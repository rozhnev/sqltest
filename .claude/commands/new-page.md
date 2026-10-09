Create a new site page (or add SEO metadata to an existing one) following the project localization and SEO rules.

## Usage

```
/new-page <page-name> [short purpose of the page]
```

## Steps to execute

**Step 1 — Route and controller.**
Add the route in `lib/Router.php` (simple static pages go into the `static-page` pattern) and the action in `lib/Controller.php`. Look at `about()` / `privacy_policy()` as examples.

**Step 2 — Templates.**
Follow the localization rules in `CLAUDE.md`: a shared shell in `templates/<name>.tpl` (layout, styles, JS, logic) includes the page text from `templates/{lang}/<name>.tpl`, resolved with `Controller::localizedTemplate('<name>.tpl')`. Never branch on the language in templates or PHP.

**Step 3 — Page title and meta description.**
Put them in `translations/{lang}.php` (they are short strings, so translation keys are right here):

- `<name>_page_title`, `<name>_page_description`
- optionally `<name>_og_title`, `<name>_og_description`

Assign them at the top of the shell template, before `site-title.tpl` is included:

```smarty
{assign var="PageTitle" value="{translate}<name>_page_title{/translate}"}
{assign var="PageDescription" value="{translate}<name>_page_description{/translate}"}
```

or pass `'PageTitle' => Localizer::translateString(...)`, `'PageDescription' => ...` from the controller.

For descriptions built from DB data in PHP (e.g. question pages), keep the template in translations with `##Name##` placeholders and fill it with `Helper::fitDescription($template, $vars, 'Title')`: it drops the template's last sentence (generic call to action) and only then shortens the most specific value, so the result stays ≤160 characters without losing the unique part. Use a separate template per page type (see `question_meta_description_query` / `_quiz` / `_free_answer`).

Dynamic values go into the translation as `##VarName##` placeholders (the `{translate}` block replaces them with the template variable of that name), e.g. `'erd_page_description' => 'Interactive ER diagram of the ##Db## database: ...'`. Never hard-code English text with variables into the template.

### Meta description rules

- **Length 25–160 characters in every language**; aim for 120–155 (Chinese is naturally shorter — 50–80 characters is fine). With placeholders, count with the longest realistic value substituted (e.g. `AdventureWorks`).
- A complete sentence or phrase that ends naturally — don't rely on truncation. `site-title.tpl` passes the text through `Helper::metaDescription()`, which cuts anything over 160 characters with "…" and replaces anything under 25 with the default description; that is only a safety net.
- SEO/GEO: the text must make sense on its own (search snippets and AI answers quote it without the page) — say what the page is (its unique name), what type of content it is, the DBMS/topic, and what the user can do there.
- Unique per page; start with what the page gives the user, with the primary keyword near the beginning ("Free online SQL Playground: …", not "On this page you can …").
- Concrete facts beat filler: DBMS names, number of exercises, what can be downloaded. Drop phrases like "We appreciate your support!", "Perfect for …", "Become an expert today!" when space is short.
- Plain text only: no HTML tags, no line breaks.
- Write it natively in each language, not as a literal word-by-word translation that overflows the limit (French, Spanish and Portuguese run 10–20% longer than English).

### Title rules

- Unique per page, primary keyword first, about 50–70 characters; the `| SQLtest.online` suffix is optional.
- Translated in every language, same as the description.

**Step 4 — Languages.**
Add title and description for all languages (en, ru, pt, fr, zh, es). If time is short, at least `en` and `ru` — English is the fallback.

**Step 5 — Verify lengths.**

```bash
php -r '
foreach (glob("translations/*.php") as $f) { include $f;
  foreach ($translations as $k => $v) if (preg_match("/page_description/", $k)) {
    $n = preg_match_all("/./us", str_replace("##Db##", "AdventureWorks", $v));
    if ($n < 25 || $n > 160) echo basename($f), " $k $n\n";
  } }
echo "done\n";'
```

Run `php -l` on every changed PHP file. Don't use `mb_*` functions (no `mbstring` on production); count UTF-8 characters with `preg_match_all('/./us', $s)`.

## Output summary

After creating the page, report:
- route, controller action and templates created
- title and description per language with character counts
