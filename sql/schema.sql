--
-- PostgreSQL database dump
--

\restrict DKcT8GITTZfgVneXPNB30Q01C3roygwrQXsgmrl0XkVIfq0qmsxnbiHSnXGOgJR

-- Dumped from database version 18.1 (Ubuntu 18.1-1.pgdg24.04+2)
-- Dumped by pg_dump version 18.1 (Ubuntu 18.1-1.pgdg24.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: questions_rate_update(); Type: FUNCTION; Schema: public; Owner: dba
--

CREATE FUNCTION public.questions_rate_update() RETURNS TABLE(question_count bigint, rated bigint, with_cost bigint)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		update questions 
		set 
			rate = rating.avg_rate
		from (
			select 
				question_id, 
				avg(rate) avg_rate
			from user_questions uq 
			group by question_id
		) rating 
		where questions.id = rating.question_id;
	

		update questions 
		set 
			best_query_cost = rating.min_cost
		from (
           	select 
				question_id, 
				min(query_cost) min_cost
			from user_solutions
			where not reported
			group by question_id
			having min(query_cost) > 0
		) rating 
		where questions.id = rating.question_id;

		delete from question_categories where category_id > 100;
		insert into question_categories
		select 
			id, 
			(case when rate = 1 then 2 else rate end) + 100, row_number() over (partition by (case when rate = 1 then 2 else rate end) order by rate,  id)
		from questions q where rate is not null and not deleted;
	
		delete from question_categories where category_id = 100;
		insert into question_categories
		select 
			id, 
			100, 
			row_number() over (order by id)
		from questions q where rate is null;
	
		return query 
			select count(*), count(rate), COUNT(best_query_cost) from questions where not deleted;
	
	END;
$$;


ALTER FUNCTION public.questions_rate_update() OWNER TO dba;

--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: dba
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_updated_at() OWNER TO dba;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.achievements (
    id integer NOT NULL,
    title text NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    sequence_position smallint
);


ALTER TABLE public.achievements OWNER TO dba;

--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.achievements_id_seq OWNER TO dba;

--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: achievements_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.achievements_localization (
    achievement_id integer NOT NULL,
    language character(2) NOT NULL,
    title text NOT NULL,
    recommended text NOT NULL
);


ALTER TABLE public.achievements_localization OWNER TO dba;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    question_id integer NOT NULL,
    sequence_position smallint NOT NULL,
    is_valid boolean NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.answers OWNER TO dba;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answers_id_seq OWNER TO dba;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: answers_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.answers_localization (
    answer_id integer NOT NULL,
    language character(2) NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.answers_localization OWNER TO dba;

--
-- Name: books; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.books (
    id integer NOT NULL,
    lang character(2) NOT NULL,
    dbms text,
    referral_link text NOT NULL,
    picture_link text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.books OWNER TO dba;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

ALTER TABLE public.books ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    sequence_position integer,
    deleted boolean DEFAULT false NOT NULL,
    questionnire_id integer,
    title_sef character varying(32) NOT NULL
);


ALTER TABLE public.categories OWNER TO dba;

--
-- Name: categories_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.categories_localization (
    category_id integer NOT NULL,
    language character(2) NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.categories_localization OWNER TO dba;

--
-- Name: donations; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.donations (
    id uuid DEFAULT uuidv7() NOT NULL,
    user_id uuid,
    donated_at date,
    amount numeric,
    currency character(3),
    amount_usd numeric,
    notes text,
    private_notes text
);


ALTER TABLE public.donations OWNER TO dba;

--
-- Name: favorites; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.favorites (
    user_id uuid NOT NULL,
    question_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.favorites OWNER TO dba;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.grades (
    id smallint NOT NULL,
    title_en text NOT NULL,
    title_ru text
);


ALTER TABLE public.grades OWNER TO dba;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

ALTER TABLE public.grades ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: grades_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.grades_localization (
    grade_id integer NOT NULL,
    language character varying NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.grades_localization OWNER TO dba;

--
-- Name: lessons; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    module_id integer NOT NULL,
    slug text NOT NULL,
    deleted boolean,
    sequence_position integer
);


ALTER TABLE public.lessons OWNER TO dba;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lessons_id_seq OWNER TO dba;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: lessons_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.lessons_localization (
    lesson_id integer NOT NULL,
    language character varying(2) NOT NULL,
    title text NOT NULL,
    content text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.lessons_localization OWNER TO dba;

--
-- Name: modules; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.modules (
    id smallint NOT NULL,
    slug character varying(255) NOT NULL,
    sequence_position integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE public.modules OWNER TO dba;

--
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

ALTER TABLE public.modules ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: modules_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.modules_localization (
    module_id integer NOT NULL,
    language character varying(2) NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.modules_localization OWNER TO dba;

--
-- Name: query_checks; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.query_checks (
    id integer NOT NULL,
    query_match boolean NOT NULL,
    regexp text NOT NULL
);


ALTER TABLE public.query_checks OWNER TO dba;

--
-- Name: query_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.query_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.query_checks_id_seq OWNER TO dba;

--
-- Name: query_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.query_checks_id_seq OWNED BY public.query_checks.id;


--
-- Name: query_checks_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.query_checks_localization (
    query_check_id integer,
    language character(2) NOT NULL,
    hint text NOT NULL
);


ALTER TABLE public.query_checks_localization OWNER TO dba;

--
-- Name: question_categories; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.question_categories (
    question_id integer NOT NULL,
    category_id integer NOT NULL,
    sequence_position integer
);


ALTER TABLE public.question_categories OWNER TO dba;

--
-- Name: question_query_checks; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.question_query_checks (
    question_id integer NOT NULL,
    query_check_id integer NOT NULL
);


ALTER TABLE public.question_query_checks OWNER TO dba;

--
-- Name: question_rates; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.question_rates (
    id integer NOT NULL,
    rate_en character varying NOT NULL,
    rate_ru character varying NOT NULL
);


ALTER TABLE public.question_rates OWNER TO dba;

--
-- Name: question_rates_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.question_rates_localization (
    id integer NOT NULL,
    language character(2) NOT NULL,
    rate text NOT NULL
);


ALTER TABLE public.question_rates_localization OWNER TO dba;

--
-- Name: questionnires; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.questionnires (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.questionnires OWNER TO dba;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    title_sef character varying(64) NOT NULL,
    query_valid_result text NOT NULL,
    db_template text NOT NULL,
    db text,
    solution_query text,
    dbms text,
    rate smallint,
    deleted boolean DEFAULT false NOT NULL,
    best_query_cost numeric(12,3),
    query_check text,
    query_pre_check text,
    pre_check_sort boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    question_type character varying(32) DEFAULT 'query'::character varying NOT NULL,
    CONSTRAINT questions_question_type_check CHECK (((question_type)::text = ANY ((ARRAY['query'::character varying, 'answer'::character varying, 'free_answer'::character varying])::text[])))
);


ALTER TABLE public.questions OWNER TO dba;

--
-- Name: COLUMN questions.pre_check_sort; Type: COMMENT; Schema: public; Owner: dba
--

COMMENT ON COLUMN public.questions.pre_check_sort IS 'sort query result before sort';


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

ALTER TABLE public.questions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: questions_localization; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.questions_localization (
    question_id integer NOT NULL,
    language character(2) NOT NULL,
    title text NOT NULL,
    task text NOT NULL,
    hint text,
    tutorial_link text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.questions_localization OWNER TO dba;

--
-- Name: referral_links; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.referral_links (
    id integer NOT NULL,
    lang character(2) NOT NULL,
    referral_link text NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    active_till date,
    desktop boolean DEFAULT true NOT NULL,
    mobile boolean DEFAULT true NOT NULL,
    link text,
    content text
);


ALTER TABLE public.referral_links OWNER TO dba;

--
-- Name: referral_links_daily_stats; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.referral_links_daily_stats (
    date date NOT NULL,
    link_id integer NOT NULL,
    shows integer DEFAULT 0 NOT NULL,
    clicks integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.referral_links_daily_stats OWNER TO dba;

--
-- Name: referral_links_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

ALTER TABLE public.referral_links ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.referral_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: solution_likes; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.solution_likes (
    solution_id integer NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.solution_likes OWNER TO dba;

--
-- Name: test_questions; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.test_questions (
    test_id uuid NOT NULL,
    question_id integer NOT NULL,
    solved_at timestamp without time zone,
    attempts smallint DEFAULT 0 NOT NULL,
    solution text,
    last_attempt_at timestamp without time zone,
    last_answer text,
    query_cost numeric(12,3),
    max_attempts smallint DEFAULT 3 NOT NULL
);


ALTER TABLE public.test_questions OWNER TO dba;

--
-- Name: tests; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.tests (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    closed_at timestamp without time zone,
    grade integer,
    questionnire_id integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.tests OWNER TO dba;

--
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.user_achievements (
    user_id uuid NOT NULL,
    achievement_id integer NOT NULL,
    earned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    viewed_at timestamp without time zone,
    user_achievement_id uuid
);


ALTER TABLE public.user_achievements OWNER TO dba;

--
-- Name: user_email_verification_codes; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.user_email_verification_codes (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    email character varying(255) NOT NULL,
    code_hash character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone
);


ALTER TABLE public.user_email_verification_codes OWNER TO dba;

--
-- Name: user_email_verification_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.user_email_verification_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_email_verification_codes_id_seq OWNER TO dba;

--
-- Name: user_email_verification_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.user_email_verification_codes_id_seq OWNED BY public.user_email_verification_codes.id;


--
-- Name: user_questions; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.user_questions (
    user_id uuid NOT NULL,
    question_id integer NOT NULL,
    last_attempt_at timestamp without time zone NOT NULL,
    solved_at timestamp without time zone,
    last_query text,
    rate smallint,
    query_cost numeric(12,3)
);


ALTER TABLE public.user_questions OWNER TO dba;

--
-- Name: user_solutions; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.user_solutions (
    id integer NOT NULL,
    question_id integer NOT NULL,
    user_id uuid NOT NULL,
    query text NOT NULL,
    query_cost numeric(12,3),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    likes integer DEFAULT 0 NOT NULL,
    dislikes integer DEFAULT 0 NOT NULL,
    reported boolean DEFAULT false NOT NULL
);


ALTER TABLE public.user_solutions OWNER TO dba;

--
-- Name: user_solutions_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.user_solutions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_solutions_id_seq OWNER TO dba;

--
-- Name: user_solutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.user_solutions_id_seq OWNED BY public.user_solutions.id;


--
-- Name: user_task_submissions; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.user_task_submissions (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    title character varying(160) NOT NULL,
    task text NOT NULL,
    hint text NOT NULL,
    solution_query text NOT NULL,
    db_template character varying(50) NOT NULL,
    db character varying(50) NOT NULL,
    moderation_note text DEFAULT ''::text NOT NULL,
    approved_question_id integer,
    approved_by_user_id uuid,
    approved_at timestamp without time zone,
    rejected_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_task_submissions_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.user_task_submissions OWNER TO dba;

--
-- Name: user_task_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dba
--

CREATE SEQUENCE public.user_task_submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_task_submissions_id_seq OWNER TO dba;

--
-- Name: user_task_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dba
--

ALTER SEQUENCE public.user_task_submissions_id_seq OWNED BY public.user_task_submissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dba
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    login text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_login_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_path text,
    admin boolean DEFAULT false NOT NULL,
    grade smallint,
    graded_at timestamp without time zone,
    hide_ad_till date,
    nickname character varying(50),
    email text,
    password_hash text,
    full_name text,
    email_verified_at timestamp without time zone,
    user_agreement_accepted_at timestamp without time zone
);

CREATE TABLE public.mailinglists (
    user_id uuid NOT NULL,
    list_name text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    PRIMARY KEY (user_id, list_name),
    CONSTRAINT mailinglists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

ALTER TABLE public.users OWNER TO dba;
ALTER TABLE public.mailinglists OWNER TO dba;

--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: query_checks id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.query_checks ALTER COLUMN id SET DEFAULT nextval('public.query_checks_id_seq'::regclass);


--
-- Name: user_email_verification_codes id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_email_verification_codes ALTER COLUMN id SET DEFAULT nextval('public.user_email_verification_codes_id_seq'::regclass);


--
-- Name: user_solutions id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_solutions ALTER COLUMN id SET DEFAULT nextval('public.user_solutions_id_seq'::regclass);


--
-- Name: user_task_submissions id; Type: DEFAULT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_task_submissions ALTER COLUMN id SET DEFAULT nextval('public.user_task_submissions_id_seq'::regclass);


--
-- Name: achievements_localization achievements_localization_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.achievements_localization
    ADD CONSTRAINT achievements_localization_pk PRIMARY KEY (achievement_id, language);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: answers_localization answers_localization_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.answers_localization
    ADD CONSTRAINT answers_localization_pk PRIMARY KEY (answer_id, language);


--
-- Name: answers answers_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pk PRIMARY KEY (id);


--
-- Name: books books_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pk PRIMARY KEY (id);


--
-- Name: categories_localization categories_data_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.categories_localization
    ADD CONSTRAINT categories_data_pk PRIMARY KEY (category_id, language);


--
-- Name: categories categories_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (id);


--
-- Name: donations donations_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT donations_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pk PRIMARY KEY (user_id, question_id);


--
-- Name: grades_localization grades_localization_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.grades_localization
    ADD CONSTRAINT grades_localization_pkey PRIMARY KEY (grade_id, language);


--
-- Name: grades grades_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pk PRIMARY KEY (id);


--
-- Name: questionnires group_categories_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.questionnires
    ADD CONSTRAINT group_categories_pk PRIMARY KEY (id);


--
-- Name: lessons_localization lessons_localization_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons_localization
    ADD CONSTRAINT lessons_localization_pkey PRIMARY KEY (lesson_id, language);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_slug_key; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_key UNIQUE (slug);


--
-- Name: users login_un; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT login_un UNIQUE (login);


--
-- Name: modules_localization modules_localization_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.modules_localization
    ADD CONSTRAINT modules_localization_pkey PRIMARY KEY (module_id, language);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- Name: modules modules_slug_key; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_slug_key UNIQUE (slug);


--
-- Name: query_checks_localization query_checks_localization_unique; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.query_checks_localization
    ADD CONSTRAINT query_checks_localization_unique UNIQUE (language, query_check_id);


--
-- Name: query_checks query_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.query_checks
    ADD CONSTRAINT query_checks_pkey PRIMARY KEY (id);


--
-- Name: query_checks query_checks_query_match_regexp_key; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.query_checks
    ADD CONSTRAINT query_checks_query_match_regexp_key UNIQUE (query_match, regexp);


--
-- Name: question_categories question_categories_category_id_sequence_position_key; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_categories
    ADD CONSTRAINT question_categories_category_id_sequence_position_key UNIQUE (category_id, sequence_position) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: question_categories question_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_categories
    ADD CONSTRAINT question_categories_pkey PRIMARY KEY (question_id, category_id);


--
-- Name: question_query_checks question_query_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_query_checks
    ADD CONSTRAINT question_query_checks_pkey PRIMARY KEY (question_id, query_check_id);


--
-- Name: question_rates_localization question_rates_localization_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_rates_localization
    ADD CONSTRAINT question_rates_localization_pk PRIMARY KEY (id, language);


--
-- Name: question_rates question_rates_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_rates
    ADD CONSTRAINT question_rates_pk PRIMARY KEY (id);


--
-- Name: questions_localization questions_data_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.questions_localization
    ADD CONSTRAINT questions_data_pk PRIMARY KEY (question_id, language);


--
-- Name: questions questions_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pk PRIMARY KEY (id);


--
-- Name: referral_links_daily_stats referral_links_daily_stats_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.referral_links_daily_stats
    ADD CONSTRAINT referral_links_daily_stats_pk PRIMARY KEY (date, link_id);


--
-- Name: referral_links referral_links_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.referral_links
    ADD CONSTRAINT referral_links_pk PRIMARY KEY (id);


--
-- Name: solution_likes solution_likes_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.solution_likes
    ADD CONSTRAINT solution_likes_pk PRIMARY KEY (solution_id, user_id);


--
-- Name: tests test_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT test_pk PRIMARY KEY (id);


--
-- Name: test_questions test_questions_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_pk PRIMARY KEY (test_id, question_id);


--
-- Name: user_achievements user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (user_id, achievement_id);


--
-- Name: user_achievements user_achievements_unique; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_unique UNIQUE (user_achievement_id);


--
-- Name: users user_email_unique; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- Name: user_email_verification_codes user_email_verification_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_email_verification_codes
    ADD CONSTRAINT user_email_verification_codes_pkey PRIMARY KEY (id);


--
-- Name: user_questions user_questions_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT user_questions_pk PRIMARY KEY (user_id, question_id);


--
-- Name: user_solutions user_solutions_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_solutions
    ADD CONSTRAINT user_solutions_pk PRIMARY KEY (id);


--
-- Name: user_solutions user_solutions_unique; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_solutions
    ADD CONSTRAINT user_solutions_unique UNIQUE (question_id, user_id, query);


--
-- Name: user_task_submissions user_task_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_task_submissions
    ADD CONSTRAINT user_task_submissions_pkey PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: answers_question_id_idx; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX answers_question_id_idx ON public.answers USING btree (question_id);


--
-- Name: categories_title_sef_idx; Type: INDEX; Schema: public; Owner: dba
--

CREATE UNIQUE INDEX categories_title_sef_idx ON public.categories USING btree (title_sef);


--
-- Name: idx_essons_module_id; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_essons_module_id ON public.lessons USING btree (module_id);


--
-- Name: idx_user_email_verification_codes_expires_at; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_user_email_verification_codes_expires_at ON public.user_email_verification_codes USING btree (expires_at);


--
-- Name: idx_user_email_verification_codes_user_id; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_user_email_verification_codes_user_id ON public.user_email_verification_codes USING btree (user_id);


--
-- Name: idx_user_task_submissions_created_at; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_user_task_submissions_created_at ON public.user_task_submissions USING btree (created_at DESC);


--
-- Name: idx_user_task_submissions_status; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_user_task_submissions_status ON public.user_task_submissions USING btree (status);


--
-- Name: idx_user_task_submissions_user_id; Type: INDEX; Schema: public; Owner: dba
--

CREATE INDEX idx_user_task_submissions_user_id ON public.user_task_submissions USING btree (user_id);


--
-- Name: questions_title_sef_idx; Type: INDEX; Schema: public; Owner: dba
--

CREATE UNIQUE INDEX questions_title_sef_idx ON public.questions USING btree (title_sef);


--
-- Name: lessons_localization trg_lessons_localization_updated_at; Type: TRIGGER; Schema: public; Owner: dba
--

CREATE TRIGGER trg_lessons_localization_updated_at BEFORE INSERT OR UPDATE ON public.lessons_localization FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: questions_localization trg_questions_localization_updated_at; Type: TRIGGER; Schema: public; Owner: dba
--

CREATE TRIGGER trg_questions_localization_updated_at BEFORE INSERT OR UPDATE ON public.questions_localization FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: questions trg_questions_updated_at; Type: TRIGGER; Schema: public; Owner: dba
--

CREATE TRIGGER trg_questions_updated_at BEFORE INSERT OR UPDATE ON public.questions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: achievements_localization achievements_localization_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.achievements_localization
    ADD CONSTRAINT achievements_localization_answer_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE;


--
-- Name: answers_localization answers_localization_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.answers_localization
    ADD CONSTRAINT answers_localization_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.answers(id) ON DELETE CASCADE;


--
-- Name: answers answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: categories_localization categories_data_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.categories_localization
    ADD CONSTRAINT categories_data_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: categories categories_group_categories_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_group_categories_fk FOREIGN KEY (questionnire_id) REFERENCES public.questionnires(id);


--
-- Name: donations donations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT donations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorites favorites_questions_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: grades_localization grades_localization_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.grades_localization
    ADD CONSTRAINT grades_localization_grade_id_fkey FOREIGN KEY (grade_id) REFERENCES public.grades(id) ON DELETE CASCADE;


--
-- Name: lessons_localization lessons_localization_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons_localization
    ADD CONSTRAINT lessons_localization_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: lessons lessons_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- Name: modules_localization modules_localization_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.modules_localization
    ADD CONSTRAINT modules_localization_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.modules(id);


--
-- Name: query_checks_localization query_checks_localization_query_check_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.query_checks_localization
    ADD CONSTRAINT query_checks_localization_query_check_id_fkey FOREIGN KEY (query_check_id) REFERENCES public.query_checks(id) ON DELETE CASCADE;


--
-- Name: question_categories question_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_categories
    ADD CONSTRAINT question_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: question_categories question_categories_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_categories
    ADD CONSTRAINT question_categories_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: question_query_checks question_query_checks_query_check_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_query_checks
    ADD CONSTRAINT question_query_checks_query_check_id_fkey FOREIGN KEY (query_check_id) REFERENCES public.query_checks(id) ON DELETE CASCADE;


--
-- Name: question_query_checks question_query_checks_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.question_query_checks
    ADD CONSTRAINT question_query_checks_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions_localization questions_data_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.questions_localization
    ADD CONSTRAINT questions_data_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: referral_links_daily_stats referral_links_daily_stats_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.referral_links_daily_stats
    ADD CONSTRAINT referral_links_daily_stats_link_id_fkey FOREIGN KEY (link_id) REFERENCES public.referral_links(id) ON DELETE CASCADE;


--
-- Name: solution_likes solution_likes_solutions_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.solution_likes
    ADD CONSTRAINT solution_likes_solutions_fk FOREIGN KEY (solution_id) REFERENCES public.user_solutions(id) ON DELETE CASCADE;


--
-- Name: solution_likes solution_likes_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.solution_likes
    ADD CONSTRAINT solution_likes_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: test_questions test_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: test_questions test_questions_tests_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_tests_fk FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- Name: tests tests_questionnires_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_questionnires_fk FOREIGN KEY (questionnire_id) REFERENCES public.questionnires(id) ON DELETE CASCADE;


--
-- Name: tests tests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_achievements user_achievements_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id);


--
-- Name: user_achievements user_achievements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_email_verification_codes user_email_verification_codes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_email_verification_codes
    ADD CONSTRAINT user_email_verification_codes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_questions user_questions_questions_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT user_questions_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: user_questions user_questions_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT user_questions_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_solutions user_solutions_questions_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_solutions
    ADD CONSTRAINT user_solutions_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: user_solutions user_solutions_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_solutions
    ADD CONSTRAINT user_solutions_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_task_submissions user_task_submissions_approved_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_task_submissions
    ADD CONSTRAINT user_task_submissions_approved_by_user_id_fkey FOREIGN KEY (approved_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_task_submissions user_task_submissions_approved_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_task_submissions
    ADD CONSTRAINT user_task_submissions_approved_question_id_fkey FOREIGN KEY (approved_question_id) REFERENCES public.questions(id) ON DELETE SET NULL;


--
-- Name: user_task_submissions user_task_submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.user_task_submissions
    ADD CONSTRAINT user_task_submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE answers; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.answers TO sqltester;


--
-- Name: TABLE answers_localization; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.answers_localization TO sqltester;


--
-- Name: TABLE books; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.books TO sqltester;


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.categories TO sqltester;


--
-- Name: TABLE categories_localization; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.categories_localization TO sqltester;


--
-- Name: TABLE question_categories; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.question_categories TO sqltester;


--
-- Name: TABLE question_rates; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.question_rates TO sqltester;


--
-- Name: TABLE question_rates_localization; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.question_rates_localization TO sqltester;


--
-- Name: TABLE questionnires; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.questionnires TO sqltester;


--
-- Name: TABLE questions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.questions TO sqltester;


--
-- Name: TABLE questions_localization; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.questions_localization TO sqltester;


--
-- Name: TABLE referral_links; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.referral_links TO sqltester;


--
-- Name: TABLE test_questions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.test_questions TO sqltester;


--
-- Name: TABLE tests; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.tests TO sqltester;


--
-- Name: TABLE user_questions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.user_questions TO sqltester;


--
-- Name: TABLE user_solutions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.user_solutions TO sqltester;


--
-- Name: SEQUENCE user_solutions_id_seq; Type: ACL; Schema: public; Owner: dba
--

GRANT ALL ON SEQUENCE public.user_solutions_id_seq TO sqltester;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.users TO sqltester;

GRANT SELECT,INSERT,UPDATE ON TABLE public.mailinglists TO sqltester;

--
-- PostgreSQL database dump complete
--

\unrestrict DKcT8GITTZfgVneXPNB30Q01C3roygwrQXsgmrl0XkVIfq0qmsxnbiHSnXGOgJR

