#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
One-off bootstrap tool for the "job interview simulation" feature
(see INTERVIEW_SIMULATION_PLAN.md, п. 3.1.2).

Reads an export of `questions`/`questions_localization` (questions.json,
produced by the query in its own top-level key) and heuristically classifies
each question by:
  - position: sql_developer / data_analyst / both / excluded
  - grade window: derived from questions.rate, matching the overlap rule in
    the plan (junior -> rate 1-2, middle -> rate 2-4, senior -> rate 3-5)

This is a first-pass heuristic (keyword rules + a handful of manually
reviewed id-level overrides), not an LLM classification — review the SD-only
and excluded lists before trusting it for production interview content.
The plan's п. 3.7 (optional interview_skill_tags via LLM) is the intended
long-term replacement for this script once more positions are added.

Usage:
    python3 scripts/classify_interview_questions.py \
        --input questions.json \
        --sql-out sql/interview_questions_fill.sql \
        --report-out /tmp/interview_questions_report.tsv
"""
import argparse
import json
import re
from collections import Counter

# Questions that are pure MariaDB Foundation / community / brand trivia, or
# Data Engineering pipeline-design scenarios — out of scope for the two
# positions covered so far (sql_developer, data_analyst).
EXCLUDE_BRAND_TRIVIA = {461, 462, 389, 388, 467}
EXCLUDE_DATA_ENGINEERING = {429, 430, 431, 432, 433, 434, 435, 436, 437, 438}

# Technical (not brand-trivia) MariaDB-internals questions: DB-engine
# knowledge, closer to a developer/DBA skill than a data analyst's.
SD_ONLY_MARIADB_TECH = {463, 464, 465, 466, 387, 390}

# Index/performance-tuning theory: developer/DBA territory, not core to a
# data-analyst interview.
SD_ONLY_INDEX_PERF_THEORY = {257, 218, 313, 314, 405, 406, 397, 337, 334, 335, 396}

# Keyword false positives found while reviewing the first classification pass:
# these say "создайте таблицу/столбец с полями X" to describe the *shape of
# a SELECT result*, not an actual CREATE TABLE/ALTER TABLE statement.
FORCE_BOTH = {192, 344, 411, 48}

DDL_KEYWORDS = [
    'создайте таблицу', 'создайте новую таблицу', 'создать таблицу',
    'измените таблицу', 'добавьте новый столбец', 'добавьте столбец',
    'создайте индекс', 'создайте уникальный индекс', 'создайте функциональный индекс',
    'триггер', 'переименуйте таблицу', 'удалите таблицу', 'удалить представление',
    'создание таблицы', 'напишите оператор ddl', 'справочную таблицу',
    'ссылающ', 'создайте новый столбец',
]
DML_KEYWORDS = [
    'обновите', 'обновить', 'удалите записи', 'удалите из таблицы', 'удалите все записи',
    'вставьте', 'добавьте запись', 'добавьте новую запись', 'напишите запрос на добавление',
    'выполните обновление', 'выполните коррекцию', 'корректировка стоимости',
    'переместить фильм', 'установите значение', 'исправьте её указав',
    'измените вилку', 'измените штатное расписание', 'обновите таблицу',
]

# rate is NULL for a handful of questions (mostly the DuckDB yellow_tripdata
# set, which has no crowdsourced rating yet); these are manually estimated
# from task complexity. Anything else with NULL rate falls back to
# DEFAULT_NULL_RATE.
NULL_RATE_OVERRIDES = {
    441: 2, 443: 2, 452: 3, 455: 4, 456: 4, 442: 2, 444: 3, 445: 3, 447: 4,
    446: 3, 448: 3, 449: 3, 450: 4, 451: 4, 454: 4, 457: 3, 458: 2, 459: 4, 460: 3,
    140: 4, 425: 3, 414: 2, 420: 2,
}
DEFAULT_NULL_RATE = 3

# grades.id: 1=Intern, 2=Junior, 3=Middle, 4=Senior
GRADE_JUNIOR, GRADE_MIDDLE, GRADE_SENIOR = 2, 3, 4


def strip_html(s):
    if not s:
        return ''
    s = re.sub('<[^>]+>', ' ', s)
    return re.sub(r'\s+', ' ', s).strip().lower()


def grade_windows(rate):
    grades = []
    if rate in (1, 2):
        grades.append(GRADE_JUNIOR)
    if rate in (2, 3, 4):
        grades.append(GRADE_MIDDLE)
    if rate in (3, 4, 5):
        grades.append(GRADE_SENIOR)
    return grades


def classify(rows):
    result_rows = []  # (position, grade, question_id)
    report = []        # (question_id, title, dbms, rate, positions)
    excluded = []       # (question_id, title, reason)

    for r in rows:
        qid = r['id']
        title = r.get('title') or ''
        task = strip_html(r.get('task'))
        text = (title + ' ' + task).lower()
        dbms = r.get('dbms') or ''
        rate = r['rate']
        if rate is None:
            rate = NULL_RATE_OVERRIDES.get(qid, DEFAULT_NULL_RATE)

        if qid in EXCLUDE_BRAND_TRIVIA:
            excluded.append((qid, title, 'brand trivia'))
            continue
        if qid in EXCLUDE_DATA_ENGINEERING:
            excluded.append((qid, title, 'data engineering (out of scope)'))
            continue

        positions = {'data_analyst', 'sql_developer'}

        if qid in SD_ONLY_MARIADB_TECH or qid in SD_ONLY_INDEX_PERF_THEORY:
            positions = {'sql_developer'}
        elif 'postgis' in dbms.lower():
            positions = {'sql_developer'}
        else:
            is_ddl = any(k in text for k in DDL_KEYWORDS)
            is_dml = any(k in text for k in DML_KEYWORDS)
            if (is_ddl or is_dml) and qid not in FORCE_BOTH:
                positions = {'sql_developer'}

        grades = grade_windows(rate)
        for pos in sorted(positions):
            for g in grades:
                result_rows.append((pos, g, qid))
        report.append((qid, title, dbms, rate, sorted(positions)))

    return result_rows, report, excluded


def write_sql(result_rows, out_path):
    result_rows = sorted(result_rows)
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write("-- Auto-generated by scripts/classify_interview_questions.py\n")
        f.write("-- Heuristic first pass -- review before relying on it for production\n")
        f.write("-- interview content. Grade ids reuse public.grades: 2=Junior, 3=Middle, 4=Senior.\n\n")
        f.write("INSERT INTO public.interview_questions (position, grade, question_id) VALUES\n")
        lines = [f"    ('{pos}', {g}, {qid})" for pos, g, qid in result_rows]
        f.write(",\n".join(lines))
        f.write("\nON CONFLICT (position, grade, question_id) DO NOTHING;\n")


def write_report(report, excluded, out_path):
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write("question_id\ttitle\tdbms\trate\tpositions\n")
        for qid, title, dbms, rate, positions in report:
            f.write(f"{qid}\t{title}\t{dbms}\t{rate}\t{','.join(positions)}\n")
        for qid, title, reason in excluded:
            f.write(f"{qid}\t{title}\t\t\texcluded:{reason}\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, help='questions.json export path')
    parser.add_argument('--sql-out', required=True, help='where to write the INSERT statements')
    parser.add_argument('--report-out', required=True, help='where to write the classification report (TSV)')
    args = parser.parse_args()

    with open(args.input, encoding='utf-8') as f:
        data = json.load(f)
    key = list(data.keys())[0]
    rows = data[key]

    result_rows, report, excluded = classify(rows)

    write_sql(result_rows, args.sql_out)
    write_report(report, excluded, args.report_out)

    pos_counter = Counter(p for _, _, _, _, positions in report for p in positions)
    print(f"input rows: {len(rows)}")
    print(f"excluded: {len(excluded)}")
    print(f"classified questions: {len(report)}")
    print(f"(position, grade, question_id) rows written: {len(result_rows)}")
    print(f"question count per position: {dict(pos_counter)}")


if __name__ == '__main__':
    main()
