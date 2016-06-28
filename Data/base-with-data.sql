--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: artists; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE artists (
    id integer NOT NULL,
    upstream_identifier text NOT NULL,
    data_source text NOT NULL,
    musicbrainz_id text,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name text NOT NULL,
    featured integer DEFAULT 0 NOT NULL,
    slug text NOT NULL
);


ALTER TABLE artists OWNER TO alecgorge;

--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artists_id_seq OWNER TO alecgorge;

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE artists_id_seq OWNED BY artists.id;


--
-- Name: eras; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE eras (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    "order" smallint DEFAULT '0'::smallint,
    name text,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE eras OWNER TO alecgorge;

--
-- Name: eras_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE eras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eras_id_seq OWNER TO alecgorge;

--
-- Name: eras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE eras_id_seq OWNED BY eras.id;


--
-- Name: features; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE features (
    id integer NOT NULL,
    descriptions boolean DEFAULT false NOT NULL,
    eras boolean DEFAULT false NOT NULL,
    multiple_sources boolean DEFAULT false NOT NULL,
    reviews boolean DEFAULT false NOT NULL,
    ratings boolean DEFAULT false NOT NULL,
    tours boolean DEFAULT false NOT NULL,
    taper_notes boolean DEFAULT false NOT NULL,
    source_information boolean DEFAULT false NOT NULL,
    sets boolean DEFAULT false NOT NULL,
    per_show_venues boolean DEFAULT false NOT NULL,
    per_source_venues boolean DEFAULT false NOT NULL,
    venue_coords boolean DEFAULT false NOT NULL,
    songs boolean DEFAULT false NOT NULL,
    years boolean DEFAULT true NOT NULL,
    track_md5s boolean DEFAULT false NOT NULL,
    review_titles boolean DEFAULT false NOT NULL,
    jam_charts boolean DEFAULT false NOT NULL,
    setlist_data_incomplete boolean DEFAULT false NOT NULL,
    artist_id integer NOT NULL,
    track_names boolean DEFAULT false NOT NULL
);


ALTER TABLE features OWNER TO alecgorge;

--
-- Name: featuresets_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE featuresets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE featuresets_id_seq OWNER TO alecgorge;

--
-- Name: featuresets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE featuresets_id_seq OWNED BY features.id;


--
-- Name: setlist_shows; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE setlist_shows (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    venue_id integer NOT NULL,
    upstream_identifier text NOT NULL,
    date date NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    tour_id integer,
    era_id integer
);


ALTER TABLE setlist_shows OWNER TO alecgorge;

--
-- Name: setlist_show_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE setlist_show_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE setlist_show_id_seq OWNER TO alecgorge;

--
-- Name: setlist_show_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE setlist_show_id_seq OWNED BY setlist_shows.id;


--
-- Name: setlist_songs; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE setlist_songs (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    upstream_identifier text NOT NULL
);


ALTER TABLE setlist_songs OWNER TO alecgorge;

--
-- Name: setlist_song_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE setlist_song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE setlist_song_id_seq OWNER TO alecgorge;

--
-- Name: setlist_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE setlist_song_id_seq OWNED BY setlist_songs.id;


--
-- Name: setlist_songs_plays; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE setlist_songs_plays (
    played_setlist_song_id integer NOT NULL,
    played_setlist_show_id integer NOT NULL
);


ALTER TABLE setlist_songs_plays OWNER TO alecgorge;

--
-- Name: shows; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE shows (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    tour_id integer,
    year_id integer,
    era_id integer,
    date date NOT NULL,
    avg_rating_weighted real DEFAULT '0'::real NOT NULL,
    avg_duration real DEFAULT '0'::real NOT NULL,
    display_date text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE shows OWNER TO alecgorge;

--
-- Name: shows_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE shows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shows_id_seq OWNER TO alecgorge;

--
-- Name: shows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE shows_id_seq OWNED BY shows.id;


--
-- Name: source_reviews; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE source_reviews (
    id integer NOT NULL,
    source_id integer NOT NULL,
    rating smallint,
    title text,
    review text NOT NULL,
    author text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE source_reviews OWNER TO alecgorge;

--
-- Name: COLUMN source_reviews.rating; Type: COMMENT; Schema: public; Owner: alecgorge
--

COMMENT ON COLUMN source_reviews.rating IS 'Scale of 1 to 10';


--
-- Name: source_review_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE source_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE source_review_id_seq OWNER TO alecgorge;

--
-- Name: source_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE source_review_id_seq OWNED BY source_reviews.id;


--
-- Name: source_sets; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE source_sets (
    id integer NOT NULL,
    source_id integer NOT NULL,
    index integer DEFAULT 0 NOT NULL,
    is_encore boolean DEFAULT false NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE source_sets OWNER TO alecgorge;

--
-- Name: source_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE source_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE source_sets_id_seq OWNER TO alecgorge;

--
-- Name: source_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE source_sets_id_seq OWNED BY source_sets.id;


--
-- Name: source_tracks; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE source_tracks (
    id integer NOT NULL,
    source_id integer NOT NULL,
    source_set_id integer NOT NULL,
    track_position integer NOT NULL,
    duration integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    mp3_url text NOT NULL,
    md5 text,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE source_tracks OWNER TO alecgorge;

--
-- Name: COLUMN source_tracks.duration; Type: COMMENT; Schema: public; Owner: alecgorge
--

COMMENT ON COLUMN source_tracks.duration IS 'Duration in seconds';


--
-- Name: source_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE source_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE source_tracks_id_seq OWNER TO alecgorge;

--
-- Name: source_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE source_tracks_id_seq OWNED BY source_tracks.id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE sources (
    id integer NOT NULL,
    show_id integer,
    is_soundboard boolean NOT NULL,
    is_remaster boolean NOT NULL,
    avg_rating real NOT NULL,
    num_reviews integer NOT NULL,
    upstream_identifier text NOT NULL,
    has_jamcharts boolean NOT NULL,
    description text NOT NULL,
    taper_notes text NOT NULL,
    source text NOT NULL,
    taper text NOT NULL,
    transferrer text NOT NULL,
    lineage text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    artist_id integer NOT NULL,
    avg_rating_weighted real DEFAULT '0'::real NOT NULL,
    duration real NOT NULL
);


ALTER TABLE sources OWNER TO alecgorge;

--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sources_id_seq OWNER TO alecgorge;

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- Name: tours; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE tours (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    start_date date,
    end_date date,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    slug text NOT NULL,
    upstream_identifier text NOT NULL
);


ALTER TABLE tours OWNER TO alecgorge;

--
-- Name: tours_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE tours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tours_id_seq OWNER TO alecgorge;

--
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE tours_id_seq OWNED BY tours.id;


--
-- Name: venues; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE venues (
    id integer NOT NULL,
    artist_id integer,
    latitude double precision,
    longitude double precision,
    name text,
    location text,
    upstream_identifier text,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE venues OWNER TO alecgorge;

--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE venues_id_seq OWNER TO alecgorge;

--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: years; Type: TABLE; Schema: public; Owner: alecgorge
--

CREATE TABLE years (
    id integer NOT NULL,
    show_count integer DEFAULT 0,
    recording_count integer DEFAULT 0,
    duration integer DEFAULT 0,
    avg_duration real DEFAULT '0'::real,
    avg_rating real DEFAULT '0'::real,
    artist_id integer NOT NULL,
    year text,
    created_at timestamp with time zone DEFAULT (now())::timestamp(0) without time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE years OWNER TO alecgorge;

--
-- Name: years_id_seq; Type: SEQUENCE; Schema: public; Owner: alecgorge
--

CREATE SEQUENCE years_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE years_id_seq OWNER TO alecgorge;

--
-- Name: years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alecgorge
--

ALTER SEQUENCE years_id_seq OWNED BY years.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY artists ALTER COLUMN id SET DEFAULT nextval('artists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY eras ALTER COLUMN id SET DEFAULT nextval('eras_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY features ALTER COLUMN id SET DEFAULT nextval('featuresets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows ALTER COLUMN id SET DEFAULT nextval('setlist_show_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_songs ALTER COLUMN id SET DEFAULT nextval('setlist_song_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows ALTER COLUMN id SET DEFAULT nextval('shows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_reviews ALTER COLUMN id SET DEFAULT nextval('source_review_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_sets ALTER COLUMN id SET DEFAULT nextval('source_sets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_tracks ALTER COLUMN id SET DEFAULT nextval('source_tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY tours ALTER COLUMN id SET DEFAULT nextval('tours_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY years ALTER COLUMN id SET DEFAULT nextval('years_id_seq'::regclass);


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY artists (id, upstream_identifier, data_source, musicbrainz_id, created_at, updated_at, name, featured, slug) FROM stdin;
1	GratefulDead	archive.org + setlist.fm	6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6	2016-06-23 16:58:18-04	2016-06-23 16:59:44-04	Grateful Dead	0	grateful-dead
2	DeadAndCompany	archive.org + setlist.fm	94f8947c-2d9c-4519-bcf9-6d11a24ad006	2016-06-27 15:15:33-04	2016-06-27 15:15:33-04	Dead & Company	0	dead-and-company
\.


--
-- Name: artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('artists_id_seq', 2, true);


--
-- Data for Name: eras; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY eras (id, artist_id, "order", name, created_at, updated_at) FROM stdin;
\.


--
-- Name: eras_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('eras_id_seq', 1, false);


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY features (id, descriptions, eras, multiple_sources, reviews, ratings, tours, taper_notes, source_information, sets, per_show_venues, per_source_venues, venue_coords, songs, years, track_md5s, review_titles, jam_charts, setlist_data_incomplete, artist_id, track_names) FROM stdin;
1	t	f	t	t	t	t	t	t	f	t	f	t	t	t	t	t	f	f	1	t
2	t	f	t	t	t	t	t	t	f	t	f	t	t	t	t	t	f	f	2	t
\.


--
-- Name: featuresets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('featuresets_id_seq', 1, false);


--
-- Name: setlist_show_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('setlist_show_id_seq', 2137, true);


--
-- Data for Name: setlist_shows; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY setlist_shows (id, artist_id, venue_id, upstream_identifier, date, created_at, updated_at, tour_id, era_id) FROM stdin;
75	2	59	43ffbbb7	2016-06-26	2016-06-28 10:28:06-04	2016-06-27 09:30:40-04	11	\N
76	2	59	6bfe423a	2016-06-25	2016-06-28 10:28:06-04	2016-06-27 10:01:55-04	11	\N
77	2	60	1bfe4dcc	2016-06-23	2016-06-28 10:28:06-04	2016-06-24 01:07:29-04	11	\N
78	2	60	13ffad5d	2016-06-22	2016-06-28 10:28:06-04	2016-06-26 20:38:11-04	11	\N
79	2	61	5bfe5fac	2016-06-21	2016-06-28 10:28:06-04	2016-06-22 13:34:39-04	11	\N
80	2	62	4bfe636e	2016-06-20	2016-06-28 10:28:06-04	2016-06-25 23:54:56-04	11	\N
81	2	63	3bfe74cc	2016-06-17	2016-06-28 10:28:06-04	2016-06-21 12:34:53-04	11	\N
82	2	64	bfe7966	2016-06-16	2016-06-28 10:28:06-04	2016-06-18 09:36:58-04	11	\N
83	2	65	2bfe10ba	2016-06-12	2016-06-28 10:28:06-04	2016-06-13 22:33:50-04	11	\N
84	2	66	1bfe1d48	2016-06-10	2016-06-28 10:28:06-04	2016-06-12 17:30:52-04	11	\N
85	2	67	33fe88fd	2016-05-23	2016-06-28 10:28:06-04	2016-06-20 20:24:36-04	11	\N
86	2	68	63f16207	2016-05-10	2016-06-28 10:28:06-04	2016-05-12 16:52:52-04	12	\N
87	2	69	1bf36d4c	2016-02-18	2016-06-28 10:28:06-04	2016-02-24 12:38:42-05	12	\N
88	2	70	7bf27e94	2015-12-31	2016-06-28 10:28:06-04	2016-03-19 04:44:50-04	13	\N
89	2	70	63f2028f	2015-12-30	2016-06-28 10:28:06-04	2016-02-26 12:56:18-05	13	\N
90	2	71	23f20457	2015-12-28	2016-06-28 10:28:06-04	2016-06-12 10:59:19-04	13	\N
91	2	71	43f20b8f	2015-12-27	2016-06-28 10:28:06-04	2015-12-28 08:56:28-05	13	\N
92	2	72	73f2b28d	2015-11-28	2016-06-28 10:28:06-04	2016-02-26 12:56:18-05	13	\N
93	2	72	2bf2b4ce	2015-11-27	2016-06-28 10:28:06-04	2015-11-28 13:27:07-05	13	\N
94	2	73	53f543ed	2015-11-25	2016-06-28 10:28:06-04	2015-11-26 09:34:03-05	13	\N
95	2	73	6bf54a8a	2015-11-24	2016-06-28 10:28:06-04	2015-11-30 13:19:17-05	13	\N
96	2	74	4bf55b2e	2015-11-21	2016-06-28 10:28:06-04	2015-11-25 13:35:33-05	13	\N
97	2	75	13f55d39	2015-11-20	2016-06-28 10:28:06-04	2015-11-25 13:36:37-05	13	\N
98	2	76	7bf56e5c	2015-11-18	2016-06-28 10:28:06-04	2016-01-27 20:13:01-05	13	\N
99	2	77	23f570f7	2015-11-17	2016-06-28 10:28:06-04	2015-11-23 18:40:15-05	13	\N
100	2	78	3f505a7	2015-11-14	2016-06-28 10:28:06-04	2016-06-12 10:55:12-04	13	\N
101	2	79	2bf50c3a	2015-11-13	2016-06-28 10:28:06-04	2015-11-23 18:53:09-05	13	\N
102	2	80	1bf5199c	2015-11-11	2016-06-28 10:28:06-04	2016-06-18 08:29:17-04	13	\N
103	2	81	43f523b7	2015-11-10	2016-06-28 10:28:06-04	2016-06-21 13:16:07-04	13	\N
104	2	82	13f52d49	2015-11-07	2016-06-28 10:28:06-04	2015-11-15 19:58:31-05	13	\N
105	2	83	3f53913	2015-11-06	2016-06-28 10:28:06-04	2015-11-15 19:58:19-05	13	\N
106	2	84	5bf5c348	2015-11-05	2016-06-28 10:28:06-04	2015-11-15 19:58:07-05	13	\N
107	2	82	2bf5d806	2015-11-01	2016-06-28 10:28:06-04	2015-11-15 19:57:56-05	13	\N
108	2	82	5bf5df5c	2015-10-31	2016-06-28 10:28:06-04	2016-06-12 11:01:13-04	13	\N
109	2	85	53f5df5d	2015-10-29	2016-06-28 10:28:06-04	2015-11-15 19:57:22-05	13	\N
110	1	86	4bf6af3e	2015-07-05	2016-06-28 11:08:51-04	2015-08-22 09:52:56-04	14	\N
111	1	86	7bf6b6cc	2015-07-04	2016-06-28 11:08:51-04	2015-07-16 08:43:31-04	14	\N
112	1	86	1bf6b9cc	2015-07-03	2016-06-28 11:08:51-04	2015-09-06 12:34:43-04	14	\N
113	1	87	2bc95402	2015-06-28	2016-06-28 11:08:51-04	2015-11-11 01:11:06-05	14	\N
114	1	87	7bc95e1c	2015-06-27	2016-06-28 11:08:51-04	2016-02-26 12:56:18-05	14	\N
115	1	86	3bd600ec	1995-07-09	2016-06-28 11:08:51-04	2015-10-20 15:17:08-04	15	\N
116	1	86	1bd6bde8	1995-07-08	2016-06-28 11:08:51-04	2015-07-20 11:30:39-04	15	\N
117	1	88	33d600ed	1995-07-06	2016-06-28 11:08:51-04	2015-05-16 23:11:17-04	15	\N
118	1	88	13d6bde9	1995-07-05	2016-06-28 11:08:51-04	2015-09-21 16:32:12-04	15	\N
119	1	89	bd6bdea	1995-07-02	2016-06-28 11:08:51-04	2015-03-13 08:39:23-04	15	\N
120	1	90	3d6bdeb	1995-06-30	2016-06-28 11:08:51-04	2016-03-13 15:51:00-04	15	\N
121	1	91	23d600ef	1995-06-28	2016-06-28 11:08:51-04	2015-12-01 15:35:05-05	15	\N
122	1	91	3bd600e8	1995-06-27	2016-06-28 11:08:51-04	2015-05-16 23:11:17-04	15	\N
123	1	92	33d600e9	1995-06-25	2016-06-28 11:08:51-04	2015-03-30 00:17:26-04	15	\N
124	1	92	13d6bdf5	1995-06-24	2016-06-28 11:08:51-04	2015-09-21 16:32:12-04	15	\N
125	1	93	2bd600ea	1995-06-22	2016-06-28 11:08:51-04	2016-01-27 20:08:03-05	15	\N
126	1	93	3d6bdf7	1995-06-21	2016-06-28 11:08:51-04	2015-12-01 15:35:05-05	15	\N
127	1	94	23d600eb	1995-06-19	2016-06-28 11:08:51-04	2016-02-26 12:56:24-05	15	\N
128	1	94	3bd600f4	1995-06-18	2016-06-28 11:08:51-04	2015-07-20 11:30:40-04	15	\N
129	1	95	1bd6bdf0	1995-06-15	2016-06-28 11:08:51-04	2015-05-16 23:11:17-04	15	\N
130	1	96	33d600f5	1995-06-04	2016-06-28 11:08:51-04	2015-03-30 00:17:27-04	15	\N
131	1	96	2bd600f6	1995-06-03	2016-06-28 11:08:51-04	2015-07-20 11:30:40-04	15	\N
132	1	96	bd6bdf2	1995-06-02	2016-06-28 11:08:51-04	2015-12-01 15:35:05-05	15	\N
133	1	97	23d600f7	1995-05-29	2016-06-28 11:08:51-04	2015-05-16 23:11:18-04	15	\N
134	1	97	3d6bdf3	1995-05-28	2016-06-28 11:08:51-04	2015-09-21 16:32:16-04	15	\N
135	1	98	3bd600f0	1995-05-26	2016-06-28 11:08:51-04	2015-12-01 15:35:05-05	15	\N
136	1	98	33d600f1	1995-05-25	2016-06-28 11:08:51-04	2015-11-25 17:34:38-05	15	\N
137	1	98	1bd6bdfc	1995-05-24	2016-06-28 11:08:51-04	2016-02-26 12:56:24-05	15	\N
138	1	99	2bd600f2	1995-05-21	2016-06-28 11:08:51-04	2015-05-16 23:11:18-04	15	\N
139	1	99	23d600f3	1995-05-20	2016-06-28 11:08:51-04	2015-07-20 11:30:40-04	15	\N
140	1	99	13d6bdfd	1995-05-19	2016-06-28 11:08:51-04	2015-12-01 15:35:06-05	15	\N
141	1	100	bd6bdfe	1995-04-07	2016-06-28 11:08:51-04	2015-12-01 15:35:06-05	16	\N
142	1	101	3bd600fc	1995-04-05	2016-06-28 11:08:51-04	2015-03-30 00:17:28-04	16	\N
143	1	101	3d6bdff	1995-04-04	2016-06-28 11:08:51-04	2015-12-01 15:35:06-05	16	\N
144	1	102	33d600fd	1995-04-02	2016-06-28 11:08:51-04	2015-03-19 21:29:34-04	16	\N
145	1	102	1bd6bdf8	1995-04-01	2016-06-28 11:08:51-04	2015-09-21 16:32:16-04	16	\N
146	1	103	2bd600fe	1995-03-30	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	16	\N
147	1	103	23d600ff	1995-03-29	2016-06-28 11:08:51-04	2015-03-13 08:39:23-04	16	\N
148	1	103	33d600f9	1995-03-27	2016-06-28 11:08:51-04	2015-09-21 16:32:12-04	16	\N
149	1	103	13d6bdf9	1995-03-26	2016-06-28 11:08:51-04	2015-03-23 20:05:34-04	16	\N
150	1	104	2bd600fa	1995-03-24	2016-06-28 11:08:51-04	2015-05-16 23:11:18-04	16	\N
151	1	104	23d600fb	1995-03-23	2016-06-28 11:08:51-04	2015-12-01 15:35:07-05	16	\N
152	1	104	bd6bdfa	1995-03-22	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	16	\N
153	1	105	3bd600f8	1995-03-19	2016-06-28 11:08:51-04	2015-12-01 15:35:07-05	16	\N
154	1	105	3bd60004	1995-03-18	2016-06-28 11:08:51-04	2015-11-29 14:02:33-05	16	\N
155	1	105	33d60005	1995-03-17	2016-06-28 11:08:51-04	2015-11-29 14:04:28-05	16	\N
156	1	106	2bd60006	1995-02-26	2016-06-28 11:08:51-04	2015-09-21 16:32:12-04	17	\N
157	1	106	23d60007	1995-02-25	2016-06-28 11:08:51-04	2015-12-01 15:35:07-05	17	\N
158	1	106	1bd6bd04	1995-02-24	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	17	\N
159	1	107	3bd60000	1995-02-21	2016-06-28 11:08:51-04	2015-05-16 23:11:18-04	17	\N
160	1	107	33d60001	1995-02-20	2016-06-28 11:08:51-04	2015-03-19 00:08:08-04	17	\N
161	1	107	13d6bd05	1995-02-19	2016-06-28 11:08:51-04	2015-07-20 11:30:40-04	17	\N
162	1	108	23d60003	1994-12-19	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	18	\N
163	1	108	3bd6000c	1994-12-18	2016-06-28 11:08:51-04	2015-03-13 08:39:23-04	18	\N
164	1	108	33d6000d	1994-12-16	2016-06-28 11:08:51-04	2014-06-23 11:14:36-04	18	\N
165	1	108	2bd6000e	1994-12-15	2016-06-28 11:08:51-04	2015-05-16 23:11:18-04	18	\N
166	1	106	23d6000f	1994-12-12	2016-06-28 11:08:51-04	2015-12-01 15:35:08-05	18	\N
167	1	106	3bd60008	1994-12-11	2016-06-28 11:08:51-04	2015-09-21 16:32:16-04	18	\N
168	1	106	33d60009	1994-12-09	2016-06-28 11:08:51-04	2015-03-20 22:57:30-04	18	\N
169	1	106	2bd6000a	1994-12-08	2016-06-28 11:08:51-04	2015-11-03 10:56:49-05	18	\N
170	1	109	23d6000b	1994-12-01	2016-06-28 11:08:51-04	2015-09-21 16:32:16-04	18	\N
171	1	109	3bd60014	1994-11-30	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	18	\N
172	1	109	33d60015	1994-11-29	2016-06-28 11:08:51-04	2015-12-01 15:35:08-05	18	\N
173	1	110	2bd60016	1994-10-19	2016-06-28 11:08:51-04	2015-03-23 20:05:37-04	18	\N
174	1	110	23d60017	1994-10-18	2016-06-28 11:08:51-04	2015-09-21 16:32:12-04	18	\N
175	1	110	3bd60010	1994-10-17	2016-06-28 11:08:51-04	2015-09-21 16:32:10-04	18	\N
176	1	110	33d60011	1994-10-15	2016-06-28 11:08:51-04	2015-12-01 15:35:08-05	18	\N
177	1	110	2bd60012	1994-10-14	2016-06-28 11:08:51-04	2016-02-26 12:56:25-05	18	\N
178	1	110	23d60013	1994-10-13	2016-06-28 11:08:52-04	2015-04-15 18:17:55-04	18	\N
179	1	111	3bd6001c	1994-10-11	2016-06-28 11:08:52-04	2015-12-01 15:35:09-05	18	\N
180	1	111	33d6001d	1994-10-10	2016-06-28 11:08:52-04	2015-11-29 13:25:50-05	18	\N
181	1	111	2bd6001e	1994-10-09	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	18	\N
182	1	105	23d6001f	1994-10-07	2016-06-28 11:08:52-04	2015-11-29 14:07:19-05	18	\N
183	1	105	3bd60018	1994-10-06	2016-06-28 11:08:52-04	2015-12-01 15:35:09-05	18	\N
184	1	105	33d60019	1994-10-05	2016-06-28 11:08:52-04	2015-11-29 14:09:55-05	18	\N
185	1	112	2bd6001a	1994-10-03	2016-06-28 11:08:52-04	2015-09-21 16:32:16-04	18	\N
186	1	112	23d6001b	1994-10-02	2016-06-28 11:08:52-04	2015-09-21 16:32:12-04	18	\N
187	1	112	3bd60024	1994-10-01	2016-06-28 11:08:52-04	2015-05-16 23:11:19-04	18	\N
188	1	112	33d60025	1994-09-29	2016-06-28 11:08:52-04	2015-04-15 18:17:56-04	18	\N
189	1	112	2bd60026	1994-09-28	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	18	\N
190	1	112	23d60027	1994-09-27	2016-06-28 11:08:52-04	2015-12-01 15:35:09-05	18	\N
191	1	113	3bd60020	1994-09-24	2016-06-28 11:08:52-04	2015-04-15 18:17:56-04	18	\N
192	1	96	33d60021	1994-09-18	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	18	\N
193	1	96	2bd60022	1994-09-17	2016-06-28 11:08:52-04	2015-03-19 21:29:35-04	18	\N
194	1	96	23d60023	1994-09-16	2016-06-28 11:08:52-04	2015-05-16 23:11:19-04	18	\N
195	1	94	3bd6002c	1994-08-04	2016-06-28 11:08:52-04	2015-07-20 11:30:41-04	19	\N
196	1	94	2bd60002	1994-08-03	2016-06-28 11:08:52-04	2015-12-01 15:35:10-05	19	\N
197	1	91	33d6002d	1994-08-01	2016-06-28 11:08:52-04	2015-09-21 16:32:16-04	19	\N
198	1	91	2bd6002e	1994-07-31	2016-06-28 11:08:52-04	2015-09-21 16:32:10-04	19	\N
199	1	114	23d6002f	1994-07-29	2016-06-28 11:08:52-04	2016-03-27 16:04:46-04	19	\N
200	1	88	3bd60028	1994-07-27	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	19	\N
201	1	88	33d60029	1994-07-26	2016-06-28 11:08:52-04	2015-12-01 15:35:10-05	19	\N
202	1	86	2bd6002a	1994-07-24	2016-06-28 11:08:52-04	2016-01-27 20:08:03-05	19	\N
203	1	86	23d6002b	1994-07-23	2016-06-28 11:08:52-04	2015-04-15 18:17:56-04	19	\N
204	1	89	3bd60034	1994-07-21	2016-06-28 11:08:52-04	2015-09-21 16:32:16-04	19	\N
205	1	89	33d60035	1994-07-20	2016-06-28 11:08:52-04	2015-03-19 00:09:50-04	19	\N
206	1	89	2bd60036	1994-07-19	2016-06-28 11:08:52-04	2015-12-01 15:35:10-05	19	\N
207	1	92	23d60037	1994-07-17	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	19	\N
208	1	92	3bd60030	1994-07-16	2016-06-28 11:08:52-04	2015-12-05 12:14:49-05	19	\N
209	1	95	33d60031	1994-07-13	2016-06-28 11:08:52-04	2013-11-21 03:31:41-05	19	\N
210	1	96	2bd60032	1994-07-03	2016-06-28 11:08:52-04	2015-05-16 23:11:21-04	19	\N
211	1	96	23d60033	1994-07-02	2016-06-28 11:08:52-04	2016-03-17 19:06:58-04	19	\N
212	1	96	3bd6003c	1994-07-01	2016-06-28 11:08:52-04	2015-03-30 00:17:33-04	19	\N
213	1	99	33d6003d	1994-06-26	2016-06-28 11:08:52-04	2015-09-21 16:32:16-04	19	\N
214	1	99	2bd6003e	1994-06-25	2016-06-28 11:08:52-04	2015-12-01 15:35:11-05	19	\N
215	1	99	23d6003f	1994-06-24	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	19	\N
216	1	115	3bd60038	1994-06-19	2016-06-28 11:08:52-04	2015-03-23 20:05:44-04	19	\N
217	1	115	33d60039	1994-06-18	2016-06-28 11:08:52-04	2015-12-01 15:35:11-05	19	\N
218	1	115	2bd6003a	1994-06-17	2016-06-28 11:08:52-04	2015-03-30 00:17:34-04	19	\N
219	1	98	23d6003b	1994-06-14	2016-06-28 11:08:52-04	2015-05-16 23:11:21-04	19	\N
220	1	98	3bd60044	1994-06-13	2016-06-28 11:08:52-04	2013-11-21 03:31:42-05	19	\N
221	1	116	33d60045	1994-06-10	2016-06-28 11:08:52-04	2015-12-01 15:35:11-05	19	\N
222	1	116	2bd60046	1994-06-09	2016-06-28 11:08:52-04	2015-07-20 11:30:41-04	19	\N
223	1	116	23d60047	1994-06-08	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	19	\N
224	1	117	3bd60040	1994-04-08	2016-06-28 11:08:52-04	2015-04-15 18:17:56-04	20	\N
225	1	117	33d60041	1994-04-07	2016-06-28 11:08:52-04	2015-05-16 23:11:21-04	20	\N
226	1	117	2bd60042	1994-04-06	2016-06-28 11:08:52-04	2015-09-21 16:32:17-04	20	\N
227	1	118	23d60043	1994-04-04	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	20	\N
228	1	103	3bd6004c	1994-04-01	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	20	\N
229	1	103	3bd60048	1994-03-31	2016-06-28 11:08:52-04	2015-12-01 15:35:11-05	20	\N
230	1	103	33d60049	1994-03-30	2016-06-28 11:08:52-04	2015-06-28 00:53:21-04	20	\N
231	1	119	2bd6004a	1994-03-28	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	20	\N
232	1	119	23d6004b	1994-03-27	2016-06-28 11:08:52-04	2015-12-01 15:35:12-05	20	\N
233	1	119	3bd60054	1994-03-25	2016-06-28 11:08:52-04	2015-03-30 00:17:36-04	20	\N
234	1	119	33d60055	1994-03-24	2016-06-28 11:08:52-04	2015-05-16 23:11:22-04	20	\N
235	1	119	2bd60056	1994-03-23	2016-06-28 11:08:52-04	2015-07-20 11:30:41-04	20	\N
236	1	120	23d60057	1994-03-21	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	20	\N
237	1	120	bd359de	1994-03-20	2016-06-28 11:08:52-04	2015-03-23 20:05:46-04	20	\N
238	1	121	3bd60050	1994-03-18	2016-06-28 11:08:52-04	2015-04-15 18:17:56-04	20	\N
239	1	121	33d60051	1994-03-17	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	20	\N
240	1	121	2bd60052	1994-03-16	2016-06-28 11:08:52-04	2015-12-01 15:35:12-05	20	\N
241	1	122	33d6004d	1994-03-06	2016-06-28 11:08:52-04	2015-12-01 15:35:12-05	20	\N
242	1	122	2bd6004e	1994-03-05	2016-06-28 11:08:52-04	2015-09-21 16:32:17-04	20	\N
243	1	122	23d6004f	1994-03-04	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	20	\N
244	1	106	3bd2e484	1994-02-27	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	20	\N
245	1	106	23d60053	1994-02-26	2016-06-28 11:08:52-04	2015-05-16 23:11:22-04	20	\N
246	1	106	3bd6005c	1994-02-25	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	20	\N
247	1	106	2bd6005e	1993-12-19	2016-06-28 11:08:52-04	2016-01-27 20:08:04-05	21	\N
248	1	106	23d6005f	1993-12-18	2016-06-28 11:08:52-04	2015-12-01 15:35:13-05	21	\N
249	1	106	3bd60058	1993-12-17	2016-06-28 11:08:52-04	2015-03-13 08:39:24-04	21	\N
250	1	123	33d60059	1993-12-13	2016-06-28 11:08:52-04	2015-12-01 15:35:13-05	21	\N
251	1	123	2bd6005a	1993-12-12	2016-06-28 11:08:52-04	2015-09-21 16:32:17-04	21	\N
252	1	108	23d6005b	1993-12-10	2016-06-28 11:08:52-04	2015-03-19 00:08:08-04	21	\N
253	1	108	3bd60064	1993-12-09	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	21	\N
254	1	108	33d60065	1993-12-08	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	21	\N
255	1	112	2bd60066	1993-09-30	2016-06-28 11:08:52-04	2015-12-01 15:35:13-05	21	\N
256	1	112	23d60067	1993-09-29	2016-06-28 11:08:52-04	2015-05-16 23:11:23-04	21	\N
257	1	112	3bd60060	1993-09-28	2016-06-28 11:08:52-04	2015-07-20 11:30:42-04	21	\N
258	1	112	33d60061	1993-09-26	2016-06-28 11:08:52-04	2015-12-01 15:35:14-05	21	\N
259	1	112	2bd60062	1993-09-25	2016-06-28 11:08:52-04	2015-09-21 16:32:17-04	21	\N
260	1	112	23d60063	1993-09-24	2016-06-28 11:08:52-04	2015-05-16 23:11:23-04	21	\N
261	1	110	3bd6006c	1993-09-22	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	21	\N
262	1	110	33d6006d	1993-09-21	2016-06-28 11:08:52-04	2015-03-19 21:29:37-04	21	\N
263	1	110	2bd6006e	1993-09-20	2016-06-28 11:08:52-04	2015-03-23 20:05:51-04	21	\N
264	1	110	23d6006f	1993-09-18	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	21	\N
265	1	110	3bd60068	1993-09-17	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	21	\N
266	1	110	33d60069	1993-09-16	2016-06-28 11:08:52-04	2015-07-20 11:30:42-04	21	\N
267	1	124	2bd6006a	1993-09-14	2016-06-28 11:08:52-04	2015-09-21 16:32:13-04	21	\N
268	1	124	23d6006b	1993-09-13	2016-06-28 11:08:52-04	2015-12-01 15:35:14-05	21	\N
269	1	124	3bd60074	1993-09-12	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	21	\N
270	1	120	33d60075	1993-09-10	2016-06-28 11:08:52-04	2015-09-21 16:32:17-04	21	\N
271	1	120	2bd60076	1993-09-09	2016-06-28 11:08:52-04	2015-12-01 15:35:15-05	21	\N
272	1	120	23d60077	1993-09-08	2016-06-28 11:08:52-04	2015-05-16 23:11:23-04	21	\N
273	1	96	3bd60070	1993-08-27	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	22	\N
274	1	96	33d60071	1993-08-26	2016-06-28 11:08:52-04	2015-03-30 00:17:44-04	22	\N
275	1	96	2bd60072	1993-08-25	2016-06-28 11:08:52-04	2015-12-01 15:35:15-05	22	\N
276	1	115	23d60073	1993-08-22	2016-06-28 11:08:52-04	2015-05-16 23:11:24-04	22	\N
277	1	115	3bd6007c	1993-08-21	2016-06-28 11:08:52-04	2015-11-25 17:34:41-05	22	\N
278	1	92	33d6007d	1993-06-26	2016-06-28 11:08:52-04	2015-12-11 15:02:37-05	23	\N
279	1	92	2bd6007e	1993-06-25	2016-06-28 11:08:52-04	2015-12-10 13:03:05-05	23	\N
280	1	89	23d6007f	1993-06-23	2016-06-28 11:08:52-04	2015-12-01 15:35:15-05	23	\N
281	1	89	3bd60078	1993-06-22	2016-06-28 11:08:52-04	2015-05-16 23:11:24-04	23	\N
282	1	89	33d60079	1993-06-21	2016-06-28 11:08:52-04	2015-03-18 01:31:15-04	23	\N
283	1	86	2bd6007a	1993-06-19	2016-06-28 11:08:52-04	2015-07-20 11:30:42-04	23	\N
284	1	86	23d6007b	1993-06-18	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	23	\N
285	1	125	1bd60184	1993-06-16	2016-06-28 11:08:52-04	2015-12-01 15:35:15-05	23	\N
286	1	125	13d60185	1993-06-15	2016-06-28 11:08:52-04	2015-03-30 00:17:47-04	23	\N
287	1	126	bd60186	1993-06-13	2016-06-28 11:08:52-04	2015-03-23 20:05:55-04	23	\N
288	1	114	3d60187	1993-06-11	2016-06-28 11:08:52-04	2016-03-27 16:04:46-04	23	\N
289	1	91	1bd60180	1993-06-09	2016-06-28 11:08:52-04	2015-12-01 15:35:16-05	23	\N
290	1	91	13d60181	1993-06-08	2016-06-28 11:08:52-04	2016-02-26 12:56:25-05	23	\N
291	1	94	bd60182	1993-06-06	2016-06-28 11:08:52-04	2015-05-16 23:11:25-04	23	\N
292	1	94	3d60183	1993-06-05	2016-06-28 11:08:53-04	2015-12-01 15:35:16-05	23	\N
293	1	116	1bd6018c	1993-05-27	2016-06-28 11:08:53-04	2015-04-15 18:17:56-04	23	\N
294	1	116	13d6018d	1993-05-26	2016-06-28 11:08:53-04	2015-05-16 23:11:25-04	23	\N
295	1	116	bd6018e	1993-05-25	2016-06-28 11:08:53-04	2015-03-30 00:17:49-04	23	\N
296	1	96	3d6018f	1993-05-23	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	23	\N
297	1	96	1bd60188	1993-05-22	2016-06-28 11:08:53-04	2015-03-20 22:57:37-04	23	\N
298	1	96	13d60189	1993-05-21	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
299	1	127	bd6018a	1993-05-16	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	23	\N
300	1	127	3d6018b	1993-05-15	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
301	1	127	1bd60194	1993-05-14	2016-06-28 11:08:53-04	2015-05-16 23:11:25-04	23	\N
302	1	128	33d6005d	1993-04-12	2016-06-28 11:08:53-04	2012-08-06 09:48:28-04	23	\N
303	1	119	13d60195	1993-04-05	2016-06-28 11:08:53-04	2013-11-21 03:31:42-05	23	\N
304	1	119	bd60196	1993-04-04	2016-06-28 11:08:53-04	2015-09-21 16:32:10-04	23	\N
305	1	119	3d60197	1993-04-02	2016-06-28 11:08:53-04	2015-03-19 21:29:39-04	23	\N
306	1	119	1bd60190	1993-04-01	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	23	\N
307	1	119	13d60191	1993-03-31	2016-06-28 11:08:53-04	2015-03-30 00:17:52-04	23	\N
308	1	93	bd60192	1993-03-29	2016-06-28 11:08:53-04	2015-05-16 23:11:26-04	23	\N
309	1	93	3d60193	1993-03-28	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	23	\N
310	1	93	1bd6019c	1993-03-27	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
311	1	129	13d6019d	1993-03-25	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	23	\N
312	1	129	bd6019e	1993-03-24	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	23	\N
313	1	103	3d6019f	1993-03-22	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	23	\N
314	1	103	1bd60198	1993-03-21	2016-06-28 11:08:53-04	2015-05-16 23:11:26-04	23	\N
315	1	103	13d60199	1993-03-20	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
316	1	130	bd6019a	1993-03-18	2016-06-28 11:08:53-04	2016-03-28 13:18:37-04	23	\N
317	1	130	3d6019b	1993-03-17	2016-06-28 11:08:53-04	2016-03-28 12:12:17-04	23	\N
318	1	130	1bd601a4	1993-03-16	2016-06-28 11:08:53-04	2016-03-28 12:43:39-04	23	\N
319	1	120	13d601a5	1993-03-14	2016-06-28 11:08:53-04	2016-03-28 12:46:36-04	23	\N
320	1	121	bd601a6	1993-03-11	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	23	\N
321	1	121	3d601a7	1993-03-10	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
322	1	121	1bd601a0	1993-03-09	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	23	\N
323	1	106	13d601a1	1993-02-23	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	23	\N
324	1	106	bd601a2	1993-02-22	2016-06-28 11:08:53-04	2015-07-06 02:19:20-04	23	\N
325	1	106	3d601a3	1993-02-21	2016-06-28 11:08:53-04	2015-05-16 23:11:28-04	23	\N
326	1	106	1bd601ac	1993-01-26	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	23	\N
327	1	106	13d601ad	1993-01-25	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
328	1	106	bd601ae	1993-01-24	2016-06-28 11:08:53-04	2015-03-23 20:06:05-04	23	\N
329	1	106	3d601af	1992-12-17	2016-06-28 11:08:53-04	2015-03-13 08:39:24-04	24	\N
330	1	106	1bd601a8	1992-12-16	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	24	\N
331	1	106	13d601a9	1992-12-13	2016-06-28 11:08:53-04	2015-03-19 13:40:23-04	24	\N
332	1	106	bd601aa	1992-12-12	2016-06-28 11:08:53-04	2015-03-19 00:08:08-04	24	\N
333	1	106	3d601ab	1992-12-11	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	24	\N
334	1	131	1bd601b4	1992-12-06	2016-06-28 11:08:53-04	2015-04-15 18:17:56-04	24	\N
335	1	131	13d601b5	1992-12-05	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	24	\N
336	1	109	bd601b6	1992-12-03	2016-06-28 11:08:53-04	2015-03-19 00:09:50-04	24	\N
337	1	109	3d601b7	1992-12-02	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	24	\N
338	1	114	1bd601b0	1992-07-01	2016-06-28 11:08:53-04	2016-03-27 16:04:46-04	25	\N
339	1	89	13d601b1	1992-06-29	2016-06-28 11:08:53-04	2015-03-19 00:08:08-04	25	\N
340	1	89	bd601b2	1992-06-28	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	25	\N
341	1	86	3d601b3	1992-06-26	2016-06-28 11:08:53-04	2015-03-19 21:29:40-04	25	\N
342	1	86	1bd601bc	1992-06-25	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	25	\N
343	1	132	13d601bd	1992-06-23	2016-06-28 11:08:53-04	2015-03-20 22:57:43-04	25	\N
344	1	132	bd601be	1992-06-22	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	25	\N
345	1	92	3d601bf	1992-06-20	2016-06-28 11:08:53-04	2015-05-17 12:09:00-04	25	\N
346	1	104	1bd601b8	1992-06-18	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	25	\N
347	1	104	13d601b9	1992-06-17	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	25	\N
348	1	94	bd601ba	1992-06-15	2016-06-28 11:08:53-04	2015-04-15 18:17:56-04	25	\N
349	1	94	3d601bb	1992-06-14	2016-06-28 11:08:53-04	2015-03-23 20:06:09-04	25	\N
350	1	93	1bd601c4	1992-06-12	2016-06-28 11:08:53-04	2013-07-07 19:34:06-04	25	\N
351	1	93	13d601c5	1992-06-11	2016-06-28 11:08:53-04	2014-09-16 15:04:27-04	25	\N
352	1	120	bd601c6	1992-06-09	2016-06-28 11:08:53-04	2016-02-26 12:56:25-05	25	\N
353	1	120	3d601c7	1992-06-08	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	25	\N
354	1	126	1bd601c0	1992-06-06	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	25	\N
355	1	127	13d601c1	1992-05-31	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	25	\N
356	1	127	bd601c2	1992-05-30	2016-06-28 11:08:53-04	2015-03-30 00:18:04-04	25	\N
357	1	127	3d601c3	1992-05-29	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	25	\N
358	1	96	1bd601cc	1992-05-25	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	25	\N
359	1	96	13d601cd	1992-05-24	2016-06-28 11:08:53-04	2015-04-15 18:17:56-04	25	\N
360	1	96	bd601ce	1992-05-23	2016-06-28 11:08:53-04	2014-09-16 15:02:43-04	25	\N
361	1	116	3d601cf	1992-05-21	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	25	\N
362	1	116	1bd601c8	1992-05-20	2016-06-28 11:08:53-04	2015-03-20 22:57:45-04	25	\N
363	1	116	13d601c9	1992-05-19	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	25	\N
364	1	91	bd601ca	1992-03-24	2016-06-28 11:08:53-04	2015-07-20 11:30:43-04	26	\N
365	1	91	3d601cb	1992-03-23	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	26	\N
366	1	133	1bd601d4	1992-03-21	2016-06-28 11:08:53-04	2015-03-19 00:09:50-04	26	\N
367	1	133	13d601d5	1992-03-20	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	26	\N
368	1	124	bd601d6	1992-03-18	2016-06-28 11:08:53-04	2015-03-30 00:18:06-04	26	\N
369	1	124	3d601d7	1992-03-17	2016-06-28 11:08:53-04	2015-03-18 01:31:18-04	26	\N
370	1	124	1bd601d0	1992-03-16	2016-06-28 11:08:53-04	2016-06-16 16:01:18-04	26	\N
371	1	119	13d601d1	1992-03-13	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	26	\N
372	1	119	bd601d2	1992-03-12	2016-06-28 11:08:53-04	2015-03-20 22:57:45-04	26	\N
373	1	119	3d601d3	1992-03-11	2016-06-28 11:08:53-04	2015-07-20 11:30:44-04	26	\N
374	1	130	1bd601dc	1992-03-09	2016-06-28 11:08:53-04	2015-10-29 22:59:25-04	26	\N
375	1	130	13d601dd	1992-03-08	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	26	\N
376	1	134	bd601de	1992-03-06	2016-06-28 11:08:53-04	2015-12-15 22:43:26-05	26	\N
377	1	134	3d601df	1992-03-05	2016-06-28 11:08:53-04	2015-12-15 22:43:26-05	26	\N
378	1	103	1bd601d8	1992-03-03	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	26	\N
379	1	103	13d601d9	1992-03-02	2016-06-28 11:08:53-04	2015-07-20 11:30:44-04	26	\N
380	1	103	bd601da	1992-03-01	2016-06-28 11:08:53-04	2015-03-30 00:18:09-04	26	\N
381	1	106	3d601db	1992-02-24	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	26	\N
382	1	106	2bd5a44a	1992-02-23	2016-06-28 11:08:53-04	2015-07-20 11:30:44-04	26	\N
383	1	106	1bd601e4	1992-02-22	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	26	\N
384	1	106	13d601e5	1991-12-31	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	23	\N
385	1	106	bd601e6	1991-12-30	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	23	\N
386	1	106	3d601e7	1991-12-28	2016-06-28 11:08:53-04	2015-11-29 12:56:24-05	23	\N
387	1	106	1bd601e0	1991-12-27	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
388	1	135	13d1793d	1991-11-03	2016-06-28 11:08:53-04	2015-07-20 11:30:44-04	23	\N
389	1	106	bd601e2	1991-10-31	2016-06-28 11:08:53-04	2016-01-13 07:59:39-05	23	\N
390	1	106	3d601e3	1991-10-30	2016-06-28 11:08:53-04	2015-03-19 13:40:23-04	23	\N
391	1	106	1bd601ec	1991-10-28	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	23	\N
392	1	106	13d601ed	1991-10-27	2016-06-28 11:08:53-04	2016-06-18 09:25:51-04	23	\N
393	1	112	bd601ee	1991-09-26	2016-06-28 11:08:53-04	2015-03-30 00:18:15-04	23	\N
394	1	112	3d601ef	1991-09-25	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	23	\N
395	1	112	1bd601e8	1991-09-24	2016-06-28 11:08:53-04	2015-11-29 12:55:21-05	23	\N
396	1	112	13d601e9	1991-09-22	2016-06-28 11:08:53-04	2016-06-16 16:01:18-04	23	\N
397	1	112	bd601ea	1991-09-21	2016-06-28 11:08:53-04	2015-03-19 00:09:50-04	23	\N
398	1	112	3d601eb	1991-09-20	2016-06-28 11:08:53-04	2016-02-26 12:56:26-05	23	\N
399	1	110	1bd601f4	1991-09-18	2016-06-28 11:08:53-04	2015-09-21 16:32:10-04	23	\N
400	1	110	13d601f5	1991-09-17	2016-06-28 11:08:53-04	2015-09-21 16:32:13-04	23	\N
401	1	110	bd601f6	1991-09-16	2016-06-28 11:08:53-04	2016-01-27 20:08:04-05	23	\N
402	1	110	3d601f7	1991-09-14	2016-06-28 11:08:53-04	2015-09-21 16:32:17-04	23	\N
403	1	110	1bd601f0	1991-09-13	2016-06-28 11:08:53-04	2015-04-15 18:17:57-04	23	\N
404	1	110	13d601f1	1991-09-12	2016-06-28 11:08:53-04	2015-03-13 08:39:24-04	23	\N
405	1	110	bd601f2	1991-09-10	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
406	1	110	3d601f3	1991-09-09	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
407	1	110	1bd601fc	1991-09-08	2016-06-28 11:08:54-04	2015-03-23 20:06:19-04	23	\N
408	1	120	13d601fd	1991-09-06	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
409	1	120	bd601fe	1991-09-05	2016-06-28 11:08:54-04	2015-07-20 11:30:45-04	23	\N
410	1	120	3d601ff	1991-09-04	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
411	1	96	1bd601f8	1991-08-18	2016-06-28 11:08:54-04	2015-07-14 17:34:36-04	23	\N
412	1	96	13d601f9	1991-08-17	2016-06-28 11:08:54-04	2015-03-30 00:18:19-04	23	\N
413	1	96	bd601fa	1991-08-16	2016-06-28 11:08:54-04	2015-08-08 00:41:02-04	23	\N
414	1	116	3d601fb	1991-08-14	2016-06-28 11:08:54-04	2015-03-19 00:08:09-04	23	\N
415	1	116	1bd60104	1991-08-13	2016-06-28 11:08:54-04	2015-11-29 13:23:38-05	23	\N
416	1	116	13d60105	1991-08-12	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
417	1	136	bd60106	1991-06-28	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
418	1	137	3d60107	1991-06-25	2016-06-28 11:08:54-04	2015-03-13 08:39:24-04	23	\N
419	1	137	1bd60100	1991-06-24	2016-06-28 11:08:54-04	2015-07-20 11:30:45-04	23	\N
420	1	86	13d60101	1991-06-22	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
421	1	138	bd60102	1991-06-20	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
422	1	138	3d60103	1991-06-19	2016-06-28 11:08:54-04	2014-08-27 16:22:20-04	23	\N
423	1	94	1bd6010c	1991-06-17	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
424	1	94	13d6010d	1991-06-16	2016-06-28 11:08:54-04	2015-07-20 11:30:45-04	23	\N
425	1	92	bd6010e	1991-06-14	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
426	1	104	3d6010f	1991-06-12	2016-06-28 11:08:54-04	2016-06-16 16:01:18-04	23	\N
427	1	104	1bd60108	1991-06-11	2016-06-28 11:08:54-04	2015-11-29 13:21:25-05	23	\N
428	1	114	13d60109	1991-06-09	2016-06-28 11:08:54-04	2016-03-27 16:04:46-04	23	\N
429	1	89	bd6010a	1991-06-07	2016-06-28 11:08:54-04	2015-03-20 22:57:53-04	23	\N
430	1	89	3d6010b	1991-06-06	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
431	1	139	1bd60114	1991-06-01	2016-06-28 11:08:54-04	2015-03-13 08:39:24-04	23	\N
432	1	96	13d60115	1991-05-12	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
433	1	96	bd60116	1991-05-11	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
434	1	96	3d60117	1991-05-10	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
435	1	116	1bd60110	1991-05-05	2016-06-28 11:08:54-04	2015-03-19 00:08:09-04	23	\N
436	1	116	13d60111	1991-05-04	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
437	1	116	bd60112	1991-05-03	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
438	1	127	3d60113	1991-04-28	2016-06-28 11:08:54-04	2015-03-31 15:29:47-04	23	\N
439	1	127	1bd6011c	1991-04-27	2016-06-28 11:08:54-04	2015-03-13 08:39:24-04	23	\N
440	1	118	13d6011d	1991-04-09	2016-06-28 11:08:54-04	2016-01-27 20:08:04-05	23	\N
441	1	118	bd6011e	1991-04-08	2016-06-28 11:08:54-04	2015-03-19 13:40:23-04	23	\N
442	1	118	3d6011f	1991-04-07	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
443	1	103	1bd60118	1991-04-05	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
444	1	103	13d60119	1991-04-04	2016-06-28 11:08:54-04	2015-03-13 08:39:24-04	23	\N
445	1	103	bd6011a	1991-04-03	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
446	1	140	3d6011b	1991-04-01	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
447	1	140	1bd60124	1991-03-31	2016-06-28 11:08:54-04	2015-03-30 00:18:30-04	23	\N
448	1	119	13d60125	1991-03-29	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
449	1	119	bd60126	1991-03-28	2016-06-28 11:08:54-04	2014-08-27 16:41:33-04	23	\N
450	1	119	3d60127	1991-03-27	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
451	1	93	1bd60120	1991-03-25	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
452	1	93	13d60121	1991-03-24	2016-06-28 11:08:54-04	2015-07-20 11:30:46-04	23	\N
453	1	93	bd60122	1991-03-23	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	23	\N
454	1	130	3d60123	1991-03-21	2016-06-28 11:08:54-04	2014-09-01 12:24:44-04	23	\N
455	1	130	1bd6012c	1991-03-20	2016-06-28 11:08:54-04	2015-03-19 00:08:09-04	23	\N
456	1	130	13d6012d	1991-03-18	2016-06-28 11:08:54-04	2016-02-26 12:56:26-05	23	\N
457	1	130	bd6012e	1991-03-17	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
458	1	106	3d6012f	1991-02-21	2016-06-28 11:08:54-04	2015-03-19 00:08:09-04	23	\N
459	1	106	1bd60128	1991-02-20	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
460	1	106	13d60129	1991-02-19	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
461	1	106	bd6012a	1990-12-31	2016-06-28 11:08:54-04	2015-10-19 08:15:37-04	23	\N
462	1	106	3d6012b	1990-12-30	2016-06-28 11:08:54-04	2015-11-05 17:10:37-05	23	\N
463	1	106	1bd60134	1990-12-28	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
464	1	106	13d60135	1990-12-27	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
465	1	109	bd60136	1990-12-14	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
466	1	109	3d60137	1990-12-13	2016-06-28 11:08:54-04	2015-11-05 18:08:30-05	23	\N
467	1	109	1bd60130	1990-12-12	2016-06-28 11:08:54-04	2015-12-12 21:39:02-05	23	\N
468	1	131	13d60131	1990-12-09	2016-06-28 11:08:54-04	2015-11-05 18:05:30-05	23	\N
469	1	131	bd60132	1990-12-08	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
470	1	106	3d60133	1990-12-04	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
471	1	106	1bd6013c	1990-12-03	2016-06-28 11:08:54-04	2015-11-29 12:59:09-05	23	\N
472	1	141	13d6013d	1990-11-01	2016-06-28 11:08:54-04	2015-11-29 12:57:57-05	27	\N
473	1	141	bd6013e	1990-10-31	2016-06-28 11:08:54-04	2016-01-27 20:08:05-05	27	\N
474	1	141	3d6013f	1990-10-30	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	27	\N
475	1	142	1bd60138	1990-10-28	2016-06-28 11:08:54-04	2015-11-05 14:56:15-05	27	\N
476	1	142	13d60139	1990-10-27	2016-06-28 11:08:54-04	2015-07-20 11:30:47-04	27	\N
477	1	143	bd6013a	1990-10-24	2016-06-28 11:08:54-04	2015-09-21 16:32:13-04	27	\N
478	1	144	3d6013b	1990-10-22	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	27	\N
479	1	145	1bd60144	1990-10-20	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	27	\N
480	1	145	13d60145	1990-10-19	2016-06-28 11:08:54-04	2015-03-19 00:08:09-04	27	\N
481	1	146	bd60146	1990-10-17	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	27	\N
482	1	147	3d60147	1990-10-13	2016-06-28 11:08:54-04	2015-11-29 13:12:31-05	27	\N
483	1	110	1bd60140	1990-09-20	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
484	1	110	13d60141	1990-09-19	2016-06-28 11:08:54-04	2016-01-27 20:08:05-05	23	\N
485	1	110	bd60142	1990-09-18	2016-06-28 11:08:54-04	2014-08-27 14:51:25-04	23	\N
486	1	110	3d60143	1990-09-16	2016-06-28 11:08:54-04	2015-09-21 16:32:14-04	23	\N
487	1	110	1bd6014c	1990-09-15	2016-06-28 11:08:54-04	2015-11-03 10:59:07-05	23	\N
488	1	110	13d6014d	1990-09-14	2016-06-28 11:08:54-04	2014-08-27 14:53:42-04	23	\N
489	1	124	bd6014e	1990-09-12	2016-06-28 11:08:54-04	2016-03-28 12:34:48-04	23	\N
490	1	124	3d6014f	1990-09-11	2016-06-28 11:08:54-04	2015-07-20 11:30:47-04	23	\N
491	1	124	1bd60148	1990-09-10	2016-06-28 11:08:54-04	2015-03-19 00:09:51-04	23	\N
492	1	120	13d60149	1990-09-08	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
493	1	120	bd6014a	1990-09-07	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
494	1	148	3d6014b	1990-07-23	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
495	1	148	1bd60154	1990-07-22	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
496	1	148	13d60155	1990-07-21	2016-06-28 11:08:54-04	2015-05-17 10:13:38-04	23	\N
497	1	89	bd60156	1990-07-19	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
498	1	89	3d60157	1990-07-18	2016-06-28 11:08:54-04	2015-07-20 11:30:47-04	23	\N
499	1	126	1bd60150	1990-07-16	2016-06-28 11:08:54-04	2015-07-20 11:37:52-04	23	\N
500	1	149	13d60151	1990-07-14	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
501	1	92	bd60152	1990-07-12	2016-06-28 11:08:54-04	2015-09-21 16:32:17-04	23	\N
502	1	150	3d60153	1990-07-10	2016-06-28 11:08:54-04	2015-09-21 16:32:14-04	23	\N
503	1	90	1bd6015c	1990-07-08	2016-06-28 11:08:54-04	2016-06-10 00:54:47-04	23	\N
504	1	151	13d6015d	1990-07-06	2016-06-28 11:08:54-04	2015-07-20 11:30:48-04	23	\N
505	1	137	bd6015e	1990-07-04	2016-06-28 11:08:54-04	2015-03-13 08:39:25-04	23	\N
506	1	115	3d6015f	1990-06-24	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
507	1	115	1bd60158	1990-06-23	2016-06-28 11:08:54-04	2015-03-19 13:40:23-04	23	\N
508	1	96	13d60159	1990-06-17	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
509	1	96	bd6015a	1990-06-16	2016-06-28 11:08:54-04	2015-07-20 11:30:48-04	23	\N
510	1	96	3d6015b	1990-06-15	2016-06-28 11:08:54-04	2015-03-20 22:58:07-04	23	\N
511	1	116	1bd60164	1990-06-10	2016-06-28 11:08:54-04	2015-03-30 00:18:42-04	23	\N
512	1	116	13d60165	1990-06-09	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
513	1	116	bd60166	1990-06-08	2016-06-28 11:08:54-04	2015-07-20 11:30:48-04	23	\N
514	1	152	3d60167	1990-05-06	2016-06-28 11:08:54-04	2016-02-26 12:56:27-05	23	\N
515	1	152	1bd60160	1990-05-05	2016-06-28 11:08:54-04	2015-03-19 13:40:23-04	23	\N
516	1	103	13d60161	1990-04-03	2016-06-28 11:08:54-04	2015-04-15 18:17:57-04	23	\N
517	1	103	bd60162	1990-04-02	2016-06-28 11:08:54-04	2014-08-26 07:59:34-04	23	\N
518	1	103	43d64b4b	1990-04-01	2016-06-28 11:08:54-04	2015-07-20 11:30:48-04	23	\N
519	1	119	1bd6016c	1990-03-30	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
520	1	119	13d6016d	1990-03-29	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
521	1	119	bd6016e	1990-03-28	2016-06-28 11:08:55-04	2014-08-26 07:55:26-04	23	\N
522	1	93	3d6016f	1990-03-26	2016-06-28 11:08:55-04	2015-07-20 11:30:48-04	23	\N
523	1	93	1bd60168	1990-03-25	2016-06-28 11:08:55-04	2015-04-15 18:17:57-04	23	\N
524	1	93	13d60169	1990-03-24	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
525	1	133	bd6016a	1990-03-22	2016-06-28 11:08:55-04	2016-03-15 12:05:44-04	23	\N
526	1	133	3d6016b	1990-03-21	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
527	1	153	1bd60174	1990-03-19	2016-06-28 11:08:55-04	2014-09-16 15:02:43-04	23	\N
528	1	153	13d60175	1990-03-18	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
529	1	130	bd60176	1990-03-16	2016-06-28 11:08:55-04	2015-03-19 00:09:51-04	23	\N
530	1	130	3d60177	1990-03-15	2016-06-28 11:08:55-04	2015-07-20 11:30:48-04	23	\N
531	1	130	1bd60170	1990-03-14	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
532	1	106	13d60171	1990-02-27	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
533	1	106	bd60172	1990-02-26	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
534	1	106	3d60173	1990-02-25	2016-06-28 11:08:55-04	2015-07-20 11:30:48-04	23	\N
535	1	106	1bd6017c	1989-12-31	2016-06-28 11:08:55-04	2015-12-30 16:13:46-05	23	\N
536	1	106	13d6017d	1989-12-30	2016-06-28 11:08:55-04	2015-12-30 16:08:25-05	23	\N
537	1	106	bd6017e	1989-12-28	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
538	1	106	3d6017f	1989-12-27	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
539	1	154	1bd60178	1989-12-10	2016-06-28 11:08:55-04	2015-07-20 11:30:48-04	23	\N
540	1	154	13d60179	1989-12-09	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
541	1	154	bd6017a	1989-12-08	2016-06-28 11:08:55-04	2015-03-20 22:58:12-04	23	\N
542	1	106	3d6017b	1989-12-06	2016-06-28 11:08:55-04	2015-11-29 13:11:40-05	23	\N
543	1	117	7bd60684	1989-10-26	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
544	1	117	73d60685	1989-10-25	2016-06-28 11:08:55-04	2014-09-16 15:02:43-04	23	\N
545	1	104	6bd60686	1989-10-23	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
546	1	104	63d60687	1989-10-22	2016-06-28 11:08:55-04	2015-03-23 20:06:42-04	23	\N
547	1	124	7bd60680	1989-10-20	2016-06-28 11:08:55-04	2015-03-20 22:58:15-04	23	\N
548	1	124	73d60681	1989-10-19	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
549	1	124	6bd60682	1989-10-18	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
550	1	155	63d60683	1989-10-16	2016-06-28 11:08:55-04	2014-09-16 15:02:43-04	23	\N
551	1	155	7bd6068c	1989-10-15	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
552	1	155	73d6068d	1989-10-14	2016-06-28 11:08:55-04	2014-08-13 23:58:46-04	23	\N
553	1	155	6bd6068e	1989-10-12	2016-06-28 11:08:55-04	2014-08-13 23:57:51-04	23	\N
554	1	155	63d6068f	1989-10-11	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
555	1	134	7bd60688	1989-10-09	2016-06-28 11:08:55-04	2015-12-15 22:43:26-05	23	\N
556	1	134	73d60689	1989-10-08	2016-06-28 11:08:55-04	2015-12-15 22:43:26-05	23	\N
557	1	96	6bd6068a	1989-10-01	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
558	1	96	63d6068b	1989-09-30	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
559	1	96	7bd60694	1989-09-29	2016-06-28 11:08:55-04	2015-07-20 11:30:49-04	23	\N
560	1	156	73d60695	1989-08-19	2016-06-28 11:08:55-04	2015-07-20 11:30:49-04	23	\N
561	1	156	6bd60696	1989-08-18	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
562	1	156	63d60697	1989-08-17	2016-06-28 11:08:55-04	2015-03-13 08:39:25-04	23	\N
563	1	116	7bd60690	1989-08-06	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
564	1	116	73d60691	1989-08-05	2016-06-28 11:08:55-04	2015-07-20 11:30:49-04	23	\N
565	1	116	6bd60692	1989-08-04	2016-06-28 11:08:55-04	2015-03-30 00:18:48-04	23	\N
566	1	157	63d60693	1989-07-19	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
567	1	157	7bd6069c	1989-07-18	2016-06-28 11:08:55-04	2015-05-17 09:53:38-04	23	\N
568	1	157	73d6069d	1989-07-17	2016-06-28 11:08:55-04	2015-07-20 11:30:50-04	23	\N
569	1	89	6bd6069e	1989-07-15	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
570	1	92	63d6069f	1989-07-13	2016-06-28 11:08:55-04	2015-03-19 00:08:09-04	23	\N
571	1	92	7bd60698	1989-07-12	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
572	1	94	73d60699	1989-07-10	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
573	1	94	6bd6069a	1989-07-09	2016-06-28 11:08:55-04	2015-07-20 11:30:50-04	23	\N
574	1	158	63d6069b	1989-07-07	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
575	1	126	7bd606a4	1989-07-04	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
576	1	159	73d606a5	1989-07-02	2016-06-28 11:08:55-04	2015-05-17 09:57:16-04	23	\N
577	1	96	6bd606a6	1989-06-21	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
578	1	96	63d606a7	1989-06-19	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
579	1	96	7bd606a0	1989-06-18	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
580	1	160	73d606a1	1989-05-27	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
581	1	161	6bd606a2	1989-05-07	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
582	1	161	63d606a3	1989-05-06	2016-06-28 11:08:55-04	2015-07-20 11:30:50-04	23	\N
583	1	162	7bd606ac	1989-04-30	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
584	1	162	73d606ad	1989-04-29	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
585	1	162	6bd606ae	1989-04-28	2016-06-28 11:08:55-04	2015-03-19 00:09:51-04	23	\N
586	1	163	63d606af	1989-04-17	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
587	1	164	7bd606a8	1989-04-16	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
588	1	164	73d606a9	1989-04-15	2016-06-28 11:08:55-04	2015-09-21 16:32:17-04	23	\N
589	1	121	6bd606aa	1989-04-13	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
590	1	121	63d606ab	1989-04-12	2016-06-28 11:08:55-04	2016-02-26 12:56:27-05	23	\N
591	1	121	7bd606b4	1989-04-11	2016-06-28 11:08:55-04	2015-03-23 20:06:56-04	23	\N
592	1	125	73d606b5	1989-04-09	2016-06-28 11:08:55-04	2016-01-27 20:08:05-05	23	\N
593	1	165	6bd606b6	1989-04-08	2016-06-28 11:08:55-04	2015-07-20 11:30:50-04	23	\N
594	1	166	63d606b7	1989-04-06	2016-06-28 11:08:55-04	2015-04-15 18:17:58-04	23	\N
595	1	166	7bd606b0	1989-04-05	2016-06-28 11:08:55-04	2015-03-23 20:06:57-04	23	\N
596	1	167	73d606b1	1989-04-03	2016-06-28 11:08:55-04	2015-03-13 08:39:25-04	23	\N
597	1	167	6bd606b2	1989-04-02	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
598	1	140	63d606b3	1989-03-31	2016-06-28 11:08:55-04	2015-09-21 16:32:18-04	23	\N
599	1	140	7bd606bc	1989-03-30	2016-06-28 11:08:55-04	2015-07-20 11:30:51-04	23	\N
600	1	103	73d606bd	1989-03-28	2016-06-28 11:08:55-04	2015-03-23 20:06:59-04	23	\N
601	1	103	6bd606be	1989-03-27	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
602	1	154	63d606bf	1989-02-12	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
603	1	154	7bd606b8	1989-02-11	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
604	1	154	73d606b9	1989-02-10	2016-06-28 11:08:55-04	2015-04-15 18:17:58-04	23	\N
605	1	168	6bd606ba	1989-02-07	2016-06-28 11:08:55-04	2015-11-29 13:09:07-05	23	\N
606	1	168	63d606bb	1989-02-06	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
607	1	168	7bd606c4	1989-02-05	2016-06-28 11:08:55-04	2015-03-19 00:08:09-04	23	\N
608	1	106	73d606c5	1988-12-31	2016-06-28 11:08:55-04	2015-09-21 16:32:18-04	23	\N
609	1	106	6bd606c6	1988-12-29	2016-06-28 11:08:55-04	2015-03-23 20:07:01-04	23	\N
610	1	106	63d606c7	1988-12-28	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
611	1	169	7bd606c0	1988-12-11	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
612	1	169	73d606c1	1988-12-10	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
613	1	169	6bd606c2	1988-12-09	2016-06-28 11:08:55-04	2015-09-21 16:32:18-04	23	\N
614	1	170	63d606c3	1988-10-21	2016-06-28 11:08:55-04	2015-09-21 16:32:18-04	23	\N
615	1	171	7bd606cc	1988-10-20	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
616	1	172	73d606cd	1988-10-18	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
617	1	173	6bd606ce	1988-10-16	2016-06-28 11:08:55-04	2015-09-21 16:32:18-04	23	\N
618	1	173	63d606cf	1988-10-15	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
619	1	117	7bd606c8	1988-10-14	2016-06-28 11:08:55-04	2015-07-20 11:30:51-04	23	\N
620	1	96	73d606c9	1988-10-02	2016-06-28 11:08:55-04	2015-03-23 20:07:03-04	23	\N
621	1	96	6bd606ca	1988-10-01	2016-06-28 11:08:55-04	2015-03-19 00:08:09-04	23	\N
622	1	96	63d606cb	1988-09-30	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
623	1	110	7bd606d4	1988-09-24	2016-06-28 11:08:55-04	2015-09-21 16:32:14-04	23	\N
624	1	110	73d606d5	1988-09-23	2016-06-28 11:08:55-04	2015-03-23 20:07:04-04	23	\N
625	1	110	6bd606d6	1988-09-22	2016-06-28 11:08:55-04	2016-02-26 12:56:28-05	23	\N
626	1	110	73d606fd	1988-09-20	2016-06-28 11:08:55-04	2015-04-15 18:17:58-04	23	\N
627	1	110	6bd606fe	1988-09-19	2016-06-28 11:08:55-04	2015-03-19 00:08:09-04	23	\N
628	1	110	63d606ff	1988-09-18	2016-06-28 11:08:55-04	2015-03-20 22:58:28-04	23	\N
629	1	110	7bd606f8	1988-09-16	2016-06-28 11:08:55-04	2015-07-20 11:30:52-04	23	\N
630	1	110	73d606f9	1988-09-15	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
631	1	110	6bd606fa	1988-09-14	2016-06-28 11:08:56-04	2016-01-27 20:08:05-05	23	\N
632	1	124	7bd60604	1988-09-12	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
633	1	124	6bd60606	1988-09-11	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
634	1	124	63d606d7	1988-09-09	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
635	1	124	7bd606d0	1988-09-08	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
636	1	130	73d606d1	1988-09-06	2016-06-28 11:08:56-04	2015-03-23 20:07:08-04	23	\N
637	1	130	6bd606d2	1988-09-05	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
638	1	130	63d606d3	1988-09-03	2016-06-28 11:08:56-04	2015-03-19 13:40:24-04	23	\N
639	1	130	7bd606dc	1988-09-02	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
640	1	115	73d606dd	1988-08-28	2016-06-28 11:08:56-04	2015-03-19 00:08:09-04	23	\N
641	1	174	6bd606de	1988-08-26	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
642	1	175	63d606df	1988-07-31	2016-06-28 11:08:56-04	2015-09-21 16:32:11-04	23	\N
643	1	175	7bd606d8	1988-07-30	2016-06-28 11:08:56-04	2014-08-14 15:35:14-04	23	\N
644	1	175	73d606d9	1988-07-29	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
645	1	156	6bd606da	1988-07-17	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
646	1	156	63d606db	1988-07-16	2016-06-28 11:08:56-04	2015-07-20 11:30:53-04	23	\N
647	1	156	7bd606e4	1988-07-15	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
648	1	176	73d606e5	1988-07-03	2016-06-28 11:08:56-04	2015-05-17 10:15:30-04	23	\N
649	1	176	7bd60600	1988-07-02	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
650	1	177	63d60603	1988-06-30	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
651	1	178	7bd6060c	1988-06-28	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
652	1	167	6bd606e6	1988-06-26	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
653	1	114	73d6060d	1988-06-25	2016-06-28 11:08:56-04	2016-03-27 16:04:46-04	23	\N
654	1	157	6bd6060e	1988-06-23	2016-06-28 11:08:56-04	2016-01-27 20:08:06-05	23	\N
655	1	157	63d606e7	1988-06-22	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
656	1	157	63d606fb	1988-06-20	2016-06-28 11:08:56-04	2014-08-12 17:39:20-04	23	\N
657	1	157	73d60605	1988-06-19	2016-06-28 11:08:56-04	2015-03-19 00:08:09-04	23	\N
658	1	163	63d60607	1988-06-17	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
659	1	161	7bd606e0	1988-05-01	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
660	1	161	73d606e1	1988-04-30	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
661	1	162	6bd606e2	1988-04-24	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
662	1	162	63d606e3	1988-04-23	2016-06-28 11:08:56-04	2016-03-25 09:42:01-04	23	\N
663	1	162	7bd606ec	1988-04-22	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
664	1	121	73d606ed	1988-04-15	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
665	1	121	6bd606ee	1988-04-14	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
666	1	121	63d606ef	1988-04-13	2016-06-28 11:08:56-04	2015-03-19 00:08:09-04	23	\N
667	1	179	7bd606e8	1988-04-11	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
668	1	180	73d606e9	1988-04-09	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
669	1	180	6bd606ea	1988-04-08	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
670	1	180	63d606eb	1988-04-07	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
671	1	153	7bd606f4	1988-04-05	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
672	1	153	73d606f5	1988-04-04	2016-06-28 11:08:56-04	2015-05-17 10:30:51-04	23	\N
673	1	153	6bd606f6	1988-04-03	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
674	1	155	63d606f7	1988-04-01	2016-06-28 11:08:56-04	2015-07-20 11:30:54-04	23	\N
675	1	155	7bd606f0	1988-03-31	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
676	1	155	73d606f1	1988-03-30	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
677	1	134	6bd606f2	1988-03-28	2016-06-28 11:08:56-04	2016-01-27 20:08:06-05	23	\N
678	1	134	63d606f3	1988-03-27	2016-06-28 11:08:56-04	2015-12-15 22:43:26-05	23	\N
679	1	134	73d60601	1988-03-26	2016-06-28 11:08:56-04	2015-12-15 22:43:26-05	23	\N
680	1	103	7bd606fc	1988-03-24	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
681	1	168	63d6060f	1988-03-18	2016-06-28 11:08:56-04	2015-09-21 16:32:14-04	23	\N
682	1	168	7bd60608	1988-03-17	2016-06-28 11:08:56-04	2015-07-20 11:30:54-04	23	\N
683	1	168	73d60609	1988-03-16	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
684	1	181	bf245da	1988-03-12	2016-06-28 11:08:56-04	2016-01-07 21:26:53-05	23	\N
685	1	168	6bd6060a	1988-02-17	2016-06-28 11:08:56-04	2015-03-19 00:08:09-04	23	\N
686	1	168	63d6060b	1988-02-16	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
687	1	168	7bd60614	1988-02-14	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
688	1	168	73d60615	1988-02-13	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
689	1	106	6bd60616	1987-12-31	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
690	1	106	63d60617	1987-12-30	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
691	1	106	7bd60610	1987-12-28	2016-06-28 11:08:56-04	2015-07-20 11:30:55-04	23	\N
692	1	106	73d60611	1987-12-27	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
693	1	169	6bd60612	1987-11-15	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
694	1	169	63d60613	1987-11-14	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
695	1	169	7bd6061c	1987-11-13	2016-06-28 11:08:56-04	2014-08-27 17:18:26-04	23	\N
696	1	168	73d6061d	1987-11-08	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
697	1	168	6bd6061e	1987-11-07	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
698	1	168	63d6061f	1987-11-06	2016-06-28 11:08:56-04	2016-01-27 20:08:06-05	23	\N
699	1	96	7bd60618	1987-10-04	2016-06-28 11:08:56-04	2016-02-21 21:37:30-05	23	\N
700	1	96	73d60619	1987-10-03	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
701	1	96	6bd6061a	1987-10-02	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
702	1	124	63d6061b	1987-09-24	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
703	1	124	7bd60624	1987-09-23	2016-06-28 11:08:56-04	2016-05-26 12:21:30-04	23	\N
704	1	124	73d60625	1987-09-22	2016-06-28 11:08:56-04	2016-02-02 04:55:12-05	23	\N
705	1	110	6bd60626	1987-09-20	2016-06-28 11:08:56-04	2016-01-27 20:08:06-05	23	\N
706	1	110	63d60627	1987-09-19	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
707	1	110	7bd60620	1987-09-18	2016-06-28 11:08:56-04	2016-05-26 12:21:31-04	23	\N
708	1	182	73d60621	1987-09-17	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
709	1	110	6bd60622	1987-09-16	2016-06-28 11:08:56-04	2015-03-19 00:08:10-04	23	\N
710	1	110	63d60623	1987-09-15	2016-06-28 11:08:56-04	2015-07-20 11:30:55-04	23	\N
711	1	130	7bd6062c	1987-09-13	2016-06-28 11:08:56-04	2016-05-26 12:21:33-04	23	\N
712	1	130	73d6062d	1987-09-12	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
713	1	130	6bd6062e	1987-09-11	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
714	1	183	63d6062f	1987-09-09	2016-06-28 11:08:56-04	2015-07-20 11:30:56-04	23	\N
715	1	183	7bd60628	1987-09-08	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
716	1	183	73d60629	1987-09-07	2016-06-28 11:08:56-04	2016-05-26 12:21:34-04	23	\N
717	1	184	6bd6062a	1987-08-23	2016-06-28 11:08:56-04	2015-09-21 17:52:43-04	23	\N
718	1	184	63d6062b	1987-08-22	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
719	1	185	7bd60634	1987-08-20	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
720	1	131	73d60635	1987-08-18	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
721	1	186	6bd60636	1987-08-16	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
722	1	186	63d60637	1987-08-15	2016-06-28 11:08:56-04	2015-03-19 13:40:25-04	23	\N
723	1	187	7bd60630	1987-08-13	2016-06-28 11:08:56-04	2015-07-30 17:50:37-04	23	\N
724	1	187	73d60631	1987-08-12	2016-06-28 11:08:56-04	2016-02-26 12:56:28-05	23	\N
725	1	187	6bd60632	1987-08-11	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
726	1	188	63d60633	1987-07-26	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	28	\N
727	1	160	7bd6063c	1987-07-24	2016-06-28 11:08:56-04	2016-03-25 09:42:01-04	28	\N
728	1	115	73d6063d	1987-07-19	2016-06-28 11:08:56-04	2016-02-26 12:56:29-05	28	\N
729	1	94	6bd6063e	1987-07-12	2016-06-28 11:08:56-04	2015-10-29 23:14:49-04	28	\N
730	1	158	63d6063f	1987-07-10	2016-06-28 11:08:56-04	2015-10-29 23:15:21-04	28	\N
731	1	189	7bd60638	1987-07-08	2016-06-28 11:08:56-04	2015-10-29 23:05:17-04	23	\N
732	1	189	73d60639	1987-07-07	2016-06-28 11:08:56-04	2016-03-25 09:42:01-04	23	\N
733	1	167	6bd6063a	1987-07-06	2016-06-28 11:08:56-04	2015-10-29 23:07:04-04	23	\N
734	1	159	63d6063b	1987-07-04	2016-06-28 11:08:56-04	2015-07-20 11:37:22-04	28	\N
735	1	177	7bd60644	1987-07-02	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
736	1	190	73d60645	1987-06-30	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
737	1	157	6bd60646	1987-06-28	2016-06-28 11:08:56-04	2015-03-19 13:40:25-04	23	\N
738	1	157	63d60647	1987-06-27	2016-06-28 11:08:56-04	2016-02-26 12:56:29-05	23	\N
739	1	157	7bd60640	1987-06-26	2016-06-28 11:08:56-04	2015-09-21 16:32:18-04	23	\N
740	1	156	73d60641	1987-06-21	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
741	1	156	6bd60642	1987-06-20	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
742	1	156	63d60643	1987-06-19	2016-06-28 11:08:56-04	2016-02-26 12:56:29-05	23	\N
743	1	191	7bd6064c	1987-06-14	2016-06-28 11:08:56-04	2015-03-19 13:40:25-04	23	\N
744	1	191	73d6064d	1987-06-13	2016-06-28 11:08:56-04	2015-04-15 18:17:58-04	23	\N
745	1	191	6bd6064e	1987-06-12	2016-06-28 11:08:56-04	2015-07-20 11:30:57-04	23	\N
746	1	175	63d6064f	1987-05-10	2016-06-28 11:08:56-04	2016-02-26 12:56:29-05	23	\N
747	1	175	7bd60648	1987-05-09	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
748	1	161	73d60649	1987-05-03	2016-06-28 11:08:56-04	2015-09-21 16:32:15-04	23	\N
749	1	161	6bd6064a	1987-05-02	2016-06-28 11:08:56-04	2016-02-26 12:56:29-05	23	\N
750	1	162	63d6064b	1987-04-19	2016-06-28 11:08:57-04	2015-07-20 11:30:57-04	23	\N
751	1	162	7bd60654	1987-04-18	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
752	1	162	73d60655	1987-04-17	2016-06-28 11:08:57-04	2015-03-23 20:07:44-04	23	\N
753	1	192	6bd60656	1987-04-11	2016-06-28 11:08:57-04	2014-08-28 13:30:23-04	23	\N
754	1	192	63d60657	1987-04-10	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
755	1	192	7bd60650	1987-04-09	2016-06-28 11:08:57-04	2014-09-16 15:02:43-04	23	\N
756	1	155	73d60651	1987-04-07	2016-06-28 11:08:57-04	2015-03-20 22:58:53-04	23	\N
757	1	155	6bd60652	1987-04-06	2016-06-28 11:08:57-04	2015-06-01 00:10:20-04	23	\N
758	1	180	63d60653	1987-04-04	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
759	1	180	7bd6065c	1987-04-03	2016-06-28 11:08:57-04	2016-01-27 20:08:06-05	23	\N
760	1	180	73d6065d	1987-04-02	2016-06-28 11:08:57-04	2015-03-19 13:40:25-04	23	\N
761	1	124	6bd6065e	1987-03-31	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
762	1	124	63d6065f	1987-03-30	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
763	1	124	7bd60658	1987-03-29	2016-06-28 11:08:57-04	2015-03-19 00:08:10-04	23	\N
764	1	153	73d60659	1987-03-27	2016-06-28 11:08:57-04	2015-03-23 20:07:49-04	23	\N
765	1	153	6bd6065a	1987-03-26	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
766	1	134	63d6065b	1987-03-24	2016-06-28 11:08:57-04	2015-12-15 22:43:26-05	23	\N
767	1	134	7bd60664	1987-03-23	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
768	1	134	73d60665	1987-03-22	2016-06-28 11:08:57-04	2015-12-15 22:43:26-05	23	\N
769	1	168	6bd60666	1987-03-03	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
770	1	168	63d60667	1987-03-02	2016-06-28 11:08:57-04	2016-03-25 09:42:01-04	23	\N
771	1	168	7bd60660	1987-03-01	2016-06-28 11:08:57-04	2015-03-23 20:07:52-04	23	\N
772	1	181	73d60661	1987-01-30	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
773	1	181	6bd60662	1987-01-29	2016-06-28 11:08:57-04	2016-03-25 09:42:01-04	23	\N
774	1	181	63d60663	1987-01-28	2016-06-28 11:08:57-04	2016-01-27 20:08:06-05	23	\N
775	1	168	7bd6066c	1986-12-31	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
776	1	168	73d6066d	1986-12-30	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
777	1	168	6bd6066e	1986-12-28	2016-06-28 11:08:57-04	2015-03-20 22:58:56-04	23	\N
778	1	168	63d6066f	1986-12-27	2016-06-28 11:08:57-04	2015-06-01 00:10:20-04	23	\N
779	1	106	7bd60668	1986-12-17	2016-06-28 11:08:57-04	2015-03-23 20:08:01-04	23	\N
780	1	106	73d60669	1986-12-16	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
781	1	106	6bd6066a	1986-12-15	2016-06-28 11:08:57-04	2016-06-16 16:01:19-04	23	\N
782	1	92	63d6066b	1986-07-07	2016-06-28 11:08:57-04	2016-01-27 20:08:07-05	23	\N
783	1	92	7bd60674	1986-07-06	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
784	1	126	73d60675	1986-07-04	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
785	1	193	6bd60676	1986-07-02	2016-06-28 11:08:57-04	2015-10-30 02:09:54-04	23	\N
786	1	194	63d60677	1986-06-30	2016-06-28 11:08:57-04	2014-08-28 14:01:32-04	23	\N
787	1	157	7bd60670	1986-06-29	2016-06-28 11:08:57-04	2015-06-01 00:10:20-04	23	\N
788	1	157	73d60671	1986-06-28	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
789	1	195	6bd60672	1986-06-26	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
790	1	156	63d60673	1986-06-22	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
791	1	156	7bd6067c	1986-06-21	2016-06-28 11:08:57-04	2015-07-20 11:30:59-04	23	\N
792	1	156	73d6067d	1986-06-20	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
793	1	161	6bd6067e	1986-05-11	2016-06-28 11:08:57-04	2016-01-27 20:08:07-05	23	\N
794	1	161	63d6067f	1986-05-10	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
795	1	116	7bd60678	1986-05-04	2016-06-28 11:08:57-04	2015-07-20 11:30:59-04	23	\N
796	1	116	73d60679	1986-05-03	2016-06-28 11:08:57-04	2015-07-14 17:34:36-04	23	\N
797	1	113	6bd6067a	1986-04-22	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
798	1	113	63d6067b	1986-04-21	2016-06-28 11:08:57-04	2014-08-28 14:21:56-04	23	\N
799	1	113	5bd60784	1986-04-19	2016-06-28 11:08:57-04	2015-03-20 22:59:04-04	23	\N
800	1	113	53d60785	1986-04-18	2016-06-28 11:08:57-04	2015-07-14 17:34:36-04	23	\N
801	1	162	4bd60786	1986-04-13	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
802	1	162	43d60787	1986-04-12	2016-06-28 11:08:57-04	2015-03-19 00:08:10-04	23	\N
803	1	153	5bd60780	1986-04-04	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
804	1	153	53d60781	1986-04-03	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
805	1	183	4bd60782	1986-04-01	2016-06-28 11:08:57-04	2015-03-20 22:59:06-04	23	\N
806	1	183	43d60783	1986-03-31	2016-06-28 11:08:57-04	2014-08-28 14:42:53-04	23	\N
807	1	183	5bd6078c	1986-03-30	2016-06-28 11:08:57-04	2015-07-14 17:34:37-04	23	\N
808	1	196	53d6078d	1986-03-28	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
809	1	196	4bd6078e	1986-03-27	2016-06-28 11:08:57-04	2015-07-20 11:31:00-04	23	\N
810	1	124	43d6078f	1986-03-25	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
811	1	124	5bd60788	1986-03-24	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
812	1	124	53d60789	1986-03-23	2016-06-28 11:08:57-04	2015-03-23 20:08:16-04	23	\N
813	1	134	4bd6078a	1986-03-21	2016-06-28 11:08:57-04	2015-12-15 22:43:26-05	23	\N
814	1	134	43d6078b	1986-03-20	2016-06-28 11:08:57-04	2015-12-15 22:43:26-05	23	\N
815	1	134	5bd60794	1986-03-19	2016-06-28 11:08:57-04	2015-12-15 22:43:26-05	23	\N
816	1	168	53d60795	1986-02-14	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
817	1	168	4bd60796	1986-02-12	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
818	1	168	43d60797	1986-02-11	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
819	1	168	5bd60790	1986-02-09	2016-06-28 11:08:57-04	2015-07-14 17:34:37-04	23	\N
820	1	168	53d60791	1986-02-08	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
821	1	106	4bd60792	1985-12-31	2016-06-28 11:08:57-04	2016-06-16 16:01:19-04	23	\N
822	1	106	43d60793	1985-12-30	2016-06-28 11:08:57-04	2015-03-23 20:08:21-04	23	\N
823	1	168	5bd6079c	1985-11-22	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
824	1	168	53d6079d	1985-11-21	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
825	1	168	4bd6079e	1985-11-20	2016-06-28 11:08:57-04	2016-06-16 16:01:19-04	23	\N
826	1	169	43d6079f	1985-11-17	2016-06-28 11:08:57-04	2015-07-20 11:31:00-04	23	\N
827	1	169	5bd60798	1985-11-16	2016-06-28 11:08:57-04	2015-03-19 00:08:10-04	23	\N
828	1	155	53d60799	1985-11-11	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
829	1	155	4bd6079a	1985-11-10	2016-06-28 11:08:57-04	2015-07-20 11:31:01-04	23	\N
830	1	197	43d6079b	1985-11-08	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
831	1	197	5bd607a4	1985-11-07	2016-06-28 11:08:57-04	2016-06-16 16:01:19-04	23	\N
832	1	180	53d607a5	1985-11-05	2016-06-28 11:08:57-04	2014-09-16 15:02:43-04	23	\N
833	1	180	4bd607a6	1985-11-04	2016-06-28 11:08:57-04	2016-01-27 20:08:07-05	23	\N
834	1	198	43d607a7	1985-11-02	2016-06-28 11:08:57-04	2016-06-16 16:01:19-04	23	\N
835	1	198	5bd607a0	1985-11-01	2016-06-28 11:08:57-04	2015-06-01 00:10:20-04	23	\N
836	1	199	53d607a1	1985-10-31	2016-06-28 11:08:57-04	2016-03-25 09:42:01-04	23	\N
837	1	200	4bd607a2	1985-10-29	2016-06-28 11:08:57-04	2013-07-11 13:01:07-04	23	\N
838	1	200	43d607a3	1985-10-28	2016-06-28 11:08:57-04	2015-03-19 00:09:51-04	23	\N
839	1	201	5bd607ac	1985-10-26	2016-06-28 11:08:57-04	2015-09-21 16:32:11-04	23	\N
840	1	202	53d607ad	1985-10-25	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
841	1	200	1bc2216c	1985-10-20	2016-06-28 11:08:57-04	2014-08-30 02:06:46-04	23	\N
842	1	203	4bd607ae	1985-09-15	2016-06-28 11:08:57-04	2015-03-23 20:08:33-04	23	\N
843	1	168	43d607af	1985-09-12	2016-06-28 11:08:57-04	2014-09-16 15:02:43-04	23	\N
844	1	168	5bd607a8	1985-09-11	2016-06-28 11:08:57-04	2014-09-16 15:04:28-04	23	\N
845	1	168	53d607a9	1985-09-10	2016-06-28 11:08:57-04	2015-07-20 11:31:02-04	23	\N
846	1	187	4bd607aa	1985-09-07	2016-06-28 11:08:57-04	2016-02-26 12:56:29-05	23	\N
847	1	187	43d607ab	1985-09-06	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
848	1	187	5bd607b4	1985-09-05	2016-06-28 11:08:57-04	2015-07-14 17:34:37-04	23	\N
849	1	204	53d607b5	1985-09-03	2016-06-28 11:08:57-04	2016-06-16 12:25:29-04	23	\N
850	1	205	4bd607b6	1985-09-02	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
851	1	206	43d607b7	1985-08-31	2016-06-28 11:08:57-04	2014-08-30 02:25:50-04	23	\N
852	1	207	5bd607b0	1985-08-30	2016-06-28 11:08:57-04	2015-07-14 17:34:37-04	23	\N
853	1	208	53d607b1	1985-08-24	2016-06-28 11:08:57-04	2016-02-26 12:56:30-05	23	\N
854	1	191	4bd607b2	1985-07-14	2016-06-28 11:08:57-04	2015-07-20 11:31:02-04	23	\N
855	1	191	43d607b3	1985-07-13	2016-06-28 11:08:57-04	2015-03-13 08:39:26-04	23	\N
856	1	167	5bd607bc	1985-07-02	2016-06-28 11:08:57-04	2016-02-26 12:56:30-05	23	\N
857	1	209	53d607bd	1985-07-01	2016-06-28 11:08:57-04	2015-06-01 00:10:20-04	23	\N
858	1	209	4bd607be	1985-06-30	2016-06-28 11:08:57-04	2015-10-01 13:54:00-04	23	\N
859	1	210	43d607bf	1985-06-28	2016-06-28 11:08:57-04	2015-03-18 18:44:52-04	23	\N
860	1	178	5bd607b8	1985-06-27	2016-06-28 11:08:57-04	2016-02-26 12:56:30-05	23	\N
861	1	211	53d607b9	1985-06-25	2016-06-28 11:08:57-04	2015-10-30 01:50:00-04	23	\N
862	1	194	4bd607ba	1985-06-24	2016-06-28 11:08:57-04	2015-09-21 16:32:15-04	23	\N
863	1	157	43d607bb	1985-06-22	2016-06-28 11:08:57-04	2015-10-01 13:54:00-04	23	\N
864	1	157	5bd607c4	1985-06-21	2016-06-28 11:08:57-04	2015-03-20 22:59:39-04	23	\N
865	1	156	53d607c5	1985-06-16	2016-06-28 11:08:57-04	2016-02-26 12:56:30-05	23	\N
866	1	156	4bd607c6	1985-06-15	2016-06-28 11:08:57-04	2015-07-20 11:31:03-04	23	\N
867	1	156	43d607c7	1985-06-14	2016-06-28 11:08:57-04	2015-10-01 13:54:00-04	23	\N
868	1	161	5bd607c0	1985-04-28	2016-06-28 11:08:57-04	2015-07-20 11:31:03-04	23	\N
869	1	161	53d607c1	1985-04-27	2016-06-28 11:08:57-04	2015-06-01 00:10:14-04	23	\N
870	1	162	4bd607c2	1985-04-14	2016-06-28 11:08:58-04	2015-07-20 11:31:03-04	23	\N
871	1	162	43d607c3	1985-04-13	2016-06-28 11:08:58-04	2015-03-19 00:09:51-04	23	\N
872	1	124	5bd607cc	1985-04-08	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
873	1	124	53d607cd	1985-04-07	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
874	1	124	4bd607ce	1985-04-06	2016-06-28 11:08:58-04	2015-07-20 11:31:04-04	23	\N
875	1	183	43d607cf	1985-04-04	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
876	1	183	5bd607c8	1985-04-03	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
877	1	196	53d607c9	1985-04-01	2016-06-28 11:08:58-04	2015-07-20 11:31:04-04	23	\N
878	1	196	4bd607ca	1985-03-31	2016-06-28 11:08:58-04	2016-06-16 16:01:19-04	23	\N
879	1	119	43d607cb	1985-03-29	2016-06-28 11:08:58-04	2015-03-18 18:44:54-04	23	\N
880	1	119	5bd607d4	1985-03-28	2016-06-28 11:08:58-04	2015-07-20 11:31:04-04	23	\N
881	1	119	53d607d5	1985-03-27	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
882	1	212	4bd607d6	1985-03-25	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
883	1	212	43d607d7	1985-03-24	2016-06-28 11:08:58-04	2015-03-23 20:09:01-04	23	\N
884	1	134	5bd607d0	1985-03-22	2016-06-28 11:08:58-04	2015-12-15 22:43:27-05	23	\N
885	1	134	53d607d1	1985-03-21	2016-06-28 11:08:58-04	2015-12-15 22:43:27-05	23	\N
886	1	113	4bd607d2	1985-03-13	2016-06-28 11:08:58-04	2015-03-18 01:31:37-04	23	\N
887	1	113	43d607d3	1985-03-12	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
888	1	113	5bd607dc	1985-03-10	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
889	1	113	53d607dd	1985-03-09	2016-06-28 11:08:58-04	2014-08-30 12:34:43-04	23	\N
890	1	168	4bd607de	1985-02-20	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
891	1	168	43d607df	1985-02-19	2016-06-28 11:08:58-04	2014-08-30 12:37:50-04	23	\N
892	1	168	5bd607d8	1985-02-18	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
893	1	181	53d607d9	1984-12-31	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
894	1	181	4bd607da	1984-12-29	2016-06-28 11:08:58-04	2015-03-23 20:09:08-04	23	\N
895	1	181	43d607db	1984-12-28	2016-06-28 11:08:58-04	2015-07-20 11:31:05-04	23	\N
896	1	113	5bd607e4	1984-11-03	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
897	1	113	53d607e5	1984-11-02	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
898	1	113	4bd607e6	1984-10-31	2016-06-28 11:08:58-04	2015-03-23 20:09:11-04	23	\N
899	1	113	43d607e7	1984-10-30	2016-06-28 11:08:58-04	2015-06-01 00:10:20-04	23	\N
900	1	113	5bd607e0	1984-10-28	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
901	1	113	53d607e1	1984-10-27	2016-06-28 11:08:58-04	2015-07-20 11:31:05-04	23	\N
902	1	213	4bd607e2	1984-10-20	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
903	1	155	43d607e3	1984-10-18	2016-06-28 11:08:58-04	2015-06-01 00:10:20-04	23	\N
904	1	155	5bd607ec	1984-10-17	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
905	1	153	53d607ed	1984-10-15	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
906	1	153	4bd607ee	1984-10-14	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
907	1	214	43d607ef	1984-10-12	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
908	1	214	5bd607e8	1984-10-11	2016-06-28 11:08:58-04	2015-03-19 00:09:51-04	23	\N
909	1	180	53d607e9	1984-10-09	2016-06-28 11:08:58-04	2015-06-01 00:10:20-04	23	\N
910	1	180	4bd607ea	1984-10-08	2016-06-28 11:08:58-04	2016-06-16 16:01:19-04	23	\N
911	1	198	43d607eb	1984-10-06	2016-06-28 11:08:58-04	2014-09-16 15:02:43-04	23	\N
912	1	104	5bd607f4	1984-10-05	2016-06-28 11:08:58-04	2015-07-20 11:31:06-04	23	\N
913	1	191	53d607f5	1984-07-22	2016-06-28 11:08:58-04	2015-09-21 02:13:12-04	23	\N
914	1	191	4bd607f6	1984-07-21	2016-06-28 11:08:58-04	2015-07-20 11:31:06-04	23	\N
915	1	156	43d607f7	1984-07-15	2016-06-28 11:08:58-04	2015-07-20 11:31:06-04	23	\N
916	1	156	5bd607f0	1984-07-14	2016-06-28 11:08:58-04	2015-03-19 00:08:10-04	23	\N
917	1	156	53d607f1	1984-07-13	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
918	1	157	4bd607f2	1984-07-07	2016-06-28 11:08:58-04	2016-02-26 12:56:30-05	23	\N
919	1	157	43d607f3	1984-07-06	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
920	1	215	5bd607fc	1984-07-04	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
921	1	204	53d607fd	1984-07-03	2016-06-28 11:08:58-04	2015-10-30 01:33:39-04	23	\N
922	1	138	4bd607fe	1984-07-01	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
923	1	216	43d607ff	1984-06-30	2016-06-28 11:08:58-04	2015-03-18 01:31:42-04	23	\N
924	1	211	5bd607f8	1984-06-29	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
925	1	209	53d607f9	1984-06-27	2016-06-28 11:08:58-04	2015-03-19 00:08:10-04	23	\N
926	1	209	4bd607fa	1984-06-26	2016-06-28 11:08:58-04	2015-07-20 11:31:07-04	23	\N
927	1	178	43d607fb	1984-06-24	2016-06-28 11:08:58-04	2015-06-01 00:10:21-04	23	\N
928	1	217	5bd60704	1984-06-23	2016-06-28 11:08:58-04	2015-03-19 00:09:51-04	23	\N
929	1	190	53d60705	1984-06-21	2016-06-28 11:08:58-04	2016-06-16 16:01:19-04	23	\N
930	1	187	4bd60706	1984-06-14	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
931	1	187	43d60707	1984-06-13	2016-06-28 11:08:58-04	2015-07-20 11:31:07-04	23	\N
932	1	187	5bd60700	1984-06-12	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
933	1	116	53d60701	1984-06-10	2016-06-28 11:08:58-04	2015-07-20 11:31:08-04	23	\N
934	1	116	4bd60702	1984-06-09	2016-06-28 11:08:58-04	2016-06-16 16:01:19-04	23	\N
935	1	218	43d60703	1984-05-08	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
936	1	218	5bd6070c	1984-05-07	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
937	1	218	53d6070d	1984-05-06	2016-06-28 11:08:58-04	2015-03-23 20:09:42-04	23	\N
938	1	119	4bd6070e	1984-04-30	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
939	1	119	43d6070f	1984-04-29	2016-06-28 11:08:58-04	2015-07-20 11:31:08-04	23	\N
940	1	183	5bd60708	1984-04-27	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
941	1	183	53d60709	1984-04-26	2016-06-28 11:08:58-04	2015-07-14 17:34:37-04	23	\N
942	1	219	4bd6070a	1984-04-24	2016-06-28 11:08:58-04	2015-07-20 11:31:08-04	23	\N
943	1	219	43d6070b	1984-04-23	2016-06-28 11:08:58-04	2015-09-21 16:32:15-04	23	\N
944	1	220	5bd60714	1984-04-21	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
945	1	220	53d60715	1984-04-20	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
946	1	220	4bd60716	1984-04-19	2016-06-28 11:08:58-04	2015-07-20 11:31:09-04	23	\N
947	1	221	43d60717	1984-04-17	2016-06-28 11:08:58-04	2014-09-02 13:16:43-04	23	\N
948	1	197	5bd60710	1984-04-16	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
949	1	134	53d60711	1984-04-14	2016-06-28 11:08:58-04	2015-12-15 22:43:27-05	23	\N
950	1	134	4bd60712	1984-04-13	2016-06-28 11:08:58-04	2015-12-15 22:43:27-05	23	\N
951	1	162	43d60713	1984-04-07	2016-06-28 11:08:58-04	2016-06-16 16:01:19-04	23	\N
952	1	222	5bd6071c	1984-04-06	2016-06-28 11:08:58-04	2015-07-20 11:31:09-04	23	\N
953	1	223	53d6071d	1984-04-01	2016-06-28 11:08:58-04	2015-03-23 20:09:51-04	23	\N
954	1	223	4bd6071e	1984-03-31	2016-06-28 11:08:58-04	2014-09-02 13:21:13-04	23	\N
955	1	223	43d6071f	1984-03-29	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
956	1	223	5bd60718	1984-03-28	2016-06-28 11:08:58-04	2015-09-21 16:32:16-04	23	\N
957	1	181	53d60719	1983-12-31	2016-06-28 11:08:58-04	2015-09-21 02:17:00-04	23	\N
958	1	181	4bd6071a	1983-12-30	2016-06-28 11:08:58-04	2015-11-03 20:38:37-05	23	\N
959	1	181	43d6071b	1983-12-28	2016-06-28 11:08:58-04	2015-07-20 11:31:09-04	23	\N
960	1	181	5bd60724	1983-12-27	2016-06-28 11:08:58-04	2015-07-14 17:34:38-04	23	\N
961	1	223	53d60725	1983-10-31	2016-06-28 11:08:58-04	2015-03-30 00:19:06-04	23	\N
962	1	223	4bd60726	1983-10-30	2016-06-28 11:08:58-04	2015-03-23 20:09:57-04	23	\N
963	1	213	43d60727	1983-10-22	2016-06-28 11:08:58-04	2015-07-20 11:31:10-04	23	\N
964	1	180	5bd60720	1983-10-21	2016-06-28 11:08:58-04	2015-07-14 17:34:38-04	23	\N
965	1	180	53d60721	1983-10-20	2016-06-28 11:08:58-04	2015-03-23 20:10:01-04	23	\N
966	1	196	4bd60722	1983-10-18	2016-06-28 11:08:58-04	2015-07-20 11:31:10-04	23	\N
967	1	224	43d60723	1983-10-17	2016-06-28 11:08:58-04	2015-03-23 20:10:04-04	23	\N
968	1	153	5bd6072c	1983-10-15	2016-06-28 11:08:58-04	2015-07-20 11:31:10-04	23	\N
969	1	153	53d6072d	1983-10-14	2016-06-28 11:08:58-04	2015-07-14 17:34:38-04	23	\N
970	1	110	4bd6072e	1983-10-12	2016-06-28 11:08:58-04	2016-01-27 20:08:08-05	23	\N
971	1	110	43d6072f	1983-10-11	2016-06-28 11:08:58-04	2015-07-20 11:31:10-04	23	\N
972	1	140	5bd60728	1983-10-09	2016-06-28 11:08:58-04	2015-03-23 20:10:07-04	23	\N
973	1	198	53d60729	1983-10-08	2016-06-28 11:08:58-04	2015-03-18 01:31:47-04	23	\N
974	1	225	4bd6072a	1983-09-24	2016-06-28 11:08:58-04	2016-03-25 09:42:01-04	23	\N
975	1	226	43d6072b	1983-09-18	2016-06-28 11:08:58-04	2015-03-23 20:10:10-04	23	\N
976	1	206	5bd60734	1983-09-13	2016-06-28 11:08:58-04	2015-03-19 00:08:10-04	23	\N
977	1	227	53d60735	1983-09-11	2016-06-28 11:08:58-04	2015-07-14 17:34:38-04	23	\N
978	1	227	4bd60736	1983-09-10	2016-06-28 11:08:58-04	2015-07-20 11:31:11-04	23	\N
979	1	187	43d60737	1983-09-08	2016-06-28 11:08:58-04	2013-10-24 11:30:55-04	23	\N
980	1	187	5bd60730	1983-09-07	2016-06-28 11:08:58-04	2015-07-20 11:31:11-04	23	\N
981	1	187	53d60731	1983-09-06	2016-06-28 11:08:58-04	2015-10-30 16:09:28-04	23	\N
982	1	185	4bd60732	1983-09-04	2016-06-28 11:08:58-04	2015-07-20 11:31:11-04	23	\N
983	1	228	43d60733	1983-09-02	2016-06-28 11:08:58-04	2015-03-30 00:19:14-04	23	\N
984	1	218	5bd6073c	1983-08-31	2016-06-28 11:08:58-04	2015-03-19 13:40:26-04	23	\N
985	1	218	53d6073d	1983-08-30	2016-06-28 11:08:58-04	2015-03-23 20:10:16-04	23	\N
986	1	218	4bd6073e	1983-08-29	2016-06-28 11:08:58-04	2015-07-20 11:31:12-04	23	\N
987	1	229	43d6073f	1983-08-27	2016-06-28 11:08:58-04	2015-03-19 00:08:10-04	23	\N
988	1	230	5bd60738	1983-08-26	2016-06-28 11:08:58-04	2015-03-30 00:19:16-04	23	\N
989	1	161	53d60739	1983-08-21	2016-06-28 11:08:58-04	2015-07-20 11:31:12-04	23	\N
990	1	161	4bd6073a	1983-08-20	2016-06-28 11:08:59-04	2015-02-12 22:46:58-05	23	\N
991	1	191	43d6073b	1983-07-31	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
992	1	191	5bd60744	1983-07-30	2016-06-28 11:08:59-04	2015-07-20 11:31:12-04	23	\N
993	1	231	53d60745	1983-06-28	2016-06-28 11:08:59-04	2015-09-21 16:32:16-04	23	\N
994	1	231	4bd60746	1983-06-27	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
995	1	232	43d60747	1983-06-25	2016-06-28 11:08:59-04	2015-03-23 20:10:23-04	23	\N
996	1	233	5bd60740	1983-06-24	2016-06-28 11:08:59-04	2015-03-19 00:08:10-04	23	\N
997	1	217	53d60741	1983-06-22	2016-06-28 11:08:59-04	2015-07-20 11:31:13-04	23	\N
998	1	209	4bd60742	1983-06-21	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
999	1	209	43d60743	1983-06-20	2016-06-28 11:08:59-04	2015-07-20 11:31:13-04	23	\N
1000	1	178	5bd6074c	1983-06-18	2016-06-28 11:08:59-04	2014-09-16 15:02:43-04	23	\N
1001	1	156	53d6074d	1983-05-15	2016-06-28 11:08:59-04	2016-01-05 23:17:49-05	23	\N
1002	1	156	4bd6074e	1983-05-14	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
1003	1	156	43d6074f	1983-05-13	2016-06-28 11:08:59-04	2015-07-20 11:31:13-04	23	\N
1004	1	124	5bd60748	1983-04-26	2016-06-28 11:08:59-04	2016-01-27 20:08:08-05	23	\N
1005	1	124	53d60749	1983-04-25	2016-06-28 11:08:59-04	2015-07-20 11:31:14-04	23	\N
1006	1	219	4bd6074a	1983-04-23	2016-06-28 11:08:59-04	2015-03-19 00:09:52-04	23	\N
1007	1	219	43d6074b	1983-04-22	2016-06-28 11:08:59-04	2016-03-25 09:42:01-04	23	\N
1008	1	183	5bd60754	1983-04-20	2016-06-28 11:08:59-04	2015-07-20 11:31:14-04	23	\N
1009	1	234	53d60755	1983-04-19	2016-06-28 11:08:59-04	2015-03-23 20:10:38-04	23	\N
1010	1	155	4bd60756	1983-04-17	2016-06-28 11:08:59-04	2016-01-27 20:08:08-05	23	\N
1011	1	155	43d60757	1983-04-16	2016-06-28 11:08:59-04	2015-09-21 16:32:16-04	23	\N
1012	1	197	5bd60750	1983-04-15	2016-06-28 11:08:59-04	2015-03-23 20:10:41-04	23	\N
1013	1	235	53d60751	1983-04-13	2016-06-28 11:08:59-04	2014-09-16 15:04:28-04	23	\N
1014	1	236	4bd60752	1983-04-12	2016-06-28 11:08:59-04	2015-03-19 00:09:52-04	23	\N
1015	1	237	43d60753	1983-04-10	2016-06-28 11:08:59-04	2016-01-03 18:52:18-05	23	\N
1016	1	134	5bd6075c	1983-04-09	2016-06-28 11:08:59-04	2015-12-15 22:43:27-05	23	\N
1017	1	238	53d6075d	1983-03-31	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
1018	1	238	4bd6075e	1983-03-30	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1019	1	238	43d6075f	1983-03-29	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1020	1	162	5bd60758	1983-03-27	2016-06-28 11:08:59-04	2015-07-20 11:31:15-04	23	\N
1021	1	222	53d60759	1983-03-26	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1022	1	239	4bd6075a	1983-03-25	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
1023	1	240	43d6075b	1982-12-31	2016-06-28 11:08:59-04	2016-02-26 12:56:30-05	23	\N
1024	1	240	5bd60764	1982-12-30	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1025	1	240	53d60765	1982-12-28	2016-06-28 11:08:59-04	2015-03-23 20:10:51-04	23	\N
1026	1	240	4bd60766	1982-12-27	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
1027	1	240	43d60767	1982-12-26	2016-06-28 11:08:59-04	2015-07-20 11:31:15-04	23	\N
1028	1	241	5bd60760	1982-11-25	2016-06-28 11:08:59-04	2015-03-23 20:10:53-04	23	\N
1029	1	227	53d60761	1982-10-17	2016-06-28 11:08:59-04	2015-03-23 20:10:58-04	23	\N
1030	1	161	4bd60762	1982-10-10	2016-06-28 11:08:59-04	2015-07-20 11:31:15-04	23	\N
1031	1	161	43d60763	1982-10-09	2016-06-28 11:08:59-04	2015-03-19 13:40:26-04	23	\N
1032	1	213	5bd6076c	1982-09-24	2016-06-28 11:08:59-04	2015-09-21 16:32:16-04	23	\N
1033	1	219	53d6076d	1982-09-23	2016-06-28 11:08:59-04	2015-03-19 00:09:52-04	23	\N
1034	1	110	4bd6076e	1982-09-21	2016-06-28 11:08:59-04	2015-07-20 11:31:16-04	23	\N
1035	1	110	43d6076f	1982-09-20	2016-06-28 11:08:59-04	2014-08-12 19:46:31-04	23	\N
1036	1	112	5bd60768	1982-09-18	2016-06-28 11:08:59-04	2015-03-23 20:11:04-04	23	\N
1037	1	196	53d60769	1982-09-17	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1038	1	130	4bd6076a	1982-09-15	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1039	1	242	43d6076b	1982-09-14	2016-06-28 11:08:59-04	2015-09-21 16:32:16-04	23	\N
1040	1	243	5bd60774	1982-09-12	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1041	1	244	53d60775	1982-09-11	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1042	1	245	4bd60776	1982-09-09	2016-06-28 11:08:59-04	2015-08-05 00:39:49-04	23	\N
1043	1	246	43d60777	1982-09-05	2016-06-28 11:08:59-04	2015-07-20 11:31:16-04	23	\N
1044	1	229	5bd60770	1982-08-29	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1045	1	247	53d60771	1982-08-28	2016-06-28 11:08:59-04	2015-07-20 11:31:17-04	23	\N
1046	1	248	4bd60772	1982-08-10	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1047	1	157	43d60773	1982-08-08	2016-06-28 11:08:59-04	2015-03-23 20:11:20-04	23	\N
1048	1	157	5bd6077c	1982-08-07	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1049	1	232	53d6077d	1982-08-06	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1050	1	249	4bd6077e	1982-08-04	2016-06-28 11:08:59-04	2015-10-30 01:39:32-04	23	\N
1051	1	204	43d6077f	1982-08-03	2016-06-28 11:08:59-04	2015-03-23 20:11:24-04	23	\N
1052	1	205	5bd60778	1982-08-01	2016-06-28 11:08:59-04	2015-09-21 16:32:16-04	23	\N
1053	1	206	53d60779	1982-07-31	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1054	1	187	4bd6077a	1982-07-29	2016-06-28 11:08:59-04	2015-03-23 20:11:28-04	23	\N
1055	1	187	43d6077b	1982-07-28	2016-06-28 11:08:59-04	2014-09-16 15:04:28-04	23	\N
1056	1	187	3bd60484	1982-07-27	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1057	1	239	33d60485	1982-07-25	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1058	1	191	2bd60486	1982-07-18	2016-06-28 11:08:59-04	2015-03-23 20:11:35-04	23	\N
1059	1	191	23d60487	1982-07-17	2016-06-28 11:08:59-04	2015-07-20 11:31:19-04	23	\N
1060	1	250	3bd60480	1982-05-28	2016-06-28 11:08:59-04	2016-02-26 12:56:30-05	23	\N
1061	1	156	33d60481	1982-05-23	2016-06-28 11:08:59-04	2015-03-23 20:11:39-04	23	\N
1062	1	156	2bd60482	1982-05-22	2016-06-28 11:08:59-04	2015-07-20 11:31:19-04	23	\N
1063	1	156	23d60483	1982-05-21	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1064	1	251	3bd6048c	1982-04-19	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1065	1	153	33d6048d	1982-04-18	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1066	1	153	2bd6048e	1982-04-17	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1067	1	183	23d6048f	1982-04-15	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1068	1	252	3bd60488	1982-04-14	2016-06-28 11:08:59-04	2015-07-20 11:31:19-04	23	\N
1069	1	182	33d60489	1982-04-13	2016-06-28 11:08:59-04	2014-03-09 13:43:12-04	23	\N
1070	1	119	2bd6048a	1982-04-12	2016-06-28 11:08:59-04	2016-06-16 16:01:19-04	23	\N
1071	1	119	23d6048b	1982-04-11	2016-06-28 11:08:59-04	2015-03-23 20:11:47-04	23	\N
1072	1	197	3bd60494	1982-04-09	2016-06-28 11:08:59-04	2015-07-20 11:31:20-04	23	\N
1073	1	253	33d60495	1982-04-08	2016-06-28 11:08:59-04	2016-03-25 09:42:01-04	23	\N
1074	1	124	2bd60496	1982-04-06	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1075	1	124	23d60497	1982-04-05	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1076	1	254	3bd60490	1982-04-03	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1077	1	255	33d60491	1982-04-02	2016-06-28 11:08:59-04	2016-01-27 20:08:09-05	23	\N
1078	1	256	2bd60492	1982-03-14	2016-06-28 11:08:59-04	2015-03-23 20:11:55-04	23	\N
1079	1	257	23d60493	1982-03-13	2016-06-28 11:08:59-04	2016-01-27 20:08:10-05	23	\N
1080	1	258	33d6049d	1982-02-21	2016-06-28 11:08:59-04	2015-07-20 11:31:20-04	23	\N
1081	1	259	2bd6049e	1982-02-20	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1082	1	259	23d6049f	1982-02-19	2016-06-28 11:08:59-04	2015-03-19 00:08:11-04	23	\N
1083	1	238	3bd60498	1982-02-17	2016-06-28 11:08:59-04	2015-07-14 17:34:38-04	23	\N
1084	1	238	33d60499	1982-02-16	2016-06-28 11:08:59-04	2015-07-20 11:31:21-04	23	\N
1085	1	240	2bd6049a	1981-12-31	2016-06-28 11:08:59-04	2016-06-16 16:01:19-04	23	\N
1086	1	240	23d6049b	1981-12-30	2016-06-28 11:08:59-04	2015-11-09 22:26:39-05	23	\N
1087	1	240	3bd604a4	1981-12-28	2016-06-28 11:08:59-04	2015-11-09 22:22:24-05	23	\N
1088	1	240	33d604a5	1981-12-27	2016-06-28 11:08:59-04	2015-11-09 22:19:11-05	23	\N
1089	1	240	2bd604a6	1981-12-26	2016-06-28 11:08:59-04	2015-11-09 22:15:45-05	23	\N
1090	1	260	23d604a7	1981-12-12	2016-06-28 11:08:59-04	2016-06-10 09:04:08-04	23	\N
1091	1	261	3bd604a0	1981-12-09	2016-06-28 11:08:59-04	2015-11-09 22:03:48-05	23	\N
1092	1	262	33d604a1	1981-12-07	2016-06-28 11:08:59-04	2015-11-09 21:59:32-05	23	\N
1093	1	121	2bd604a2	1981-12-06	2016-06-28 11:08:59-04	2015-11-09 21:49:32-05	23	\N
1094	1	263	23d604a3	1981-12-05	2016-06-28 11:08:59-04	2015-11-09 21:46:16-05	23	\N
1095	1	233	3bd604ac	1981-12-03	2016-06-28 11:08:59-04	2015-11-09 21:41:18-05	23	\N
1096	1	264	33d604ad	1981-12-02	2016-06-28 11:09:00-04	2015-11-09 21:32:48-05	23	\N
1097	1	265	2bd604ae	1981-11-30	2016-06-28 11:09:00-04	2016-03-27 13:52:05-04	23	\N
1098	1	167	23d604af	1981-11-29	2016-06-28 11:09:00-04	2015-11-09 21:23:29-05	23	\N
1099	1	266	3bd604a8	1981-10-19	2016-06-28 11:09:00-04	2016-06-24 15:28:07-04	23	\N
1100	1	267	33d604a9	1981-10-17	2016-06-28 11:09:00-04	2015-11-09 20:25:00-05	23	\N
1101	1	268	2bd604aa	1981-10-16	2016-06-28 11:09:00-04	2016-02-26 12:56:30-05	23	\N
1102	1	268	23d604ab	1981-10-15	2016-06-28 11:09:00-04	2015-11-09 20:19:55-05	23	\N
1103	1	269	3bd604b4	1981-10-13	2016-06-28 11:09:00-04	2015-11-09 20:12:23-05	23	\N
1104	1	270	33d604b5	1981-10-12	2016-06-28 11:09:00-04	2015-11-09 20:08:46-05	23	\N
1105	1	268	2bd604b6	1981-10-11	2016-06-28 11:09:00-04	2015-10-18 16:01:41-04	23	\N
1106	1	271	23d604b7	1981-10-10	2016-06-28 11:09:00-04	2015-11-09 20:06:12-05	23	\N
1107	1	272	3bd604b0	1981-10-08	2016-06-28 11:09:00-04	2016-05-02 01:18:41-04	23	\N
1108	1	273	33d604b1	1981-10-06	2016-06-28 11:09:00-04	2016-01-27 20:08:10-05	23	\N
1109	1	273	2bd604b2	1981-10-04	2016-06-28 11:09:00-04	2015-10-23 23:12:23-04	23	\N
1110	1	273	23d604b3	1981-10-03	2016-06-28 11:09:00-04	2015-10-23 22:47:19-04	23	\N
1111	1	273	3bd604bc	1981-10-02	2016-06-28 11:09:00-04	2015-10-23 22:45:03-04	23	\N
1112	1	274	33d604bd	1981-09-30	2016-06-28 11:09:00-04	2015-10-23 22:21:51-04	23	\N
1113	1	130	2bd604be	1981-09-27	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1114	1	275	23d604bf	1981-09-26	2016-06-28 11:09:00-04	2015-10-23 12:12:02-04	23	\N
1115	1	276	3bd604b8	1981-09-25	2016-06-28 11:09:00-04	2015-10-23 12:09:29-04	23	\N
1116	1	156	33d604b9	1981-09-13	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1117	1	156	2bd604ba	1981-09-12	2016-06-28 11:09:00-04	2015-10-23 21:37:07-04	23	\N
1118	1	156	23d604bb	1981-09-11	2016-06-28 11:09:00-04	2015-11-10 01:19:31-05	23	\N
1119	1	222	3bd604c4	1981-08-31	2016-06-28 11:09:00-04	2015-10-21 12:57:42-04	23	\N
1120	1	239	33d604c5	1981-08-30	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1121	1	169	2bd604c6	1981-08-28	2016-06-28 11:09:00-04	2015-10-21 12:53:05-04	23	\N
1122	1	169	23d604c7	1981-08-27	2016-06-28 11:09:00-04	2015-10-21 12:48:41-04	23	\N
1123	1	277	3bd604c0	1981-08-16	2016-06-28 11:09:00-04	2015-10-21 12:43:44-04	23	\N
1124	1	230	33d604c1	1981-08-15	2016-06-28 11:09:00-04	2015-10-21 12:42:11-04	23	\N
1125	1	229	2bd604c2	1981-08-14	2016-06-28 11:09:00-04	2015-10-21 12:05:31-04	23	\N
1126	1	278	23d604c3	1981-08-12	2016-06-28 11:09:00-04	2015-10-21 11:59:26-04	23	\N
1127	1	109	3bd604cc	1981-07-14	2016-06-28 11:09:00-04	2015-10-21 11:55:45-04	23	\N
1128	1	109	33d604cd	1981-07-13	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1129	1	157	2bd604ce	1981-07-11	2016-06-28 11:09:00-04	2015-10-21 11:49:13-04	23	\N
1130	1	232	23d604cf	1981-07-10	2016-06-28 11:09:00-04	2015-10-21 11:43:40-04	23	\N
1131	1	249	3bd604c8	1981-07-08	2016-06-28 11:09:00-04	2015-11-10 00:41:02-05	23	\N
1132	1	279	33d604c9	1981-07-07	2016-06-28 11:09:00-04	2015-10-21 11:36:45-04	23	\N
1133	1	205	2bd604ca	1981-07-05	2016-06-28 11:09:00-04	2015-10-21 11:35:41-04	23	\N
1134	1	206	23d604cb	1981-07-04	2016-06-28 11:09:00-04	2015-10-21 11:34:24-04	23	\N
1135	1	171	3bd604d4	1981-07-02	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1136	1	238	33d604d5	1981-05-22	2016-06-28 11:09:00-04	2015-10-20 09:19:43-04	23	\N
1137	1	253	2bd604d6	1981-05-17	2016-06-28 11:09:00-04	2015-10-20 09:07:47-04	23	\N
1138	1	280	23d604d7	1981-05-16	2016-06-28 11:09:00-04	2015-10-20 09:14:15-04	23	\N
1139	1	281	3bd604d0	1981-05-15	2016-06-28 11:09:00-04	2015-10-20 09:23:57-04	23	\N
1140	1	183	33d604d1	1981-05-13	2016-06-28 11:09:00-04	2016-06-16 16:01:19-04	23	\N
1141	1	219	2bd604d2	1981-05-12	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1142	1	219	23d604d3	1981-05-11	2016-06-28 11:09:00-04	2015-10-20 14:12:30-04	23	\N
1143	1	119	3bd604dc	1981-05-09	2016-06-28 11:09:00-04	2015-10-20 14:29:30-04	23	\N
1144	1	119	33d604dd	1981-05-08	2016-06-28 11:09:00-04	2015-10-20 14:34:31-04	23	\N
1145	1	282	2bd604de	1981-05-07	2016-06-28 11:09:00-04	2015-06-30 10:47:51-04	23	\N
1146	1	119	23d604df	1981-05-06	2016-06-28 11:09:00-04	2015-10-20 15:25:20-04	23	\N
1147	1	252	3bd604d8	1981-05-05	2016-06-28 11:09:00-04	2015-10-20 15:26:47-04	23	\N
1148	1	124	33d604d9	1981-05-04	2016-06-28 11:09:00-04	2015-10-20 15:30:44-04	23	\N
1149	1	124	2bd604da	1981-05-02	2016-06-28 11:09:00-04	2015-10-20 15:32:52-04	23	\N
1150	1	134	23d604db	1981-05-01	2016-06-28 11:09:00-04	2015-12-15 22:43:27-05	23	\N
1151	1	140	3bd604e4	1981-04-30	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1152	1	113	33d604e5	1981-04-25	2016-06-28 11:09:00-04	2015-10-20 15:47:29-04	23	\N
1153	1	146	6bd6baaa	1981-03-28	2016-06-28 11:09:00-04	2015-10-20 16:16:21-04	23	\N
1154	1	273	23d604e7	1981-03-24	2016-06-28 11:09:00-04	2015-10-20 16:01:40-04	23	\N
1155	1	273	3bd604e0	1981-03-23	2016-06-28 11:09:00-04	2016-01-27 20:08:11-05	23	\N
1156	1	273	33d604e1	1981-03-21	2016-06-28 11:09:00-04	2015-10-20 18:17:39-04	23	\N
1157	1	273	2bd604e2	1981-03-20	2016-06-28 11:09:00-04	2015-10-20 18:21:45-04	23	\N
1158	1	153	23d604e3	1981-03-14	2016-06-28 11:09:00-04	2015-11-10 01:10:21-05	23	\N
1159	1	283	3bd604ec	1981-03-13	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1160	1	112	33d604ed	1981-03-12	2016-06-28 11:09:00-04	2015-10-21 01:06:27-04	23	\N
1161	1	110	2bd604ee	1981-03-10	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1162	1	110	23d604ef	1981-03-09	2016-06-28 11:09:00-04	2015-10-21 09:46:04-04	23	\N
1163	1	284	3bd604e8	1981-03-07	2016-06-28 11:09:00-04	2016-06-16 16:01:19-04	23	\N
1164	1	285	33d604e9	1981-03-06	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1165	1	285	2bd604ea	1981-03-05	2016-06-28 11:09:00-04	2015-10-21 10:58:15-04	23	\N
1166	1	286	23d604eb	1981-03-03	2016-06-28 11:09:00-04	2015-11-10 00:46:46-05	23	\N
1167	1	286	3bd604f4	1981-03-02	2016-06-28 11:09:00-04	2015-10-21 11:22:22-04	23	\N
1168	1	287	33d604f5	1981-02-28	2016-06-28 11:09:00-04	2015-11-10 00:57:32-05	23	\N
1169	1	287	2bd604f6	1981-02-27	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1170	1	287	23d604f7	1981-02-26	2016-06-28 11:09:00-04	2015-11-10 01:00:40-05	23	\N
1171	1	240	3bd604f0	1980-12-31	2016-06-28 11:09:00-04	2015-07-20 11:31:28-04	23	\N
1172	1	240	33d604f1	1980-12-30	2016-06-28 11:09:00-04	2015-03-23 20:14:03-04	23	\N
1173	1	240	2bd604f2	1980-12-28	2016-06-28 11:09:00-04	2015-03-19 13:40:27-04	23	\N
1174	1	240	23d604f3	1980-12-27	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1175	1	240	3bd604fc	1980-12-26	2016-06-28 11:09:00-04	2015-07-14 17:34:39-04	23	\N
1176	1	169	33d604fd	1980-12-14	2016-06-28 11:09:00-04	2016-01-27 20:08:12-05	23	\N
1177	1	169	2bd604fe	1980-12-13	2016-06-28 11:09:00-04	2015-07-14 17:34:39-04	23	\N
1178	1	288	23d604ff	1980-12-12	2016-06-28 11:09:00-04	2015-07-20 11:31:28-04	23	\N
1179	1	289	3bd604f8	1980-12-06	2016-06-28 11:09:00-04	2015-04-24 17:56:54-04	23	\N
1180	1	200	33d604f9	1980-11-30	2016-06-28 11:09:00-04	2016-01-27 20:08:13-05	23	\N
1181	1	290	2bd604fa	1980-11-29	2016-06-28 11:09:00-04	2014-05-26 21:55:42-04	23	\N
1182	1	243	23d604fb	1980-11-28	2016-06-28 11:09:00-04	2015-03-19 00:09:52-04	23	\N
1183	1	202	3bd60404	1980-11-26	2016-06-28 11:09:00-04	2016-01-27 20:08:13-05	23	\N
1184	1	291	33d60405	1980-10-31	2016-06-28 11:09:00-04	2016-01-27 20:08:13-05	23	\N
1185	1	291	2bd60406	1980-10-30	2016-06-28 11:09:00-04	2015-04-24 17:55:59-04	23	\N
1186	1	291	23d60407	1980-10-29	2016-06-28 11:09:00-04	2016-01-27 20:08:14-05	23	\N
1187	1	291	3bd60400	1980-10-27	2016-06-28 11:09:00-04	2015-04-24 17:54:09-04	23	\N
1188	1	291	33d60401	1980-10-26	2016-06-28 11:09:01-04	2016-01-27 20:08:14-05	23	\N
1189	1	291	2bd60402	1980-10-25	2016-06-28 11:09:01-04	2015-04-24 17:53:35-04	23	\N
1190	1	291	23d60403	1980-10-23	2016-06-28 11:09:01-04	2016-01-27 20:08:14-05	23	\N
1191	1	291	3bd6040c	1980-10-22	2016-06-28 11:09:01-04	2015-07-20 11:31:29-04	23	\N
1192	1	245	33d6040d	1980-10-19	2016-06-28 11:09:01-04	2015-03-23 20:14:55-04	23	\N
1193	1	245	2bd6040e	1980-10-18	2016-06-28 11:09:01-04	2016-01-27 20:08:14-05	23	\N
1194	1	238	23d6040f	1980-10-14	2016-06-28 11:09:01-04	2016-01-27 20:08:14-05	23	\N
1195	1	238	3bd60408	1980-10-13	2016-06-28 11:09:01-04	2015-07-14 17:34:39-04	23	\N
1196	1	238	33d60409	1980-10-11	2016-06-28 11:09:01-04	2015-07-20 11:31:30-04	23	\N
1197	1	238	2bd6040a	1980-10-10	2016-06-28 11:09:01-04	2016-01-27 20:08:14-05	23	\N
1198	1	238	23d6040b	1980-10-09	2016-06-28 11:09:01-04	2015-04-24 17:48:42-04	23	\N
1199	1	238	3bd60414	1980-10-07	2016-06-28 11:09:01-04	2015-09-21 16:32:16-04	23	\N
1200	1	238	33d60415	1980-10-06	2016-06-28 11:09:01-04	2016-01-27 20:08:15-05	23	\N
1201	1	238	2bd60416	1980-10-04	2016-06-28 11:09:01-04	2016-01-27 20:08:15-05	23	\N
1202	1	238	23d60417	1980-10-03	2016-06-28 11:09:01-04	2015-04-24 17:47:21-04	23	\N
1203	1	238	3bd60410	1980-10-02	2016-06-28 11:09:01-04	2016-01-27 20:08:15-05	23	\N
1204	1	238	33d60411	1980-09-30	2016-06-28 11:09:01-04	2015-03-23 20:15:32-04	23	\N
1205	1	238	2bd60412	1980-09-29	2016-06-28 11:09:01-04	2015-07-20 11:31:31-04	23	\N
1206	1	238	23d60413	1980-09-27	2016-06-28 11:09:01-04	2016-01-27 20:08:15-05	23	\N
1207	1	238	3bd6041c	1980-09-26	2016-06-28 11:09:01-04	2015-04-24 17:45:44-04	23	\N
1208	1	238	33d6041d	1980-09-25	2016-06-28 11:09:01-04	2016-01-27 20:08:15-05	23	\N
1209	1	292	2bd6041e	1980-09-06	2016-06-28 11:09:01-04	2015-07-20 11:31:32-04	23	\N
1210	1	183	23d6041f	1980-09-04	2016-06-28 11:09:01-04	2015-07-20 11:31:32-04	23	\N
1211	1	212	3bd60418	1980-09-03	2016-06-28 11:09:01-04	2015-03-19 00:08:11-04	23	\N
1212	1	197	33d60419	1980-09-02	2016-06-28 11:09:01-04	2015-09-21 16:32:16-04	23	\N
1213	1	130	2bd6041a	1980-08-31	2016-06-28 11:09:01-04	2015-03-19 00:08:11-04	23	\N
1214	1	124	23d6041b	1980-08-30	2016-06-28 11:09:01-04	2015-07-14 17:34:39-04	23	\N
1215	1	124	3bd60424	1980-08-29	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1216	1	138	33d60425	1980-08-27	2016-06-28 11:09:01-04	2015-07-20 11:31:33-04	23	\N
1217	1	293	2bd60426	1980-08-26	2016-06-28 11:09:01-04	2015-03-19 00:08:11-04	23	\N
1218	1	294	23d60427	1980-08-24	2016-06-28 11:09:01-04	2015-07-20 11:31:33-04	23	\N
1219	1	157	3bd60420	1980-08-23	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1220	1	287	33d60421	1980-08-21	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1221	1	287	2bd60422	1980-08-20	2016-06-28 11:09:01-04	2014-09-16 15:04:28-04	23	\N
1222	1	287	23d60423	1980-08-19	2016-06-28 11:09:01-04	2015-07-20 11:31:33-04	23	\N
1223	1	279	3bd6042c	1980-08-17	2016-06-28 11:09:01-04	2015-03-23 20:15:54-04	23	\N
1224	1	295	33d6042d	1980-08-16	2016-06-28 11:09:01-04	2015-09-21 16:32:16-04	23	\N
1225	1	123	2bd6042e	1980-07-01	2016-06-28 11:09:01-04	2015-07-20 11:31:34-04	23	\N
1226	1	258	23d6042f	1980-06-29	2016-06-28 11:09:01-04	2013-08-26 17:40:00-04	23	\N
1227	1	296	3bd60428	1980-06-21	2016-06-28 11:09:01-04	2015-03-23 20:15:59-04	23	\N
1228	1	296	33d60429	1980-06-20	2016-06-28 11:09:01-04	2013-08-27 01:07:26-04	23	\N
1229	1	296	2bd6042a	1980-06-19	2016-06-28 11:09:01-04	2015-07-20 11:31:34-04	23	\N
1230	1	297	23d6042b	1980-06-14	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1231	1	229	3bd60434	1980-06-13	2016-06-28 11:09:01-04	2015-07-20 11:31:34-04	23	\N
1232	1	230	33d60435	1980-06-12	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1233	1	298	2bd60436	1980-06-08	2016-06-28 11:09:01-04	2015-03-23 20:16:04-04	23	\N
1234	1	298	23d60437	1980-06-07	2016-06-28 11:09:01-04	2013-10-24 11:30:55-04	23	\N
1235	1	239	3bd60430	1980-06-05	2016-06-28 11:09:01-04	2015-07-20 11:31:35-04	23	\N
1236	1	299	33d60431	1980-05-31	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1237	1	300	2bd60432	1980-05-30	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1238	1	262	23d60433	1980-05-29	2016-06-28 11:09:01-04	2013-08-27 01:02:06-04	23	\N
1239	1	119	3bd6043c	1980-05-16	2016-06-28 11:09:01-04	2015-07-20 11:31:35-04	23	\N
1240	1	119	33d6043d	1980-05-15	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1241	1	119	2bd6043e	1980-05-14	2016-06-28 11:09:01-04	2013-08-26 17:50:00-04	23	\N
1242	1	112	23d6043f	1980-05-12	2016-06-28 11:09:01-04	2015-07-20 11:31:35-04	23	\N
1243	1	196	3bd60438	1980-05-11	2016-06-28 11:09:01-04	2014-09-16 15:02:43-04	23	\N
1244	1	153	33d60439	1980-05-10	2016-06-28 11:09:01-04	2015-07-20 11:31:36-04	23	\N
1245	1	252	2bd6043a	1980-05-08	2016-06-28 11:09:01-04	2013-10-24 11:30:55-04	23	\N
1246	1	280	23d6043b	1980-05-07	2016-06-28 11:09:01-04	2014-09-16 15:02:43-04	23	\N
1247	1	301	3bd60444	1980-05-06	2016-06-28 11:09:01-04	2015-07-20 11:31:36-04	23	\N
1248	1	251	33d60445	1980-05-04	2016-06-28 11:09:01-04	2015-03-23 20:16:09-04	23	\N
1249	1	134	2bd60446	1980-05-02	2016-06-28 11:09:01-04	2015-12-15 22:43:27-05	23	\N
1250	1	140	23d60447	1980-05-01	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1251	1	200	3bd60440	1980-04-29	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1252	1	302	33d60441	1980-04-28	2016-06-28 11:09:01-04	2015-07-20 11:31:37-04	23	\N
1253	1	303	2bd60442	1980-04-05	2016-06-28 11:09:01-04	2009-09-11 08:54:49-04	23	\N
1254	1	304	23d60443	1980-04-01	2016-06-28 11:09:01-04	2015-07-20 11:31:37-04	23	\N
1255	1	304	3bd6044c	1980-03-31	2016-06-28 11:09:01-04	2015-03-23 20:16:19-04	23	\N
1256	1	304	33d6044d	1980-03-30	2016-06-28 11:09:01-04	2015-03-19 00:09:52-04	23	\N
1257	1	106	2bd6044e	1980-01-13	2016-06-28 11:09:01-04	2014-09-16 15:02:43-04	23	\N
1258	1	240	23d6044f	1979-12-31	2016-06-28 11:09:01-04	2015-07-20 11:31:37-04	23	\N
1259	1	240	3bd60448	1979-12-30	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1260	1	240	33d60449	1979-12-28	2016-06-28 11:09:01-04	2014-09-16 15:02:43-04	23	\N
1261	1	240	2bd6044a	1979-12-27	2016-06-28 11:09:01-04	2015-07-20 11:31:38-04	23	\N
1262	1	240	23d6044b	1979-12-26	2016-06-28 11:09:01-04	2015-07-14 17:34:39-04	23	\N
1263	1	305	3bd60454	1979-12-11	2016-06-28 11:09:01-04	2015-11-08 18:08:11-05	23	\N
1264	1	305	33d60455	1979-12-10	2016-06-28 11:09:01-04	2015-11-08 18:08:11-05	23	\N
1265	1	249	2bd60456	1979-12-09	2016-06-28 11:09:01-04	2015-03-23 20:16:42-04	23	\N
1266	1	306	23d60457	1979-12-07	2016-06-28 11:09:01-04	2015-10-18 09:53:39-04	23	\N
1267	1	287	3bd60450	1979-12-05	2016-06-28 11:09:01-04	2015-03-23 20:16:48-04	23	\N
1268	1	287	33d60451	1979-12-04	2016-06-28 11:09:01-04	2015-07-20 11:31:39-04	23	\N
1269	1	287	2bd60452	1979-12-03	2016-06-28 11:09:01-04	2015-03-23 20:16:54-04	23	\N
1270	1	285	23d60453	1979-12-01	2016-06-28 11:09:01-04	2015-07-20 11:31:39-04	23	\N
1271	1	285	3bd6045c	1979-11-30	2016-06-28 11:09:01-04	2015-06-01 00:10:15-04	23	\N
1272	1	293	33d6045d	1979-11-29	2016-06-28 11:09:01-04	2015-03-23 20:17:00-04	23	\N
1273	1	258	2bd6045e	1979-11-25	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1274	1	259	23d6045f	1979-11-24	2016-06-28 11:09:01-04	2015-07-20 11:31:39-04	23	\N
1275	1	259	3bd60458	1979-11-23	2016-06-28 11:09:01-04	2015-03-20 22:59:52-04	23	\N
1276	1	166	33d60459	1979-11-10	2016-06-28 11:09:01-04	2015-03-23 20:17:05-04	23	\N
1277	1	275	2bd6045a	1979-11-09	2016-06-28 11:09:01-04	2015-06-01 00:10:15-04	23	\N
1278	1	130	23d6045b	1979-11-08	2016-06-28 11:09:01-04	2015-07-20 11:31:40-04	23	\N
1279	1	124	3bd60464	1979-11-06	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1280	1	124	33d60465	1979-11-05	2016-06-28 11:09:01-04	2015-07-20 11:31:40-04	23	\N
1281	1	183	2bd60466	1979-11-04	2016-06-28 11:09:01-04	2015-03-19 13:40:28-04	23	\N
1282	1	119	23d60467	1979-11-02	2016-06-28 11:09:01-04	2013-08-15 14:57:03-04	23	\N
1283	1	119	3bd60460	1979-11-01	2016-06-28 11:09:01-04	2015-03-23 20:17:10-04	23	\N
1284	1	119	33d60461	1979-10-31	2016-06-28 11:09:01-04	2015-07-20 11:31:41-04	23	\N
1285	1	307	2bd60462	1979-10-28	2016-06-28 11:09:01-04	2015-07-20 11:31:41-04	23	\N
1286	1	307	23d60463	1979-10-27	2016-06-28 11:09:01-04	2015-06-01 00:10:15-04	23	\N
1287	1	219	3bd6046c	1979-10-25	2016-06-28 11:09:02-04	2015-03-19 00:09:52-04	23	\N
1288	1	212	33d6046d	1979-10-24	2016-06-28 11:09:02-04	2015-03-23 20:17:19-04	23	\N
1289	1	110	2bd6046e	1979-09-06	2016-06-28 11:09:02-04	2015-07-20 11:31:41-04	23	\N
1290	1	110	23d6046f	1979-09-05	2016-06-28 11:09:02-04	2015-03-19 00:09:52-04	23	\N
1291	1	110	3bd60468	1979-09-04	2016-06-28 11:09:02-04	2015-07-20 11:31:41-04	23	\N
1292	1	214	33d60469	1979-09-02	2016-06-28 11:09:02-04	2015-03-23 20:17:24-04	23	\N
1293	1	308	2bd6046a	1979-09-01	2016-06-28 11:09:02-04	2015-03-19 13:40:28-04	23	\N
1294	1	252	23d6046b	1979-08-31	2016-06-28 11:09:02-04	2015-03-19 00:09:52-04	23	\N
1295	1	109	3bd60474	1979-08-14	2016-06-28 11:09:02-04	2015-03-23 20:17:30-04	23	\N
1296	1	109	33d60475	1979-08-13	2016-06-28 11:09:02-04	2015-03-19 13:40:28-04	23	\N
1297	1	187	2bd60476	1979-08-12	2016-06-28 11:09:02-04	2015-07-20 11:31:42-04	23	\N
1298	1	240	23d60477	1979-08-05	2016-06-28 11:09:02-04	2015-03-19 13:40:28-04	23	\N
1299	1	240	3bd60470	1979-08-04	2016-06-28 11:09:02-04	2015-03-23 20:17:36-04	23	\N
1300	1	229	33d60471	1979-07-01	2016-06-28 11:09:02-04	2015-03-23 20:17:41-04	23	\N
1301	1	309	2bd60472	1979-06-30	2016-06-28 11:09:02-04	2015-03-19 13:40:28-04	23	\N
1302	1	310	23d60473	1979-06-28	2016-06-28 11:09:02-04	2015-03-23 20:17:47-04	23	\N
1303	1	196	3bd6047c	1979-05-13	2016-06-28 11:09:02-04	2014-03-14 10:09:57-04	23	\N
1304	1	311	33d6047d	1979-05-12	2016-06-28 11:09:02-04	2015-03-23 20:17:53-04	23	\N
1305	1	312	2bd6047e	1979-05-11	2016-06-28 11:09:02-04	2015-03-19 00:09:52-04	23	\N
1306	1	236	23d6047f	1979-05-09	2016-06-28 11:09:02-04	2015-07-20 11:31:42-04	23	\N
1307	1	301	3bd60478	1979-05-08	2016-06-28 11:09:02-04	2015-03-23 20:18:00-04	23	\N
1308	1	313	33d60479	1979-05-07	2016-06-28 11:09:02-04	2015-03-20 23:00:25-04	23	\N
1309	1	251	2bd6047a	1979-05-05	2016-06-28 11:09:02-04	2015-06-01 00:10:15-04	23	\N
1310	1	134	23d6047b	1979-05-04	2016-06-28 11:09:02-04	2015-12-15 22:43:27-05	23	\N
1311	1	104	1bd60584	1979-05-03	2016-06-28 11:09:02-04	2015-03-23 20:18:10-04	23	\N
1312	1	314	13d60585	1979-04-22	2016-06-28 11:09:02-04	2015-03-20 23:00:31-04	23	\N
1313	1	315	bd60586	1979-04-16	2016-06-28 11:09:02-04	2013-07-23 09:52:26-04	23	\N
1314	1	106	3d60587	1979-02-17	2016-06-28 11:09:02-04	2014-09-16 15:02:43-04	23	\N
1315	1	249	1bd60580	1979-02-11	2016-06-28 11:09:02-04	2015-07-20 11:31:43-04	23	\N
1316	1	305	13d60581	1979-02-10	2016-06-28 11:09:02-04	2015-11-08 18:08:11-05	23	\N
1317	1	305	bd60582	1979-02-09	2016-06-28 11:09:02-04	2015-11-08 18:08:11-05	23	\N
1318	1	316	3d60583	1979-02-07	2016-06-28 11:09:02-04	2015-06-01 00:10:15-04	23	\N
1319	1	317	1bd6058c	1979-02-06	2016-06-28 11:09:02-04	2015-07-20 11:31:44-04	23	\N
1320	1	233	13d6058d	1979-02-04	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1321	1	263	bd6058e	1979-02-03	2016-06-28 11:09:02-04	2015-07-20 11:31:44-04	23	\N
1322	1	318	3d6058f	1979-01-21	2016-06-28 11:09:02-04	2015-03-23 20:18:27-04	23	\N
1323	1	319	1bd60588	1979-01-20	2016-06-28 11:09:02-04	2015-03-20 23:00:43-04	23	\N
1324	1	183	13d60589	1979-01-18	2016-06-28 11:09:02-04	2014-03-14 10:09:57-04	23	\N
1325	1	219	bd6058a	1979-01-17	2016-06-28 11:09:02-04	2015-03-20 23:00:45-04	23	\N
1326	1	212	3d6058b	1979-01-15	2016-06-28 11:09:02-04	2015-03-20 23:00:47-04	23	\N
1327	1	283	1bd60594	1979-01-14	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1328	1	124	13d60595	1979-01-12	2016-06-28 11:09:02-04	2016-01-27 20:08:15-05	23	\N
1329	1	119	bd60596	1979-01-11	2016-06-28 11:09:02-04	2015-03-19 13:40:28-04	23	\N
1330	1	119	3d60597	1979-01-10	2016-06-28 11:09:02-04	2015-03-20 23:00:53-04	23	\N
1331	1	110	1bd60590	1979-01-08	2016-06-28 11:09:02-04	2015-03-23 20:18:37-04	23	\N
1332	1	110	13d60591	1979-01-07	2016-06-28 11:09:02-04	2015-03-20 23:00:56-04	23	\N
1333	1	124	bd60592	1979-01-05	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1334	1	320	3d60593	1978-12-31	2016-06-28 11:09:02-04	2015-03-23 20:18:45-04	23	\N
1335	1	258	1bd6059c	1978-12-30	2016-06-28 11:09:02-04	2015-03-20 23:01:07-04	23	\N
1336	1	259	13d6059d	1978-12-28	2016-06-28 11:09:02-04	2016-03-25 09:42:01-04	23	\N
1337	1	259	bd6059e	1978-12-27	2016-06-28 11:09:02-04	2015-03-23 20:18:50-04	23	\N
1338	1	321	3d6059f	1978-12-22	2016-06-28 11:09:02-04	2015-03-20 23:01:13-04	23	\N
1339	1	171	1bd60598	1978-12-21	2016-06-28 11:09:02-04	2015-03-20 23:01:16-04	23	\N
1340	1	322	13d60599	1978-12-19	2016-06-28 11:09:02-04	2015-03-20 23:01:20-04	23	\N
1341	1	200	bd6059a	1978-12-17	2016-06-28 11:09:02-04	2015-03-20 23:01:23-04	23	\N
1342	1	323	3d6059b	1978-12-16	2016-06-28 11:09:02-04	2015-03-23 20:18:56-04	23	\N
1343	1	302	1bd605a4	1978-12-15	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1344	1	324	13d605a5	1978-12-13	2016-06-28 11:09:02-04	2014-09-16 15:02:43-04	23	\N
1345	1	325	bd605a6	1978-12-12	2016-06-28 11:09:02-04	2015-12-12 19:38:22-05	23	\N
1346	1	304	3d605a7	1978-11-24	2016-06-28 11:09:02-04	2015-03-20 23:01:32-04	23	\N
1347	1	130	1bd605a0	1978-11-23	2016-06-28 11:09:02-04	2015-06-01 00:10:14-04	23	\N
1348	1	197	13d605a1	1978-11-21	2016-06-28 11:09:02-04	2015-03-20 23:01:39-04	23	\N
1349	1	286	bd605a2	1978-11-20	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1350	1	287	3d605a3	1978-11-18	2016-06-28 11:09:02-04	2015-03-20 23:01:44-04	23	\N
1351	1	287	1bd605ac	1978-11-17	2016-06-28 11:09:02-04	2015-03-19 00:09:53-04	23	\N
1352	1	287	13d605ad	1978-11-16	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1353	1	326	bd605ae	1978-11-14	2016-06-28 11:09:02-04	2015-03-20 23:01:51-04	23	\N
1354	1	326	3d605af	1978-11-13	2016-06-28 11:09:02-04	2015-03-23 20:19:13-04	23	\N
1355	1	327	1bd605a8	1978-11-11	2016-06-28 11:09:02-04	2012-08-06 09:30:35-04	23	\N
1356	1	320	13d605a9	1978-10-22	2016-06-28 11:09:02-04	2015-03-23 20:19:20-04	23	\N
1357	1	320	bd605aa	1978-10-21	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1358	1	320	3d605ab	1978-10-20	2016-06-28 11:09:02-04	2015-06-01 00:10:15-04	23	\N
1359	1	320	1bd605b4	1978-10-18	2016-06-28 11:09:02-04	2015-03-23 20:19:28-04	23	\N
1360	1	320	13d605b5	1978-10-17	2016-06-28 11:09:02-04	2015-03-20 23:02:03-04	23	\N
1361	1	328	bd605b6	1978-09-16	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1362	1	328	3d605b7	1978-09-15	2016-06-28 11:09:02-04	2015-03-20 23:02:05-04	23	\N
1363	1	328	1bd605d4	1978-09-14	2016-06-28 11:09:02-04	2015-10-31 14:16:22-04	23	\N
1364	1	94	13d605d5	1978-09-02	2016-06-28 11:09:02-04	2015-03-20 23:02:08-04	23	\N
1365	1	187	1bd605b0	1978-08-31	2016-06-28 11:09:02-04	2015-03-23 20:19:39-04	23	\N
1366	1	187	bd605d6	1978-08-30	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1367	1	187	3d605d7	1978-07-08	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1368	1	187	13d605b1	1978-07-07	2016-06-28 11:09:02-04	2016-05-15 19:05:51-04	23	\N
1369	1	329	bd605b2	1978-07-05	2016-06-28 11:09:02-04	2016-05-01 22:03:37-04	23	\N
1370	1	232	3d605b3	1978-07-03	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1371	1	330	1bd605bc	1978-07-01	2016-06-28 11:09:02-04	2015-03-19 13:40:29-04	23	\N
1372	1	115	13d605bd	1978-06-25	2016-06-28 11:09:02-04	2015-03-23 20:19:55-04	23	\N
1373	1	331	bd605be	1978-06-04	2016-06-28 11:09:02-04	2015-03-23 20:20:02-04	23	\N
1374	1	287	3d605bf	1978-05-17	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1375	1	287	1bd605b8	1978-05-16	2016-06-28 11:09:02-04	2015-03-19 00:09:53-04	23	\N
1376	1	183	13d605b9	1978-05-14	2016-06-28 11:09:02-04	2016-01-27 20:08:16-05	23	\N
1377	1	124	bd605ba	1978-05-13	2016-06-28 11:09:02-04	2015-03-19 00:09:53-04	23	\N
1378	1	212	3d605bb	1978-05-11	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1379	1	219	1bd605c4	1978-05-10	2016-06-28 11:09:02-04	2016-01-27 20:08:17-05	23	\N
1380	1	253	13d605c5	1978-05-09	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1381	1	332	bd605c6	1978-05-07	2016-06-28 11:09:02-04	2016-03-25 09:42:01-04	23	\N
1382	1	235	3d605c7	1978-05-06	2016-06-28 11:09:02-04	2016-01-27 20:08:17-05	23	\N
1383	1	333	1bd605c0	1978-05-05	2016-06-28 11:09:02-04	2013-07-06 21:59:03-04	23	\N
1384	1	334	13d605c1	1978-04-24	2016-06-28 11:09:02-04	2016-01-27 20:08:17-05	23	\N
1385	1	323	bd605c2	1978-04-22	2016-06-28 11:09:02-04	2016-01-27 20:08:18-05	23	\N
1386	1	335	3d605c3	1978-04-21	2016-06-28 11:09:02-04	2016-03-25 09:42:01-04	23	\N
1387	1	336	1bd605cc	1978-04-19	2016-06-28 11:09:02-04	2016-01-27 20:08:18-05	23	\N
1388	1	167	13d605cd	1978-04-18	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1389	1	337	bd605ce	1978-04-16	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1390	1	338	3d605cf	1978-04-15	2016-06-28 11:09:02-04	2014-09-16 15:02:43-04	23	\N
1391	1	339	1bd605c8	1978-04-14	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1392	1	255	13d605c9	1978-04-12	2016-06-28 11:09:02-04	2016-03-25 09:42:01-04	23	\N
1393	1	200	bd605ca	1978-04-11	2016-06-28 11:09:02-04	2015-09-21 16:32:16-04	23	\N
1394	1	200	3d605cb	1978-04-10	2016-06-28 11:09:02-04	2015-06-01 00:10:12-04	23	\N
1395	1	340	1bd605d0	1978-04-08	2016-06-28 11:09:03-04	2016-01-27 20:08:18-05	23	\N
1396	1	202	13d605d1	1978-04-07	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1397	1	324	bd605d2	1978-04-06	2016-06-28 11:09:03-04	2016-01-27 20:08:18-05	23	\N
1398	1	341	3d605d3	1978-02-05	2016-06-28 11:09:03-04	2015-03-23 20:21:14-04	23	\N
1399	1	300	1bd605dc	1978-02-04	2016-06-28 11:09:03-04	2015-06-01 00:10:12-04	23	\N
1400	1	233	13d605dd	1978-02-03	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1401	1	287	bd605de	1978-02-01	2016-06-28 11:09:03-04	2016-01-27 20:08:18-05	23	\N
1402	1	287	3d605df	1978-01-31	2016-06-28 11:09:03-04	2015-03-23 20:21:30-04	23	\N
1403	1	287	1bd605d8	1978-01-30	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1404	1	277	13d605d9	1978-01-22	2016-06-28 11:09:03-04	2015-03-23 20:21:37-04	23	\N
1405	1	342	bd605da	1978-01-18	2016-06-28 11:09:03-04	2015-03-19 13:40:29-04	23	\N
1406	1	310	3d605db	1978-01-17	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1407	1	343	1bd605e4	1978-01-15	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1408	1	344	13d605e5	1978-01-14	2016-06-28 11:09:03-04	2015-03-23 20:21:47-04	23	\N
1409	1	345	bd605e6	1978-01-13	2016-06-28 11:09:03-04	2015-06-01 00:10:15-04	23	\N
1410	1	346	3d605e7	1978-01-11	2016-06-28 11:09:03-04	2015-03-23 20:21:52-04	23	\N
1411	1	346	1bd605e0	1978-01-10	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1412	1	259	13d605e1	1978-01-08	2016-06-28 11:09:03-04	2015-03-23 20:21:58-04	23	\N
1413	1	259	bd605e2	1978-01-07	2016-06-28 11:09:03-04	2015-06-01 00:10:12-04	23	\N
1414	1	288	3d605e3	1978-01-06	2016-06-28 11:09:03-04	2014-09-16 15:02:43-04	23	\N
1415	1	320	1bd605ec	1977-12-31	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1416	1	320	13d605ed	1977-12-30	2016-06-28 11:09:03-04	2015-03-23 20:22:10-04	23	\N
1417	1	320	bd605ee	1977-12-29	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1418	1	320	3d605ef	1977-12-27	2016-06-28 11:09:03-04	2015-03-23 20:22:17-04	23	\N
1419	1	236	1bd605e8	1977-11-06	2016-06-28 11:09:03-04	2015-03-23 20:22:25-04	23	\N
1420	1	197	13d605e9	1977-11-05	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1421	1	347	bd605ea	1977-11-04	2016-06-28 11:09:03-04	2016-01-27 20:08:19-05	23	\N
1422	1	348	3d605eb	1977-11-02	2016-06-28 11:09:03-04	2015-03-23 20:22:43-04	23	\N
1423	1	349	1bd605f4	1977-11-01	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1424	1	350	13d605f5	1977-10-30	2016-06-28 11:09:03-04	2015-03-23 20:22:49-04	23	\N
1425	1	351	bd605f6	1977-10-29	2016-06-28 11:09:03-04	2016-01-27 20:08:20-05	23	\N
1426	1	305	3d605f7	1977-10-28	2016-06-28 11:09:03-04	2015-11-08 18:08:11-05	23	\N
1427	1	352	1bd605f0	1977-10-16	2016-06-28 11:09:03-04	2013-07-13 21:12:34-04	23	\N
1428	1	353	13d605f1	1977-10-15	2016-06-28 11:09:03-04	2015-03-23 20:23:01-04	23	\N
1429	1	354	bd605f2	1977-10-14	2016-06-28 11:09:03-04	2015-03-19 13:40:29-04	23	\N
1430	1	206	3d605f3	1977-10-12	2016-06-28 11:09:03-04	2015-09-21 16:32:16-04	23	\N
1431	1	355	1bd605fc	1977-10-11	2016-06-28 11:09:03-04	2015-06-01 00:10:12-04	23	\N
1432	1	109	13d605fd	1977-10-09	2016-06-28 11:09:03-04	2015-03-23 20:23:14-04	23	\N
1433	1	356	bd605fe	1977-10-07	2016-06-28 11:09:03-04	2015-09-21 16:32:16-04	23	\N
1434	1	357	3d605ff	1977-10-06	2016-06-28 11:09:03-04	2013-10-09 15:05:05-04	23	\N
1435	1	358	1bd605f8	1977-10-02	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1436	1	358	13d605f9	1977-10-01	2016-06-28 11:09:03-04	2016-01-27 20:08:20-05	23	\N
1437	1	359	bd605fa	1977-09-29	2016-06-28 11:09:03-04	2015-03-23 20:23:31-04	23	\N
1438	1	359	3d605fb	1977-09-28	2016-06-28 11:09:03-04	2015-03-19 13:40:29-04	23	\N
1439	1	360	6bd7c22e	1977-09-03	2016-06-28 11:09:03-04	2015-03-23 20:23:36-04	23	\N
1440	1	320	13d60505	1977-06-09	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1441	1	320	bd60506	1977-06-08	2016-06-28 11:09:03-04	2014-03-14 10:09:57-04	23	\N
1442	1	320	3d60507	1977-06-07	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1443	1	361	1bd60500	1977-06-04	2016-06-28 11:09:03-04	2015-03-23 20:23:59-04	23	\N
1444	1	153	13d60501	1977-05-28	2016-06-28 11:09:03-04	2015-03-23 20:24:06-04	23	\N
1445	1	251	bd60502	1977-05-26	2016-06-28 11:09:03-04	2015-03-23 20:24:12-04	23	\N
1446	1	362	3d60503	1977-05-25	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1447	1	202	1bd6050c	1977-05-22	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1448	1	243	13d6050d	1977-05-21	2016-06-28 11:09:03-04	2015-03-23 20:24:27-04	23	\N
1449	1	200	bd6050e	1977-05-19	2016-06-28 11:09:03-04	2015-06-01 00:10:12-04	23	\N
1450	1	200	3d6050f	1977-05-18	2016-06-28 11:09:03-04	2016-01-27 20:08:20-05	23	\N
1451	1	363	1bd60508	1977-05-17	2016-06-28 11:09:03-04	2015-03-23 20:24:41-04	23	\N
1452	1	364	13d60509	1977-05-15	2016-06-28 11:09:03-04	2016-03-25 09:42:01-04	23	\N
1453	1	365	bd6050a	1977-05-13	2016-06-28 11:09:03-04	2015-03-23 20:24:55-04	23	\N
1454	1	365	3d6050b	1977-05-12	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1455	1	232	1bd60514	1977-05-11	2016-06-28 11:09:03-04	2015-03-23 20:25:09-04	23	\N
1456	1	275	13d60515	1977-05-09	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1457	1	280	bd60516	1977-05-08	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1458	1	112	3d60517	1977-05-07	2016-06-28 11:09:03-04	2015-03-23 20:25:15-04	23	\N
1459	1	219	1bd60510	1977-05-05	2016-06-28 11:09:03-04	2015-03-19 00:09:53-04	23	\N
1460	1	366	13d60511	1977-05-04	2016-06-28 11:09:03-04	2016-01-27 20:08:20-05	23	\N
1461	1	366	bd60512	1977-05-03	2016-06-28 11:09:03-04	2015-03-23 20:25:22-04	23	\N
1462	1	366	3d60513	1977-05-01	2016-06-28 11:09:03-04	2016-01-27 20:08:20-05	23	\N
1463	1	366	1bd6051c	1977-04-30	2016-06-28 11:09:03-04	2015-03-19 13:40:29-04	23	\N
1464	1	366	13d6051d	1977-04-29	2016-06-28 11:09:03-04	2015-03-23 20:25:35-04	23	\N
1465	1	304	bd6051e	1977-04-27	2016-06-28 11:09:03-04	2015-03-23 20:25:40-04	23	\N
1466	1	304	3d6051f	1977-04-26	2016-06-28 11:09:03-04	2016-01-27 20:08:21-05	23	\N
1467	1	304	1bd60518	1977-04-25	2016-06-28 11:09:03-04	2015-03-23 20:25:52-04	23	\N
1468	1	212	13d60519	1977-04-23	2016-06-28 11:09:03-04	2015-08-30 19:09:33-04	23	\N
1469	1	124	bd6051a	1977-04-22	2016-06-28 11:09:03-04	2016-01-27 20:08:21-05	23	\N
1470	1	320	3d6051b	1977-03-20	2016-06-28 11:09:03-04	2015-10-06 00:54:44-04	23	\N
1471	1	320	1bd60524	1977-03-19	2016-06-28 11:09:03-04	2015-10-06 00:53:19-04	23	\N
1472	1	320	13d60525	1977-03-18	2016-06-28 11:09:03-04	2015-10-06 00:47:00-04	23	\N
1473	1	367	bd60526	1977-02-27	2016-06-28 11:09:03-04	2015-10-06 00:51:13-04	23	\N
1474	1	288	3d60527	1977-02-26	2016-06-28 11:09:03-04	2015-10-06 00:53:57-04	23	\N
1475	1	368	1bd60520	1976-12-31	2016-06-28 11:09:03-04	2015-03-23 20:26:38-04	23	\N
1476	1	346	13d60521	1976-10-15	2016-06-28 11:09:03-04	2016-01-27 20:08:21-05	23	\N
1477	1	346	bd60522	1976-10-14	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1478	1	160	3d60523	1976-10-10	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1479	1	160	1bd6052c	1976-10-09	2016-06-28 11:09:03-04	2015-03-23 20:27:08-04	23	\N
1480	1	349	13d6052d	1976-10-03	2016-06-28 11:09:03-04	2016-01-27 20:08:21-05	23	\N
1481	1	165	bd6052e	1976-10-02	2016-06-28 11:09:03-04	2016-01-27 20:08:22-05	23	\N
1482	1	263	3d6052f	1976-10-01	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1483	1	369	1bd60528	1976-09-30	2016-06-28 11:09:03-04	2016-01-27 20:08:22-05	23	\N
1484	1	253	13d60529	1976-09-28	2016-06-28 11:09:03-04	2015-06-01 00:10:22-04	23	\N
1485	1	197	bd6052a	1976-09-27	2016-06-28 11:09:03-04	2015-03-23 20:27:49-04	23	\N
1486	1	130	bdcb5a6	1976-09-25	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1487	1	338	3d6052b	1976-09-24	2016-06-28 11:09:03-04	2015-03-23 20:27:57-04	23	\N
1488	1	255	13d60535	1976-09-23	2016-06-28 11:09:03-04	2016-01-27 20:08:22-05	23	\N
1489	1	370	bd60536	1976-08-04	2016-06-28 11:09:03-04	2016-01-27 20:08:22-05	23	\N
1490	1	371	3d60537	1976-08-02	2016-06-28 11:09:03-04	2015-03-23 20:28:22-04	23	\N
1491	1	372	1bd60530	1976-07-18	2016-06-28 11:09:03-04	2015-03-23 20:28:32-04	23	\N
1492	1	372	13d60531	1976-07-17	2016-06-28 11:09:03-04	2015-03-23 20:28:39-04	23	\N
1493	1	372	bd60532	1976-07-16	2016-06-28 11:09:03-04	2015-03-23 20:28:48-04	23	\N
1494	1	372	3d60533	1976-07-14	2016-06-28 11:09:03-04	2015-03-23 20:28:55-04	23	\N
1495	1	372	1bd6053c	1976-07-13	2016-06-28 11:09:03-04	2016-01-27 20:08:22-05	23	\N
1496	1	372	13d6053d	1976-07-12	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1497	1	365	bd6053e	1976-06-29	2016-06-28 11:09:03-04	2015-03-23 20:29:18-04	23	\N
1498	1	365	3d6053f	1976-06-28	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1499	1	365	1bd60538	1976-06-27	2016-06-28 11:09:03-04	2015-03-23 20:29:25-04	23	\N
1500	1	365	13d60539	1976-06-26	2016-06-28 11:09:03-04	2015-03-23 20:29:33-04	23	\N
1501	1	373	bd6053a	1976-06-24	2016-06-28 11:09:03-04	2016-01-27 20:08:23-05	23	\N
1502	1	373	3d6053b	1976-06-23	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1503	1	373	1bd60544	1976-06-22	2016-06-28 11:09:03-04	2015-06-01 00:10:13-04	23	\N
1504	1	373	13d60545	1976-06-21	2016-06-28 11:09:03-04	2016-01-27 20:08:23-05	23	\N
1505	1	304	bd60546	1976-06-19	2016-06-28 11:09:03-04	2015-06-01 00:10:14-04	23	\N
1506	1	304	3d60547	1976-06-18	2016-06-28 11:09:04-04	2015-03-23 20:30:19-04	23	\N
1507	1	304	1bd60540	1976-06-17	2016-06-28 11:09:04-04	2015-06-01 00:10:14-04	23	\N
1508	1	374	13d60541	1976-06-15	2016-06-28 11:09:04-04	2016-01-27 20:08:23-05	23	\N
1509	1	374	bd60542	1976-06-14	2016-06-28 11:09:04-04	2015-06-01 00:10:14-04	23	\N
1510	1	326	3d60543	1976-06-12	2016-06-28 11:09:04-04	2015-06-01 00:10:14-04	23	\N
1511	1	326	1bd6054c	1976-06-11	2016-06-28 11:09:04-04	2016-01-27 20:08:23-05	23	\N
1512	1	326	13d6054d	1976-06-10	2016-06-28 11:09:04-04	2015-06-01 00:10:14-04	23	\N
1513	1	326	bd6054e	1976-06-09	2016-06-28 11:09:04-04	2016-01-27 20:08:23-05	23	\N
1514	1	358	3d6054f	1976-06-04	2016-06-28 11:09:04-04	2015-06-01 00:10:14-04	23	\N
1515	1	358	1bd60548	1976-06-03	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1516	1	135	13d60549	1975-09-28	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1517	1	375	bd6054a	1975-08-13	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1518	1	320	3d6054b	1975-06-17	2016-06-28 11:09:04-04	2015-03-19 13:40:29-04	23	\N
1519	1	376	1bd60554	1975-03-23	2016-06-28 11:09:04-04	2009-09-11 09:37:53-04	23	\N
1520	1	320	13d60555	1974-10-20	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1521	1	320	bd60556	1974-10-19	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1522	1	320	3d60557	1974-10-18	2016-06-28 11:09:04-04	2015-03-19 00:09:54-04	23	\N
1523	1	320	1bd60550	1974-10-17	2016-06-28 11:09:04-04	2016-01-27 20:08:24-05	23	\N
1524	1	320	13d60551	1974-10-16	2016-06-28 11:09:04-04	2016-01-27 20:08:25-05	23	\N
1525	1	377	bd60552	1974-09-21	2016-06-28 11:09:04-04	2015-03-19 13:40:29-04	29	\N
1526	1	377	3d60553	1974-09-20	2016-06-28 11:09:04-04	2016-01-27 20:08:25-05	29	\N
1527	1	378	1bd6055c	1974-09-18	2016-06-28 11:09:04-04	2015-04-07 10:14:10-04	29	\N
1528	1	270	13d6055d	1974-09-14	2016-06-28 11:09:04-04	2016-01-27 20:08:25-05	29	\N
1529	1	379	bd6055e	1974-09-11	2016-06-28 11:09:04-04	2016-01-27 20:08:26-05	29	\N
1530	1	379	3d6055f	1974-09-10	2016-06-28 11:09:04-04	2015-07-20 11:31:46-04	29	\N
1531	1	379	1bd60558	1974-09-09	2016-06-28 11:09:04-04	2016-01-27 20:08:26-05	29	\N
1532	1	370	13d60559	1974-08-06	2016-06-28 11:09:04-04	2015-03-19 13:40:29-04	30	\N
1533	1	220	bd6055a	1974-08-05	2016-06-28 11:09:04-04	2016-01-27 20:08:26-05	30	\N
1534	1	220	3d6055b	1974-08-04	2016-06-28 11:09:04-04	2016-01-27 20:08:26-05	30	\N
1535	1	380	1bd60564	1974-07-31	2016-06-28 11:09:04-04	2016-01-27 20:08:27-05	30	\N
1536	1	130	13d60565	1974-07-29	2016-06-28 11:09:04-04	2016-01-27 20:08:27-05	30	\N
1537	1	189	bd60566	1974-07-27	2016-06-28 11:09:04-04	2016-01-27 20:08:27-05	30	\N
1538	1	381	3d60567	1974-07-25	2016-06-28 11:09:04-04	2016-01-27 20:08:27-05	30	\N
1539	1	382	1bd60560	1974-07-21	2016-06-28 11:09:04-04	2016-01-27 20:08:27-05	30	\N
1540	1	343	13d60561	1974-07-19	2016-06-28 11:09:04-04	2016-01-27 20:08:28-05	30	\N
1541	1	212	bd60562	1974-06-30	2016-06-28 11:09:04-04	2015-07-20 11:31:48-04	30	\N
1542	1	112	3d60563	1974-06-28	2016-06-28 11:09:04-04	2016-01-27 20:08:28-05	30	\N
1543	1	183	1bd6056c	1974-06-26	2016-06-28 11:09:04-04	2016-01-27 20:08:28-05	30	\N
1544	1	325	13d6056d	1974-06-23	2016-06-28 11:09:04-04	2014-11-18 18:12:50-05	30	\N
1545	1	325	bd6056e	1974-06-22	2016-06-28 11:09:04-04	2016-01-27 20:08:28-05	30	\N
1546	1	103	3d6056f	1974-06-20	2016-06-28 11:09:04-04	2016-01-27 20:08:28-05	30	\N
1547	1	125	1bd60568	1974-06-18	2016-06-28 11:09:04-04	2016-01-27 20:08:29-05	30	\N
1548	1	383	13d60569	1974-06-16	2016-06-28 11:09:04-04	2016-01-27 20:08:29-05	30	\N
1549	1	160	bd6056a	1974-06-08	2016-06-28 11:09:04-04	2016-01-27 20:08:29-05	31	\N
1550	1	331	3d6056b	1974-05-25	2016-06-28 11:09:04-04	2015-07-20 11:31:50-04	31	\N
1551	1	384	1bd60574	1974-05-21	2016-06-28 11:09:04-04	2016-01-27 20:08:29-05	31	\N
1552	1	230	13d60575	1974-05-19	2016-06-28 11:09:04-04	2016-02-21 17:33:06-05	31	\N
1553	1	385	bd60576	1974-05-17	2016-06-28 11:09:04-04	2016-01-27 20:08:30-05	31	\N
1554	1	386	3d60577	1974-05-14	2016-06-28 11:09:04-04	2016-01-27 20:08:30-05	31	\N
1555	1	387	1bd60570	1974-05-12	2016-06-28 11:09:04-04	2016-01-27 20:08:30-05	31	\N
1556	1	368	13d60571	1974-03-23	2016-06-28 11:09:04-04	2016-01-27 20:08:31-05	23	\N
1557	1	320	bd60572	1974-02-24	2016-06-28 11:09:04-04	2016-01-27 20:08:31-05	23	\N
1558	1	320	3d60573	1974-02-23	2016-06-28 11:09:04-04	2015-03-19 13:40:30-04	23	\N
1559	1	320	1bd6057c	1974-02-22	2016-06-28 11:09:04-04	2016-01-27 20:08:31-05	23	\N
1560	1	324	13d6057d	1973-12-19	2016-06-28 11:09:04-04	2015-03-18 17:41:36-04	23	\N
1561	1	324	bd6057e	1973-12-18	2016-06-28 11:09:04-04	2015-07-20 11:31:53-04	23	\N
1562	1	103	3d6057f	1973-12-12	2016-06-28 11:09:04-04	2015-07-20 11:31:53-04	23	\N
1563	1	104	1bd60578	1973-12-10	2016-06-28 11:09:04-04	2015-07-20 11:31:54-04	23	\N
1564	1	255	13d60579	1973-12-08	2016-06-28 11:09:04-04	2015-07-20 11:31:54-04	23	\N
1565	1	293	bd6057a	1973-12-06	2016-06-28 11:09:04-04	2015-07-20 11:31:54-04	23	\N
1566	1	388	3d6057b	1973-12-04	2016-06-28 11:09:04-04	2015-07-20 11:31:55-04	23	\N
1567	1	326	7bd60a84	1973-12-02	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1568	1	326	73d60a85	1973-12-01	2016-06-28 11:09:04-04	2015-07-20 11:31:55-04	23	\N
1569	1	326	6bd60a86	1973-11-30	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1570	1	389	63d60a87	1973-11-25	2016-06-28 11:09:04-04	2015-07-20 11:31:56-04	23	\N
1571	1	390	7bd60a80	1973-11-23	2016-06-28 11:09:04-04	2015-07-20 11:31:56-04	23	\N
1572	1	391	73d60a81	1973-11-21	2016-06-28 11:09:04-04	2015-03-19 13:40:30-04	23	\N
1573	1	391	6bd60a82	1973-11-20	2016-06-28 11:09:04-04	2015-07-20 11:31:56-04	23	\N
1574	1	258	63d60a83	1973-11-17	2016-06-28 11:09:04-04	2015-07-20 11:31:57-04	23	\N
1575	1	123	7bd60a8c	1973-11-14	2016-06-28 11:09:04-04	2015-07-20 11:31:57-04	23	\N
1576	1	320	73d60a8d	1973-11-11	2016-06-28 11:09:04-04	2015-07-20 11:31:58-04	23	\N
1577	1	320	6bd60a8e	1973-11-10	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1578	1	320	63d60a8f	1973-11-09	2016-06-28 11:09:04-04	2015-07-20 11:31:58-04	23	\N
1579	1	392	7bd60a88	1973-11-01	2016-06-28 11:09:04-04	2014-09-16 15:02:44-04	23	\N
1580	1	249	73d60a89	1973-10-30	2016-06-28 11:09:04-04	2015-07-20 11:31:58-04	23	\N
1581	1	249	6bd60a8a	1973-10-29	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1582	1	393	63d60a8b	1973-10-27	2016-06-28 11:09:04-04	2015-07-20 11:31:59-04	23	\N
1583	1	233	7bd60a94	1973-10-25	2016-06-28 11:09:04-04	2015-07-20 11:31:59-04	23	\N
1584	1	299	73d60a95	1973-10-23	2016-06-28 11:09:04-04	2015-07-20 11:32:00-04	23	\N
1585	1	329	6bd60a96	1973-10-21	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1586	1	394	63d60a97	1973-10-19	2016-06-28 11:09:04-04	2016-01-21 16:36:32-05	23	\N
1587	1	275	7bd60a90	1973-09-26	2016-06-28 11:09:04-04	2015-07-20 11:32:01-04	23	\N
1588	1	167	73d60a91	1973-09-24	2016-06-28 11:09:04-04	2015-07-20 11:32:01-04	23	\N
1589	1	124	6bd60a92	1973-09-21	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1590	1	124	63d60a93	1973-09-20	2016-06-28 11:09:04-04	2015-07-20 11:32:02-04	23	\N
1591	1	253	73d60a9d	1973-09-17	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1592	1	183	6bd60a9e	1973-09-15	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1593	1	338	63d60a9f	1973-09-12	2016-06-28 11:09:04-04	2015-04-29 08:11:23-04	23	\N
1594	1	338	7bd60a98	1973-09-11	2016-06-28 11:09:04-04	2015-07-20 11:32:02-04	23	\N
1595	1	119	73d60a99	1973-09-08	2016-06-28 11:09:04-04	2015-07-20 11:32:03-04	23	\N
1596	1	119	6bd60a9a	1973-09-07	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1597	1	370	63d60a9b	1973-08-01	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1598	1	370	7bd60aa4	1973-07-31	2016-06-28 11:09:04-04	2015-07-20 11:32:03-04	23	\N
1599	1	395	73d60aa5	1973-07-28	2016-06-28 11:09:04-04	2015-07-29 00:30:45-04	23	\N
1600	1	395	6bd60aa6	1973-07-27	2016-06-28 11:09:04-04	2015-03-19 13:40:31-04	23	\N
1601	1	396	63d60aa7	1973-07-01	2016-06-28 11:09:04-04	2015-07-20 11:32:04-04	23	\N
1602	1	396	7bd60aa0	1973-06-30	2016-06-28 11:09:04-04	2014-09-16 15:04:28-04	23	\N
1603	1	396	73d60aa1	1973-06-29	2016-06-28 11:09:04-04	2015-07-20 11:32:04-04	23	\N
1604	1	397	6bd60aa2	1973-06-26	2016-06-28 11:09:04-04	2015-07-20 11:32:05-04	23	\N
1605	1	230	63d60aa3	1973-06-24	2016-06-28 11:09:04-04	2015-07-20 11:32:05-04	23	\N
1606	1	385	7bd60aac	1973-06-22	2016-06-28 11:09:04-04	2015-07-20 11:32:06-04	23	\N
1607	1	92	73d60aad	1973-06-10	2016-06-28 11:09:04-04	2015-07-16 21:12:41-04	23	\N
1608	1	92	6bd60aae	1973-06-09	2016-06-28 11:09:05-04	2015-07-20 11:32:06-04	23	\N
1609	1	376	63d60aaf	1973-05-26	2016-06-28 11:09:05-04	2015-07-20 11:32:06-04	23	\N
1610	1	331	7bd60aa8	1973-05-20	2016-06-28 11:09:05-04	2015-07-20 11:32:07-04	23	\N
1611	1	383	73d60aa9	1973-05-13	2016-06-28 11:09:05-04	2015-07-20 11:32:07-04	23	\N
1612	1	112	6bd60aaa	1973-04-02	2016-06-28 11:09:05-04	2015-07-20 11:32:08-04	23	\N
1613	1	275	63d60aab	1973-03-31	2016-06-28 11:09:05-04	2015-07-20 11:32:08-04	23	\N
1614	1	197	7bd60ab4	1973-03-30	2016-06-28 11:09:05-04	2015-07-20 11:32:09-04	23	\N
1615	1	212	73d60ab5	1973-03-28	2016-06-28 11:09:05-04	2015-07-20 11:32:09-04	23	\N
1616	1	251	6bd60ab6	1973-03-26	2016-06-28 11:09:05-04	2015-07-20 11:32:10-04	23	\N
1617	1	124	63d60ab7	1973-03-24	2016-06-28 11:09:05-04	2015-07-20 11:32:10-04	23	\N
1618	1	283	7bd60ab0	1973-03-22	2016-06-28 11:09:05-04	2015-07-20 11:32:11-04	23	\N
1619	1	283	73d60ab1	1973-03-21	2016-06-28 11:09:05-04	2015-07-20 11:32:11-04	23	\N
1620	1	119	6bd60ab2	1973-03-19	2016-06-28 11:09:05-04	2015-07-20 11:32:12-04	23	\N
1621	1	119	63d60ab3	1973-03-16	2016-06-28 11:09:05-04	2015-07-20 11:32:12-04	23	\N
1622	1	119	7bd60abc	1973-03-15	2016-06-28 11:09:05-04	2015-03-19 13:40:31-04	23	\N
1623	1	278	73d60abd	1973-02-28	2016-06-28 11:09:05-04	2015-07-20 11:32:12-04	23	\N
1624	1	398	6bd60abe	1973-02-26	2016-06-28 11:09:05-04	2015-07-20 11:32:13-04	23	\N
1625	1	248	63d60abf	1973-02-24	2016-06-28 11:09:05-04	2015-07-20 11:32:13-04	23	\N
1626	1	264	7bd60ab8	1973-02-22	2016-06-28 11:09:05-04	2015-09-25 18:41:44-04	23	\N
1627	1	264	73d60ab9	1973-02-21	2016-06-28 11:09:05-04	2016-02-21 08:08:02-05	23	\N
1628	1	381	6bd60aba	1973-02-19	2016-06-28 11:09:05-04	2012-08-01 08:52:22-04	23	\N
1629	1	399	63d60abb	1973-02-17	2016-06-28 11:09:05-04	2015-07-20 11:32:14-04	23	\N
1630	1	233	7bd60ac4	1973-02-15	2016-06-28 11:09:05-04	2015-10-28 17:27:46-04	23	\N
1631	1	400	73d60ac5	1973-02-09	2016-06-28 11:09:05-04	2015-07-20 11:32:15-04	23	\N
1632	1	320	6bd60ac6	1972-12-31	2016-06-28 11:09:05-04	2014-09-16 15:04:28-04	23	\N
1633	1	169	63d60ac7	1972-12-15	2016-06-28 11:09:05-04	2015-03-19 13:40:31-04	23	\N
1634	1	320	7bd60ac0	1972-12-12	2016-06-28 11:09:05-04	2015-03-18 17:41:37-04	23	\N
1635	1	320	73d60ac1	1972-12-11	2016-06-28 11:09:05-04	2015-07-20 11:32:15-04	23	\N
1636	1	320	6bd60ac2	1972-12-10	2016-06-28 11:09:05-04	2015-07-20 11:32:16-04	23	\N
1637	1	401	63d60ac3	1972-11-26	2016-06-28 11:09:05-04	2015-07-20 11:32:16-04	23	\N
1638	1	402	7bd60acc	1972-11-24	2016-06-28 11:09:05-04	2015-07-20 11:32:17-04	23	\N
1639	1	403	73d60acd	1972-11-22	2016-06-28 11:09:05-04	2015-07-20 11:32:18-04	23	\N
1640	1	354	6bd60ace	1972-11-19	2016-06-28 11:09:05-04	2015-07-20 11:32:18-04	23	\N
1641	1	354	63d60acf	1972-11-18	2016-06-28 11:09:05-04	2015-07-20 11:32:18-04	23	\N
1642	1	404	7bd60ac8	1972-11-17	2016-06-28 11:09:05-04	2015-07-20 11:32:19-04	23	\N
1643	1	405	73d60ac9	1972-11-15	2016-06-28 11:09:05-04	2015-07-20 11:32:20-04	23	\N
1644	1	405	6bd60aca	1972-11-14	2016-06-28 11:09:05-04	2015-07-20 11:32:20-04	23	\N
1645	1	305	63d60acb	1972-11-13	2016-06-28 11:09:05-04	2015-11-08 18:08:11-05	23	\N
1646	1	305	7bd60ad4	1972-11-12	2016-06-28 11:09:05-04	2015-11-08 18:08:11-05	23	\N
1647	1	406	73d60ad5	1972-10-30	2016-06-28 11:09:05-04	2015-07-20 11:32:21-04	23	\N
1648	1	293	6bd60ad6	1972-10-28	2016-06-28 11:09:05-04	2015-07-20 11:32:22-04	23	\N
1649	1	336	63d60ad7	1972-10-27	2016-06-28 11:09:05-04	2015-03-18 17:41:37-04	23	\N
1650	1	407	7bd60ad0	1972-10-26	2016-06-28 11:09:05-04	2015-07-20 11:32:22-04	23	\N
1651	1	408	73d60ad1	1972-10-24	2016-06-28 11:09:05-04	2015-07-20 11:32:23-04	23	\N
1652	1	408	6bd60ad2	1972-10-23	2016-06-28 11:09:05-04	2015-07-20 11:32:23-04	23	\N
1653	1	409	63d60ad3	1972-10-21	2016-06-28 11:09:05-04	2015-07-20 11:32:24-04	23	\N
1654	1	410	7bd60adc	1972-10-19	2016-06-28 11:09:05-04	2015-07-20 11:32:24-04	23	\N
1655	1	410	73d60add	1972-10-18	2016-06-28 11:09:05-04	2015-07-20 11:32:25-04	23	\N
1656	1	410	6bd60ade	1972-10-17	2016-06-28 11:09:05-04	2015-07-20 11:32:25-04	23	\N
1657	1	320	63d60adf	1972-10-09	2016-06-28 11:09:05-04	2015-07-20 11:32:26-04	23	\N
1658	1	212	7bd60ad8	1972-10-02	2016-06-28 11:09:05-04	2015-07-20 11:32:27-04	23	\N
1659	1	411	73d60ad9	1972-09-30	2016-06-28 11:09:05-04	2015-07-20 11:32:27-04	23	\N
1660	1	412	6bd60ada	1972-09-28	2016-06-28 11:09:05-04	2015-07-20 11:32:28-04	23	\N
1661	1	412	63d60adb	1972-09-27	2016-06-28 11:09:05-04	2015-07-20 11:32:29-04	23	\N
1662	1	412	7bd60ae4	1972-09-26	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1663	1	413	73d60ae5	1972-09-24	2016-06-28 11:09:05-04	2015-07-20 11:32:29-04	23	\N
1664	1	413	6bd60ae6	1972-09-23	2016-06-28 11:09:05-04	2015-07-20 11:32:30-04	23	\N
1665	1	124	63d60ae7	1972-09-21	2016-06-28 11:09:05-04	2015-07-20 11:32:30-04	23	\N
1666	1	370	7bd60ae0	1972-09-19	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1667	1	251	73d60ae1	1972-09-17	2016-06-28 11:09:05-04	2015-07-20 11:32:31-04	23	\N
1668	1	326	6bd60ae2	1972-09-16	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1669	1	326	63d60ae3	1972-09-15	2016-06-28 11:09:05-04	2015-07-20 11:32:31-04	23	\N
1670	1	414	7bd60aec	1972-09-10	2016-06-28 11:09:05-04	2014-09-16 15:04:28-04	23	\N
1671	1	414	73d60aed	1972-09-09	2016-06-28 11:09:05-04	2015-07-20 11:32:32-04	23	\N
1672	1	298	6bd60aee	1972-09-03	2016-06-28 11:09:05-04	2015-07-20 11:32:32-04	23	\N
1673	1	415	63d60aef	1972-08-27	2016-06-28 11:09:05-04	2015-07-20 11:32:33-04	23	\N
1674	1	113	7bd60ae8	1972-08-25	2016-06-28 11:09:05-04	2014-09-16 15:04:28-04	23	\N
1675	1	113	73d60ae9	1972-08-24	2016-06-28 11:09:05-04	2016-04-11 14:38:08-04	23	\N
1676	1	113	6bd60aea	1972-08-22	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1677	1	113	63d60aeb	1972-08-21	2016-06-28 11:09:05-04	2015-07-20 11:32:33-04	23	\N
1678	1	416	7bd60af4	1972-08-20	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1679	1	310	73d60af5	1972-08-12	2016-06-28 11:09:05-04	2015-03-19 13:40:32-04	23	\N
1680	1	358	6bd60af6	1972-07-26	2016-06-28 11:09:05-04	2015-07-20 11:32:34-04	23	\N
1681	1	358	63d60af7	1972-07-25	2016-06-28 11:09:05-04	2015-07-20 11:32:34-04	23	\N
1682	1	359	7bd60af0	1972-07-22	2016-06-28 11:09:05-04	2015-07-20 11:32:35-04	23	\N
1683	1	359	73d60af1	1972-07-21	2016-06-28 11:09:05-04	2015-07-20 11:32:35-04	23	\N
1684	1	370	63d60af3	1972-07-18	2016-06-28 11:09:05-04	2015-07-20 11:32:36-04	23	\N
1685	1	380	6bd60af2	1972-07-16	2016-06-28 11:09:05-04	2015-03-19 13:40:33-04	23	\N
1686	1	382	7bd60afc	1972-06-17	2016-06-28 11:09:05-04	2015-07-20 11:32:36-04	23	\N
1687	1	417	73d60afd	1972-05-26	2016-06-28 11:09:05-04	2015-07-20 11:32:37-04	32	\N
1688	1	417	6bd60afe	1972-05-25	2016-06-28 11:09:05-04	2015-07-20 11:32:37-04	32	\N
1689	1	417	63d60aff	1972-05-24	2016-06-28 11:09:05-04	2016-02-26 12:56:30-05	32	\N
1690	1	417	7bd60af8	1972-05-23	2016-06-28 11:09:05-04	2015-07-20 11:32:39-04	32	\N
1691	1	418	73d60af9	1972-05-18	2016-06-28 11:09:05-04	2015-07-20 11:32:39-04	32	\N
1692	1	419	6bd60afa	1972-05-16	2016-06-28 11:09:05-04	2015-07-20 11:32:40-04	32	\N
1693	1	420	63d60afb	1972-05-13	2016-06-28 11:09:05-04	2015-07-20 11:32:40-04	32	\N
1694	1	421	7bd60a04	1972-05-11	2016-06-28 11:09:05-04	2015-07-20 11:32:41-04	32	\N
1695	1	422	73d60a05	1972-05-10	2016-06-28 11:09:05-04	2015-07-20 11:32:41-04	32	\N
1696	1	423	6bd60a06	1972-05-07	2016-06-28 11:09:05-04	2016-02-26 12:56:30-05	32	\N
1697	1	424	63d60a07	1972-05-04	2016-06-28 11:09:05-04	2015-05-25 22:41:47-04	32	\N
1698	1	424	7bd60a00	1972-05-03	2016-06-28 11:09:05-04	2015-07-20 11:32:42-04	32	\N
1699	1	425	73d60a01	1972-04-29	2016-06-28 11:09:05-04	2015-07-20 11:32:43-04	32	\N
1700	1	426	6bd60a02	1972-04-26	2016-06-28 11:09:05-04	2016-02-26 12:56:30-05	32	\N
1701	1	427	63d60a03	1972-04-24	2016-06-28 11:09:05-04	2015-07-20 11:32:44-04	32	\N
1702	1	428	7bd60a0c	1972-04-21	2016-06-28 11:09:05-04	2014-09-16 15:04:28-04	32	\N
1703	1	429	73d60a0d	1972-04-17	2016-06-28 11:09:05-04	2015-07-20 11:32:44-04	32	\N
1704	1	430	6bd60a0e	1972-04-16	2016-06-28 11:09:05-04	2015-07-20 11:32:45-04	32	\N
1705	1	429	7bd60a08	1972-04-14	2016-06-28 11:09:05-04	2015-03-19 13:40:33-04	32	\N
1706	1	431	73d60a09	1972-04-11	2016-06-28 11:09:05-04	2015-07-20 11:32:46-04	32	\N
1707	1	432	6bd60a0a	1972-04-08	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	32	\N
1708	1	432	63d60a0b	1972-04-07	2016-06-28 11:09:06-04	2015-07-20 11:32:46-04	32	\N
1709	1	433	7bd60a14	1972-03-28	2016-06-28 11:09:06-04	2015-07-20 11:32:47-04	23	\N
1710	1	433	73d60a15	1972-03-27	2016-06-28 11:09:06-04	2015-07-20 11:32:47-04	23	\N
1711	1	433	6bd60a16	1972-03-26	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1712	1	433	63d60a17	1972-03-25	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1713	1	433	7bd60a10	1972-03-23	2016-06-28 11:09:06-04	2015-10-03 11:52:27-04	23	\N
1714	1	433	73d60a11	1972-03-22	2016-06-28 11:09:06-04	2015-07-20 11:32:48-04	23	\N
1715	1	433	6bd60a12	1972-03-21	2016-06-28 11:09:06-04	2015-05-25 22:41:47-04	23	\N
1716	1	320	3d6c9cb	1972-03-05	2016-06-28 11:09:06-04	2015-07-20 11:32:49-04	23	\N
1717	1	320	1bd6c9d4	1972-01-02	2016-06-28 11:09:06-04	2015-07-20 11:32:50-04	23	\N
1718	1	320	3bdcf824	1971-12-31	2016-06-28 11:09:06-04	2015-07-20 11:32:50-04	23	\N
1719	1	434	33dcf825	1971-12-15	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1720	1	434	2bdcf826	1971-12-14	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1721	1	410	23dcf827	1971-12-10	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1722	1	410	1bc79d54	1971-12-09	2016-06-28 11:09:06-04	2014-09-16 15:04:28-04	23	\N
1723	1	435	3c79d57	1971-12-07	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1724	1	435	1bc79d50	1971-12-06	2016-06-28 11:09:06-04	2015-07-20 11:32:51-04	23	\N
1725	1	435	3bdcf820	1971-12-05	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1726	1	435	23dcf823	1971-12-04	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1727	1	326	3bdcf82c	1971-12-02	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1728	1	326	33dcf82d	1971-12-01	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1729	1	258	23dcf82f	1971-11-20	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1730	1	436	33dcf835	1971-11-17	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1731	1	403	2bdcf836	1971-11-15	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1732	1	437	23dcf837	1971-11-14	2016-06-28 11:09:06-04	2015-07-20 11:32:52-04	23	\N
1733	1	401	2bdcf832	1971-11-12	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1734	1	438	23dcf833	1971-11-11	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1735	1	439	3dcf99f	1971-11-07	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1736	1	439	1bc79d6c	1971-11-06	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1737	1	440	bdcf99a	1971-10-31	2016-06-28 11:09:06-04	2014-09-16 15:02:44-04	23	\N
1738	1	441	3dcf9a7	1971-10-30	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1739	1	442	13dcf9ad	1971-10-29	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1740	1	253	1bdcf9a8	1971-10-27	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1741	1	443	33dcfc89	1971-10-26	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1742	1	444	4bda3312	1971-10-24	2016-06-28 11:09:06-04	2015-07-20 11:32:53-04	23	\N
1743	1	444	1bdcf924	1971-10-23	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1744	1	365	33dca4b9	1971-10-22	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1745	1	365	3dcf927	1971-10-21	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1746	1	445	1bdcf928	1971-10-19	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1747	1	446	13dcf931	1971-08-26	2016-06-28 11:09:06-04	2015-07-20 11:32:53-04	23	\N
1748	1	365	2bdca4ca	1971-08-24	2016-06-28 11:09:06-04	2015-03-18 17:41:38-04	23	\N
1749	1	365	3dcf933	1971-08-23	2016-06-28 11:09:06-04	2015-03-19 13:40:33-04	23	\N
1750	1	113	3dcf93f	1971-08-15	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1751	1	113	3dcf947	1971-08-14	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1752	1	259	23dca4d7	1971-08-07	2016-06-28 11:09:06-04	2015-07-20 11:32:54-04	23	\N
1753	1	414	bdcf94e	1971-08-06	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1754	1	414	3dcf94b	1971-08-05	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1755	1	447	1bc2e168	1971-08-04	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1756	1	448	1bdcf950	1971-07-31	2016-06-28 11:09:06-04	2015-07-20 11:32:55-04	23	\N
1757	1	449	bdcf952	1971-07-02	2016-06-28 11:09:06-04	2015-07-20 11:32:56-04	23	\N
1758	1	450	bdcf95a	1971-06-21	2016-06-28 11:09:06-04	2015-07-20 11:32:56-04	23	\N
1759	1	320	13dcf965	1971-05-30	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1760	1	320	bdcf962	1971-05-29	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1761	1	451	bdcf96a	1971-04-29	2016-06-28 11:09:06-04	2015-09-21 01:55:55-04	23	\N
1762	1	451	bdcf97e	1971-04-28	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1763	1	451	7bdcfe80	1971-04-27	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1764	1	451	6bdcfe82	1971-04-26	2016-06-28 11:09:06-04	2015-07-20 11:32:59-04	23	\N
1765	1	451	43dcff37	1971-04-25	2016-06-28 11:09:06-04	2015-07-20 11:32:59-04	23	\N
1766	1	452	53dcff29	1971-04-24	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1767	1	453	53dcff31	1971-04-22	2016-06-28 11:09:06-04	2015-07-20 11:33:00-04	23	\N
1768	1	454	bd7056e	1971-04-21	2016-06-28 11:09:06-04	2015-03-18 17:41:38-04	23	\N
1769	1	455	53dcff65	1971-04-18	2016-06-28 11:09:06-04	2015-07-20 11:33:01-04	23	\N
1770	1	456	43dcff67	1971-04-17	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1771	1	457	73c7a2dd	1971-04-15	2016-06-28 11:09:06-04	2016-01-13 17:31:23-05	23	\N
1772	1	458	6bc7a2de	1971-04-14	2016-06-28 11:09:06-04	2015-07-20 11:33:01-04	23	\N
1773	1	459	73c7a2d9	1971-04-13	2016-06-28 11:09:06-04	2015-03-18 17:41:38-04	23	\N
1774	1	167	63c7a2db	1971-04-12	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1775	1	460	4bdcff62	1971-04-10	2016-06-28 11:09:06-04	2015-11-10 17:40:09-05	23	\N
1776	1	326	5bdcff74	1971-04-08	2016-06-28 11:09:06-04	2015-07-20 11:33:02-04	23	\N
1777	1	326	4bdcff72	1971-04-07	2016-06-28 11:09:06-04	2015-07-20 11:33:02-04	23	\N
1778	1	461	2bdcfcb2	1971-04-06	2016-06-28 11:09:06-04	2015-09-21 01:57:45-04	23	\N
1779	1	461	23dcfcbb	1971-04-05	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1780	1	461	2bdcfcc2	1971-04-04	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1781	1	320	2bdcfcce	1971-03-24	2016-06-28 11:09:06-04	2014-09-16 15:04:28-04	23	\N
1782	1	408	2bdcfcca	1971-03-21	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1783	1	462	3c2e177	1971-03-20	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1784	1	410	6bc7a2ea	1971-03-18	2016-06-28 11:09:06-04	2015-11-16 17:09:17-05	23	\N
1785	1	410	63c7a2eb	1971-03-17	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1786	1	463	23dcfc0f	1971-03-14	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1787	1	464	5bda331c	1971-03-13	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1788	1	449	3bdcfc14	1971-03-03	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1789	1	465	33dcfc11	1971-02-24	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1790	1	465	2bdcfc12	1971-02-23	2016-06-28 11:09:06-04	2015-07-20 11:33:04-04	23	\N
1791	1	465	33dcfc1d	1971-02-21	2016-06-28 11:09:06-04	2015-07-20 11:33:05-04	23	\N
1792	1	465	23dcfc1f	1971-02-20	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1793	1	465	13dcfd41	1971-02-19	2016-06-28 11:09:06-04	2015-11-05 10:15:30-05	23	\N
1794	1	465	7bc7a2fc	1971-02-18	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1795	1	397	63c7a2ff	1971-01-25	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1796	1	397	7bc7a2f8	1971-01-24	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1797	1	466	13dcfd4d	1971-01-22	2016-06-28 11:09:06-04	2015-07-20 11:33:07-04	23	\N
1798	1	467	73c7a205	1971-01-21	2016-06-28 11:09:06-04	2015-08-23 08:02:47-04	23	\N
1799	1	320	13dcfd51	1970-12-31	2016-06-28 11:09:06-04	2015-09-15 18:37:58-04	23	\N
1800	1	468	1bdcfd5c	1970-12-28	2016-06-28 11:09:06-04	2015-07-20 11:33:08-04	23	\N
1801	1	468	3bdc70d0	1970-12-27	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1802	1	468	3dcfd5f	1970-12-26	2016-06-28 11:09:06-04	2015-07-20 11:33:09-04	23	\N
1803	1	320	1bdcfd64	1970-12-23	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1804	1	469	3dcfd67	1970-12-12	2016-06-28 11:09:06-04	2015-07-20 11:33:09-04	23	\N
1805	1	470	bdcfd62	1970-11-29	2016-06-28 11:09:06-04	2015-03-19 13:40:34-04	23	\N
1806	1	471	43c73fa7	1970-11-27	2016-06-28 11:09:06-04	2016-02-26 12:56:30-05	23	\N
1807	1	472	3dcfd6f	1970-11-23	2016-06-28 11:09:06-04	2015-07-20 11:33:10-04	23	\N
1808	1	473	13dcfd69	1970-11-21	2016-06-28 11:09:06-04	2012-07-26 15:19:55-04	23	\N
1809	1	474	1bdcfd68	1970-11-21	2016-06-28 11:09:06-04	2015-11-11 01:26:14-05	23	\N
1810	1	443	bdcfd6a	1970-11-20	2016-06-28 11:09:06-04	2015-11-05 22:18:09-05	23	\N
1811	1	451	3dcfd6b	1970-11-16	2016-06-28 11:09:06-04	2015-07-20 11:33:11-04	23	\N
1812	1	475	13dcfd75	1970-11-11	2016-06-28 11:09:06-04	2016-05-26 12:21:57-04	23	\N
1813	1	476	53c73fad	1970-11-10	2016-06-28 11:09:06-04	2015-08-23 08:05:00-04	23	\N
1814	1	476	bdcfd72	1970-11-09	2016-06-28 11:09:06-04	2014-09-15 01:12:40-04	23	\N
1815	1	465	3dcfd7f	1970-11-08	2016-06-28 11:09:06-04	2015-08-04 07:56:44-04	23	\N
1816	1	465	3dcfd7b	1970-11-07	2016-06-28 11:09:07-04	2015-07-20 11:33:13-04	23	\N
1817	1	465	6bdc8286	1970-11-06	2016-06-28 11:09:07-04	2016-02-26 12:56:30-05	23	\N
1818	1	465	63dc8287	1970-11-05	2016-06-28 11:09:07-04	2015-07-20 11:33:14-04	23	\N
1819	1	477	63dc828f	1970-10-31	2016-06-28 11:09:07-04	2015-07-20 11:33:14-04	23	\N
1820	1	477	73dc8281	1970-10-31	2016-06-28 11:09:07-04	2013-07-18 10:15:08-04	23	\N
1821	1	477	7bdc8294	1970-10-30	2016-06-28 11:09:07-04	2016-02-26 12:56:30-05	23	\N
1822	1	477	7bdc8290	1970-10-30	2016-06-28 11:09:07-04	2015-03-19 13:40:34-04	23	\N
1823	1	478	73dc829d	1970-10-24	2016-06-28 11:09:07-04	2016-02-26 12:56:30-05	23	\N
1824	1	479	73dc8299	1970-10-23	2016-06-28 11:09:07-04	2015-07-20 11:33:15-04	23	\N
1825	1	286	73c7a23d	1970-10-17	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1826	1	480	6bc7a23e	1970-10-16	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1827	1	481	73dc82a5	1970-10-11	2016-06-28 11:09:07-04	2015-06-01 00:10:14-04	23	\N
1828	1	482	6bdc82a2	1970-10-10	2016-06-28 11:09:07-04	2015-03-19 13:40:34-04	23	\N
1829	1	320	5bc73fb8	1970-10-05	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1830	1	320	6bdc82b6	1970-10-04	2016-06-28 11:09:07-04	2015-07-20 11:33:16-04	23	\N
1831	1	483	2bdc70ca	1970-09-26	2016-06-28 11:09:07-04	2015-07-20 11:33:17-04	23	\N
1832	1	484	23dc70cf	1970-09-25	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1833	1	451	63dc82b3	1970-09-20	2016-06-28 11:09:07-04	2015-07-20 11:33:17-04	23	\N
1834	1	451	73dc82b9	1970-09-19	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1835	1	451	7bdc82c4	1970-09-18	2016-06-28 11:09:07-04	2015-06-01 00:10:15-04	23	\N
1836	1	451	5bdc833c	1970-09-17	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1837	1	485	5bdc8350	1970-08-30	2016-06-28 11:09:07-04	2012-07-25 22:55:57-04	23	\N
1838	1	449	53dc8351	1970-08-19	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1839	1	449	4bdc8352	1970-08-18	2016-06-28 11:09:07-04	2015-06-01 00:10:15-04	23	\N
1840	1	449	7bda66d4	1970-08-17	2016-06-28 11:09:07-04	2013-07-24 04:57:04-04	23	\N
1841	1	486	43dc8353	1970-08-05	2016-06-28 11:09:07-04	2015-11-19 21:19:56-05	23	\N
1842	1	487	53dc835d	1970-07-30	2016-06-28 11:09:07-04	2013-07-24 05:06:55-04	23	\N
1843	1	488	4bdc835e	1970-07-16	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1844	1	488	43dc835f	1970-07-14	2016-06-28 11:09:07-04	2015-07-20 11:33:20-04	23	\N
1845	1	451	53dc8359	1970-07-12	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1846	1	451	43dc835b	1970-07-11	2016-06-28 11:09:07-04	2015-07-20 11:33:21-04	23	\N
1847	1	451	33c73cdd	1970-07-10	2016-06-28 11:09:07-04	2015-07-20 11:33:22-04	23	\N
1848	1	451	2bc73cde	1970-07-09	2016-06-28 11:09:07-04	2013-10-07 18:11:05-04	23	\N
1849	1	295	bdf859e	1970-07-08	2016-06-28 11:09:07-04	2015-07-20 11:33:22-04	23	\N
1850	1	489	63c7da6f	1970-07-01	2016-06-28 11:09:07-04	2015-08-23 08:07:58-04	23	\N
1851	1	465	53dc8361	1970-06-24	2016-06-28 11:09:07-04	2015-07-20 11:33:23-04	23	\N
1852	1	465	5bdc8360	1970-06-24	2016-06-28 11:09:07-04	2015-08-30 17:36:53-04	23	\N
1853	1	490	5bdc836c	1970-06-21	2016-06-28 11:09:07-04	2016-02-21 18:11:26-05	23	\N
1854	1	491	43dc836f	1970-06-13	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1855	1	449	7bda6674	1970-06-07	2016-06-28 11:09:07-04	2015-04-24 22:43:49-04	23	\N
1856	1	449	6bda6672	1970-06-06	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1857	1	449	53dc8369	1970-06-05	2016-06-28 11:09:07-04	2015-07-20 11:33:26-04	23	\N
1858	1	449	4bdc836a	1970-06-04	2016-06-28 11:09:07-04	2015-09-21 01:59:59-04	23	\N
1859	1	492	2bdc809e	1970-05-24	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1860	1	493	5bc7db90	1970-05-16	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1861	1	451	33dc80a5	1970-05-15	2016-06-28 11:09:07-04	2015-08-19 18:49:10-04	23	\N
1862	1	451	23dc809b	1970-05-15	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1863	1	494	2bdc80a6	1970-05-14	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1864	1	495	5bc7db9c	1970-05-10	2016-06-28 11:09:07-04	2015-08-25 11:14:52-04	23	\N
1865	1	496	3dc81cb	1970-05-09	2016-06-28 11:09:07-04	2013-07-22 06:30:46-04	23	\N
1866	1	497	5bc7db98	1970-05-08	2016-06-28 11:09:07-04	2015-06-01 00:10:15-04	23	\N
1867	1	498	13dc81d5	1970-05-07	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1868	1	499	bdc81d6	1970-05-06	2016-06-28 11:09:07-04	2015-07-20 11:33:31-04	23	\N
1869	1	500	13dc81d1	1970-05-03	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1870	1	501	1bdc81dc	1970-05-02	2016-06-28 11:09:07-04	2015-07-20 11:33:32-04	23	\N
1871	1	502	1bdc81e0	1970-05-01	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1872	1	503	3dc81ef	1970-04-24	2016-06-28 11:09:07-04	2015-07-20 11:33:32-04	23	\N
1873	1	504	bdcad1e	1970-04-19	2016-06-28 11:09:07-04	2015-07-20 11:33:33-04	23	\N
1874	1	504	1bdcad18	1970-04-18	2016-06-28 11:09:07-04	2015-03-19 13:40:35-04	23	\N
1875	1	504	3dcad1b	1970-04-17	2016-06-28 11:09:07-04	2015-08-19 18:48:26-04	23	\N
1876	1	320	73da6aa9	1970-04-15	2016-06-28 11:09:07-04	2016-03-29 13:07:04-04	23	\N
1877	1	449	1bdc81f4	1970-04-12	2016-06-28 11:09:07-04	2015-11-25 17:35:16-05	23	\N
1878	1	449	73da6ab5	1970-04-11	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1879	1	449	bc7d956	1970-04-10	2016-06-28 11:09:07-04	2015-10-26 12:13:27-04	23	\N
1880	1	449	1bdc81f8	1970-04-09	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1881	1	505	1bdc8104	1970-04-03	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1882	1	506	bdc8102	1970-03-24	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1883	1	465	3c7d95f	1970-03-21	2016-06-28 11:09:07-04	2015-04-24 22:46:03-04	23	\N
1884	1	465	1bdc810c	1970-03-21	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1885	1	465	13dc8115	1970-03-20	2016-06-28 11:09:07-04	2013-10-02 00:27:16-04	23	\N
1886	1	465	bdc810a	1970-03-20	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1887	1	507	1bc7d964	1970-03-17	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1888	1	508	bc7d962	1970-03-08	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1889	1	509	13dc8111	1970-03-07	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1890	1	504	3dcad2b	1970-03-01	2016-06-28 11:09:07-04	2015-07-20 11:33:38-04	23	\N
1891	1	504	bdcad4a	1970-02-28	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1892	1	504	73dcb2a5	1970-02-27	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1893	1	403	63dcb2a7	1970-02-23	2016-06-28 11:09:07-04	2015-07-20 11:33:40-04	23	\N
1894	1	451	63dcb2a3	1970-02-14	2016-06-28 11:09:07-04	2015-07-20 11:33:40-04	23	\N
1895	1	451	3bdcb458	1970-02-13	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1896	1	510	3bdcb464	1970-02-12	2016-06-28 11:09:07-04	2014-09-16 15:04:28-04	23	\N
1897	1	451	23dcb467	1970-02-11	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1898	1	449	33dcb461	1970-02-08	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1899	1	449	2bdcb462	1970-02-07	2016-06-28 11:09:07-04	2015-07-20 11:33:42-04	23	\N
1900	1	449	bdcb5a2	1970-02-06	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1901	1	449	1bdcb5ac	1970-02-05	2016-06-28 11:09:07-04	2015-07-20 11:33:43-04	23	\N
1902	1	504	bdcb5ae	1970-02-04	2016-06-28 11:09:07-04	2015-09-21 02:02:58-04	23	\N
1903	1	410	4bdbb376	1970-02-02	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1904	1	511	3dcb5af	1970-02-01	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1905	1	511	13dcb5a9	1970-01-31	2016-06-28 11:09:07-04	2015-08-19 18:47:34-04	23	\N
1906	1	511	1bdcb5b0	1970-01-30	2016-06-28 11:09:07-04	2015-07-20 11:33:45-04	23	\N
1907	1	491	1bdcb5c4	1970-01-23	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1908	1	512	13df1539	1970-01-18	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1909	1	513	13dcb5c1	1970-01-17	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1910	1	512	3dcb5c3	1970-01-16	2016-06-28 11:09:07-04	2015-07-20 11:33:47-04	23	\N
1911	1	259	1bdcb5c8	1970-01-10	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1912	1	451	bdcb5ca	1970-01-03	2016-06-28 11:09:07-04	2015-09-21 02:03:44-04	23	\N
1913	1	451	1bdcb5d4	1970-01-03	2016-06-28 11:09:07-04	2015-03-19 13:40:35-04	23	\N
1914	1	451	3dcb5df	1970-01-02	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1915	1	451	bdcb5d2	1970-01-02	2016-06-28 11:09:07-04	2012-07-29 01:20:43-04	23	\N
1916	1	514	bdc654e	1969-12-31	2016-06-28 11:09:07-04	2015-07-20 11:33:49-04	23	\N
1917	1	514	4bdca7da	1969-12-30	2016-06-28 11:09:07-04	2015-09-21 02:04:52-04	23	\N
1918	1	514	43dca7db	1969-12-29	2016-06-28 11:09:07-04	2015-07-20 11:33:50-04	23	\N
1919	1	515	4bdca7e6	1969-12-28	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1920	1	516	4bdca7ee	1969-12-26	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1921	1	449	63da6ab7	1969-12-21	2016-06-28 11:09:07-04	2015-07-20 11:33:52-04	23	\N
1922	1	449	7bda6ab0	1969-12-20	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1923	1	449	5bdca7e8	1969-12-19	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1924	1	288	53dca7e9	1969-12-13	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1925	1	517	5bdca7f4	1969-12-12	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1926	1	517	53dca7f5	1969-12-11	2016-06-28 11:09:07-04	2015-06-01 00:10:14-04	23	\N
1927	1	517	63dcde5b	1969-12-11	2016-06-28 11:09:07-04	2015-07-20 11:33:55-04	23	\N
1928	1	517	5bdca7fc	1969-12-10	2016-06-28 11:09:07-04	2015-11-25 17:35:18-05	23	\N
1929	1	449	53dca7f9	1969-12-07	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1930	1	449	43dca707	1969-12-05	2016-06-28 11:09:07-04	2015-07-20 11:33:56-04	23	\N
1931	1	449	4bdca736	1969-12-04	2016-06-28 11:09:07-04	2015-11-25 17:35:18-05	23	\N
1932	1	518	5bdca730	1969-11-21	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1933	1	519	53dca73d	1969-11-15	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1934	1	449	2bdca462	1969-11-08	2016-06-28 11:09:07-04	2015-11-25 17:35:19-05	23	\N
1935	1	449	43dca747	1969-11-07	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1936	1	504	73da6ab1	1969-11-02	2016-06-28 11:09:07-04	2015-09-21 01:47:16-04	23	\N
1937	1	504	63da6ab3	1969-11-01	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1938	1	520	4bdca742	1969-10-31	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1939	1	320	73da6abd	1969-10-26	2016-06-28 11:09:07-04	2015-03-19 13:40:35-04	23	\N
1940	1	320	43dca743	1969-10-25	2016-06-28 11:09:07-04	2012-07-28 09:39:46-04	23	\N
1941	1	320	5bdca74c	1969-10-24	2016-06-28 11:09:07-04	2015-07-20 11:34:01-04	23	\N
1942	1	521	53dca74d	1969-09-30	2016-06-28 11:09:07-04	2015-07-20 11:34:02-04	23	\N
1943	1	521	6bc7de02	1969-09-29	2016-06-28 11:09:07-04	2015-04-24 22:46:04-04	23	\N
1944	1	451	53dca749	1969-09-27	2016-06-28 11:09:07-04	2015-03-19 13:40:35-04	23	\N
1945	1	451	4bdca74a	1969-09-26	2016-06-28 11:09:07-04	2013-10-17 11:10:23-04	23	\N
1946	1	504	7bda6ab8	1969-09-07	2016-06-28 11:09:07-04	2013-10-18 19:58:33-04	23	\N
1947	1	504	43dca74b	1969-09-06	2016-06-28 11:09:07-04	2015-11-25 17:35:19-05	23	\N
1948	1	522	5bdca754	1969-09-01	2016-06-28 11:09:07-04	2016-02-26 12:56:31-05	23	\N
1949	1	504	43dca757	1969-08-30	2016-06-28 11:09:07-04	2012-07-17 19:47:04-04	23	\N
1950	1	504	73da6ab9	1969-08-29	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1951	1	504	6bda6aba	1969-08-28	2016-06-28 11:09:08-04	2015-04-24 22:40:17-04	23	\N
1952	1	523	63da6abb	1969-08-23	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1953	1	524	5bdca750	1969-08-21	2016-06-28 11:09:08-04	2016-01-11 22:49:45-05	23	\N
1954	1	525	bd6b52a	1969-08-16	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1955	1	504	7bda6ac4	1969-08-03	2016-06-28 11:09:08-04	2014-09-16 15:04:28-04	23	\N
1956	1	504	7bc7de38	1969-08-02	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1957	1	526	53dca751	1969-07-12	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1958	1	526	43dca753	1969-07-11	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1959	1	527	5bdca75c	1969-07-10	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1960	1	528	73da6ac5	1969-07-07	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1961	1	529	73da6a5d	1969-07-05	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1962	1	529	6bc7de46	1969-07-04	2016-06-28 11:09:08-04	2016-02-26 12:56:31-05	23	\N
1963	1	530	6bda6a66	1969-07-03	2016-06-28 11:09:08-04	2015-04-24 22:46:04-04	23	\N
1964	1	531	53dca75d	1969-06-28	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1965	1	531	7bda6a68	1969-06-27	2016-06-28 11:09:08-04	2015-03-19 13:40:35-04	23	\N
1966	1	532	4bdca75e	1969-06-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1967	1	451	4bdca75a	1969-06-21	2016-06-28 11:09:08-04	2015-03-19 13:40:35-04	23	\N
1968	1	451	7bc7de54	1969-06-20	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1969	1	533	43dca767	1969-06-14	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1970	1	534	4bdca762	1969-06-13	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1971	1	449	bdca50e	1969-06-08	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1972	1	449	5bdca76c	1969-06-07	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1973	1	449	53dca76d	1969-06-06	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1974	1	449	4bdca76e	1969-06-05	2016-06-28 11:09:08-04	2015-04-24 22:46:04-04	23	\N
1975	1	277	5bdca768	1969-05-31	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1976	1	512	73c7de69	1969-05-30	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1977	1	367	33dca48d	1969-05-29	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1978	1	535	bdca52a	1969-05-24	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1979	1	535	3dca52b	1969-05-23	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1980	1	536	63da6a6b	1969-05-16	2016-06-28 11:09:08-04	2015-11-25 17:35:22-05	23	\N
1981	1	537	43c7df93	1969-05-11	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1982	1	538	63da6a77	1969-05-10	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1983	1	260	4bc7df9e	1969-05-09	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1984	1	135	6bda6a7e	1969-05-07	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1985	1	320	13dca535	1969-05-03	2016-06-28 11:09:08-04	2015-04-24 22:46:04-04	23	\N
1986	1	320	43c7df9b	1969-05-02	2016-06-28 11:09:08-04	2015-08-23 08:17:21-04	23	\N
1987	1	539	bdca536	1969-04-27	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1988	1	529	5bdcab10	1969-04-26	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1989	1	529	1bda1978	1969-04-25	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1990	1	540	5bdcab18	1969-04-23	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1991	1	540	43dcab1b	1969-04-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1992	1	540	4bdcab26	1969-04-21	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1993	1	541	5bc7dfa0	1969-04-20	2016-06-28 11:09:08-04	2015-11-25 17:25:08-05	23	\N
1994	1	542	53da6b81	1969-04-18	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1995	1	543	1bdf1544	1969-04-17	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1996	1	544	5bdcab20	1969-04-15	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1997	1	545	53dcab21	1969-04-13	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1998	1	546	4bda6b96	1969-04-12	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
1999	1	547	5bc7dfac	1969-04-11	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2000	1	548	43dcab23	1969-04-06	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2001	1	548	53dcab2d	1969-04-05	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2002	1	548	43dcab2f	1969-04-04	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2003	1	549	53dcab29	1969-03-29	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2004	1	550	4bda6b92	1969-03-28	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2005	1	551	4bdcab2a	1969-03-27	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2006	1	538	4bda6b9e	1969-03-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2007	1	552	5bdcab34	1969-03-15	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2008	1	449	53dcab35	1969-03-02	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2009	1	449	53dcab31	1969-03-01	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2010	1	449	4bdcab3e	1969-02-28	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2011	1	449	43dcab33	1969-02-27	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2012	1	553	5bdcab38	1969-02-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2013	1	553	53dcab39	1969-02-21	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2014	1	449	53c7dfb9	1969-02-19	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2015	1	554	4bda7bae	1969-02-15	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2016	1	554	5bdcab44	1969-02-14	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2017	1	451	4bda7bb6	1969-02-12	2016-06-28 11:09:08-04	2013-10-25 19:56:48-04	23	\N
2018	1	451	43da7bb7	1969-02-11	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2019	1	285	5bda7bb0	1969-02-07	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2020	1	249	43da7b3f	1969-02-06	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2021	1	555	5bc7dfcc	1969-02-05	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2022	1	539	53dcab45	1969-02-02	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2023	1	548	4bdcab46	1969-01-26	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2024	1	548	1bdca510	1969-01-25	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2025	1	548	5bda7b38	1969-01-24	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2026	1	367	4bc7dfe2	1969-01-17	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2027	1	320	6bc792b6	1968-12-31	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2028	1	556	23dca477	1968-12-29	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2029	1	557	53c7df19	1968-12-28	2016-06-28 11:09:08-04	2015-10-17 23:37:12-04	23	\N
2030	1	346	5bda7b44	1968-12-21	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2031	1	346	43c7df1b	1968-12-20	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2032	1	558	43da7b47	1968-12-07	2016-06-28 11:09:08-04	2015-04-24 22:46:05-04	23	\N
2033	1	559	2bf6583a	1968-11-29	2016-06-28 11:09:08-04	2015-11-25 17:35:33-05	23	\N
2034	1	560	4bc7df32	1968-11-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2035	1	449	43c7df3b	1968-11-10	2016-06-28 11:09:08-04	2015-08-23 08:23:00-04	23	\N
2036	1	561	1bdca904	1968-11-01	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2037	1	156	bdca906	1968-10-20	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2038	1	548	5bda7b40	1968-10-13	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2039	1	548	3dca907	1968-10-12	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2040	1	487	53f2df8d	1968-10-10	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2041	1	487	4bf2dfb2	1968-10-08	2016-06-28 11:09:08-04	2015-12-08 14:14:29-05	23	\N
2042	1	562	43c7df6f	1968-09-22	2016-06-28 11:09:08-04	2015-11-25 17:35:34-05	23	\N
2043	1	113	53da7b41	1968-09-20	2016-06-28 11:09:08-04	2015-11-25 17:25:09-05	23	\N
2044	1	563	13dca901	1968-09-02	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2045	1	548	23d03cff	1968-08-28	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2046	1	346	1bdca90c	1968-08-24	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2047	1	346	bdca90e	1968-08-23	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2048	1	449	3bd03cf8	1968-08-22	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2049	1	449	33d03cf9	1968-08-21	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2050	1	449	3bc7dc8c	1968-08-20	2016-06-28 11:09:08-04	2013-10-01 14:51:46-04	23	\N
2051	1	564	2bd03cfa	1968-06-19	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2052	1	451	1bdca908	1968-06-14	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2053	1	564	7bd1f2c4	1968-06-07	2016-06-28 11:09:08-04	2011-12-21 14:43:19-05	23	\N
2054	1	565	23c7dcdb	1968-05-25	2016-06-28 11:09:08-04	2015-11-25 17:35:38-05	23	\N
2055	1	565	23c7dce3	1968-05-24	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2056	1	566	bdca916	1968-05-18	2016-06-28 11:09:08-04	2013-05-08 18:46:37-04	23	\N
2057	1	567	73c7e249	1968-05-09	2016-06-28 11:09:08-04	2015-08-23 08:26:15-04	23	\N
2058	1	567	6bc7e24a	1968-05-08	2016-06-28 11:09:08-04	2015-10-18 18:23:54-04	23	\N
2059	1	532	73c7e255	1968-05-05	2016-06-28 11:09:08-04	2013-10-01 02:12:21-04	23	\N
2060	1	568	63c7e257	1968-05-03	2016-06-28 11:09:08-04	2015-07-27 17:09:14-04	23	\N
2061	1	320	73c7e259	1968-04-03	2016-06-28 11:09:08-04	2015-08-23 08:27:26-04	23	\N
2062	1	564	bdca912	1968-03-31	2016-06-28 11:09:08-04	2013-10-25 19:56:48-04	23	\N
2063	1	564	1bdca91c	1968-03-30	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2064	1	564	13dca91d	1968-03-29	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2065	1	569	3dca91f	1968-03-26	2016-06-28 11:09:08-04	2015-11-25 17:25:10-05	23	\N
2066	1	564	63c7e26b	1968-03-17	2016-06-28 11:09:08-04	2015-08-23 08:28:29-04	23	\N
2067	1	564	23d03cfb	1968-03-16	2016-06-28 11:09:08-04	2015-11-25 17:35:39-05	23	\N
2068	1	310	1bdca59c	1968-03-11	2016-06-28 11:09:08-04	2015-08-23 08:29:06-04	23	\N
2069	1	569	3bf5b050	1968-03-09	2016-06-28 11:09:08-04	2015-10-18 17:29:33-04	23	\N
2070	1	569	33f5b061	1968-03-08	2016-06-28 11:09:08-04	2015-10-18 17:19:40-04	23	\N
2071	1	570	13dca925	1968-03-03	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2072	1	571	3dca5cb	1968-02-24	2016-06-28 11:09:08-04	2015-11-25 17:35:39-05	23	\N
2073	1	571	1bdca5d4	1968-02-23	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2074	1	343	13dca5a5	1968-02-17	2016-06-28 11:09:08-04	2015-11-25 17:35:40-05	23	\N
2075	1	564	3dca927	1968-02-14	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2076	1	572	3bd03c04	1968-02-03	2016-06-28 11:09:08-04	2015-11-25 17:35:41-05	23	\N
2077	1	572	33d03c05	1968-02-02	2016-06-28 11:09:08-04	2015-11-25 17:35:42-05	23	\N
2078	1	573	3dca523	1968-01-30	2016-06-28 11:09:08-04	2012-07-17 11:56:02-04	23	\N
2079	1	574	bdca52e	1968-01-27	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2080	1	574	6bd0c2f2	1968-01-26	2016-06-28 11:09:08-04	2015-07-17 08:07:16-04	23	\N
2081	1	575	bdca92e	1968-01-20	2016-06-28 11:09:08-04	2015-11-25 17:25:10-05	23	\N
2082	1	564	13dca5c5	1968-01-17	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	23	\N
2083	1	346	4bc7e35e	1967-12-13	2016-06-28 11:09:08-04	2015-08-23 08:30:37-04	23	\N
2084	1	576	bf0f5f6	1967-12-08	2016-06-28 11:09:08-04	2016-03-05 20:42:20-05	23	\N
2085	1	346	63d0c2f3	1967-11-11	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	33	\N
2086	1	346	7bd0c2fc	1967-11-10	2016-06-28 11:09:08-04	2015-11-25 17:35:44-05	33	\N
2087	1	320	3dca92f	1967-10-31	2016-06-28 11:09:08-04	2013-05-08 18:42:42-04	23	\N
2088	1	320	bdca92a	1967-10-22	2016-06-28 11:09:08-04	2016-02-26 12:56:32-05	33	\N
2089	1	577	53c7e361	1967-10-14	2016-06-28 11:09:08-04	2015-11-25 17:35:44-05	23	\N
2090	1	382	3dca92b	1967-09-15	2016-06-28 11:09:08-04	2015-11-25 17:35:45-05	23	\N
2091	1	578	4bc7e7ae	1967-09-04	2016-06-28 11:09:08-04	2015-01-30 15:24:03-05	33	\N
2092	1	578	73d0c2fd	1967-09-03	2016-06-28 11:09:08-04	2015-11-25 17:35:46-05	33	\N
2093	1	579	4bc7e7d6	1967-08-06	2016-06-28 11:10:08-04	2015-08-23 08:32:44-04	23	\N
2094	1	580	53c7e7d9	1967-08-05	2016-06-28 11:10:08-04	2016-02-26 12:56:32-05	33	\N
2095	1	580	13dca935	1967-08-04	2016-06-28 11:10:08-04	2016-02-26 12:56:32-05	33	\N
2096	1	577	43c7e7ef	1967-07-21	2016-06-28 11:10:08-04	2015-09-21 01:54:16-04	23	\N
2097	1	581	4bf65bfe	1967-07-02	2016-06-28 11:10:08-04	2015-07-31 20:58:04-04	23	\N
2098	1	240	5bc7e700	1967-06-28	2016-06-28 11:10:08-04	2015-11-25 17:35:47-05	23	\N
2099	1	582	6bd0c2fe	1967-06-18	2016-06-28 11:10:08-04	2015-01-30 15:12:24-05	33	\N
2100	1	521	33cff4e1	1967-06-06	2016-06-28 11:10:08-04	2015-09-21 01:52:57-04	23	\N
2101	1	521	53c7e711	1967-06-05	2016-06-28 11:10:08-04	2015-09-21 01:40:52-04	23	\N
2102	1	583	53c7e71d	1967-06-01	2016-06-28 11:10:08-04	2015-11-25 17:35:48-05	23	\N
2103	1	584	4bc7e726	1967-05-18	2016-06-28 11:10:08-04	2015-08-23 08:35:43-04	23	\N
2104	1	585	63d0c2ff	1967-05-05	2016-06-28 11:10:08-04	2015-04-24 22:46:05-04	33	\N
2105	1	585	43c7e73f	1967-04-12	2016-06-28 11:10:08-04	2014-06-14 00:10:45-04	23	\N
2106	1	320	7bd0c2f8	1967-03-18	2016-06-28 11:10:08-04	2015-06-01 00:10:21-04	33	\N
2107	1	585	23c7e4ab	1967-02-12	2016-06-28 11:10:08-04	2015-05-28 13:20:29-04	33	\N
2108	1	548	bdca936	1967-01-27	2016-06-28 11:10:08-04	2013-07-23 05:46:55-04	23	\N
2109	1	135	3dca937	1967-01-14	2016-06-28 11:10:09-04	2015-11-25 17:35:48-05	33	\N
2110	1	585	2bc7e4ca	1967-01-14	2016-06-28 11:10:09-04	2015-11-25 17:35:49-05	23	\N
2111	1	487	73d0c2f9	1966-12-01	2016-06-28 11:10:09-04	2016-06-22 22:24:51-04	23	\N
2112	1	487	6bd0c2fa	1966-11-29	2016-06-28 11:10:09-04	2016-06-22 22:25:40-04	23	\N
2113	1	585	63d0c2fb	1966-11-19	2016-06-28 11:10:09-04	2015-09-21 01:42:56-04	23	\N
2114	1	585	13c7e549	1966-10-07	2016-06-28 11:10:09-04	2015-09-19 16:59:17-04	23	\N
2115	1	548	7bd096d0	1966-09-16	2016-06-28 11:10:09-04	2015-11-25 17:35:56-05	23	\N
2116	1	585	63c43ad7	1966-08-07	2016-06-28 11:10:09-04	2015-09-21 01:36:32-04	23	\N
2117	1	586	6bd096d2	1966-07-30	2016-06-28 11:10:09-04	2015-07-23 16:24:48-04	23	\N
2118	1	586	63d096d3	1966-07-29	2016-06-28 11:10:09-04	2015-07-24 23:19:19-04	23	\N
2119	1	585	6bc7ea86	1966-07-17	2016-06-28 11:10:09-04	2015-08-23 08:43:37-04	23	\N
2120	1	585	1bdca500	1966-07-16	2016-06-28 11:10:09-04	2015-07-20 11:34:04-04	23	\N
2121	1	585	13dca931	1966-07-03	2016-06-28 11:10:09-04	2015-07-20 11:34:05-04	23	\N
2122	1	548	7bc7eaa8	1966-05-19	2016-06-28 11:10:09-04	2015-07-20 11:34:06-04	23	\N
2123	1	587	63c7eab7	1966-04-24	2016-06-28 11:10:09-04	2015-09-21 01:40:08-04	23	\N
2124	1	587	6bc7eab2	1966-04-22	2016-06-28 11:10:09-04	2015-08-23 08:45:56-04	23	\N
2125	1	588	7bd096dc	1966-03-25	2016-06-28 11:10:09-04	2015-07-24 23:18:33-04	23	\N
2126	1	589	73c7eabd	1966-03-18	2016-06-28 11:10:09-04	2016-01-09 23:16:57-05	23	\N
2127	1	590	3dca933	1966-03-12	2016-06-28 11:10:09-04	2016-01-09 23:16:22-05	23	\N
2128	1	591	7bc7eab8	1966-03-03	2016-06-28 11:10:09-04	2015-09-19 16:40:10-04	23	\N
2129	1	592	6bc7eaba	1966-02-25	2016-06-28 11:10:09-04	2015-11-29 12:49:16-05	23	\N
2130	1	487	73c7eac9	1966-01-13	2016-06-28 11:10:09-04	2015-08-23 08:47:26-04	23	\N
2131	1	585	3de4943	1966-01-08	2016-06-28 11:10:09-04	2014-11-04 16:52:30-05	23	\N
2132	1	487	63c7eac3	1966-01-07	2016-06-28 11:10:09-04	2015-09-21 01:38:08-04	23	\N
2133	1	487	73dcbea9	1966-01-06	2016-06-28 11:10:09-04	2015-09-21 01:37:41-04	23	\N
2134	1	593	43dbbf2b	1965-12-18	2016-06-28 11:10:09-04	2015-12-19 01:50:22-05	23	\N
2135	1	594	53dbbf35	1965-12-11	2016-06-28 11:10:09-04	2015-12-19 01:51:39-05	23	\N
2136	1	585	4bdbbf36	1965-12-10	2016-06-28 11:10:09-04	2015-12-19 01:53:08-05	23	\N
2137	1	595	43dbbf43	1965-05-05	2016-06-28 11:10:09-04	2015-12-19 10:26:00-05	23	\N
\.


--
-- Name: setlist_song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('setlist_song_id_seq', 779, true);


--
-- Data for Name: setlist_songs; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY setlist_songs (id, artist_id, name, slug, created_at, updated_at, upstream_identifier) FROM stdin;
231	2	St. Stephen	st-stephen	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	St. Stephen
232	2	The Music Never Stopped	the-music-never-stopped	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	The Music Never Stopped
233	2	Bertha	bertha	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Bertha
234	2	Black-Throated Wind	black-throated-wind	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Black-Throated Wind
235	2	Peggy-O	peggy-o	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Peggy-O
236	2	Box of Rain	box-of-rain	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Box of Rain
237	2	Going Down the Road Feelin' Bad	going-down-the-road-feelin-bad	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Going Down the Road Feelin' Bad
238	2	Truckin'	truckin	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Truckin'
239	2	He's Gone	hes-gone	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	He's Gone
240	2	Help on the Way	help-on-the-way	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Help on the Way
241	2	Slipknot!	slipknot	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Slipknot!
242	2	Franklin's Tower	franklins-tower	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Franklin's Tower
243	2	Drums	drums	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Drums
244	2	Space	space	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Space
245	2	Days Between	days-between	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Days Between
246	2	China Cat Sunflower	china-cat-sunflower	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	China Cat Sunflower
247	2	I Know You Rider	i-know-you-rider	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	I Know You Rider
248	2	Samson and Delilah	samson-and-delilah	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	Samson and Delilah
249	2	Shakedown Street	shakedown-street	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Shakedown Street
250	2	Jack Straw	jack-straw	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Jack Straw
251	2	Althea	althea	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Althea
252	2	Loose Lucy	loose-lucy	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Loose Lucy
253	2	Ramble On Rose	ramble-on-rose	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Ramble On Rose
254	2	Sugaree	sugaree	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Sugaree
255	2	Passenger	passenger	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Passenger
256	2	Casey Jones	casey-jones	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Casey Jones
257	2	Dark Star	dark-star	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Dark Star
258	2	Friend of the Devil	friend-of-the-devil	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Friend of the Devil
259	2	Scarlet Begonias	scarlet-begonias	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Scarlet Begonias
260	2	Fire on the Mountain	fire-on-the-mountain	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Fire on the Mountain
261	2	The Other One	the-other-one	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	The Other One
262	2	Wharf Rat	wharf-rat	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Wharf Rat
263	2	Throwing Stones	throwing-stones	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Throwing Stones
264	2	Ripple	ripple	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	Ripple
265	2	One More Saturday Night	one-more-saturday-night	2016-06-28 10:28:06-04	2016-06-28 14:28:05.940464-04	One More Saturday Night
266	2	Cold Rain and Snow	cold-rain-and-snow	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Cold Rain and Snow
267	2	New Speedway Boogie	new-speedway-boogie	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	New Speedway Boogie
268	2	El Paso	el-paso	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	El Paso
269	2	They Love Each Other	they-love-each-other	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	They Love Each Other
270	2	Candyman	candyman	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Candyman
271	2	Bird Song	bird-song	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Bird Song
272	2	Don't Ease Me In	dont-ease-me-in	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Don't Ease Me In
273	2	Lost Sailor	lost-sailor	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Lost Sailor
274	2	Saint of Circumstance	saint-of-circumstance	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Saint of Circumstance
275	2	Viola Lee Blues	viola-lee-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Viola Lee Blues
276	2	Terrapin Station	terrapin-station	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Terrapin Station
277	2	Dear Prudence	dear-prudence	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Dear Prudence
278	2	Sugar Magnolia	sugar-magnolia	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Sugar Magnolia
279	2	Black Muddy River	black-muddy-river	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04	Black Muddy River
280	2	Space... Lotsa space...	space-lotsa-space	2016-06-28 10:28:06-04	2016-06-28 14:28:05.965225-04	Space... Lotsa space...
281	2	Feel Like a Stranger	feel-like-a-stranger	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Feel Like a Stranger
282	2	Here Comes Sunshine	here-comes-sunshine	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Here Comes Sunshine
283	2	Brown Eyed Women	brown-eyed-women	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Brown Eyed Women
284	2	Loser	loser	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Loser
285	2	Little Red Rooster	little-red-rooster	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Little Red Rooster
286	2	Cassidy	cassidy	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Cassidy
287	2	Deal	deal	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Deal
288	2	Iko Iko	iko-iko	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Iko Iko
289	2	Estimated Prophet	estimated-prophet	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Estimated Prophet
290	2	Uncle John's Band	uncle-johns-band	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Uncle John's Band
291	2	Good Lovin'	good-lovin	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Good Lovin'
292	2	Brokedown Palace	brokedown-palace	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Brokedown Palace
293	2	Johnny B. Goode	johnny-b-goode	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04	Johnny B. Goode
294	2	West L.A. Fadeaway	west-la-fadeaway	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	West L.A. Fadeaway
295	2	Row Jimmy	row-jimmy	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Row Jimmy
296	2	Crazy Fingers	crazy-fingers	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Crazy Fingers
297	2	I Need a Miracle	i-need-a-miracle	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	I Need a Miracle
298	2	Big Railroad Blues	big-railroad-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Big Railroad Blues
299	2	Playing in the Band	playing-in-the-band	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Playing in the Band
300	2	The Wheel	the-wheel	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	The Wheel
301	2	Eyes of the World	eyes-of-the-world	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Eyes of the World
302	2	Standing on the Moon	standing-on-the-moon	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Standing on the Moon
303	2	Let It Grow	let-it-grow	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Let It Grow
304	2	All Along the Watchtower	all-along-the-watchtower	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	All Along the Watchtower
305	2	Morning Dew	morning-dew	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Morning Dew
306	2	Not Fade Away	not-fade-away	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04	Not Fade Away
307	2	Minglewood Blues	minglewood-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:05.991361-04	Minglewood Blues
308	2	Cumberland Blues	cumberland-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:05.991361-04	Cumberland Blues
385	1	Let It Grow	let-it-grow	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Let It Grow
309	2	A Hard Rain's A-Gonna Fall	a-hard-rains-a-gonna-fall	2016-06-28 10:28:06-04	2016-06-28 14:28:05.991361-04	A Hard Rain's A-Gonna Fall
310	2	Looks Like Rain	looks-like-rain	2016-06-28 10:28:06-04	2016-06-28 14:28:05.991361-04	Looks Like Rain
311	2	Jam	jam	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Jam
312	2	Hell in a Bucket	hell-in-a-bucket	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Hell in a Bucket
313	2	Me and My Uncle	me-and-my-uncle	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Me and My Uncle
314	2	Big River	big-river	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Big River
315	2	Mississippi Half-Step Uptown Toodeloo	mississippi-half-step-uptown-toodeloo	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Mississippi Half-Step Uptown Toodeloo
316	2	Stella Blue	stella-blue	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	Stella Blue
317	2	U.S. Blues	us-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04	U.S. Blues
318	2	Smokestack Lightning	smokestack-lightning	2016-06-28 10:28:06-04	2016-06-28 14:28:06.010912-04	Smokestack Lightning
319	2	Tennessee Jed	tennessee-jed	2016-06-28 10:28:06-04	2016-06-28 14:28:06.010912-04	Tennessee Jed
320	2	Touch of Grey	touch-of-grey	2016-06-28 10:28:06-04	2016-06-28 14:28:06.010912-04	Touch of Grey
321	2	Liberty	liberty	2016-06-28 10:28:06-04	2016-06-28 14:28:06.019823-04	Liberty
322	2	The Promised Land	the-promised-land	2016-06-28 10:28:06-04	2016-06-28 14:28:06.019823-04	The Promised Land
323	2	Black Peter	black-peter	2016-06-28 10:28:06-04	2016-06-28 14:28:06.019823-04	Black Peter
324	2	Turn On Your Love Light	turn-on-your-love-light	2016-06-28 10:28:06-04	2016-06-28 14:28:06.019823-04	Turn On Your Love Light
325	2	Queen Jane Approximately	queen-jane-approximately	2016-06-28 10:28:06-04	2016-06-28 14:28:06.027024-04	Queen Jane Approximately
326	2	In the Midnight Hour	in-the-midnight-hour	2016-06-28 10:28:06-04	2016-06-28 14:28:06.040775-04	In the Midnight Hour
327	2	Sunshine Daydream	sunshine-daydream	2016-06-28 10:28:06-04	2016-06-28 14:28:06.040775-04	Sunshine Daydream
328	2	Shakey Ground	shakey-ground	2016-06-28 10:28:06-04	2016-06-28 14:28:06.055879-04	Shakey Ground
329	2	Cryptical Envelopment	cryptical-envelopment	2016-06-28 10:28:06-04	2016-06-28 14:28:06.069478-04	Cryptical Envelopment
330	2	Big Boss Man	big-boss-man	2016-06-28 10:28:06-04	2016-06-28 14:28:06.118451-04	Big Boss Man
331	2	Mexicali Blues	mexicali-blues	2016-06-28 10:28:06-04	2016-06-28 14:28:06.118451-04	Mexicali Blues
332	2	Ship of Fools	ship-of-fools	2016-06-28 10:28:06-04	2016-06-28 14:28:06.145236-04	Ship of Fools
333	2	Wang Dang Doodle	wang-dang-doodle	2016-06-28 10:28:06-04	2016-06-28 14:28:06.158801-04	Wang Dang Doodle
334	2	China Doll	china-doll	2016-06-28 10:28:06-04	2016-06-28 14:28:06.158801-04	China Doll
335	2	Get Out of My Life, Woman	get-out-of-my-life-woman	2016-06-28 10:28:06-04	2016-06-28 14:28:06.166757-04	Get Out of My Life, Woman
336	2	Werewolves of London	werewolves-of-london	2016-06-28 10:28:06-04	2016-06-28 14:28:06.198544-04	Werewolves of London
337	1	China Cat Sunflower	china-cat-sunflower	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	China Cat Sunflower
338	1	I Know You Rider	i-know-you-rider	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	I Know You Rider
339	1	Estimated Prophet	estimated-prophet	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Estimated Prophet
340	1	Built to Last	built-to-last	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Built to Last
341	1	Samson and Delilah	samson-and-delilah	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Samson and Delilah
342	1	Mountains of the Moon	mountains-of-the-moon	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Mountains of the Moon
343	1	Throwing Stones	throwing-stones	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Throwing Stones
344	1	Truckin'	truckin	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Truckin'
345	1	Cassidy	cassidy	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Cassidy
346	1	Althea	althea	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Althea
347	1	Terrapin Station	terrapin-station	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Terrapin Station
348	1	Drums	drums	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Drums
349	1	Space	space	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Space
350	1	Unbroken Chain	unbroken-chain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Unbroken Chain
351	1	Days Between	days-between	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Days Between
352	1	Not Fade Away	not-fade-away	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Not Fade Away
353	1	Touch of Grey	touch-of-grey	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Touch of Grey
354	1	Attics of My Life	attics-of-my-life	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	Attics of My Life
355	1	Shakedown Street	shakedown-street	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Shakedown Street
356	1	Liberty	liberty	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Liberty
357	1	Standing on the Moon	standing-on-the-moon	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Standing on the Moon
358	1	Me and My Uncle	me-and-my-uncle	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Me and My Uncle
359	1	Tennessee Jed	tennessee-jed	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Tennessee Jed
360	1	Cumberland Blues	cumberland-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Cumberland Blues
361	1	Little Red Rooster	little-red-rooster	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Little Red Rooster
362	1	Friend of the Devil	friend-of-the-devil	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Friend of the Devil
363	1	Deal	deal	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Deal
364	1	Bird Song	bird-song	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Bird Song
365	1	The Golden Road (To Unlimited Devotion)	the-golden-road-to-unlimited-devotion	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	The Golden Road (To Unlimited Devotion)
366	1	Lost Sailor	lost-sailor	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Lost Sailor
367	1	Saint of Circumstance	saint-of-circumstance	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Saint of Circumstance
368	1	West L.A. Fadeaway	west-la-fadeaway	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	West L.A. Fadeaway
369	1	Foolish Heart	foolish-heart	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Foolish Heart
370	1	Stella Blue	stella-blue	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	Stella Blue
371	1	One More Saturday Night	one-more-saturday-night	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	One More Saturday Night
372	1	U.S. Blues	us-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.869679-04	U.S. Blues
373	1	Box of Rain	box-of-rain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Box of Rain
374	1	Jack Straw	jack-straw	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Jack Straw
375	1	Bertha	bertha	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Bertha
376	1	Passenger	passenger	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Passenger
377	1	The Wheel	the-wheel	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	The Wheel
378	1	Crazy Fingers	crazy-fingers	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Crazy Fingers
379	1	The Music Never Stopped	the-music-never-stopped	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	The Music Never Stopped
380	1	Mason's Children	masons-children	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Mason's Children
381	1	Scarlet Begonias	scarlet-begonias	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Scarlet Begonias
382	1	Fire on the Mountain	fire-on-the-mountain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Fire on the Mountain
383	1	New Potato Caboose	new-potato-caboose	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	New Potato Caboose
384	1	Playing in the Band	playing-in-the-band	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Playing in the Band
386	1	Help on the Way	help-on-the-way	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Help on the Way
387	1	Slipknot!	slipknot	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Slipknot!
388	1	Franklin's Tower	franklins-tower	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Franklin's Tower
389	1	Ripple	ripple	2016-06-28 11:08:51-04	2016-06-28 15:08:50.883928-04	Ripple
390	1	Feel Like a Stranger	feel-like-a-stranger	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Feel Like a Stranger
391	1	Minglewood Blues	minglewood-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Minglewood Blues
392	1	Brown-Eyed Women	brown-eyed-women	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Brown-Eyed Women
393	1	Loose Lucy	loose-lucy	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Loose Lucy
394	1	Loser	loser	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Loser
395	1	Row Jimmy	row-jimmy	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Row Jimmy
396	1	Alabama Getaway	alabama-getaway	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Alabama Getaway
397	1	Black Peter	black-peter	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Black Peter
398	1	Hell in a Bucket	hell-in-a-bucket	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Hell in a Bucket
399	1	Mississippi Half-Step Uptown Toodeloo	mississippi-half-step-uptown-toodeloo	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Mississippi Half-Step Uptown Toodeloo
400	1	Wharf Rat	wharf-rat	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Wharf Rat
401	1	Eyes of the World	eyes-of-the-world	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Eyes of the World
402	1	He's Gone	hes-gone	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	He's Gone
403	1	I Need a Miracle	i-need-a-miracle	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	I Need a Miracle
404	1	Death Don't Have No Mercy	death-dont-have-no-mercy	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Death Don't Have No Mercy
405	1	Sugar Magnolia	sugar-magnolia	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Sugar Magnolia
406	1	Brokedown Palace	brokedown-palace	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04	Brokedown Palace
407	1	Uncle John's Band	uncle-johns-band	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Uncle John's Band
408	1	Alligator	alligator	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Alligator
409	1	Born Cross-Eyed	born-cross-eyed	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Born Cross-Eyed
410	1	Cream Puff War	cream-puff-war	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Cream Puff War
411	1	Viola Lee Blues	viola-lee-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Viola Lee Blues
412	1	Cryptical Envelopment	cryptical-envelopment	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Cryptical Envelopment
413	1	Dark Star	dark-star	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Dark Star
414	1	St. Stephen	st-stephen	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	St. Stephen
415	1	The Eleven	the-eleven	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	The Eleven
416	1	Turn On Your Love Light	turn-on-your-love-light	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Turn On Your Love Light
417	1	What's Become of the Baby?	whats-become-of-the-baby	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	What's Become of the Baby?
418	1	The Other One	the-other-one	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	The Other One
419	1	Morning Dew	morning-dew	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Morning Dew
420	1	Casey Jones	casey-jones	2016-06-28 11:08:51-04	2016-06-28 15:08:50.911117-04	Casey Jones
421	1	Lazy River Road	lazy-river-road	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	Lazy River Road
422	1	When I Paint My Masterpiece	when-i-paint-my-masterpiece	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	When I Paint My Masterpiece
423	1	Childhood's End	childhoods-end	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	Childhood's End
424	1	The Promised Land	the-promised-land	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	The Promised Land
425	1	So Many Roads	so-many-roads	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	So Many Roads
426	1	Samba in the Rain	samba-in-the-rain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	Samba in the Rain
427	1	Corrina	corrina	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	Corrina
428	1	Black Muddy River	black-muddy-river	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	Black Muddy River
429	1	Sugaree	sugaree	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Sugaree
430	1	Wang Dang Doodle	wang-dang-doodle	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Wang Dang Doodle
431	1	Queen Jane Approximately	queen-jane-approximately	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Queen Jane Approximately
432	1	Eternity	eternity	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Eternity
433	1	Don't Ease Me In	dont-ease-me-in	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Don't Ease Me In
434	1	It's All Too Much	its-all-too-much	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	It's All Too Much
435	1	Visions of Johanna	visions-of-johanna	2016-06-28 11:08:51-04	2016-06-28 15:08:50.933767-04	Visions of Johanna
436	1	Take Me to the River	take-me-to-the-river	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04	Take Me to the River
437	1	Big Boss Man	big-boss-man	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04	Big Boss Man
438	1	Big River	big-river	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04	Big River
439	1	The Last Time	the-last-time	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04	The Last Time
440	1	Around and Around	around-and-around	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04	Around and Around
441	1	Peggy-O	peggy-o	2016-06-28 11:08:51-04	2016-06-28 15:08:50.952604-04	Peggy-O
442	1	The Same Thing	the-same-thing	2016-06-28 11:08:51-04	2016-06-28 15:08:50.952604-04	The Same Thing
443	1	El Paso	el-paso	2016-06-28 11:08:51-04	2016-06-28 15:08:50.952604-04	El Paso
444	1	Iko Iko	iko-iko	2016-06-28 11:08:51-04	2016-06-28 15:08:50.952604-04	Iko Iko
445	1	Going Down the Road Feelin' Bad	going-down-the-road-feelin-bad	2016-06-28 11:08:51-04	2016-06-28 15:08:50.952604-04	Going Down the Road Feelin' Bad
446	1	Here Comes Sunshine	here-comes-sunshine	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Here Comes Sunshine
447	1	Walkin' Blues	walkin-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Walkin' Blues
448	1	Dire Wolf	dire-wolf	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Dire Wolf
449	1	It's All Over Now	its-all-over-now	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	It's All Over Now
450	1	Broken Arrow	broken-arrow	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Broken Arrow
451	1	Desolation Row	desolation-row	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Desolation Row
452	1	Victim or the Crime	victim-or-the-crime	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Victim or the Crime
453	1	New Speedway Boogie	new-speedway-boogie	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	New Speedway Boogie
454	1	Quinn the Eskimo (The Mighty Quinn)	quinn-the-eskimo-the-mighty-quinn	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04	Quinn the Eskimo (The Mighty Quinn)
455	1	Candyman	candyman	2016-06-28 11:08:51-04	2016-06-28 15:08:50.97159-04	Candyman
456	1	Rain	rain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.97159-04	Rain
457	1	Looks Like Rain	looks-like-rain	2016-06-28 11:08:51-04	2016-06-28 15:08:50.97159-04	Looks Like Rain
458	1	Gloria	gloria	2016-06-28 11:08:51-04	2016-06-28 15:08:50.97159-04	Gloria
459	1	Good Morning, School Girl	good-morning-school-girl	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Good Morning, School Girl
460	1	Black-Throated Wind	black-throated-wind	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Black-Throated Wind
461	1	Just Like Tom Thumb's Blues	just-like-tom-thumbs-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Just Like Tom Thumb's Blues
462	1	Big Railroad Blues	big-railroad-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Big Railroad Blues
463	1	Way to Go Home	way-to-go-home	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Way to Go Home
464	1	Easy Answers	easy-answers	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Easy Answers
465	1	Good Lovin'	good-lovin	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Good Lovin'
466	1	Lucy in the Sky With Diamonds	lucy-in-the-sky-with-diamonds	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04	Lucy in the Sky With Diamonds
467	1	Greatest Story Ever Told	greatest-story-ever-told	2016-06-28 11:08:51-04	2016-06-28 15:08:50.991662-04	Greatest Story Ever Told
468	1	Ramble On Rose	ramble-on-rose	2016-06-28 11:08:51-04	2016-06-28 15:08:50.991662-04	Ramble On Rose
469	1	Jam	jam	2016-06-28 11:08:51-04	2016-06-28 15:08:50.991662-04	Jam
470	1	Jack-A-Roe	jack-a-roe	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Jack-A-Roe
471	1	Mama Tried	mama-tried	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Mama Tried
472	1	Mexicali Blues	mexicali-blues	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Mexicali Blues
473	1	Picasso Moon	picasso-moon	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Picasso Moon
474	1	Ship of Fools	ship-of-fools	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Ship of Fools
475	1	Rollin' and Tumblin'	rollin-and-tumblin	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04	Rollin' and Tumblin'
476	1	That Would Be Something	that-would-be-something	2016-06-28 11:08:51-04	2016-06-28 15:08:51.008861-04	That Would Be Something
477	1	The Days Between	the-days-between	2016-06-28 11:08:51-04	2016-06-28 15:08:51.008861-04	The Days Between
478	1	It Must Have Been the Roses	it-must-have-been-the-roses	2016-06-28 11:08:51-04	2016-06-28 15:08:51.018099-04	It Must Have Been the Roses
479	1	All Along the Watchtower	all-along-the-watchtower	2016-06-28 11:08:51-04	2016-06-28 15:08:51.018099-04	All Along the Watchtower
480	1	I Fought the Law	i-fought-the-law	2016-06-28 11:08:51-04	2016-06-28 15:08:51.018099-04	I Fought the Law
481	1	Man Smart, Woman Smarter	man-smart-woman-smarter	2016-06-28 11:08:51-04	2016-06-28 15:08:51.027021-04	Man Smart, Woman Smarter
482	1	Cold Rain and Snow	cold-rain-and-snow	2016-06-28 11:08:51-04	2016-06-28 15:08:51.03417-04	Cold Rain and Snow
483	1	Matilda, Matilda	matilda-matilda	2016-06-28 11:08:51-04	2016-06-28 15:08:51.03417-04	Matilda, Matilda
484	1	Stagger Lee	stagger-lee	2016-06-28 11:08:51-04	2016-06-28 15:08:51.041813-04	Stagger Lee
485	1	Spanish Jam	spanish-jam	2016-06-28 11:08:51-04	2016-06-28 15:08:51.041813-04	Spanish Jam
486	1	Let the Good Times Roll	let-the-good-times-roll	2016-06-28 11:08:51-04	2016-06-28 15:08:51.11473-04	Let the Good Times Roll
487	1	I Want to Tell You	i-want-to-tell-you	2016-06-28 11:08:51-04	2016-06-28 15:08:51.141419-04	I Want to Tell You
488	1	The Race Is On	the-race-is-on	2016-06-28 11:08:51-04	2016-06-28 15:08:51.157325-04	The Race Is On
489	1	Maggie's Farm	maggies-farm	2016-06-28 11:08:51-04	2016-06-28 15:08:51.178491-04	Maggie's Farm
490	1	Johnny B. Goode	johnny-b-goode	2016-06-28 11:08:51-04	2016-06-28 15:08:51.178491-04	Johnny B. Goode
491	1	Stuck Inside of Mobile With the Memphis Blues Again	stuck-inside-of-mobile-with-the-memphis-blues-again	2016-06-28 11:08:51-04	2016-06-28 15:08:51.192331-04	Stuck Inside of Mobile With the Memphis Blues Again
492	1	High Time	high-time	2016-06-28 11:08:51-04	2016-06-28 15:08:51.268792-04	High Time
493	1	If the Shoe Fits	if-the-shoe-fits	2016-06-28 11:08:51-04	2016-06-28 15:08:51.268792-04	If the Shoe Fits
494	1	The Weight	the-weight	2016-06-28 11:08:51-04	2016-06-28 15:08:51.277037-04	The Weight
495	1	Salt Lake City	salt-lake-city	2016-06-28 11:08:51-04	2016-06-28 15:08:51.330447-04	Salt Lake City
496	1	I Just Want to Make Love to You	i-just-want-to-make-love-to-you	2016-06-28 11:08:51-04	2016-06-28 15:08:51.330447-04	I Just Want to Make Love to You
497	1	It's All Over Now, Baby Blue	its-all-over-now-baby-blue	2016-06-28 11:08:51-04	2016-06-28 15:08:51.344411-04	It's All Over Now, Baby Blue
498	1	Nobody's Fault but Mine	nobodys-fault-but-mine	2016-06-28 11:08:51-04	2016-06-28 15:08:51.35203-04	Nobody's Fault but Mine
499	1	Spoonful	spoonful	2016-06-28 11:08:51-04	2016-06-28 15:08:51.398732-04	Spoonful
500	1	Baba O'Riley	baba-oriley	2016-06-28 11:08:51-04	2016-06-28 15:08:51.461682-04	Baba O'Riley
501	1	Tomorrow Never Knows	tomorrow-never-knows	2016-06-28 11:08:51-04	2016-06-28 15:08:51.461682-04	Tomorrow Never Knows
502	1	Smokestack Lightning	smokestack-lightning	2016-06-28 11:08:51-04	2016-06-28 15:08:51.474811-04	Smokestack Lightning
503	1	In the Midnight Hour	in-the-midnight-hour	2016-06-28 11:08:51-04	2016-06-28 15:08:51.483421-04	In the Midnight Hour
504	1	Rainy Day Women #12 & 35	rainy-day-women-12-35	2016-06-28 11:08:51-04	2016-06-28 15:08:51.483421-04	Rainy Day Women #12 & 35
505	1	Dupree's Diamond Blues	duprees-diamond-blues	2016-06-28 11:08:52-04	2016-06-28 15:08:51.504437-04	Dupree's Diamond Blues
506	1	China Doll	china-doll	2016-06-28 11:08:52-04	2016-06-28 15:08:51.511608-04	China Doll
507	1	Comes a Time	comes-a-time	2016-06-28 11:08:52-04	2016-06-28 15:08:51.525489-04	Comes a Time
508	1	Beat It On Down the Line	beat-it-on-down-the-line	2016-06-28 11:08:52-04	2016-06-28 15:08:51.55316-04	Beat It On Down the Line
509	1	They Love Each Other	they-love-each-other	2016-06-28 11:08:52-04	2016-06-28 15:08:51.625657-04	They Love Each Other
510	1	K.C. Moan	kc-moan	2016-06-28 11:08:52-04	2016-06-28 15:08:51.633113-04	K.C. Moan
511	1	(I Can't Get No) Satisfaction	i-cant-get-no-satisfaction	2016-06-28 11:08:52-04	2016-06-28 15:08:51.673476-04	(I Can't Get No) Satisfaction
512	1	Knockin' on Heaven's Door	knockin-on-heavens-door	2016-06-28 11:08:52-04	2016-06-28 15:08:51.714693-04	Knockin' on Heaven's Door
513	1	Sunshine Daydream	sunshine-daydream	2016-06-28 11:08:52-04	2016-06-28 15:08:51.876832-04	Sunshine Daydream
514	1	I'm a King Bee	im-a-king-bee	2016-06-28 11:08:52-04	2016-06-28 15:08:51.931001-04	I'm a King Bee
515	1	Might as Well	might-as-well	2016-06-28 11:08:52-04	2016-06-28 15:08:52.012562-04	Might as Well
516	1	Wave to the Wind	wave-to-the-wind	2016-06-28 11:08:52-04	2016-06-28 15:08:52.172282-04	Wave to the Wind
517	1	Tubular Bells	tubular-bells	2016-06-28 11:08:52-04	2016-06-28 15:08:52.273476-04	Tubular Bells
518	1	Supplication	supplication	2016-06-28 11:08:53-04	2016-06-28 15:08:52.540075-04	Supplication
519	1	The Star-Spangled Banner	the-star-spangled-banner	2016-06-28 11:08:53-04	2016-06-28 15:08:52.575928-04	The Star-Spangled Banner
520	1	The Handsome Cabin Boy Jam	the-handsome-cabin-boy-jam	2016-06-28 11:08:53-04	2016-06-28 15:08:52.733742-04	The Handsome Cabin Boy Jam
521	1	To Lay Me Down	to-lay-me-down	2016-06-28 11:08:53-04	2016-06-28 15:08:52.928796-04	To Lay Me Down
522	1	See See Rider	see-see-rider	2016-06-28 11:08:53-04	2016-06-28 15:08:53.205497-04	See See Rider
523	1	It Takes a Lot to Laugh, It Takes a Train to Cry	it-takes-a-lot-to-laugh-it-takes-a-train-to-cry	2016-06-28 11:08:53-04	2016-06-28 15:08:53.205497-04	It Takes a Lot to Laugh, It Takes a Train to Cry
524	1	Stander on the Mountain	stander-on-the-mountain	2016-06-28 11:08:53-04	2016-06-28 15:08:53.324298-04	Stander on the Mountain
525	1	Born on the Bayou	born-on-the-bayou	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04	Born on the Bayou
526	1	Green River	green-river	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04	Green River
527	1	Bad Moon Rising	bad-moon-rising	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04	Bad Moon Rising
528	1	Proud Mary	proud-mary	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04	Proud Mary
529	1	Forever Young	forever-young	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04	Forever Young
530	1	Werewolves of London	werewolves-of-london	2016-06-28 11:08:53-04	2016-06-28 15:08:53.352106-04	Werewolves of London
531	1	Hey! Bo Diddley	hey-bo-diddley	2016-06-28 11:08:53-04	2016-06-28 15:08:53.404217-04	Hey! Bo Diddley
532	1	Mona	mona	2016-06-28 11:08:53-04	2016-06-28 15:08:53.404217-04	Mona
533	1	And We Bid You Goodnight	and-we-bid-you-goodnight	2016-06-28 11:08:53-04	2016-06-28 15:08:53.414732-04	And We Bid You Goodnight
534	1	Rubin and Cherise	rubin-and-cherise	2016-06-28 11:08:54-04	2016-06-28 15:08:53.69886-04	Rubin and Cherise
535	1	Stir It Up	stir-it-up	2016-06-28 11:08:54-04	2016-06-28 15:08:53.939422-04	Stir It Up
536	1	The Valley Road	the-valley-road	2016-06-28 11:08:54-04	2016-06-28 15:08:53.99195-04	The Valley Road
537	1	Spoonful Jam	spoonful-jam	2016-06-28 11:08:54-04	2016-06-28 15:08:54.195166-04	Spoonful Jam
538	1	Phil & Keyboards Jam	phil-keyboards-jam	2016-06-28 11:08:54-04	2016-06-28 15:08:54.195166-04	Phil & Keyboards Jam
539	1	Gimme Some Lovin'	gimme-some-lovin	2016-06-28 11:08:54-04	2016-06-28 15:08:54.203173-04	Gimme Some Lovin'
540	1	Never Trust a Woman	never-trust-a-woman	2016-06-28 11:08:54-04	2016-06-28 15:08:54.283059-04	Never Trust a Woman
541	1	Far From Me	far-from-me	2016-06-28 11:08:54-04	2016-06-28 15:08:54.291582-04	Far From Me
542	1	Hey Pocky A-Way	hey-pocky-a-way	2016-06-28 11:08:54-04	2016-06-28 15:08:54.291582-04	Hey Pocky A-Way
543	1	Just a Little Light	just-a-little-light	2016-06-28 11:08:54-04	2016-06-28 15:08:54.301048-04	Just a Little Light
544	1	Dear Mr. Fantasy	dear-mr-fantasy	2016-06-28 11:08:54-04	2016-06-28 15:08:54.301048-04	Dear Mr. Fantasy
545	1	Easy to Love You	easy-to-love-you	2016-06-28 11:08:54-04	2016-06-28 15:08:54.316689-04	Easy to Love You
546	1	Blow Away	blow-away	2016-06-28 11:08:54-04	2016-06-28 15:08:54.325316-04	Blow Away
547	1	I Will Take You Home	i-will-take-you-home	2016-06-28 11:08:54-04	2016-06-28 15:08:54.333957-04	I Will Take You Home
548	1	Hey Jude	hey-jude	2016-06-28 11:08:54-04	2016-06-28 15:08:54.341443-04	Hey Jude
549	1	We Can Run	we-can-run	2016-06-28 11:08:54-04	2016-06-28 15:08:54.350963-04	We Can Run
550	1	Revolution	revolution	2016-06-28 11:08:55-04	2016-06-28 15:08:54.515709-04	Revolution
551	1	Mind Left Body Jam	mind-left-body-jam	2016-06-28 11:08:55-04	2016-06-28 15:08:54.537312-04	Mind Left Body Jam
552	1	Believe It or Not	believe-it-or-not	2016-06-28 11:08:55-04	2016-06-28 15:08:54.545353-04	Believe It or Not
553	1	I'm a Man	im-a-man	2016-06-28 11:08:55-04	2016-06-28 15:08:54.673643-04	I'm a Man
554	1	California Earthquake (A Whole Lotta Shakin' Goin' On)	california-earthquake-a-whole-lotta-shakin-goin-on	2016-06-28 11:08:55-04	2016-06-28 15:08:54.71354-04	California Earthquake (A Whole Lotta Shakin' Goin' On)
555	1	When Push Comes to Shove	when-push-comes-to-shove	2016-06-28 11:08:55-04	2016-06-28 15:08:54.895439-04	When Push Comes to Shove
556	1	Hide Away	hide-away	2016-06-28 11:08:55-04	2016-06-28 15:08:55.00472-04	Hide Away
557	1	Louie Louie	louie-louie	2016-06-28 11:08:55-04	2016-06-28 15:08:55.201305-04	Louie Louie
558	1	How Long Blues	how-long-blues	2016-06-28 11:08:55-04	2016-06-28 15:08:55.268082-04	How Long Blues
559	1	The Monkey and the Engineer	the-monkey-and-the-engineer	2016-06-28 11:08:55-04	2016-06-28 15:08:55.268082-04	The Monkey and the Engineer
560	1	Happy Birthday	happy-birthday	2016-06-28 11:08:55-04	2016-06-28 15:08:55.375969-04	Happy Birthday
561	1	Chinese Bones	chinese-bones	2016-06-28 11:08:55-04	2016-06-28 15:08:55.436791-04	Chinese Bones
562	1	Neighborhood Girls	neighborhood-girls	2016-06-28 11:08:55-04	2016-06-28 15:08:55.436791-04	Neighborhood Girls
563	1	Everytime You Go Away	everytime-you-go-away	2016-06-28 11:08:55-04	2016-06-28 15:08:55.436791-04	Everytime You Go Away
564	1	What's Going On	whats-going-on	2016-06-28 11:08:55-04	2016-06-28 15:08:55.436791-04	What's Going On
565	1	Gentlemen Start Your Engines	gentlemen-start-your-engines	2016-06-28 11:08:56-04	2016-06-28 15:08:55.585026-04	Gentlemen Start Your Engines
566	1	Blackbird	blackbird	2016-06-28 11:08:56-04	2016-06-28 15:08:55.605434-04	Blackbird
567	1	Green Onions	green-onions	2016-06-28 11:08:56-04	2016-06-28 15:08:55.67041-04	Green Onions
568	1	Mexican Hat Dance	mexican-hat-dance	2016-06-28 11:08:56-04	2016-06-28 15:08:55.709623-04	Mexican Hat Dance
569	1	Funiculì funiculà	funicul-funicul	2016-06-28 11:08:56-04	2016-06-28 15:08:55.756963-04	Funiculì funiculà
570	1	Ballad of a Thin Man	ballad-of-a-thin-man	2016-06-28 11:08:56-04	2016-06-28 15:08:55.86642-04	Ballad of a Thin Man
571	1	So What	so-what	2016-06-28 11:08:56-04	2016-06-28 15:08:55.892629-04	So What
572	1	Day-O (The Banana Boat Song)	day-o-the-banana-boat-song	2016-06-28 11:08:56-04	2016-06-28 15:08:55.959401-04	Day-O (The Banana Boat Song)
573	1	Devil With a Blue Dress On	devil-with-a-blue-dress-on	2016-06-28 11:08:56-04	2016-06-28 15:08:56.068803-04	Devil With a Blue Dress On
574	1	Good Golly Miss Molly	good-golly-miss-molly	2016-06-28 11:08:56-04	2016-06-28 15:08:56.068803-04	Good Golly Miss Molly
575	1	My Brother Esau	my-brother-esau	2016-06-28 11:08:56-04	2016-06-28 15:08:56.075569-04	My Brother Esau
576	1	Tons of Steel	tons-of-steel	2016-06-28 11:08:56-04	2016-06-28 15:08:56.097706-04	Tons of Steel
577	1	La bamba	la-bamba	2016-06-28 11:08:56-04	2016-06-28 15:08:56.097706-04	La bamba
578	1	The Addams Family Theme	the-addams-family-theme	2016-06-28 11:08:56-04	2016-06-28 15:08:56.105452-04	The Addams Family Theme
579	1	Walkin' the Dog	walkin-the-dog	2016-06-28 11:08:56-04	2016-06-28 15:08:56.131539-04	Walkin' the Dog
580	1	Tore Up Over You	tore-up-over-you	2016-06-28 11:08:56-04	2016-06-28 15:08:56.131539-04	Tore Up Over You
581	1	Kansas City	kansas-city	2016-06-28 11:08:56-04	2016-06-28 15:08:56.131539-04	Kansas City
582	1	Fever	fever	2016-06-28 11:08:56-04	2016-06-28 15:08:56.201037-04	Fever
583	1	Dancing in the Street	dancing-in-the-street	2016-06-28 11:08:57-04	2016-06-28 15:08:56.56974-04	Dancing in the Street
584	1	Willie and the Hand Jive	willie-and-the-hand-jive	2016-06-28 11:08:57-04	2016-06-28 15:08:56.576581-04	Willie and the Hand Jive
585	1	Get Back	get-back	2016-06-28 11:08:57-04	2016-06-28 15:08:56.726176-04	Get Back
586	1	Don't Think Twice, It's All Right	dont-think-twice-its-all-right	2016-06-28 11:08:57-04	2016-06-28 15:08:56.798801-04	Don't Think Twice, It's All Right
587	1	Maybe You Know How I Feel	maybe-you-know-how-i-feel	2016-06-28 11:08:57-04	2016-06-28 15:08:56.914464-04	Maybe You Know How I Feel
588	1	My Baby Left Me	my-baby-left-me	2016-06-28 11:08:57-04	2016-06-28 15:08:56.926609-04	My Baby Left Me
589	1	That's All Right	thats-all-right	2016-06-28 11:08:57-04	2016-06-28 15:08:56.926609-04	That's All Right
590	1	Don't Need Love	dont-need-love	2016-06-28 11:08:57-04	2016-06-28 15:08:56.935259-04	Don't Need Love
591	1	Day Job	day-job	2016-06-28 11:08:57-04	2016-06-28 15:08:56.949548-04	Day Job
592	1	(I'm a) Road Runner	im-a-road-runner	2016-06-28 11:08:57-04	2016-06-28 15:08:56.967914-04	(I'm a) Road Runner
593	1	Why Don't We Do It in the Road?	why-dont-we-do-it-in-the-road	2016-06-28 11:08:57-04	2016-06-28 15:08:56.973944-04	Why Don't We Do It in the Road?
594	1	Revolutionary Hamstrung Blues	revolutionary-hamstrung-blues	2016-06-28 11:08:57-04	2016-06-28 15:08:56.989511-04	Revolutionary Hamstrung Blues
595	1	Keep On Growing	keep-on-growing	2016-06-28 11:08:57-04	2016-06-28 15:08:57.065694-04	Keep On Growing
596	1	Big Boy Pete	big-boy-pete	2016-06-28 11:08:57-04	2016-06-28 15:08:57.114631-04	Big Boy Pete
597	1	She Belongs to Me	she-belongs-to-me	2016-06-28 11:08:57-04	2016-06-28 15:08:57.114631-04	She Belongs to Me
598	1	Baby What You Want Me to Do	baby-what-you-want-me-to-do	2016-06-28 11:08:57-04	2016-06-28 15:08:57.180061-04	Baby What You Want Me to Do
599	1	The Frozen Logger	the-frozen-logger	2016-06-28 11:08:57-04	2016-06-28 15:08:57.295343-04	The Frozen Logger
600	1	Day Tripper	day-tripper	2016-06-28 11:08:57-04	2016-06-28 15:08:57.384777-04	Day Tripper
601	1	Down in the Bottom	down-in-the-bottom	2016-06-28 11:08:57-04	2016-06-28 15:08:57.427938-04	Down in the Bottom
602	1	I Ain't Superstitious	i-aint-superstitious	2016-06-28 11:08:57-04	2016-06-28 15:08:57.427938-04	I Ain't Superstitious
603	1	Lazy Lightning	lazy-lightning	2016-06-28 11:08:58-04	2016-06-28 15:08:57.752622-04	Lazy Lightning
604	1	On the Road Again	on-the-road-again	2016-06-28 11:08:58-04	2016-06-28 15:08:57.813118-04	On the Road Again
605	1	New Orleans	new-orleans	2016-06-28 11:08:58-04	2016-06-28 15:08:58.003783-04	New Orleans
606	1	Only a Fool	only-a-fool	2016-06-28 11:08:58-04	2016-06-28 15:08:58.133546-04	Only a Fool
607	1	Blues for Allah	blues-for-allah	2016-06-28 11:08:58-04	2016-06-28 15:08:58.241785-04	Blues for Allah
608	1	Oh Babe, It Ain't No Lie	oh-babe-it-aint-no-lie	2016-06-28 11:08:58-04	2016-06-28 15:08:58.255051-04	Oh Babe, It Ain't No Lie
609	1	Goodnight, Irene	goodnight-irene	2016-06-28 11:08:58-04	2016-06-28 15:08:58.263173-04	Goodnight, Irene
610	1	Deep Elem Blues	deep-elem-blues	2016-06-28 11:08:58-04	2016-06-28 15:08:58.398176-04	Deep Elem Blues
611	1	Love the One You're With	love-the-one-youre-with	2016-06-28 11:08:59-04	2016-06-28 15:08:58.754294-04	Love the One You're With
612	1	Black Queen	black-queen	2016-06-28 11:08:59-04	2016-06-28 15:08:58.763039-04	Black Queen
613	1	Tell Mama	tell-mama	2016-06-28 11:08:59-04	2016-06-28 15:08:58.847313-04	Tell Mama
614	1	Hard to Handle	hard-to-handle	2016-06-28 11:08:59-04	2016-06-28 15:08:58.847313-04	Hard to Handle
615	1	A Mind to Give Up Livin'	a-mind-to-give-up-livin	2016-06-28 11:08:59-04	2016-06-28 15:08:59.155148-04	A Mind to Give Up Livin'
616	1	Me and Bobby McGee	me-and-bobby-mcgee	2016-06-28 11:08:59-04	2016-06-28 15:08:59.362418-04	Me and Bobby McGee
617	1	Bye Bye Love	bye-bye-love	2016-06-28 11:08:59-04	2016-06-28 15:08:59.362418-04	Bye Bye Love
618	1	Lucifer's Eyes	lucifers-eyes	2016-06-28 11:08:59-04	2016-06-28 15:08:59.362418-04	Lucifer's Eyes
619	1	(For the) Children of the Eighties	for-the-children-of-the-eighties	2016-06-28 11:08:59-04	2016-06-28 15:08:59.362418-04	(For the) Children of the Eighties
620	1	Banks of the Ohio	banks-of-the-ohio	2016-06-28 11:08:59-04	2016-06-28 15:08:59.362418-04	Banks of the Ohio
621	1	Lady Di and I	lady-di-and-i	2016-06-28 11:08:59-04	2016-06-28 15:08:59.372846-04	Lady Di and I
622	1	Barbara Allen	barbara-allen	2016-06-28 11:08:59-04	2016-06-28 15:08:59.372846-04	Barbara Allen
623	1	Warriors of the Sun	warriors-of-the-sun	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04	Warriors of the Sun
624	1	Marriott USA	marriott-usa	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04	Marriott USA
625	1	Where Have the Heroes Gone	where-have-the-heroes-gone	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04	Where Have the Heroes Gone
626	1	Oh, Boy!	oh-boy	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04	Oh, Boy!
627	1	The Boxer	the-boxer	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04	The Boxer
628	1	Mack the Knife	mack-the-knife	2016-06-28 11:09:00-04	2016-06-28 15:08:59.519374-04	Mack the Knife
629	1	Hully Gully	hully-gully	2016-06-28 11:09:00-04	2016-06-28 15:08:59.555038-04	Hully Gully
630	1	Been All Around This World	been-all-around-this-world	2016-06-28 11:09:00-04	2016-06-28 15:08:59.59233-04	Been All Around This World
631	1	Dark Hollow	dark-hollow	2016-06-28 11:09:00-04	2016-06-28 15:09:00.143626-04	Dark Hollow
632	1	Heaven Help the Fool	heaven-help-the-fool	2016-06-28 11:09:00-04	2016-06-28 15:09:00.46621-04	Heaven Help the Fool
633	1	Sage and Spirit	sage-and-spirit	2016-06-28 11:09:00-04	2016-06-28 15:09:00.46621-04	Sage and Spirit
634	1	Little Sadie	little-sadie	2016-06-28 11:09:00-04	2016-06-28 15:09:00.46621-04	Little Sadie
635	1	Rosalie McFall	rosalie-mcfall	2016-06-28 11:09:00-04	2016-06-28 15:09:00.497937-04	Rosalie McFall
636	1	Caution (Do Not Stop on Tracks)	caution-do-not-stop-on-tracks	2016-06-28 11:09:02-04	2016-06-28 15:09:01.498933-04	Caution (Do Not Stop on Tracks)
637	1	Ollin Arageed	ollin-arageed	2016-06-28 11:09:02-04	2016-06-28 15:09:01.615263-04	Ollin Arageed
638	1	Linda Lu	linda-lu	2016-06-28 11:09:02-04	2016-06-28 15:09:01.765525-04	Linda Lu
639	1	From the Heart of Me	from-the-heart-of-me	2016-06-28 11:09:02-04	2016-06-28 15:09:01.771531-04	From the Heart of Me
640	1	If I Had the World to Give	if-i-had-the-world-to-give	2016-06-28 11:09:02-04	2016-06-28 15:09:02.106879-04	If I Had the World to Give
641	1	Got My Mojo Working	got-my-mojo-working	2016-06-28 11:09:02-04	2016-06-28 15:09:02.153077-04	Got My Mojo Working
642	1	Sunrise	sunrise	2016-06-28 11:09:02-04	2016-06-28 15:09:02.189918-04	Sunrise
643	1	Close Encounters	close-encounters	2016-06-28 11:09:03-04	2016-06-28 15:09:02.567759-04	Close Encounters
644	1	Terrapin Transit	terrapin-transit	2016-06-28 11:09:03-04	2016-06-28 15:09:03.210749-04	Terrapin Transit
645	1			2016-06-28 11:09:03-04	2016-06-28 15:09:03.302913-04	
646	1	Cosmic Charlie	cosmic-charlie	2016-06-28 11:09:03-04	2016-06-28 15:09:03.318984-04	Cosmic Charlie
647	1	Stronger Than Dirt	stronger-than-dirt	2016-06-28 11:09:03-04	2016-06-28 15:09:03.411094-04	Stronger Than Dirt
648	1	Mission in the Rain	mission-in-the-rain	2016-06-28 11:09:03-04	2016-06-28 15:09:03.44077-04	Mission in the Rain
649	1	King Solomon's Marbles	king-solomons-marbles	2016-06-28 11:09:04-04	2016-06-28 15:09:03.612676-04	King Solomon's Marbles
650	1	Tomorrow Is Forever	tomorrow-is-forever	2016-06-28 11:09:04-04	2016-06-28 15:09:03.63797-04	Tomorrow Is Forever
651	1	Weather Report Suite	weather-report-suite	2016-06-28 11:09:04-04	2016-06-28 15:09:03.647833-04	Weather Report Suite
652	1	Seastones	seastones	2016-06-28 11:09:04-04	2016-06-28 15:09:03.647833-04	Seastones
653	1	Let It Rock	let-it-rock	2016-06-28 11:09:04-04	2016-06-28 15:09:03.876142-04	Let It Rock
654	1	It's a Sin	its-a-sin	2016-06-28 11:09:04-04	2016-06-28 15:09:03.898897-04	It's a Sin
655	1	Money Money	money-money	2016-06-28 11:09:04-04	2016-06-28 15:09:03.965114-04	Money Money
656	1	You Ain't Woman Enough (To Take My Man)	you-aint-woman-enough-to-take-my-man	2016-06-28 11:09:04-04	2016-06-28 15:09:04.272331-04	You Ain't Woman Enough (To Take My Man)
657	1	Sing Me Back Home	sing-me-back-home	2016-06-28 11:09:04-04	2016-06-28 15:09:04.288331-04	Sing Me Back Home
658	1	Let Me Sing Your Blues Away	let-me-sing-your-blues-away	2016-06-28 11:09:04-04	2016-06-28 15:09:04.332067-04	Let Me Sing Your Blues Away
659	1	Beer Barrel Polka	beer-barrel-polka	2016-06-28 11:09:04-04	2016-06-28 15:09:04.375283-04	Beer Barrel Polka
660	1	Wave That Flag	wave-that-flag	2016-06-28 11:09:04-04	2016-06-28 15:09:04.469377-04	Wave That Flag
661	1	Weather Report Suite Prelude	weather-report-suite-prelude	2016-06-28 11:09:05-04	2016-06-28 15:09:04.54737-04	Weather Report Suite Prelude
662	1	Philo Stomp	philo-stomp	2016-06-28 11:09:05-04	2016-06-28 15:09:04.929901-04	Philo Stomp
663	1	Rockin' Pneumonia and the Boogie Woogie Flu	rockin-pneumonia-and-the-boogie-woogie-flu	2016-06-28 11:09:05-04	2016-06-28 15:09:04.940321-04	Rockin' Pneumonia and the Boogie Woogie Flu
664	1	26 Miles (Santa Catalina)	26-miles-santa-catalina	2016-06-28 11:09:05-04	2016-06-28 15:09:05.027713-04	26 Miles (Santa Catalina)
665	1	You Win Again	you-win-again	2016-06-28 11:09:05-04	2016-06-28 15:09:05.123088-04	You Win Again
666	1	Mr. Charlie	mr-charlie	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04	Mr. Charlie
667	1	Next Time You See Me	next-time-you-see-me	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04	Next Time You See Me
668	1	The Stranger (Two Souls in Communion)	the-stranger-two-souls-in-communion	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04	The Stranger (Two Souls in Communion)
669	1	Chinatown Shuffle	chinatown-shuffle	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04	Chinatown Shuffle
670	1	Sitting on Top of the World	sitting-on-top-of-the-world	2016-06-28 11:09:05-04	2016-06-28 15:09:05.32847-04	Sitting on Top of the World
671	1	It Hurts Me Too	it-hurts-me-too	2016-06-28 11:09:05-04	2016-06-28 15:09:05.338937-04	It Hurts Me Too
672	1	Who Do You Love?	who-do-you-love	2016-06-28 11:09:05-04	2016-06-28 15:09:05.384754-04	Who Do You Love?
673	1	Sidewalks of New York	sidewalks-of-new-york	2016-06-28 11:09:06-04	2016-06-28 15:09:05.547589-04	Sidewalks of New York
674	1	Take It Off	take-it-off	2016-06-28 11:09:06-04	2016-06-28 15:09:05.571316-04	Take It Off
675	1	How Sweet It Is (To Be Loved by You)	how-sweet-it-is-to-be-loved-by-you	2016-06-28 11:09:06-04	2016-06-28 15:09:05.571316-04	How Sweet It Is (To Be Loved by You)
676	1	Are You Lonely for Me	are-you-lonely-for-me	2016-06-28 11:09:06-04	2016-06-28 15:09:05.571316-04	Are You Lonely for Me
677	1	Your Love At Home	your-love-at-home	2016-06-28 11:09:06-04	2016-06-28 15:09:05.611206-04	Your Love At Home
678	1	Run Rudolph Run	run-rudolph-run	2016-06-28 11:09:06-04	2016-06-28 15:09:05.629224-04	Run Rudolph Run
679	1	Mannish Boy	mannish-boy	2016-06-28 11:09:06-04	2016-06-28 15:09:05.629224-04	Mannish Boy
680	1	I Washed My Hands in Muddy Water	i-washed-my-hands-in-muddy-water	2016-06-28 11:09:06-04	2016-06-28 15:09:05.68021-04	I Washed My Hands in Muddy Water
681	1	The Rub	the-rub	2016-06-28 11:09:06-04	2016-06-28 15:09:05.738577-04	The Rub
682	1	That's It for the Other One	thats-it-for-the-other-one	2016-06-28 11:09:06-04	2016-06-28 15:09:05.777241-04	That's It for the Other One
683	1	Empty Pages	empty-pages	2016-06-28 11:09:06-04	2016-06-28 15:09:05.889746-04	Empty Pages
684	1	I Second That Emotion	i-second-that-emotion	2016-06-28 11:09:06-04	2016-06-28 15:09:06.016882-04	I Second That Emotion
685	1	Searchin'	searchin	2016-06-28 11:09:06-04	2016-06-28 15:09:06.037095-04	Searchin'
686	1	Riot in Cell Block #9	riot-in-cell-block-9	2016-06-28 11:09:06-04	2016-06-28 15:09:06.037095-04	Riot in Cell Block #9
687	1	Help Me, Rhonda	help-me-rhonda	2016-06-28 11:09:06-04	2016-06-28 15:09:06.037095-04	Help Me, Rhonda
688	1	Okie From Muskogee	okie-from-muskogee	2016-06-28 11:09:06-04	2016-06-28 15:09:06.037095-04	Okie From Muskogee
689	1	I'm a Hog for You	im-a-hog-for-you	2016-06-28 11:09:06-04	2016-06-28 15:09:06.190403-04	I'm a Hog for You
690	1	Easy Wind	easy-wind	2016-06-28 11:09:06-04	2016-06-28 15:09:06.204732-04	Easy Wind
691	1	Till the Morning Comes	till-the-morning-comes	2016-06-28 11:09:06-04	2016-06-28 15:09:06.391443-04	Till the Morning Comes
692	1	The Ballad of Casey Jones	the-ballad-of-casey-jones	2016-06-28 11:09:06-04	2016-06-28 15:09:06.446036-04	The Ballad of Casey Jones
693	1	Angie	angie	2016-06-28 11:09:06-04	2016-06-28 15:09:06.458892-04	Angie
694	1	Let Me In	let-me-in	2016-06-28 11:09:06-04	2016-06-28 15:09:06.458892-04	Let Me In
695	1	Darling Corey	darling-corey	2016-06-28 11:09:06-04	2016-06-28 15:09:06.463799-04	Darling Corey
696	1	John's Other	johns-other	2016-06-28 11:09:06-04	2016-06-28 15:09:06.473974-04	John's Other
697	1	Operator	operator	2016-06-28 11:09:06-04	2016-06-28 15:09:06.489527-04	Operator
698	1	Wake Up Little Susie	wake-up-little-susie	2016-06-28 11:09:06-04	2016-06-28 15:09:06.489527-04	Wake Up Little Susie
699	1	Mystery Train	mystery-train	2016-06-28 11:09:06-04	2016-06-28 15:09:06.489527-04	Mystery Train
700	1	My Babe	my-babe	2016-06-28 11:09:06-04	2016-06-28 15:09:06.489527-04	My Babe
701	1	The Main Ten	the-main-ten	2016-06-28 11:09:06-04	2016-06-28 15:09:06.489527-04	The Main Ten
702	1	Mountain Jam	mountain-jam	2016-06-28 11:09:07-04	2016-06-28 15:09:06.507429-04	Mountain Jam
703	1	Silver Threads and Golden Needles	silver-threads-and-golden-needles	2016-06-28 11:09:07-04	2016-06-28 15:09:06.629436-04	Silver Threads and Golden Needles
704	1	Cold Jordan	cold-jordan	2016-06-28 11:09:07-04	2016-06-28 15:09:06.629436-04	Cold Jordan
705	1	Swing Low, Sweet Chariot	swing-low-sweet-chariot	2016-06-28 11:09:07-04	2016-06-28 15:09:06.629436-04	Swing Low, Sweet Chariot
706	1	It's a Man's Man's Man's World	its-a-mans-mans-mans-world	2016-06-28 11:09:07-04	2016-06-28 15:09:06.655524-04	It's a Man's Man's Man's World
707	1	Tell It to Me	tell-it-to-me	2016-06-28 11:09:07-04	2016-06-28 15:09:06.667056-04	Tell It to Me
708	1	Drink Up and Go Home	drink-up-and-go-home	2016-06-28 11:09:07-04	2016-06-28 15:09:06.731911-04	Drink Up and Go Home
709	1	A Voice From on High	a-voice-from-on-high	2016-06-28 11:09:07-04	2016-06-28 15:09:06.731911-04	A Voice From on High
710	1	Katie Mae	katie-mae	2016-06-28 11:09:07-04	2016-06-28 15:09:06.754539-04	Katie Mae
711	1	She's Mine	shes-mine	2016-06-28 11:09:07-04	2016-06-28 15:09:06.754539-04	She's Mine
712	1	So Sad	so-sad	2016-06-28 11:09:07-04	2016-06-28 15:09:06.763756-04	So Sad
713	1	Long Black Limousine	long-black-limousine	2016-06-28 11:09:07-04	2016-06-28 15:09:06.871829-04	Long Black Limousine
714	1	Will the Circle Be Unbroken?	will-the-circle-be-unbroken	2016-06-28 11:09:07-04	2016-06-28 15:09:06.895158-04	Will the Circle Be Unbroken?
715	1	Feedback	feedback	2016-06-28 11:09:07-04	2016-06-28 15:09:06.926508-04	Feedback
716	1	Sawmill	sawmill	2016-06-28 11:09:07-04	2016-06-28 15:09:06.973284-04	Sawmill
717	1	Roberta	roberta	2016-06-28 11:09:07-04	2016-06-28 15:09:06.973284-04	Roberta
718	1	Big Breasa	big-breasa	2016-06-28 11:09:07-04	2016-06-28 15:09:06.973284-04	Big Breasa
719	1	Walk Down the Street	walk-down-the-street	2016-06-28 11:09:07-04	2016-06-28 15:09:06.981633-04	Walk Down the Street
720	1	The Flood	the-flood	2016-06-28 11:09:07-04	2016-06-28 15:09:06.981633-04	The Flood
721	1	Cathy's Clown	cathys-clown	2016-06-28 11:09:07-04	2016-06-28 15:09:06.988247-04	Cathy's Clown
722	1	Cowboy Song	cowboy-song	2016-06-28 11:09:07-04	2016-06-28 15:09:07.015834-04	Cowboy Song
723	1	He Was a Friend of Mine	he-was-a-friend-of-mine	2016-06-28 11:09:07-04	2016-06-28 15:09:07.038436-04	He Was a Friend of Mine
724	1	The Seven	the-seven	2016-06-28 11:09:07-04	2016-06-28 15:09:07.038436-04	The Seven
725	1	Yellow Dog Story	yellow-dog-story	2016-06-28 11:09:07-04	2016-06-28 15:09:07.118321-04	Yellow Dog Story
726	1	Seasons of My Heart	seasons-of-my-heart	2016-06-28 11:09:07-04	2016-06-28 15:09:07.118321-04	Seasons of My Heart
727	1	Green, Green Grass of Home	green-green-grass-of-home	2016-06-28 11:09:07-04	2016-06-28 15:09:07.149497-04	Green, Green Grass of Home
728	1	Bound in Memories	bound-in-memories	2016-06-28 11:09:07-04	2016-06-28 15:09:07.175812-04	Bound in Memories
729	1	Slewfoot	slewfoot	2016-06-28 11:09:07-04	2016-06-28 15:09:07.258838-04	Slewfoot
730	1	The Master's Bouquet	the-masters-bouquet	2016-06-28 11:09:07-04	2016-06-28 15:09:07.286657-04	The Master's Bouquet
731	1	The Eleven Jam	the-eleven-jam	2016-06-28 11:09:07-04	2016-06-28 15:09:07.384765-04	The Eleven Jam
732	1	Feelin' Groovy Jam	feelin-groovy-jam	2016-06-28 11:09:07-04	2016-06-28 15:09:07.420608-04	Feelin' Groovy Jam
733	1	Doin' That Rag	doin-that-rag	2016-06-28 11:09:07-04	2016-06-28 15:09:07.474936-04	Doin' That Rag
734	1	Peggy Sue	peggy-sue	2016-06-28 11:09:07-04	2016-06-28 15:09:07.485493-04	Peggy Sue
735	1	That'll Be the Day	thatll-be-the-day	2016-06-28 11:09:07-04	2016-06-28 15:09:07.485493-04	That'll Be the Day
736	1	Wipe Out	wipe-out	2016-06-28 11:09:07-04	2016-06-28 15:09:07.485493-04	Wipe Out
737	1	Twist and Shout	twist-and-shout	2016-06-28 11:09:07-04	2016-06-28 15:09:07.485493-04	Twist and Shout
738	1	Blue Moon	blue-moon	2016-06-28 11:09:07-04	2016-06-28 15:09:07.485493-04	Blue Moon
739	1	Hi-Heel Sneakers	hi-heel-sneakers	2016-06-28 11:09:08-04	2016-06-28 15:09:07.506016-04	Hi-Heel Sneakers
740	1	New Minglewood Blues	new-minglewood-blues	2016-06-28 11:09:08-04	2016-06-28 15:09:07.514052-04	New Minglewood Blues
741	1	The Things I Used to Do	the-things-i-used-to-do	2016-06-28 11:09:08-04	2016-06-28 15:09:07.617959-04	The Things I Used to Do
742	1	Who's Lovin' You Tonight	whos-lovin-you-tonight	2016-06-28 11:09:08-04	2016-06-28 15:09:07.617959-04	Who's Lovin' You Tonight
743	1	Checkin' Up on My Baby	checkin-up-on-my-baby	2016-06-28 11:09:08-04	2016-06-28 15:09:07.627928-04	Checkin' Up on My Baby
744	1	Foxy Lady	foxy-lady	2016-06-28 11:09:08-04	2016-06-28 15:09:07.732295-04	Foxy Lady
745	1	Clementine	clementine	2016-06-28 11:09:08-04	2016-06-28 15:09:07.925016-04	Clementine
746	1	Rosemary	rosemary	2016-06-28 11:09:08-04	2016-06-28 15:09:07.996723-04	Rosemary
747	1	Look on Yonder Wall	look-on-yonder-wall	2016-06-28 11:09:08-04	2016-06-28 15:09:08.042972-04	Look on Yonder Wall
748	1	Prisoner Blues	prisoner-blues	2016-06-28 11:09:08-04	2016-06-28 15:09:08.048618-04	Prisoner Blues
749	1	Betty & Dupree	betty-dupree	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	Betty & Dupree
750	1	See That My Grave Is Kept Clean	see-that-my-grave-is-kept-clean	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	See That My Grave Is Kept Clean
751	1	Alice D. Millionaire	alice-d-millionaire	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	Alice D. Millionaire
752	1	You Won't Find Me	you-wont-find-me	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	You Won't Find Me
753	1	It's My Own Fault	its-my-own-fault	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	It's My Own Fault
754	1	Down So Long	down-so-long	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	Down So Long
755	1	There Is Something on Your Mind	there-is-something-on-your-mind	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	There Is Something on Your Mind
756	1	Lindy	lindy	2016-06-28 11:10:09-04	2016-06-28 15:10:08.547056-04	Lindy
757	1	Stealin'	stealin	2016-06-28 11:10:09-04	2016-06-28 15:10:08.558186-04	Stealin'
758	1	Early Morning Rain	early-morning-rain	2016-06-28 11:10:09-04	2016-06-28 15:10:08.558186-04	Early Morning Rain
759	1	Good Morning, Little Schoolgirl	good-morning-little-schoolgirl	2016-06-28 11:10:09-04	2016-06-28 15:10:08.558186-04	Good Morning, Little Schoolgirl
760	1	Pain in My Heart	pain-in-my-heart	2016-06-28 11:10:09-04	2016-06-28 15:10:08.563953-04	Pain in My Heart
761	1	Standing on the Corner	standing-on-the-corner	2016-06-28 11:10:09-04	2016-06-28 15:10:08.626987-04	Standing on the Corner
762	1	You Don't Have to Ask	you-dont-have-to-ask	2016-06-28 11:10:09-04	2016-06-28 15:10:08.626987-04	You Don't Have to Ask
763	1	Cardboard Cowboy	cardboard-cowboy	2016-06-28 11:10:09-04	2016-06-28 15:10:08.626987-04	Cardboard Cowboy
764	1	Hey Little One	hey-little-one	2016-06-28 11:10:09-04	2016-06-28 15:10:08.63333-04	Hey Little One
765	1	In the Pines	in-the-pines	2016-06-28 11:10:09-04	2016-06-28 15:10:08.639325-04	In the Pines
766	1	Mindbender	mindbender	2016-06-28 11:10:09-04	2016-06-28 15:10:08.673044-04	Mindbender
767	1	Sick and Tired	sick-and-tired	2016-06-28 11:10:09-04	2016-06-28 15:10:08.673044-04	Sick and Tired
768	1	Tastebud	tastebud	2016-06-28 11:10:09-04	2016-06-28 15:10:08.673044-04	Tastebud
769	1	Blues Instrumental	blues-instrumental	2016-06-28 11:10:09-04	2016-06-28 15:10:08.682123-04	Blues Instrumental
770	1	Instrumental	instrumental	2016-06-28 11:10:09-04	2016-06-28 15:10:08.687436-04	Instrumental
771	1	You See a Broken Heart	you-see-a-broken-heart	2016-06-28 11:10:09-04	2016-06-28 15:10:08.691531-04	You See a Broken Heart
772	1	Heads Up	heads-up	2016-06-28 11:10:09-04	2016-06-28 15:10:08.691531-04	Heads Up
773	1	Teddy Bear Picnic	teddy-bear-picnic	2016-06-28 11:10:09-04	2016-06-28 15:10:08.701372-04	Teddy Bear Picnic
774	1	All of My Love	all-of-my-love	2016-06-28 11:10:09-04	2016-06-28 15:10:08.736827-04	All of My Love
775	1	I'll Go Crazy	ill-go-crazy	2016-06-28 11:10:09-04	2016-06-28 15:10:08.7422-04	I'll Go Crazy
776	1	Can't Come Down	cant-come-down	2016-06-28 11:10:09-04	2016-06-28 15:10:08.7422-04	Can't Come Down
777	1	Parchman Farm	parchman-farm	2016-06-28 11:10:09-04	2016-06-28 15:10:08.7422-04	Parchman Farm
778	1	The Only Time Is Now	the-only-time-is-now	2016-06-28 11:10:09-04	2016-06-28 15:10:08.7422-04	The Only Time Is Now
779	1	Off the Hook	off-the-hook	2016-06-28 11:10:09-04	2016-06-28 15:10:08.760574-04	Off the Hook
\.


--
-- Data for Name: setlist_songs_plays; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY setlist_songs_plays (played_setlist_song_id, played_setlist_show_id) FROM stdin;
231	75
232	75
233	75
234	75
235	75
236	75
237	75
238	75
239	75
240	75
241	75
242	75
243	75
244	75
245	75
246	75
247	75
248	75
243	76
244	76
249	76
250	76
251	76
252	76
253	76
254	76
255	76
256	76
257	76
258	76
259	76
260	76
261	76
262	76
263	76
264	76
265	76
243	77
244	77
266	77
267	77
268	77
269	77
270	77
271	77
272	77
273	77
274	77
275	77
276	77
277	77
278	77
279	77
280	78
243	79
244	79
245	79
246	79
247	79
281	79
282	79
283	79
284	79
285	79
286	79
287	79
288	79
289	79
290	79
291	79
292	79
293	79
233	80
243	80
244	80
249	80
264	80
294	80
295	80
296	80
297	80
298	80
299	80
300	80
301	80
302	80
303	80
304	80
305	80
306	80
231	81
234	81
237	81
239	81
243	81
244	81
251	81
253	81
257	81
267	81
273	81
274	81
279	81
307	81
308	81
309	81
310	81
236	82
243	82
244	82
246	82
247	82
250	82
254	82
275	82
278	82
283	82
290	82
311	82
312	82
313	82
314	82
315	82
316	82
317	82
233	83
238	83
240	83
241	83
242	83
243	83
244	83
249	83
255	83
256	83
259	83
260	83
261	83
262	83
271	83
276	83
299	83
311	83
318	83
319	83
320	83
232	84
243	84
244	84
258	84
266	84
269	84
281	84
286	84
287	84
289	84
301	84
321	84
322	84
323	84
324	84
231	85
245	85
246	85
247	85
252	85
254	85
257	85
261	85
266	85
283	85
289	85
292	85
298	85
312	85
325	85
233	86
251	86
259	86
260	86
306	86
249	87
283	87
231	88
243	88
244	88
252	88
253	88
254	88
257	88
259	88
260	88
269	88
276	88
277	88
278	88
281	88
290	88
292	88
312	88
320	88
326	88
327	88
233	89
243	89
244	89
246	89
247	89
249	89
251	89
258	89
261	89
262	89
271	89
275	89
282	89
284	89
294	89
299	89
307	89
324	89
232	90
240	90
241	90
242	90
243	90
244	90
250	90
267	90
270	90
273	90
274	90
292	90
300	90
306	90
310	90
313	90
315	90
319	90
328	90
234	91
237	91
238	91
239	91
243	91
244	91
248	91
256	91
264	91
266	91
283	91
286	91
287	91
289	91
301	91
302	91
317	91
323	91
240	92
241	92
242	92
243	92
244	92
252	92
253	92
254	92
259	92
260	92
261	92
265	92
286	92
287	92
292	92
294	92
305	92
319	92
324	92
329	92
231	93
234	93
243	93
244	93
249	93
250	93
251	93
256	93
257	93
262	93
264	93
278	93
290	93
295	93
299	93
303	93
232	94
235	94
238	94
239	94
243	94
244	94
246	94
247	94
271	94
276	94
281	94
283	94
285	94
301	94
306	94
312	94
316	94
233	95
240	95
241	95
242	95
243	95
244	95
257	95
266	95
267	95
270	95
273	95
274	95
289	95
291	95
313	95
318	95
320	95
323	95
237	96
243	96
244	96
250	96
253	96
256	96
258	96
259	96
260	96
265	96
277	96
290	96
295	96
308	96
312	96
329	96
330	96
331	96
232	97
234	97
243	97
244	97
249	97
254	97
264	97
269	97
276	97
278	97
283	97
288	97
300	97
301	97
303	97
307	97
310	97
238	98
243	98
244	98
246	98
247	98
251	98
252	98
267	98
268	98
275	98
287	98
289	98
293	98
294	98
299	98
311	98
316	98
319	98
231	99
233	99
240	99
241	99
242	99
243	99
244	99
266	99
272	99
281	99
284	99
286	99
290	99
292	99
297	99
305	99
306	99
322	99
239	100
243	100
244	100
249	100
250	100
258	100
259	100
260	100
261	100
262	100
265	100
273	100
274	100
296	100
312	100
313	100
332	100
243	101
244	101
246	101
247	101
271	101
283	101
285	101
291	101
299	101
300	101
301	101
302	101
308	101
315	101
319	101
320	101
323	101
233	102
238	102
243	102
244	102
251	102
256	102
257	102
267	102
268	102
275	102
278	102
282	102
307	102
317	102
322	102
333	102
334	102
232	103
235	103
237	103
243	103
244	103
253	103
254	103
264	103
276	103
277	103
286	103
287	103
289	103
290	103
295	103
314	103
335	103
231	104
239	104
240	104
241	104
242	104
243	104
244	104
249	104
250	104
261	104
266	104
269	104
292	104
297	104
306	104
316	104
319	104
233	105
238	105
243	105
244	105
259	105
260	105
273	105
274	105
283	105
284	105
294	105
300	105
301	105
310	105
320	105
326	105
330	105
243	106
244	106
246	106
247	106
252	106
256	106
270	106
271	106
278	106
281	106
282	106
288	106
299	106
302	106
308	106
315	106
317	106
233	107
237	107
243	107
244	107
248	107
249	107
254	107
257	107
258	107
259	107
260	107
262	107
264	107
290	107
296	107
299	107
307	107
238	108
243	108
244	108
246	108
247	108
250	108
251	108
253	108
265	108
267	108
276	108
283	108
286	108
287	108
289	108
301	108
305	108
333	108
336	108
232	109
239	109
240	109
241	109
242	109
243	109
244	109
261	109
266	109
271	109
273	109
274	109
281	109
299	109
306	109
316	109
319	109
320	109
337	110
338	110
339	110
340	110
341	110
342	110
343	110
344	110
345	110
346	110
347	110
348	110
349	110
350	110
351	110
352	110
353	110
354	110
348	111
349	111
355	111
356	111
357	111
358	111
359	111
360	111
361	111
362	111
363	111
364	111
365	111
366	111
367	111
368	111
369	111
370	111
371	111
372	111
348	112
349	112
375	112
373	112
378	112
382	112
388	112
386	112
374	112
385	112
380	112
383	112
376	112
384	112
389	112
381	112
387	112
379	112
377	112
348	113
349	113
396	113
397	113
406	113
392	113
404	113
401	113
390	113
398	113
402	113
403	113
393	113
394	113
391	113
399	113
395	113
405	113
400	113
344	114
348	114
349	114
360	114
408	114
409	114
420	114
410	114
412	114
413	114
419	114
414	114
415	114
418	114
416	114
407	114
411	114
417	114
341	115
348	115
349	115
350	115
353	115
355	115
360	115
361	115
373	115
405	115
428	115
423	115
427	115
421	115
426	115
425	115
424	115
422	115
337	116
338	116
346	116
347	116
348	116
349	116
359	116
367	116
371	116
372	116
374	116
418	116
433	116
432	116
434	116
431	116
429	116
435	116
430	116
344	117
345	117
348	117
349	117
350	117
356	117
358	117
370	117
392	117
401	117
402	117
399	117
426	117
440	117
437	117
438	117
436	117
439	117
343	118
348	118
349	118
352	118
378	118
384	118
390	118
393	118
428	118
423	118
427	118
433	118
443	118
445	118
444	118
441	118
442	118
348	119
349	119
354	119
359	119
382	119
385	119
381	119
405	119
434	119
450	119
451	119
448	119
446	119
449	119
453	119
454	119
452	119
447	119
347	120
348	120
349	120
357	120
364	120
368	120
373	120
398	120
403	120
426	120
424	120
422	120
436	120
455	120
456	120
457	120
458	120
337	121
338	121
339	121
348	121
349	121
354	121
379	121
394	121
399	121
407	121
462	121
460	121
464	121
465	121
459	121
461	121
466	121
463	121
348	122
349	122
356	122
357	122
369	122
375	122
391	122
405	122
427	122
421	122
433	122
432	122
434	122
431	122
439	122
452	122
467	122
469	122
468	122
341	123
344	123
348	123
349	123
352	123
355	123
373	123
406	123
393	123
400	123
426	123
430	123
456	123
470	123
471	123
472	123
473	123
475	123
474	123
346	124
348	124
349	124
361	124
362	124
367	124
371	124
374	124
428	124
425	124
424	124
443	124
444	124
453	124
463	124
476	124
477	124
339	125
347	125
348	125
349	125
353	125
388	125
386	125
387	125
379	125
397	125
426	125
425	125
422	125
440	125
447	125
479	125
480	125
478	125
348	126
349	126
372	126
382	126
384	126
381	126
398	126
394	126
395	126
419	126
424	126
434	126
436	126
450	126
464	126
481	126
343	127
348	127
349	127
350	127
358	127
370	127
406	127
418	127
416	127
427	127
421	127
426	127
433	127
438	127
444	127
449	127
459	127
468	127
482	127
483	127
337	128
338	128
341	128
348	128
349	128
352	128
363	128
375	128
401	128
390	128
403	128
400	128
432	128
442	128
466	128
463	128
485	128
484	128
344	129
348	129
349	129
353	129
356	129
357	129
373	129
402	129
393	129
405	129
426	129
424	129
430	129
443	129
441	129
446	129
460	129
468	129
475	129
476	129
345	130
348	130
349	130
350	130
352	130
375	130
406	130
401	130
403	130
393	130
421	130
431	130
430	130
441	130
452	130
471	130
472	130
477	130
484	130
337	131
338	131
343	131
346	131
348	131
349	131
356	131
361	131
370	131
371	131
373	131
384	131
392	131
398	131
407	131
426	131
432	131
450	131
484	131
348	132
349	132
357	132
364	132
367	132
396	132
402	132
424	132
440	132
443	132
453	132
455	132
464	132
459	132
466	132
463	132
467	132
468	132
476	132
347	133
348	133
349	133
355	133
356	133
359	133
379	133
405	133
426	133
439	133
448	133
447	133
457	133
460	133
461	133
470	133
477	133
486	133
341	134
348	134
349	134
373	134
378	134
374	134
385	134
397	134
392	134
395	134
427	134
422	134
430	134
440	134
441	134
463	134
479	134
348	135
349	135
356	135
370	135
382	135
388	135
386	135
384	135
381	135
387	135
393	135
407	135
433	135
432	135
442	135
464	135
465	135
343	136
345	136
348	136
349	136
352	136
359	136
369	136
375	136
377	136
390	136
402	136
426	136
443	136
441	136
454	136
452	136
459	136
339	137
348	137
349	137
353	137
358	137
364	137
367	137
372	137
403	137
391	137
400	137
416	137
421	137
438	137
444	137
463	137
487	137
341	138
348	138
349	138
350	138
356	138
361	138
368	138
374	138
401	138
405	138
418	138
427	138
425	138
424	138
461	138
468	138
477	138
337	139
338	139
344	139
348	139
349	139
359	139
371	139
399	139
419	139
421	139
426	139
422	139
432	139
439	139
476	139
481	139
488	139
346	140
348	140
349	140
357	140
362	140
363	140
384	140
407	140
431	140
430	140
440	140
446	140
464	140
466	140
463	140
473	140
348	141
349	141
350	141
352	141
361	141
367	141
372	141
374	141
401	141
393	141
427	141
426	141
424	141
422	141
435	141
441	141
464	141
477	141
344	142
348	142
349	142
353	142
358	142
379	142
403	142
395	142
419	142
407	142
430	142
446	142
463	142
476	142
483	142
484	142
490	142
489	142
347	143
348	143
349	143
370	143
390	143
391	143
427	143
433	143
429	143
440	143
444	143
454	143
452	143
460	143
464	143
468	143
339	144
346	144
348	144
349	144
350	144
352	144
355	144
359	144
378	144
400	144
424	144
432	144
439	144
442	144
446	144
491	144
348	145
349	145
357	145
363	145
367	145
369	145
371	145
377	145
401	145
398	145
423	145
421	145
422	145
436	145
455	145
463	145
479	145
337	146
338	146
343	146
348	146
349	146
353	146
362	146
396	146
402	146
393	146
416	146
426	146
431	146
435	146
450	146
457	146
464	146
459	146
466	146
476	146
345	147
348	147
349	147
350	147
352	147
357	147
372	147
388	147
386	147
374	147
387	147
392	147
403	147
395	147
427	147
447	147
470	147
471	147
472	147
483	147
348	148
349	148
385	148
384	148
405	148
407	148
425	148
429	148
444	148
449	148
463	148
473	148
477	148
480	148
339	149
341	149
347	149
348	149
349	149
358	149
361	149
378	149
419	149
418	149
421	149
433	149
432	149
434	149
438	149
468	149
482	149
490	149
348	150
349	150
356	150
364	150
397	150
401	150
390	150
391	150
426	150
424	150
440	150
439	150
446	150
460	150
481	150
484	150
492	150
493	150
348	151
349	151
350	151
382	151
381	151
394	151
399	151
427	151
425	151
430	151
443	151
464	151
465	151
469	151
477	151
482	151
483	151
494	151
348	152
349	152
354	152
359	152
367	152
369	152
375	152
374	152
379	152
402	152
416	152
421	152
422	152
442	152
454	152
452	152
487	152
341	153
348	153
349	153
350	153
352	153
370	153
378	153
396	153
406	153
403	153
427	153
425	153
433	153
447	153
464	153
463	153
483	153
348	154
349	154
368	154
371	154
384	154
398	154
407	154
424	154
434	154
435	154
439	154
443	154
444	154
456	154
461	154
468	154
470	154
337	155
338	155
344	155
348	155
349	155
357	155
393	155
405	155
421	155
426	155
432	155
431	155
430	155
441	155
446	155
453	155
466	155
479	155
339	156
341	156
348	156
349	156
352	156
368	156
373	156
401	156
403	156
421	156
433	156
431	156
444	156
471	156
472	156
474	156
477	156
486	156
347	157
348	157
349	157
363	157
371	157
390	157
391	157
395	157
400	157
418	157
441	157
453	157
452	157
457	157
464	157
461	157
466	157
346	158
348	158
349	158
367	158
372	158
382	158
388	158
386	158
385	158
381	158
387	158
393	158
416	158
427	158
422	158
435	158
442	158
463	158
344	159
348	159
349	159
356	159
359	159
362	159
369	159
379	159
405	159
426	159
425	159
435	159
430	159
450	159
460	159
476	159
496	159
495	159
343	160
345	160
348	160
349	160
352	160
361	160
370	160
375	160
373	160
384	160
401	160
394	160
407	160
421	160
439	160
443	160
456	160
467	160
468	160
337	161
338	161
339	161
341	161
348	161
349	161
354	161
358	161
374	161
396	161
403	161
433	161
429	161
438	161
453	161
447	161
490	161
493	161
497	161
348	162
349	162
361	162
363	162
367	162
406	162
403	162
416	162
425	162
422	162
450	162
453	162
464	162
468	162
473	162
477	162
481	162
484	162
498	162
346	163
347	163
348	163
349	163
353	163
354	163
378	163
385	163
384	163
393	163
439	163
443	163
452	163
447	163
461	163
467	163
490	163
497	163
339	164
348	164
349	164
401	164
398	164
402	164
391	164
400	164
418	164
423	164
426	164
425	164
433	164
432	164
465	164
466	164
482	164
348	165
349	165
355	165
356	165
358	165
369	165
395	165
419	165
407	165
427	165
421	165
424	165
430	165
439	165
463	165
472	165
343	166
346	166
347	166
348	166
349	166
352	166
357	166
358	166
364	166
374	166
384	166
406	166
407	166
423	166
444	166
455	166
464	166
489	166
341	167
348	167
349	167
356	167
359	167
361	167
388	167
386	167
387	167
401	167
405	167
421	167
426	167
424	167
446	167
460	167
477	167
479	167
493	167
344	168
348	168
349	168
373	168
382	168
381	168
379	168
390	168
402	168
393	168
443	168
442	168
450	168
463	168
468	168
476	168
484	168
490	168
337	169
338	169
348	169
349	169
360	169
375	169
418	169
427	169
425	169
433	169
432	169
440	169
449	169
457	169
466	169
470	169
497	169
499	169
343	170
348	170
349	170
352	170
364	170
367	170
406	170
401	170
398	170
394	170
422	170
429	170
430	170
446	170
463	170
477	170
479	170
493	170
339	171
345	171
347	171
348	171
349	171
353	171
356	171
357	171
358	171
368	171
378	171
403	171
393	171
416	171
421	171
426	171
431	171
438	171
452	171
467	171
485	171
348	172
349	172
359	172
370	172
374	172
384	172
405	172
407	172
425	172
439	172
443	172
444	172
441	172
447	172
464	172
497	172
500	172
501	172
341	173
347	173
348	173
349	173
364	173
367	173
370	173
375	173
406	173
390	173
405	173
425	173
443	173
463	173
470	173
493	173
499	173
343	174
344	174
345	174
346	174
348	174
349	174
352	174
372	174
388	174
386	174
387	174
402	174
423	174
426	174
433	174
444	174
442	174
477	174
502	174
339	175
348	175
349	175
359	175
362	175
378	175
377	175
401	175
391	175
419	175
424	175
432	175
441	175
479	175
481	175
503	175
504	175
348	176
349	176
355	176
357	176
361	176
363	176
371	176
439	176
446	176
453	176
452	176
455	176
460	176
464	176
461	176
463	176
484	176
487	176
348	177
349	177
354	177
356	177
368	177
373	177
382	177
374	177
381	177
403	177
416	177
427	177
421	177
426	177
431	177
443	177
457	177
468	177
348	178
349	178
353	178
369	178
385	178
384	178
393	178
394	178
400	178
418	178
407	178
422	178
430	178
471	178
472	178
490	178
497	178
505	178
348	179
349	179
363	179
401	179
402	179
405	179
421	179
426	179
449	179
464	179
466	179
470	179
473	179
481	179
492	179
493	179
506	179
339	180
346	180
347	180
348	180
349	180
352	180
370	180
388	180
386	180
387	180
393	180
432	180
444	180
451	180
447	180
479	180
480	180
341	181
343	181
348	181
349	181
358	181
367	181
375	181
398	181
403	181
416	181
425	181
424	181
438	181
450	181
446	181
456	181
463	181
474	181
484	181
499	181
507	181
348	182
349	182
359	182
369	182
379	182
392	182
390	182
419	182
427	182
426	182
429	182
439	182
443	182
442	182
452	182
476	182
490	182
337	183
338	183
344	183
348	183
349	183
356	183
391	183
399	183
400	183
418	183
422	183
433	183
441	183
453	183
464	183
465	183
463	183
468	183
493	183
348	184
349	184
357	184
360	184
362	184
363	184
374	184
384	184
403	184
405	184
407	184
421	184
432	184
431	184
430	184
454	184
470	184
503	184
345	185
348	185
349	185
353	185
354	185
355	185
361	185
364	185
373	185
377	185
406	185
393	185
423	185
440	185
445	185
448	185
460	185
479	185
508	185
341	186
343	186
344	186
348	186
349	186
352	186
359	186
372	186
378	186
374	186
394	186
395	186
426	186
444	186
450	186
449	186
471	186
472	186
473	186
476	186
477	186
493	186
346	187
347	187
348	187
349	187
356	187
358	187
367	187
370	187
371	187
382	187
388	187
386	187
381	187
387	187
425	187
424	187
438	187
439	187
447	187
461	187
463	187
339	188
348	188
349	188
385	188
384	188
392	188
401	188
398	188
402	188
405	188
400	188
418	188
422	188
430	188
441	188
468	188
480	188
485	188
348	189
349	189
368	189
369	189
375	189
377	189
397	189
403	189
416	189
421	189
426	189
433	189
432	189
443	189
452	189
457	189
467	189
486	189
497	189
337	190
338	190
348	190
349	190
357	190
360	190
363	190
390	190
391	190
407	190
427	190
425	190
464	190
463	190
479	190
481	190
490	190
489	190
509	190
343	191
345	191
354	191
364	191
423	191
421	191
422	191
447	191
505	191
510	191
341	192
343	192
348	192
349	192
352	192
353	192
359	192
361	192
367	192
379	192
406	192
392	192
426	192
425	192
443	192
444	192
467	192
470	192
477	192
347	193
348	193
349	193
368	193
370	193
371	193
374	193
384	193
403	193
407	193
427	193
433	193
432	193
431	193
441	193
442	193
468	193
497	193
339	194
345	194
348	194
349	194
356	194
363	194
378	194
377	194
401	194
421	194
430	194
439	194
452	194
460	194
465	194
482	194
484	194
493	194
337	195
338	195
343	195
348	195
349	195
352	195
363	195
373	195
374	195
384	195
406	195
403	195
407	195
423	195
425	195
432	195
447	195
463	195
470	195
473	195
477	195
348	196
349	196
354	196
356	196
361	196
364	196
369	196
378	196
399	196
405	196
418	196
427	196
421	196
426	196
424	196
443	196
464	196
493	196
339	197
348	197
349	197
356	197
370	197
382	197
381	197
379	197
423	197
426	197
441	197
442	197
452	197
473	197
479	197
484	197
511	197
341	198
344	198
348	198
349	198
353	198
358	198
397	198
402	198
393	198
395	198
421	198
438	198
439	198
453	198
465	198
463	198
467	198
485	198
494	198
499	198
503	198
346	199
348	199
349	199
357	199
363	199
367	199
369	199
375	199
390	199
403	199
394	199
416	199
407	199
426	199
432	199
430	199
443	199
454	199
456	199
457	199
487	199
348	200
349	200
356	200
373	200
385	200
427	200
440	200
439	200
444	200
446	200
447	200
460	200
461	200
463	200
468	200
470	200
477	200
337	201
338	201
339	201
348	201
349	201
354	201
359	201
361	201
362	201
363	201
374	201
377	201
405	201
421	201
426	201
431	201
452	201
464	201
474	201
480	201
341	202
343	202
348	202
349	202
352	202
356	202
401	202
402	202
393	202
399	202
433	202
432	202
443	202
449	202
464	202
463	202
477	202
478	202
493	202
345	203
347	203
348	203
349	203
371	203
384	203
392	203
391	203
400	203
418	203
421	203
426	203
422	203
429	203
466	203
473	203
512	203
348	204
349	204
353	204
356	204
358	204
388	204
386	204
387	204
379	204
442	204
465	204
463	204
467	204
468	204
470	204
472	204
477	204
479	204
481	204
484	204
493	204
348	205
349	205
373	205
390	205
403	205
419	205
407	205
423	205
427	205
426	205
433	205
441	205
446	205
457	205
483	205
490	205
491	205
492	205
508	205
343	206
348	206
349	206
352	206
355	206
359	206
367	206
369	206
384	206
400	206
438	206
450	206
447	206
456	206
464	206
470	206
487	206
489	206
341	207
348	207
349	207
357	207
375	207
406	207
401	207
398	207
402	207
416	207
425	207
433	207
430	207
452	207
460	207
461	207
463	207
337	208
338	208
339	208
348	208
349	208
356	208
370	208
371	208
378	208
393	208
421	208
426	208
424	208
422	208
439	208
443	208
468	208
473	208
482	208
493	208
344	209
346	209
348	209
349	209
357	209
359	209
372	209
374	209
385	209
403	209
394	209
405	209
407	209
427	209
431	209
449	209
453	209
463	209
486	209
487	209
341	210
346	210
347	210
348	210
349	210
356	210
364	210
373	210
382	210
401	210
427	210
424	210
422	210
446	210
449	210
465	210
477	210
343	211
344	211
348	211
349	211
359	211
362	211
370	211
371	211
388	211
386	211
387	211
379	211
402	211
432	211
429	211
451	211
493	211
502	211
348	212
349	212
354	212
369	212
375	212
384	212
405	212
426	212
433	212
431	212
430	212
439	212
448	212
460	212
473	212
474	212
481	212
482	212
484	212
487	212
347	213
348	213
349	213
367	213
372	213
373	213
379	213
377	213
401	213
398	213
391	213
419	213
425	213
443	213
441	213
452	213
461	213
468	213
479	213
345	214
348	214
349	214
356	214
361	214
370	214
371	214
393	214
399	214
407	214
427	214
421	214
422	214
439	214
464	214
463	214
493	214
339	215
346	215
348	215
349	215
357	215
360	215
390	215
402	215
403	215
426	215
433	215
432	215
445	215
444	215
442	215
450	215
486	215
490	215
341	216
348	216
349	216
353	216
364	216
382	216
384	216
381	216
392	216
400	216
418	216
407	216
443	216
447	216
465	216
463	216
493	216
512	216
337	217
338	217
348	217
349	217
358	217
359	217
371	217
378	217
374	217
427	217
429	217
439	217
449	217
455	217
464	217
477	217
480	217
481	217
489	217
343	218
348	218
349	218
352	218
354	218
363	218
367	218
372	218
375	218
377	218
401	218
421	218
426	218
430	218
456	218
460	218
461	218
467	218
468	218
344	219
346	219
348	219
349	219
355	219
356	219
357	219
361	219
393	219
405	219
421	219
426	219
422	219
432	219
452	219
463	219
476	219
347	220
348	220
349	220
359	220
364	220
372	220
382	220
381	220
398	220
403	220
391	220
395	220
419	220
427	220
424	220
431	220
348	221
349	221
353	221
406	221
394	221
405	221
400	221
418	221
421	221
433	221
440	221
443	221
442	221
446	221
457	221
464	221
463	221
513	221
337	222
338	222
339	222
343	222
348	222
349	222
352	222
362	222
363	222
370	222
373	222
374	222
402	222
430	222
439	222
468	222
493	222
345	223
348	223
349	223
357	223
358	223
384	223
399	223
416	223
407	223
426	223
433	223
438	223
441	223
447	223
462	223
473	223
479	223
480	223
484	223
348	224
349	224
364	224
367	224
382	224
381	224
398	224
403	224
427	224
421	224
425	224
422	224
440	224
441	224
449	224
477	224
480	224
347	225
348	225
349	225
355	225
356	225
362	225
370	225
384	225
379	225
401	225
405	225
431	225
439	225
447	225
468	225
341	226
348	226
349	226
357	226
360	226
368	226
374	226
377	226
395	226
424	226
430	226
443	226
450	226
446	226
463	226
470	226
479	226
481	226
490	226
343	227
344	227
345	227
347	227
348	227
349	227
352	227
361	227
388	227
386	227
387	227
392	227
393	227
422	227
433	227
444	227
463	227
477	227
480	227
337	228
338	228
339	228
348	228
349	228
363	228
364	228
373	228
406	228
402	228
400	228
418	228
416	228
430	228
448	228
460	228
473	228
476	228
348	229
349	229
353	229
357	229
359	229
362	229
367	229
378	229
401	229
427	229
439	229
451	229
464	229
463	229
480	229
514	229
348	230
349	230
356	230
370	230
382	230
384	230
381	230
390	230
403	230
405	230
413	230
421	230
424	230
443	230
442	230
446	230
453	230
470	230
348	231
349	231
368	231
375	231
373	231
379	231
406	231
402	231
416	231
422	231
445	231
441	231
452	231
456	231
467	231
476	231
477	231
479	231
478	231
486	231
508	231
341	232
348	232
349	232
363	232
374	232
384	232
419	232
418	232
407	232
431	232
444	232
449	232
455	232
464	232
470	232
484	232
490	232
346	233
348	233
349	233
354	233
388	233
386	233
387	233
399	233
427	233
421	233
433	233
432	233
430	233
440	233
439	233
460	233
468	233
473	233
494	233
343	234
345	234
347	234
348	234
349	234
352	234
356	234
358	234
377	234
401	234
398	234
393	234
394	234
429	234
447	234
457	234
463	234
489	234
337	235
338	235
344	235
348	235
349	235
355	235
357	235
361	235
372	235
403	235
395	235
425	235
424	235
443	235
465	235
481	235
515	235
348	236
349	236
356	236
359	236
368	236
370	236
375	236
402	236
416	236
432	236
431	236
441	236
442	236
453	236
452	236
467	236
473	236
339	237
341	237
343	237
348	237
349	237
352	237
378	237
385	237
397	237
421	237
433	237
438	237
439	237
449	237
455	237
463	237
471	237
480	237
482	237
348	238
349	238
363	238
367	238
372	238
379	238
392	238
390	238
400	238
418	238
427	238
422	238
440	238
443	238
446	238
468	238
474	238
346	239
348	239
349	239
353	239
358	239
373	239
384	239
377	239
419	239
407	239
421	239
432	239
430	239
444	239
456	239
472	239
479	239
348	240
349	240
357	240
362	240
382	240
374	240
381	240
403	240
391	240
405	240
413	240
421	240
433	240
457	240
464	240
461	240
463	240
480	240
492	240
508	240
348	241
349	241
354	241
356	241
388	241
386	241
385	241
384	241
387	241
377	241
392	241
401	241
421	241
422	241
464	241
465	241
470	241
499	241
337	242
338	242
348	242
349	242
367	242
370	242
371	242
375	242
390	242
402	242
393	242
432	242
443	242
450	242
463	242
479	242
480	242
484	242
339	243
343	243
348	243
349	243
358	243
361	243
364	243
372	243
378	243
397	243
403	243
399	243
424	243
438	243
444	243
457	243
468	243
341	244
348	244
349	244
353	244
359	244
398	244
391	244
395	244
400	244
418	244
416	244
407	244
427	244
421	244
456	244
464	244
471	244
472	244
339	245
346	245
347	245
348	245
349	245
356	245
357	245
371	245
379	245
401	245
403	245
393	245
430	245
450	245
460	245
482	245
344	246
345	246
348	246
349	246
370	246
374	246
402	246
394	246
405	246
433	246
431	246
439	246
444	246
441	246
452	246
447	246
463	246
468	246
480	246
499	246
339	247
344	247
348	247
349	247
364	247
375	247
382	247
381	247
406	247
393	247
405	247
418	247
425	247
424	247
431	247
430	247
449	247
477	247
478	247
502	247
337	248
338	248
348	248
349	248
359	248
362	248
363	248
370	248
371	248
373	248
374	248
384	248
403	248
407	248
422	248
464	248
463	248
499	248
509	248
348	249
349	249
354	249
367	249
378	249
388	249
386	249
387	249
379	249
427	249
421	249
439	249
450	249
451	249
446	249
447	249
465	249
468	249
470	249
480	249
343	250
348	250
349	250
356	250
392	250
401	250
390	250
399	250
439	250
442	250
450	250
464	250
466	250
463	250
468	250
477	250
481	250
341	251
344	251
346	251
348	251
349	251
355	251
362	251
364	251
370	251
377	251
391	251
424	251
440	251
460	251
474	251
476	251
479	251
480	251
482	251
498	251
508	251
347	252
348	252
349	252
352	252
357	252
361	252
375	252
382	252
381	252
406	252
398	252
403	252
394	252
427	252
425	252
432	252
429	252
461	252
337	253
338	253
339	253
348	253
349	253
353	253
356	253
402	253
393	253
400	253
418	253
416	253
433	253
431	253
430	253
441	253
450	253
464	253
516	253
348	254
349	254
358	254
384	254
395	254
405	254
419	254
407	254
421	254
422	254
439	254
444	254
456	254
463	254
472	254
473	254
480	254
484	254
486	254
514	254
339	255
348	255
349	255
352	255
378	255
406	255
402	255
400	255
418	255
433	255
443	255
450	255
446	255
455	255
464	255
466	255
484	255
499	255
516	255
347	256
348	256
349	256
356	256
359	256
370	256
384	256
401	256
398	256
393	256
405	256
432	256
429	256
442	256
448	256
457	256
460	256
463	256
337	257
338	257
341	257
343	257
348	257
349	257
353	257
354	257
364	257
372	257
384	257
391	257
395	257
407	257
425	257
422	257
465	257
467	257
344	258
346	258
348	258
349	258
357	258
358	258
367	258
374	258
403	258
421	258
433	258
444	258
447	258
456	258
464	258
474	258
489	258
492	258
345	259
348	259
349	259
363	259
369	259
371	259
373	259
378	259
377	259
397	259
394	259
427	259
430	259
449	259
461	259
479	259
480	259
482	259
348	260
349	260
356	260
361	260
382	260
381	260
390	260
402	260
393	260
431	260
440	260
439	260
463	260
470	260
473	260
477	260
481	260
484	260
339	261
343	261
348	261
349	261
364	261
388	261
386	261
387	261
391	261
400	261
413	261
416	261
421	261
422	261
464	261
468	261
480	261
347	262
348	262
349	262
359	262
370	262
375	262
384	262
379	262
398	262
405	262
439	262
441	262
442	262
450	262
446	262
463	262
494	262
341	263
344	263
348	263
349	263
353	263
402	263
395	263
419	263
418	263
421	263
425	263
445	263
448	263
467	263
488	263
490	263
491	263
500	263
501	263
345	264
346	264
348	264
349	264
361	264
371	264
377	264
392	264
393	264
399	264
407	264
427	264
422	264
444	264
452	264
458	264
479	264
506	264
348	265
349	265
357	265
367	265
369	265
374	265
403	265
416	265
421	265
424	265
429	265
447	265
464	265
461	265
468	265
474	265
476	265
480	265
481	265
337	266
338	266
339	266
343	266
346	266
348	266
349	266
352	266
355	266
356	266
401	266
433	266
432	266
431	266
430	266
456	266
463	266
477	266
482	266
348	267
349	267
364	267
378	267
388	267
386	267
387	267
406	267
392	267
391	267
405	267
400	267
427	267
422	267
439	267
444	267
450	267
457	267
463	267
347	268
348	268
349	268
382	268
385	268
384	268
381	268
398	268
413	268
442	268
448	268
460	268
464	268
465	268
470	268
477	268
480	268
484	268
517	268
341	269
343	269
344	269
348	269
349	269
353	269
360	269
370	269
402	269
393	269
394	269
418	269
416	269
421	269
432	269
451	269
447	269
473	269
512	269
337	270
338	270
348	270
349	270
352	270
354	270
361	270
372	270
375	270
374	270
377	270
407	270
427	270
460	270
461	270
463	270
468	270
479	270
509	270
347	271
348	271
349	271
359	271
367	271
378	271
419	271
433	271
431	271
439	271
446	271
452	271
464	271
480	271
484	271
499	271
339	272
348	272
349	272
356	272
369	272
397	272
392	272
401	272
390	272
403	272
405	272
422	272
430	272
441	272
490	272
494	272
343	273
348	273
349	273
384	273
403	273
393	273
391	273
399	273
416	273
407	273
427	273
421	273
444	273
450	273
477	273
480	273
490	273
516	273
348	274
349	274
367	274
370	274
375	274
378	274
385	274
398	274
402	274
418	274
433	274
430	274
440	274
455	274
456	274
461	274
463	274
339	275
347	275
348	275
349	275
353	275
354	275
362	275
382	275
381	275
405	275
425	275
424	275
441	275
442	275
464	275
466	275
467	275
479	275
341	276
346	276
348	276
349	276
352	276
356	276
359	276
361	276
375	276
388	276
386	276
374	276
387	276
379	276
377	276
403	276
427	276
422	276
450	276
474	276
477	276
337	277
338	277
344	277
348	277
349	277
357	277
364	277
371	277
421	277
424	277
431	277
439	277
446	277
447	277
459	277
463	277
480	277
502	277
343	278
347	278
348	278
349	278
356	278
364	278
371	278
384	278
392	278
390	278
421	278
422	278
439	278
444	278
463	278
473	278
477	278
499	278
337	279
338	279
345	279
346	279
348	279
349	279
360	279
361	279
367	279
403	279
399	279
405	279
400	279
407	279
427	279
424	279
461	279
494	279
341	280
347	280
348	280
349	280
377	280
398	280
394	280
413	280
421	280
450	280
464	280
465	280
466	280
463	280
486	280
491	280
516	280
348	281
349	281
356	281
359	281
378	281
388	281
386	281
387	281
402	281
403	281
430	281
449	281
452	281
457	281
461	281
473	281
477	281
490	281
492	281
348	282
349	282
362	282
382	282
374	282
381	282
397	282
393	282
427	282
425	282
424	282
432	282
440	282
439	282
460	282
470	282
474	282
480	282
481	282
499	282
337	283
338	283
343	283
344	283
348	283
349	283
353	283
357	283
358	283
361	283
363	283
371	283
418	283
421	283
450	283
456	283
463	283
489	283
502	283
348	284
349	284
356	284
373	284
384	284
379	284
398	284
395	284
416	284
407	284
431	284
429	284
444	284
447	284
479	284
484	284
506	284
348	285
349	285
367	285
369	285
370	285
392	285
403	285
427	285
421	285
433	285
432	285
441	285
442	285
464	285
465	285
461	285
468	285
480	285
482	285
339	286
346	286
348	286
349	286
362	286
378	286
390	286
402	286
419	286
433	286
430	286
439	286
451	286
452	286
458	286
499	286
341	287
344	287
345	287
348	287
349	287
353	287
358	287
359	287
363	287
394	287
391	287
418	287
421	287
450	287
457	287
463	287
472	287
477	287
480	287
490	287
348	288
349	288
369	288
374	288
384	288
377	288
397	288
406	288
401	288
405	288
407	288
427	288
421	288
425	288
424	288
422	288
442	288
461	288
479	288
337	289
338	289
347	289
348	289
349	289
356	289
361	289
375	289
388	289
386	289
387	289
403	289
393	289
400	289
440	289
464	289
481	289
516	289
344	290
346	290
348	290
349	290
357	290
364	290
367	290
402	290
416	290
431	290
439	290
449	290
453	290
463	290
473	290
476	290
480	290
478	290
343	291
348	291
349	291
352	291
354	291
356	291
375	291
385	291
384	291
391	291
407	291
427	291
421	291
422	291
450	291
446	291
465	291
468	291
339	292
348	292
349	292
370	292
371	292
373	292
378	292
382	292
381	292
379	292
398	292
418	292
432	292
429	292
430	292
441	292
455	292
464	292
463	292
345	293
348	293
349	293
355	293
360	293
382	293
405	293
400	293
418	293
407	293
424	293
422	293
442	293
448	293
458	293
473	293
492	293
508	293
516	293
341	294
348	294
349	294
356	294
363	294
373	294
378	294
384	294
427	294
440	294
450	294
446	294
452	294
447	294
468	294
491	294
506	294
343	295
344	295
348	295
349	295
375	295
385	295
377	295
401	295
393	295
421	295
433	295
431	295
430	295
445	295
456	295
457	295
463	295
467	295
470	295
490	295
347	296
348	296
349	296
352	296
364	296
367	296
374	296
379	296
403	296
394	296
444	296
449	296
461	296
466	296
477	296
516	296
348	297
349	297
361	297
369	297
370	297
371	297
392	297
399	297
427	297
424	297
439	297
450	297
474	297
480	297
481	297
484	297
518	297
337	298
338	298
339	298
348	298
349	298
356	298
358	298
362	298
368	298
390	298
402	298
419	298
432	298
438	298
463	298
479	298
486	298
500	298
501	298
341	299
343	299
345	299
346	299
347	299
348	299
349	299
353	299
388	299
386	299
387	299
406	299
395	299
400	299
418	299
416	299
422	299
447	299
457	299
348	300
349	300
359	300
364	300
371	300
378	300
384	300
441	300
442	300
450	300
446	300
466	300
473	300
477	300
479	300
348	301
349	301
356	301
357	301
382	301
381	301
403	301
405	301
407	301
427	301
421	301
431	301
430	301
460	301
463	301
468	301
480	301
482	301
519	302
348	303
349	303
353	303
359	303
363	303
372	303
379	303
402	303
403	303
400	303
427	303
421	303
458	303
460	303
461	303
463	303
467	303
480	303
339	304
341	304
343	304
348	304
349	304
352	304
354	304
356	304
364	304
401	304
418	304
425	304
422	304
432	304
429	304
450	304
448	304
447	304
503	304
347	305
348	305
349	305
382	305
388	305
386	305
381	305
387	305
397	305
406	305
392	305
427	305
431	305
440	305
439	305
442	305
470	305
473	305
481	305
348	306
349	306
356	306
367	306
378	306
374	306
391	306
416	306
432	306
444	306
451	306
455	306
456	306
463	306
477	306
484	306
509	306
516	306
344	307
346	307
348	307
349	307
357	307
360	307
385	307
384	307
403	307
395	307
405	307
407	307
421	307
430	307
449	307
480	307
482	307
343	308
348	308
349	308
352	308
356	308
361	308
373	308
390	308
402	308
394	308
400	308
421	308
439	308
446	308
457	308
460	308
468	308
486	308
490	308
341	309
344	309
348	309
349	309
354	309
363	309
382	309
381	309
399	309
416	309
425	309
422	309
432	309
447	309
463	309
474	309
492	309
512	309
516	309
339	310
345	310
348	310
349	310
371	310
375	310
377	310
401	310
398	310
393	310
420	310
427	310
431	310
441	310
442	310
450	310
477	310
479	310
480	310
507	310
337	311
338	311
347	311
348	311
349	311
353	311
356	311
362	311
391	311
419	311
418	311
421	311
425	311
432	311
438	311
463	311
467	311
472	311
481	311
494	311
516	311
343	312
348	312
349	312
352	312
359	312
373	312
378	312
374	312
385	312
384	312
430	312
445	312
446	312
466	312
478	312
485	312
484	312
491	312
346	313
348	313
349	313
361	313
370	313
388	313
386	313
387	313
405	313
407	313
427	313
421	313
439	313
444	313
461	313
473	313
480	313
506	313
508	313
516	313
341	314
348	314
349	314
356	314
367	314
368	314
392	314
390	314
402	314
403	314
432	314
431	314
440	314
450	314
455	314
460	314
463	314
477	314
500	314
501	314
344	315
348	315
349	315
356	315
357	315
358	315
364	315
371	315
377	315
401	315
399	315
421	315
425	315
424	315
449	315
457	315
479	315
489	315
502	315
337	316
338	316
339	316
343	316
347	316
348	316
349	316
352	316
362	316
379	316
398	316
393	316
400	316
427	316
422	316
429	316
450	316
447	316
463	316
480	316
516	316
348	317
349	317
355	317
356	317
378	317
384	317
413	317
418	317
421	317
432	317
430	317
451	317
465	317
466	317
468	317
473	317
477	317
520	317
345	318
348	318
349	318
359	318
372	318
382	318
374	318
381	318
391	318
395	318
405	318
419	318
407	318
425	318
424	318
439	318
481	318
341	319
343	319
347	319
348	319
349	319
353	319
370	319
392	319
403	319
416	319
427	319
421	319
433	319
432	319
447	319
461	319
463	319
480	319
482	319
344	320
346	320
348	320
349	320
356	320
361	320
388	320
386	320
387	320
379	320
402	320
418	320
425	320
422	320
440	320
444	320
477	320
499	320
516	320
348	321
349	321
352	321
357	321
385	321
377	321
401	321
390	321
427	321
421	321
431	321
441	321
442	321
463	321
468	321
479	321
484	321
497	321
337	322
338	322
348	322
349	322
356	322
358	322
384	322
397	322
393	322
395	322
405	322
432	322
430	322
439	322
450	322
446	322
452	322
472	322
474	322
512	322
348	323
349	323
370	323
384	323
406	323
394	323
418	323
416	323
427	323
421	323
430	323
444	323
450	323
463	323
482	323
490	323
491	323
343	324
345	324
346	324
348	324
349	324
352	324
367	324
382	324
381	324
398	324
425	324
422	324
433	324
429	324
447	324
477	324
512	324
516	324
339	325
341	325
348	325
349	325
356	325
372	325
375	325
378	325
377	325
403	325
395	325
419	325
427	325
421	325
424	325
432	325
431	325
467	325
468	325
339	326
347	326
348	326
349	326
370	326
392	326
401	326
395	326
418	326
416	326
424	326
430	326
451	326
458	326
468	326
473	326
481	326
337	327
338	327
346	327
348	327
349	327
355	327
373	327
384	327
379	327
393	327
400	327
407	327
427	327
440	327
442	327
463	327
471	327
479	327
489	327
341	328
348	328
349	328
364	328
378	328
374	328
384	328
397	328
402	328
394	328
405	328
431	328
429	328
439	328
447	328
512	328
343	329
348	329
349	329
352	329
353	329
382	329
384	329
381	329
379	329
394	329
407	329
427	329
425	329
431	329
439	329
446	329
447	329
463	329
500	329
501	329
341	330
348	330
349	330
355	330
370	330
385	330
384	330
392	330
390	330
393	330
395	330
420	330
413	330
442	330
465	330
474	330
479	330
491	330
347	331
348	331
349	331
358	331
359	331
368	331
399	331
419	331
418	331
424	331
446	331
449	331
452	331
463	331
489	331
494	331
348	332
349	332
357	332
361	332
362	332
364	332
371	332
375	332
378	332
374	332
403	332
413	332
451	332
456	332
473	332
481	332
345	333
346	333
348	333
349	333
363	333
370	333
372	333
377	333
401	333
405	333
427	333
422	333
430	333
444	333
457	333
482	333
484	333
341	334
343	334
346	334
348	334
349	334
352	334
358	334
362	334
363	334
378	334
384	334
406	334
407	334
422	334
439	334
446	334
467	334
489	334
506	334
339	335
348	335
349	335
359	335
371	335
382	335
381	335
379	335
377	335
397	335
398	335
391	335
429	335
455	335
461	335
479	335
486	335
494	335
345	336
347	336
348	336
349	336
353	336
361	336
384	336
401	336
419	336
418	336
427	336
433	336
431	336
441	336
458	336
468	336
337	337
338	337
344	337
348	337
349	337
385	337
390	337
402	337
403	337
400	337
416	337
425	337
442	337
449	337
456	337
463	337
470	337
509	337
344	338
348	338
349	338
353	338
364	338
367	338
368	338
392	338
403	338
400	338
416	338
424	338
422	338
467	338
473	338
484	338
499	338
500	338
501	338
503	338
346	339
348	339
349	339
361	339
363	339
370	339
373	339
406	339
390	339
405	339
418	339
427	339
425	339
451	339
452	339
474	339
337	340
338	340
339	340
348	340
349	340
388	340
386	340
387	340
420	340
430	340
440	340
439	340
443	340
453	340
461	340
463	340
502	340
506	340
521	340
343	341
348	341
349	341
352	341
359	341
378	341
384	341
398	341
403	341
393	341
400	341
407	341
427	341
441	341
442	341
472	341
473	341
489	341
494	341
348	342
349	342
358	342
367	342
368	342
375	342
379	342
377	342
392	342
402	342
416	342
425	342
422	342
438	342
444	342
458	342
459	342
463	342
467	342
468	342
479	342
344	343
348	343
349	343
357	343
388	343
386	343
387	343
406	343
391	343
405	343
427	343
425	343
439	343
453	343
462	343
460	343
463	343
484	343
491	343
499	343
348	344
349	344
363	344
370	344
382	344
374	344
381	344
394	344
413	344
418	344
431	344
440	344
445	344
452	344
447	344
468	344
478	344
485	344
508	344
512	344
343	345
348	345
349	345
359	345
362	345
371	345
378	345
384	345
395	345
420	345
407	345
427	345
424	345
430	345
472	345
473	345
482	345
489	345
500	345
501	345
346	346
348	346
349	346
361	346
385	346
401	346
390	346
402	346
419	346
441	346
457	346
461	346
479	346
481	346
511	346
337	347
338	347
339	347
348	347
349	347
353	347
363	347
368	347
372	347
377	347
397	347
438	347
465	347
463	347
467	347
470	347
471	347
497	347
343	348
347	348
348	348
349	348
352	348
357	348
359	348
364	348
367	348
373	348
398	348
403	348
425	348
422	348
429	348
442	348
512	348
341	349
348	349
349	349
355	349
419	349
418	349
427	349
433	349
451	349
447	349
455	349
463	349
470	349
473	349
474	349
499	349
500	349
501	349
344	350
348	350
349	350
354	350
382	350
374	350
381	350
392	350
405	350
424	350
429	350
439	350
453	350
460	350
463	350
472	350
489	350
502	350
506	350
348	351
349	351
369	351
375	351
384	351
379	351
403	351
393	351
391	351
395	351
400	351
407	351
431	351
440	351
448	351
454	351
508	351
345	352
348	352
349	352
358	352
363	352
397	352
406	352
401	352
416	352
430	352
438	352
441	352
452	352
463	352
474	352
479	352
482	352
484	352
337	353
338	353
348	353
349	353
361	353
370	353
372	353
378	353
390	353
394	353
405	353
413	353
427	353
425	353
433	353
439	353
460	353
461	353
339	354
343	354
346	354
348	354
349	354
353	354
362	354
371	354
385	354
377	354
402	354
418	354
422	354
444	354
442	354
449	354
467	354
468	354
500	354
501	354
348	355
349	355
354	355
364	355
367	355
382	355
388	355
386	355
381	355
387	355
402	355
391	355
419	355
418	355
425	355
431	355
473	355
478	355
481	355
499	355
500	355
501	355
344	356
345	356
347	356
348	356
349	356
357	356
360	356
371	356
374	356
401	356
403	356
433	356
429	356
430	356
463	356
485	356
489	356
492	356
502	356
512	356
337	357
338	357
348	357
349	357
378	357
384	357
399	357
405	357
424	357
441	357
447	357
457	357
460	357
470	357
479	357
491	357
494	357
506	357
509	357
343	358
348	358
349	358
352	358
354	358
359	358
368	358
390	358
438	358
444	358
453	358
452	358
461	358
472	358
473	358
486	358
499	358
500	358
501	358
341	359
348	359
349	359
355	359
369	359
401	359
394	359
419	359
427	359
425	359
422	359
439	359
442	359
448	359
463	359
490	359
497	359
345	360
348	360
349	360
370	360
371	360
373	360
384	360
379	360
377	360
398	360
393	360
391	360
407	360
429	360
455	360
474	360
481	360
512	360
339	361
348	361
349	361
353	361
357	361
358	361
364	361
382	361
381	361
402	361
395	361
416	361
430	361
458	361
479	361
489	361
344	362
348	362
349	362
367	362
372	362
375	362
373	362
378	362
374	362
392	362
400	362
418	362
424	362
440	362
451	362
447	362
484	362
337	363
338	363
346	363
347	363
348	363
349	363
359	363
361	363
385	363
397	363
403	363
405	363
431	363
457	363
463	363
482	363
500	363
501	363
337	364
338	364
343	364
348	364
349	364
352	364
353	364
358	364
367	364
369	364
370	364
403	364
427	364
425	364
438	364
453	364
463	364
467	364
494	364
348	365
349	365
359	365
368	365
378	365
374	365
379	365
377	365
393	365
419	365
407	365
422	365
452	365
447	365
458	365
479	365
482	365
508	365
516	365
347	366
348	366
349	366
361	366
371	366
373	366
388	366
386	366
387	366
397	366
427	366
425	366
431	366
439	366
441	366
463	366
346	367
348	367
349	367
355	367
357	367
364	367
372	367
392	367
398	367
413	367
418	367
416	367
424	367
442	367
472	367
481	367
489	367
343	368
348	368
349	368
352	368
353	368
363	368
384	368
406	368
401	368
395	368
400	368
407	368
427	368
430	368
449	368
470	368
473	368
516	368
344	369
345	369
348	369
349	369
359	369
373	369
402	369
403	369
394	369
391	369
405	369
425	369
463	369
491	369
494	369
499	369
339	370
348	370
349	370
362	370
382	370
385	370
381	370
390	370
419	370
427	370
460	370
468	370
479	370
486	370
490	370
523	370
522	370
343	371
348	371
349	371
364	371
373	371
378	371
377	371
392	371
399	371
400	371
416	371
422	371
443	371
442	371
455	371
463	371
481	371
516	371
348	372
349	372
359	372
367	372
370	372
375	372
384	372
405	372
418	372
427	372
424	372
447	372
461	372
467	372
474	372
484	372
497	372
508	372
337	373
338	373
346	373
347	373
348	373
349	373
384	373
397	373
425	373
431	373
430	373
440	373
439	373
448	373
449	373
473	373
482	373
512	373
345	374
348	374
349	374
358	374
363	374
368	374
374	374
403	374
395	374
413	374
419	374
427	374
438	374
444	374
452	374
469	374
511	374
341	375
343	375
348	375
349	375
352	375
353	375
369	375
379	375
393	375
391	375
425	375
451	375
454	375
457	375
462	375
460	375
463	375
468	375
479	375
486	375
516	375
344	376
348	376
349	376
362	376
364	376
378	376
390	376
405	376
400	376
427	376
439	376
453	376
472	376
473	376
484	376
489	376
494	376
339	377
348	377
349	377
372	377
388	377
386	377
385	377
387	377
377	377
401	377
402	377
403	377
425	377
442	377
465	377
461	377
463	377
470	377
343	378
348	378
349	378
359	378
384	378
406	378
398	378
416	378
407	378
427	378
431	378
429	378
444	378
447	378
455	378
506	378
516	378
337	379
338	379
347	379
348	379
349	379
361	379
363	379
370	379
392	379
394	379
418	379
422	379
440	379
481	379
482	379
497	379
512	379
346	380
348	380
349	380
367	380
382	380
374	380
381	380
397	380
395	380
405	380
425	380
433	380
430	380
439	380
463	380
473	380
491	380
494	380
345	381
346	381
348	381
349	381
353	381
362	381
390	381
418	381
416	381
427	381
425	381
422	381
444	381
442	381
454	381
463	381
516	381
337	382
338	382
343	382
347	382
348	382
349	382
352	382
370	382
373	382
384	382
398	382
403	382
427	382
441	382
447	382
460	382
463	382
468	382
339	383
348	383
349	383
371	383
372	383
375	383
377	383
397	383
402	383
393	383
399	383
405	383
425	383
424	383
433	383
431	383
430	383
479	383
484	383
516	383
339	384
348	384
349	384
352	384
368	384
388	384
386	384
387	384
401	384
398	384
405	384
400	384
418	384
422	384
455	384
460	384
478	384
508	384
512	384
337	385
338	385
341	385
348	385
349	385
353	385
364	385
367	385
370	385
395	385
416	385
424	385
430	385
438	385
439	385
461	385
468	385
474	385
489	385
494	385
343	386
345	386
348	386
349	386
363	386
369	386
371	386
372	386
374	386
384	386
403	386
394	386
391	386
407	386
431	386
441	386
448	386
481	386
524	386
347	387
348	387
349	387
361	387
382	387
381	387
379	387
377	387
397	387
393	387
440	387
457	387
471	387
472	387
479	387
482	387
484	387
491	387
497	387
509	387
337	388
338	388
344	388
353	388
398	388
400	388
418	388
430	388
513	388
527	388
525	388
529	388
526	388
528	388
343	389
344	389
348	389
349	389
352	389
357	389
361	389
382	389
388	389
386	389
385	389
381	389
387	389
394	389
413	389
439	389
461	389
499	389
530	389
339	390
347	390
348	390
349	390
358	390
359	390
362	390
379	390
397	390
392	390
401	390
418	390
440	390
454	390
473	390
489	390
497	390
348	391
349	391
364	391
367	391
370	391
375	391
378	391
384	391
393	391
416	391
430	391
441	391
467	391
479	391
491	391
494	391
337	392
338	392
341	392
345	392
346	392
348	392
349	392
353	392
377	392
403	392
405	392
400	392
422	392
429	392
444	392
447	392
455	392
465	392
474	392
512	392
531	392
532	392
348	393
349	393
354	393
360	393
367	393
373	393
374	393
406	393
401	393
413	393
418	393
430	393
455	393
465	393
472	393
473	393
482	393
533	393
343	394
347	394
348	394
349	394
352	394
359	394
378	394
388	394
386	394
384	394
387	394
379	394
431	394
448	394
454	394
452	394
447	394
476	394
478	394
506	394
337	395
338	395
346	395
348	395
349	395
369	395
390	395
403	395
413	395
440	395
451	395
453	395
462	395
474	395
481	395
486	395
492	395
494	395
497	395
508	395
524	395
341	396
348	396
349	396
355	396
358	396
370	396
385	396
392	396
402	396
405	396
439	396
444	396
457	396
489	396
498	396
499	396
512	396
523	396
522	396
345	397
348	397
349	397
363	397
367	397
371	397
401	397
398	397
391	397
400	397
418	397
407	397
441	397
449	397
461	397
509	397
339	398
344	398
348	398
349	398
353	398
361	398
364	398
382	398
386	398
387	398
419	398
416	398
422	398
460	398
470	398
479	398
484	398
347	399
348	399
349	399
378	399
374	399
384	399
377	399
406	399
403	399
395	399
405	399
400	399
430	399
452	399
455	399
468	399
491	399
503	399
341	400
343	400
346	400
348	400
349	400
352	400
361	400
372	400
373	400
397	400
392	400
401	400
394	400
439	400
444	400
467	400
473	400
482	400
497	400
348	401
349	401
354	401
367	401
368	401
375	401
379	401
390	401
391	401
399	401
407	401
433	401
431	401
445	401
448	401
465	401
478	401
490	401
507	401
337	402
338	402
344	402
348	402
349	402
359	402
361	402
362	402
371	402
374	402
402	402
424	402
451	402
470	402
474	402
479	402
486	402
494	402
499	402
506	402
343	403
346	403
348	403
349	403
352	403
353	403
360	403
364	403
370	403
382	403
381	403
418	403
422	403
430	403
438	403
441	403
452	403
512	403
347	404
348	404
349	404
369	404
375	404
373	404
385	404
384	404
377	404
397	404
398	404
405	404
440	404
447	404
462	404
461	404
468	404
508	404
513	404
339	405
345	405
348	405
349	405
355	405
357	405
363	405
388	405
386	405
387	405
403	405
413	405
416	405
460	405
492	405
497	405
523	405
522	405
348	406
349	406
358	406
384	406
379	406
393	406
419	406
407	406
429	406
439	406
444	406
453	406
454	406
457	406
472	406
473	406
491	406
509	406
341	407
348	407
349	407
353	407
354	407
367	407
385	407
401	407
394	407
391	407
395	407
400	407
418	407
438	407
455	407
465	407
467	407
489	407
347	408
348	408
349	408
364	408
370	408
375	408
378	408
384	408
390	408
430	408
440	408
441	408
452	408
461	408
479	408
497	408
512	408
337	409
338	409
344	409
345	409
348	409
349	409
361	409
372	409
397	409
403	409
399	409
405	409
433	409
431	409
468	409
474	409
481	409
484	409
502	409
339	410
343	410
348	410
349	410
352	410
359	410
362	410
382	410
374	410
381	410
377	410
402	410
424	410
422	410
447	410
460	410
470	410
482	410
486	410
494	410
506	410
341	411
343	411
348	411
349	411
352	411
363	411
368	411
406	411
390	411
398	411
399	411
422	411
445	411
470	411
484	411
490	411
506	411
508	411
523	411
522	411
348	412
349	412
359	412
371	412
388	412
386	412
387	412
379	412
392	412
402	412
419	412
431	412
430	412
449	412
474	412
481	412
502	412
344	413
348	413
349	413
357	413
372	413
375	413
382	413
374	413
384	413
381	413
413	413
424	413
451	413
449	413
452	413
465	413
468	413
339	414
345	414
348	414
349	414
353	414
361	414
373	414
378	414
394	414
395	414
400	414
418	414
407	414
433	414
440	414
457	414
460	414
482	414
512	414
518	414
348	415
349	415
367	415
369	415
385	415
397	415
401	415
405	415
428	415
429	415
447	415
455	415
473	415
479	415
491	415
492	415
337	416
338	416
346	416
347	416
348	416
349	416
358	416
364	416
370	416
384	416
377	416
403	416
391	416
416	416
424	416
438	416
444	416
494	416
343	417
345	417
348	417
349	417
352	417
353	417
367	417
373	417
378	417
401	417
403	417
399	417
400	417
433	417
430	417
444	417
441	417
460	417
467	417
473	417
344	418
348	418
349	418
359	418
382	418
374	418
381	418
379	418
402	418
429	418
445	418
447	418
455	418
465	418
491	418
497	418
502	418
507	418
337	419
338	419
339	419
346	419
348	419
349	419
358	419
388	419
386	419
387	419
419	419
418	419
407	419
424	419
440	419
438	419
523	419
522	419
347	420
348	420
349	420
355	420
362	420
369	420
371	420
378	420
385	420
384	420
397	420
392	420
398	420
422	420
430	420
457	420
494	420
343	421
348	421
349	421
352	421
353	421
357	421
364	421
377	421
406	421
402	421
403	421
400	421
444	421
441	421
467	421
472	421
479	421
489	421
348	422
349	422
370	422
382	422
381	422
390	422
391	422
418	422
424	422
431	422
448	422
454	422
452	422
468	422
481	422
490	422
509	422
344	423
345	423
348	423
349	423
367	423
384	423
392	423
401	423
393	423
405	423
407	423
422	423
453	423
447	423
469	423
474	423
494	423
506	423
515	423
337	424
338	424
343	424
348	424
349	424
352	424
361	424
375	424
373	424
378	424
374	424
385	424
397	424
403	424
455	424
473	424
484	424
491	424
339	425
348	425
349	425
359	425
370	425
388	425
386	425
387	425
379	425
395	425
413	425
416	425
430	425
438	425
460	425
470	425
482	425
489	425
497	425
346	426
348	426
349	426
353	426
367	426
406	426
390	426
398	426
393	426
419	426
433	426
445	426
441	426
451	426
474	426
479	426
481	426
522	426
343	427
347	427
348	427
349	427
352	427
364	427
368	427
372	427
377	427
401	427
424	427
431	427
444	427
452	427
447	427
457	427
470	427
471	427
472	427
341	428
348	428
349	428
378	428
385	428
384	428
402	428
391	428
400	428
418	428
422	428
429	428
440	428
468	428
473	428
512	428
534	428
344	429
348	429
349	429
357	429
358	429
361	429
382	429
381	429
379	429
403	429
394	429
399	429
405	429
433	429
453	429
484	429
489	429
494	429
337	430
338	430
339	430
345	430
348	430
349	430
370	430
373	430
374	430
377	430
395	430
416	430
407	430
430	430
462	430
460	430
479	430
509	430
515	430
343	431
348	431
349	431
352	431
355	431
363	431
369	431
371	431
375	431
384	431
397	431
403	431
407	431
431	431
447	431
455	431
467	431
473	431
343	432
346	432
347	432
348	432
349	432
363	432
388	432
386	432
387	432
416	432
443	432
445	432
457	432
460	432
473	432
492	432
494	432
523	432
522	432
348	433
349	433
364	433
371	433
384	433
403	433
399	433
419	433
407	433
424	433
431	433
430	433
440	433
444	433
441	433
454	433
344	434
348	434
349	434
358	434
367	434
369	434
378	434
374	434
377	434
397	434
405	434
433	434
451	434
453	434
447	434
479	434
482	434
484	434
489	434
497	434
509	434
343	435
344	435
347	435
348	435
349	435
352	435
361	435
388	435
386	435
387	435
392	435
401	435
400	435
418	435
424	435
468	435
473	435
474	435
481	435
512	435
348	436
349	436
353	436
357	436
371	436
378	436
384	436
379	436
398	436
403	436
394	436
391	436
395	436
407	436
422	436
429	436
453	436
452	436
488	436
337	437
338	437
339	437
348	437
349	437
359	437
368	437
370	437
372	437
375	437
385	437
377	437
402	437
416	437
431	437
467	437
470	437
479	437
497	437
344	438
346	438
348	438
349	438
358	438
363	438
364	438
367	438
369	438
373	438
378	438
374	438
400	438
418	438
430	438
440	438
438	438
455	438
513	438
345	439
348	439
349	439
353	439
362	439
371	439
382	439
384	439
381	439
397	439
403	439
393	439
405	439
407	439
447	439
472	439
489	439
494	439
515	439
337	440
338	440
343	440
348	440
349	440
352	440
361	440
367	440
369	440
385	440
406	440
398	440
393	440
400	440
418	440
422	440
478	440
482	440
344	441
348	441
349	441
358	441
377	441
401	441
403	441
399	441
419	441
441	441
448	441
447	441
473	441
474	441
481	441
490	441
489	441
515	441
348	442
349	442
373	442
378	442
374	442
384	442
395	442
416	442
407	442
424	442
429	442
430	442
445	442
460	442
497	442
534	442
343	443
347	443
348	443
349	443
352	443
355	443
362	443
363	443
367	443
391	443
400	443
418	443
431	443
444	443
454	443
471	443
472	443
484	443
339	444
348	444
349	444
357	444
372	444
388	444
386	444
387	444
390	444
402	444
403	444
424	444
447	444
465	444
468	444
486	444
491	444
492	444
509	444
344	445
348	445
349	445
353	445
359	445
361	445
369	445
370	445
378	445
379	445
392	445
394	445
405	445
422	445
433	445
452	445
467	445
479	445
494	445
502	445
337	446
338	446
348	446
349	446
364	446
374	446
384	446
397	446
413	446
416	446
441	446
449	446
455	446
457	446
461	446
473	446
497	446
341	447
345	447
348	447
349	447
362	447
368	447
384	447
377	447
401	447
399	447
431	447
430	447
440	447
490	447
512	447
515	447
343	448
344	448
346	448
348	448
349	448
353	448
358	448
367	448
406	448
390	448
400	448
418	448
422	448
429	448
444	448
448	448
453	448
447	448
472	448
347	449
348	449
349	449
369	449
375	449
385	449
394	449
445	449
452	449
460	449
465	449
467	449
468	449
481	449
506	449
339	450
348	450
349	450
370	450
373	450
382	450
381	450
398	450
393	450
391	450
395	450
405	450
407	450
471	450
473	450
479	450
482	450
489	450
534	450
343	451
344	451
348	451
349	451
353	451
355	451
359	451
361	451
378	451
384	451
397	451
418	451
416	451
424	451
431	451
449	451
467	451
484	451
492	451
499	451
337	452
338	452
341	452
348	452
349	452
357	452
363	452
372	452
388	452
386	452
387	452
377	452
392	452
402	452
403	452
430	452
451	452
457	452
465	452
470	452
508	452
345	453
348	453
349	453
362	453
367	453
371	453
375	453
374	453
384	453
394	453
419	453
422	453
444	453
453	453
447	453
474	453
479	453
512	453
343	454
348	454
349	454
352	454
364	454
373	454
382	454
381	454
399	454
438	454
445	454
452	454
455	454
472	454
491	454
535	454
339	455
346	455
348	455
349	455
359	455
361	455
369	455
379	455
401	455
390	455
402	455
405	455
400	455
418	455
460	455
482	455
494	455
515	455
347	456
348	456
349	456
353	456
358	456
370	456
384	456
403	456
391	456
395	456
416	456
407	456
433	456
468	456
473	456
489	456
497	456
337	457
338	457
344	457
348	457
349	457
372	457
378	457
385	457
377	457
397	457
398	457
431	457
429	457
440	457
441	457
453	457
447	457
479	457
481	457
534	457
343	458
347	458
348	458
349	458
352	458
359	458
361	458
388	458
386	458
384	458
387	458
401	458
394	458
407	458
424	458
491	458
512	458
339	459
348	459
349	459
360	459
362	459
364	459
382	459
381	459
398	459
402	459
400	459
418	459
422	459
429	459
440	459
454	459
447	459
472	459
337	460
338	460
344	460
345	460
346	460
348	460
349	460
372	460
375	460
378	460
377	460
397	460
405	460
431	460
441	460
453	460
467	460
468	460
473	460
479	460
348	461
349	461
352	461
364	461
401	461
398	461
395	461
400	461
413	461
418	461
424	461
430	461
438	461
470	461
472	461
490	461
494	461
347	462
348	462
349	462
358	462
359	462
372	462
375	462
378	462
384	462
390	462
399	462
405	462
455	462
457	462
489	462
491	462
492	462
536	462
337	463
338	463
348	463
349	463
362	463
367	463
369	463
370	463
392	463
402	463
428	463
440	463
449	463
452	463
447	463
479	463
482	463
339	464
343	464
345	464
348	464
349	464
382	464
374	464
381	464
377	464
403	464
393	464
391	464
416	464
433	464
431	464
429	464
478	464
497	464
507	464
348	465
349	465
355	465
361	465
369	465
385	465
402	465
403	465
400	465
413	465
416	465
422	465
441	465
452	465
473	465
481	465
484	465
512	465
521	465
348	466
349	466
358	466
362	466
367	466
372	466
373	466
388	466
386	466
374	466
387	466
401	466
419	466
418	466
429	466
430	466
438	466
468	466
491	466
536	466
337	467
338	467
343	467
347	467
348	467
349	467
352	467
353	467
363	467
370	467
393	467
413	467
431	467
444	467
447	467
455	467
457	467
467	467
472	467
479	467
489	467
494	467
341	468
344	468
348	468
349	468
361	468
364	468
375	468
382	468
381	468
377	468
406	468
398	468
402	468
445	468
460	468
465	468
470	468
489	468
499	468
536	468
348	469
349	469
359	469
369	469
371	469
372	469
384	469
379	469
397	469
394	469
391	469
395	469
407	469
440	469
451	469
452	469
473	469
479	469
482	469
344	470
348	470
349	470
358	470
364	470
367	470
374	470
392	470
401	470
399	470
400	470
418	470
416	470
422	470
438	470
447	470
455	470
474	470
497	470
502	470
536	470
337	471
338	471
339	471
345	471
346	471
347	471
348	471
349	471
353	471
368	471
370	471
377	471
390	471
403	471
405	471
431	471
468	471
494	471
524	471
343	472
345	472
348	472
349	472
352	472
353	472
362	472
372	472
384	472
398	472
400	472
413	472
452	472
447	472
471	472
482	472
489	472
524	472
344	473
348	473
349	473
358	473
361	473
364	473
370	473
382	473
388	473
386	473
381	473
387	473
402	473
393	473
424	473
422	473
440	473
438	473
465	473
479	473
478	473
530	473
347	474
348	474
349	474
369	474
375	474
374	474
385	474
377	474
397	474
403	474
395	474
416	474
431	474
430	474
457	474
473	474
494	474
536	474
339	475
345	475
346	475
348	475
349	475
353	475
359	475
373	475
401	475
405	475
400	475
418	475
407	475
452	475
447	475
455	475
472	475
489	475
512	475
524	475
337	476
338	476
343	476
348	476
349	476
352	476
364	476
367	476
370	476
371	476
378	476
384	476
398	476
391	476
424	476
422	476
429	476
460	476
468	476
470	476
344	477
348	477
349	477
358	477
361	477
368	477
372	477
388	477
386	477
387	477
377	477
390	477
402	477
403	477
431	477
440	477
438	477
445	477
444	477
482	477
509	477
348	478
349	478
357	478
364	478
369	478
370	478
375	478
384	478
416	478
407	478
430	478
441	478
451	478
452	478
467	478
479	478
494	478
536	478
341	479
343	479
348	479
349	479
352	479
362	479
371	479
373	479
374	479
385	479
401	479
399	479
413	479
422	479
447	479
460	479
470	479
474	479
347	480
348	480
349	480
355	480
361	480
363	480
382	480
381	480
392	480
395	480
405	480
400	480
418	480
440	480
457	480
471	480
472	480
486	480
491	480
497	480
337	481
338	481
344	481
345	481
348	481
349	481
358	481
359	481
377	481
397	481
398	481
402	481
403	481
391	481
416	481
429	481
468	481
473	481
489	481
492	481
512	481
339	482
343	482
348	482
349	482
352	482
353	482
364	482
370	482
371	482
378	482
384	482
390	482
394	482
424	482
431	482
447	482
455	482
479	482
482	482
337	483
338	483
343	483
344	483
346	483
348	483
349	483
353	483
372	483
384	483
392	483
390	483
413	483
416	483
443	483
449	483
467	483
468	483
481	483
348	484
349	484
358	484
370	484
375	484
388	484
386	484
374	484
385	484
384	484
387	484
407	484
440	484
438	484
445	484
454	484
474	484
478	484
491	484
339	485
348	485
349	485
369	485
377	485
401	485
394	485
391	485
399	485
395	485
405	485
418	485
424	485
451	485
473	485
512	485
521	485
341	486
345	486
348	486
349	486
357	486
359	486
361	486
363	486
398	486
402	486
403	486
419	486
431	486
444	486
457	486
482	486
484	486
497	486
538	486
537	486
343	487
348	487
349	487
352	487
353	487
364	487
368	487
370	487
371	487
373	487
378	487
384	487
407	487
422	487
447	487
455	487
471	487
472	487
479	487
494	487
539	487
344	488
345	488
347	488
348	488
349	488
372	488
382	488
381	488
390	488
391	488
405	488
400	488
418	488
433	488
429	488
460	488
468	488
470	488
346	489
348	489
349	489
358	489
378	489
385	489
384	489
406	489
399	489
419	489
416	489
407	489
422	489
438	489
444	489
447	489
492	489
509	489
520	489
337	490
338	490
348	490
349	490
359	490
375	490
374	490
377	490
397	490
392	490
398	490
402	490
403	490
431	490
440	490
449	490
455	490
457	490
467	490
499	490
512	490
348	491
349	491
355	491
361	491
369	491
372	491
382	491
381	491
395	491
405	491
400	491
418	491
424	491
441	491
452	491
471	491
472	491
481	491
491	491
339	492
343	492
345	492
347	492
348	492
349	492
352	492
362	492
363	492
370	492
371	492
401	492
398	492
394	492
391	492
431	492
429	492
479	492
337	493
338	493
344	493
346	493
348	493
349	493
358	493
364	493
372	493
378	493
384	493
397	493
403	493
416	493
422	493
438	493
447	493
468	493
473	493
482	493
512	493
344	494
345	494
347	494
348	494
349	494
357	494
369	494
440	494
452	494
465	494
473	494
479	494
481	494
482	494
484	494
494	494
502	494
540	494
339	495
341	495
343	495
348	495
349	495
359	495
368	495
370	495
373	495
377	495
401	495
390	495
398	495
394	495
416	495
422	495
508	495
512	495
539	495
541	495
542	495
348	496
349	496
353	496
362	496
364	496
371	496
378	496
382	496
384	496
381	496
402	496
403	496
431	496
454	496
447	496
467	496
470	496
544	496
543	496
346	497
348	497
349	497
352	497
369	497
372	497
374	497
384	497
397	497
395	497
407	497
424	497
451	497
452	497
473	497
479	497
506	497
509	497
337	498
338	498
345	498
347	498
348	498
349	498
363	498
388	498
386	498
387	498
392	498
391	498
419	498
418	498
422	498
441	498
457	498
494	498
545	498
344	499
348	499
349	499
385	499
381	499
377	499
406	499
398	499
393	499
399	499
405	499
400	499
433	499
440	499
449	499
471	499
472	499
474	499
481	499
492	499
513	499
539	499
546	499
339	500
343	500
348	500
349	500
355	500
371	500
378	500
401	500
403	500
416	500
407	500
439	500
445	500
447	500
455	500
468	500
491	500
533	500
541	500
547	500
345	501
348	501
349	501
353	501
359	501
369	501
375	501
373	501
379	501
390	501
413	501
431	501
452	501
479	501
484	501
486	501
494	501
544	501
543	501
548	501
348	502
349	502
352	502
358	502
362	502
364	502
370	502
374	502
384	502
406	502
394	502
418	502
407	502
424	502
422	502
438	502
444	502
549	502
339	503
341	503
343	503
347	503
348	503
349	503
353	503
385	503
397	503
401	503
403	503
391	503
395	503
416	503
430	503
461	503
467	503
470	503
471	503
472	503
512	503
337	504
338	504
344	504
348	504
349	504
357	504
368	504
379	504
398	504
402	504
400	504
429	504
440	504
445	504
441	504
451	504
468	504
473	504
481	504
497	504
545	504
348	505
349	505
369	505
370	505
372	505
382	505
381	505
377	505
393	505
394	505
399	505
405	505
424	505
431	505
449	505
452	505
447	505
482	505
539	505
543	505
339	506
348	506
349	506
357	506
369	506
373	506
388	506
386	506
385	506
387	506
406	506
402	506
393	506
405	506
400	506
418	506
422	506
455	506
473	506
481	506
543	506
345	507
348	507
349	507
358	507
359	507
360	507
368	507
371	507
378	507
384	507
377	507
401	507
390	507
403	507
419	507
407	507
424	507
457	507
509	507
541	507
343	508
348	508
349	508
355	508
361	508
364	508
370	508
384	508
401	508
403	508
416	508
424	508
431	508
444	508
470	508
473	508
474	508
494	508
545	508
547	508
337	509
338	509
339	509
344	509
345	509
347	509
348	509
349	509
353	509
362	509
371	509
405	509
437	509
438	509
471	509
486	509
497	509
506	509
549	509
348	510
349	510
382	510
388	510
386	510
381	510
387	510
398	510
402	510
391	510
400	510
418	510
440	510
451	510
468	510
481	510
484	510
512	510
543	510
546	510
343	511
348	511
349	511
352	511
357	511
359	511
375	511
373	511
378	511
374	511
384	511
401	511
395	511
424	511
430	511
439	511
448	511
473	511
539	511
345	512
347	512
348	512
349	512
353	512
358	512
370	512
390	512
393	512
394	512
416	512
428	512
422	512
433	512
441	512
452	512
457	512
472	512
479	512
486	512
544	512
548	512
337	513
338	513
339	513
348	513
349	513
364	513
369	513
372	513
377	513
397	513
403	513
405	513
407	513
431	513
449	513
447	513
470	513
482	513
492	513
545	513
341	514
343	514
347	514
348	514
349	514
357	514
368	514
369	514
390	514
399	514
418	514
416	514
422	514
439	514
444	514
452	514
455	514
494	514
545	514
546	514
344	515
348	515
349	515
353	515
358	515
371	515
378	515
388	515
386	515
384	515
387	515
403	515
393	515
394	515
407	515
431	515
440	515
445	515
472	515
486	515
488	515
544	515
339	516
343	516
348	516
349	516
352	516
355	516
359	516
378	516
384	516
381	516
398	516
395	516
424	516
422	516
429	516
445	516
473	516
533	516
547	516
549	516
348	517
349	517
369	517
385	517
392	517
404	517
390	517
402	517
399	517
418	517
428	517
431	517
440	517
439	517
457	517
465	517
494	517
545	517
337	518
338	518
344	518
346	518
348	518
349	518
353	518
358	518
370	518
379	518
405	518
438	518
452	518
447	518
455	518
474	518
481	518
497	518
521	518
544	518
543	518
548	518
347	519
348	519
349	519
352	519
354	519
357	519
361	519
388	519
386	519
384	519
387	519
403	519
407	519
433	519
444	519
448	519
449	519
461	519
473	519
506	519
539	519
339	520
343	520
348	520
349	520
364	520
375	520
374	520
377	520
401	520
413	520
416	520
424	520
422	520
468	520
512	520
549	520
345	521
348	521
349	521
360	521
363	521
369	521
393	521
391	521
400	521
418	521
431	521
457	521
465	521
482	521
492	521
494	521
542	521
545	521
550	521
337	522
338	522
340	522
348	522
349	522
406	522
398	522
403	522
395	522
419	522
452	522
462	522
460	522
473	522
481	522
505	522
539	522
544	522
543	522
546	522
341	523
344	523
348	523
349	523
353	523
364	523
378	523
385	523
397	523
401	523
422	523
430	523
440	523
445	523
454	523
467	523
470	523
499	523
540	523
547	523
347	524
348	524
349	524
352	524
359	524
370	524
371	524
388	524
386	524
384	524
387	524
377	524
394	524
407	524
451	524
447	524
479	524
486	524
533	524
551	524
341	525
344	525
348	525
349	525
368	525
382	525
381	525
390	525
405	525
418	525
433	525
439	525
473	525
478	525
497	525
508	525
544	525
545	525
548	525
552	525
339	526
343	526
348	526
349	526
357	526
360	526
378	526
402	526
403	526
393	526
391	526
399	526
400	526
416	526
424	526
431	526
452	526
512	526
541	526
542	526
348	527
349	527
363	527
369	527
375	527
373	527
384	527
406	527
392	527
401	527
398	527
440	527
445	527
449	527
470	527
473	527
506	527
539	527
549	527
344	528
348	528
349	528
355	528
358	528
361	528
362	528
372	528
379	528
377	528
402	528
419	528
422	528
444	528
457	528
468	528
472	528
479	528
484	528
499	528
543	528
339	529
348	529
349	529
353	529
364	529
370	529
381	529
394	529
391	529
405	529
418	529
431	529
439	529
441	529
460	529
474	529
481	529
486	529
546	529
337	530
338	530
341	530
343	530
345	530
346	530
347	530
348	530
349	530
352	530
359	530
374	530
400	530
433	530
429	530
447	530
461	530
545	530
547	530
550	530
348	531
349	531
378	531
385	531
384	531
397	531
390	531
403	531
393	531
395	531
416	531
407	531
428	531
438	531
471	531
482	531
491	531
540	531
544	531
343	532
344	532
348	532
349	532
352	532
357	532
364	532
390	532
399	532
419	532
418	532
422	532
429	532
444	532
452	532
481	532
486	532
499	532
533	532
347	533
348	533
349	533
370	533
382	533
384	533
381	533
379	533
398	533
403	533
416	533
433	533
441	533
447	533
461	533
468	533
497	533
337	534
338	534
339	534
345	534
348	534
349	534
353	534
361	534
363	534
377	534
401	534
405	534
400	534
431	534
439	534
467	534
470	534
484	534
512	534
539	534
543	534
343	535
348	535
349	535
352	535
353	535
355	535
406	535
405	535
413	535
437	535
445	535
444	535
452	535
481	535
491	535
503	535
513	535
544	535
548	535
337	536
338	536
339	536
347	536
348	536
349	536
357	536
368	536
371	536
375	536
374	536
379	536
418	536
422	536
429	536
447	536
465	536
470	536
497	536
547	536
348	537
349	537
361	537
369	537
370	537
372	537
385	537
401	537
390	537
416	537
431	537
448	537
457	537
468	537
479	537
486	537
539	537
543	537
346	538
348	538
349	538
358	538
364	538
378	538
384	538
377	538
403	538
419	538
407	538
428	538
424	538
438	538
444	538
461	538
467	538
482	538
490	538
540	538
337	539
338	539
348	539
349	539
370	539
374	539
377	539
398	539
403	539
394	539
422	539
429	539
452	539
465	539
481	539
497	539
522	539
549	539
553	539
348	540
349	540
353	540
360	540
364	540
369	540
371	540
378	540
384	540
391	540
395	540
416	540
407	540
472	540
512	540
544	540
548	540
343	541
345	541
348	541
349	541
352	541
372	541
388	541
386	541
387	541
390	541
402	541
400	541
418	541
457	541
468	541
484	541
486	541
508	541
546	541
547	541
347	542
348	542
349	542
355	542
357	542
362	542
381	542
377	542
405	542
428	542
433	542
431	542
452	542
447	542
470	542
474	542
479	542
513	542
543	542
339	543
348	543
349	543
352	543
358	543
361	543
369	543
370	543
377	543
392	543
413	543
433	543
438	543
452	543
479	543
484	543
533	543
546	543
344	544
348	544
349	544
357	544
362	544
363	544
372	544
384	544
398	544
405	544
400	544
407	544
429	544
473	544
482	544
491	544
539	544
543	544
347	545
348	545
349	545
353	545
354	545
357	545
359	545
375	545
378	545
385	545
390	545
394	545
416	545
422	545
445	545
447	545
457	545
547	545
549	545
554	545
341	546
343	546
348	546
349	546
352	546
364	546
369	546
370	546
388	546
386	546
387	546
403	546
391	546
399	546
428	546
431	546
468	546
490	546
508	546
546	546
344	547
348	547
349	547
353	547
359	547
382	547
381	547
406	547
405	547
400	547
418	547
424	547
455	547
467	547
473	547
484	547
491	547
542	547
543	547
547	547
554	547
339	548
340	548
345	548
348	548
349	548
360	548
368	548
388	548
386	548
387	548
377	548
404	548
401	548
398	548
416	548
422	548
433	548
452	548
497	548
544	548
546	548
548	548
337	549
338	549
347	549
348	549
349	549
355	549
361	549
364	549
372	549
379	549
397	549
431	549
440	549
441	549
465	549
474	549
479	549
481	549
539	549
340	550
348	550
349	550
354	550
363	550
385	550
384	550
390	550
403	550
399	550
413	550
407	550
473	550
491	550
533	550
540	550
547	550
339	551
341	551
343	551
348	551
349	551
352	551
357	551
370	551
373	551
378	551
401	551
395	551
444	551
452	551
447	551
486	551
541	551
543	551
344	552
348	552
349	552
353	552
362	552
369	552
371	552
388	552
386	552
381	552
387	552
391	552
428	552
471	552
472	552
481	552
506	552
549	552
348	553
349	553
359	553
360	553
364	553
374	553
406	553
398	553
402	553
405	553
400	553
418	553
431	553
429	553
457	553
542	553
546	553
337	554
338	554
339	554
345	554
346	554
347	554
348	554
349	554
375	554
377	554
397	554
394	554
416	554
422	554
433	554
467	554
479	554
486	554
497	554
543	554
340	555
343	555
348	555
349	555
354	555
361	555
384	555
379	555
404	555
390	555
395	555
413	555
407	555
465	555
468	555
470	555
491	555
544	555
548	555
549	555
348	556
349	556
358	556
364	556
369	556
388	556
386	556
387	556
377	556
401	556
403	556
419	556
424	556
431	556
438	556
452	556
447	556
455	556
484	556
533	556
539	556
340	557
345	557
348	557
349	557
374	557
381	557
398	557
402	557
400	557
418	557
416	557
422	557
433	557
447	557
468	557
481	557
512	557
543	557
339	558
344	558
348	558
349	558
353	558
368	558
372	558
375	558
385	558
377	558
395	558
431	558
444	558
467	558
479	558
502	558
547	558
337	559
338	559
347	559
348	559
349	559
364	559
388	559
384	559
404	559
390	559
403	559
405	559
424	559
430	559
454	559
470	559
486	559
491	559
546	559
549	559
337	560
338	560
348	560
349	560
352	560
359	560
369	560
373	560
374	560
384	560
394	560
400	560
418	560
407	560
449	560
486	560
491	560
549	560
340	561
343	561
347	561
348	561
349	561
364	561
370	561
378	561
403	561
391	561
395	561
416	561
428	561
424	561
422	561
444	561
452	561
457	561
482	561
533	561
339	562
348	562
349	562
353	562
379	562
377	562
401	562
398	562
433	562
431	562
429	562
445	562
454	562
447	562
455	562
465	562
470	562
474	562
481	562
539	562
341	563
348	563
364	563
382	563
388	563
381	563
390	563
400	563
418	563
416	563
422	563
447	563
469	563
468	563
474	563
481	563
486	563
490	563
533	563
547	563
338	564
343	564
347	564
348	564
349	564
352	564
357	564
371	564
372	564
385	564
384	564
395	564
482	564
484	564
491	564
542	564
549	564
340	565
344	565
345	565
346	565
348	565
349	565
360	565
363	565
370	565
375	565
378	565
377	565
401	565
403	565
405	565
431	565
430	565
467	565
470	565
471	565
472	565
497	565
540	565
346	566
347	566
348	566
349	566
363	566
368	566
369	566
373	566
377	566
398	566
419	566
418	566
416	566
429	566
451	566
452	566
457	566
471	566
472	566
343	567
348	567
349	567
353	567
362	567
364	567
374	567
381	567
401	567
391	567
405	567
424	567
454	567
470	567
481	567
491	567
506	567
513	567
544	567
548	567
337	568
338	568
340	568
348	568
349	568
352	568
357	568
358	568
360	568
384	568
379	568
377	568
390	568
395	568
407	568
422	568
445	568
449	568
486	568
490	568
533	568
539	568
555	568
344	569
348	569
349	569
364	569
369	569
370	569
375	569
378	569
406	569
405	569
431	569
441	569
452	569
447	569
455	569
467	569
479	569
502	569
506	569
549	569
343	570
347	570
348	570
349	570
359	570
361	570
372	570
385	570
398	570
402	570
400	570
418	570
457	570
465	570
482	570
491	570
521	570
547	570
339	571
345	571
348	571
349	571
353	571
362	571
397	571
401	571
403	571
391	571
399	571
416	571
428	571
424	571
429	571
461	571
474	571
481	571
541	571
544	571
348	572
349	572
359	572
369	572
388	572
384	572
379	572
390	572
405	572
419	572
407	572
422	572
433	572
444	572
447	572
470	572
479	572
512	572
543	572
337	573
338	573
340	573
341	573
343	573
344	573
348	573
349	573
352	573
355	573
364	573
368	573
374	573
406	573
392	573
431	573
445	573
452	573
539	573
339	574
348	574
349	574
357	574
361	574
373	574
382	574
385	574
381	574
398	574
394	574
400	574
418	574
416	574
444	574
468	574
491	574
512	574
546	574
347	575
348	575
349	575
352	575
353	575
363	575
372	575
375	575
384	575
395	575
419	575
422	575
447	575
457	575
467	575
474	575
479	575
481	575
482	575
484	575
547	575
344	576
345	576
348	576
349	576
359	576
362	576
378	576
384	576
377	576
401	576
402	576
405	576
433	576
431	576
430	576
454	576
521	576
544	576
548	576
549	576
339	577
344	577
345	577
348	577
349	577
353	577
363	577
373	577
381	577
406	577
401	577
398	577
391	577
395	577
419	577
418	577
416	577
422	577
448	577
468	577
474	577
556	577
337	578
338	578
343	578
348	578
349	578
352	578
364	578
378	578
388	578
384	578
397	578
390	578
447	578
455	578
479	578
491	578
512	578
547	578
549	578
555	578
341	579
348	579
349	579
360	579
361	579
367	579
369	579
370	579
372	579
374	579
377	579
396	579
402	579
403	579
431	579
440	579
444	579
465	579
482	579
542	579
344	580
346	580
348	580
349	580
353	580
364	580
382	580
406	580
398	580
400	580
418	580
416	580
424	580
444	580
447	580
467	580
491	580
546	580
547	580
340	581
348	581
349	581
358	581
361	581
364	581
369	581
375	581
378	581
397	581
402	581
418	581
416	581
444	581
452	581
472	581
473	581
481	581
512	581
337	582
338	582
341	582
348	582
349	582
352	582
368	582
374	582
384	582
377	582
401	582
403	582
400	582
428	582
431	582
440	582
441	582
447	582
474	582
486	582
488	582
509	582
542	582
543	582
547	582
339	583
344	583
348	583
349	583
359	583
363	583
370	583
373	583
401	583
399	583
422	583
430	583
440	583
444	583
465	583
473	583
484	583
497	583
539	583
549	583
337	584
338	584
340	584
343	584
348	584
349	584
371	584
372	584
392	584
398	584
402	584
400	584
418	584
416	584
429	584
447	584
457	584
491	584
499	584
546	584
547	584
347	585
348	585
349	585
353	585
357	585
361	585
364	585
378	585
384	585
377	585
403	585
405	585
407	585
431	585
441	585
454	585
468	585
473	585
482	585
543	585
339	586
340	586
341	586
348	586
349	586
352	586
375	586
378	586
377	586
401	586
391	586
395	586
400	586
444	586
452	586
482	586
512	586
539	586
541	586
343	587
344	587
348	587
349	587
361	587
364	587
367	587
370	587
373	587
382	587
381	587
398	587
418	587
416	587
471	587
472	587
484	587
509	587
337	588
338	588
347	588
348	588
349	588
371	588
388	588
384	588
390	588
399	588
419	588
424	588
431	588
447	588
479	588
546	588
547	588
555	588
345	589
348	589
349	589
369	589
377	589
401	589
403	589
433	589
445	589
444	589
441	589
449	589
457	589
465	589
467	589
497	589
521	589
544	589
548	589
344	590
348	590
349	590
353	590
359	590
360	590
374	590
385	590
402	590
391	590
395	590
400	590
416	590
428	590
422	590
479	590
499	590
502	590
547	590
340	591
341	591
343	591
347	591
348	591
349	591
352	591
355	591
357	591
361	591
362	591
363	591
372	591
378	591
384	591
452	591
491	591
539	591
549	591
339	592
348	592
349	592
358	592
369	592
370	592
398	592
405	592
418	592
407	592
429	592
438	592
451	592
447	592
468	592
474	592
478	592
481	592
512	592
557	592
337	593
338	593
345	593
348	593
349	593
368	593
371	593
373	593
377	593
397	593
401	593
403	593
394	593
433	593
431	593
430	593
457	593
486	593
544	593
546	593
548	593
340	594
346	594
348	594
349	594
353	594
361	594
364	594
382	594
384	594
381	594
406	594
392	594
400	594
418	594
424	594
422	594
440	594
471	594
472	594
547	594
341	595
343	595
347	595
348	595
349	595
352	595
360	595
372	595
388	595
385	595
390	595
391	595
454	595
455	595
481	595
491	595
505	595
506	595
541	595
339	596
340	596
348	596
349	596
370	596
375	596
378	596
403	596
405	596
407	596
428	596
433	596
443	596
452	596
447	596
461	596
467	596
470	596
490	596
539	596
546	596
348	597
349	597
355	597
359	597
361	597
369	597
379	597
377	597
392	597
416	597
431	597
440	597
445	597
444	597
448	597
449	597
481	597
497	597
544	597
548	597
549	597
344	598
347	598
348	598
349	598
357	598
358	598
406	598
398	598
394	598
391	598
419	598
429	598
438	598
441	598
452	598
465	598
479	598
542	598
547	598
337	599
338	599
348	599
349	599
364	599
370	599
375	599
374	599
402	599
395	599
405	599
418	599
424	599
422	599
457	599
512	599
546	599
341	600
343	600
348	600
349	600
352	600
369	600
373	600
388	600
385	600
384	600
390	600
400	600
433	600
468	600
474	600
484	600
486	600
491	600
539	600
339	601
340	601
345	601
348	601
349	601
353	601
357	601
372	601
382	601
381	601
377	601
401	601
403	601
399	601
416	601
431	601
447	601
455	601
549	601
345	602
348	602
349	602
352	602
368	602
369	602
370	602
396	602
398	602
395	602
418	602
424	602
444	602
448	602
482	602
491	602
508	602
512	602
539	602
558	602
559	602
337	603
338	603
339	603
340	603
348	603
349	603
357	603
364	603
373	603
397	603
401	603
403	603
391	603
399	603
416	603
431	603
438	603
455	603
481	603
547	603
549	603
344	604
348	604
349	604
362	604
378	604
388	604
385	604
384	604
377	604
390	604
405	604
400	604
422	604
447	604
497	604
521	604
539	604
543	604
343	605
348	605
349	605
357	605
364	605
369	605
374	605
377	605
394	605
407	605
444	605
452	605
447	605
465	605
491	605
512	605
542	605
543	605
549	605
345	606
347	606
348	606
349	606
352	606
359	606
370	606
381	606
392	606
398	606
418	606
416	606
428	606
431	606
429	606
430	606
457	606
470	606
346	607
348	607
349	607
353	607
357	607
361	607
388	607
384	607
390	607
402	607
403	607
419	607
433	607
451	607
481	607
482	607
490	607
547	607
549	607
345	608
347	608
348	608
349	608
353	608
368	608
371	608
388	608
377	608
405	608
400	608
419	608
422	608
433	608
430	608
445	608
479	608
481	608
482	608
486	608
513	608
539	608
341	609
343	609
348	609
349	609
352	609
362	609
370	609
378	609
385	609
384	609
401	609
398	609
391	609
418	609
431	609
429	609
454	609
521	609
337	610
338	610
339	610
348	610
349	610
364	610
369	610
374	610
402	610
403	610
416	610
407	610
444	610
449	610
447	610
470	610
491	610
497	610
555	610
348	611
349	611
364	611
369	611
373	611
374	611
398	611
403	611
395	611
405	611
428	611
431	611
444	611
454	611
452	611
481	611
544	611
548	611
337	612
338	612
343	612
346	612
347	612
348	612
349	612
358	612
359	612
368	612
370	612
384	612
379	612
390	612
418	612
416	612
438	612
491	612
512	612
339	613
345	613
348	613
349	613
372	613
382	613
388	613
381	613
377	613
401	613
400	613
422	613
433	613
447	613
470	613
479	613
486	613
492	613
539	613
348	614
349	614
369	614
370	614
388	614
374	614
406	614
390	614
405	614
430	614
445	614
452	614
447	614
479	614
481	614
486	614
491	614
505	614
547	614
552	614
560	614
337	615
338	615
340	615
348	615
349	615
358	615
368	615
384	615
379	615
403	615
391	615
416	615
428	615
431	615
455	615
472	615
482	615
484	615
544	615
548	615
339	616
343	616
348	616
349	616
352	616
361	616
364	616
382	616
381	616
401	616
398	616
394	616
400	616
418	616
422	616
444	616
441	616
467	616
508	616
509	616
512	616
547	616
347	617
348	617
349	617
362	617
369	617
373	617
377	617
390	617
399	617
419	617
433	617
454	617
452	617
457	617
479	617
491	617
521	617
539	617
540	617
344	618
348	618
349	618
359	618
370	618
371	618
372	618
378	618
385	618
384	618
379	618
416	618
407	618
431	618
429	618
447	618
502	618
546	618
555	618
337	619
338	619
348	619
349	619
353	619
364	619
367	619
392	619
402	619
403	619
391	619
395	619
428	619
424	619
422	619
445	619
449	619
544	619
548	619
339	620
341	620
343	620
348	620
349	620
352	620
363	620
370	620
373	620
378	620
401	620
391	620
428	620
441	620
482	620
491	620
521	620
539	620
345	621
348	621
349	621
359	621
361	621
362	621
371	621
382	621
381	621
398	621
403	621
419	621
418	621
407	621
433	621
431	621
429	621
452	621
347	622
348	622
349	622
358	622
372	622
375	622
385	622
384	622
377	622
397	622
405	622
438	622
444	622
447	622
479	622
484	622
555	622
343	623
348	623
349	623
352	623
361	623
368	623
373	623
378	623
377	623
390	623
422	623
433	623
444	623
465	623
468	623
481	623
512	623
561	623
563	623
562	623
564	623
341	624
348	624
349	624
369	624
370	624
372	624
398	624
394	624
405	624
418	624
424	624
452	624
447	624
474	624
482	624
486	624
491	624
505	624
547	624
337	625
338	625
339	625
345	625
348	625
349	625
355	625
363	625
406	625
401	625
403	625
391	625
416	625
455	625
461	625
467	625
508	625
521	625
544	625
548	625
344	626
346	626
347	626
348	626
349	626
360	626
375	626
374	626
379	626
419	626
422	626
438	626
445	626
441	626
457	626
471	626
490	626
557	626
348	627
349	627
353	627
359	627
361	627
369	627
385	627
384	627
377	627
397	627
431	627
440	627
448	627
454	627
452	627
465	627
506	627
541	627
343	628
348	628
349	628
352	628
382	628
388	628
381	628
390	628
400	628
418	628
428	628
424	628
462	628
481	628
484	628
491	628
540	628
337	629
338	629
339	629
347	629
348	629
349	629
358	629
364	629
403	629
391	629
399	629
405	629
422	629
472	629
474	629
497	629
521	629
542	629
544	629
548	629
341	630
345	630
348	630
349	630
363	630
372	630
378	630
384	630
398	630
395	630
416	630
407	630
429	630
445	630
451	630
479	630
547	630
348	631
349	631
369	631
373	631
385	631
396	631
402	631
403	631
419	631
428	631
431	631
452	631
447	631
457	631
467	631
468	631
478	631
484	631
486	631
539	631
345	632
346	632
348	632
349	632
373	632
374	632
379	632
401	632
400	632
418	632
422	632
440	632
448	632
465	632
481	632
482	632
505	632
512	632
540	632
555	632
343	633
348	633
349	633
352	633
359	633
361	633
369	633
370	633
382	633
388	633
381	633
377	633
390	633
424	633
444	633
441	633
452	633
491	633
497	633
337	634
338	634
347	634
348	634
349	634
358	634
384	634
392	634
398	634
391	634
405	634
433	634
431	634
429	634
438	634
454	634
455	634
479	634
547	634
552	634
344	635
348	635
349	635
355	635
375	635
378	635
385	635
377	635
403	635
394	635
416	635
428	635
449	635
447	635
467	635
486	635
521	635
544	635
548	635
339	636
341	636
343	636
345	636
348	636
349	636
352	636
353	636
360	636
363	636
368	636
374	636
406	636
402	636
400	636
418	636
451	636
474	636
484	636
508	636
337	637
338	637
348	637
349	637
372	637
384	637
379	637
397	637
395	637
416	637
407	637
440	637
444	637
447	637
468	637
471	637
472	637
491	637
539	637
555	637
348	638
349	638
358	638
361	638
364	638
369	638
371	638
373	638
388	638
389	638
401	638
390	638
403	638
419	638
438	638
445	638
441	638
452	638
481	638
486	638
346	639
347	639
348	639
349	639
370	639
382	639
385	639
381	639
377	639
398	639
391	639
405	639
428	639
431	639
448	639
457	639
479	639
509	639
343	640
344	640
347	640
348	640
349	640
352	640
361	640
362	640
369	640
375	640
374	640
399	640
400	640
418	640
433	640
452	640
491	640
512	640
337	641
338	641
348	641
349	641
353	641
384	641
379	641
397	641
398	641
403	641
395	641
416	641
407	641
428	641
422	641
429	641
444	641
447	641
540	641
555	641
347	642
348	642
358	642
361	642
364	642
368	642
369	642
398	642
403	642
399	642
419	642
418	642
422	642
438	642
468	642
481	642
503	642
547	642
565	642
339	643
343	643
348	643
349	643
353	643
371	643
372	643
379	643
401	643
390	643
394	643
391	643
395	643
400	643
433	643
445	643
452	643
486	643
491	643
502	643
512	643
555	643
337	644
338	644
345	644
346	644
348	644
349	644
363	644
378	644
384	644
377	644
405	644
428	644
431	644
444	644
447	644
455	644
539	644
546	644
552	644
343	645
346	645
348	645
349	645
352	645
358	645
369	645
373	645
378	645
385	645
384	645
406	645
407	645
438	645
445	645
452	645
455	645
467	645
479	645
552	645
566	645
337	646
338	646
347	646
348	646
349	646
361	646
364	646
370	646
371	646
379	646
394	646
418	646
429	646
440	646
457	646
491	646
512	646
541	646
547	646
339	647
345	647
348	647
349	647
355	647
362	647
375	647
382	647
381	647
377	647
403	647
419	647
416	647
431	647
448	647
447	647
474	647
481	647
539	647
540	647
339	648
348	648
349	648
352	648
353	648
359	648
364	648
401	648
398	648
403	648
431	648
429	648
445	648
447	648
457	648
542	648
544	648
547	648
548	648
347	649
348	649
349	649
368	649
369	649
378	649
374	649
384	649
377	649
395	649
405	649
419	649
407	649
444	649
454	649
452	649
479	649
491	649
539	649
546	649
337	650
338	650
341	650
343	650
344	650
348	650
349	650
358	650
373	650
406	650
402	650
391	650
400	650
418	650
416	650
433	650
431	650
468	650
472	650
482	650
541	650
552	650
567	650
339	651
348	651
349	651
352	651
369	651
370	651
375	651
378	651
382	651
381	651
398	651
403	651
395	651
422	651
445	651
452	651
447	651
455	651
512	651
547	651
348	652
349	652
353	652
360	652
361	652
384	652
379	652
397	652
399	652
416	652
407	652
428	652
438	652
462	652
471	652
544	652
548	652
555	652
565	652
343	653
345	653
347	653
348	653
349	653
352	653
363	653
368	653
369	653
373	653
388	653
390	653
400	653
418	653
429	653
452	653
491	653
512	653
546	653
348	654
349	654
358	654
364	654
406	654
402	654
403	654
391	654
419	654
424	654
422	654
444	654
472	654
479	654
478	654
481	654
484	654
539	654
542	654
552	654
566	654
348	655
349	655
359	655
369	655
370	655
385	655
381	655
377	655
398	655
416	655
431	655
454	655
447	655
455	655
457	655
486	655
547	655
555	655
568	655
344	656
345	656
347	656
348	656
349	656
360	656
368	656
372	656
373	656
374	656
394	656
400	656
418	656
433	656
440	656
452	656
465	656
474	656
491	656
546	656
343	657
348	657
349	657
352	657
361	657
364	657
369	657
384	657
390	657
403	657
399	657
407	657
424	657
445	657
468	657
512	657
540	657
544	657
337	658
338	658
339	658
346	658
348	658
349	658
377	658
397	658
401	658
398	658
391	658
395	658
416	658
428	658
422	658
429	658
452	658
479	658
539	658
541	658
341	659
343	659
344	659
345	659
348	659
349	659
353	659
360	659
361	659
373	659
378	659
401	659
398	659
400	659
418	659
416	659
491	659
512	659
541	659
555	659
557	659
337	660
338	660
348	660
349	660
355	660
371	660
385	660
384	660
397	660
390	660
395	660
405	660
445	660
447	660
468	660
474	660
479	660
481	660
486	660
542	660
341	661
343	661
347	661
348	661
349	661
352	661
353	661
361	661
364	661
373	661
395	661
400	661
418	661
424	661
422	661
444	661
454	661
457	661
541	661
345	662
348	662
349	662
358	662
368	662
370	662
378	662
384	662
398	662
403	662
416	662
407	662
433	662
438	662
445	662
482	662
512	662
521	662
542	662
544	662
548	662
569	662
337	663
338	663
339	663
348	663
349	663
388	663
385	663
377	663
390	663
402	663
391	663
399	663
405	663
428	663
431	663
455	663
479	663
539	663
555	663
557	663
347	664
348	664
349	664
360	664
363	664
378	664
382	664
381	664
398	664
403	664
418	664
416	664
447	664
455	664
457	664
491	664
512	664
544	664
548	664
557	664
339	665
343	665
346	665
348	665
349	665
352	665
364	665
368	665
373	665
374	665
377	665
397	665
401	665
428	665
424	665
422	665
438	665
444	665
471	665
539	665
348	666
349	666
353	666
361	666
375	666
388	666
384	666
390	666
399	666
405	666
419	666
407	666
433	666
431	666
445	666
513	666
555	666
344	667
348	667
349	667
353	667
370	667
379	667
377	667
406	667
398	667
391	667
416	667
429	667
474	667
479	667
478	667
481	667
491	667
521	667
539	667
560	667
343	668
347	668
348	668
349	668
352	668
358	668
359	668
363	668
371	668
398	668
403	668
422	668
437	668
445	668
444	668
447	668
455	668
457	668
472	668
541	668
544	668
548	668
348	669
361	669
368	669
378	669
374	669
385	669
384	669
397	669
394	669
418	669
416	669
407	669
428	669
431	669
484	669
339	670
348	670
349	670
353	670
373	670
388	670
381	670
377	670
397	670
401	670
390	670
391	670
395	670
405	670
440	670
462	670
479	670
491	670
513	670
539	670
341	671
343	671
348	671
349	671
352	671
364	671
398	671
403	671
400	671
422	671
429	671
444	671
448	671
449	671
447	671
474	671
502	671
512	671
515	671
557	671
344	672
345	672
348	672
353	672
370	672
372	672
396	672
402	672
418	672
433	672
431	672
457	672
465	672
490	672
509	672
540	672
544	672
548	672
555	672
346	673
348	673
349	673
361	673
373	673
378	673
388	673
384	673
397	673
416	673
424	673
433	673
467	673
481	673
482	673
491	673
497	673
539	673
337	674
338	674
339	674
343	674
348	674
349	674
352	674
360	674
363	674
374	674
406	674
401	674
391	674
399	674
400	674
418	674
521	674
555	674
570	674
341	675
347	675
348	675
349	675
358	675
382	675
385	675
381	675
392	675
398	675
403	675
422	675
429	675
445	675
468	675
472	675
479	675
512	675
544	675
548	675
345	676
348	676
349	676
355	676
368	676
375	676
384	676
377	676
419	676
416	676
407	676
428	676
433	676
431	676
457	676
462	676
467	676
539	676
542	676
343	677
344	677
348	677
349	677
352	677
353	677
364	677
370	677
373	677
388	677
379	677
390	677
418	677
422	677
454	677
447	677
474	677
478	677
481	677
555	677
339	678
348	678
349	678
358	678
360	678
361	678
372	678
382	678
385	678
381	678
401	678
403	678
405	678
445	678
444	678
484	678
513	678
521	678
544	678
570	678
571	678
337	679
338	679
348	679
349	679
371	679
384	679
377	679
397	679
398	679
391	679
395	679
407	679
429	679
438	679
441	679
472	679
479	679
491	679
512	679
515	679
535	679
539	679
344	680
345	680
347	680
348	680
349	680
353	680
403	680
394	680
399	680
400	680
416	680
428	680
433	680
431	680
449	680
447	680
455	680
457	680
541	680
343	681
348	681
349	681
352	681
361	681
364	681
370	681
379	681
406	681
392	681
418	681
407	681
422	681
444	681
474	681
481	681
555	681
337	682
338	682
339	682
348	682
349	682
385	682
401	682
398	682
403	682
391	682
395	682
428	682
429	682
445	682
468	682
491	682
544	682
548	682
345	683
348	683
349	683
353	683
382	683
384	683
381	683
377	683
396	683
419	683
433	683
431	683
437	683
447	683
455	683
467	683
479	683
484	683
539	683
353	684
339	685
344	685
348	685
349	685
359	685
360	685
361	685
375	685
373	685
397	685
406	685
405	685
433	685
451	685
449	685
474	685
481	685
542	685
348	686
349	686
352	686
358	686
364	686
368	686
372	686
374	686
384	686
377	686
401	686
395	686
422	686
444	686
472	686
479	686
544	686
337	687
338	687
341	687
343	687
345	687
347	687
348	687
349	687
353	687
370	687
388	687
390	687
403	687
416	687
454	687
447	687
555	687
348	688
349	688
362	688
371	688
398	688
394	688
391	688
400	688
418	688
428	688
429	688
438	688
444	688
457	688
465	688
471	688
539	688
343	689
347	689
348	689
349	689
352	689
361	689
364	689
375	689
379	689
398	689
400	689
418	689
407	689
424	689
422	689
444	689
481	689
482	689
512	689
555	689
572	689
341	690
345	690
346	690
348	690
349	690
362	690
368	690
385	690
381	690
402	690
403	690
419	690
437	690
467	690
471	690
472	690
474	690
479	690
497	690
539	690
542	690
337	691
338	691
344	691
348	691
349	691
360	691
388	691
377	691
397	691
390	691
398	691
391	691
395	691
405	691
428	691
422	691
429	691
481	691
502	691
541	691
339	692
343	692
348	692
349	692
353	692
358	692
370	692
374	692
384	692
401	692
416	692
407	692
433	692
438	692
441	692
451	692
454	692
447	692
468	692
478	692
544	692
345	693
348	693
349	693
358	693
368	693
382	693
381	693
402	693
419	693
418	693
428	693
433	693
440	693
444	693
447	693
455	693
457	693
472	693
479	693
343	694
346	694
347	694
348	694
349	694
355	694
360	694
361	694
363	694
370	694
384	694
403	694
416	694
422	694
454	694
489	694
542	694
339	695
348	695
349	695
362	695
364	695
375	695
379	695
377	695
398	695
391	695
405	695
400	695
429	695
474	695
481	695
512	695
539	695
541	695
337	696
338	696
344	696
348	696
349	696
353	696
361	696
368	696
370	696
378	696
379	696
418	696
416	696
433	696
438	696
444	696
457	696
461	696
472	696
484	696
343	697
345	697
347	697
348	697
349	697
352	697
371	697
373	697
374	697
384	697
397	697
403	697
395	697
407	697
422	697
505	697
512	697
515	697
542	697
348	698
349	698
358	698
360	698
385	698
381	698
377	698
390	698
398	698
402	698
391	698
419	698
428	698
437	698
479	698
478	698
539	698
555	698
339	699
348	699
349	699
352	699
353	699
374	699
406	699
401	699
398	699
403	699
400	699
444	699
451	699
447	699
492	699
544	699
555	699
573	699
574	699
343	700
347	700
348	700
349	700
360	700
364	700
368	700
370	700
379	700
391	700
418	700
416	700
422	700
454	700
455	700
457	700
489	700
542	700
575	700
337	701
338	701
344	701
348	701
349	701
358	701
361	701
385	701
377	701
395	701
428	701
433	701
472	701
474	701
479	701
481	701
482	701
484	701
539	701
541	701
343	702
348	702
349	702
353	702
358	702
364	702
373	702
382	702
397	702
398	702
391	702
418	702
416	702
424	702
437	702
438	702
444	702
492	702
512	702
575	702
348	703
349	703
360	703
362	703
372	703
375	703
388	703
384	703
379	703
390	703
403	703
407	703
440	703
451	703
447	703
462	703
465	703
544	703
577	703
576	703
337	704
338	704
341	704
344	704
345	704
346	704
347	704
348	704
349	704
361	704
363	704
370	704
377	704
405	704
422	704
468	704
497	704
539	704
542	704
555	704
578	704
343	705
348	705
349	705
352	705
353	705
368	705
374	705
406	705
398	705
402	705
400	705
418	705
424	705
444	705
451	705
457	705
478	705
515	705
541	705
575	705
348	706
349	706
373	706
378	706
384	706
397	706
403	706
399	706
416	706
407	706
428	706
433	706
440	706
438	706
449	706
472	706
489	706
492	706
555	706
347	707
348	707
349	707
355	707
364	707
398	707
419	707
422	707
429	707
445	707
447	707
455	707
465	707
479	707
481	707
512	707
577	707
422	708
465	708
479	708
581	708
580	708
579	708
343	709
344	709
348	709
349	709
352	709
353	709
361	709
375	709
385	709
381	709
402	709
400	709
428	709
433	709
448	709
467	709
492	709
573	709
574	709
575	709
337	710
338	710
339	710
348	710
349	710
358	710
359	710
379	710
377	710
397	710
401	710
391	710
395	710
405	710
431	710
472	710
497	710
539	710
542	710
555	710
343	711
348	711
349	711
361	711
364	711
370	711
382	711
384	711
381	711
392	711
418	711
424	711
422	711
444	711
465	711
484	711
512	711
577	711
582	711
341	712
344	712
345	712
348	712
349	712
358	712
360	712
371	712
398	712
403	712
394	712
419	712
416	712
428	712
438	712
461	712
468	712
474	712
481	712
515	712
542	712
339	713
348	713
349	713
353	713
363	713
375	713
401	713
391	713
405	713
400	713
424	713
429	713
445	713
451	713
455	713
479	713
513	713
544	713
555	713
560	713
576	713
337	714
338	714
343	714
345	714
346	714
348	714
349	714
352	714
362	714
368	714
374	714
384	714
377	714
422	714
454	714
467	714
506	714
539	714
542	714
573	714
574	714
347	715
348	715
349	715
361	715
370	715
382	715
379	715
398	715
399	715
395	715
418	715
416	715
428	715
433	715
431	715
457	715
509	715
344	716
348	716
349	716
367	716
388	716
385	716
397	716
390	716
407	716
440	716
444	716
447	716
465	716
474	716
478	716
499	716
512	716
541	716
555	716
575	716
577	716
348	717
349	717
352	717
358	717
368	717
373	717
382	717
374	717
384	717
381	717
406	717
403	717
419	717
444	717
447	717
472	717
479	717
492	717
544	717
339	718
343	718
348	718
349	718
353	718
359	718
361	718
362	718
364	718
372	718
401	718
398	718
418	718
416	718
422	718
445	718
459	718
503	718
555	718
575	718
576	718
337	719
338	719
344	719
345	719
348	719
349	719
370	719
377	719
394	719
391	719
395	719
405	719
424	719
437	719
448	719
449	719
454	719
474	719
479	719
481	719
502	719
539	719
555	719
343	720
347	720
348	720
349	720
375	720
378	720
384	720
398	720
400	720
416	720
428	720
429	720
441	720
447	720
467	720
468	720
544	720
575	720
341	721
344	721
348	721
349	721
353	721
361	721
368	721
397	721
406	721
402	721
399	721
418	721
424	721
422	721
444	721
462	721
465	721
541	721
555	721
348	722
349	722
358	722
359	722
363	722
371	722
375	722
382	722
388	722
381	722
401	722
390	722
403	722
391	722
419	722
438	722
451	722
455	722
457	722
497	722
339	723
343	723
345	723
348	723
349	723
352	723
353	723
370	723
373	723
374	723
377	723
402	723
394	723
395	723
407	723
437	723
449	723
512	723
539	723
541	723
337	724
338	724
347	724
348	724
349	724
360	724
362	724
364	724
379	724
398	724
400	724
418	724
416	724
429	724
454	724
472	724
481	724
540	724
544	724
575	724
341	725
348	725
349	725
361	725
378	725
385	725
384	725
405	725
428	725
422	725
440	725
445	725
474	725
479	725
482	725
492	725
506	725
555	725
576	725
343	726
347	726
348	726
349	726
352	726
355	726
364	726
368	726
370	726
391	726
418	726
424	726
422	726
444	726
457	726
472	726
576	726
345	727
348	727
349	727
358	727
362	727
363	727
375	727
374	727
384	727
381	727
398	727
403	727
399	727
405	727
407	727
438	727
541	727
544	727
555	727
569	727
575	727
344	728
348	728
349	728
368	728
388	728
385	728
384	728
377	728
390	728
402	728
391	728
400	728
416	728
422	728
444	728
441	728
499	728
539	728
578	728
343	729
348	729
349	729
352	729
368	729
370	729
375	729
384	729
398	729
394	729
419	729
418	729
424	729
422	729
467	729
468	729
555	729
576	729
337	730
338	730
345	730
346	730
347	730
348	730
349	730
371	730
374	730
397	730
403	730
391	730
429	730
440	730
444	730
457	730
555	730
575	730
339	731
344	731
348	731
349	731
378	731
382	731
385	731
381	731
398	731
402	731
405	731
428	731
422	731
429	731
449	731
462	731
505	731
507	731
540	731
348	732
349	732
358	732
360	732
364	732
368	732
372	732
377	732
401	732
399	732
419	732
416	732
424	732
447	732
455	732
457	732
472	732
539	732
555	732
569	732
575	732
341	733
348	733
349	733
355	733
388	733
390	733
391	733
395	733
433	733
438	733
444	733
451	733
465	733
471	733
481	733
484	733
490	733
512	733
541	733
572	733
343	734
344	734
346	734
348	734
349	734
353	734
361	734
368	734
373	734
384	734
398	734
400	734
418	734
407	734
576	734
337	735
338	735
341	735
345	735
348	735
349	735
358	735
363	735
370	735
375	735
392	735
398	735
402	735
405	735
428	735
445	735
448	735
447	735
457	735
472	735
479	735
555	735
575	735
576	735
339	736
348	736
349	736
353	736
373	736
382	736
381	736
401	736
394	736
391	736
418	736
422	736
433	736
440	736
438	736
455	736
465	736
467	736
468	736
471	736
485	736
506	736
544	736
343	737
346	737
348	737
349	737
352	737
358	737
361	737
364	737
367	737
374	737
398	737
403	737
399	737
419	737
429	737
454	737
472	737
474	737
481	737
344	738
347	738
348	738
349	738
359	738
362	738
368	738
385	738
384	738
391	738
400	738
418	738
416	738
407	738
428	738
444	738
461	738
467	738
484	738
575	738
337	739
338	739
339	739
345	739
348	739
349	739
353	739
363	739
388	739
377	739
397	739
401	739
390	739
395	739
405	739
440	739
447	739
479	739
539	739
555	739
576	739
343	740
348	740
349	740
352	740
360	740
367	740
368	740
373	740
378	740
384	740
396	740
397	740
406	740
424	740
422	740
433	740
447	740
472	740
481	740
506	740
541	740
348	741
349	741
363	741
364	741
371	741
388	741
377	741
398	741
394	741
391	741
405	741
400	741
418	741
444	741
457	741
479	741
539	741
575	741
341	742
347	742
348	742
349	742
353	742
361	742
370	742
375	742
379	742
392	742
403	742
416	742
428	742
438	742
445	742
451	742
467	742
471	742
478	742
482	742
555	742
343	743
344	743
346	743
347	743
348	743
349	743
352	743
358	743
382	743
384	743
381	743
390	743
398	743
400	743
429	743
454	743
468	743
472	743
515	743
576	743
339	744
345	744
348	744
349	744
355	744
362	744
367	744
385	744
401	744
399	744
395	744
405	744
419	744
418	744
428	744
422	744
447	744
474	744
555	744
337	745
338	745
348	745
349	745
353	745
364	745
368	745
374	745
377	745
397	745
402	745
403	745
433	745
440	745
438	745
451	745
455	745
465	745
471	745
481	745
541	745
575	745
343	746
348	746
349	746
352	746
368	746
373	746
382	746
384	746
381	746
390	746
398	746
391	746
399	746
395	746
416	746
428	746
433	746
451	746
481	746
506	746
348	747
349	747
353	747
358	747
359	747
385	747
377	747
402	747
405	747
400	747
418	747
429	747
440	747
444	747
457	747
472	747
513	747
555	747
575	747
576	747
339	748
343	748
345	748
348	748
349	748
352	748
353	748
397	748
390	748
395	748
418	748
424	748
433	748
444	748
441	748
454	748
474	748
540	748
337	749
338	749
344	749
347	749
348	749
349	749
361	749
368	749
371	749
374	749
384	749
398	749
419	749
416	749
428	749
440	749
448	749
484	749
508	749
541	749
555	749
337	750
338	750
345	750
348	750
349	750
352	750
360	750
373	750
388	750
396	750
406	750
403	750
391	750
399	750
400	750
418	750
428	750
424	750
468	750
481	750
576	750
343	751
347	751
348	751
349	751
358	751
368	751
385	751
384	751
398	751
395	751
419	751
416	751
428	751
433	751
429	751
444	751
472	751
539	751
541	751
339	752
341	752
344	752
348	752
349	752
353	752
361	752
362	752
363	752
370	752
377	752
401	752
440	752
451	752
449	752
454	752
465	752
474	752
482	752
555	752
343	753
344	753
347	753
348	753
349	753
352	753
353	753
379	753
398	753
394	753
391	753
400	753
428	753
429	753
451	753
462	753
481	753
576	753
345	754
348	754
349	754
355	754
358	754
361	754
373	754
397	754
392	754
402	754
418	754
416	754
433	754
440	754
444	754
455	754
457	754
472	754
497	754
348	755
349	755
363	755
372	755
382	755
384	755
381	755
395	755
405	755
407	755
424	755
443	755
445	755
467	755
506	755
540	755
541	755
555	755
575	755
343	756
348	756
349	756
352	756
353	756
362	756
368	756
375	756
373	756
398	756
403	756
391	756
419	756
433	756
438	756
454	756
471	756
474	756
481	756
484	756
508	756
539	756
347	757
348	757
349	757
358	757
360	757
361	757
363	757
367	757
370	757
388	757
374	757
390	757
405	757
418	757
428	757
441	757
472	757
555	757
576	757
583	757
344	758
345	758
346	758
348	758
349	758
353	758
359	758
371	758
373	758
384	758
419	758
424	758
443	758
444	758
467	758
507	758
540	758
584	758
337	759
338	759
341	759
343	759
348	759
349	759
352	759
372	759
378	759
385	759
398	759
400	759
418	759
433	759
429	759
449	759
462	759
478	759
481	759
522	759
348	760
349	760
358	760
364	760
382	760
381	760
379	760
377	760
397	760
401	760
391	760
428	760
440	760
457	760
465	760
472	760
482	760
505	760
508	760
539	760
541	760
555	760
339	761
347	761
348	761
349	761
353	761
370	761
388	761
374	761
406	761
403	761
416	761
407	761
433	761
440	761
438	761
451	761
455	761
468	761
471	761
522	761
576	761
343	762
344	762
345	762
348	762
349	762
352	762
355	762
367	762
373	762
402	762
394	762
400	762
418	762
444	762
449	762
484	762
497	762
540	762
348	763
349	763
361	763
362	763
375	763
385	763
384	763
377	763
398	763
399	763
405	763
428	763
443	763
445	763
454	763
481	763
506	763
541	763
555	763
339	764
341	764
348	764
349	764
353	764
359	764
360	764
361	764
368	764
379	764
396	764
392	764
401	764
419	764
407	764
467	764
490	764
508	764
337	765
338	765
348	765
349	765
364	765
397	765
402	765
403	765
395	765
424	765
440	765
451	765
454	765
457	765
465	765
482	765
503	765
522	765
555	765
575	765
347	766
348	766
349	766
352	766
374	766
385	766
384	766
406	766
394	766
391	766
400	766
428	766
455	766
468	766
471	766
472	766
539	766
544	766
343	767
344	767
346	767
348	767
349	767
353	767
358	767
361	767
370	767
372	767
373	767
390	767
418	767
416	767
433	767
438	767
444	767
474	767
481	767
576	767
339	768
345	768
348	768
349	768
363	768
368	768
382	768
381	768
377	768
397	768
398	768
405	768
429	768
443	768
449	768
497	768
513	768
555	768
343	769
345	769
347	769
348	769
349	769
353	769
367	769
406	769
394	769
391	769
399	769
400	769
424	769
444	769
454	769
467	769
539	769
576	769
337	770
338	770
339	770
344	770
346	770
348	770
349	770
364	770
374	770
401	770
390	770
419	770
468	770
474	770
481	770
490	770
508	770
522	770
569	770
341	771
348	771
349	771
353	771
358	771
361	771
382	771
385	771
381	771
397	771
398	771
402	771
395	771
418	771
428	771
433	771
440	771
441	771
449	771
465	771
472	771
555	771
337	772
338	772
339	772
343	772
344	772
348	772
349	772
352	772
353	772
358	772
406	772
391	772
400	772
418	772
424	772
444	772
455	772
472	772
474	772
481	772
508	772
555	772
345	773
347	773
348	773
349	773
361	773
370	773
382	773
381	773
392	773
398	773
403	773
394	773
433	773
429	773
443	773
445	773
457	773
490	773
497	773
569	773
341	774
348	774
349	774
355	774
364	774
372	774
374	774
397	774
401	774
402	774
395	774
405	774
428	774
440	774
441	774
449	774
447	774
478	774
499	774
555	774
575	774
585	774
341	775
347	775
348	775
349	775
353	775
358	775
372	775
373	775
374	775
385	775
406	775
400	775
416	775
428	775
429	775
445	775
451	775
455	775
472	775
503	775
539	775
555	775
337	776
338	776
339	776
343	776
346	776
348	776
349	776
352	776
360	776
367	776
370	776
379	776
401	776
398	776
433	776
444	776
467	776
474	776
481	776
490	776
508	776
522	776
555	776
575	776
348	777
349	777
373	777
382	777
381	777
397	777
402	777
391	777
395	777
405	777
418	777
424	777
443	777
457	777
462	777
482	777
484	777
497	777
344	778
348	778
349	778
361	778
364	778
375	778
384	778
403	778
428	778
440	778
454	778
468	778
471	778
472	778
502	778
507	778
555	778
583	778
341	779
343	779
348	779
349	779
352	779
359	779
360	779
361	779
367	779
368	779
379	779
396	779
397	779
406	779
402	779
418	779
424	779
451	779
474	779
481	779
555	779
576	779
339	780
348	780
349	780
358	780
370	780
373	780
378	780
374	780
401	780
398	780
391	780
395	780
405	780
429	780
438	780
444	780
484	780
503	780
555	780
584	780
344	781
345	781
346	781
347	781
348	781
349	781
353	781
385	781
384	781
394	781
400	781
428	781
444	781
455	781
457	781
465	781
467	781
490	781
508	781
522	781
555	781
575	781
347	782
348	782
349	782
373	782
384	782
391	782
400	782
418	782
440	782
451	782
465	782
468	782
478	782
497	782
511	782
343	783
345	783
346	783
348	783
349	783
352	783
358	783
367	783
370	783
385	783
406	783
398	783
402	783
395	783
429	783
438	783
444	783
457	783
341	784
348	784
349	784
353	784
359	784
372	784
382	784
374	784
377	784
403	784
416	784
407	784
445	784
482	784
505	784
522	784
539	784
575	784
337	785
338	785
344	785
348	785
349	785
358	785
361	785
373	785
384	785
396	785
397	785
405	785
433	785
451	785
455	785
467	785
472	785
497	785
509	785
586	785
345	786
348	786
349	786
362	786
368	786
370	786
375	786
385	786
390	786
402	786
403	786
394	786
438	786
454	786
465	786
471	786
474	786
481	786
502	786
339	787
341	787
343	787
348	787
349	787
352	787
355	787
372	787
388	787
392	787
401	787
391	787
399	787
400	787
418	787
461	787
484	787
583	787
348	788
349	788
353	788
371	788
384	788
398	788
395	788
416	788
407	788
433	788
445	788
457	788
468	788
497	788
506	788
508	788
522	788
339	789
344	789
347	789
348	789
349	789
358	789
359	789
361	789
377	789
397	789
406	789
405	789
429	789
440	789
444	789
472	789
539	789
575	789
341	790
344	790
345	790
348	790
349	790
370	790
372	790
373	790
382	790
374	790
398	790
391	790
395	790
416	790
438	790
445	790
462	790
471	790
474	790
478	790
481	790
484	790
515	790
337	791
338	791
343	791
348	791
349	791
352	791
362	791
367	791
396	791
406	791
402	791
394	791
400	791
418	791
424	791
451	791
502	791
522	791
539	791
348	792
349	792
358	792
368	792
385	792
384	792
397	792
403	792
399	792
407	792
440	792
443	792
454	792
455	792
465	792
472	792
503	792
507	792
341	793
345	793
348	793
349	793
352	793
372	793
378	793
402	793
403	793
418	793
440	793
444	793
478	793
502	793
507	793
515	793
539	793
540	793
575	793
583	793
339	794
343	794
348	794
349	794
359	794
368	794
375	794
385	794
377	794
401	794
398	794
391	794
416	794
429	794
451	794
454	794
462	794
467	794
506	794
337	795
338	795
348	795
349	795
358	795
361	795
371	795
373	795
384	795
403	795
399	795
400	795
407	795
440	795
455	795
465	795
472	795
539	795
348	796
349	796
363	796
382	796
381	796
405	796
418	796
424	796
445	796
481	796
482	796
488	796
492	796
507	796
508	796
509	796
522	796
337	797
338	797
343	797
347	797
348	797
349	797
361	797
363	797
364	797
373	797
397	797
406	797
416	797
435	797
438	797
457	797
471	797
499	797
339	798
348	798
349	798
352	798
353	798
360	798
385	798
401	798
399	798
395	798
419	798
433	798
440	798
443	798
445	798
451	798
468	798
575	798
587	798
345	799
348	799
349	799
362	799
371	799
378	799
384	799
390	799
391	799
405	799
418	799
454	799
462	799
484	799
506	799
348	800
349	800
355	800
358	800
368	800
370	800
372	800
379	800
377	800
396	800
392	800
402	800
440	800
467	800
472	800
481	800
490	800
502	800
522	800
576	800
588	800
589	800
337	801
338	801
343	801
347	801
348	801
349	801
373	801
385	801
397	801
403	801
391	801
399	801
416	801
444	801
441	801
451	801
457	801
518	801
590	801
339	802
344	802
346	802
348	802
349	802
361	802
371	802
375	802
374	802
401	802
398	802
394	802
395	802
400	802
418	802
454	802
482	802
508	802
584	802
343	803
348	803
349	803
353	803
370	803
373	803
378	803
374	803
377	803
402	803
416	803
448	803
449	803
455	803
457	803
467	803
502	803
522	803
591	803
348	804
349	804
352	804
358	804
364	804
385	804
384	804
391	804
400	804
418	804
407	804
433	804
440	804
444	804
441	804
472	804
497	804
518	804
590	804
339	805
345	805
348	805
349	805
355	805
359	805
361	805
373	805
379	805
397	805
401	805
403	805
405	805
457	805
462	805
484	805
539	805
344	806
348	806
349	806
368	806
392	806
390	806
399	806
445	806
451	806
474	806
490	806
507	806
515	806
575	806
584	806
592	806
341	807
343	807
347	807
348	807
349	807
352	807
353	807
360	807
363	807
370	807
398	807
429	807
443	807
454	807
461	807
481	807
505	807
522	807
576	807
593	807
346	808
348	808
349	808
358	808
373	808
388	808
384	808
377	808
403	808
394	808
440	808
444	808
465	808
472	808
497	808
508	808
540	808
544	808
337	809
338	809
339	809
344	809
348	809
349	809
375	809
374	809
401	809
391	809
405	809
400	809
424	809
430	809
441	809
462	809
485	809
518	809
591	809
594	809
343	810
348	810
349	810
353	810
359	810
381	810
397	810
406	810
390	810
416	810
433	810
445	810
451	810
457	810
461	810
478	810
522	810
576	810
348	811
349	811
361	811
366	811
367	811
373	811
396	811
392	811
399	811
419	811
443	811
448	811
467	811
468	811
481	811
492	811
503	811
575	811
341	812
345	812
348	812
349	812
355	812
363	812
368	812
402	812
418	812
438	812
455	812
465	812
471	812
499	812
507	812
515	812
539	812
584	812
591	812
347	813
348	813
349	813
364	813
370	813
385	813
384	813
403	813
391	813
405	813
407	813
497	813
505	813
518	813
576	813
592	813
339	814
343	814
346	814
348	814
349	814
352	814
353	814
358	814
361	814
362	814
372	814
373	814
401	814
395	814
400	814
444	814
449	814
472	814
337	815
338	815
344	815
348	815
349	815
384	815
379	815
377	815
397	815
398	815
433	815
435	815
440	815
454	815
457	815
462	815
482	815
484	815
490	815
508	815
522	815
343	816
347	816
348	816
349	816
366	816
367	816
368	816
385	816
406	816
392	816
390	816
400	816
416	816
438	816
457	816
471	816
482	816
595	816
339	817
345	817
348	817
349	817
359	817
372	817
382	817
381	817
377	817
398	817
433	817
429	817
490	817
503	817
576	817
584	817
337	818
338	818
344	818
348	818
352	818
358	818
364	818
370	818
379	818
401	818
391	818
445	818
444	818
472	818
505	818
515	818
531	818
341	819
348	819
349	819
363	819
374	819
402	819
394	819
418	819
440	819
454	819
465	819
481	819
497	819
502	819
507	819
509	819
522	819
348	820
349	820
361	820
371	820
375	820
388	820
384	820
397	820
399	820
405	820
444	820
441	820
449	820
484	820
506	820
508	820
539	820
591	820
343	821
344	821
345	821
347	821
348	821
349	821
352	821
353	821
385	821
384	821
397	821
406	821
392	821
416	821
429	821
474	821
481	821
503	821
505	821
522	821
576	821
341	822
348	822
349	822
359	822
361	822
368	822
378	822
402	822
403	822
405	822
400	822
418	822
433	822
454	822
457	822
467	822
484	822
497	822
539	822
575	822
339	823
343	823
345	823
346	823
348	823
349	823
353	823
385	823
406	823
401	823
398	823
391	823
419	823
416	823
429	823
505	823
348	824
349	824
355	824
358	824
361	824
378	824
384	824
392	824
400	824
418	824
448	824
457	824
468	824
472	824
503	824
515	824
539	824
579	824
596	824
597	824
347	825
348	825
349	825
366	825
367	825
370	825
372	825
374	825
405	825
424	825
433	825
444	825
441	825
484	825
492	825
508	825
522	825
575	825
590	825
337	826
338	826
341	826
343	826
345	826
348	826
349	826
352	826
362	826
377	826
402	826
391	826
399	826
449	826
457	826
462	826
484	826
497	826
499	826
515	826
540	826
344	827
348	827
349	827
359	827
360	827
361	827
368	827
378	827
385	827
397	827
398	827
403	827
429	827
443	827
465	827
505	827
507	827
539	827
591	827
339	828
343	828
346	828
348	828
349	828
358	828
363	828
364	828
382	828
381	828
406	828
401	828
391	828
416	828
433	828
438	828
445	828
457	828
544	828
579	828
338	829
344	829
345	829
348	829
349	829
353	829
384	829
390	829
398	829
399	829
395	829
407	829
429	829
440	829
449	829
465	829
484	829
497	829
507	829
518	829
339	830
348	830
349	830
361	830
374	830
392	830
401	830
403	830
405	830
418	830
444	830
441	830
511	830
515	830
550	830
575	830
597	830
598	830
341	831
343	831
348	831
349	831
352	831
353	831
360	831
363	831
370	831
385	831
394	831
448	831
471	831
472	831
492	831
503	831
508	831
522	831
539	831
583	831
348	832
349	832
355	832
359	832
364	832
384	832
397	832
406	832
398	832
433	832
440	832
445	832
449	832
457	832
465	832
461	832
474	832
481	832
509	832
518	832
581	832
590	832
337	833
338	833
344	833
347	833
348	833
349	833
368	833
372	833
384	833
379	833
377	833
396	833
391	833
405	833
400	833
424	833
443	833
462	833
478	833
515	833
339	834
343	834
346	834
348	834
349	834
375	834
385	834
419	834
416	834
407	834
444	834
455	834
467	834
497	834
505	834
506	834
522	834
575	834
341	835
348	835
349	835
358	835
361	835
366	835
367	835
374	835
392	835
402	835
433	835
438	835
458	835
482	835
484	835
492	835
499	835
507	835
539	835
583	835
591	835
597	835
348	836
349	836
352	836
355	836
359	836
368	836
372	836
384	836
379	836
457	836
471	836
472	836
474	836
515	836
530	836
544	836
569	836
348	837
349	837
362	837
363	837
364	837
366	837
367	837
378	837
388	837
377	837
406	837
390	837
398	837
391	837
399	837
400	837
418	837
490	837
344	838
345	838
347	838
348	838
349	838
353	838
370	838
381	838
395	838
424	838
429	838
440	838
441	838
465	838
468	838
481	838
502	838
575	838
581	838
591	838
337	839
338	839
343	839
348	839
349	839
358	839
371	839
402	839
433	839
438	839
445	839
457	839
462	839
467	839
481	839
484	839
503	839
505	839
507	839
522	839
539	839
590	839
339	840
348	840
349	840
361	840
363	840
385	840
397	840
401	840
403	840
394	840
405	840
419	840
443	840
444	840
448	840
449	840
497	840
348	841
349	841
362	841
363	841
364	841
366	841
367	841
378	841
388	841
377	841
406	841
390	841
398	841
391	841
399	841
400	841
418	841
490	841
341	842
344	842
348	842
349	842
363	842
368	842
372	842
382	842
381	842
396	842
406	842
424	842
440	842
438	842
471	842
502	842
505	842
507	842
511	842
597	842
343	843
348	843
349	843
352	843
375	843
388	843
386	843
384	843
387	843
397	843
406	843
395	843
418	843
449	843
457	843
462	843
467	843
515	843
575	843
347	844
348	844
349	844
353	844
359	844
362	844
363	844
370	844
372	844
385	844
398	844
391	844
399	844
424	844
465	844
481	844
508	844
539	844
337	845
338	845
339	845
345	845
348	845
349	845
358	845
361	845
374	845
401	845
405	845
433	845
440	845
445	845
441	845
468	845
472	845
484	845
506	845
540	845
591	845
341	846
344	846
348	846
349	846
355	846
371	846
378	846
384	846
392	846
394	846
391	846
399	846
416	846
407	846
490	846
497	846
505	846
507	846
544	846
548	846
575	846
599	846
343	847
348	847
349	847
352	847
364	847
372	847
377	847
397	847
398	847
402	847
433	847
429	847
443	847
444	847
449	847
457	847
499	847
339	848
348	848
349	848
358	848
382	848
385	848
381	848
406	848
401	848
405	848
400	848
438	848
441	848
455	848
482	848
484	848
508	848
522	848
539	848
344	849
345	849
348	849
349	849
361	849
379	849
401	849
390	849
412	849
418	849
416	849
433	849
448	849
462	849
497	849
498	849
502	849
507	849
509	849
590	849
337	850
338	850
348	850
349	850
358	850
368	850
375	850
384	850
398	850
403	850
391	850
440	850
444	850
465	850
467	850
468	850
471	850
474	850
481	850
484	850
506	850
591	850
339	851
343	851
346	851
347	851
348	851
349	851
352	851
370	851
371	851
385	851
399	851
438	851
443	851
445	851
470	851
472	851
505	851
575	851
597	851
341	852
348	852
349	852
353	852
363	852
364	852
374	852
381	852
377	852
395	852
405	852
419	852
418	852
457	852
522	852
539	852
337	853
338	853
344	853
348	853
349	853
362	853
368	853
396	853
397	853
390	853
398	853
402	853
391	853
416	853
433	853
440	853
467	853
600	853
337	854
338	854
339	854
341	854
343	854
344	854
345	854
346	854
348	854
349	854
352	854
397	854
401	854
398	854
457	854
462	854
474	854
502	854
509	854
515	854
575	854
591	854
347	855
348	855
349	855
353	855
364	855
371	855
372	855
382	855
379	855
377	855
405	855
412	855
418	855
440	855
438	855
447	855
471	855
481	855
505	855
507	855
343	856
345	856
347	856
348	856
349	856
362	856
366	856
367	856
378	856
374	856
406	856
391	856
400	856
416	856
424	856
462	856
478	856
481	856
550	856
348	857
349	857
382	857
385	857
384	857
381	857
407	857
445	857
447	857
465	857
470	857
484	857
497	857
505	857
511	857
544	857
575	857
583	857
591	857
341	858
348	858
349	858
355	858
370	858
372	858
392	858
402	858
399	858
405	858
412	858
418	858
433	858
440	858
457	858
462	858
471	858
472	858
522	858
539	858
595	858
339	859
343	859
347	859
348	859
349	859
352	859
363	859
364	859
379	859
403	859
419	859
424	859
461	859
468	859
482	859
507	859
591	859
601	859
602	859
344	860
348	860
349	860
361	860
375	860
378	860
397	860
401	860
390	860
398	860
416	860
433	860
443	860
445	860
481	860
484	860
490	860
492	860
497	860
499	860
503	860
518	860
337	861
338	861
348	861
349	861
353	861
358	861
368	861
374	861
384	861
377	861
395	861
405	861
438	861
448	861
462	861
506	861
508	861
515	861
522	861
539	861
600	861
341	862
348	862
349	862
359	862
372	862
385	862
396	862
402	862
394	862
391	862
400	862
412	862
418	862
440	862
444	862
465	862
467	862
502	862
507	862
509	862
575	862
343	863
345	863
346	863
348	863
349	863
352	863
366	863
367	863
370	863
371	863
406	863
392	863
398	863
403	863
399	863
429	863
449	863
447	863
455	863
544	863
595	863
339	864
344	864
348	864
349	864
364	864
397	864
401	864
405	864
440	864
445	864
457	864
471	864
472	864
481	864
482	864
484	864
497	864
591	864
601	864
602	864
341	865
348	865
349	865
359	865
375	865
382	865
381	865
406	865
403	865
399	865
400	865
412	865
418	865
416	865
424	865
445	865
447	865
457	865
462	865
503	865
575	865
337	866
338	866
343	866
345	866
347	866
348	866
349	866
352	866
353	866
358	866
362	866
366	866
367	866
372	866
377	866
391	866
438	866
505	866
515	866
539	866
597	866
344	867
348	867
349	867
363	867
368	867
385	867
384	867
398	867
405	867
419	867
441	867
484	867
502	867
506	867
507	867
522	867
583	867
591	867
595	867
337	868
338	868
343	868
348	868
349	868
352	868
364	868
372	868
378	868
384	868
398	868
391	868
399	868
400	868
506	868
539	868
576	868
597	868
344	869
348	869
349	869
361	869
371	869
375	869
381	869
379	869
377	869
397	869
392	869
401	869
418	869
440	869
445	869
461	869
468	869
481	869
482	869
575	869
583	869
591	869
337	870
338	870
348	870
349	870
353	870
392	870
398	870
402	870
403	870
405	870
400	870
418	870
433	870
429	870
457	870
458	870
462	870
481	870
544	870
576	870
601	870
602	870
343	871
344	871
345	871
347	871
348	871
349	871
361	871
363	871
368	871
371	871
375	871
378	871
374	871
384	871
377	871
441	871
497	871
593	871
339	872
346	872
348	872
349	872
353	872
358	872
360	872
370	872
406	872
401	872
398	872
416	872
440	872
437	872
445	872
503	872
515	872
518	872
550	872
576	872
579	872
601	872
602	872
341	873
344	873
348	873
349	873
355	873
363	873
364	873
399	873
405	873
419	873
481	873
502	873
522	873
539	873
583	873
591	873
593	873
597	873
337	874
338	874
343	874
348	874
349	874
352	874
371	874
384	874
390	874
391	874
418	874
407	874
433	874
438	874
457	874
462	874
471	874
505	874
509	874
341	875
348	875
349	875
362	875
363	875
366	875
367	875
372	875
378	875
374	875
377	875
396	875
397	875
402	875
403	875
416	875
440	875
443	875
445	875
448	875
575	875
597	875
343	876
344	876
347	876
348	876
349	876
358	876
385	876
398	876
395	876
405	876
400	876
429	876
468	876
472	876
474	876
481	876
499	876
591	876
601	876
602	876
337	877
338	877
339	877
348	877
349	877
352	877
361	877
364	877
368	877
370	877
375	877
401	877
418	877
440	877
457	877
461	877
467	877
497	877
515	877
341	878
348	878
349	878
372	878
384	878
379	878
377	878
402	878
403	878
394	878
433	878
444	878
449	878
455	878
505	878
506	878
508	878
522	878
600	878
343	879
347	879
348	879
349	879
359	879
362	879
406	879
391	879
400	879
433	879
445	879
481	879
482	879
490	879
518	879
575	879
598	879
601	879
602	879
337	880
338	880
344	880
345	880
348	880
349	880
382	880
381	880
397	880
405	880
418	880
443	880
441	880
457	880
492	880
502	880
539	880
591	880
348	881
349	881
353	881
355	881
368	881
370	881
384	881
392	881
398	881
399	881
416	881
407	881
438	881
461	881
471	881
515	881
576	881
339	882
348	882
349	882
361	882
364	882
388	882
386	882
374	882
385	882
387	882
401	882
403	882
429	882
445	882
449	882
465	882
478	882
506	882
591	882
341	883
343	883
346	883
348	883
349	883
352	883
358	883
360	883
363	883
372	883
375	883
402	883
391	883
424	883
468	883
472	883
481	883
499	883
544	883
344	884
345	884
347	884
348	884
349	884
381	884
397	884
392	884
390	884
398	884
405	884
433	884
462	884
474	884
482	884
485	884
497	884
502	884
522	884
575	884
337	885
338	885
348	885
349	885
359	885
384	885
377	885
396	885
400	885
418	885
440	885
443	885
457	885
467	885
490	885
505	885
509	885
515	885
591	885
601	885
602	885
339	886
346	886
348	886
349	886
362	886
363	886
388	886
374	886
379	886
397	886
406	886
391	886
465	886
471	886
472	886
481	886
499	886
343	887
348	887
349	887
352	887
353	887
358	887
361	887
368	887
372	887
384	887
402	887
416	887
433	887
438	887
444	887
457	887
505	887
341	888
344	888
347	888
348	888
349	888
364	888
370	888
390	888
398	888
440	888
445	888
441	888
462	888
490	888
502	888
522	888
591	888
337	889
348	889
349	889
360	889
371	889
375	889
385	889
377	889
401	889
403	889
395	889
405	889
418	889
429	889
449	889
497	889
348	890
349	890
359	890
368	890
372	890
382	890
384	890
381	890
377	890
397	890
416	890
433	890
438	890
457	890
471	890
482	890
600	890
343	891
344	891
347	891
348	891
349	891
353	891
364	891
374	891
392	891
398	891
391	891
481	891
490	891
505	891
515	891
575	891
337	892
338	892
341	892
345	892
348	892
349	892
358	892
401	892
402	892
405	892
445	892
444	892
448	892
468	892
472	892
499	892
506	892
522	892
591	892
598	892
343	893
348	893
349	893
355	893
364	893
382	893
374	893
381	893
377	893
398	893
391	893
405	893
416	893
407	893
433	893
440	893
441	893
481	893
485	893
497	893
539	893
341	894
344	894
345	894
346	894
347	894
348	894
349	894
352	894
362	894
370	894
371	894
385	894
384	894
406	894
462	894
575	894
337	895
338	895
348	895
349	895
353	895
358	895
368	895
402	895
405	895
400	895
418	895
448	895
457	895
467	895
472	895
499	895
505	895
515	895
576	895
600	895
601	895
602	895
343	896
348	896
349	896
360	896
362	896
363	896
379	896
396	896
406	896
390	896
416	896
407	896
424	896
458	896
478	896
544	896
593	896
601	896
348	897
349	897
366	897
367	897
375	897
388	897
386	897
374	897
384	897
387	897
394	897
400	897
420	897
443	897
444	897
441	897
465	897
499	897
502	897
539	897
341	898
348	898
349	898
353	898
355	898
371	898
402	898
403	898
391	898
419	898
433	898
440	898
438	898
462	898
468	898
471	898
474	898
511	898
518	898
602	898
603	898
339	899
345	899
348	899
349	899
359	899
361	899
370	899
372	899
382	899
385	899
381	899
392	899
401	899
405	899
418	899
448	899
541	899
583	899
343	900
346	900
347	900
348	900
349	900
352	900
363	900
364	900
384	900
377	900
457	900
482	900
497	900
506	900
522	900
575	900
337	901
338	901
344	901
348	901
349	901
358	901
371	901
397	901
398	901
402	901
429	901
430	901
445	901
449	901
455	901
472	901
481	901
505	901
508	901
515	901
590	901
591	901
341	902
348	902
349	902
355	902
364	902
368	902
375	902
374	902
377	902
397	902
402	902
418	902
416	902
467	902
468	902
502	902
522	902
550	902
575	902
343	903
345	903
346	903
348	903
349	903
352	903
353	903
361	903
384	903
390	903
398	903
407	903
455	903
462	903
497	903
506	903
583	903
344	904
347	904
348	904
349	904
368	904
370	904
388	904
386	904
387	904
406	904
392	904
391	904
395	904
418	904
424	904
445	904
444	904
457	904
481	904
498	904
515	904
575	904
348	905
349	905
359	905
364	905
382	905
374	905
384	905
381	905
377	905
398	905
405	905
400	905
429	905
443	905
497	905
522	905
591	905
337	906
338	906
339	906
341	906
343	906
348	906
349	906
352	906
361	906
396	906
401	906
403	906
394	906
391	906
395	906
416	906
448	906
467	906
492	906
505	906
506	906
515	906
575	906
348	907
349	907
360	907
366	907
367	907
384	907
379	907
390	907
419	907
407	907
449	907
465	907
470	907
478	907
482	907
590	907
604	907
348	908
349	908
353	908
355	908
384	908
397	908
398	908
405	908
438	908
441	908
457	908
467	908
468	908
471	908
474	908
481	908
515	908
544	908
591	908
343	909
346	909
348	909
349	909
358	909
362	909
370	909
388	909
386	909
374	909
385	909
387	909
377	909
402	909
440	909
462	909
472	909
490	909
502	909
550	909
575	909
583	909
341	910
344	910
347	910
348	910
349	910
352	910
363	910
364	910
372	910
403	910
400	910
444	910
455	910
496	910
508	910
518	910
522	910
603	910
343	911
345	911
348	911
349	911
359	911
371	911
382	911
384	911
381	911
398	911
391	911
433	911
445	911
448	911
457	911
506	911
509	911
591	911
337	912
338	912
339	912
348	912
349	912
361	912
368	912
375	912
397	912
392	912
401	912
390	912
405	912
418	912
424	912
490	912
497	912
505	912
515	912
575	912
341	913
343	913
345	913
347	913
348	913
349	913
352	913
375	913
406	913
398	913
394	913
419	913
468	913
474	913
481	913
496	913
503	913
575	913
583	913
591	913
337	914
338	914
344	914
346	914
348	914
349	914
353	914
355	914
358	914
361	914
370	914
371	914
401	914
418	914
440	914
457	914
472	914
482	914
515	914
541	914
337	915
338	915
343	915
348	915
349	915
352	915
360	915
364	915
384	915
406	915
398	915
391	915
407	915
468	915
490	915
506	915
575	915
583	915
590	915
593	915
339	916
344	916
348	916
349	916
359	916
361	916
368	916
371	916
388	916
386	916
374	916
387	916
401	916
400	916
433	916
445	916
457	916
462	916
508	916
591	916
345	917
348	917
349	917
353	917
370	917
375	917
382	917
381	917
377	917
398	917
403	917
394	917
405	917
413	917
448	917
467	917
481	917
505	917
515	917
522	917
341	918
343	918
347	918
348	918
349	918
352	918
384	918
406	918
392	918
398	918
391	918
416	918
448	918
457	918
482	918
505	918
506	918
515	918
575	918
337	919
338	919
348	919
349	919
353	919
358	919
361	919
364	919
374	919
385	919
397	919
405	919
418	919
440	919
444	919
455	919
462	919
472	919
474	919
481	919
544	919
593	919
339	920
344	920
348	920
349	920
360	920
362	920
372	920
388	920
386	920
387	920
390	920
398	920
402	920
395	920
400	920
433	920
440	920
465	920
508	920
522	920
541	920
343	921
345	921
348	921
349	921
352	921
353	921
363	921
368	921
382	921
381	921
377	921
396	921
394	921
424	921
455	921
457	921
469	921
575	921
590	921
591	921
337	922
338	922
341	922
348	922
349	922
359	922
361	922
375	922
392	922
398	922
402	922
403	922
405	922
438	922
444	922
471	922
497	922
506	922
515	922
344	923
347	923
348	923
349	923
355	923
363	923
366	923
367	923
370	923
371	923
374	923
384	923
391	923
445	923
448	923
468	923
499	923
505	923
541	923
575	923
591	923
348	924
349	924
353	924
364	924
368	924
372	924
375	924
381	924
379	924
377	924
397	924
398	924
418	924
433	924
440	924
467	924
481	924
490	924
509	924
522	924
544	924
339	925
343	925
348	925
349	925
352	925
360	925
361	925
362	925
388	925
386	925
374	925
385	925
387	925
406	925
401	925
394	925
419	925
575	925
593	925
337	926
338	926
344	926
345	926
346	926
348	926
349	926
359	926
370	926
390	926
402	926
420	926
430	926
440	926
457	926
465	926
481	926
515	926
590	926
591	926
341	927
348	927
349	927
358	927
363	927
375	927
384	927
398	927
403	927
391	927
405	927
400	927
418	927
448	927
455	927
468	927
472	927
497	927
506	927
511	927
583	927
339	928
344	928
348	928
349	928
353	928
361	928
371	928
379	928
396	928
397	928
392	928
401	928
424	928
433	928
440	928
445	928
441	928
462	928
575	928
591	928
341	929
343	929
347	929
348	929
349	929
352	929
364	929
382	929
381	929
377	929
398	929
437	929
444	929
457	929
505	929
508	929
509	929
515	929
522	929
540	929
605	929
343	930
345	930
348	930
349	930
352	930
355	930
372	930
374	930
384	930
397	930
392	930
391	930
444	930
478	930
544	930
591	930
337	931
338	931
348	931
349	931
370	931
385	931
377	931
398	931
403	931
405	931
433	931
455	931
468	931
474	931
481	931
482	931
497	931
522	931
575	931
339	932
346	932
348	932
349	932
353	932
358	932
361	932
362	932
372	932
381	932
396	932
401	932
400	932
418	932
440	932
457	932
462	932
467	932
472	932
490	932
515	932
337	933
338	933
341	933
343	933
344	933
348	933
349	933
352	933
364	933
406	933
390	933
402	933
391	933
448	933
508	933
509	933
515	933
575	933
590	933
345	934
348	934
349	934
363	934
371	934
375	934
384	934
397	934
398	934
403	934
394	934
405	934
444	934
505	934
506	934
522	934
591	934
347	935
348	935
349	935
353	935
358	935
359	935
374	935
381	935
406	935
403	935
391	935
405	935
400	935
419	935
418	935
455	935
457	935
472	935
481	935
482	935
515	935
337	936
338	936
339	936
343	936
348	936
349	936
352	936
363	936
364	936
377	936
401	936
394	936
438	936
444	936
471	936
497	936
522	936
575	936
341	937
344	937
345	937
348	937
349	937
353	937
361	937
368	937
384	937
397	937
398	937
407	937
440	937
448	937
474	937
499	937
505	937
506	937
508	937
591	937
343	938
346	938
348	938
349	938
352	938
363	938
375	938
406	938
402	938
403	938
391	938
395	938
418	938
444	938
457	938
467	938
506	938
575	938
337	939
338	939
341	939
344	939
345	939
347	939
348	939
349	939
362	939
364	939
368	939
370	939
385	939
390	939
398	939
405	939
468	939
522	939
590	939
591	939
346	940
348	940
349	940
353	940
358	940
384	940
379	940
377	940
396	940
391	940
395	940
400	940
424	940
440	940
438	940
448	940
462	940
481	940
490	940
492	940
506	940
575	940
339	941
343	941
348	941
349	941
352	941
355	941
363	941
382	941
381	941
392	941
401	941
398	941
394	941
419	941
497	941
518	941
522	941
540	941
603	941
337	942
338	942
348	942
349	942
361	942
364	942
370	942
372	942
375	942
402	942
405	942
418	942
433	942
449	942
455	942
467	942
468	942
481	942
575	942
344	943
345	943
348	943
366	943
367	943
374	943
397	943
398	943
407	943
429	943
440	943
444	943
465	943
485	943
505	943
515	943
591	943
606	943
343	944
348	944
349	944
352	944
358	944
359	944
362	944
363	944
368	944
388	944
386	944
384	944
387	944
396	944
406	944
391	944
400	944
424	944
457	944
472	944
506	944
590	944
341	945
348	945
349	945
360	945
361	945
382	945
385	945
381	945
392	945
390	945
403	945
419	945
440	945
478	945
482	945
490	945
508	945
575	945
591	945
337	946
338	946
339	946
347	946
348	946
349	946
364	946
375	946
379	946
377	946
398	946
394	946
405	946
400	946
433	946
462	946
467	946
497	946
522	946
343	947
348	947
349	947
352	947
353	947
363	947
388	947
386	947
374	947
387	947
397	947
401	947
391	947
395	947
448	947
457	947
468	947
481	947
575	947
345	948
348	948
349	948
355	948
358	948
361	948
368	948
370	948
398	948
402	948
418	948
440	948
441	948
472	948
474	948
490	948
505	948
515	948
541	948
591	948
343	949
347	949
348	949
349	949
353	949
359	949
371	949
385	949
384	949
392	949
390	949
419	949
497	949
509	949
522	949
575	949
590	949
339	950
344	950
348	950
349	950
364	950
368	950
372	950
382	950
381	950
377	950
398	950
391	950
433	950
440	950
445	950
448	950
449	950
465	950
508	950
591	950
343	951
346	951
348	951
352	951
353	951
358	951
368	951
371	951
384	951
390	951
400	951
418	951
407	951
444	951
462	951
472	951
485	951
522	951
575	951
337	952
338	952
344	952
348	952
349	952
366	952
367	952
372	952
375	952
379	952
397	952
392	952
401	952
398	952
405	952
449	952
467	952
468	952
509	952
515	952
341	953
345	953
347	953
348	953
349	953
353	953
358	953
359	953
362	953
388	953
386	953
374	953
387	953
403	953
419	953
433	953
445	953
462	953
465	953
472	953
575	953
343	954
346	954
348	954
349	954
352	954
363	954
382	954
381	954
396	954
390	954
398	954
402	954
391	954
448	954
457	954
481	954
497	954
505	954
607	954
339	955
348	955
355	955
361	955
364	955
375	955
401	955
405	955
400	955
418	955
424	955
478	955
485	955
515	955
575	955
579	955
591	955
337	956
338	956
344	956
348	956
349	956
353	956
368	956
385	956
384	956
377	956
398	956
394	956
440	956
443	956
444	956
455	956
490	956
499	956
508	956
522	956
590	956
608	956
339	957
343	957
348	957
352	957
353	957
359	957
374	957
406	957
401	957
398	957
391	957
405	957
433	957
437	957
444	957
441	957
455	957
503	957
575	957
609	957
344	958
347	958
348	958
355	958
358	958
361	958
362	958
363	958
375	958
392	958
400	958
438	958
457	958
465	958
467	958
468	958
481	958
551	958
591	958
337	959
338	959
348	959
364	959
370	959
384	959
377	959
390	959
394	959
391	959
418	959
440	959
448	959
471	959
472	959
490	959
497	959
341	960
343	960
345	960
346	960
348	960
368	960
372	960
382	960
381	960
397	960
398	960
402	960
405	960
482	960
508	960
509	960
515	960
522	960
339	961
343	961
348	961
352	961
361	961
363	961
366	961
367	961
388	961
386	961
387	961
392	961
401	961
414	961
430	961
441	961
550	961
575	961
341	962
344	962
345	962
348	962
359	962
362	962
368	962
375	962
384	962
396	962
397	962
398	962
391	962
405	962
467	962
474	962
499	962
515	962
591	962
337	963
338	963
343	963
347	963
348	963
352	963
355	963
364	963
371	963
377	963
398	963
391	963
430	963
455	963
481	963
550	963
591	963
344	964
345	964
348	964
349	964
353	964
360	964
382	964
384	964
381	964
379	964
403	964
394	964
400	964
407	964
424	964
462	964
468	964
490	964
522	964
575	964
341	965
348	965
359	965
363	965
368	965
370	965
375	965
388	965
386	965
387	965
401	965
398	965
391	965
395	965
418	965
440	965
457	965
465	965
467	965
485	965
591	965
337	966
338	966
339	966
346	966
348	966
352	966
358	966
372	966
374	966
397	966
402	966
405	966
440	966
472	966
505	966
509	966
515	966
518	966
522	966
603	966
341	967
347	967
348	967
353	967
361	967
362	967
363	967
364	967
377	967
398	967
403	967
429	967
445	967
465	967
481	967
521	967
550	967
575	967
337	968
338	968
343	968
348	968
371	968
385	968
384	968
406	968
392	968
390	968
391	968
414	968
430	968
448	968
462	968
506	968
591	968
339	969
346	969
348	969
359	969
370	969
372	969
382	969
381	969
396	969
401	969
398	969
405	969
418	969
438	969
467	969
471	969
485	969
509	969
522	969
591	969
344	970
345	970
348	970
352	970
360	970
388	970
386	970
387	970
397	970
402	970
391	970
457	970
468	970
478	970
481	970
482	970
515	970
550	970
575	970
337	971
338	971
343	971
348	971
353	971
358	971
364	971
375	971
374	971
398	971
403	971
394	971
414	971
430	971
472	971
490	971
506	971
591	971
339	972
341	972
348	972
352	972
353	972
355	972
361	972
385	972
401	972
405	972
441	972
455	972
462	972
481	972
497	972
575	972
344	973
345	973
348	973
362	973
363	973
368	973
372	973
378	973
384	973
392	973
390	973
398	973
391	973
400	973
465	973
499	973
591	973
337	974
338	974
343	974
344	974
348	974
349	974
352	974
358	974
364	974
371	974
396	974
406	974
398	974
407	974
424	974
457	974
472	974
474	974
481	974
509	974
569	974
591	974
610	974
341	975
347	975
348	975
353	975
362	975
374	975
385	975
398	975
391	975
405	975
400	975
418	975
440	975
468	975
497	975
509	975
343	976
344	976
345	976
348	976
349	976
352	976
361	976
375	976
382	976
381	976
379	976
377	976
406	976
392	976
394	976
433	976
515	976
575	976
344	977
346	977
348	977
358	977
368	977
372	977
388	977
386	977
385	977
387	977
396	977
398	977
402	977
405	977
419	977
430	977
440	977
448	977
467	977
472	977
515	977
522	977
337	978
338	978
348	978
349	978
359	978
360	978
371	978
384	978
379	978
391	978
418	978
445	978
462	978
481	978
482	978
506	978
508	978
509	978
575	978
339	979
343	979
347	979
348	979
355	979
363	979
382	979
381	979
397	979
392	979
398	979
440	979
438	979
457	979
465	979
468	979
471	979
497	979
337	980
338	980
341	980
344	980
345	980
348	980
361	980
368	980
370	980
372	980
375	980
374	980
402	980
403	980
394	980
405	980
455	980
575	980
343	981
348	981
349	981
352	981
364	981
388	981
386	981
384	981
387	981
396	981
406	981
398	981
391	981
407	981
441	981
467	981
505	981
515	981
518	981
603	981
337	982
338	982
346	982
348	982
359	982
361	982
362	982
371	982
372	982
375	982
382	982
381	982
377	982
398	982
400	982
418	982
424	982
440	982
481	982
485	982
575	982
339	983
343	983
348	983
363	983
388	983
386	983
374	983
387	983
397	983
392	983
401	983
391	983
405	983
430	983
438	983
445	983
457	983
462	983
471	983
497	983
509	983
344	984
345	984
346	984
348	984
358	984
368	984
370	984
372	984
384	984
396	984
398	984
433	984
440	984
465	984
467	984
472	984
482	984
505	984
506	984
511	984
341	985
343	985
347	985
348	985
352	985
353	985
359	985
361	985
363	985
406	985
390	985
405	985
400	985
448	985
455	985
518	985
575	985
603	985
337	986
338	986
339	986
348	986
355	986
362	986
364	986
372	986
377	986
401	986
398	986
391	986
418	986
445	986
449	986
490	986
515	986
343	987
348	987
353	987
361	987
363	987
371	987
374	987
384	987
397	987
392	987
407	987
457	987
468	987
497	987
575	987
610	987
344	988
348	988
358	988
368	988
370	988
372	988
375	988
382	988
385	988
381	988
402	988
394	988
391	988
405	988
424	988
430	988
438	988
441	988
481	988
337	989
338	989
341	989
343	989
345	989
346	989
348	989
352	989
358	989
361	989
385	989
384	989
377	989
438	989
448	989
462	989
490	989
497	989
339	990
348	990
355	990
359	990
363	990
364	990
371	990
396	990
397	990
401	990
391	990
418	990
457	990
465	990
467	990
474	990
481	990
509	990
575	990
343	991
348	991
352	991
353	991
358	991
359	991
361	991
362	991
363	991
368	991
371	991
382	991
374	991
381	991
398	991
400	991
418	991
457	991
472	991
337	992
338	992
344	992
345	992
348	992
372	992
384	992
379	992
397	992
392	992
394	992
405	992
429	992
449	992
462	992
506	992
575	992
343	993
348	993
352	993
359	993
361	993
363	993
370	993
388	993
386	993
387	993
392	993
390	993
402	993
405	993
444	993
448	993
449	993
457	993
481	993
339	994
344	994
348	994
358	994
364	994
372	994
375	994
382	994
381	994
377	994
398	994
391	994
418	994
424	994
429	994
465	994
472	994
482	994
505	994
341	995
343	995
345	995
348	995
353	995
368	995
371	995
374	995
397	995
407	995
445	995
462	995
474	995
481	995
497	995
509	995
515	995
518	995
575	995
603	995
344	996
346	996
348	996
355	996
361	996
363	996
366	996
367	996
388	996
386	996
387	996
392	996
398	996
419	996
433	996
440	996
455	996
471	996
472	996
490	996
541	996
337	997
338	997
348	997
349	997
352	997
362	997
363	997
370	997
384	997
406	997
390	997
398	997
403	997
445	997
468	997
485	997
522	997
575	997
339	998
343	998
345	998
347	998
348	998
353	998
358	998
360	998
372	998
396	998
397	998
401	998
394	998
440	998
448	998
449	998
457	998
462	998
465	998
467	998
481	998
515	998
337	999
338	999
341	999
344	999
348	999
349	999
359	999
361	999
368	999
379	999
398	999
402	999
391	999
405	999
400	999
418	999
441	999
497	999
509	999
575	999
343	1000
346	1000
348	1000
352	1000
353	1000
363	1000
364	1000
371	1000
375	1000
382	1000
374	1000
384	1000
381	1000
377	1000
398	1000
419	1000
433	1000
438	1000
472	1000
341	1001
343	1001
344	1001
345	1001
346	1001
348	1001
352	1001
353	1001
363	1001
370	1001
388	1001
386	1001
387	1001
392	1001
398	1001
402	1001
391	1001
457	1001
468	1001
497	1001
348	1002
355	1002
358	1002
359	1002
362	1002
371	1002
375	1002
384	1002
377	1002
390	1002
405	1002
419	1002
472	1002
506	1002
575	1002
337	1003
338	1003
339	1003
343	1003
348	1003
361	1003
364	1003
368	1003
385	1003
401	1003
398	1003
394	1003
400	1003
418	1003
440	1003
465	1003
467	1003
482	1003
485	1003
343	1004
344	1004
348	1004
349	1004
352	1004
355	1004
358	1004
368	1004
372	1004
388	1004
386	1004
385	1004
387	1004
391	1004
419	1004
472	1004
478	1004
481	1004
498	1004
509	1004
575	1004
587	1004
337	1005
338	1005
345	1005
347	1005
348	1005
353	1005
361	1005
362	1005
374	1005
384	1005
377	1005
392	1005
394	1005
405	1005
445	1005
511	1005
575	1005
343	1006
348	1006
352	1006
359	1006
366	1006
367	1006
371	1006
382	1006
381	1006
379	1006
396	1006
406	1006
391	1006
400	1006
418	1006
441	1006
455	1006
467	1006
518	1006
541	1006
603	1006
341	1007
344	1007
348	1007
363	1007
364	1007
370	1007
388	1007
386	1007
387	1007
390	1007
395	1007
440	1007
465	1007
471	1007
472	1007
474	1007
481	1007
482	1007
497	1007
499	1007
522	1007
569	1007
575	1007
337	1008
338	1008
339	1008
343	1008
348	1008
353	1008
358	1008
360	1008
375	1008
401	1008
394	1008
391	1008
405	1008
419	1008
424	1008
433	1008
457	1008
468	1008
575	1008
587	1008
341	1009
344	1009
348	1009
362	1009
368	1009
372	1009
374	1009
402	1009
400	1009
429	1009
440	1009
438	1009
448	1009
449	1009
465	1009
485	1009
505	1009
515	1009
518	1009
603	1009
604	1009
343	1010
345	1010
348	1010
352	1010
353	1010
361	1010
388	1010
386	1010
385	1010
384	1010
387	1010
377	1010
406	1010
441	1010
462	1010
478	1010
481	1010
505	1010
508	1010
515	1010
575	1010
611	1010
337	1011
338	1011
344	1011
348	1011
353	1011
358	1011
359	1011
364	1011
368	1011
371	1011
397	1011
391	1011
418	1011
407	1011
444	1011
457	1011
472	1011
490	1011
575	1011
587	1011
612	1011
341	1012
343	1012
348	1012
352	1012
355	1012
361	1012
363	1012
392	1012
390	1012
402	1012
440	1012
445	1012
448	1012
474	1012
490	1012
497	1012
518	1012
575	1012
587	1012
603	1012
339	1013
343	1013
348	1013
353	1013
360	1013
368	1013
382	1013
374	1013
381	1013
401	1013
419	1013
465	1013
468	1013
471	1013
508	1013
509	1013
515	1013
541	1013
575	1013
587	1013
345	1014
347	1014
348	1014
352	1014
364	1014
366	1014
367	1014
388	1014
386	1014
385	1014
387	1014
396	1014
394	1014
391	1014
400	1014
418	1014
441	1014
449	1014
467	1014
497	1014
505	1014
341	1015
346	1015
348	1015
349	1015
353	1015
358	1015
359	1015
361	1015
362	1015
372	1015
384	1015
377	1015
405	1015
407	1015
472	1015
481	1015
506	1015
515	1015
575	1015
337	1016
338	1016
343	1016
344	1016
348	1016
368	1016
371	1016
375	1016
388	1016
386	1016
387	1016
397	1016
392	1016
391	1016
424	1016
445	1016
455	1016
457	1016
502	1016
511	1016
575	1016
343	1017
347	1017
348	1017
358	1017
361	1017
362	1017
366	1017
367	1017
368	1017
406	1017
390	1017
400	1017
418	1017
433	1017
440	1017
438	1017
465	1017
505	1017
541	1017
575	1017
337	1018
338	1018
345	1018
348	1018
353	1018
372	1018
375	1018
384	1018
391	1018
405	1018
424	1018
441	1018
448	1018
471	1018
472	1018
478	1018
481	1018
506	1018
515	1018
575	1018
339	1019
343	1019
348	1019
352	1019
361	1019
364	1019
388	1019
386	1019
374	1019
387	1019
377	1019
445	1019
449	1019
455	1019
462	1019
467	1019
468	1019
490	1019
497	1019
575	1019
337	1020
338	1020
341	1020
343	1020
344	1020
345	1020
348	1020
352	1020
355	1020
363	1020
372	1020
402	1020
394	1020
391	1020
400	1020
465	1020
509	1020
575	1020
339	1021
346	1021
348	1021
353	1021
361	1021
362	1021
363	1021
370	1021
371	1021
382	1021
374	1021
381	1021
392	1021
401	1021
418	1021
424	1021
440	1021
471	1021
472	1021
575	1021
343	1022
348	1022
352	1022
358	1022
359	1022
388	1022
386	1022
385	1022
384	1022
387	1022
397	1022
391	1022
405	1022
433	1022
438	1022
448	1022
462	1022
482	1022
575	1022
345	1023
348	1023
349	1023
352	1023
360	1023
363	1023
384	1023
406	1023
405	1023
416	1023
429	1023
445	1023
457	1023
468	1023
474	1023
481	1023
482	1023
503	1023
513	1023
522	1023
541	1023
591	1023
598	1023
614	1023
613	1023
343	1024
344	1024
348	1024
353	1024
361	1024
366	1024
367	1024
370	1024
388	1024
379	1024
396	1024
390	1024
402	1024
394	1024
424	1024
433	1024
445	1024
462	1024
490	1024
505	1024
614	1024
613	1024
341	1025
343	1025
347	1025
348	1025
352	1025
353	1025
355	1025
359	1025
362	1025
363	1025
374	1025
419	1025
443	1025
448	1025
481	1025
497	1025
511	1025
518	1025
540	1025
603	1025
604	1025
348	1026
358	1026
364	1026
372	1026
375	1026
382	1026
385	1026
384	1026
381	1026
377	1026
397	1026
392	1026
405	1026
418	1026
438	1026
467	1026
508	1026
509	1026
337	1027
338	1027
339	1027
343	1027
345	1027
346	1027
348	1027
353	1027
401	1027
391	1027
400	1027
440	1027
441	1027
449	1027
455	1027
465	1027
471	1027
472	1027
541	1027
591	1027
341	1028
343	1028
346	1028
348	1028
352	1028
382	1028
385	1028
381	1028
397	1028
394	1028
391	1028
429	1028
465	1028
481	1028
339	1029
341	1029
343	1029
346	1029
348	1029
355	1029
358	1029
363	1029
388	1029
385	1029
377	1029
402	1029
391	1029
399	1029
400	1029
418	1029
433	1029
445	1029
455	1029
465	1029
468	1029
472	1029
481	1029
540	1029
337	1030
338	1030
343	1030
345	1030
348	1030
352	1030
353	1030
359	1030
361	1030
366	1030
367	1030
378	1030
384	1030
377	1030
397	1030
394	1030
391	1030
405	1030
429	1030
457	1030
497	1030
511	1030
541	1030
339	1031
343	1031
344	1031
348	1031
353	1031
358	1031
363	1031
368	1031
371	1031
372	1031
379	1031
396	1031
401	1031
419	1031
418	1031
438	1031
467	1031
505	1031
508	1031
509	1031
604	1031
337	1032
338	1032
343	1032
344	1032
348	1032
362	1032
364	1032
378	1032
374	1032
384	1032
397	1032
406	1032
391	1032
405	1032
440	1032
445	1032
444	1032
457	1032
468	1032
522	1032
541	1032
343	1033
346	1033
348	1033
353	1033
359	1033
361	1033
366	1033
367	1033
385	1033
377	1033
396	1033
400	1033
418	1033
440	1033
441	1033
467	1033
471	1033
472	1033
474	1033
490	1033
497	1033
337	1034
338	1034
339	1034
341	1034
343	1034
348	1034
352	1034
353	1034
358	1034
368	1034
372	1034
378	1034
384	1034
397	1034
402	1034
394	1034
438	1034
457	1034
465	1034
492	1034
508	1034
343	1035
344	1035
347	1035
348	1035
353	1035
355	1035
370	1035
382	1035
381	1035
391	1035
395	1035
405	1035
418	1035
443	1035
449	1035
455	1035
481	1035
485	1035
505	1035
540	1035
591	1035
341	1036
343	1036
344	1036
345	1036
348	1036
361	1036
368	1036
371	1036
374	1036
384	1036
377	1036
400	1036
407	1036
429	1036
440	1036
471	1036
472	1036
497	1036
505	1036
541	1036
339	1037
343	1037
346	1037
348	1037
353	1037
358	1037
363	1037
368	1037
372	1037
375	1037
401	1037
405	1037
419	1037
418	1037
424	1037
438	1037
445	1037
449	1037
455	1037
481	1037
485	1037
492	1037
505	1037
522	1037
348	1038
352	1038
353	1038
355	1038
361	1038
366	1038
367	1038
370	1038
378	1038
385	1038
384	1038
440	1038
465	1038
478	1038
505	1038
508	1038
591	1038
337	1039
338	1039
339	1039
341	1039
344	1039
348	1039
363	1039
364	1039
375	1039
374	1039
397	1039
402	1039
403	1039
443	1039
444	1039
441	1039
462	1039
490	1039
492	1039
518	1039
522	1039
603	1039
345	1040
348	1040
352	1040
361	1040
362	1040
368	1040
384	1040
377	1040
396	1040
392	1040
405	1040
419	1040
433	1040
449	1040
467	1040
474	1040
481	1040
515	1040
344	1041
347	1041
348	1041
358	1041
359	1041
366	1041
367	1041
370	1041
371	1041
382	1041
385	1041
381	1041
394	1041
391	1041
440	1041
438	1041
457	1041
497	1041
505	1041
509	1041
522	1041
339	1042
341	1042
346	1042
348	1042
368	1042
388	1042
377	1042
401	1042
390	1042
399	1042
400	1042
418	1042
407	1042
465	1042
471	1042
472	1042
490	1042
591	1042
337	1043
338	1043
341	1043
344	1043
348	1043
352	1043
355	1043
372	1043
384	1043
397	1043
391	1043
405	1043
429	1043
481	1043
511	1043
341	1044
345	1044
348	1044
352	1044
361	1044
368	1044
372	1044
374	1044
385	1044
402	1044
394	1044
405	1044
400	1044
462	1044
471	1044
472	1044
478	1044
591	1044
337	1045
338	1045
344	1045
346	1045
348	1045
358	1045
359	1045
368	1045
371	1045
375	1045
384	1045
377	1045
397	1045
391	1045
418	1045
438	1045
449	1045
481	1045
505	1045
541	1045
591	1045
337	1046
338	1046
344	1046
345	1046
348	1046
359	1046
362	1046
366	1046
367	1046
370	1046
375	1046
401	1046
390	1046
403	1046
391	1046
405	1046
444	1046
478	1046
484	1046
490	1046
497	1046
508	1046
604	1046
339	1047
341	1047
348	1047
352	1047
361	1047
382	1047
381	1047
396	1047
406	1047
392	1047
394	1047
400	1047
418	1047
424	1047
441	1047
457	1047
465	1047
471	1047
472	1047
509	1047
511	1047
541	1047
337	1048
338	1048
346	1048
348	1048
358	1048
371	1048
372	1048
385	1048
384	1048
379	1048
377	1048
419	1048
429	1048
438	1048
468	1048
474	1048
478	1048
481	1048
508	1048
522	1048
604	1048
344	1049
348	1049
359	1049
361	1049
364	1049
366	1049
367	1049
375	1049
382	1049
381	1049
391	1049
400	1049
440	1049
443	1049
445	1049
449	1049
455	1049
490	1049
497	1049
515	1049
518	1049
603	1049
339	1050
347	1050
348	1050
349	1050
352	1050
362	1050
372	1050
397	1050
392	1050
390	1050
395	1050
424	1050
440	1050
457	1050
465	1050
469	1050
471	1050
472	1050
484	1050
522	1050
540	1050
341	1051
345	1051
346	1051
348	1051
355	1051
360	1051
370	1051
388	1051
385	1051
402	1051
391	1051
399	1051
405	1051
420	1051
418	1051
443	1051
441	1051
462	1051
481	1051
515	1051
521	1051
337	1052
338	1052
348	1052
358	1052
359	1052
366	1052
367	1052
372	1052
374	1052
384	1052
377	1052
397	1052
440	1052
438	1052
444	1052
490	1052
509	1052
522	1052
339	1053
344	1053
348	1053
361	1053
363	1053
364	1053
371	1053
382	1053
381	1053
379	1053
396	1053
392	1053
401	1053
419	1053
407	1053
424	1053
433	1053
443	1053
449	1053
455	1053
468	1053
341	1054
345	1054
348	1054
359	1054
362	1054
378	1054
406	1054
390	1054
403	1054
394	1054
391	1054
400	1054
418	1054
440	1054
445	1054
457	1054
465	1054
482	1054
515	1054
344	1055
346	1055
348	1055
352	1055
355	1055
363	1055
385	1055
397	1055
402	1055
405	1055
462	1055
467	1055
471	1055
472	1055
481	1055
485	1055
497	1055
508	1055
509	1055
518	1055
603	1055
337	1056
338	1056
347	1056
348	1056
358	1056
361	1056
370	1056
372	1056
374	1056
384	1056
377	1056
418	1056
429	1056
438	1056
441	1056
478	1056
604	1056
339	1057
341	1057
348	1057
352	1057
363	1057
364	1057
366	1057
367	1057
378	1057
382	1057
388	1057
381	1057
397	1057
399	1057
433	1057
443	1057
455	1057
465	1057
522	1057
341	1058
345	1058
348	1058
352	1058
362	1058
363	1058
378	1058
388	1058
406	1058
394	1058
391	1058
405	1058
400	1058
418	1058
457	1058
468	1058
471	1058
472	1058
474	1058
481	1058
511	1058
337	1059
338	1059
339	1059
344	1059
346	1059
348	1059
358	1059
359	1059
361	1059
371	1059
375	1059
384	1059
377	1059
440	1059
438	1059
467	1059
497	1059
509	1059
344	1060
346	1060
348	1060
352	1060
359	1060
361	1060
396	1060
416	1060
445	1060
447	1060
467	1060
490	1060
615	1060
339	1061
341	1061
348	1061
355	1061
361	1061
370	1061
382	1061
385	1061
381	1061
406	1061
401	1061
403	1061
394	1061
420	1061
418	1061
424	1061
468	1061
471	1061
472	1061
474	1061
509	1061
511	1061
337	1062
338	1062
345	1062
348	1062
352	1062
359	1062
360	1062
363	1062
366	1062
367	1062
372	1062
374	1062
402	1062
391	1062
400	1062
429	1062
440	1062
465	1062
481	1062
518	1062
540	1062
603	1062
346	1063
348	1063
358	1063
362	1063
364	1063
375	1063
384	1063
377	1063
397	1063
405	1063
407	1063
433	1063
438	1063
457	1063
467	1063
515	1063
522	1063
339	1064
344	1064
345	1064
347	1064
348	1064
360	1064
361	1064
370	1064
388	1064
374	1064
377	1064
406	1064
390	1064
440	1064
441	1064
465	1064
478	1064
481	1064
509	1064
515	1064
604	1064
341	1065
346	1065
348	1065
358	1065
362	1065
375	1065
385	1065
384	1065
397	1065
401	1065
405	1065
418	1065
424	1065
433	1065
457	1065
462	1065
468	1065
472	1065
474	1065
482	1065
513	1065
522	1065
348	1066
352	1066
355	1066
359	1066
361	1066
364	1066
366	1066
367	1066
371	1066
391	1066
400	1066
407	1066
429	1066
440	1066
443	1066
449	1066
470	1066
481	1066
485	1066
497	1066
339	1067
344	1067
345	1067
346	1067
348	1067
363	1067
382	1067
381	1067
396	1067
402	1067
419	1067
433	1067
441	1067
455	1067
457	1067
465	1067
467	1067
468	1067
508	1067
522	1067
337	1068
338	1068
348	1068
358	1068
361	1068
372	1068
375	1068
374	1068
384	1068
377	1068
397	1068
392	1068
403	1068
438	1068
490	1068
509	1068
518	1068
603	1068
610	1068
559	1069
610	1069
339	1070
348	1070
359	1070
363	1070
364	1070
370	1070
391	1070
405	1070
418	1070
407	1070
429	1070
444	1070
441	1070
457	1070
471	1070
472	1070
481	1070
511	1070
522	1070
341	1071
344	1071
346	1071
348	1071
349	1071
352	1071
361	1071
375	1071
388	1071
385	1071
397	1071
402	1071
399	1071
395	1071
433	1071
440	1071
443	1071
455	1071
465	1071
508	1071
540	1071
337	1072
338	1072
348	1072
364	1072
366	1072
367	1072
370	1072
396	1072
406	1072
394	1072
391	1072
418	1072
445	1072
448	1072
449	1072
467	1072
481	1072
511	1072
521	1072
522	1072
339	1073
348	1073
352	1073
358	1073
361	1073
362	1073
372	1073
385	1073
384	1073
397	1073
401	1073
390	1073
407	1073
438	1073
468	1073
490	1073
509	1073
569	1073
344	1074
347	1074
348	1074
355	1074
366	1074
367	1074
392	1074
405	1074
419	1074
418	1074
424	1074
449	1074
455	1074
457	1074
462	1074
470	1074
471	1074
472	1074
482	1074
497	1074
515	1074
522	1074
345	1075
346	1075
348	1075
359	1075
361	1075
362	1075
375	1075
374	1075
384	1075
377	1075
400	1075
433	1075
443	1075
465	1075
474	1075
481	1075
610	1075
339	1076
346	1076
348	1076
352	1076
358	1076
364	1076
370	1076
371	1076
372	1076
382	1076
385	1076
381	1076
396	1076
401	1076
438	1076
441	1076
449	1076
467	1076
509	1076
522	1076
540	1076
337	1077
338	1077
341	1077
344	1077
348	1077
361	1077
397	1077
402	1077
394	1077
391	1077
405	1077
418	1077
433	1077
429	1077
455	1077
457	1077
471	1077
472	1077
478	1077
481	1077
341	1078
346	1078
348	1078
352	1078
358	1078
361	1078
364	1078
371	1078
372	1078
382	1078
385	1078
384	1078
381	1078
405	1078
400	1078
429	1078
457	1078
468	1078
472	1078
474	1078
337	1079
338	1079
339	1079
345	1079
348	1079
362	1079
388	1079
396	1079
397	1079
392	1079
401	1079
390	1079
391	1079
418	1079
433	1079
440	1079
465	1079
467	1079
478	1079
522	1079
337	1080
338	1080
339	1080
348	1080
352	1080
355	1080
358	1080
361	1080
362	1080
364	1080
370	1080
375	1080
406	1080
401	1080
391	1080
405	1080
438	1080
481	1080
341	1081
344	1081
348	1081
359	1081
371	1081
388	1081
374	1081
385	1081
384	1081
397	1081
440	1081
462	1081
471	1081
472	1081
497	1081
509	1081
521	1081
522	1081
345	1082
346	1082
348	1082
361	1082
366	1082
367	1082
370	1082
372	1082
375	1082
396	1082
392	1082
391	1082
418	1082
424	1082
443	1082
448	1082
455	1082
467	1082
474	1082
481	1082
490	1082
339	1083
348	1083
352	1083
359	1083
364	1083
382	1083
381	1083
377	1083
401	1083
394	1083
391	1083
405	1083
400	1083
429	1083
449	1083
481	1083
511	1083
522	1083
604	1083
337	1084
338	1084
344	1084
346	1084
347	1084
348	1084
349	1084
355	1084
358	1084
361	1084
362	1084
384	1084
397	1084
433	1084
440	1084
438	1084
441	1084
457	1084
465	1084
467	1084
498	1084
515	1084
347	1085
348	1085
349	1085
352	1085
355	1085
358	1085
375	1085
384	1085
391	1085
413	1085
419	1085
418	1085
433	1085
437	1085
445	1085
444	1085
465	1085
472	1085
478	1085
482	1085
497	1085
508	1085
522	1085
620	1085
617	1085
619	1085
618	1085
616	1085
339	1086
346	1086
348	1086
349	1086
352	1086
360	1086
361	1086
374	1086
397	1086
390	1086
420	1086
448	1086
449	1086
468	1086
490	1086
509	1086
515	1086
518	1086
603	1086
604	1086
616	1086
622	1086
621	1086
337	1087
338	1087
348	1087
349	1087
359	1087
366	1087
367	1087
370	1087
372	1087
375	1087
401	1087
394	1087
418	1087
440	1087
443	1087
441	1087
465	1087
467	1087
471	1087
472	1087
474	1087
481	1087
508	1087
540	1087
341	1088
345	1088
346	1088
348	1088
349	1088
362	1088
363	1088
376	1088
384	1088
377	1088
391	1088
405	1088
400	1088
429	1088
457	1088
497	1088
521	1088
522	1088
610	1088
339	1089
344	1089
348	1089
349	1089
358	1089
361	1089
364	1089
371	1089
382	1089
385	1089
381	1089
396	1089
397	1089
402	1089
424	1089
433	1089
440	1089
437	1089
438	1089
449	1089
455	1089
462	1089
358	1090
361	1090
371	1090
391	1090
440	1090
448	1090
472	1090
482	1090
497	1090
610	1090
617	1090
619	1090
618	1090
616	1090
622	1090
621	1090
624	1090
626	1090
627	1090
623	1090
625	1090
337	1091
338	1091
339	1091
345	1091
348	1091
349	1091
361	1091
362	1091
364	1091
370	1091
372	1091
382	1091
374	1091
381	1091
402	1091
418	1091
440	1091
455	1091
457	1091
465	1091
471	1091
472	1091
482	1091
511	1091
344	1092
345	1092
346	1092
348	1092
349	1092
358	1092
362	1092
366	1092
367	1092
375	1092
388	1092
379	1092
397	1092
399	1092
405	1092
433	1092
438	1092
448	1092
467	1092
469	1092
522	1092
610	1092
337	1093
338	1093
339	1093
341	1093
348	1093
349	1093
352	1093
359	1093
361	1093
406	1093
401	1093
391	1093
400	1093
429	1093
455	1093
457	1093
465	1093
470	1093
471	1093
472	1093
508	1093
521	1093
348	1094
349	1094
355	1094
360	1094
362	1094
364	1094
366	1094
367	1094
370	1094
371	1094
385	1094
376	1094
384	1094
377	1094
396	1094
405	1094
424	1094
443	1094
462	1094
468	1094
522	1094
339	1095
344	1095
345	1095
346	1095
348	1095
349	1095
358	1095
375	1095
382	1095
374	1095
381	1095
397	1095
402	1095
403	1095
394	1095
440	1095
438	1095
485	1095
490	1095
497	1095
508	1095
509	1095
522	1095
610	1095
337	1096
338	1096
347	1096
348	1096
349	1096
352	1096
360	1096
366	1096
367	1096
370	1096
375	1096
388	1096
376	1096
392	1096
390	1096
433	1096
440	1096
441	1096
457	1096
465	1096
467	1096
471	1096
472	1096
540	1096
339	1097
345	1097
348	1097
349	1097
359	1097
361	1097
364	1097
385	1097
401	1097
391	1097
405	1097
400	1097
418	1097
433	1097
478	1097
481	1097
509	1097
515	1097
628	1097
341	1098
344	1098
346	1098
348	1098
349	1098
355	1098
358	1098
362	1098
366	1098
367	1098
372	1098
397	1098
402	1098
438	1098
455	1098
457	1098
467	1098
469	1098
474	1098
511	1098
515	1098
522	1098
346	1099
348	1099
349	1099
359	1099
366	1099
367	1099
370	1099
382	1099
388	1099
374	1099
385	1099
376	1099
381	1099
394	1099
405	1099
418	1099
433	1099
471	1099
472	1099
485	1099
522	1099
339	1100
344	1100
346	1100
348	1100
349	1100
352	1100
355	1100
358	1100
361	1100
364	1100
371	1100
372	1100
392	1100
401	1100
391	1100
419	1100
433	1100
440	1100
438	1100
455	1100
457	1100
540	1100
341	1101
345	1101
364	1101
384	1101
389	1101
377	1101
397	1101
405	1101
416	1101
445	1101
448	1101
458	1101
488	1101
559	1101
604	1101
608	1101
629	1101
346	1102
348	1102
361	1102
362	1102
396	1102
402	1102
391	1102
400	1102
418	1102
424	1102
440	1102
443	1102
481	1102
490	1102
497	1102
499	1102
508	1102
509	1102
541	1102
345	1103
348	1103
349	1103
364	1103
366	1103
367	1103
377	1103
396	1103
397	1103
391	1103
405	1103
433	1103
441	1103
457	1103
467	1103
469	1103
482	1103
485	1103
509	1103
511	1103
513	1103
521	1103
522	1103
337	1104
338	1104
339	1104
341	1104
346	1104
348	1104
349	1104
360	1104
361	1104
370	1104
372	1104
375	1104
374	1104
376	1104
440	1104
445	1104
455	1104
465	1104
468	1104
471	1104
472	1104
474	1104
508	1104
540	1104
345	1105
364	1105
559	1105
604	1105
608	1105
630	1105
344	1106
348	1106
349	1106
355	1106
358	1106
359	1106
362	1106
363	1106
364	1106
366	1106
367	1106
371	1106
375	1106
385	1106
401	1106
391	1106
400	1106
420	1106
418	1106
429	1106
438	1106
443	1106
481	1106
345	1107
346	1107
347	1107
348	1107
349	1107
352	1107
360	1107
372	1107
382	1107
384	1107
381	1107
379	1107
397	1107
390	1107
394	1107
440	1107
471	1107
472	1107
490	1107
509	1107
522	1107
339	1108
346	1108
348	1108
349	1108
355	1108
358	1108
360	1108
361	1108
370	1108
377	1108
406	1108
402	1108
391	1108
405	1108
457	1108
465	1108
472	1108
478	1108
481	1108
492	1108
513	1108
515	1108
540	1108
341	1109
348	1109
349	1109
362	1109
363	1109
366	1109
367	1109
382	1109
374	1109
385	1109
381	1109
392	1109
391	1109
395	1109
405	1109
400	1109
418	1109
433	1109
443	1109
469	1109
470	1109
482	1109
485	1109
508	1109
337	1110
338	1110
339	1110
347	1110
348	1110
349	1110
352	1110
358	1110
359	1110
361	1110
364	1110
371	1110
388	1110
396	1110
406	1110
390	1110
419	1110
424	1110
440	1110
438	1110
441	1110
457	1110
344	1111
345	1111
346	1111
348	1111
349	1111
355	1111
360	1111
366	1111
367	1111
372	1111
375	1111
384	1111
397	1111
391	1111
405	1111
429	1111
448	1111
471	1111
472	1111
485	1111
522	1111
339	1112
341	1112
346	1112
348	1112
349	1112
358	1112
361	1112
370	1112
372	1112
385	1112
396	1112
401	1112
390	1112
394	1112
391	1112
418	1112
433	1112
438	1112
455	1112
465	1112
467	1112
474	1112
509	1112
540	1112
337	1113
338	1113
344	1113
346	1113
348	1113
349	1113
358	1113
361	1113
366	1113
367	1113
374	1113
396	1113
402	1113
403	1113
400	1113
424	1113
455	1113
465	1113
472	1113
478	1113
481	1113
485	1113
497	1113
339	1114
345	1114
348	1114
349	1114
352	1114
355	1114
371	1114
375	1114
385	1114
384	1114
392	1114
419	1114
433	1114
445	1114
457	1114
468	1114
470	1114
490	1114
509	1114
522	1114
604	1114
341	1115
346	1115
348	1115
349	1115
360	1115
361	1115
362	1115
364	1115
366	1115
367	1115
372	1115
382	1115
376	1115
381	1115
379	1115
377	1115
397	1115
391	1115
405	1115
440	1115
443	1115
441	1115
508	1115
513	1115
515	1115
540	1115
341	1116
347	1116
348	1116
349	1116
358	1116
361	1116
366	1116
367	1116
375	1116
374	1116
385	1116
376	1116
377	1116
406	1116
403	1116
394	1116
405	1116
438	1116
445	1116
468	1116
478	1116
482	1116
511	1116
515	1116
521	1116
540	1116
337	1117
338	1117
339	1117
345	1117
348	1117
352	1117
355	1117
359	1117
362	1117
364	1117
371	1117
382	1117
381	1117
401	1117
400	1117
440	1117
443	1117
457	1117
465	1117
467	1117
497	1117
522	1117
344	1118
346	1118
348	1118
349	1118
360	1118
361	1118
363	1118
366	1118
367	1118
388	1118
390	1118
402	1118
391	1118
419	1118
418	1118
433	1118
455	1118
471	1118
472	1118
481	1118
490	1118
508	1118
509	1118
345	1119
346	1119
348	1119
349	1119
361	1119
363	1119
366	1119
367	1119
372	1119
382	1119
385	1119
384	1119
381	1119
390	1119
394	1119
419	1119
440	1119
443	1119
455	1119
470	1119
490	1119
540	1119
339	1120
341	1120
348	1120
349	1120
359	1120
360	1120
370	1120
388	1120
402	1120
391	1120
399	1120
418	1120
433	1120
445	1120
457	1120
465	1120
469	1120
471	1120
472	1120
474	1120
478	1120
508	1120
515	1120
337	1121
338	1121
344	1121
346	1121
348	1121
349	1121
355	1121
358	1121
361	1121
366	1121
367	1121
372	1121
374	1121
385	1121
377	1121
392	1121
405	1121
400	1121
438	1121
469	1121
485	1121
509	1121
540	1121
339	1122
341	1122
348	1122
349	1122
352	1122
360	1122
362	1122
364	1122
382	1122
376	1122
381	1122
396	1122
397	1122
401	1122
424	1122
433	1122
443	1122
441	1122
457	1122
465	1122
515	1122
522	1122
339	1123
348	1123
349	1123
361	1123
362	1123
363	1123
370	1123
382	1123
374	1123
381	1123
401	1123
390	1123
394	1123
391	1123
418	1123
440	1123
443	1123
441	1123
465	1123
497	1123
345	1124
346	1124
347	1124
348	1124
352	1124
355	1124
358	1124
359	1124
366	1124
367	1124
371	1124
385	1124
397	1124
405	1124
438	1124
455	1124
469	1124
481	1124
515	1124
521	1124
522	1124
337	1125
338	1125
341	1125
348	1125
349	1125
361	1125
375	1125
384	1125
392	1125
403	1125
391	1125
400	1125
424	1125
433	1125
429	1125
445	1125
441	1125
457	1125
469	1125
474	1125
490	1125
497	1125
508	1125
515	1125
604	1125
339	1126
344	1126
346	1126
348	1126
349	1126
362	1126
366	1126
367	1126
372	1126
382	1126
381	1126
396	1126
401	1126
419	1126
440	1126
465	1126
467	1126
469	1126
470	1126
471	1126
472	1126
481	1126
485	1126
515	1126
522	1126
341	1127
344	1127
345	1127
348	1127
349	1127
355	1127
358	1127
361	1127
362	1127
364	1127
366	1127
367	1127
372	1127
401	1127
391	1127
400	1127
418	1127
433	1127
462	1127
465	1127
472	1127
482	1127
492	1127
521	1127
339	1128
346	1128
347	1128
348	1128
349	1128
352	1128
363	1128
382	1128
381	1128
397	1128
390	1128
405	1128
443	1128
457	1128
469	1128
470	1128
478	1128
481	1128
508	1128
509	1128
511	1128
522	1128
337	1129
338	1129
344	1129
348	1129
349	1129
358	1129
359	1129
361	1129
364	1129
366	1129
367	1129
370	1129
371	1129
396	1129
406	1129
402	1129
403	1129
391	1129
418	1129
438	1129
445	1129
441	1129
467	1129
469	1129
474	1129
339	1130
341	1130
345	1130
346	1130
348	1130
349	1130
374	1130
385	1130
384	1130
392	1130
401	1130
394	1130
420	1130
407	1130
433	1130
429	1130
440	1130
465	1130
469	1130
468	1130
471	1130
472	1130
506	1130
522	1130
337	1131
338	1131
346	1131
348	1131
349	1131
352	1131
358	1131
361	1131
366	1131
367	1131
372	1131
382	1131
388	1131
381	1131
390	1131
391	1131
399	1131
405	1131
400	1131
433	1131
438	1131
441	1131
469	1131
339	1132
344	1132
348	1132
349	1132
363	1132
364	1132
375	1132
397	1132
401	1132
403	1132
391	1132
433	1132
443	1132
445	1132
455	1132
457	1132
462	1132
465	1132
481	1132
518	1132
521	1132
583	1132
603	1132
341	1133
345	1133
346	1133
348	1133
349	1133
355	1133
366	1133
367	1133
370	1133
372	1133
385	1133
379	1133
392	1133
402	1133
418	1133
424	1133
433	1133
440	1133
455	1133
471	1133
472	1133
474	1133
490	1133
509	1133
522	1133
337	1134
338	1134
348	1134
349	1134
352	1134
358	1134
359	1134
361	1134
364	1134
371	1134
374	1134
384	1134
390	1134
394	1134
391	1134
405	1134
400	1134
438	1134
441	1134
339	1135
344	1135
346	1135
348	1135
349	1135
362	1135
366	1135
367	1135
372	1135
382	1135
381	1135
377	1135
396	1135
397	1135
401	1135
440	1135
443	1135
448	1135
457	1135
465	1135
467	1135
470	1135
478	1135
481	1135
522	1135
345	1136
348	1136
362	1136
364	1136
389	1136
488	1136
521	1136
559	1136
604	1136
608	1136
610	1136
626	1136
337	1137
338	1137
339	1137
341	1137
348	1137
349	1137
361	1137
367	1137
396	1137
402	1137
391	1137
405	1137
400	1137
418	1137
424	1137
441	1137
455	1137
457	1137
462	1137
471	1137
472	1137
474	1137
482	1137
509	1137
511	1137
344	1138
346	1138
348	1138
349	1138
355	1138
358	1138
362	1138
366	1138
367	1138
370	1138
371	1138
375	1138
385	1138
376	1138
392	1138
390	1138
407	1138
433	1138
438	1138
445	1138
485	1138
492	1138
522	1138
339	1139
345	1139
348	1139
349	1139
352	1139
361	1139
372	1139
382	1139
388	1139
381	1139
397	1139
401	1139
391	1139
399	1139
405	1139
433	1139
443	1139
448	1139
455	1139
457	1139
468	1139
470	1139
341	1140
347	1140
348	1140
349	1140
359	1140
362	1140
363	1140
364	1140
366	1140
367	1140
370	1140
374	1140
385	1140
406	1140
403	1140
444	1140
465	1140
471	1140
472	1140
522	1140
337	1141
338	1141
339	1141
345	1141
346	1141
348	1141
349	1141
355	1141
358	1141
361	1141
396	1141
402	1141
405	1141
400	1141
418	1141
433	1141
438	1141
441	1141
457	1141
467	1141
474	1141
478	1141
346	1142
348	1142
349	1142
382	1142
384	1142
381	1142
377	1142
391	1142
395	1142
433	1142
429	1142
440	1142
443	1142
449	1142
465	1142
470	1142
506	1142
508	1142
511	1142
518	1142
521	1142
522	1142
603	1142
337	1143
338	1143
339	1143
344	1143
348	1143
349	1143
361	1143
364	1143
366	1143
367	1143
371	1143
388	1143
397	1143
406	1143
401	1143
390	1143
399	1143
440	1143
455	1143
457	1143
471	1143
472	1143
474	1143
341	1144
346	1144
347	1144
348	1144
352	1144
355	1144
358	1144
370	1144
372	1144
374	1144
385	1144
384	1144
394	1144
405	1144
433	1144
438	1144
441	1144
469	1144
522	1144
345	1145
448	1145
604	1145
610	1145
345	1146
348	1146
361	1146
363	1146
366	1146
367	1146
385	1146
396	1146
402	1146
391	1146
400	1146
418	1146
433	1146
445	1146
448	1146
457	1146
462	1146
465	1146
467	1146
469	1146
470	1146
485	1146
492	1146
509	1146
339	1147
344	1147
346	1147
348	1147
349	1147
372	1147
382	1147
376	1147
381	1147
379	1147
396	1147
392	1147
401	1147
390	1147
407	1147
433	1147
443	1147
441	1147
468	1147
490	1147
522	1147
337	1148
338	1148
341	1148
346	1148
348	1148
361	1148
366	1148
367	1148
375	1148
384	1148
397	1148
406	1148
405	1148
433	1148
457	1148
467	1148
470	1148
471	1148
472	1148
482	1148
498	1148
508	1148
521	1148
339	1149
345	1149
346	1149
347	1149
348	1149
349	1149
352	1149
364	1149
370	1149
371	1149
382	1149
374	1149
381	1149
391	1149
424	1149
429	1149
440	1149
443	1149
455	1149
465	1149
346	1150
348	1150
349	1150
358	1150
359	1150
361	1150
362	1150
363	1150
366	1150
367	1150
372	1150
388	1150
385	1150
377	1150
396	1150
390	1150
402	1150
405	1150
400	1150
418	1150
424	1150
438	1150
337	1151
338	1151
339	1151
341	1151
344	1151
348	1151
349	1151
355	1151
374	1151
396	1151
397	1151
401	1151
394	1151
420	1151
440	1151
441	1151
457	1151
467	1151
478	1151
490	1151
522	1151
348	1152
362	1152
443	1152
470	1152
559	1152
604	1152
608	1152
610	1152
626	1152
631	1152
339	1153
341	1153
346	1153
348	1153
352	1153
355	1153
358	1153
361	1153
363	1153
371	1153
396	1153
402	1153
400	1153
418	1153
429	1153
440	1153
457	1153
465	1153
467	1153
472	1153
474	1153
337	1154
338	1154
344	1154
348	1154
349	1154
355	1154
358	1154
361	1154
366	1154
367	1154
388	1154
377	1154
406	1154
402	1154
399	1154
395	1154
400	1154
440	1154
438	1154
465	1154
467	1154
469	1154
492	1154
508	1154
341	1155
345	1155
347	1155
348	1155
349	1155
364	1155
370	1155
374	1155
384	1155
391	1155
405	1155
420	1155
418	1155
429	1155
443	1155
468	1155
478	1155
509	1155
518	1155
521	1155
603	1155
337	1156
338	1156
339	1156
346	1156
348	1156
349	1156
352	1156
358	1156
359	1156
361	1156
371	1156
374	1156
385	1156
396	1156
397	1156
401	1156
424	1156
433	1156
438	1156
441	1156
474	1156
344	1157
346	1157
348	1157
349	1157
362	1157
363	1157
366	1157
367	1157
372	1157
382	1157
381	1157
390	1157
402	1157
394	1157
391	1157
400	1157
440	1157
455	1157
457	1157
471	1157
472	1157
490	1157
522	1157
337	1158
338	1158
346	1158
348	1158
358	1158
366	1158
367	1158
370	1158
371	1158
375	1158
376	1158
396	1158
390	1158
403	1158
418	1158
429	1158
438	1158
441	1158
465	1158
467	1158
474	1158
522	1158
339	1159
341	1159
345	1159
346	1159
348	1159
349	1159
355	1159
361	1159
366	1159
367	1159
379	1159
401	1159
391	1159
405	1159
400	1159
433	1159
443	1159
470	1159
478	1159
482	1159
492	1159
509	1159
346	1160
347	1160
348	1160
349	1160
352	1160
359	1160
364	1160
372	1160
388	1160
374	1160
385	1160
384	1160
397	1160
402	1160
440	1160
471	1160
472	1160
490	1160
522	1160
344	1161
348	1161
349	1161
358	1161
361	1161
363	1161
366	1161
367	1161
382	1161
388	1161
381	1161
377	1161
406	1161
392	1161
399	1161
405	1161
433	1161
457	1161
469	1161
478	1161
506	1161
511	1161
518	1161
603	1161
337	1162
338	1162
339	1162
341	1162
346	1162
348	1162
349	1162
364	1162
370	1162
372	1162
390	1162
391	1162
418	1162
407	1162
443	1162
465	1162
468	1162
474	1162
508	1162
522	1162
610	1162
344	1163
348	1163
349	1163
358	1163
363	1163
364	1163
366	1163
367	1163
371	1163
376	1163
396	1163
397	1163
440	1163
438	1163
444	1163
448	1163
455	1163
457	1163
467	1163
470	1163
490	1163
522	1163
339	1164
341	1164
345	1164
348	1164
349	1164
361	1164
363	1164
370	1164
388	1164
374	1164
385	1164
392	1164
395	1164
405	1164
418	1164
433	1164
443	1164
441	1164
478	1164
509	1164
346	1165
348	1165
349	1165
352	1165
359	1165
362	1165
372	1165
382	1165
376	1165
384	1165
381	1165
379	1165
396	1165
391	1165
400	1165
440	1165
467	1165
469	1165
471	1165
472	1165
490	1165
521	1165
522	1165
337	1166
338	1166
341	1166
348	1166
349	1166
358	1166
361	1166
363	1166
364	1166
366	1166
367	1166
397	1166
390	1166
402	1166
420	1166
438	1166
441	1166
457	1166
462	1166
465	1166
469	1166
345	1167
346	1167
348	1167
349	1167
355	1167
372	1167
384	1167
377	1167
391	1167
424	1167
433	1167
440	1167
443	1167
448	1167
468	1167
470	1167
490	1167
506	1167
518	1167
603	1167
346	1168
347	1168
348	1168
349	1168
361	1168
363	1168
366	1168
367	1168
370	1168
371	1168
374	1168
385	1168
418	1168
440	1168
455	1168
462	1168
465	1168
467	1168
469	1168
471	1168
472	1168
474	1168
482	1168
509	1168
339	1169
345	1169
348	1169
349	1169
352	1169
362	1169
382	1169
381	1169
396	1169
401	1169
394	1169
391	1169
405	1169
400	1169
424	1169
433	1169
478	1169
522	1169
337	1170
338	1170
341	1170
344	1170
346	1170
348	1170
358	1170
359	1170
361	1170
364	1170
372	1170
376	1170
379	1170
397	1170
390	1170
402	1170
438	1170
445	1170
441	1170
469	1170
490	1170
337	1171
338	1171
339	1171
345	1171
346	1171
348	1171
349	1171
361	1171
363	1171
364	1171
366	1171
367	1171
382	1171
389	1171
381	1171
396	1171
406	1171
405	1171
400	1171
418	1171
440	1171
448	1171
457	1171
467	1171
470	1171
488	1171
509	1171
511	1171
513	1171
521	1171
559	1171
604	1171
630	1171
341	1172
344	1172
346	1172
348	1172
349	1172
352	1172
355	1172
362	1172
363	1172
372	1172
385	1172
392	1172
402	1172
391	1172
440	1172
465	1172
471	1172
472	1172
506	1172
508	1172
346	1173
347	1173
348	1173
349	1173
358	1173
361	1173
364	1173
366	1173
367	1173
370	1173
388	1173
374	1173
399	1173
405	1173
420	1173
418	1173
433	1173
438	1173
337	1174
338	1174
339	1174
344	1174
348	1174
349	1174
359	1174
371	1174
376	1174
379	1174
377	1174
401	1174
390	1174
394	1174
391	1174
400	1174
429	1174
445	1174
457	1174
478	1174
490	1174
341	1175
345	1175
346	1175
348	1175
349	1175
352	1175
363	1175
366	1175
367	1175
372	1175
382	1175
384	1175
381	1175
396	1175
397	1175
424	1175
440	1175
441	1175
465	1175
474	1175
509	1175
522	1175
339	1176
341	1176
346	1176
348	1176
349	1176
358	1176
361	1176
364	1176
370	1176
375	1176
376	1176
377	1176
406	1176
394	1176
418	1176
433	1176
440	1176
438	1176
455	1176
457	1176
465	1176
467	1176
478	1176
482	1176
348	1177
349	1177
352	1177
363	1177
366	1177
367	1177
371	1177
382	1177
384	1177
381	1177
397	1177
390	1177
391	1177
405	1177
429	1177
468	1177
521	1177
522	1177
337	1178
338	1178
339	1178
344	1178
346	1178
348	1178
349	1178
359	1178
361	1178
362	1178
396	1178
401	1178
402	1178
400	1178
424	1178
433	1178
440	1178
441	1178
457	1178
465	1178
467	1178
471	1178
472	1178
345	1179
364	1179
389	1179
448	1179
470	1179
506	1179
559	1179
604	1179
608	1179
630	1179
341	1180
345	1180
348	1180
349	1180
358	1180
361	1180
363	1180
364	1180
366	1180
367	1180
382	1180
384	1180
381	1180
377	1180
390	1180
394	1180
407	1180
440	1180
438	1180
468	1180
474	1180
478	1180
490	1180
506	1180
339	1181
344	1181
346	1181
348	1181
349	1181
355	1181
366	1181
367	1181
370	1181
388	1181
396	1181
402	1181
391	1181
395	1181
420	1181
418	1181
424	1181
433	1181
455	1181
465	1181
471	1181
472	1181
347	1182
348	1182
349	1182
352	1182
359	1182
361	1182
363	1182
372	1182
374	1182
385	1182
376	1182
397	1182
390	1182
405	1182
441	1182
457	1182
521	1182
610	1182
337	1183
338	1183
339	1183
341	1183
346	1183
348	1183
349	1183
362	1183
363	1183
366	1183
367	1183
396	1183
401	1183
391	1183
400	1183
440	1183
465	1183
467	1183
470	1183
478	1183
482	1183
488	1183
511	1183
604	1183
345	1184
348	1184
349	1184
352	1184
358	1184
361	1184
363	1184
364	1184
366	1184
367	1184
370	1184
382	1184
388	1184
374	1184
389	1184
392	1184
407	1184
433	1184
445	1184
457	1184
465	1184
468	1184
472	1184
478	1184
482	1184
559	1184
632	1184
634	1184
633	1184
341	1185
344	1185
346	1185
348	1185
349	1185
355	1185
366	1185
367	1185
389	1185
396	1185
402	1185
394	1185
391	1185
400	1185
418	1185
424	1185
441	1185
465	1185
471	1185
472	1185
490	1185
521	1185
604	1185
610	1185
630	1185
631	1185
632	1185
337	1186
338	1186
339	1186
346	1186
347	1186
348	1186
349	1186
358	1186
359	1186
361	1186
364	1186
367	1186
372	1186
388	1186
389	1186
379	1186
377	1186
397	1186
390	1186
405	1186
438	1186
448	1186
455	1186
457	1186
478	1186
488	1186
604	1186
608	1186
632	1186
344	1187
348	1187
349	1187
362	1187
363	1187
364	1187
366	1187
367	1187
375	1187
382	1187
376	1187
389	1187
381	1187
396	1187
403	1187
391	1187
395	1187
400	1187
420	1187
441	1187
467	1187
488	1187
490	1187
521	1187
559	1187
604	1187
630	1187
632	1187
635	1187
339	1188
341	1188
345	1188
346	1188
348	1188
349	1188
352	1188
361	1188
370	1188
374	1188
385	1188
389	1188
406	1188
392	1188
402	1188
433	1188
429	1188
444	1188
465	1188
469	1188
470	1188
478	1188
506	1188
604	1188
631	1188
348	1189
349	1189
358	1189
363	1189
364	1189
366	1189
367	1189
371	1189
372	1189
388	1189
384	1189
389	1189
397	1189
391	1189
399	1189
418	1189
407	1189
440	1189
438	1189
443	1189
448	1189
457	1189
468	1189
482	1189
488	1189
492	1189
521	1189
559	1189
610	1189
630	1189
632	1189
339	1190
341	1190
344	1190
345	1190
346	1190
347	1190
348	1190
349	1190
359	1190
361	1190
389	1190
379	1190
377	1190
390	1190
405	1190
400	1190
420	1190
462	1190
470	1190
471	1190
472	1190
474	1190
478	1190
506	1190
559	1190
604	1190
608	1190
631	1190
337	1191
338	1191
348	1191
349	1191
352	1191
358	1191
362	1191
364	1191
366	1191
367	1191
372	1191
382	1191
389	1191
381	1191
396	1191
391	1191
438	1191
445	1191
441	1191
448	1191
465	1191
467	1191
521	1191
559	1191
604	1191
630	1191
632	1191
341	1192
344	1192
345	1192
347	1192
348	1192
349	1192
359	1192
364	1192
382	1192
374	1192
376	1192
389	1192
381	1192
406	1192
395	1192
405	1192
400	1192
424	1192
455	1192
457	1192
465	1192
470	1192
471	1192
472	1192
509	1192
604	1192
608	1192
631	1192
632	1192
635	1192
337	1193
338	1193
339	1193
346	1193
348	1193
349	1193
352	1193
358	1193
362	1193
363	1193
366	1193
367	1193
371	1193
389	1193
396	1193
397	1193
401	1193
390	1193
394	1193
391	1193
440	1193
438	1193
448	1193
467	1193
474	1193
478	1193
490	1193
521	1193
559	1193
604	1193
630	1193
632	1193
339	1194
345	1194
347	1194
348	1194
349	1194
358	1194
359	1194
361	1194
362	1194
364	1194
372	1194
382	1194
385	1194
384	1194
389	1194
381	1194
379	1194
377	1194
396	1194
406	1194
403	1194
419	1194
407	1194
448	1194
455	1194
465	1194
467	1194
472	1194
478	1194
506	1194
559	1194
630	1194
631	1194
632	1194
341	1195
348	1195
349	1195
363	1195
364	1195
366	1195
367	1195
370	1195
389	1195
402	1195
391	1195
420	1195
418	1195
429	1195
440	1195
443	1195
441	1195
462	1195
470	1195
474	1195
482	1195
488	1195
490	1195
518	1195
521	1195
522	1195
603	1195
604	1195
610	1195
632	1195
337	1196
338	1196
345	1196
346	1196
348	1196
349	1196
352	1196
366	1196
367	1196
371	1196
385	1196
376	1196
389	1196
406	1196
390	1196
394	1196
400	1196
445	1196
448	1196
457	1196
468	1196
471	1196
472	1196
506	1196
509	1196
559	1196
608	1196
610	1196
631	1196
632	1196
635	1196
339	1197
341	1197
344	1197
346	1197
348	1197
349	1197
358	1197
364	1197
372	1197
382	1197
388	1197
374	1197
389	1197
381	1197
397	1197
401	1197
391	1197
399	1197
395	1197
424	1197
440	1197
438	1197
455	1197
462	1197
470	1197
478	1197
498	1197
508	1197
521	1197
559	1197
604	1197
631	1197
632	1197
345	1198
347	1198
348	1198
349	1198
352	1198
359	1198
361	1198
362	1198
364	1198
366	1198
367	1198
389	1198
379	1198
396	1198
392	1198
390	1198
405	1198
400	1198
420	1198
441	1198
448	1198
467	1198
471	1198
472	1198
488	1198
492	1198
506	1198
604	1198
608	1198
630	1198
631	1198
339	1199
346	1199
348	1199
349	1199
355	1199
358	1199
361	1199
363	1199
370	1199
385	1199
389	1199
377	1199
396	1199
402	1199
403	1199
394	1199
391	1199
433	1199
438	1199
443	1199
444	1199
465	1199
482	1199
521	1199
559	1199
610	1199
631	1199
632	1199
635	1199
337	1200
338	1200
341	1200
344	1200
345	1200
347	1200
348	1200
349	1200
363	1200
364	1200
366	1200
367	1200
372	1200
389	1200
397	1200
392	1200
391	1200
405	1200
418	1200
441	1200
448	1200
457	1200
470	1200
478	1200
490	1200
506	1200
508	1200
509	1200
518	1200
559	1200
603	1200
604	1200
630	1200
632	1200
339	1201
346	1201
348	1201
349	1201
352	1201
361	1201
363	1201
371	1201
388	1201
385	1201
376	1201
389	1201
396	1201
401	1201
390	1201
403	1201
400	1201
407	1201
455	1201
467	1201
468	1201
471	1201
472	1201
478	1201
488	1201
490	1201
492	1201
521	1201
559	1201
604	1201
608	1201
610	1201
631	1201
635	1201
341	1202
348	1202
349	1202
358	1202
359	1202
364	1202
382	1202
374	1202
384	1202
389	1202
381	1202
379	1202
377	1202
397	1202
406	1202
391	1202
395	1202
429	1202
438	1202
448	1202
465	1202
470	1202
474	1202
506	1202
559	1202
604	1202
630	1202
631	1202
632	1202
337	1203
338	1203
345	1203
347	1203
348	1203
364	1203
366	1203
367	1203
370	1203
375	1203
384	1203
389	1203
396	1203
394	1203
405	1203
444	1203
441	1203
449	1203
457	1203
467	1203
470	1203
471	1203
472	1203
478	1203
488	1203
507	1203
521	1203
604	1203
631	1203
339	1204
341	1204
348	1204
349	1204
361	1204
362	1204
364	1204
388	1204
389	1204
396	1204
397	1204
406	1204
390	1204
402	1204
394	1204
418	1204
424	1204
441	1204
462	1204
465	1204
470	1204
506	1204
508	1204
518	1204
559	1204
603	1204
604	1204
608	1204
631	1204
632	1204
635	1204
337	1205
338	1205
344	1205
345	1205
346	1205
347	1205
348	1205
349	1205
364	1205
366	1205
367	1205
372	1205
374	1205
389	1205
392	1205
391	1205
400	1205
440	1205
443	1205
448	1205
449	1205
455	1205
490	1205
509	1205
521	1205
604	1205
608	1205
630	1205
631	1205
632	1205
346	1206
348	1206
349	1206
361	1206
363	1206
364	1206
370	1206
371	1206
388	1206
385	1206
389	1206
402	1206
403	1206
399	1206
395	1206
418	1206
445	1206
448	1206
468	1206
470	1206
471	1206
472	1206
478	1206
482	1206
488	1206
490	1206
521	1206
522	1206
559	1206
604	1206
608	1206
631	1206
339	1207
345	1207
348	1207
349	1207
352	1207
358	1207
359	1207
364	1207
366	1207
367	1207
382	1207
389	1207
381	1207
397	1207
406	1207
401	1207
390	1207
391	1207
405	1207
429	1207
438	1207
441	1207
455	1207
457	1207
506	1207
521	1207
604	1207
630	1207
631	1207
635	1207
337	1208
338	1208
341	1208
346	1208
348	1208
349	1208
361	1208
362	1208
363	1208
364	1208
372	1208
374	1208
384	1208
389	1208
396	1208
394	1208
400	1208
440	1208
465	1208
467	1208
470	1208
471	1208
472	1208
474	1208
478	1208
559	1208
608	1208
630	1208
631	1208
635	1208
337	1209
338	1209
346	1209
348	1209
349	1209
352	1209
355	1209
358	1209
359	1209
361	1209
362	1209
366	1209
367	1209
371	1209
384	1209
377	1209
396	1209
406	1209
390	1209
405	1209
407	1209
424	1209
429	1209
467	1209
472	1209
541	1209
337	1210
338	1210
339	1210
341	1210
345	1210
346	1210
348	1210
349	1210
372	1210
401	1210
390	1210
391	1210
400	1210
418	1210
445	1210
441	1210
448	1210
457	1210
465	1210
468	1210
518	1210
541	1210
344	1211
346	1211
348	1211
349	1211
361	1211
363	1211
366	1211
367	1211
388	1211
385	1211
397	1211
406	1211
390	1211
402	1211
399	1211
440	1211
455	1211
471	1211
472	1211
490	1211
492	1211
545	1211
337	1212
338	1212
339	1212
346	1212
347	1212
348	1212
349	1212
362	1212
366	1212
367	1212
384	1212
396	1212
391	1212
405	1212
419	1212
433	1212
429	1212
443	1212
444	1212
449	1212
474	1212
522	1212
344	1213
346	1213
348	1213
349	1213
359	1213
361	1213
363	1213
366	1213
367	1213
370	1213
396	1213
406	1213
403	1213
418	1213
407	1213
424	1213
465	1213
467	1213
471	1213
472	1213
507	1213
509	1213
518	1213
541	1213
603	1213
339	1214
345	1214
346	1214
348	1214
349	1214
352	1214
362	1214
371	1214
382	1214
374	1214
381	1214
397	1214
401	1214
390	1214
391	1214
405	1214
441	1214
457	1214
468	1214
482	1214
522	1214
545	1214
346	1215
348	1215
349	1215
358	1215
361	1215
363	1215
366	1215
367	1215
372	1215
385	1215
396	1215
392	1215
402	1215
395	1215
400	1215
418	1215
424	1215
440	1215
438	1215
445	1215
455	1215
467	1215
490	1215
541	1215
337	1216
338	1216
339	1216
346	1216
348	1216
349	1216
352	1216
359	1216
370	1216
372	1216
375	1216
401	1216
390	1216
403	1216
391	1216
424	1216
457	1216
462	1216
465	1216
471	1216
472	1216
492	1216
509	1216
522	1216
346	1217
348	1217
349	1217
361	1217
363	1217
366	1217
367	1217
384	1217
394	1217
420	1217
407	1217
433	1217
429	1217
443	1217
490	1217
507	1217
508	1217
518	1217
541	1217
603	1217
337	1218
338	1218
341	1218
345	1218
346	1218
348	1218
349	1218
352	1218
363	1218
374	1218
385	1218
376	1218
397	1218
392	1218
390	1218
405	1218
433	1218
441	1218
457	1218
474	1218
509	1218
346	1219
348	1219
349	1219
358	1219
359	1219
366	1219
367	1219
371	1219
379	1219
396	1219
402	1219
400	1219
424	1219
433	1219
440	1219
438	1219
455	1219
465	1219
518	1219
603	1219
344	1220
348	1220
355	1220
377	1220
396	1220
391	1220
405	1220
418	1220
407	1220
424	1220
441	1220
449	1220
471	1220
472	1220
482	1220
492	1220
545	1220
346	1221
347	1221
348	1221
349	1221
352	1221
363	1221
366	1221
367	1221
372	1221
374	1221
385	1221
394	1221
419	1221
443	1221
457	1221
462	1221
465	1221
467	1221
468	1221
508	1221
541	1221
337	1222
338	1222
339	1222
345	1222
346	1222
348	1222
349	1222
358	1222
361	1222
388	1222
384	1222
396	1222
401	1222
390	1222
391	1222
399	1222
395	1222
440	1222
438	1222
448	1222
490	1222
507	1222
545	1222
341	1223
344	1223
348	1223
349	1223
362	1223
366	1223
367	1223
372	1223
382	1223
374	1223
381	1223
377	1223
391	1223
400	1223
433	1223
429	1223
441	1223
465	1223
471	1223
472	1223
541	1223
337	1224
338	1224
339	1224
346	1224
348	1224
349	1224
358	1224
359	1224
363	1224
371	1224
396	1224
397	1224
402	1224
391	1224
405	1224
418	1224
424	1224
443	1224
444	1224
457	1224
474	1224
509	1224
522	1224
545	1224
337	1225
338	1225
344	1225
346	1225
348	1225
349	1225
359	1225
366	1225
367	1225
388	1225
374	1225
384	1225
396	1225
400	1225
407	1225
440	1225
443	1225
441	1225
465	1225
490	1225
518	1225
522	1225
541	1225
603	1225
339	1226
346	1226
348	1226
363	1226
366	1226
367	1226
372	1226
382	1226
381	1226
396	1226
397	1226
390	1226
394	1226
391	1226
405	1226
418	1226
424	1226
433	1226
457	1226
462	1226
545	1226
341	1227
344	1227
347	1227
348	1227
349	1227
358	1227
370	1227
371	1227
384	1227
406	1227
390	1227
394	1227
391	1227
405	1227
429	1227
438	1227
455	1227
462	1227
468	1227
518	1227
541	1227
603	1227
339	1228
346	1228
348	1228
352	1228
362	1228
363	1228
366	1228
367	1228
388	1228
374	1228
385	1228
396	1228
397	1228
418	1228
433	1228
440	1228
467	1228
471	1228
472	1228
474	1228
490	1228
545	1228
337	1229
338	1229
345	1229
346	1229
348	1229
349	1229
359	1229
366	1229
367	1229
372	1229
375	1229
379	1229
396	1229
403	1229
400	1229
424	1229
443	1229
441	1229
457	1229
465	1229
509	1229
522	1229
541	1229
339	1230
348	1230
349	1230
358	1230
362	1230
366	1230
367	1230
370	1230
371	1230
396	1230
392	1230
401	1230
390	1230
424	1230
433	1230
438	1230
443	1230
445	1230
457	1230
462	1230
465	1230
474	1230
541	1230
337	1231
338	1231
346	1231
347	1231
348	1231
349	1231
363	1231
366	1231
367	1231
385	1231
376	1231
396	1231
391	1231
405	1231
400	1231
418	1231
433	1231
429	1231
455	1231
471	1231
472	1231
522	1231
339	1232
345	1232
346	1232
348	1232
349	1232
352	1232
363	1232
366	1232
367	1232
382	1232
381	1232
396	1232
397	1232
392	1232
424	1232
440	1232
443	1232
441	1232
465	1232
490	1232
541	1232
339	1233
341	1233
346	1233
348	1233
349	1233
358	1233
359	1233
363	1233
367	1233
384	1233
396	1233
397	1233
406	1233
401	1233
390	1233
405	1233
407	1233
457	1233
472	1233
474	1233
545	1233
346	1234
348	1234
349	1234
352	1234
362	1234
363	1234
366	1234
367	1234
371	1234
372	1234
375	1234
374	1234
376	1234
396	1234
390	1234
394	1234
391	1234
400	1234
443	1234
465	1234
467	1234
468	1234
471	1234
541	1234
337	1235
338	1235
344	1235
346	1235
347	1235
348	1235
349	1235
359	1235
366	1235
367	1235
372	1235
396	1235
397	1235
390	1235
391	1235
424	1235
433	1235
440	1235
443	1235
457	1235
472	1235
490	1235
509	1235
545	1235
345	1236
346	1236
348	1236
349	1236
363	1236
366	1236
367	1236
372	1236
375	1236
396	1236
406	1236
390	1236
403	1236
394	1236
391	1236
405	1236
400	1236
418	1236
424	1236
441	1236
457	1236
474	1236
541	1236
346	1237
348	1237
349	1237
352	1237
358	1237
362	1237
382	1237
388	1237
374	1237
376	1237
384	1237
381	1237
379	1237
396	1237
397	1237
438	1237
445	1237
465	1237
545	1237
339	1238
346	1238
348	1238
349	1238
363	1238
366	1238
367	1238
372	1238
385	1238
396	1238
401	1238
390	1238
391	1238
418	1238
424	1238
440	1238
443	1238
455	1238
472	1238
474	1238
490	1238
507	1238
509	1238
541	1238
337	1239
338	1239
344	1239
346	1239
348	1239
349	1239
358	1239
366	1239
367	1239
396	1239
406	1239
401	1239
390	1239
391	1239
395	1239
419	1239
424	1239
440	1239
438	1239
457	1239
468	1239
490	1239
492	1239
345	1240
346	1240
347	1240
348	1240
349	1240
352	1240
363	1240
366	1240
367	1240
388	1240
374	1240
384	1240
396	1240
390	1240
407	1240
445	1240
441	1240
465	1240
509	1240
518	1240
541	1240
603	1240
346	1241
348	1241
349	1241
359	1241
366	1241
367	1241
385	1241
379	1241
396	1241
397	1241
390	1241
418	1241
424	1241
433	1241
429	1241
440	1241
443	1241
455	1241
472	1241
490	1241
507	1241
545	1241
337	1242
338	1242
339	1242
346	1242
348	1242
367	1242
372	1242
374	1242
396	1242
390	1242
402	1242
391	1242
405	1242
400	1242
443	1242
474	1242
518	1242
541	1242
603	1242
345	1243
347	1243
348	1243
349	1243
382	1243
384	1243
381	1243
379	1243
396	1243
397	1243
406	1243
390	1243
394	1243
424	1243
433	1243
440	1243
445	1243
449	1243
457	1243
462	1243
490	1243
509	1243
545	1243
337	1244
338	1244
339	1244
346	1244
348	1244
352	1244
363	1244
366	1244
367	1244
371	1244
376	1244
396	1244
390	1244
402	1244
391	1244
405	1244
407	1244
443	1244
441	1244
472	1244
507	1244
541	1244
339	1245
344	1245
348	1245
349	1245
362	1245
366	1245
367	1245
370	1245
372	1245
396	1245
401	1245
407	1245
424	1245
440	1245
468	1245
471	1245
472	1245
490	1245
492	1245
518	1245
603	1245
345	1246
346	1246
347	1246
348	1246
349	1246
355	1246
359	1246
367	1246
375	1246
374	1246
384	1246
396	1246
397	1246
390	1246
395	1246
433	1246
443	1246
465	1246
545	1246
337	1247
338	1247
346	1247
348	1247
349	1247
358	1247
366	1247
367	1247
396	1247
406	1247
390	1247
402	1247
394	1247
400	1247
418	1247
440	1247
438	1247
441	1247
467	1247
490	1247
518	1247
541	1247
603	1247
341	1248
346	1248
348	1248
349	1248
372	1248
382	1248
388	1248
384	1248
381	1248
397	1248
392	1248
390	1248
399	1248
405	1248
424	1248
433	1248
443	1248
449	1248
474	1248
545	1248
346	1249
348	1249
349	1249
352	1249
362	1249
370	1249
375	1249
379	1249
396	1249
401	1249
390	1249
403	1249
394	1249
391	1249
457	1249
465	1249
471	1249
472	1249
490	1249
541	1249
339	1250
346	1250
348	1250
349	1250
358	1250
363	1250
366	1250
367	1250
396	1250
406	1250
390	1250
391	1250
400	1250
407	1250
424	1250
433	1250
429	1250
440	1250
438	1250
455	1250
490	1250
545	1250
347	1251
348	1251
349	1251
362	1251
366	1251
367	1251
372	1251
375	1251
374	1251
376	1251
379	1251
392	1251
403	1251
391	1251
433	1251
441	1251
465	1251
469	1251
468	1251
471	1251
472	1251
541	1251
337	1252
338	1252
341	1252
346	1252
348	1252
349	1252
359	1252
363	1252
396	1252
397	1252
390	1252
402	1252
405	1252
418	1252
424	1252
443	1252
445	1252
457	1252
509	1252
541	1252
367	1253
396	1253
337	1254
338	1254
339	1254
348	1254
349	1254
355	1254
358	1254
362	1254
363	1254
370	1254
390	1254
402	1254
418	1254
424	1254
433	1254
440	1254
438	1254
449	1254
455	1254
457	1254
341	1255
346	1255
347	1255
348	1255
349	1255
366	1255
367	1255
374	1255
384	1255
392	1255
390	1255
400	1255
433	1255
465	1255
471	1255
472	1255
490	1255
509	1255
541	1255
339	1256
345	1256
346	1256
348	1256
349	1256
359	1256
366	1256
367	1256
372	1256
382	1256
381	1256
396	1256
397	1256
401	1256
394	1256
391	1256
405	1256
424	1256
443	1256
441	1256
541	1256
348	1257
352	1257
359	1257
372	1257
388	1257
374	1257
384	1257
391	1257
405	1257
433	1257
457	1257
337	1258
338	1258
341	1258
346	1258
348	1258
349	1258
352	1258
359	1258
363	1258
366	1258
367	1258
370	1258
388	1258
374	1258
396	1258
391	1258
405	1258
407	1258
424	1258
457	1258
465	1258
471	1258
472	1258
474	1258
513	1258
344	1259
348	1259
349	1259
358	1259
363	1259
382	1259
385	1259
381	1259
406	1259
391	1259
400	1259
433	1259
440	1259
438	1259
455	1259
468	1259
490	1259
518	1259
603	1259
347	1260
348	1260
349	1260
371	1260
375	1260
384	1260
379	1260
396	1260
403	1260
395	1260
420	1260
407	1260
429	1260
449	1260
465	1260
467	1260
471	1260
472	1260
492	1260
337	1261
338	1261
341	1261
345	1261
348	1261
349	1261
363	1261
366	1261
367	1261
372	1261
374	1261
397	1261
406	1261
401	1261
405	1261
433	1261
443	1261
441	1261
508	1261
509	1261
339	1262
348	1262
352	1262
355	1262
358	1262
362	1262
396	1262
406	1262
392	1262
402	1262
391	1262
418	1262
407	1262
424	1262
440	1262
438	1262
448	1262
457	1262
482	1262
490	1262
522	1262
337	1263
338	1263
341	1263
346	1263
347	1263
348	1263
352	1263
355	1263
358	1263
366	1263
367	1263
374	1263
396	1263
397	1263
394	1263
391	1263
405	1263
424	1263
438	1263
474	1263
545	1263
344	1264
348	1264
359	1264
363	1264
372	1264
382	1264
388	1264
385	1264
381	1264
402	1264
400	1264
441	1264
457	1264
467	1264
469	1264
471	1264
472	1264
482	1264
490	1264
545	1264
583	1264
341	1265
345	1265
347	1265
348	1265
355	1265
363	1265
366	1265
367	1265
375	1265
396	1265
397	1265
392	1265
403	1265
391	1265
395	1265
424	1265
433	1265
455	1265
465	1265
492	1265
518	1265
545	1265
603	1265
337	1266
338	1266
346	1266
348	1266
349	1266
358	1266
359	1266
366	1266
367	1266
372	1266
379	1266
401	1266
391	1266
400	1266
433	1266
440	1266
438	1266
443	1266
449	1266
462	1266
490	1266
545	1266
341	1267
346	1267
348	1267
349	1267
355	1267
358	1267
366	1267
367	1267
375	1267
396	1267
397	1267
402	1267
403	1267
418	1267
433	1267
438	1267
448	1267
465	1267
467	1267
474	1267
482	1267
490	1267
545	1267
337	1268
338	1268
339	1268
348	1268
349	1268
352	1268
363	1268
370	1268
372	1268
388	1268
374	1268
376	1268
391	1268
405	1268
441	1268
457	1268
471	1268
472	1268
484	1268
509	1268
341	1269
344	1269
346	1269
347	1269
348	1269
349	1269
366	1269
367	1269
382	1269
384	1269
381	1269
379	1269
396	1269
392	1269
400	1269
424	1269
443	1269
449	1269
468	1269
470	1269
490	1269
518	1269
603	1269
337	1270
338	1270
346	1270
348	1270
352	1270
358	1270
371	1270
374	1270
379	1270
397	1270
402	1270
394	1270
391	1270
405	1270
429	1270
438	1270
457	1270
522	1270
545	1270
345	1271
347	1271
348	1271
349	1271
359	1271
362	1271
363	1271
366	1271
367	1271
382	1271
376	1271
384	1271
381	1271
396	1271
400	1271
433	1271
443	1271
441	1271
465	1271
467	1271
545	1271
583	1271
339	1272
341	1272
346	1272
348	1272
352	1272
355	1272
372	1272
396	1272
397	1272
392	1272
401	1272
391	1272
424	1272
433	1272
440	1272
457	1272
471	1272
472	1272
490	1272
492	1272
509	1272
545	1272
344	1273
346	1273
348	1273
349	1273
355	1273
358	1273
359	1273
363	1273
366	1273
367	1273
370	1273
375	1273
374	1273
402	1273
394	1273
391	1273
418	1273
438	1273
457	1273
465	1273
490	1273
545	1273
337	1274
338	1274
345	1274
346	1274
347	1274
348	1274
349	1274
366	1274
367	1274
371	1274
376	1274
384	1274
396	1274
405	1274
400	1274
441	1274
467	1274
471	1274
472	1274
474	1274
545	1274
339	1275
348	1275
349	1275
352	1275
358	1275
363	1275
372	1275
379	1275
396	1275
397	1275
401	1275
391	1275
424	1275
429	1275
438	1275
457	1275
465	1275
484	1275
492	1275
509	1275
545	1275
341	1276
347	1276
348	1276
352	1276
358	1276
363	1276
371	1276
376	1276
384	1276
396	1276
397	1276
391	1276
405	1276
424	1276
438	1276
443	1276
441	1276
448	1276
457	1276
468	1276
474	1276
482	1276
492	1276
339	1277
345	1277
346	1277
348	1277
349	1277
372	1277
375	1277
388	1277
374	1277
396	1277
402	1277
403	1277
394	1277
400	1277
424	1277
465	1277
509	1277
518	1277
545	1277
583	1277
603	1277
337	1278
338	1278
348	1278
349	1278
352	1278
363	1278
366	1278
367	1278
382	1278
381	1278
391	1278
419	1278
433	1278
449	1278
457	1278
471	1278
472	1278
484	1278
490	1278
347	1279
348	1279
349	1279
358	1279
359	1279
363	1279
372	1279
374	1279
384	1279
396	1279
397	1279
424	1279
455	1279
457	1279
465	1279
470	1279
472	1279
545	1279
337	1280
338	1280
339	1280
345	1280
346	1280
348	1280
349	1280
362	1280
366	1280
367	1280
388	1280
376	1280
379	1280
401	1280
405	1280
420	1280
443	1280
441	1280
484	1280
545	1280
339	1281
346	1281
348	1281
349	1281
358	1281
363	1281
366	1281
367	1281
372	1281
396	1281
392	1281
402	1281
391	1281
400	1281
418	1281
440	1281
438	1281
467	1281
474	1281
509	1281
545	1281
348	1282
349	1282
352	1282
359	1282
363	1282
366	1282
367	1282
370	1282
375	1282
388	1282
403	1282
399	1282
405	1282
420	1282
443	1282
472	1282
518	1282
603	1282
341	1283
347	1283
348	1283
349	1283
372	1283
382	1283
374	1283
384	1283
381	1283
397	1283
391	1283
424	1283
433	1283
441	1283
455	1283
457	1283
465	1283
471	1283
472	1283
509	1283
545	1283
337	1284
338	1284
339	1284
344	1284
345	1284
346	1284
348	1284
349	1284
355	1284
358	1284
366	1284
367	1284
376	1284
401	1284
394	1284
400	1284
438	1284
468	1284
490	1284
337	1285
338	1285
341	1285
346	1285
348	1285
349	1285
370	1285
372	1285
388	1285
376	1285
384	1285
379	1285
399	1285
405	1285
468	1285
471	1285
472	1285
474	1285
348	1286
352	1286
358	1286
363	1286
366	1286
367	1286
371	1286
388	1286
374	1286
397	1286
392	1286
402	1286
391	1286
418	1286
440	1286
438	1286
455	1286
484	1286
545	1286
583	1286
636	1286
339	1287
345	1287
348	1287
355	1287
359	1287
362	1287
363	1287
370	1287
372	1287
376	1287
392	1287
401	1287
433	1287
443	1287
441	1287
449	1287
457	1287
465	1287
341	1288
347	1288
348	1288
366	1288
367	1288
382	1288
384	1288
381	1288
394	1288
391	1288
400	1288
424	1288
448	1288
471	1288
472	1288
490	1288
509	1288
545	1288
337	1289
338	1289
346	1289
347	1289
348	1289
352	1289
366	1289
367	1289
370	1289
384	1289
392	1289
391	1289
405	1289
433	1289
443	1289
448	1289
449	1289
457	1289
468	1289
490	1289
545	1289
339	1290
345	1290
348	1290
349	1290
372	1290
375	1290
382	1290
388	1290
381	1290
397	1290
401	1290
403	1290
394	1290
399	1290
424	1290
441	1290
465	1290
471	1290
472	1290
337	1291
338	1291
348	1291
349	1291
355	1291
358	1291
359	1291
363	1291
366	1291
367	1291
374	1291
402	1291
391	1291
400	1291
429	1291
440	1291
438	1291
455	1291
457	1291
341	1292
344	1292
345	1292
347	1292
348	1292
370	1292
372	1292
374	1292
385	1292
379	1292
391	1292
395	1292
440	1292
468	1292
470	1292
471	1292
472	1292
484	1292
509	1292
348	1293
349	1293
358	1293
362	1293
366	1293
367	1293
371	1293
375	1293
382	1293
388	1293
381	1293
403	1293
399	1293
400	1293
433	1293
438	1293
457	1293
465	1293
339	1294
345	1294
346	1294
348	1294
352	1294
355	1294
363	1294
366	1294
367	1294
397	1294
401	1294
394	1294
391	1294
424	1294
440	1294
443	1294
441	1294
448	1294
467	1294
474	1294
545	1294
341	1295
347	1295
348	1295
352	1295
359	1295
370	1295
372	1295
374	1295
376	1295
384	1295
379	1295
424	1295
465	1295
470	1295
471	1295
472	1295
474	1295
484	1295
490	1295
545	1295
344	1296
346	1296
348	1296
355	1296
358	1296
362	1296
363	1296
366	1296
375	1296
402	1296
403	1296
391	1296
405	1296
400	1296
418	1296
438	1296
443	1296
455	1296
465	1296
337	1297
338	1297
339	1297
346	1297
348	1297
349	1297
352	1297
366	1297
372	1297
376	1297
397	1297
392	1297
401	1297
424	1297
433	1297
440	1297
441	1297
457	1297
471	1297
472	1297
509	1297
518	1297
603	1297
339	1298
346	1298
348	1298
352	1298
358	1298
366	1298
375	1298
382	1298
388	1298
381	1298
392	1298
401	1298
399	1298
400	1298
424	1298
440	1298
438	1298
449	1298
455	1298
465	1298
490	1298
637	1298
341	1299
346	1299
348	1299
349	1299
355	1299
359	1299
362	1299
363	1299
366	1299
370	1299
372	1299
374	1299
376	1299
384	1299
391	1299
405	1299
443	1299
441	1299
471	1299
472	1299
509	1299
341	1300
344	1300
347	1300
348	1300
349	1300
355	1300
370	1300
388	1300
376	1300
384	1300
392	1300
391	1300
399	1300
433	1300
429	1300
440	1300
443	1300
441	1300
471	1300
472	1300
484	1300
339	1301
348	1301
349	1301
358	1301
359	1301
362	1301
363	1301
371	1301
375	1301
374	1301
402	1301
403	1301
405	1301
400	1301
418	1301
438	1301
455	1301
457	1301
465	1301
341	1302
348	1302
352	1302
372	1302
382	1302
376	1302
384	1302
381	1302
379	1302
397	1302
401	1302
394	1302
391	1302
433	1302
440	1302
441	1302
449	1302
471	1302
472	1302
474	1302
484	1302
509	1302
339	1303
344	1303
348	1303
349	1303
372	1303
382	1303
374	1303
381	1303
402	1303
395	1303
400	1303
429	1303
440	1303
443	1303
449	1303
455	1303
470	1303
471	1303
472	1303
341	1304
347	1304
348	1304
352	1304
355	1304
358	1304
359	1304
362	1304
363	1304
370	1304
371	1304
374	1304
384	1304
391	1304
433	1304
438	1304
457	1304
465	1304
484	1304
509	1304
339	1305
348	1305
355	1305
375	1305
388	1305
376	1305
397	1305
392	1305
401	1305
403	1305
399	1305
441	1305
449	1305
465	1305
471	1305
472	1305
474	1305
518	1305
603	1305
337	1306
338	1306
344	1306
348	1306
349	1306
358	1306
362	1306
374	1306
402	1306
394	1306
391	1306
405	1306
400	1306
429	1306
457	1306
484	1306
490	1306
341	1307
347	1307
348	1307
355	1307
363	1307
382	1307
384	1307
381	1307
392	1307
395	1307
418	1307
424	1307
443	1307
449	1307
465	1307
471	1307
472	1307
484	1307
506	1307
509	1307
518	1307
603	1307
339	1308
348	1308
349	1308
352	1308
355	1308
358	1308
359	1308
372	1308
374	1308
376	1308
397	1308
401	1308
391	1308
433	1308
440	1308
438	1308
441	1308
455	1308
457	1308
484	1308
341	1309
348	1309
359	1309
362	1309
371	1309
382	1309
374	1309
381	1309
402	1309
405	1309
400	1309
418	1309
429	1309
443	1309
449	1309
583	1309
339	1310
344	1310
348	1310
370	1310
375	1310
388	1310
376	1310
401	1310
403	1310
394	1310
391	1310
399	1310
433	1310
440	1310
455	1310
465	1310
471	1310
472	1310
474	1310
518	1310
603	1310
341	1311
347	1311
348	1311
352	1311
358	1311
359	1311
363	1311
372	1311
384	1311
397	1311
392	1311
395	1311
424	1311
438	1311
449	1311
457	1311
484	1311
339	1312
348	1312
355	1312
359	1312
363	1312
372	1312
375	1312
382	1312
374	1312
376	1312
381	1312
392	1312
402	1312
403	1312
391	1312
400	1312
418	1312
429	1312
440	1312
457	1312
465	1312
471	1312
472	1312
484	1312
348	1313
352	1313
375	1313
382	1313
374	1313
376	1313
381	1313
403	1313
458	1313
465	1313
638	1313
347	1314
348	1314
355	1314
362	1314
371	1314
375	1314
376	1314
384	1314
377	1314
403	1314
405	1314
433	1314
457	1314
462	1314
465	1314
467	1314
470	1314
471	1314
472	1314
492	1314
515	1314
518	1314
603	1314
639	1314
337	1315
338	1315
341	1315
347	1315
348	1315
352	1315
362	1315
370	1315
372	1315
384	1315
379	1315
403	1315
424	1315
429	1315
465	1315
471	1315
472	1315
515	1315
518	1315
603	1315
639	1315
339	1316
348	1316
358	1316
363	1316
371	1316
382	1316
374	1316
381	1316
392	1316
401	1316
391	1316
405	1316
400	1316
418	1316
433	1316
438	1316
449	1316
509	1316
639	1316
337	1317
338	1317
344	1317
345	1317
348	1317
352	1317
355	1317
359	1317
375	1317
376	1317
402	1317
403	1317
424	1317
440	1317
443	1317
455	1317
457	1317
465	1317
470	1317
484	1317
507	1317
639	1317
345	1318
348	1318
372	1318
375	1318
382	1318
381	1318
379	1318
397	1318
403	1318
391	1318
433	1318
441	1318
457	1318
465	1318
470	1318
471	1318
472	1318
484	1318
509	1318
583	1318
337	1319
338	1319
339	1319
348	1319
352	1319
363	1319
375	1319
374	1319
397	1319
401	1319
403	1319
394	1319
391	1319
440	1319
441	1319
449	1319
465	1319
474	1319
490	1319
508	1319
639	1319
341	1320
345	1320
347	1320
348	1320
355	1320
358	1320
359	1320
362	1320
372	1320
388	1320
384	1320
397	1320
399	1320
440	1320
438	1320
443	1320
444	1320
441	1320
518	1320
603	1320
639	1320
337	1321
338	1321
339	1321
348	1321
371	1321
382	1321
381	1321
379	1321
401	1321
403	1321
391	1321
400	1321
420	1321
418	1321
424	1321
455	1321
471	1321
472	1321
484	1321
639	1321
341	1322
344	1322
347	1322
348	1322
358	1322
362	1322
363	1322
370	1322
372	1322
374	1322
384	1322
392	1322
391	1322
429	1322
438	1322
448	1322
457	1322
465	1322
508	1322
509	1322
339	1323
348	1323
352	1323
371	1323
375	1323
374	1323
403	1323
394	1323
391	1323
405	1323
413	1323
418	1323
424	1323
429	1323
443	1323
441	1323
449	1323
465	1323
470	1323
484	1323
344	1324
345	1324
362	1324
363	1324
372	1324
375	1324
402	1324
403	1324
391	1324
400	1324
418	1324
424	1324
440	1324
457	1324
465	1324
468	1324
470	1324
471	1324
472	1324
474	1324
509	1324
639	1324
339	1325
348	1325
352	1325
355	1325
358	1325
382	1325
381	1325
397	1325
392	1325
401	1325
403	1325
391	1325
420	1325
440	1325
438	1325
441	1325
484	1325
508	1325
639	1325
345	1326
347	1326
348	1326
355	1326
363	1326
374	1326
376	1326
384	1326
403	1326
395	1326
420	1326
470	1326
471	1326
472	1326
484	1326
490	1326
639	1326
339	1327
348	1327
358	1327
375	1327
397	1327
392	1327
401	1327
403	1327
391	1327
418	1327
440	1327
438	1327
444	1327
448	1327
449	1327
457	1327
465	1327
470	1327
482	1327
484	1327
509	1327
518	1327
530	1327
603	1327
341	1328
348	1328
352	1328
359	1328
363	1328
372	1328
374	1328
376	1328
405	1328
443	1328
445	1328
441	1328
455	1328
478	1328
508	1328
583	1328
339	1329
344	1329
345	1329
348	1329
358	1329
362	1329
363	1329
370	1329
374	1329
402	1329
403	1329
391	1329
420	1329
418	1329
429	1329
438	1329
441	1329
465	1329
468	1329
474	1329
639	1329
348	1330
355	1330
359	1330
375	1330
376	1330
379	1330
403	1330
394	1330
395	1330
400	1330
413	1330
414	1330
424	1330
440	1330
443	1330
448	1330
457	1330
465	1330
471	1330
472	1330
484	1330
490	1330
341	1331
347	1331
348	1331
358	1331
362	1331
372	1331
382	1331
388	1331
384	1331
381	1331
392	1331
391	1331
399	1331
400	1331
418	1331
438	1331
449	1331
455	1331
465	1331
518	1331
603	1331
339	1332
345	1332
348	1332
352	1332
355	1332
359	1332
374	1332
376	1332
397	1332
401	1332
403	1332
440	1332
443	1332
457	1332
465	1332
470	1332
484	1332
509	1332
639	1332
339	1333
344	1333
348	1333
349	1333
375	1333
379	1333
397	1333
392	1333
401	1333
391	1333
429	1333
440	1333
449	1333
455	1333
465	1333
471	1333
472	1333
478	1333
484	1333
490	1333
498	1333
639	1333
341	1334
347	1334
348	1334
352	1334
358	1334
362	1334
382	1334
384	1334
381	1334
403	1334
405	1334
400	1334
420	1334
413	1334
414	1334
418	1334
440	1334
438	1334
449	1334
465	1334
468	1334
484	1334
490	1334
513	1334
533	1334
639	1334
348	1335
352	1335
355	1335
359	1335
371	1335
375	1335
382	1335
374	1335
376	1335
384	1335
381	1335
403	1335
394	1335
391	1335
414	1335
424	1335
429	1335
440	1335
445	1335
457	1335
465	1335
471	1335
472	1335
484	1335
509	1335
637	1335
339	1336
344	1336
348	1336
355	1336
358	1336
359	1336
401	1336
391	1336
405	1336
400	1336
429	1336
438	1336
448	1336
455	1336
457	1336
484	1336
490	1336
508	1336
518	1336
569	1336
603	1336
639	1336
341	1337
345	1337
347	1337
348	1337
352	1337
362	1337
372	1337
375	1337
388	1337
384	1337
379	1337
397	1337
399	1337
424	1337
440	1337
441	1337
465	1337
471	1337
472	1337
474	1337
339	1338
348	1338
352	1338
355	1338
358	1338
359	1338
363	1338
382	1338
381	1338
401	1338
391	1338
400	1338
438	1338
455	1338
457	1338
484	1338
508	1338
639	1338
345	1339
347	1339
348	1339
362	1339
375	1339
374	1339
376	1339
384	1339
379	1339
397	1339
392	1339
403	1339
405	1339
441	1339
448	1339
449	1339
465	1339
471	1339
472	1339
484	1339
639	1339
344	1340
348	1340
349	1340
352	1340
358	1340
370	1340
382	1340
388	1340
381	1340
394	1340
391	1340
399	1340
395	1340
420	1340
418	1340
424	1340
440	1340
438	1340
443	1340
484	1340
509	1340
518	1340
603	1340
339	1341
348	1341
355	1341
375	1341
374	1341
376	1341
379	1341
392	1341
401	1341
403	1341
391	1341
405	1341
441	1341
465	1341
468	1341
471	1341
472	1341
484	1341
490	1341
509	1341
639	1341
341	1342
348	1342
358	1342
359	1342
371	1342
382	1342
381	1342
402	1342
400	1342
418	1342
429	1342
440	1342
438	1342
455	1342
457	1342
484	1342
508	1342
518	1342
603	1342
639	1342
344	1343
345	1343
347	1343
348	1343
355	1343
362	1343
363	1343
370	1343
372	1343
375	1343
384	1343
392	1343
403	1343
391	1343
424	1343
443	1343
465	1343
478	1343
639	1343
348	1344
349	1344
355	1344
359	1344
363	1344
374	1344
376	1344
384	1344
397	1344
403	1344
394	1344
405	1344
443	1344
449	1344
455	1344
471	1344
472	1344
474	1344
490	1344
509	1344
339	1345
348	1345
352	1345
358	1345
372	1345
375	1345
388	1345
379	1345
392	1345
401	1345
391	1345
399	1345
440	1345
438	1345
445	1345
441	1345
457	1345
465	1345
468	1345
484	1345
339	1346
348	1346
355	1346
358	1346
362	1346
382	1346
374	1346
376	1346
403	1346
394	1346
391	1346
405	1346
424	1346
429	1346
438	1346
455	1346
465	1346
484	1346
490	1346
637	1346
639	1346
341	1347
347	1347
348	1347
355	1347
359	1347
362	1347
372	1347
388	1347
376	1347
384	1347
379	1347
392	1347
391	1347
399	1347
440	1347
457	1347
484	1347
583	1347
339	1348
344	1348
345	1348
348	1348
349	1348
352	1348
358	1348
363	1348
375	1348
374	1348
397	1348
401	1348
394	1348
391	1348
395	1348
424	1348
438	1348
448	1348
465	1348
484	1348
490	1348
509	1348
348	1349
355	1349
388	1349
376	1349
384	1349
399	1349
440	1349
441	1349
457	1349
470	1349
471	1349
472	1349
478	1349
484	1349
518	1349
603	1349
640	1349
348	1350
358	1350
371	1350
382	1350
374	1350
381	1350
379	1350
402	1350
403	1350
405	1350
400	1350
418	1350
429	1350
438	1350
443	1350
449	1350
455	1350
484	1350
639	1350
339	1351
345	1351
347	1351
348	1351
349	1351
355	1351
359	1351
362	1351
375	1351
376	1351
401	1351
403	1351
420	1351
440	1351
441	1351
465	1351
471	1351
472	1351
474	1351
341	1352
344	1352
348	1352
349	1352
358	1352
363	1352
372	1352
382	1352
381	1352
397	1352
392	1352
402	1352
391	1352
438	1352
448	1352
457	1352
484	1352
508	1352
509	1352
583	1352
339	1353
348	1353
349	1353
352	1353
375	1353
376	1353
401	1353
403	1353
394	1353
400	1353
429	1353
443	1353
445	1353
449	1353
455	1353
465	1353
474	1353
484	1353
490	1353
639	1353
341	1354
345	1354
348	1354
349	1354
359	1354
362	1354
372	1354
388	1354
374	1354
384	1354
397	1354
391	1354
399	1354
424	1354
440	1354
441	1354
471	1354
472	1354
484	1354
509	1354
403	1355
420	1355
465	1355
341	1356
348	1356
352	1356
358	1356
362	1356
363	1356
382	1356
374	1356
381	1356
403	1356
391	1356
438	1356
445	1356
441	1356
490	1356
636	1356
637	1356
639	1356
641	1356
339	1357
348	1357
370	1357
372	1357
375	1357
376	1357
402	1357
403	1357
405	1357
418	1357
424	1357
429	1357
457	1357
465	1357
469	1357
468	1357
478	1357
484	1357
637	1357
641	1357
345	1358
348	1358
352	1358
355	1358
359	1358
388	1358
397	1358
394	1358
391	1358
399	1358
440	1358
443	1358
448	1358
449	1358
490	1358
509	1358
518	1358
583	1358
603	1358
341	1359
344	1359
347	1359
348	1359
358	1359
375	1359
384	1359
379	1359
403	1359
391	1359
400	1359
429	1359
438	1359
441	1359
455	1359
457	1359
465	1359
474	1359
484	1359
639	1359
339	1360
348	1360
359	1360
362	1360
372	1360
382	1360
374	1360
381	1360
401	1360
403	1360
424	1360
440	1360
471	1360
472	1360
484	1360
640	1360
344	1361
348	1361
349	1361
355	1361
363	1361
370	1361
371	1361
375	1361
382	1361
403	1361
391	1361
395	1361
440	1361
443	1361
444	1361
449	1361
455	1361
457	1361
465	1361
468	1361
637	1361
642	1361
339	1362
347	1362
348	1362
349	1362
362	1362
374	1362
401	1362
403	1362
394	1362
405	1362
424	1362
438	1362
471	1362
474	1362
484	1362
637	1362
341	1363
344	1363
348	1363
349	1363
352	1363
358	1363
363	1363
382	1363
381	1363
397	1363
391	1363
418	1363
429	1363
440	1363
441	1363
508	1363
509	1363
637	1363
339	1364
348	1364
362	1364
371	1364
382	1364
374	1364
381	1364
401	1364
403	1364
391	1364
405	1364
441	1364
448	1364
457	1364
465	1364
484	1364
518	1364
603	1364
341	1365
347	1365
348	1365
349	1365
352	1365
355	1365
374	1365
384	1365
397	1365
391	1365
399	1365
405	1365
443	1365
441	1365
455	1365
465	1365
474	1365
490	1365
498	1365
639	1365
339	1366
348	1366
349	1366
363	1366
372	1366
392	1366
401	1366
403	1366
418	1366
424	1366
429	1366
440	1366
444	1366
457	1366
471	1366
472	1366
484	1366
640	1366
339	1367
341	1367
347	1367
348	1367
363	1367
371	1367
375	1367
388	1367
401	1367
391	1367
405	1367
400	1367
418	1367
424	1367
443	1367
448	1367
465	1367
468	1367
474	1367
478	1367
530	1367
345	1368
348	1368
349	1368
352	1368
358	1368
359	1368
362	1368
372	1368
382	1368
374	1368
376	1368
381	1368
379	1368
397	1368
440	1368
438	1368
441	1368
455	1368
482	1368
490	1368
498	1368
508	1368
583	1368
339	1369
341	1369
344	1369
348	1369
349	1369
363	1369
401	1369
400	1369
424	1369
429	1369
440	1369
444	1369
448	1369
449	1369
455	1369
457	1369
474	1369
508	1369
509	1369
518	1369
603	1369
345	1370
348	1370
352	1370
363	1370
370	1370
382	1370
381	1370
379	1370
394	1370
391	1370
405	1370
441	1370
457	1370
468	1370
471	1370
472	1370
530	1370
583	1370
339	1371
347	1371
348	1371
358	1371
359	1371
362	1371
363	1371
375	1371
374	1371
384	1371
400	1371
418	1371
440	1371
438	1371
465	1371
490	1371
339	1372
341	1372
348	1372
349	1372
352	1372
358	1372
362	1372
372	1372
376	1372
401	1372
391	1372
424	1372
440	1372
438	1372
445	1372
441	1372
455	1372
509	1372
339	1373
341	1373
348	1373
352	1373
358	1373
359	1373
372	1373
375	1373
374	1373
392	1373
401	1373
405	1373
440	1373
438	1373
445	1373
448	1373
457	1373
465	1373
474	1373
498	1373
341	1374
347	1374
348	1374
349	1374
352	1374
358	1374
359	1374
362	1374
388	1374
399	1374
440	1374
438	1374
457	1374
478	1374
518	1374
530	1374
583	1374
603	1374
339	1375
345	1375
348	1375
382	1375
374	1375
376	1375
381	1375
379	1375
402	1375
395	1375
405	1375
443	1375
441	1375
448	1375
471	1375
472	1375
474	1375
490	1375
507	1375
339	1376
341	1376
345	1376
348	1376
352	1376
358	1376
372	1376
385	1376
392	1376
401	1376
399	1376
440	1376
438	1376
445	1376
457	1376
474	1376
478	1376
509	1376
344	1377
347	1377
348	1377
371	1377
375	1377
374	1377
384	1377
379	1377
397	1377
391	1377
395	1377
405	1377
443	1377
441	1377
448	1377
455	1377
465	1377
508	1377
348	1378
352	1378
359	1378
362	1378
370	1378
382	1378
381	1378
394	1378
391	1378
440	1378
441	1378
457	1378
471	1378
472	1378
482	1378
490	1378
508	1378
518	1378
530	1378
583	1378
603	1378
339	1379
345	1379
348	1379
358	1379
363	1379
372	1379
375	1379
374	1379
385	1379
401	1379
405	1379
400	1379
418	1379
438	1379
441	1379
465	1379
468	1379
478	1379
509	1379
341	1380
348	1380
349	1380
352	1380
362	1380
363	1380
388	1380
376	1380
397	1380
391	1380
395	1380
440	1380
443	1380
455	1380
457	1380
474	1380
530	1380
583	1380
339	1381
348	1381
359	1381
362	1381
372	1381
382	1381
374	1381
376	1381
381	1381
379	1381
397	1381
392	1381
402	1381
418	1381
440	1381
444	1381
448	1381
449	1381
471	1381
472	1381
569	1381
341	1382
347	1382
348	1382
358	1382
363	1382
371	1382
384	1382
394	1382
391	1382
405	1382
400	1382
429	1382
438	1382
441	1382
457	1382
478	1382
508	1382
642	1382
339	1383
345	1383
348	1383
352	1383
370	1383
375	1383
376	1383
392	1383
401	1383
424	1383
440	1383
443	1383
448	1383
455	1383
465	1383
474	1383
509	1383
518	1383
530	1383
603	1383
345	1384
347	1384
348	1384
352	1384
358	1384
362	1384
382	1384
376	1384
381	1384
379	1384
397	1384
392	1384
424	1384
440	1384
438	1384
465	1384
468	1384
478	1384
530	1384
339	1385
348	1385
352	1385
359	1385
363	1385
371	1385
375	1385
374	1385
401	1385
391	1385
405	1385
400	1385
441	1385
455	1385
457	1385
465	1385
478	1385
518	1385
603	1385
341	1386
344	1386
348	1386
349	1386
370	1386
372	1386
376	1386
384	1386
379	1386
392	1386
395	1386
424	1386
448	1386
449	1386
468	1386
471	1386
472	1386
474	1386
530	1386
569	1386
339	1387
341	1387
345	1387
348	1387
358	1387
362	1387
363	1387
375	1387
376	1387
402	1387
400	1387
418	1387
440	1387
438	1387
441	1387
455	1387
465	1387
478	1387
530	1387
341	1388
347	1388
348	1388
359	1388
372	1388
381	1388
394	1388
391	1388
429	1388
440	1388
443	1388
448	1388
457	1388
508	1388
518	1388
583	1388
603	1388
339	1389
341	1389
345	1389
348	1389
349	1389
372	1389
382	1389
374	1389
381	1389
401	1389
391	1389
405	1389
444	1389
441	1389
448	1389
471	1389
472	1389
474	1389
509	1389
348	1390
352	1390
362	1390
363	1390
371	1390
375	1390
385	1390
376	1390
384	1390
392	1390
399	1390
419	1390
440	1390
443	1390
455	1390
465	1390
642	1390
341	1391
348	1391
349	1391
358	1391
359	1391
379	1391
397	1391
405	1391
418	1391
424	1391
438	1391
441	1391
448	1391
449	1391
457	1391
474	1391
490	1391
505	1391
583	1391
339	1392
344	1392
348	1392
372	1392
375	1392
374	1392
401	1392
394	1392
391	1392
395	1392
400	1392
440	1392
441	1392
448	1392
465	1392
471	1392
472	1392
478	1392
508	1392
518	1392
569	1392
603	1392
341	1393
347	1393
348	1393
358	1393
359	1393
362	1393
363	1393
375	1393
382	1393
381	1393
392	1393
391	1393
405	1393
438	1393
444	1393
457	1393
465	1393
490	1393
642	1393
345	1394
348	1394
372	1394
388	1394
374	1394
376	1394
379	1394
397	1394
392	1394
395	1394
424	1394
440	1394
443	1394
441	1394
448	1394
449	1394
455	1394
474	1394
583	1394
339	1395
341	1395
348	1395
358	1395
363	1395
371	1395
382	1395
381	1395
401	1395
399	1395
405	1395
438	1395
443	1395
457	1395
478	1395
509	1395
518	1395
603	1395
345	1396
347	1396
348	1396
352	1396
359	1396
374	1396
384	1396
379	1396
397	1396
394	1396
391	1396
424	1396
429	1396
441	1396
465	1396
471	1396
472	1396
474	1396
490	1396
339	1397
341	1397
348	1397
358	1397
362	1397
372	1397
375	1397
376	1397
402	1397
400	1397
418	1397
440	1397
438	1397
448	1397
455	1397
465	1397
478	1397
518	1397
603	1397
341	1398
344	1398
348	1398
359	1398
362	1398
363	1398
372	1398
375	1398
382	1398
376	1398
381	1398
392	1398
391	1398
400	1398
418	1398
440	1398
443	1398
465	1398
474	1398
642	1398
341	1399
347	1399
352	1399
358	1399
359	1399
363	1399
371	1399
374	1399
384	1399
397	1399
395	1399
440	1399
449	1399
455	1399
471	1399
505	1399
508	1399
583	1399
339	1400
376	1400
384	1400
379	1400
377	1400
392	1400
401	1400
394	1400
438	1400
443	1400
441	1400
457	1400
465	1400
472	1400
474	1400
482	1400
490	1400
509	1400
339	1401
341	1401
345	1401
358	1401
362	1401
374	1401
379	1401
402	1401
405	1401
400	1401
418	1401
429	1401
468	1401
471	1401
478	1401
642	1401
341	1402
344	1402
347	1402
359	1402
382	1402
385	1402
376	1402
384	1402
381	1402
397	1402
391	1402
399	1402
443	1402
455	1402
465	1402
509	1402
339	1403
363	1403
370	1403
375	1403
388	1403
392	1403
401	1403
424	1403
440	1403
438	1403
441	1403
448	1403
449	1403
457	1403
465	1403
472	1403
474	1403
490	1403
518	1403
603	1403
341	1404
345	1404
347	1404
348	1404
352	1404
359	1404
372	1404
375	1404
374	1404
379	1404
391	1404
395	1404
414	1404
418	1404
440	1404
443	1404
441	1404
448	1404
465	1404
474	1404
643	1404
339	1405
347	1405
358	1405
362	1405
370	1405
374	1405
376	1405
384	1405
399	1405
395	1405
405	1405
440	1405
441	1405
449	1405
471	1405
518	1405
603	1405
339	1406
344	1406
345	1406
348	1406
372	1406
375	1406
379	1406
397	1406
402	1406
394	1406
391	1406
395	1406
418	1406
424	1406
440	1406
448	1406
455	1406
457	1406
465	1406
478	1406
341	1407
347	1407
362	1407
375	1407
376	1407
384	1407
379	1407
392	1407
405	1407
400	1407
438	1407
448	1407
465	1407
472	1407
478	1407
642	1407
339	1408
341	1408
345	1408
352	1408
358	1408
363	1408
371	1408
374	1408
385	1408
401	1408
394	1408
448	1408
455	1408
457	1408
471	1408
509	1408
344	1409
348	1409
362	1409
375	1409
392	1409
399	1409
405	1409
400	1409
440	1409
438	1409
449	1409
455	1409
465	1409
472	1409
508	1409
518	1409
583	1409
603	1409
642	1409
341	1410
347	1410
349	1410
352	1410
385	1410
376	1410
384	1410
392	1410
391	1410
414	1410
438	1410
443	1410
448	1410
457	1410
509	1410
642	1410
339	1411
345	1411
348	1411
358	1411
362	1411
363	1411
372	1411
375	1411
388	1411
374	1411
376	1411
379	1411
392	1411
402	1411
400	1411
418	1411
440	1411
455	1411
465	1411
472	1411
478	1411
642	1411
339	1412
341	1412
344	1412
348	1412
349	1412
374	1412
405	1412
418	1412
438	1412
449	1412
457	1412
465	1412
471	1412
490	1412
518	1412
603	1412
642	1412
341	1413
345	1413
348	1413
352	1413
358	1413
371	1413
374	1413
385	1413
376	1413
384	1413
391	1413
424	1413
440	1413
443	1413
457	1413
472	1413
583	1413
642	1413
339	1414
344	1414
348	1414
359	1414
363	1414
384	1414
394	1414
391	1414
418	1414
424	1414
438	1414
448	1414
457	1414
471	1414
490	1414
518	1414
603	1414
344	1415
348	1415
352	1415
358	1415
359	1415
362	1415
371	1415
382	1415
374	1415
381	1415
379	1415
394	1415
405	1415
400	1415
420	1415
440	1415
518	1415
569	1415
603	1415
339	1416
341	1416
358	1416
372	1416
385	1416
376	1416
401	1416
399	1416
395	1416
405	1416
414	1416
438	1416
441	1416
448	1416
457	1416
465	1416
468	1416
474	1416
337	1417
338	1417
347	1417
348	1417
352	1417
359	1417
375	1417
374	1417
384	1417
394	1417
391	1417
424	1417
429	1417
457	1417
465	1417
471	1417
478	1417
490	1417
506	1417
509	1417
642	1417
339	1418
341	1418
344	1418
345	1418
362	1418
375	1418
382	1418
376	1418
381	1418
379	1418
392	1418
402	1418
400	1418
440	1418
443	1418
441	1418
448	1418
455	1418
457	1418
465	1418
482	1418
518	1418
603	1418
341	1419
344	1419
348	1419
352	1419
358	1419
359	1419
362	1419
382	1419
374	1419
376	1419
381	1419
379	1419
391	1419
399	1419
400	1419
414	1419
448	1419
465	1419
472	1419
490	1419
505	1419
642	1419
339	1420
341	1420
348	1420
363	1420
371	1420
374	1420
397	1420
401	1420
402	1420
391	1420
399	1420
405	1420
418	1420
438	1420
448	1420
455	1420
457	1420
471	1420
478	1420
339	1421
341	1421
345	1421
348	1421
370	1421
375	1421
385	1421
384	1421
392	1421
401	1421
391	1421
418	1421
444	1421
465	1421
478	1421
482	1421
490	1421
505	1421
642	1421
339	1422
341	1422
344	1422
347	1422
358	1422
382	1422
381	1422
414	1422
424	1422
440	1422
438	1422
455	1422
457	1422
465	1422
468	1422
474	1422
509	1422
515	1422
518	1422
603	1422
642	1422
339	1423
344	1423
347	1423
348	1423
359	1423
362	1423
372	1423
374	1423
376	1423
379	1423
400	1423
418	1423
440	1423
443	1423
441	1423
448	1423
457	1423
515	1423
341	1424
348	1424
358	1424
359	1424
363	1424
376	1424
384	1424
377	1424
391	1424
400	1424
418	1424
441	1424
455	1424
471	1424
490	1424
509	1424
518	1424
603	1424
339	1425
348	1425
352	1425
362	1425
371	1425
375	1425
374	1425
385	1425
397	1425
401	1425
394	1425
391	1425
405	1425
414	1425
443	1425
448	1425
457	1425
465	1425
468	1425
478	1425
513	1425
515	1425
341	1426
345	1426
348	1426
352	1426
359	1426
363	1426
370	1426
376	1426
392	1426
402	1426
420	1426
424	1426
440	1426
438	1426
445	1426
455	1426
472	1426
509	1426
518	1426
603	1426
642	1426
339	1427
345	1427
347	1427
348	1427
362	1427
372	1427
382	1427
381	1427
379	1427
397	1427
394	1427
391	1427
418	1427
424	1427
429	1427
440	1427
448	1427
465	1427
642	1427
341	1428
344	1428
347	1428
352	1428
370	1428
371	1428
375	1428
385	1428
405	1428
414	1428
438	1428
441	1428
457	1428
465	1428
468	1428
471	1428
509	1428
642	1428
348	1429
358	1429
359	1429
362	1429
375	1429
374	1429
376	1429
384	1429
379	1429
377	1429
406	1429
392	1429
394	1429
391	1429
399	1429
400	1429
440	1429
443	1429
455	1429
465	1429
339	1430
341	1430
344	1430
348	1430
358	1430
359	1430
362	1430
363	1430
376	1430
397	1430
392	1430
402	1430
405	1430
418	1430
424	1430
443	1430
444	1430
455	1430
490	1430
498	1430
509	1430
518	1430
603	1430
339	1431
352	1431
363	1431
388	1431
386	1431
374	1431
385	1431
387	1431
401	1431
400	1431
440	1431
443	1431
441	1431
448	1431
583	1431
642	1431
339	1432
341	1432
344	1432
345	1432
347	1432
348	1432
382	1432
381	1432
379	1432
392	1432
402	1432
420	1432
424	1432
429	1432
440	1432
448	1432
457	1432
509	1432
518	1432
603	1432
341	1433
347	1433
348	1433
363	1433
371	1433
374	1433
385	1433
376	1433
384	1433
377	1433
399	1433
405	1433
400	1433
438	1433
443	1433
444	1433
441	1433
468	1433
505	1433
509	1433
642	1433
339	1434
348	1434
352	1434
359	1434
362	1434
375	1434
374	1434
379	1434
397	1434
401	1434
394	1434
391	1434
407	1434
424	1434
440	1434
448	1434
457	1434
465	1434
509	1434
341	1435
344	1435
348	1435
363	1435
382	1435
374	1435
385	1435
384	1435
381	1435
377	1435
392	1435
405	1435
400	1435
420	1435
418	1435
443	1435
490	1435
505	1435
569	1435
642	1435
339	1436
345	1436
348	1436
352	1436
359	1436
363	1436
375	1436
376	1436
379	1436
397	1436
401	1436
391	1436
424	1436
440	1436
441	1436
448	1436
465	1436
472	1436
478	1436
509	1436
583	1436
339	1437
341	1437
344	1437
348	1437
363	1437
370	1437
388	1437
385	1437
402	1437
399	1437
407	1437
429	1437
443	1437
445	1437
457	1437
468	1437
471	1437
474	1437
490	1437
339	1438
345	1438
348	1438
352	1438
358	1438
359	1438
362	1438
372	1438
375	1438
374	1438
376	1438
379	1438
401	1438
394	1438
391	1438
400	1438
440	1438
441	1438
448	1438
465	1438
509	1438
339	1439
341	1439
344	1439
347	1439
352	1439
358	1439
362	1439
375	1439
379	1439
401	1439
402	1439
394	1439
391	1439
399	1439
424	1439
441	1439
457	1439
465	1439
509	1439
339	1440
341	1440
345	1440
347	1440
348	1440
352	1440
363	1440
371	1440
372	1440
388	1440
386	1440
374	1440
387	1440
379	1440
394	1440
399	1440
405	1440
414	1440
457	1440
509	1440
569	1440
642	1440
339	1441
348	1441
352	1441
375	1441
376	1441
406	1441
392	1441
401	1441
391	1441
395	1441
400	1441
418	1441
429	1441
445	1441
449	1441
465	1441
468	1441
470	1441
472	1441
490	1441
518	1441
603	1441
642	1441
339	1442
341	1442
347	1442
348	1442
359	1442
362	1442
372	1442
375	1442
382	1442
374	1442
381	1442
379	1442
402	1442
419	1442
407	1442
440	1442
443	1442
441	1442
455	1442
457	1442
465	1442
569	1442
339	1443
341	1443
347	1443
348	1443
352	1443
359	1443
362	1443
371	1443
388	1443
374	1443
384	1443
379	1443
392	1443
401	1443
391	1443
424	1443
443	1443
441	1443
455	1443
465	1443
474	1443
506	1443
518	1443
603	1443
339	1444
341	1444
347	1444
352	1444
359	1444
371	1444
372	1444
375	1444
374	1444
376	1444
384	1444
392	1444
391	1444
395	1444
400	1444
424	1444
429	1444
455	1444
465	1444
339	1445
341	1445
347	1445
352	1445
363	1445
375	1445
376	1445
379	1445
392	1445
401	1445
391	1445
407	1445
429	1445
440	1445
438	1445
445	1445
457	1445
470	1445
471	1445
492	1445
642	1445
339	1446
345	1446
348	1446
372	1446
382	1446
374	1446
381	1446
377	1446
392	1446
402	1446
394	1446
399	1446
400	1446
418	1446
424	1446
440	1446
441	1446
472	1446
509	1446
518	1446
603	1446
339	1447
341	1447
347	1447
362	1447
388	1447
386	1447
387	1447
379	1447
392	1447
401	1447
391	1447
405	1447
400	1447
419	1447
429	1447
443	1447
441	1447
465	1447
468	1447
518	1447
569	1447
583	1447
603	1447
642	1447
339	1448
341	1448
345	1448
348	1448
352	1448
358	1448
359	1448
371	1448
372	1448
375	1448
382	1448
374	1448
376	1448
381	1448
392	1448
402	1448
395	1448
414	1448
418	1448
470	1448
507	1448
509	1448
339	1449
341	1449
347	1449
348	1449
376	1449
384	1449
377	1449
394	1449
395	1449
407	1449
424	1449
429	1449
443	1449
441	1449
457	1449
468	1449
506	1449
583	1449
339	1450
345	1450
348	1450
362	1450
363	1450
370	1450
374	1450
379	1450
406	1450
401	1450
391	1450
418	1450
440	1450
470	1450
472	1450
474	1450
478	1450
492	1450
518	1450
603	1450
339	1451
341	1451
347	1451
348	1451
359	1451
375	1451
382	1451
374	1451
376	1451
384	1451
381	1451
392	1451
391	1451
399	1451
405	1451
400	1451
438	1451
443	1451
457	1451
465	1451
470	1451
492	1451
509	1451
642	1451
339	1452
341	1452
348	1452
352	1452
359	1452
375	1452
376	1452
392	1452
401	1452
391	1452
395	1452
405	1452
414	1452
407	1452
444	1452
465	1452
470	1452
474	1452
518	1452
569	1452
583	1452
603	1452
339	1453
341	1453
345	1453
348	1453
362	1453
370	1453
371	1453
372	1453
375	1453
382	1453
381	1453
379	1453
392	1453
391	1453
418	1453
443	1453
445	1453
457	1453
468	1453
470	1453
339	1454
341	1454
345	1454
347	1454
348	1454
352	1454
358	1454
359	1454
375	1454
374	1454
384	1454
392	1454
391	1454
399	1454
441	1454
490	1454
507	1454
509	1454
583	1454
642	1454
339	1455
341	1455
363	1455
382	1455
374	1455
381	1455
406	1455
392	1455
394	1455
400	1455
407	1455
424	1455
429	1455
440	1455
438	1455
443	1455
441	1455
457	1455
465	1455
468	1455
509	1455
518	1455
603	1455
339	1456
345	1456
348	1456
352	1456
359	1456
375	1456
388	1456
386	1456
387	1456
379	1456
392	1456
405	1456
418	1456
407	1456
438	1456
441	1456
465	1456
472	1456
474	1456
507	1456
642	1456
339	1457
352	1457
363	1457
371	1457
382	1457
374	1457
381	1457
392	1457
394	1457
391	1457
395	1457
419	1457
414	1457
443	1457
471	1457
509	1457
518	1457
583	1457
603	1457
339	1458
341	1458
345	1458
347	1458
348	1458
359	1458
362	1458
363	1458
372	1458
375	1458
374	1458
379	1458
377	1458
401	1458
391	1458
399	1458
400	1458
440	1458
438	1458
441	1458
339	1459
359	1459
363	1459
375	1459
382	1459
381	1459
379	1459
405	1459
414	1459
424	1459
429	1459
443	1459
441	1459
457	1459
465	1459
471	1459
490	1459
518	1459
603	1459
339	1460
345	1460
347	1460
363	1460
382	1460
384	1460
381	1460
392	1460
391	1460
399	1460
438	1460
457	1460
478	1460
507	1460
509	1460
583	1460
339	1461
341	1461
352	1461
358	1461
362	1461
363	1461
375	1461
374	1461
379	1461
401	1461
395	1461
400	1461
407	1461
424	1461
429	1461
440	1461
441	1461
465	1461
474	1461
515	1461
518	1461
603	1461
339	1462
341	1462
345	1462
348	1462
359	1462
384	1462
406	1462
392	1462
418	1462
443	1462
468	1462
478	1462
507	1462
509	1462
515	1462
518	1462
583	1462
603	1462
642	1462
339	1463
347	1463
352	1463
358	1463
362	1463
363	1463
370	1463
371	1463
375	1463
382	1463
381	1463
379	1463
399	1463
414	1463
424	1463
441	1463
449	1463
457	1463
465	1463
471	1463
339	1464
341	1464
345	1464
348	1464
359	1464
388	1464
386	1464
381	1464
387	1464
379	1464
377	1464
392	1464
394	1464
391	1464
400	1464
407	1464
429	1464
440	1464
438	1464
443	1464
445	1464
509	1464
339	1465
341	1465
347	1465
382	1465
381	1465
379	1465
394	1465
391	1465
399	1465
395	1465
419	1465
424	1465
429	1465
443	1465
457	1465
465	1465
468	1465
490	1465
339	1466
341	1466
345	1466
358	1466
359	1466
362	1466
363	1466
370	1466
375	1466
401	1466
399	1466
405	1466
438	1466
465	1466
478	1466
583	1466
341	1467
347	1467
348	1467
363	1467
372	1467
382	1467
384	1467
381	1467
379	1467
392	1467
391	1467
400	1467
443	1467
441	1467
457	1467
471	1467
474	1467
509	1467
518	1467
603	1467
339	1468
345	1468
352	1468
358	1468
371	1468
375	1468
382	1468
388	1468
386	1468
381	1468
387	1468
379	1468
394	1468
391	1468
395	1468
429	1468
440	1468
445	1468
449	1468
468	1468
339	1469
341	1469
347	1469
359	1469
363	1469
382	1469
384	1469
381	1469
377	1469
399	1469
424	1469
443	1469
441	1469
457	1469
478	1469
583	1469
641	1469
339	1470
341	1470
345	1470
347	1470
363	1470
370	1470
372	1470
381	1470
392	1470
391	1470
395	1470
414	1470
418	1470
424	1470
440	1470
443	1470
441	1470
468	1470
508	1470
339	1471
341	1471
347	1471
359	1471
371	1471
375	1471
388	1471
384	1471
401	1471
394	1471
405	1471
400	1471
407	1471
438	1471
457	1471
471	1471
509	1471
583	1471
339	1472
341	1472
345	1472
347	1472
348	1472
352	1472
382	1472
381	1472
392	1472
391	1472
399	1472
414	1472
407	1472
424	1472
429	1472
440	1472
441	1472
449	1472
465	1472
474	1472
644	1472
339	1473
341	1473
347	1473
348	1473
352	1473
381	1473
379	1473
394	1473
391	1473
399	1473
405	1473
419	1473
414	1473
443	1473
441	1473
465	1473
468	1473
490	1473
339	1474
341	1474
347	1474
359	1474
363	1474
372	1474
388	1474
386	1474
384	1474
387	1474
379	1474
377	1474
401	1474
391	1474
424	1474
429	1474
440	1474
471	1474
509	1474
583	1474
341	1475
348	1475
352	1475
363	1475
371	1475
375	1475
386	1475
384	1475
381	1475
387	1475
401	1475
405	1475
400	1475
419	1475
407	1475
424	1475
440	1475
457	1475
465	1475
471	1475
509	1475
533	1475
341	1476
348	1476
375	1476
388	1476
379	1476
401	1476
402	1476
394	1476
391	1476
395	1476
405	1476
418	1476
424	1476
429	1476
449	1476
471	1476
478	1476
507	1476
515	1476
518	1476
603	1476
341	1477
345	1477
359	1477
363	1477
381	1477
379	1477
391	1477
399	1477
400	1477
424	1477
440	1477
438	1477
443	1477
441	1477
457	1477
468	1477
474	1477
490	1477
509	1477
583	1477
341	1478
345	1478
348	1478
362	1478
363	1478
370	1478
384	1478
377	1478
392	1478
394	1478
405	1478
400	1478
418	1478
424	1478
443	1478
468	1478
471	1478
490	1478
515	1478
583	1478
341	1479
345	1479
348	1479
352	1479
359	1479
371	1479
372	1479
388	1479
386	1479
381	1479
387	1479
391	1479
399	1479
414	1479
424	1479
429	1479
457	1479
509	1479
518	1479
603	1479
341	1480
352	1480
384	1480
381	1480
379	1480
377	1480
394	1480
391	1480
429	1480
440	1480
443	1480
457	1480
465	1480
468	1480
478	1480
507	1480
583	1480
341	1481
348	1481
362	1481
370	1481
385	1481
379	1481
392	1481
405	1481
418	1481
438	1481
449	1481
455	1481
478	1481
515	1481
583	1481
341	1482
345	1482
348	1482
362	1482
363	1482
371	1482
372	1482
375	1482
388	1482
386	1482
381	1482
387	1482
377	1482
392	1482
424	1482
438	1482
445	1482
449	1482
471	1482
474	1482
515	1482
583	1482
341	1483
348	1483
352	1483
378	1483
381	1483
379	1483
391	1483
400	1483
419	1483
414	1483
429	1483
440	1483
443	1483
441	1483
449	1483
457	1483
468	1483
478	1483
518	1483
603	1483
341	1484
345	1484
348	1484
359	1484
362	1484
375	1484
385	1484
384	1484
377	1484
401	1484
391	1484
438	1484
445	1484
449	1484
455	1484
482	1484
490	1484
507	1484
583	1484
645	1484
341	1485
348	1485
363	1485
372	1485
388	1485
386	1485
387	1485
379	1485
392	1485
394	1485
395	1485
400	1485
418	1485
424	1485
440	1485
443	1485
449	1485
457	1485
509	1485
515	1485
518	1485
603	1485
345	1486
348	1486
352	1486
375	1486
385	1486
381	1486
392	1486
394	1486
391	1486
399	1486
405	1486
414	1486
429	1486
441	1486
449	1486
468	1486
471	1486
518	1486
583	1486
603	1486
646	1486
341	1487
345	1487
348	1487
359	1487
363	1487
370	1487
372	1487
388	1487
386	1487
384	1487
387	1487
379	1487
394	1487
391	1487
395	1487
424	1487
429	1487
440	1487
438	1487
457	1487
515	1487
518	1487
341	1488
345	1488
348	1488
378	1488
388	1488
386	1488
387	1488
379	1488
392	1488
401	1488
391	1488
399	1488
400	1488
419	1488
418	1488
443	1488
457	1488
468	1488
478	1488
492	1488
518	1488
583	1488
603	1488
341	1489
348	1489
352	1489
388	1489
386	1489
381	1489
387	1489
379	1489
377	1489
394	1489
391	1489
395	1489
405	1489
418	1489
429	1489
438	1489
457	1489
474	1489
478	1489
490	1489
509	1489
583	1489
341	1490
345	1490
348	1490
359	1490
363	1490
372	1490
384	1490
392	1490
394	1490
391	1490
399	1490
405	1490
400	1490
424	1490
440	1490
438	1490
445	1490
455	1490
457	1490
471	1490
509	1490
515	1490
518	1490
603	1490
341	1491
345	1491
348	1491
352	1491
359	1491
370	1491
385	1491
381	1491
379	1491
377	1491
394	1491
391	1491
399	1491
395	1491
405	1491
400	1491
414	1491
418	1491
455	1491
457	1491
471	1491
490	1491
515	1491
518	1491
603	1491
341	1492
348	1492
352	1492
363	1492
371	1492
372	1492
401	1492
391	1492
399	1492
418	1492
424	1492
429	1492
438	1492
445	1492
441	1492
471	1492
490	1492
507	1492
341	1493
345	1493
348	1493
363	1493
372	1493
384	1493
381	1493
379	1493
377	1493
392	1493
395	1493
405	1493
440	1493
438	1493
441	1493
457	1493
471	1493
482	1493
485	1493
492	1493
646	1493
647	1493
341	1494
348	1494
362	1494
385	1494
384	1494
381	1494
379	1494
377	1494
392	1494
401	1494
391	1494
400	1494
418	1494
424	1494
429	1494
457	1494
471	1494
474	1494
490	1494
509	1494
341	1495
345	1495
348	1495
352	1495
370	1495
378	1495
385	1495
379	1495
399	1495
405	1495
414	1495
438	1495
441	1495
478	1495
492	1495
513	1495
515	1495
583	1495
341	1496
345	1496
348	1496
359	1496
363	1496
372	1496
388	1496
386	1496
387	1496
379	1496
377	1496
392	1496
391	1496
395	1496
400	1496
424	1496
429	1496
440	1496
455	1496
457	1496
518	1496
583	1496
603	1496
341	1497
345	1497
348	1497
352	1497
359	1497
371	1497
372	1497
384	1497
379	1497
377	1497
392	1497
395	1497
414	1497
441	1497
455	1497
457	1497
471	1497
515	1497
518	1497
603	1497
648	1497
345	1498
348	1498
359	1498
381	1498
379	1498
377	1498
401	1498
400	1498
424	1498
440	1498
457	1498
492	1498
509	1498
518	1498
583	1498
603	1498
341	1499
345	1499
348	1499
362	1499
372	1499
388	1499
386	1499
385	1499
387	1499
392	1499
405	1499
400	1499
438	1499
457	1499
474	1499
482	1499
515	1499
518	1499
603	1499
341	1500
345	1500
359	1500
370	1500
371	1500
372	1500
378	1500
384	1500
381	1500
379	1500
377	1500
395	1500
414	1500
424	1500
429	1500
440	1500
441	1500
457	1500
471	1500
518	1500
603	1500
341	1501
345	1501
359	1501
362	1501
388	1501
386	1501
381	1501
387	1501
405	1501
400	1501
424	1501
438	1501
457	1501
478	1501
482	1501
518	1501
583	1501
603	1501
341	1502
348	1502
352	1502
362	1502
385	1502
379	1502
377	1502
392	1502
395	1502
414	1502
424	1502
429	1502
438	1502
457	1502
471	1502
490	1502
492	1502
515	1502
518	1502
583	1502
603	1502
646	1502
341	1503
345	1503
348	1503
359	1503
371	1503
372	1503
378	1503
384	1503
379	1503
377	1503
401	1503
424	1503
440	1503
438	1503
445	1503
457	1503
474	1503
507	1503
509	1503
583	1503
341	1504
345	1504
388	1504
386	1504
381	1504
387	1504
379	1504
377	1504
392	1504
395	1504
400	1504
424	1504
429	1504
440	1504
455	1504
457	1504
471	1504
478	1504
490	1504
518	1504
583	1504
603	1504
341	1505
345	1505
348	1505
352	1505
359	1505
371	1505
388	1505
386	1505
385	1505
384	1505
387	1505
379	1505
392	1505
440	1505
445	1505
457	1505
492	1505
509	1505
515	1505
583	1505
646	1505
341	1506
345	1506
348	1506
352	1506
359	1506
372	1506
378	1506
379	1506
377	1506
392	1506
401	1506
395	1506
405	1506
414	1506
424	1506
429	1506
438	1506
457	1506
471	1506
648	1506
341	1507
345	1507
348	1507
359	1507
362	1507
388	1507
386	1507
385	1507
381	1507
387	1507
379	1507
395	1507
400	1507
424	1507
440	1507
438	1507
457	1507
482	1507
509	1507
518	1507
583	1507
603	1507
341	1508
345	1508
352	1508
359	1508
362	1508
370	1508
385	1508
381	1508
379	1508
377	1508
405	1508
414	1508
424	1508
429	1508
455	1508
457	1508
478	1508
490	1508
513	1508
515	1508
583	1508
341	1509
345	1509
359	1509
372	1509
378	1509
388	1509
386	1509
384	1509
387	1509
379	1509
377	1509
392	1509
395	1509
440	1509
438	1509
471	1509
482	1509
492	1509
515	1509
518	1509
583	1509
603	1509
646	1509
341	1510
345	1510
348	1510
359	1510
362	1510
372	1510
385	1510
379	1510
377	1510
392	1510
395	1510
405	1510
400	1510
424	1510
440	1510
438	1510
457	1510
492	1510
507	1510
513	1510
518	1510
583	1510
603	1510
648	1510
341	1511
345	1511
359	1511
370	1511
381	1511
379	1511
392	1511
401	1511
405	1511
414	1511
424	1511
429	1511
438	1511
455	1511
457	1511
471	1511
474	1511
478	1511
490	1511
513	1511
515	1511
518	1511
583	1511
603	1511
341	1512
345	1512
348	1512
362	1512
372	1512
388	1512
386	1512
385	1512
384	1512
387	1512
379	1512
392	1512
395	1512
424	1512
429	1512
438	1512
457	1512
509	1512
515	1512
518	1512
583	1512
603	1512
648	1512
341	1513
345	1513
348	1513
378	1513
388	1513
385	1513
381	1513
379	1513
392	1513
401	1513
400	1513
414	1513
424	1513
440	1513
438	1513
457	1513
474	1513
478	1513
482	1513
492	1513
509	1513
518	1513
583	1513
603	1513
341	1514
345	1514
348	1514
362	1514
370	1514
372	1514
388	1514
386	1514
385	1514
384	1514
387	1514
392	1514
424	1514
429	1514
438	1514
455	1514
457	1514
471	1514
490	1514
515	1514
518	1514
583	1514
603	1514
646	1514
648	1514
341	1515
345	1515
371	1515
378	1515
388	1515
386	1515
385	1515
381	1515
387	1515
379	1515
377	1515
395	1515
400	1515
440	1515
455	1515
457	1515
478	1515
509	1515
515	1515
518	1515
583	1515
603	1515
344	1516
348	1516
352	1516
371	1516
388	1516
386	1516
387	1516
379	1516
415	1516
438	1516
445	1516
478	1516
508	1516
509	1516
647	1516
348	1517
372	1517
378	1517
388	1517
386	1517
387	1517
379	1517
401	1517
418	1517
429	1517
440	1517
438	1517
445	1517
478	1517
607	1517
633	1517
649	1517
348	1518
358	1518
363	1518
372	1518
378	1518
388	1518
386	1518
387	1518
405	1518
438	1518
441	1518
508	1518
607	1518
647	1518
348	1519
490	1519
607	1519
647	1519
337	1520
338	1520
348	1520
352	1520
359	1520
363	1520
370	1520
374	1520
384	1520
387	1520
406	1520
401	1520
394	1520
399	1520
405	1520
400	1520
418	1520
424	1520
440	1520
443	1520
465	1520
471	1520
478	1520
482	1520
490	1520
508	1520
533	1520
344	1521
348	1521
358	1521
362	1521
371	1521
372	1521
381	1521
397	1521
401	1521
402	1521
393	1521
399	1521
405	1521
407	1521
438	1521
443	1521
448	1521
462	1521
460	1521
471	1521
472	1521
478	1521
488	1521
506	1521
508	1521
513	1521
521	1521
636	1521
650	1521
352	1522
359	1522
360	1522
371	1522
372	1522
375	1522
374	1522
392	1522
395	1522
413	1522
419	1522
424	1522
429	1522
440	1522
443	1522
445	1522
441	1522
467	1522
469	1522
472	1522
474	1522
508	1522
652	1522
651	1522
337	1523
338	1523
358	1523
362	1523
370	1523
372	1523
374	1523
381	1523
402	1523
394	1523
399	1523
405	1523
420	1523
418	1523
424	1523
438	1523
443	1523
460	1523
468	1523
472	1523
478	1523
485	1523
651	1523
344	1524
349	1524
359	1524
360	1524
363	1524
372	1524
375	1524
374	1524
384	1524
381	1524
401	1524
395	1524
400	1524
407	1524
438	1524
445	1524
472	1524
474	1524
478	1524
490	1524
508	1524
616	1524
652	1524
358	1525
363	1525
375	1525
384	1525
401	1525
393	1525
395	1525
405	1525
420	1525
419	1525
407	1525
424	1525
429	1525
440	1525
438	1525
443	1525
441	1525
472	1525
474	1525
488	1525
506	1525
652	1525
337	1526
338	1526
344	1526
352	1526
360	1526
362	1526
370	1526
371	1526
372	1526
374	1526
381	1526
406	1526
401	1526
440	1526
438	1526
443	1526
445	1526
460	1526
467	1526
478	1526
508	1526
651	1526
344	1527
348	1527
358	1527
363	1527
372	1527
374	1527
384	1527
381	1527
401	1527
402	1527
393	1527
395	1527
407	1527
438	1527
441	1527
460	1527
472	1527
474	1527
488	1527
490	1527
506	1527
508	1527
521	1527
636	1527
344	1528
358	1528
359	1528
363	1528
371	1528
372	1528
375	1528
374	1528
381	1528
401	1528
394	1528
399	1528
395	1528
405	1528
400	1528
424	1528
429	1528
440	1528
438	1528
443	1528
472	1528
478	1528
651	1528
349	1529
359	1529
372	1529
374	1529
384	1529
381	1529
392	1529
401	1529
395	1529
405	1529
400	1529
429	1529
440	1529
438	1529
445	1529
469	1529
472	1529
474	1529
478	1529
508	1529
616	1529
647	1529
652	1529
337	1530
338	1530
352	1530
358	1530
359	1530
370	1530
372	1530
397	1530
394	1530
399	1530
405	1530
413	1530
419	1530
440	1530
438	1530
441	1530
448	1530
460	1530
468	1530
508	1530
651	1530
344	1531
359	1531
363	1531
371	1531
372	1531
375	1531
374	1531
384	1531
381	1531
395	1531
400	1531
407	1531
424	1531
443	1531
472	1531
474	1531
478	1531
490	1531
344	1532
358	1532
363	1532
372	1532
375	1532
374	1532
384	1532
381	1532
397	1532
401	1532
402	1532
393	1532
395	1532
405	1532
418	1532
407	1532
424	1532
433	1532
429	1532
438	1532
443	1532
445	1532
472	1532
474	1532
485	1532
508	1532
513	1532
337	1533
338	1533
344	1533
358	1533
359	1533
363	1533
370	1533
371	1533
372	1533
374	1533
381	1533
392	1533
402	1533
399	1533
418	1533
424	1533
440	1533
438	1533
443	1533
448	1533
468	1533
478	1533
508	1533
616	1533
358	1534
372	1534
375	1534
374	1534
384	1534
381	1534
393	1534
394	1534
395	1534
400	1534
420	1534
438	1534
443	1534
441	1534
460	1534
472	1534
474	1534
478	1534
508	1534
651	1534
337	1535
338	1535
344	1535
358	1535
371	1535
372	1535
375	1535
374	1535
381	1535
392	1535
401	1535
399	1535
395	1535
400	1535
407	1535
424	1535
440	1535
443	1535
467	1535
468	1535
472	1535
478	1535
485	1535
506	1535
508	1535
521	1535
651	1535
344	1536
360	1536
363	1536
372	1536
374	1536
381	1536
402	1536
405	1536
400	1536
420	1536
418	1536
424	1536
429	1536
440	1536
443	1536
441	1536
460	1536
478	1536
485	1536
498	1536
521	1536
651	1536
337	1537
338	1537
352	1537
358	1537
359	1537
372	1537
375	1537
374	1537
384	1537
406	1537
401	1537
399	1537
395	1537
424	1537
438	1537
445	1537
468	1537
472	1537
478	1537
490	1537
616	1537
358	1538
370	1538
371	1538
372	1538
374	1538
381	1538
392	1538
393	1538
394	1538
395	1538
413	1538
407	1538
429	1538
440	1538
438	1538
443	1538
460	1538
472	1538
474	1538
478	1538
490	1538
508	1538
651	1538
337	1539
338	1539
344	1539
358	1539
359	1539
372	1539
374	1539
384	1539
381	1539
399	1539
395	1539
405	1539
400	1539
424	1539
429	1539
440	1539
438	1539
443	1539
474	1539
478	1539
498	1539
358	1540
359	1540
363	1540
371	1540
372	1540
375	1540
374	1540
384	1540
381	1540
392	1540
401	1540
402	1540
395	1540
443	1540
472	1540
478	1540
485	1540
506	1540
508	1540
616	1540
651	1540
337	1541
338	1541
344	1541
352	1541
360	1541
370	1541
371	1541
372	1541
374	1541
384	1541
381	1541
401	1541
394	1541
407	1541
433	1541
438	1541
445	1541
441	1541
448	1541
460	1541
467	1541
358	1542
359	1542
363	1542
372	1542
374	1542
381	1542
393	1542
399	1542
395	1542
405	1542
413	1542
424	1542
429	1542
440	1542
438	1542
443	1542
445	1542
472	1542
474	1542
478	1542
508	1542
513	1542
521	1542
616	1542
651	1542
337	1543
338	1543
344	1543
358	1543
363	1543
372	1543
381	1543
392	1543
401	1543
399	1543
395	1543
405	1543
400	1543
418	1543
438	1543
443	1543
460	1543
469	1543
472	1543
478	1543
485	1543
488	1543
508	1543
651	1543
360	1544
371	1544
372	1544
374	1544
397	1544
399	1544
395	1544
420	1544
413	1544
407	1544
440	1544
438	1544
443	1544
460	1544
468	1544
474	1544
485	1544
508	1544
521	1544
651	1544
653	1544
337	1545
338	1545
358	1545
363	1545
375	1545
374	1545
384	1545
381	1545
401	1545
393	1545
405	1545
400	1545
424	1545
429	1545
443	1545
467	1545
472	1545
474	1545
478	1545
488	1545
490	1545
616	1545
337	1546
338	1546
344	1546
358	1546
371	1546
372	1546
374	1546
381	1546
392	1546
401	1546
440	1546
438	1546
443	1546
472	1546
474	1546
478	1546
506	1546
508	1546
521	1546
359	1547
370	1547
401	1547
393	1547
394	1547
395	1547
405	1547
419	1547
418	1547
424	1547
440	1547
438	1547
443	1547
460	1547
468	1547
472	1547
478	1547
506	1547
508	1547
651	1547
654	1547
337	1548
338	1548
344	1548
372	1548
375	1548
374	1548
384	1548
381	1548
401	1548
395	1548
400	1548
420	1548
429	1548
440	1548
438	1548
443	1548
445	1548
460	1548
472	1548
474	1548
478	1548
488	1548
498	1548
508	1548
337	1549
338	1549
358	1549
359	1549
371	1549
372	1549
384	1549
381	1549
392	1549
401	1549
405	1549
400	1549
420	1549
424	1549
440	1549
438	1549
467	1549
472	1549
474	1549
478	1549
616	1549
337	1550
338	1550
344	1550
358	1550
359	1550
363	1550
371	1550
372	1550
374	1550
385	1550
381	1550
392	1550
405	1550
400	1550
420	1550
424	1550
429	1550
440	1550
438	1550
443	1550
445	1550
472	1550
474	1550
508	1550
358	1551
363	1551
370	1551
372	1551
384	1551
381	1551
392	1551
401	1551
395	1551
405	1551
400	1551
440	1551
438	1551
443	1551
472	1551
474	1551
478	1551
488	1551
490	1551
506	1551
508	1551
651	1551
655	1551
337	1552
338	1552
344	1552
352	1552
359	1552
371	1552
372	1552
375	1552
381	1552
393	1552
399	1552
400	1552
424	1552
438	1552
445	1552
441	1552
462	1552
460	1552
467	1552
469	1552
472	1552
474	1552
508	1552
551	1552
651	1552
655	1552
337	1553
338	1553
344	1553
358	1553
363	1553
372	1553
374	1553
384	1553
401	1553
393	1553
395	1553
405	1553
424	1553
429	1553
438	1553
448	1553
467	1553
468	1553
472	1553
474	1553
478	1553
488	1553
498	1553
506	1553
508	1553
655	1553
352	1554
358	1554
359	1554
363	1554
371	1554
372	1554
375	1554
374	1554
384	1554
381	1554
392	1554
394	1554
395	1554
413	1554
424	1554
438	1554
443	1554
445	1554
460	1554
472	1554
478	1554
506	1554
651	1554
337	1555
338	1555
344	1555
359	1555
363	1555
372	1555
399	1555
395	1555
405	1555
418	1555
424	1555
440	1555
438	1555
443	1555
467	1555
474	1555
478	1555
616	1555
337	1556
338	1556
345	1556
358	1556
359	1556
363	1556
371	1556
372	1556
375	1556
384	1556
381	1556
392	1556
405	1556
400	1556
420	1556
419	1556
407	1556
424	1556
440	1556
438	1556
443	1556
460	1556
468	1556
472	1556
474	1556
478	1556
508	1556
651	1556
337	1557
338	1557
352	1557
360	1557
372	1557
375	1557
374	1557
384	1557
392	1557
394	1557
395	1557
405	1557
413	1557
419	1557
424	1557
438	1557
443	1557
445	1557
455	1557
472	1557
474	1557
478	1557
497	1557
508	1557
651	1557
344	1558
348	1558
358	1558
363	1558
370	1558
371	1558
375	1558
374	1558
401	1558
402	1558
395	1558
420	1558
418	1558
424	1558
429	1558
440	1558
438	1558
448	1558
446	1558
467	1558
468	1558
472	1558
474	1558
490	1558
508	1558
533	1558
616	1558
651	1558
337	1559
338	1559
344	1559
358	1559
359	1559
372	1559
374	1559
384	1559
406	1559
392	1559
401	1559
393	1559
399	1559
395	1559
405	1559
400	1559
407	1559
424	1559
438	1559
443	1559
445	1559
460	1559
472	1559
474	1559
478	1559
488	1559
498	1559
506	1559
508	1559
509	1559
344	1560
370	1560
374	1560
384	1560
402	1560
399	1560
420	1560
424	1560
429	1560
440	1560
438	1560
443	1560
448	1560
446	1560
455	1560
462	1560
460	1560
468	1560
472	1560
498	1560
616	1560
651	1560
337	1561
338	1561
348	1561
358	1561
359	1561
363	1561
375	1561
374	1561
392	1561
401	1561
395	1561
405	1561
400	1561
413	1561
407	1561
424	1561
433	1561
443	1561
441	1561
457	1561
467	1561
508	1561
509	1561
616	1561
651	1561
337	1562
338	1562
358	1562
359	1562
363	1562
384	1562
392	1562
401	1562
399	1562
395	1562
405	1562
400	1562
420	1562
419	1562
424	1562
433	1562
429	1562
438	1562
443	1562
441	1562
457	1562
467	1562
472	1562
508	1562
509	1562
616	1562
651	1562
337	1563
338	1563
344	1563
358	1563
359	1563
363	1563
375	1563
374	1563
384	1563
406	1563
392	1563
401	1563
395	1563
405	1563
420	1563
424	1563
433	1563
438	1563
443	1563
445	1563
441	1563
462	1563
472	1563
498	1563
513	1563
616	1563
337	1564
338	1564
344	1564
358	1564
370	1564
371	1564
375	1564
392	1564
402	1564
395	1564
400	1564
418	1564
407	1564
433	1564
429	1564
440	1564
438	1564
443	1564
448	1564
455	1564
460	1564
467	1564
468	1564
472	1564
488	1564
490	1564
498	1564
509	1564
616	1564
651	1564
337	1565
338	1565
363	1565
370	1565
375	1565
401	1565
405	1565
413	1565
438	1565
443	1565
446	1565
467	1565
468	1565
509	1565
651	1565
337	1566
338	1566
344	1566
358	1566
359	1566
363	1566
370	1566
371	1566
401	1566
405	1566
420	1566
429	1566
440	1566
438	1566
443	1566
445	1566
490	1566
344	1567
363	1567
370	1567
374	1567
384	1567
392	1567
402	1567
399	1567
395	1567
405	1567
400	1567
419	1567
438	1567
443	1567
448	1567
468	1567
482	1567
488	1567
508	1567
551	1567
651	1567
337	1568
338	1568
352	1568
358	1568
359	1568
384	1568
406	1568
399	1568
395	1568
420	1568
407	1568
424	1568
433	1568
429	1568
440	1568
438	1568
445	1568
457	1568
467	1568
472	1568
509	1568
616	1568
651	1568
375	1569
374	1569
384	1569
392	1569
401	1569
394	1569
395	1569
405	1569
413	1569
419	1569
424	1569
433	1569
438	1569
443	1569
448	1569
446	1569
460	1569
472	1569
508	1569
509	1569
651	1569
337	1570
338	1570
358	1570
359	1570
371	1570
384	1570
392	1570
401	1570
395	1570
405	1570
420	1570
424	1570
433	1570
429	1570
438	1570
445	1570
460	1570
472	1570
508	1570
533	1570
651	1570
337	1571
338	1571
344	1571
358	1571
359	1571
363	1571
375	1571
374	1571
401	1571
402	1571
394	1571
395	1571
420	1571
418	1571
433	1571
429	1571
440	1571
438	1571
443	1571
445	1571
457	1571
467	1571
472	1571
488	1571
490	1571
616	1571
651	1571
344	1572
358	1572
371	1572
374	1572
384	1572
406	1572
399	1572
400	1572
419	1572
407	1572
429	1572
438	1572
443	1572
445	1572
446	1572
457	1572
462	1572
472	1572
498	1572
509	1572
651	1572
337	1573
338	1573
344	1573
359	1573
370	1573
375	1573
399	1573
395	1573
405	1573
420	1573
418	1573
424	1573
433	1573
438	1573
448	1573
457	1573
460	1573
467	1573
468	1573
488	1573
509	1573
521	1573
616	1573
651	1573
337	1574
338	1574
358	1574
359	1574
363	1574
370	1574
374	1574
384	1574
392	1574
401	1574
395	1574
405	1574
420	1574
419	1574
407	1574
440	1574
438	1574
443	1574
446	1574
457	1574
468	1574
472	1574
488	1574
337	1575
338	1575
344	1575
358	1575
359	1575
360	1575
371	1575
374	1575
392	1575
401	1575
395	1575
400	1575
418	1575
429	1575
440	1575
438	1575
443	1575
445	1575
446	1575
462	1575
460	1575
472	1575
488	1575
508	1575
337	1576
338	1576
358	1576
375	1576
401	1576
393	1576
399	1576
405	1576
413	1576
407	1576
424	1576
429	1576
438	1576
443	1576
460	1576
467	1576
468	1576
490	1576
506	1576
521	1576
533	1576
551	1576
616	1576
651	1576
344	1577
359	1577
363	1577
370	1577
371	1577
375	1577
374	1577
384	1577
406	1577
394	1577
395	1577
405	1577
400	1577
420	1577
419	1577
407	1577
438	1577
443	1577
457	1577
472	1577
508	1577
651	1577
337	1578
338	1578
358	1578
359	1578
375	1578
384	1578
392	1578
401	1578
399	1578
395	1578
407	1578
424	1578
433	1578
440	1578
438	1578
445	1578
446	1578
460	1578
467	1578
468	1578
472	1578
488	1578
490	1578
506	1578
508	1578
509	1578
521	1578
616	1578
651	1578
344	1579
384	1579
405	1579
419	1579
407	1579
446	1579
337	1580
338	1580
358	1580
363	1580
370	1580
371	1580
374	1580
384	1580
401	1580
399	1580
395	1580
413	1580
438	1580
443	1580
445	1580
446	1580
457	1580
468	1580
472	1580
490	1580
509	1580
651	1580
344	1581
359	1581
375	1581
406	1581
392	1581
401	1581
394	1581
395	1581
405	1581
400	1581
420	1581
418	1581
424	1581
433	1581
440	1581
438	1581
443	1581
460	1581
467	1581
472	1581
482	1581
488	1581
506	1581
508	1581
337	1582
338	1582
344	1582
358	1582
359	1582
370	1582
375	1582
374	1582
384	1582
392	1582
402	1582
393	1582
394	1582
399	1582
405	1582
400	1582
407	1582
424	1582
429	1582
438	1582
443	1582
460	1582
467	1582
468	1582
472	1582
498	1582
508	1582
509	1582
616	1582
337	1583
338	1583
358	1583
359	1583
363	1583
370	1583
371	1583
384	1583
401	1583
413	1583
407	1583
429	1583
443	1583
445	1583
446	1583
457	1583
460	1583
472	1583
551	1583
651	1583
337	1584
338	1584
344	1584
358	1584
363	1584
374	1584
406	1584
392	1584
393	1584
399	1584
395	1584
405	1584
420	1584
418	1584
424	1584
429	1584
440	1584
438	1584
443	1584
460	1584
468	1584
472	1584
508	1584
509	1584
616	1584
651	1584
344	1585
360	1585
371	1585
384	1585
402	1585
394	1585
399	1585
405	1585
400	1585
438	1585
443	1585
445	1585
446	1585
460	1585
508	1585
509	1585
651	1585
656	1585
337	1586
338	1586
358	1586
359	1586
370	1586
374	1586
384	1586
401	1586
399	1586
395	1586
405	1586
413	1586
419	1586
424	1586
433	1586
429	1586
438	1586
443	1586
457	1586
472	1586
490	1586
509	1586
551	1586
337	1587
338	1587
344	1587
358	1587
359	1587
363	1587
371	1587
384	1587
392	1587
401	1587
402	1587
394	1587
395	1587
405	1587
440	1587
438	1587
443	1587
446	1587
457	1587
472	1587
488	1587
508	1587
651	1587
657	1587
337	1588
338	1588
344	1588
374	1588
401	1588
393	1588
399	1588
395	1588
405	1588
424	1588
429	1588
440	1588
438	1588
443	1588
457	1588
467	1588
468	1588
472	1588
498	1588
506	1588
509	1588
651	1588
344	1589
358	1589
371	1589
374	1589
384	1589
397	1589
392	1589
402	1589
393	1589
395	1589
400	1589
420	1589
418	1589
429	1589
438	1589
443	1589
446	1589
462	1589
508	1589
651	1589
658	1589
337	1590
338	1590
344	1590
359	1590
363	1590
370	1590
401	1590
394	1590
395	1590
405	1590
424	1590
440	1590
443	1590
457	1590
467	1590
472	1590
508	1590
509	1590
344	1591
358	1591
359	1591
370	1591
374	1591
401	1591
393	1591
394	1591
399	1591
395	1591
405	1591
420	1591
429	1591
457	1591
472	1591
508	1591
509	1591
651	1591
656	1591
658	1591
344	1592
348	1592
358	1592
359	1592
363	1592
364	1592
370	1592
371	1592
374	1592
384	1592
392	1592
401	1592
399	1592
395	1592
405	1592
429	1592
438	1592
443	1592
457	1592
467	1592
468	1592
508	1592
651	1592
658	1592
358	1593
364	1593
370	1593
371	1593
375	1593
374	1593
392	1593
401	1593
393	1593
394	1593
395	1593
420	1593
433	1593
440	1593
438	1593
443	1593
446	1593
457	1593
468	1593
472	1593
508	1593
658	1593
337	1594
338	1594
359	1594
363	1594
374	1594
384	1594
394	1594
399	1594
395	1594
405	1594
413	1594
419	1594
424	1594
429	1594
438	1594
443	1594
457	1594
488	1594
508	1594
651	1594
658	1594
337	1595
338	1595
344	1595
352	1595
358	1595
359	1595
370	1595
371	1595
375	1595
374	1595
385	1595
392	1595
401	1595
402	1595
395	1595
429	1595
438	1595
443	1595
445	1595
457	1595
467	1595
468	1595
506	1595
508	1595
651	1595
658	1595
659	1595
344	1596
348	1596
358	1596
363	1596
364	1596
370	1596
374	1596
385	1596
384	1596
401	1596
394	1596
405	1596
418	1596
424	1596
429	1596
440	1596
443	1596
446	1596
457	1596
472	1596
509	1596
358	1597
364	1597
370	1597
371	1597
374	1597
401	1597
399	1597
395	1597
405	1597
420	1597
413	1597
419	1597
424	1597
429	1597
440	1597
438	1597
443	1597
445	1597
472	1597
488	1597
509	1597
656	1597
337	1598
338	1598
344	1598
358	1598
359	1598
375	1598
374	1598
384	1598
397	1598
392	1598
393	1598
394	1598
418	1598
424	1598
433	1598
438	1598
443	1598
445	1598
457	1598
467	1598
468	1598
472	1598
490	1598
508	1598
509	1598
616	1598
337	1599
338	1599
344	1599
363	1599
370	1599
375	1599
373	1599
374	1599
384	1599
392	1599
401	1599
402	1599
393	1599
395	1599
405	1599
440	1599
438	1599
443	1599
446	1599
457	1599
472	1599
498	1599
508	1599
657	1599
358	1600
359	1600
364	1600
399	1600
400	1600
424	1600
429	1600
440	1600
438	1600
469	1600
472	1600
337	1601
338	1601
344	1601
358	1601
384	1601
392	1601
393	1601
399	1601
395	1601
400	1601
420	1601
418	1601
433	1601
429	1601
440	1601
438	1601
443	1601
457	1601
488	1601
616	1601
359	1602
360	1602
363	1602
364	1602
370	1602
371	1602
374	1602
384	1602
397	1602
401	1602
395	1602
405	1602
413	1602
424	1602
443	1602
457	1602
467	1602
468	1602
472	1602
508	1602
509	1602
337	1603
338	1603
344	1603
358	1603
363	1603
375	1603
374	1603
384	1603
392	1603
402	1603
393	1603
399	1603
395	1603
420	1603
419	1603
418	1603
424	1603
433	1603
429	1603
440	1603
438	1603
443	1603
457	1603
488	1603
337	1604
338	1604
344	1604
358	1604
363	1604
375	1604
373	1604
374	1604
384	1604
397	1604
392	1604
402	1604
394	1604
395	1604
405	1604
420	1604
418	1604
424	1604
438	1604
443	1604
446	1604
467	1604
472	1604
488	1604
490	1604
508	1604
509	1604
616	1604
656	1604
337	1605
338	1605
370	1605
375	1605
399	1605
395	1605
440	1605
443	1605
467	1605
508	1605
656	1605
337	1606
338	1606
344	1606
359	1606
363	1606
364	1606
375	1606
373	1606
374	1606
384	1606
397	1606
392	1606
402	1606
395	1606
405	1606
400	1606
420	1606
418	1606
424	1606
429	1606
438	1606
443	1606
446	1606
457	1606
462	1606
467	1606
472	1606
488	1606
490	1606
498	1606
508	1606
344	1607
352	1607
364	1607
370	1607
373	1607
374	1607
384	1607
401	1607
402	1607
395	1607
405	1607
400	1607
413	1607
419	1607
424	1607
440	1607
438	1607
443	1607
445	1607
446	1607
457	1607
468	1607
488	1607
490	1607
508	1607
509	1607
523	1607
589	1607
660	1607
337	1608
338	1608
344	1608
358	1608
359	1608
363	1608
373	1608
374	1608
384	1608
401	1608
402	1608
393	1608
394	1608
399	1608
395	1608
405	1608
424	1608
429	1608
438	1608
443	1608
457	1608
472	1608
506	1608
508	1608
509	1608
337	1609
338	1609
344	1609
358	1609
359	1609
363	1609
375	1609
373	1609
374	1609
384	1609
401	1609
402	1609
394	1609
399	1609
395	1609
405	1609
420	1609
418	1609
424	1609
429	1609
440	1609
438	1609
443	1609
446	1609
457	1609
472	1609
488	1609
506	1609
508	1609
509	1609
656	1609
337	1610
338	1610
344	1610
358	1610
359	1610
363	1610
370	1610
375	1610
373	1610
374	1610
384	1610
392	1610
401	1610
394	1610
395	1610
405	1610
420	1610
418	1610
424	1610
438	1610
443	1610
446	1610
457	1610
462	1610
467	1610
472	1610
488	1610
490	1610
508	1610
509	1610
337	1611
338	1611
344	1611
348	1611
358	1611
359	1611
363	1611
375	1611
373	1611
374	1611
384	1611
392	1611
401	1611
402	1611
394	1611
399	1611
395	1611
405	1611
420	1611
418	1611
424	1611
433	1611
429	1611
440	1611
438	1611
443	1611
446	1611
457	1611
467	1611
472	1611
506	1611
508	1611
509	1611
337	1612
338	1612
358	1612
363	1612
373	1612
374	1612
384	1612
392	1612
401	1612
393	1612
399	1612
395	1612
405	1612
420	1612
424	1612
433	1612
440	1612
438	1612
446	1612
457	1612
467	1612
468	1612
472	1612
490	1612
506	1612
508	1612
533	1612
616	1612
656	1612
660	1612
661	1612
338	1613
344	1613
348	1613
359	1613
375	1613
373	1613
374	1613
384	1613
402	1613
399	1613
395	1613
405	1613
420	1613
418	1613
424	1613
429	1613
443	1613
457	1613
462	1613
467	1613
472	1613
485	1613
488	1613
509	1613
337	1614
338	1614
344	1614
352	1614
360	1614
363	1614
364	1614
371	1614
373	1614
374	1614
384	1614
401	1614
395	1614
424	1614
433	1614
443	1614
445	1614
455	1614
457	1614
467	1614
472	1614
488	1614
508	1614
509	1614
660	1614
337	1615
338	1615
358	1615
360	1615
370	1615
373	1615
374	1615
384	1615
392	1615
401	1615
393	1615
394	1615
399	1615
395	1615
413	1615
424	1615
433	1615
440	1615
438	1615
443	1615
446	1615
457	1615
472	1615
488	1615
490	1615
508	1615
509	1615
656	1615
660	1615
661	1615
337	1616
338	1616
344	1616
358	1616
371	1616
373	1616
374	1616
384	1616
392	1616
401	1616
402	1616
399	1616
395	1616
400	1616
419	1616
424	1616
433	1616
429	1616
438	1616
443	1616
446	1616
455	1616
457	1616
467	1616
468	1616
472	1616
488	1616
508	1616
616	1616
660	1616
661	1616
337	1617
338	1617
344	1617
358	1617
359	1617
360	1617
370	1617
375	1617
373	1617
374	1617
384	1617
402	1617
394	1617
395	1617
405	1617
413	1617
424	1617
433	1617
438	1617
443	1617
446	1617
457	1617
472	1617
485	1617
488	1617
490	1617
508	1617
509	1617
616	1617
657	1617
660	1617
337	1618
338	1618
344	1618
358	1618
363	1618
364	1618
371	1618
373	1618
374	1618
384	1618
401	1618
395	1618
405	1618
420	1618
418	1618
424	1618
429	1618
438	1618
443	1618
446	1618
457	1618
472	1618
488	1618
506	1618
508	1618
509	1618
656	1618
660	1618
337	1619
338	1619
358	1619
359	1619
375	1619
373	1619
374	1619
384	1619
406	1619
392	1619
401	1619
394	1619
395	1619
405	1619
400	1619
420	1619
413	1619
438	1619
443	1619
446	1619
457	1619
467	1619
472	1619
488	1619
508	1619
509	1619
616	1619
656	1619
660	1619
661	1619
337	1620
338	1620
344	1620
358	1620
359	1620
370	1620
373	1620
374	1620
384	1620
392	1620
401	1620
402	1620
393	1620
399	1620
395	1620
420	1620
418	1620
424	1620
440	1620
438	1620
443	1620
457	1620
472	1620
488	1620
490	1620
506	1620
509	1620
660	1620
337	1621
338	1621
344	1621
358	1621
364	1621
375	1621
373	1621
374	1621
384	1621
394	1621
395	1621
405	1621
413	1621
419	1621
424	1621
433	1621
438	1621
443	1621
457	1621
467	1621
468	1621
472	1621
508	1621
509	1621
660	1621
344	1622
358	1622
359	1622
363	1622
370	1622
373	1622
374	1622
384	1622
401	1622
393	1622
399	1622
395	1622
405	1622
420	1622
418	1622
424	1622
429	1622
438	1622
443	1622
446	1622
457	1622
472	1622
506	1622
508	1622
509	1622
656	1622
337	1623
338	1623
344	1623
373	1623
374	1623
401	1623
402	1623
395	1623
405	1623
419	1623
418	1623
424	1623
429	1623
438	1623
443	1623
472	1623
482	1623
508	1623
509	1623
533	1623
337	1624
338	1624
344	1624
352	1624
358	1624
359	1624
363	1624
373	1624
374	1624
384	1624
401	1624
393	1624
394	1624
399	1624
395	1624
413	1624
424	1624
433	1624
438	1624
443	1624
445	1624
457	1624
462	1624
467	1624
472	1624
508	1624
509	1624
337	1625
338	1625
344	1625
359	1625
375	1625
373	1625
374	1625
384	1625
392	1625
401	1625
393	1625
395	1625
405	1625
438	1625
443	1625
446	1625
457	1625
467	1625
468	1625
472	1625
498	1625
508	1625
509	1625
616	1625
358	1626
359	1626
363	1626
364	1626
371	1626
373	1626
384	1626
401	1626
420	1626
413	1626
424	1626
440	1626
443	1626
445	1626
457	1626
472	1626
506	1626
509	1626
659	1626
660	1626
337	1627
338	1627
344	1627
358	1627
370	1627
373	1627
374	1627
392	1627
401	1627
394	1627
399	1627
395	1627
405	1627
420	1627
429	1627
440	1627
457	1627
472	1627
490	1627
508	1627
656	1627
660	1627
344	1628
401	1628
402	1628
405	1628
420	1628
418	1628
424	1628
506	1628
337	1629
338	1629
344	1629
352	1629
364	1629
370	1629
371	1629
373	1629
384	1629
402	1629
393	1629
395	1629
420	1629
424	1629
440	1629
438	1629
443	1629
445	1629
446	1629
457	1629
472	1629
508	1629
509	1629
616	1629
656	1629
660	1629
337	1630
338	1630
358	1630
359	1630
371	1630
375	1630
373	1630
374	1630
384	1630
392	1630
401	1630
393	1630
395	1630
405	1630
420	1630
413	1630
407	1630
424	1630
429	1630
438	1630
443	1630
446	1630
457	1630
472	1630
506	1630
508	1630
509	1630
656	1630
337	1631
338	1631
344	1631
358	1631
363	1631
373	1631
374	1631
384	1631
392	1631
401	1631
393	1631
395	1631
405	1631
420	1631
407	1631
424	1631
429	1631
440	1631
438	1631
443	1631
446	1631
457	1631
460	1631
468	1631
472	1631
506	1631
509	1631
660	1631
344	1632
359	1632
363	1632
371	1632
373	1632
374	1632
384	1632
392	1632
399	1632
405	1632
420	1632
419	1632
418	1632
407	1632
424	1632
433	1632
429	1632
440	1632
438	1632
443	1632
455	1632
469	1632
472	1632
490	1632
508	1632
657	1632
344	1633
358	1633
359	1633
363	1633
373	1633
384	1633
392	1633
402	1633
394	1633
405	1633
420	1633
413	1633
419	1633
443	1633
460	1633
467	1633
472	1633
490	1633
508	1633
344	1634
359	1634
360	1634
364	1634
371	1634
375	1634
373	1634
374	1634
384	1634
392	1634
402	1634
405	1634
418	1634
433	1634
440	1634
443	1634
445	1634
472	1634
490	1634
508	1634
616	1634
657	1634
337	1635
338	1635
358	1635
362	1635
363	1635
370	1635
373	1635
384	1635
392	1635
402	1635
394	1635
399	1635
405	1635
420	1635
413	1635
424	1635
429	1635
440	1635
438	1635
462	1635
472	1635
508	1635
616	1635
650	1635
337	1636
338	1636
344	1636
359	1636
363	1636
364	1636
370	1636
375	1636
373	1636
374	1636
384	1636
405	1636
420	1636
418	1636
407	1636
424	1636
433	1636
440	1636
438	1636
443	1636
455	1636
460	1636
468	1636
482	1636
490	1636
508	1636
337	1637
338	1637
363	1637
364	1637
371	1637
373	1637
374	1637
384	1637
406	1637
392	1637
405	1637
420	1637
413	1637
424	1637
433	1637
429	1637
440	1637
438	1637
443	1637
445	1637
462	1637
460	1637
472	1637
508	1637
616	1637
337	1638
338	1638
344	1638
352	1638
358	1638
359	1638
363	1638
375	1638
373	1638
374	1638
384	1638
392	1638
405	1638
420	1638
433	1638
429	1638
438	1638
443	1638
445	1638
460	1638
468	1638
508	1638
337	1639
338	1639
344	1639
348	1639
364	1639
370	1639
371	1639
384	1639
406	1639
402	1639
394	1639
405	1639
420	1639
418	1639
407	1639
424	1639
429	1639
440	1639
438	1639
443	1639
455	1639
460	1639
467	1639
468	1639
472	1639
508	1639
337	1640
338	1640
358	1640
364	1640
370	1640
375	1640
373	1640
374	1640
384	1640
399	1640
405	1640
420	1640
413	1640
424	1640
433	1640
429	1640
440	1640
438	1640
443	1640
445	1640
462	1640
460	1640
468	1640
472	1640
508	1640
650	1640
661	1640
337	1641
338	1641
359	1641
371	1641
375	1641
373	1641
392	1641
402	1641
394	1641
399	1641
405	1641
420	1641
407	1641
424	1641
429	1641
440	1641
443	1641
462	1641
460	1641
467	1641
472	1641
508	1641
337	1642
338	1642
344	1642
358	1642
359	1642
360	1642
364	1642
373	1642
374	1642
406	1642
392	1642
402	1642
405	1642
420	1642
418	1642
407	1642
424	1642
433	1642
440	1642
443	1642
460	1642
490	1642
508	1642
337	1643
338	1643
352	1643
384	1643
406	1643
424	1643
445	1643
455	1643
468	1643
472	1643
337	1644
338	1644
344	1644
358	1644
359	1644
362	1644
363	1644
375	1644
373	1644
392	1644
402	1644
394	1644
405	1644
420	1644
418	1644
424	1644
429	1644
440	1644
438	1644
443	1644
460	1644
467	1644
472	1644
508	1644
616	1644
657	1644
337	1645
338	1645
373	1645
374	1645
384	1645
392	1645
394	1645
405	1645
420	1645
413	1645
419	1645
424	1645
440	1645
443	1645
455	1645
460	1645
468	1645
482	1645
490	1645
508	1645
616	1645
650	1645
645	1646
337	1647
338	1647
344	1647
352	1647
358	1647
363	1647
364	1647
375	1647
373	1647
374	1647
384	1647
399	1647
405	1647
407	1647
424	1647
433	1647
429	1647
440	1647
438	1647
443	1647
445	1647
455	1647
460	1647
467	1647
468	1647
472	1647
650	1647
337	1648
338	1648
354	1648
358	1648
362	1648
373	1648
374	1648
384	1648
392	1648
402	1648
405	1648
420	1648
413	1648
424	1648
433	1648
429	1648
438	1648
443	1648
455	1648
467	1648
472	1648
490	1648
508	1648
616	1648
344	1649
359	1649
363	1649
364	1649
375	1649
373	1649
374	1649
392	1649
394	1649
399	1649
405	1649
420	1649
419	1649
418	1649
407	1649
424	1649
429	1649
438	1649
443	1649
462	1649
460	1649
467	1649
468	1649
472	1649
508	1649
616	1649
650	1649
337	1650
338	1650
344	1650
358	1650
359	1650
363	1650
364	1650
371	1650
384	1650
406	1650
392	1650
405	1650
420	1650
413	1650
424	1650
433	1650
429	1650
438	1650
443	1650
472	1650
498	1650
508	1650
616	1650
657	1650
337	1651
338	1651
344	1651
348	1651
349	1651
362	1651
363	1651
364	1651
373	1651
374	1651
384	1651
402	1651
420	1651
418	1651
424	1651
433	1651
429	1651
438	1651
443	1651
462	1651
460	1651
468	1651
472	1651
490	1651
508	1651
662	1651
337	1652
338	1652
358	1652
359	1652
363	1652
370	1652
375	1652
374	1652
384	1652
406	1652
392	1652
394	1652
399	1652
405	1652
413	1652
407	1652
424	1652
429	1652
438	1652
443	1652
460	1652
467	1652
472	1652
508	1652
616	1652
650	1652
663	1652
337	1653
338	1653
344	1653
358	1653
359	1653
363	1653
364	1653
375	1653
374	1653
384	1653
392	1653
402	1653
394	1653
405	1653
419	1653
418	1653
424	1653
429	1653
438	1653
443	1653
460	1653
467	1653
490	1653
508	1653
337	1654
338	1654
344	1654
348	1654
352	1654
358	1654
359	1654
362	1654
364	1654
375	1654
374	1654
402	1654
420	1654
418	1654
424	1654
433	1654
429	1654
440	1654
438	1654
443	1654
445	1654
448	1654
460	1654
467	1654
472	1654
507	1654
508	1654
337	1655
338	1655
348	1655
358	1655
362	1655
364	1655
371	1655
375	1655
374	1655
384	1655
406	1655
392	1655
394	1655
420	1655
413	1655
419	1655
424	1655
433	1655
438	1655
443	1655
462	1655
472	1655
508	1655
337	1656
338	1656
352	1656
358	1656
359	1656
360	1656
362	1656
363	1656
364	1656
375	1656
374	1656
384	1656
397	1656
399	1656
405	1656
420	1656
407	1656
424	1656
433	1656
429	1656
438	1656
443	1656
445	1656
460	1656
467	1656
468	1656
472	1656
490	1656
508	1656
616	1656
337	1657
338	1657
344	1657
358	1657
359	1657
362	1657
363	1657
373	1657
384	1657
406	1657
402	1657
394	1657
399	1657
405	1657
400	1657
420	1657
418	1657
424	1657
429	1657
438	1657
443	1657
460	1657
467	1657
469	1657
472	1657
490	1657
508	1657
337	1658
338	1658
344	1658
348	1658
359	1658
360	1658
364	1658
370	1658
374	1658
384	1658
392	1658
402	1658
399	1658
405	1658
420	1658
419	1658
407	1658
424	1658
433	1658
443	1658
462	1658
460	1658
467	1658
472	1658
482	1658
490	1658
498	1658
508	1658
616	1658
650	1658
337	1659
338	1659
344	1659
358	1659
363	1659
364	1659
371	1659
384	1659
406	1659
402	1659
394	1659
399	1659
405	1659
420	1659
418	1659
407	1659
429	1659
438	1659
443	1659
460	1659
467	1659
472	1659
657	1659
337	1660
338	1660
344	1660
352	1660
358	1660
359	1660
375	1660
384	1660
406	1660
392	1660
402	1660
394	1660
399	1660
405	1660
400	1660
418	1660
424	1660
433	1660
438	1660
443	1660
445	1660
460	1660
467	1660
468	1660
472	1660
508	1660
616	1660
337	1661
338	1661
354	1661
359	1661
360	1661
362	1661
363	1661
364	1661
374	1661
384	1661
406	1661
402	1661
420	1661
413	1661
419	1661
407	1661
424	1661
440	1661
438	1661
443	1661
460	1661
467	1661
468	1661
472	1661
508	1661
344	1662
358	1662
360	1662
363	1662
364	1662
384	1662
402	1662
399	1662
405	1662
418	1662
424	1662
429	1662
440	1662
438	1662
443	1662
460	1662
467	1662
472	1662
482	1662
490	1662
497	1662
650	1662
664	1662
337	1663
338	1663
348	1663
358	1663
359	1663
360	1663
362	1663
364	1663
371	1663
375	1663
374	1663
384	1663
392	1663
394	1663
405	1663
413	1663
424	1663
429	1663
438	1663
443	1663
462	1663
460	1663
467	1663
472	1663
508	1663
650	1663
337	1664
338	1664
348	1664
352	1664
358	1664
359	1664
363	1664
364	1664
371	1664
375	1664
374	1664
384	1664
392	1664
405	1664
400	1664
412	1664
418	1664
424	1664
429	1664
440	1664
438	1664
443	1664
445	1664
460	1664
467	1664
468	1664
472	1664
497	1664
508	1664
337	1665
338	1665
344	1665
352	1665
360	1665
362	1665
364	1665
371	1665
374	1665
384	1665
397	1665
402	1665
394	1665
399	1665
405	1665
413	1665
419	1665
424	1665
438	1665
443	1665
445	1665
462	1665
460	1665
468	1665
472	1665
508	1665
358	1666
359	1666
363	1666
364	1666
370	1666
371	1666
375	1666
374	1666
406	1666
402	1666
399	1666
405	1666
420	1666
418	1666
424	1666
429	1666
438	1666
462	1666
460	1666
467	1666
472	1666
490	1666
508	1666
337	1667
338	1667
344	1667
358	1667
359	1667
362	1667
364	1667
371	1667
374	1667
384	1667
402	1667
394	1667
399	1667
405	1667
420	1667
418	1667
407	1667
424	1667
429	1667
438	1667
443	1667
460	1667
472	1667
657	1667
352	1668
358	1668
363	1668
364	1668
370	1668
371	1668
375	1668
374	1668
384	1668
406	1668
402	1668
413	1668
419	1668
424	1668
433	1668
438	1668
443	1668
445	1668
462	1668
460	1668
467	1668
468	1668
472	1668
665	1668
337	1669
338	1669
344	1669
348	1669
358	1669
359	1669
362	1669
364	1669
371	1669
374	1669
384	1669
402	1669
394	1669
405	1669
420	1669
418	1669
424	1669
429	1669
443	1669
460	1669
467	1669
468	1669
472	1669
344	1670
363	1670
364	1670
371	1670
375	1670
374	1670
384	1670
402	1670
399	1670
405	1670
420	1670
413	1670
424	1670
429	1670
443	1670
460	1670
467	1670
468	1670
508	1670
657	1670
337	1671
338	1671
344	1671
358	1671
359	1671
362	1671
363	1671
364	1671
370	1671
371	1671
374	1671
384	1671
402	1671
394	1671
405	1671
420	1671
418	1671
424	1671
429	1671
443	1671
460	1671
472	1671
490	1671
337	1672
338	1672
344	1672
352	1672
358	1672
359	1672
363	1672
364	1672
371	1672
375	1672
374	1672
384	1672
392	1672
402	1672
394	1672
399	1672
405	1672
400	1672
420	1672
418	1672
424	1672
429	1672
443	1672
445	1672
460	1672
468	1672
472	1672
482	1672
490	1672
508	1672
663	1672
337	1673
338	1673
358	1673
363	1673
364	1673
371	1673
375	1673
374	1673
384	1673
402	1673
405	1673
420	1673
413	1673
424	1673
429	1673
443	1673
460	1673
467	1673
472	1673
657	1673
402	1674
394	1674
443	1674
460	1674
482	1674
508	1674
599	1674
337	1675
338	1675
344	1675
358	1675
359	1675
364	1675
371	1675
374	1675
384	1675
392	1675
399	1675
405	1675
420	1675
413	1675
419	1675
407	1675
424	1675
429	1675
467	1675
468	1675
472	1675
508	1675
657	1675
344	1676
348	1676
352	1676
358	1676
359	1676
362	1676
364	1676
370	1676
375	1676
384	1676
392	1676
402	1676
394	1676
418	1676
424	1676
438	1676
443	1676
445	1676
460	1676
467	1676
468	1676
472	1676
508	1676
531	1676
337	1677
338	1677
358	1677
363	1677
370	1677
371	1677
374	1677
384	1677
392	1677
402	1677
399	1677
405	1677
420	1677
413	1677
407	1677
424	1677
429	1677
443	1677
460	1677
467	1677
468	1677
472	1677
508	1677
344	1678
348	1678
358	1678
360	1678
362	1678
364	1678
370	1678
371	1678
375	1678
374	1678
384	1678
392	1678
394	1678
405	1678
420	1678
418	1678
407	1678
424	1678
429	1678
443	1678
460	1678
508	1678
616	1678
344	1679
348	1679
358	1679
359	1679
360	1679
363	1679
364	1679
370	1679
371	1679
374	1679
384	1679
397	1679
402	1679
399	1679
405	1679
420	1679
418	1679
424	1679
429	1679
443	1679
462	1679
460	1679
467	1679
468	1679
508	1679
337	1680
338	1680
352	1680
358	1680
359	1680
370	1680
374	1680
384	1680
392	1680
402	1680
399	1680
405	1680
420	1680
413	1680
424	1680
429	1680
443	1680
445	1680
460	1680
467	1680
468	1680
472	1680
482	1680
507	1680
508	1680
665	1680
337	1681
338	1681
344	1681
348	1681
352	1681
358	1681
359	1681
360	1681
364	1681
374	1681
384	1681
402	1681
394	1681
405	1681
400	1681
420	1681
418	1681
424	1681
429	1681
443	1681
445	1681
462	1681
460	1681
467	1681
472	1681
508	1681
657	1681
337	1682
338	1682
344	1682
352	1682
358	1682
359	1682
360	1682
363	1682
364	1682
375	1682
374	1682
384	1682
392	1682
402	1682
399	1682
405	1682
424	1682
429	1682
443	1682
445	1682
462	1682
460	1682
468	1682
472	1682
508	1682
616	1682
657	1682
665	1682
337	1683
338	1683
344	1683
348	1683
358	1683
359	1683
360	1683
363	1683
370	1683
374	1683
384	1683
402	1683
394	1683
405	1683
420	1683
418	1683
424	1683
429	1683
460	1683
469	1683
468	1683
472	1683
507	1683
508	1683
616	1683
337	1684
338	1684
344	1684
352	1684
358	1684
359	1684
364	1684
370	1684
371	1684
375	1684
374	1684
384	1684
392	1684
394	1684
399	1684
405	1684
420	1684
413	1684
424	1684
429	1684
443	1684
445	1684
460	1684
467	1684
468	1684
507	1684
508	1684
657	1684
344	1685
348	1685
352	1685
358	1685
359	1685
360	1685
363	1685
370	1685
374	1685
384	1685
402	1685
399	1685
405	1685
418	1685
424	1685
429	1685
445	1685
457	1685
460	1685
468	1685
472	1685
482	1685
490	1685
531	1685
657	1685
337	1686
338	1686
344	1686
348	1686
352	1686
358	1686
359	1686
360	1686
370	1686
374	1686
384	1686
394	1686
405	1686
420	1686
418	1686
424	1686
429	1686
443	1686
445	1686
462	1686
460	1686
468	1686
508	1686
663	1686
665	1686
337	1687
338	1687
344	1687
352	1687
358	1687
360	1687
371	1687
374	1687
384	1687
402	1687
394	1687
405	1687
420	1687
419	1687
418	1687
424	1687
429	1687
443	1687
445	1687
448	1687
460	1687
468	1687
657	1687
669	1687
666	1687
667	1687
668	1687
337	1688
338	1688
358	1688
359	1688
371	1688
374	1688
384	1688
406	1688
392	1688
405	1688
400	1688
420	1688
413	1688
407	1688
424	1688
437	1688
443	1688
445	1688
462	1688
460	1688
465	1688
468	1688
507	1688
616	1688
669	1688
666	1688
670	1688
337	1689
338	1689
344	1689
348	1689
358	1689
363	1689
371	1689
374	1689
384	1689
397	1689
405	1689
420	1689
418	1689
416	1689
448	1689
460	1689
472	1689
482	1689
508	1689
657	1689
663	1689
665	1689
669	1689
666	1689
668	1689
671	1689
337	1690
338	1690
352	1690
358	1690
359	1690
374	1690
384	1690
402	1690
405	1690
420	1690
413	1690
419	1690
407	1690
424	1690
429	1690
445	1690
462	1690
460	1690
465	1690
468	1690
472	1690
507	1690
531	1690
663	1690
669	1690
666	1690
667	1690
668	1690
670	1690
337	1691
338	1691
344	1691
348	1691
358	1691
359	1691
371	1691
374	1691
384	1691
405	1691
420	1691
413	1691
419	1691
429	1691
443	1691
460	1691
465	1691
468	1691
508	1691
657	1691
665	1691
669	1691
666	1691
670	1691
671	1691
337	1692
338	1692
344	1692
348	1692
352	1692
358	1692
359	1692
371	1692
375	1692
384	1692
405	1692
418	1692
424	1692
429	1692
445	1692
460	1692
508	1692
657	1692
669	1692
666	1692
671	1692
337	1693
338	1693
344	1693
348	1693
352	1693
358	1693
371	1693
375	1693
384	1693
402	1693
394	1693
405	1693
420	1693
418	1693
429	1693
445	1693
462	1693
460	1693
472	1693
508	1693
669	1693
666	1693
667	1693
671	1693
337	1694
338	1694
344	1694
348	1694
358	1694
359	1694
363	1694
371	1694
374	1694
384	1694
392	1694
405	1694
420	1694
413	1694
419	1694
407	1694
429	1694
443	1694
462	1694
460	1694
465	1694
472	1694
508	1694
636	1694
669	1694
666	1694
667	1694
668	1694
671	1694
672	1694
337	1695
338	1695
344	1695
348	1695
352	1695
358	1695
359	1695
375	1695
374	1695
384	1695
402	1695
394	1695
405	1695
400	1695
420	1695
418	1695
437	1695
443	1695
445	1695
462	1695
460	1695
467	1695
468	1695
508	1695
616	1695
657	1695
669	1695
666	1695
667	1695
668	1695
337	1696
338	1696
344	1696
348	1696
352	1696
359	1696
371	1696
374	1696
384	1696
402	1696
405	1696
420	1696
413	1696
418	1696
416	1696
429	1696
437	1696
445	1696
460	1696
465	1696
467	1696
468	1696
508	1696
657	1696
669	1696
666	1696
667	1696
348	1697
352	1697
363	1697
371	1697
374	1697
384	1697
392	1697
402	1697
405	1697
420	1697
413	1697
407	1697
437	1697
443	1697
445	1697
462	1697
465	1697
467	1697
468	1697
472	1697
508	1697
657	1697
665	1697
669	1697
666	1697
667	1697
668	1697
671	1697
337	1698
338	1698
344	1698
348	1698
352	1698
358	1698
359	1698
371	1698
375	1698
374	1698
384	1698
402	1698
405	1698
400	1698
420	1698
418	1698
429	1698
445	1698
460	1698
465	1698
467	1698
468	1698
508	1698
616	1698
657	1698
669	1698
666	1698
667	1698
671	1698
337	1699
338	1699
358	1699
371	1699
374	1699
384	1699
402	1699
394	1699
405	1699
420	1699
413	1699
407	1699
429	1699
437	1699
462	1699
460	1699
465	1699
467	1699
636	1699
669	1699
666	1699
667	1699
672	1699
337	1700
338	1700
344	1700
348	1700
358	1700
359	1700
371	1700
375	1700
374	1700
384	1700
402	1700
394	1700
405	1700
420	1700
418	1700
416	1700
443	1700
445	1700
448	1700
462	1700
460	1700
465	1700
467	1700
507	1700
508	1700
665	1700
669	1700
666	1700
667	1700
668	1700
337	1701
338	1701
344	1701
352	1701
358	1701
359	1701
371	1701
384	1701
402	1701
394	1701
405	1701
400	1701
420	1701
413	1701
443	1701
445	1701
460	1701
465	1701
508	1701
616	1701
669	1701
666	1701
667	1701
671	1701
344	1702
371	1702
375	1702
384	1702
418	1702
429	1702
508	1702
666	1702
337	1703
338	1703
344	1703
371	1703
374	1703
384	1703
402	1703
405	1703
420	1703
413	1703
429	1703
443	1703
462	1703
460	1703
468	1703
482	1703
490	1703
616	1703
636	1703
669	1703
666	1703
667	1703
671	1703
337	1704
338	1704
344	1704
352	1704
358	1704
359	1704
360	1704
363	1704
384	1704
394	1704
418	1704
429	1704
443	1704
445	1704
448	1704
460	1704
465	1704
467	1704
472	1704
508	1704
669	1704
666	1704
667	1704
344	1705
352	1705
358	1705
359	1705
360	1705
371	1705
375	1705
384	1705
392	1705
394	1705
405	1705
420	1705
413	1705
437	1705
443	1705
445	1705
457	1705
460	1705
465	1705
468	1705
508	1705
616	1705
636	1705
665	1705
669	1705
666	1705
671	1705
337	1706
338	1706
344	1706
348	1706
359	1706
363	1706
371	1706
374	1706
384	1706
406	1706
392	1706
405	1706
420	1706
418	1706
429	1706
437	1706
457	1706
462	1706
460	1706
465	1706
467	1706
468	1706
507	1706
508	1706
669	1706
666	1706
667	1706
344	1707
358	1707
359	1707
360	1707
363	1707
371	1707
375	1707
384	1707
392	1707
405	1707
420	1707
413	1707
457	1707
462	1707
460	1707
465	1707
508	1707
636	1707
666	1707
667	1707
671	1707
337	1708
338	1708
344	1708
348	1708
352	1708
358	1708
359	1708
371	1708
384	1708
394	1708
405	1708
400	1708
420	1708
418	1708
429	1708
437	1708
443	1708
445	1708
460	1708
467	1708
468	1708
508	1708
669	1708
666	1708
337	1709
338	1709
344	1709
352	1709
359	1709
360	1709
371	1709
384	1709
406	1709
405	1709
420	1709
418	1709
429	1709
443	1709
445	1709
457	1709
462	1709
460	1709
472	1709
665	1709
669	1709
666	1709
667	1709
668	1709
671	1709
673	1709
337	1710
338	1710
358	1710
360	1710
363	1710
371	1710
375	1710
384	1710
392	1710
394	1710
405	1710
420	1710
437	1710
443	1710
457	1710
460	1710
465	1710
467	1710
468	1710
616	1710
669	1710
666	1710
668	1710
671	1710
344	1711
348	1711
352	1711
358	1711
374	1711
384	1711
394	1711
400	1711
418	1711
437	1711
445	1711
457	1711
462	1711
460	1711
467	1711
482	1711
665	1711
669	1711
666	1711
375	1712
384	1712
392	1712
416	1712
429	1712
457	1712
465	1712
469	1712
502	1712
531	1712
532	1712
553	1712
666	1712
667	1712
670	1712
676	1712
675	1712
674	1712
337	1713
338	1713
344	1713
352	1713
360	1713
374	1713
384	1713
392	1713
405	1713
413	1713
437	1713
443	1713
445	1713
457	1713
460	1713
468	1713
472	1713
508	1713
665	1713
669	1713
666	1713
667	1713
668	1713
337	1714
338	1714
358	1714
359	1714
363	1714
371	1714
374	1714
384	1714
406	1714
392	1714
394	1714
405	1714
420	1714
407	1714
429	1714
437	1714
443	1714
457	1714
462	1714
460	1714
467	1714
469	1714
472	1714
616	1714
636	1714
669	1714
666	1714
668	1714
671	1714
344	1715
348	1715
352	1715
358	1715
359	1715
360	1715
371	1715
375	1715
384	1715
394	1715
405	1715
400	1715
420	1715
418	1715
429	1715
443	1715
445	1715
457	1715
462	1715
460	1715
465	1715
467	1715
468	1715
665	1715
669	1715
666	1715
667	1715
668	1715
337	1716
338	1716
352	1716
359	1716
371	1716
375	1716
374	1716
420	1716
429	1716
443	1716
445	1716
460	1716
465	1716
467	1716
472	1716
665	1716
666	1716
667	1716
337	1717
338	1717
344	1717
352	1717
359	1717
371	1717
374	1717
384	1717
392	1717
394	1717
405	1717
420	1717
429	1717
443	1717
445	1717
462	1717
465	1717
468	1717
472	1717
508	1717
665	1717
669	1717
666	1717
667	1717
677	1717
337	1718
338	1718
344	1718
352	1718
358	1718
359	1718
371	1718
374	1718
384	1718
397	1718
392	1718
394	1718
405	1718
420	1718
418	1718
429	1718
438	1718
443	1718
445	1718
442	1718
469	1718
468	1718
472	1718
508	1718
583	1718
665	1718
669	1718
666	1718
667	1718
337	1719
338	1719
360	1719
363	1719
371	1719
375	1719
374	1719
384	1719
406	1719
392	1719
405	1719
420	1719
413	1719
416	1719
443	1719
462	1719
472	1719
508	1719
514	1719
616	1719
665	1719
666	1719
671	1719
679	1719
678	1719
344	1720
348	1720
352	1720
358	1720
359	1720
374	1720
384	1720
397	1720
394	1720
405	1720
400	1720
420	1720
412	1720
418	1720
429	1720
437	1720
443	1720
445	1720
462	1720
468	1720
472	1720
508	1720
665	1720
666	1720
667	1720
678	1720
344	1721
352	1721
358	1721
359	1721
363	1721
371	1721
375	1721
374	1721
384	1721
406	1721
394	1721
405	1721
420	1721
418	1721
429	1721
443	1721
445	1721
462	1721
465	1721
507	1721
508	1721
666	1721
667	1721
670	1721
678	1721
344	1722
352	1722
359	1722
371	1722
374	1722
384	1722
397	1722
392	1722
405	1722
420	1722
429	1722
437	1722
443	1722
445	1722
468	1722
472	1722
508	1722
666	1722
671	1722
678	1722
344	1723
352	1723
358	1723
359	1723
360	1723
363	1723
371	1723
374	1723
406	1723
392	1723
405	1723
420	1723
429	1723
437	1723
443	1723
445	1723
468	1723
472	1723
482	1723
502	1723
508	1723
665	1723
666	1723
667	1723
678	1723
337	1724
338	1724
344	1724
348	1724
358	1724
359	1724
371	1724
374	1724
384	1724
397	1724
394	1724
400	1724
420	1724
412	1724
418	1724
407	1724
443	1724
462	1724
468	1724
472	1724
616	1724
666	1724
667	1724
678	1724
344	1725
352	1725
358	1725
359	1725
363	1725
371	1725
375	1725
374	1725
384	1725
392	1725
405	1725
420	1725
413	1725
429	1725
437	1725
443	1725
445	1725
462	1725
468	1725
472	1725
507	1725
508	1725
616	1725
665	1725
666	1725
667	1725
670	1725
671	1725
680	1725
344	1726
358	1726
360	1726
371	1726
374	1726
400	1726
420	1726
418	1726
429	1726
443	1726
468	1726
472	1726
490	1726
502	1726
507	1726
508	1726
616	1726
665	1726
666	1726
678	1726
352	1727
359	1727
363	1727
371	1727
375	1727
374	1727
384	1727
397	1727
406	1727
405	1727
420	1727
416	1727
407	1727
429	1727
443	1727
445	1727
462	1727
472	1727
490	1727
502	1727
508	1727
666	1727
667	1727
344	1728
348	1728
352	1728
358	1728
359	1728
371	1728
374	1728
420	1728
412	1728
418	1728
429	1728
437	1728
443	1728
445	1728
462	1728
468	1728
507	1728
508	1728
616	1728
666	1728
681	1728
337	1729
344	1729
352	1729
358	1729
359	1729
360	1729
371	1729
375	1729
374	1729
384	1729
392	1729
405	1729
420	1729
418	1729
429	1729
443	1729
445	1729
462	1729
468	1729
472	1729
508	1729
665	1729
344	1730
348	1730
352	1730
358	1730
359	1730
360	1730
363	1730
371	1730
374	1730
384	1730
400	1730
420	1730
412	1730
418	1730
407	1730
429	1730
443	1730
445	1730
462	1730
468	1730
472	1730
508	1730
616	1730
665	1730
344	1731
349	1731
352	1731
358	1731
360	1731
363	1731
375	1731
374	1731
384	1731
406	1731
394	1731
405	1731
420	1731
413	1731
443	1731
445	1731
468	1731
472	1731
490	1731
508	1731
616	1731
665	1731
337	1732
338	1732
344	1732
358	1732
359	1732
374	1732
384	1732
394	1732
420	1732
418	1732
429	1732
443	1732
462	1732
472	1732
616	1732
344	1733
358	1733
359	1733
371	1733
374	1733
397	1733
392	1733
394	1733
405	1733
420	1733
429	1733
443	1733
462	1733
468	1733
472	1733
490	1733
508	1733
682	1733
344	1734
352	1734
358	1734
371	1734
375	1734
374	1734
384	1734
405	1734
429	1734
445	1734
462	1734
472	1734
490	1734
344	1735
352	1735
358	1735
359	1735
360	1735
363	1735
371	1735
374	1735
384	1735
406	1735
392	1735
394	1735
405	1735
420	1735
413	1735
418	1735
407	1735
429	1735
443	1735
445	1735
462	1735
468	1735
472	1735
490	1735
507	1735
508	1735
556	1735
616	1735
348	1736
352	1736
358	1736
359	1736
360	1736
363	1736
371	1736
375	1736
374	1736
384	1736
397	1736
392	1736
394	1736
405	1736
412	1736
418	1736
429	1736
443	1736
445	1736
468	1736
472	1736
507	1736
508	1736
616	1736
657	1736
352	1737
363	1737
371	1737
384	1737
405	1737
413	1737
414	1737
445	1737
490	1737
344	1738
352	1738
358	1738
359	1738
371	1738
375	1738
384	1738
392	1738
394	1738
405	1738
420	1738
429	1738
443	1738
445	1738
462	1738
468	1738
472	1738
507	1738
508	1738
616	1738
344	1739
348	1739
352	1739
358	1739
359	1739
363	1739
371	1739
374	1739
384	1739
406	1739
392	1739
394	1739
405	1739
420	1739
412	1739
418	1739
429	1739
443	1739
445	1739
462	1739
468	1739
472	1739
508	1739
352	1740
358	1740
359	1740
360	1740
363	1740
371	1740
375	1740
374	1740
384	1740
405	1740
420	1740
429	1740
445	1740
462	1740
468	1740
472	1740
507	1740
508	1740
599	1740
616	1740
344	1741
348	1741
358	1741
359	1741
360	1741
371	1741
375	1741
374	1741
384	1741
394	1741
405	1741
418	1741
429	1741
443	1741
462	1741
468	1741
472	1741
482	1741
490	1741
507	1741
616	1741
337	1742
338	1742
344	1742
359	1742
360	1742
363	1742
371	1742
374	1742
384	1742
397	1742
405	1742
420	1742
413	1742
414	1742
443	1742
455	1742
468	1742
472	1742
490	1742
616	1742
344	1743
352	1743
358	1743
359	1743
360	1743
371	1743
375	1743
384	1743
406	1743
392	1743
394	1743
405	1743
420	1743
443	1743
445	1743
468	1743
472	1743
507	1743
616	1743
358	1744
359	1744
360	1744
363	1744
371	1744
375	1744
374	1744
384	1744
397	1744
394	1744
405	1744
420	1744
429	1744
468	1744
472	1744
482	1744
490	1744
507	1744
508	1744
616	1744
682	1744
344	1745
358	1745
359	1745
360	1745
371	1745
374	1745
384	1745
392	1745
394	1745
405	1745
420	1745
413	1745
414	1745
462	1745
468	1745
482	1745
490	1745
508	1745
616	1745
670	1745
344	1746
352	1746
358	1746
359	1746
360	1746
371	1746
375	1746
374	1746
384	1746
397	1746
406	1746
392	1746
405	1746
400	1746
420	1746
407	1746
429	1746
445	1746
462	1746
468	1746
472	1746
507	1746
508	1746
616	1746
682	1746
337	1747
338	1747
344	1747
352	1747
360	1747
375	1747
384	1747
394	1747
405	1747
420	1747
414	1747
418	1747
429	1747
437	1747
443	1747
445	1747
462	1747
465	1747
508	1747
614	1747
666	1747
683	1747
352	1748
360	1748
384	1748
406	1748
392	1748
394	1748
414	1748
407	1748
437	1748
445	1748
465	1748
508	1748
616	1748
671	1748
683	1748
348	1749
358	1749
360	1749
363	1749
364	1749
375	1749
384	1749
406	1749
394	1749
400	1749
412	1749
418	1749
429	1749
437	1749
443	1749
462	1749
616	1749
666	1749
667	1749
683	1749
337	1750
338	1750
344	1750
358	1750
360	1750
384	1750
400	1750
420	1750
418	1750
416	1750
424	1750
429	1750
437	1750
462	1750
490	1750
533	1750
616	1750
666	1750
344	1751
352	1751
358	1751
360	1751
375	1751
384	1751
406	1751
394	1751
405	1751
418	1751
407	1751
424	1751
429	1751
437	1751
443	1751
445	1751
462	1751
490	1751
614	1751
616	1751
666	1751
337	1752
338	1752
344	1752
352	1752
358	1752
360	1752
375	1752
405	1752
420	1752
424	1752
429	1752
437	1752
443	1752
445	1752
462	1752
471	1752
490	1752
614	1752
657	1752
666	1752
667	1752
344	1753
358	1753
360	1753
363	1753
375	1753
384	1753
406	1753
394	1753
405	1753
420	1753
419	1753
414	1753
418	1753
416	1753
614	1753
616	1753
666	1753
344	1754
348	1754
352	1754
358	1754
375	1754
394	1754
405	1754
400	1754
420	1754
412	1754
418	1754
429	1754
443	1754
445	1754
490	1754
616	1754
666	1754
337	1755
338	1755
344	1755
352	1755
358	1755
360	1755
375	1755
384	1755
394	1755
420	1755
416	1755
429	1755
437	1755
443	1755
445	1755
614	1755
616	1755
666	1755
667	1755
337	1756
338	1756
344	1756
352	1756
358	1756
363	1756
364	1756
375	1756
384	1756
394	1756
405	1756
420	1756
413	1756
407	1756
429	1756
437	1756
443	1756
445	1756
462	1756
471	1756
490	1756
614	1756
616	1756
657	1756
666	1756
337	1757
338	1757
352	1757
358	1757
363	1757
375	1757
384	1757
394	1757
405	1757
420	1757
424	1757
437	1757
445	1757
462	1757
465	1757
471	1757
490	1757
614	1757
616	1757
657	1757
667	1757
681	1757
682	1757
337	1758
338	1758
348	1758
363	1758
375	1758
384	1758
397	1758
405	1758
400	1758
420	1758
412	1758
419	1758
418	1758
437	1758
490	1758
614	1758
657	1758
337	1759
338	1759
344	1759
358	1759
360	1759
363	1759
375	1759
384	1759
394	1759
405	1759
420	1759
419	1759
416	1759
407	1759
424	1759
465	1759
490	1759
616	1759
667	1759
681	1759
344	1760
352	1760
358	1760
360	1760
363	1760
384	1760
394	1760
405	1760
400	1760
420	1760
418	1760
424	1760
445	1760
614	1760
616	1760
657	1760
671	1760
337	1761
338	1761
344	1761
358	1761
360	1761
364	1761
375	1761
384	1761
389	1761
397	1761
394	1761
391	1761
405	1761
408	1761
420	1761
419	1761
407	1761
445	1761
467	1761
482	1761
490	1761
503	1761
508	1761
533	1761
614	1761
616	1761
631	1761
671	1761
684	1761
344	1762
348	1762
352	1762
358	1762
360	1762
363	1762
364	1762
375	1762
384	1762
389	1762
394	1762
405	1762
400	1762
412	1762
413	1762
419	1762
414	1762
418	1762
443	1762
445	1762
508	1762
514	1762
614	1762
616	1762
681	1762
337	1763
338	1763
344	1763
358	1763
360	1763
363	1763
364	1763
375	1763
384	1763
394	1763
405	1763
420	1763
416	1763
407	1763
471	1763
490	1763
614	1763
616	1763
657	1763
667	1763
687	1763
688	1763
686	1763
685	1763
337	1764
338	1764
352	1764
358	1764
363	1764
375	1764
384	1764
394	1764
405	1764
400	1764
420	1764
413	1764
437	1764
445	1764
465	1764
471	1764
508	1764
614	1764
657	1764
671	1764
337	1765
338	1765
344	1765
352	1765
375	1765
394	1765
405	1765
420	1765
419	1765
445	1765
465	1765
482	1765
508	1765
614	1765
616	1765
657	1765
667	1765
681	1765
684	1765
344	1766
352	1766
358	1766
360	1766
363	1766
384	1766
394	1766
405	1766
420	1766
407	1766
445	1766
465	1766
467	1766
490	1766
614	1766
616	1766
657	1766
667	1766
337	1767
338	1767
358	1767
360	1767
363	1767
375	1767
384	1767
394	1767
420	1767
465	1767
467	1767
490	1767
508	1767
614	1767
616	1767
657	1767
667	1767
344	1768
348	1768
352	1768
360	1768
364	1768
375	1768
394	1768
405	1768
400	1768
420	1768
418	1768
407	1768
437	1768
445	1768
465	1768
471	1768
490	1768
614	1768
616	1768
337	1769
338	1769
344	1769
358	1769
375	1769
420	1769
440	1769
465	1769
482	1769
616	1769
667	1769
684	1769
344	1770
363	1770
364	1770
375	1770
384	1770
394	1770
405	1770
420	1770
416	1770
437	1770
445	1770
462	1770
465	1770
471	1770
508	1770
514	1770
614	1770
616	1770
657	1770
338	1771
344	1771
352	1771
363	1771
375	1771
384	1771
405	1771
420	1771
437	1771
443	1771
445	1771
465	1771
467	1771
471	1771
490	1771
508	1771
667	1771
684	1771
337	1772
338	1772
344	1772
348	1772
352	1772
358	1772
363	1772
364	1772
375	1772
384	1772
405	1772
400	1772
420	1772
412	1772
418	1772
445	1772
490	1772
614	1772
616	1772
657	1772
667	1772
684	1772
344	1773
348	1773
360	1773
375	1773
384	1773
394	1773
405	1773
420	1773
407	1773
437	1773
462	1773
465	1773
467	1773
471	1773
490	1773
614	1773
616	1773
684	1773
344	1774
348	1774
352	1774
358	1774
360	1774
363	1774
375	1774
384	1774
394	1774
405	1774
400	1774
420	1774
418	1774
416	1774
445	1774
467	1774
482	1774
490	1774
614	1774
616	1774
667	1774
337	1775
338	1775
344	1775
358	1775
360	1775
363	1775
375	1775
384	1775
394	1775
405	1775
420	1775
407	1775
465	1775
503	1775
508	1775
614	1775
616	1775
657	1775
667	1775
337	1776
338	1776
344	1776
352	1776
360	1776
375	1776
384	1776
394	1776
405	1776
420	1776
413	1776
414	1776
445	1776
465	1776
467	1776
490	1776
508	1776
657	1776
667	1776
684	1776
337	1777
338	1777
348	1777
352	1777
358	1777
384	1777
394	1777
405	1777
420	1777
414	1777
445	1777
490	1777
614	1777
616	1777
667	1777
344	1778
352	1778
360	1778
375	1778
384	1778
394	1778
405	1778
420	1778
445	1778
448	1778
465	1778
467	1778
471	1778
490	1778
503	1778
508	1778
616	1778
626	1778
671	1778
689	1778
337	1779
338	1779
344	1779
352	1779
358	1779
375	1779
384	1779
394	1779
405	1779
400	1779
420	1779
418	1779
416	1779
437	1779
445	1779
462	1779
482	1779
514	1779
616	1779
681	1779
344	1780
358	1780
363	1780
375	1780
384	1780
394	1780
405	1780
420	1780
419	1780
414	1780
407	1780
445	1780
465	1780
467	1780
490	1780
614	1780
616	1780
667	1780
690	1780
344	1781
352	1781
375	1781
384	1781
394	1781
405	1781
420	1781
418	1781
407	1781
445	1781
467	1781
490	1781
508	1781
514	1781
614	1781
667	1781
352	1782
358	1782
394	1782
445	1782
508	1782
533	1782
614	1782
616	1782
344	1783
358	1783
360	1783
363	1783
375	1783
384	1783
394	1783
405	1783
420	1783
416	1783
407	1783
440	1783
437	1783
465	1783
614	1783
616	1783
667	1783
337	1784
338	1784
344	1784
348	1784
352	1784
358	1784
360	1784
375	1784
384	1784
394	1784
405	1784
400	1784
420	1784
418	1784
407	1784
437	1784
445	1784
467	1784
490	1784
616	1784
636	1784
681	1784
416	1785
616	1785
344	1786
358	1786
375	1786
394	1786
405	1786
400	1786
420	1786
407	1786
465	1786
467	1786
490	1786
614	1786
616	1786
671	1786
344	1787
358	1787
375	1787
394	1787
405	1787
400	1787
420	1787
407	1787
465	1787
467	1787
490	1787
614	1787
616	1787
671	1787
344	1788
358	1788
375	1788
384	1788
394	1788
400	1788
420	1788
418	1788
465	1788
467	1788
490	1788
508	1788
514	1788
614	1788
616	1788
667	1788
344	1789
352	1789
358	1789
360	1789
363	1789
364	1789
375	1789
384	1789
394	1789
391	1789
405	1789
420	1789
416	1789
445	1789
465	1789
467	1789
490	1789
514	1789
614	1789
616	1789
667	1789
337	1790
338	1790
344	1790
352	1790
358	1790
364	1790
375	1790
384	1790
394	1790
405	1790
400	1790
420	1790
419	1790
418	1790
407	1790
437	1790
445	1790
465	1790
467	1790
490	1790
616	1790
667	1790
337	1791
338	1791
344	1791
358	1791
360	1791
364	1791
375	1791
384	1791
389	1791
394	1791
405	1791
400	1791
420	1791
407	1791
465	1791
467	1791
482	1791
490	1791
508	1791
514	1791
616	1791
667	1791
690	1791
344	1792
348	1792
352	1792
358	1792
364	1792
375	1792
384	1792
389	1792
394	1792
405	1792
400	1792
420	1792
412	1792
418	1792
416	1792
437	1792
445	1792
467	1792
490	1792
614	1792
667	1792
337	1793
338	1793
344	1793
348	1793
360	1793
363	1793
364	1793
375	1793
384	1793
394	1793
400	1793
420	1793
412	1793
418	1793
465	1793
467	1793
490	1793
502	1793
631	1793
671	1793
690	1793
344	1794
352	1794
358	1794
375	1794
384	1794
394	1794
405	1794
400	1794
420	1794
413	1794
414	1794
407	1794
437	1794
445	1794
455	1794
467	1794
471	1794
490	1794
614	1794
616	1794
671	1794
337	1795
338	1795
344	1795
352	1795
405	1795
416	1795
445	1795
465	1795
614	1795
337	1796
338	1796
344	1796
348	1796
352	1796
360	1796
405	1796
420	1796
416	1796
407	1796
445	1796
465	1796
614	1796
671	1796
337	1797
338	1797
358	1797
406	1797
420	1797
482	1797
490	1797
508	1797
614	1797
671	1797
337	1798
338	1798
344	1798
358	1798
360	1798
397	1798
405	1798
420	1798
407	1798
440	1798
448	1798
482	1798
502	1798
614	1798
646	1798
682	1798
337	1799
338	1799
360	1799
397	1799
405	1799
407	1799
448	1799
462	1799
465	1799
682	1799
337	1800
338	1800
344	1800
358	1800
360	1800
405	1800
420	1800
419	1800
407	1800
462	1800
465	1800
482	1800
502	1800
508	1800
610	1800
616	1800
671	1800
682	1800
337	1801
338	1801
344	1801
352	1801
354	1801
358	1801
360	1801
406	1801
405	1801
420	1801
414	1801
416	1801
440	1801
445	1801
465	1801
471	1801
503	1801
610	1801
614	1801
616	1801
671	1801
337	1802
338	1802
344	1802
358	1802
362	1802
397	1802
391	1802
420	1802
419	1802
448	1802
455	1802
462	1802
471	1802
482	1802
508	1802
599	1802
690	1802
691	1802
358	1803
360	1803
406	1803
420	1803
407	1803
448	1803
465	1803
508	1803
514	1803
610	1803
616	1803
337	1804
338	1804
344	1804
352	1804
358	1804
406	1804
414	1804
407	1804
445	1804
465	1804
471	1804
614	1804
344	1805
352	1805
358	1805
360	1805
406	1805
405	1805
420	1805
419	1805
418	1805
433	1805
445	1805
448	1805
465	1805
508	1805
616	1805
667	1805
416	1806
692	1806
338	1807
344	1807
352	1807
362	1807
420	1807
418	1807
407	1807
445	1807
462	1807
471	1807
482	1807
514	1807
614	1807
646	1808
682	1808
338	1809
438	1809
443	1809
469	1809
631	1809
645	1809
693	1809
694	1809
344	1810
352	1810
420	1810
414	1810
418	1810
440	1810
445	1810
449	1810
469	1810
514	1810
695	1810
337	1811
338	1811
344	1811
352	1811
358	1811
362	1811
420	1811
418	1811
407	1811
445	1811
462	1811
465	1811
471	1811
482	1811
514	1811
599	1811
614	1811
337	1812
338	1812
344	1812
352	1812
358	1812
360	1812
405	1812
420	1812
440	1812
445	1812
462	1812
465	1812
469	1812
471	1812
482	1812
531	1812
577	1812
614	1812
671	1812
682	1812
696	1812
348	1813
352	1813
418	1813
636	1813
354	1814
391	1814
419	1814
471	1814
579	1814
610	1814
338	1815
344	1815
352	1815
358	1815
362	1815
389	1815
420	1815
413	1815
419	1815
407	1815
440	1815
443	1815
445	1815
448	1815
465	1815
497	1815
583	1815
605	1815
631	1815
635	1815
685	1815
700	1815
699	1815
697	1815
701	1815
698	1815
337	1816
338	1816
344	1816
348	1816
354	1816
360	1816
389	1816
406	1816
405	1816
420	1816
418	1816
407	1816
437	1816
443	1816
462	1816
465	1816
471	1816
482	1816
508	1816
514	1816
558	1816
559	1816
610	1816
671	1816
697	1816
337	1817
338	1817
344	1817
348	1817
352	1817
358	1817
362	1817
397	1817
406	1817
405	1817
408	1817
420	1817
416	1817
407	1817
433	1817
443	1817
445	1817
455	1817
465	1817
514	1817
610	1817
631	1817
636	1817
681	1817
701	1817
702	1817
337	1818
338	1818
344	1818
352	1818
413	1818
414	1818
418	1818
445	1818
471	1818
614	1818
670	1818
337	1819
338	1819
358	1819
360	1819
406	1819
407	1819
411	1819
448	1819
471	1819
614	1819
631	1819
691	1819
348	1820
352	1820
405	1820
420	1820
414	1820
418	1820
437	1820
445	1820
465	1820
471	1820
646	1820
667	1820
337	1821
338	1821
344	1821
352	1821
362	1821
414	1821
416	1821
445	1821
455	1821
462	1821
502	1821
508	1821
583	1821
671	1821
344	1822
358	1822
360	1822
405	1822
420	1822
465	1822
482	1822
667	1822
352	1823
354	1823
358	1823
362	1823
420	1823
414	1823
416	1823
445	1823
465	1823
482	1823
583	1823
671	1823
337	1824
338	1824
344	1824
352	1824
358	1824
405	1824
420	1824
418	1824
407	1824
445	1824
455	1824
465	1824
471	1824
614	1824
337	1825
338	1825
344	1825
352	1825
358	1825
405	1825
420	1825
412	1825
413	1825
414	1825
418	1825
416	1825
407	1825
445	1825
455	1825
465	1825
482	1825
614	1825
671	1825
352	1826
419	1826
414	1826
416	1826
407	1826
465	1826
692	1826
352	1827
420	1827
413	1827
419	1827
414	1827
445	1827
455	1827
471	1827
583	1827
670	1827
671	1827
691	1827
344	1828
348	1828
352	1828
358	1828
405	1828
420	1828
412	1828
418	1828
445	1828
455	1828
482	1828
610	1828
614	1828
416	1829
583	1829
337	1830
338	1830
344	1830
406	1830
405	1830
420	1830
407	1830
465	1830
482	1830
667	1830
691	1830
338	1831
362	1831
389	1831
420	1831
419	1831
407	1831
437	1831
455	1831
348	1832
358	1832
408	1832
420	1832
412	1832
413	1832
419	1832
418	1832
416	1832
492	1832
514	1832
533	1832
646	1832
337	1833
338	1833
344	1833
352	1833
354	1833
358	1833
360	1833
362	1833
389	1833
406	1833
405	1833
420	1833
407	1833
453	1833
455	1833
462	1833
465	1833
471	1833
521	1833
533	1833
596	1833
610	1833
631	1833
635	1833
636	1833
670	1833
690	1833
352	1834
358	1834
360	1834
362	1834
405	1834
413	1834
419	1834
414	1834
416	1834
433	1834
453	1834
455	1834
459	1834
482	1834
521	1834
610	1834
635	1834
681	1834
690	1834
704	1834
703	1834
705	1834
344	1835
352	1835
358	1835
397	1835
406	1835
405	1835
414	1835
455	1835
465	1835
533	1835
583	1835
682	1835
691	1835
697	1835
706	1835
337	1836
338	1836
344	1836
352	1836
358	1836
362	1836
389	1836
406	1836
391	1836
405	1836
420	1836
414	1836
416	1836
453	1836
455	1836
465	1836
482	1836
558	1836
559	1836
631	1836
635	1836
690	1836
698	1836
704	1836
705	1836
707	1836
406	1837
420	1837
407	1837
455	1837
690	1837
337	1838
338	1838
344	1838
352	1838
358	1838
360	1838
362	1838
389	1838
406	1838
391	1838
405	1838
420	1838
414	1838
416	1838
453	1838
455	1838
482	1838
558	1838
559	1838
631	1838
635	1838
690	1838
698	1838
704	1838
705	1838
707	1838
344	1839
352	1839
354	1839
362	1839
389	1839
406	1839
405	1839
420	1839
407	1839
448	1839
453	1839
471	1839
583	1839
631	1839
635	1839
667	1839
682	1839
697	1839
704	1839
705	1839
706	1839
344	1840
354	1840
362	1840
694	1840
705	1840
362	1841
443	1841
448	1841
455	1841
471	1841
521	1841
610	1841
631	1841
635	1841
692	1841
704	1841
705	1841
707	1841
709	1841
708	1841
448	1842
455	1842
521	1842
635	1842
705	1842
709	1842
337	1843
338	1843
352	1843
354	1843
360	1843
420	1843
414	1843
416	1843
407	1843
455	1843
337	1844
338	1844
348	1844
358	1844
360	1844
362	1844
397	1844
420	1844
412	1844
418	1844
407	1844
433	1844
443	1844
448	1844
453	1844
455	1844
465	1844
558	1844
610	1844
631	1844
646	1844
690	1844
337	1845
338	1845
348	1845
354	1845
358	1845
362	1845
412	1845
418	1845
416	1845
448	1845
455	1845
471	1845
482	1845
492	1845
558	1845
583	1845
631	1845
635	1845
681	1845
690	1845
698	1845
706	1845
707	1845
710	1845
711	1845
337	1846
338	1846
352	1846
358	1846
360	1846
362	1846
391	1846
420	1846
419	1846
453	1846
465	1846
471	1846
492	1846
635	1846
670	1846
704	1846
705	1846
709	1846
712	1846
337	1847
338	1847
348	1847
352	1847
354	1847
358	1847
391	1847
408	1847
412	1847
418	1847
465	1847
482	1847
646	1847
690	1847
352	1848
360	1848
420	1848
419	1848
407	1848
411	1848
448	1848
465	1848
670	1848
690	1848
703	1848
705	1848
337	1849
338	1849
348	1849
358	1849
360	1849
397	1849
404	1849
408	1849
420	1849
412	1849
415	1849
418	1849
407	1849
448	1849
465	1849
471	1849
492	1849
583	1849
614	1849
646	1849
690	1849
455	1850
614	1850
690	1850
337	1851
338	1851
348	1851
354	1851
358	1851
391	1851
408	1851
418	1851
465	1851
482	1851
646	1851
690	1851
337	1852
338	1852
352	1852
354	1852
358	1852
405	1852
413	1852
414	1852
407	1852
462	1852
559	1852
610	1852
681	1852
690	1852
703	1852
348	1853
352	1853
360	1853
420	1853
414	1853
455	1853
465	1853
471	1853
599	1853
690	1853
337	1854
338	1854
358	1854
420	1854
416	1854
407	1854
453	1854
455	1854
465	1854
482	1854
690	1854
358	1855
360	1855
362	1855
405	1855
420	1855
433	1855
453	1855
455	1855
465	1855
471	1855
646	1855
670	1855
682	1855
701	1855
704	1855
703	1855
705	1855
706	1855
337	1856
338	1856
352	1856
354	1856
358	1856
408	1856
420	1856
419	1856
416	1856
407	1856
448	1856
465	1856
583	1856
667	1856
338	1857
354	1857
358	1857
362	1857
397	1857
420	1857
414	1857
407	1857
448	1857
453	1857
471	1857
482	1857
614	1857
682	1857
690	1857
703	1857
706	1857
337	1858
338	1858
352	1858
354	1858
358	1858
360	1858
362	1858
391	1858
420	1858
414	1858
407	1858
455	1858
465	1858
497	1858
503	1858
610	1858
614	1858
654	1858
698	1858
703	1858
705	1858
706	1858
337	1859
338	1859
352	1859
354	1859
358	1859
420	1859
413	1859
414	1859
416	1859
465	1859
482	1859
614	1859
682	1859
337	1860
338	1860
391	1860
420	1860
416	1860
453	1860
471	1860
614	1860
338	1861
354	1861
360	1861
362	1861
391	1861
420	1861
414	1861
433	1861
453	1861
455	1861
646	1861
681	1861
682	1861
690	1861
704	1861
713	1861
337	1862
338	1862
352	1862
360	1862
362	1862
397	1862
413	1862
419	1862
414	1862
416	1862
407	1862
448	1862
455	1862
465	1862
508	1862
610	1862
614	1862
667	1862
692	1862
704	1862
703	1862
709	1862
710	1862
711	1862
337	1863
338	1863
352	1863
354	1863
360	1863
362	1863
420	1863
414	1863
416	1863
433	1863
453	1863
455	1863
465	1863
459	1863
471	1863
492	1863
498	1863
610	1863
704	1863
703	1863
418	1864
471	1864
614	1864
714	1864
362	1865
397	1865
610	1865
703	1865
413	1866
407	1866
465	1866
583	1866
338	1867
352	1867
358	1867
360	1867
362	1867
397	1867
420	1867
416	1867
407	1867
433	1867
448	1867
453	1867
455	1867
465	1867
482	1867
492	1867
508	1867
514	1867
610	1867
646	1867
682	1867
690	1867
337	1868
338	1868
352	1868
420	1868
419	1868
414	1868
465	1868
469	1868
583	1868
667	1868
358	1869
416	1869
407	1869
433	1869
448	1869
453	1869
465	1869
701	1869
338	1870
360	1870
362	1870
397	1870
420	1870
419	1870
414	1870
407	1870
411	1870
433	1870
448	1870
455	1870
465	1870
482	1870
508	1870
533	1870
583	1870
610	1870
646	1870
682	1870
704	1870
706	1870
715	1870
348	1871
352	1871
412	1871
418	1871
416	1871
407	1871
453	1871
488	1871
492	1871
614	1871
698	1871
704	1871
338	1872
348	1872
358	1872
360	1872
362	1872
413	1872
414	1872
415	1872
407	1872
448	1872
455	1872
559	1872
690	1872
338	1873
358	1873
360	1873
362	1873
407	1873
455	1873
471	1873
488	1873
610	1873
681	1873
698	1873
710	1873
711	1873
718	1873
717	1873
716	1873
358	1874
360	1874
362	1874
433	1874
453	1874
455	1874
471	1874
610	1874
681	1874
698	1874
703	1874
710	1874
717	1874
720	1874
719	1874
358	1875
360	1875
362	1875
397	1875
407	1875
433	1875
453	1875
455	1875
471	1875
559	1875
610	1875
698	1875
713	1875
721	1875
337	1876
338	1876
352	1876
360	1876
416	1876
448	1876
455	1876
471	1876
482	1876
583	1876
614	1876
682	1876
706	1876
337	1877
338	1877
397	1877
420	1877
407	1877
411	1877
448	1877
455	1877
465	1877
459	1877
471	1877
583	1877
610	1877
706	1877
715	1877
352	1878
358	1878
362	1878
397	1878
413	1878
414	1878
416	1878
407	1878
433	1878
448	1878
453	1878
455	1878
508	1878
610	1878
706	1878
337	1879
338	1879
362	1879
397	1879
408	1879
407	1879
453	1879
455	1879
471	1879
482	1879
492	1879
533	1879
583	1879
610	1879
614	1879
636	1879
692	1879
698	1879
706	1879
337	1880
338	1880
352	1880
358	1880
362	1880
397	1880
420	1880
416	1880
407	1880
411	1880
455	1880
465	1880
459	1880
471	1880
610	1880
682	1880
706	1880
710	1880
722	1880
337	1881
338	1881
348	1881
352	1881
358	1881
362	1881
397	1881
420	1881
412	1881
418	1881
416	1881
407	1881
455	1881
465	1881
533	1881
583	1881
610	1881
614	1881
646	1881
698	1881
710	1881
348	1882
352	1882
358	1882
413	1882
419	1882
414	1882
418	1882
416	1882
433	1882
465	1882
471	1882
482	1882
492	1882
358	1883
360	1883
404	1883
411	1883
437	1883
448	1883
465	1883
579	1883
723	1883
724	1883
337	1884
352	1884
362	1884
397	1884
420	1884
414	1884
416	1884
407	1884
433	1884
503	1884
533	1884
583	1884
610	1884
646	1884
690	1884
698	1884
710	1884
348	1885
397	1885
391	1885
420	1885
412	1885
418	1885
465	1885
471	1885
492	1885
646	1885
337	1886
338	1886
348	1886
352	1886
358	1886
362	1886
397	1886
420	1886
416	1886
407	1886
411	1886
433	1886
465	1886
492	1886
533	1886
610	1886
614	1886
710	1886
348	1887
413	1887
416	1887
337	1888
338	1888
352	1888
358	1888
397	1888
416	1888
448	1888
469	1888
482	1888
492	1888
559	1888
614	1888
630	1888
710	1888
337	1889
338	1889
348	1889
352	1889
397	1889
418	1889
416	1889
448	1889
465	1889
492	1889
337	1890
338	1890
348	1890
358	1890
360	1890
397	1890
420	1890
412	1890
419	1890
418	1890
407	1890
448	1890
453	1890
465	1890
497	1890
508	1890
514	1890
583	1890
596	1890
614	1890
337	1891
338	1891
348	1891
358	1891
360	1891
380	1891
397	1891
408	1891
420	1891
418	1891
416	1891
407	1891
437	1891
448	1891
465	1891
492	1891
559	1891
634	1891
337	1892
338	1892
348	1892
352	1892
358	1892
360	1892
397	1892
420	1892
416	1892
465	1892
482	1892
492	1892
583	1892
614	1892
690	1892
338	1893
352	1893
358	1893
380	1893
397	1893
407	1893
448	1893
492	1893
559	1893
634	1893
726	1893
725	1893
337	1894
338	1894
348	1894
352	1894
358	1894
380	1894
397	1894
408	1894
420	1894
407	1894
448	1894
471	1894
492	1894
533	1894
559	1894
583	1894
614	1894
630	1894
631	1894
636	1894
698	1894
710	1894
337	1895
338	1895
348	1895
358	1895
397	1895
412	1895
413	1895
418	1895
416	1895
407	1895
448	1895
502	1895
533	1895
559	1895
634	1895
698	1895
710	1895
348	1896
352	1896
397	1896
420	1896
414	1896
465	1896
471	1896
482	1896
508	1896
614	1896
352	1897
358	1897
360	1897
413	1897
416	1897
407	1897
482	1897
485	1897
492	1897
337	1898
338	1898
352	1898
358	1898
397	1898
413	1898
419	1898
414	1898
416	1898
437	1898
448	1898
488	1898
502	1898
670	1898
671	1898
726	1898
337	1899
338	1899
358	1899
397	1899
407	1899
437	1899
482	1899
492	1899
614	1899
716	1899
726	1899
727	1899
358	1900
360	1900
397	1900
420	1900
412	1900
415	1900
418	1900
416	1900
407	1900
448	1900
465	1900
471	1900
482	1900
492	1900
583	1900
614	1900
337	1901
338	1901
352	1901
360	1901
380	1901
397	1901
415	1901
407	1901
437	1901
488	1901
337	1902
338	1902
352	1902
358	1902
397	1902
414	1902
482	1902
503	1902
614	1902
360	1903
380	1903
413	1903
414	1903
416	1903
337	1904
338	1904
348	1904
358	1904
360	1904
397	1904
412	1904
416	1904
448	1904
465	1904
482	1904
492	1904
358	1905
360	1905
380	1905
397	1905
419	1905
437	1905
448	1905
471	1905
482	1905
488	1905
614	1905
630	1905
634	1905
710	1905
713	1905
716	1905
726	1905
728	1905
337	1906
338	1906
348	1906
358	1906
360	1906
397	1906
420	1906
412	1906
418	1906
465	1906
471	1906
492	1906
614	1906
646	1906
690	1906
337	1907
338	1907
348	1907
397	1907
412	1907
413	1907
414	1907
418	1907
416	1907
448	1907
465	1907
471	1907
614	1907
725	1907
337	1908
338	1908
380	1908
397	1908
416	1908
437	1908
465	1908
482	1908
583	1908
337	1909
338	1909
348	1909
358	1909
360	1909
380	1909
397	1909
413	1909
414	1909
415	1909
416	1909
448	1909
465	1909
492	1909
614	1909
337	1910
338	1910
348	1910
358	1910
360	1910
397	1910
404	1910
408	1910
420	1910
412	1910
415	1910
418	1910
407	1910
448	1910
465	1910
471	1910
492	1910
583	1910
614	1910
646	1910
690	1910
337	1911
338	1911
348	1911
358	1911
380	1911
397	1911
420	1911
416	1911
448	1911
465	1911
482	1911
614	1911
337	1912
338	1912
348	1912
380	1912
397	1912
420	1912
412	1912
414	1912
418	1912
407	1912
437	1912
448	1912
465	1912
471	1912
503	1912
583	1912
646	1912
358	1913
360	1913
408	1913
419	1913
482	1913
533	1913
614	1913
636	1913
715	1913
337	1914
338	1914
358	1914
413	1914
414	1914
415	1914
416	1914
407	1914
448	1914
465	1914
492	1914
559	1914
690	1914
348	1915
360	1915
380	1915
397	1915
420	1915
412	1915
418	1915
471	1915
614	1915
646	1915
337	1916
338	1916
348	1916
352	1916
358	1916
360	1916
380	1916
397	1916
408	1916
415	1916
407	1916
448	1916
465	1916
471	1916
482	1916
488	1916
492	1916
583	1916
596	1916
614	1916
667	1916
703	1916
726	1916
729	1916
337	1917
338	1917
358	1917
360	1917
380	1917
397	1917
408	1917
420	1917
413	1917
415	1917
407	1917
453	1917
465	1917
471	1917
503	1917
533	1917
646	1917
682	1917
337	1918
338	1918
352	1918
358	1918
360	1918
380	1918
397	1918
420	1918
414	1918
448	1918
465	1918
471	1918
482	1918
492	1918
583	1918
614	1918
690	1918
337	1919
338	1919
358	1919
360	1919
380	1919
397	1919
416	1919
465	1919
482	1919
492	1919
614	1919
337	1920
338	1920
358	1920
397	1920
420	1920
413	1920
416	1920
407	1920
482	1920
492	1920
559	1920
630	1920
634	1920
713	1920
730	1920
337	1921
338	1921
352	1921
360	1921
380	1921
397	1921
407	1921
448	1921
453	1921
465	1921
471	1921
492	1921
502	1921
682	1921
337	1922
338	1922
380	1922
415	1922
416	1922
453	1922
492	1922
337	1923
338	1923
360	1923
380	1923
397	1923
416	1923
407	1923
465	1923
559	1923
614	1923
630	1923
634	1923
682	1923
713	1923
337	1924
338	1924
360	1924
397	1924
420	1924
414	1924
416	1924
465	1924
471	1924
492	1924
614	1924
337	1925
338	1925
358	1925
360	1925
397	1925
408	1925
420	1925
416	1925
407	1925
448	1925
465	1925
471	1925
482	1925
492	1925
514	1925
533	1925
614	1925
636	1925
667	1925
690	1925
715	1925
723	1925
358	1926
360	1926
397	1926
413	1926
419	1926
414	1926
415	1926
437	1926
465	1926
492	1926
508	1926
583	1926
614	1926
646	1926
667	1926
670	1926
682	1926
690	1926
337	1927
338	1927
358	1927
397	1927
420	1927
413	1927
448	1927
471	1927
482	1927
614	1927
646	1927
671	1927
682	1927
358	1928
420	1928
419	1928
459	1928
482	1928
612	1928
337	1929
338	1929
360	1929
397	1929
414	1929
415	1929
416	1929
465	1929
471	1929
583	1929
614	1929
690	1929
337	1930
338	1930
348	1930
358	1930
360	1930
397	1930
420	1930
412	1930
418	1930
407	1930
448	1930
471	1930
492	1930
497	1930
583	1930
646	1930
671	1930
701	1930
731	1930
337	1931
338	1931
358	1931
360	1931
397	1931
420	1931
413	1931
407	1931
437	1931
448	1931
465	1931
459	1931
492	1931
337	1932
338	1932
358	1932
360	1932
416	1932
465	1932
482	1932
492	1932
690	1932
337	1933
338	1933
358	1933
360	1933
420	1933
416	1933
437	1933
448	1933
465	1933
471	1933
482	1933
492	1933
646	1933
667	1933
690	1933
337	1934
338	1934
360	1934
420	1934
413	1934
414	1934
415	1934
418	1934
407	1934
448	1934
465	1934
459	1934
471	1934
492	1934
533	1934
636	1934
690	1934
701	1934
715	1934
337	1935
338	1935
348	1935
412	1935
413	1935
419	1935
418	1935
416	1935
407	1935
465	1935
471	1935
667	1935
732	1935
404	1936
413	1936
414	1936
415	1936
482	1936
503	1936
337	1937
338	1937
408	1937
420	1937
419	1937
416	1937
407	1937
448	1937
465	1937
471	1937
482	1937
492	1937
614	1937
690	1937
723	1937
337	1938
338	1938
420	1938
416	1938
448	1938
492	1938
667	1938
670	1938
671	1938
682	1938
690	1938
358	1939
420	1939
448	1939
482	1939
614	1939
667	1939
690	1939
348	1940
413	1940
414	1940
415	1940
465	1940
469	1940
337	1941
338	1941
420	1941
412	1941
418	1941
448	1941
492	1941
614	1941
646	1941
690	1941
337	1942
338	1942
348	1942
408	1942
418	1942
348	1943
414	1943
415	1943
465	1943
723	1943
724	1943
733	1943
337	1944
358	1944
420	1944
419	1944
448	1944
471	1944
492	1944
667	1944
404	1945
413	1945
414	1945
415	1945
514	1945
462	1946
490	1946
557	1946
598	1946
738	1946
734	1946
735	1946
737	1946
736	1946
449	1947
465	1947
459	1947
596	1947
723	1947
733	1947
420	1948
413	1948
419	1948
414	1948
415	1948
416	1948
471	1948
492	1948
690	1948
348	1949
413	1949
414	1949
415	1949
469	1949
492	1949
358	1950
420	1950
416	1950
448	1950
465	1950
492	1950
514	1950
605	1950
685	1950
690	1950
413	1951
415	1951
654	1951
739	1951
420	1952
413	1952
414	1952
415	1952
416	1952
471	1952
492	1952
533	1952
614	1952
670	1952
690	1952
337	1953
348	1953
358	1953
420	1953
412	1953
413	1953
419	1953
418	1953
437	1953
471	1953
492	1953
646	1953
670	1953
690	1953
733	1953
740	1953
413	1954
414	1954
416	1954
471	1954
492	1954
408	1955
413	1955
471	1955
492	1955
508	1955
533	1955
614	1955
636	1955
682	1955
739	1955
348	1956
412	1956
418	1956
416	1956
471	1956
492	1956
514	1956
614	1956
692	1956
703	1956
729	1956
413	1957
414	1957
415	1957
418	1957
416	1957
348	1958
404	1958
408	1958
420	1958
418	1958
416	1958
437	1958
448	1958
471	1958
492	1958
505	1958
614	1958
670	1958
703	1958
342	1959
414	1959
416	1959
420	1960
413	1960
419	1960
414	1960
415	1960
416	1960
471	1960
492	1960
337	1961
420	1961
413	1961
419	1961
414	1961
415	1961
416	1961
471	1961
492	1961
497	1961
614	1961
348	1962
358	1962
420	1962
412	1962
414	1962
418	1962
416	1962
448	1962
471	1962
492	1962
514	1962
614	1962
670	1962
703	1962
729	1962
733	1962
358	1963
419	1963
492	1963
670	1963
723	1963
727	1963
729	1963
358	1964
416	1964
471	1964
492	1964
514	1964
670	1964
703	1964
729	1964
733	1964
358	1965
420	1965
413	1965
414	1965
415	1965
437	1965
448	1965
471	1965
492	1965
497	1965
505	1965
670	1965
727	1965
729	1965
358	1966
420	1966
413	1966
414	1966
418	1966
416	1966
469	1966
583	1966
614	1966
654	1966
670	1966
703	1966
337	1967
348	1967
358	1967
408	1967
412	1967
419	1967
418	1967
492	1967
646	1967
727	1967
729	1967
408	1968
416	1968
448	1968
471	1968
514	1968
692	1968
704	1968
358	1969
413	1969
414	1969
415	1969
416	1969
448	1969
723	1969
733	1969
337	1970
358	1970
419	1970
414	1970
415	1970
416	1970
459	1970
508	1970
614	1970
670	1970
337	1971
348	1971
358	1971
383	1971
412	1971
418	1971
416	1971
469	1971
583	1971
646	1971
723	1971
741	1971
742	1971
342	1972
358	1972
413	1972
414	1972
415	1972
416	1972
448	1972
482	1972
505	1972
670	1972
733	1972
358	1973
416	1973
502	1973
508	1973
727	1973
743	1973
337	1974
413	1974
419	1974
414	1974
614	1974
646	1974
670	1974
682	1974
723	1974
733	1974
358	1975
413	1975
416	1975
482	1975
497	1975
533	1975
614	1975
646	1975
670	1975
671	1975
682	1975
723	1975
727	1975
733	1975
358	1976
413	1976
419	1976
414	1976
415	1976
416	1976
514	1976
646	1976
733	1976
348	1977
358	1977
408	1977
419	1977
416	1977
459	1977
682	1977
337	1978
348	1978
404	1978
408	1978
414	1978
415	1978
416	1978
533	1978
715	1978
723	1978
733	1978
358	1979
413	1979
419	1979
414	1979
415	1979
416	1979
614	1979
358	1980
459	1980
614	1980
682	1980
733	1980
416	1981
358	1982
413	1982
419	1982
414	1982
415	1982
416	1982
614	1982
725	1982
733	1982
358	1983
383	1983
416	1983
614	1983
733	1983
358	1984
413	1984
416	1984
465	1984
502	1984
682	1984
358	1985
682	1985
723	1985
733	1985
404	1986
408	1986
418	1986
482	1986
358	1987
413	1987
414	1987
415	1987
416	1987
670	1987
337	1988
342	1988
391	1988
412	1988
413	1988
419	1988
414	1988
415	1988
418	1988
416	1988
411	1988
497	1988
505	1988
533	1988
614	1988
654	1988
670	1988
671	1988
703	1988
715	1988
733	1988
419	1989
416	1989
459	1989
614	1989
670	1989
725	1989
733	1989
348	1990
352	1990
408	1990
413	1990
419	1990
414	1990
415	1990
416	1990
469	1990
497	1990
533	1990
614	1990
636	1990
654	1990
670	1990
682	1990
715	1990
723	1990
733	1990
342	1991
404	1991
413	1991
419	1991
414	1991
415	1991
416	1991
459	1991
505	1991
508	1991
636	1991
670	1991
682	1991
733	1991
348	1992
408	1992
413	1992
419	1992
414	1992
415	1992
416	1992
411	1992
469	1992
614	1992
670	1992
682	1992
715	1992
733	1992
744	1992
342	1993
404	1993
413	1993
419	1993
414	1993
415	1993
459	1993
505	1993
733	1993
419	1994
416	1994
508	1994
514	1994
614	1994
646	1994
670	1994
682	1994
733	1994
413	1995
419	1995
414	1995
415	1995
416	1995
459	1995
505	1995
614	1995
636	1995
654	1995
682	1995
337	1996
413	1996
419	1996
414	1996
415	1996
416	1996
508	1996
614	1996
654	1996
671	1996
682	1996
733	1996
348	1997
404	1997
408	1997
413	1997
419	1997
414	1997
415	1997
416	1997
459	1997
533	1997
733	1997
413	1998
419	1998
414	1998
415	1998
416	1998
459	1998
682	1998
715	1998
723	1998
733	1998
412	1999
413	1999
419	1999
414	1999
415	1999
418	1999
416	1999
614	1999
654	1999
670	1999
404	2000
416	2000
411	2000
459	2000
497	2000
508	2000
514	2000
682	2000
337	2001
342	2001
408	2001
413	2001
414	2001
415	2001
416	2001
505	2001
533	2001
614	2001
646	2001
654	2001
682	2001
715	2001
733	2001
404	2002
413	2002
414	2002
415	2002
416	2002
459	2002
682	2002
715	2002
733	2002
413	2003
419	2003
414	2003
415	2003
416	2003
459	2003
733	2003
404	2004
413	2004
414	2004
415	2004
416	2004
459	2004
682	2004
404	2005
413	2005
414	2005
415	2005
416	2005
459	2005
682	2005
413	2006
414	2006
415	2006
416	2006
459	2006
413	2007
414	2007
415	2007
416	2007
459	2007
614	2007
348	2008
404	2008
408	2008
413	2008
419	2008
414	2008
415	2008
416	2008
469	2008
533	2008
636	2008
682	2008
715	2008
733	2008
342	2009
383	2009
413	2009
414	2009
415	2009
416	2009
505	2009
548	2009
646	2009
682	2009
733	2009
348	2010
404	2010
408	2010
413	2010
419	2010
414	2010
415	2010
416	2010
459	2010
469	2010
514	2010
533	2010
636	2010
682	2010
715	2010
733	2010
342	2011
413	2011
414	2011
415	2011
416	2011
459	2011
505	2011
646	2011
682	2011
733	2011
342	2012
404	2012
413	2012
414	2012
415	2012
416	2012
505	2012
682	2012
733	2012
413	2013
419	2013
414	2013
415	2013
416	2013
459	2013
733	2013
352	2014
418	2014
416	2014
701	2014
342	2015
404	2015
408	2015
413	2015
419	2015
414	2015
415	2015
416	2015
505	2015
533	2015
636	2015
646	2015
682	2015
715	2015
733	2015
404	2016
408	2016
413	2016
419	2016
414	2016
415	2016
416	2016
459	2016
533	2016
636	2016
682	2016
404	2017
408	2017
413	2017
414	2017
415	2017
533	2017
636	2017
715	2017
416	2018
459	2018
514	2018
548	2018
682	2018
733	2018
404	2019
408	2019
413	2019
414	2019
415	2019
416	2019
533	2019
636	2019
682	2019
715	2019
413	2020
419	2020
414	2020
415	2020
416	2020
533	2020
682	2020
715	2020
412	2021
413	2021
414	2021
415	2021
418	2021
416	2021
533	2021
636	2021
715	2021
404	2022
413	2022
414	2022
415	2022
416	2022
459	2022
682	2022
404	2023
413	2023
414	2023
415	2023
416	2023
682	2023
745	2023
408	2024
413	2024
414	2024
415	2024
416	2024
505	2024
533	2024
636	2024
646	2024
715	2024
733	2024
348	2025
383	2025
413	2025
416	2025
505	2025
682	2025
733	2025
404	2026
412	2026
413	2026
414	2026
415	2026
418	2026
416	2026
646	2026
413	2027
414	2027
415	2027
416	2027
503	2027
413	2028
414	2028
415	2028
416	2028
533	2028
682	2028
715	2028
383	2029
408	2029
409	2029
412	2029
413	2029
419	2029
415	2029
418	2029
645	2029
408	2030
416	2030
533	2030
636	2030
671	2030
682	2030
715	2030
342	2031
415	2031
416	2031
383	2032
404	2032
413	2032
419	2032
414	2032
415	2032
533	2032
671	2032
682	2032
723	2032
746	2032
383	2033
418	2033
459	2033
645	2033
383	2034
412	2034
413	2034
419	2034
414	2034
415	2034
418	2034
416	2034
459	2034
533	2034
419	2035
383	2036
413	2036
533	2036
636	2036
682	2036
715	2036
413	2037
414	2037
415	2037
416	2037
459	2037
636	2037
715	2037
383	2038
404	2038
413	2038
414	2038
415	2038
682	2038
715	2038
348	2039
383	2039
404	2039
413	2039
414	2039
415	2039
469	2039
682	2039
715	2039
348	2040
404	2040
413	2040
415	2040
418	2040
416	2040
469	2040
654	2040
667	2040
681	2040
724	2040
747	2040
404	2041
413	2041
418	2041
469	2041
646	2041
667	2041
724	2041
731	2041
745	2041
748	2041
383	2042
408	2042
412	2042
418	2042
459	2042
503	2042
636	2042
715	2042
414	2043
415	2043
459	2043
408	2044
413	2044
414	2044
415	2044
636	2044
682	2044
715	2044
404	2045
413	2045
414	2045
415	2045
416	2045
459	2045
383	2046
404	2046
413	2046
419	2046
414	2046
415	2046
416	2046
459	2046
682	2046
404	2047
408	2047
413	2047
414	2047
415	2047
636	2047
682	2047
715	2047
383	2048
404	2048
408	2048
413	2048
414	2048
415	2048
533	2048
636	2048
682	2048
715	2048
404	2049
408	2049
413	2049
414	2049
415	2049
416	2049
459	2049
503	2049
682	2049
715	2049
404	2050
413	2050
414	2050
415	2050
352	2051
416	2051
682	2051
701	2051
348	2052
408	2052
414	2052
415	2052
416	2052
636	2052
715	2052
413	2053
414	2053
419	2054
459	2054
682	2054
412	2055
413	2055
414	2055
415	2055
418	2055
416	2055
533	2055
636	2055
715	2055
408	2056
636	2056
715	2056
723	2057
411	2058
645	2058
408	2059
412	2059
419	2059
418	2059
419	2060
383	2061
408	2061
409	2061
412	2061
418	2061
636	2061
533	2062
636	2062
715	2062
337	2063
404	2063
409	2063
413	2063
419	2063
415	2063
416	2063
485	2063
508	2063
583	2063
682	2063
715	2063
383	2064
404	2064
409	2064
413	2064
419	2064
416	2064
459	2064
670	2064
682	2064
404	2065
413	2065
459	2065
670	2065
337	2066
383	2066
409	2066
412	2066
413	2066
415	2066
418	2066
636	2066
337	2067
408	2067
413	2067
419	2067
415	2067
459	2067
533	2067
636	2067
671	2067
682	2067
715	2067
383	2068
409	2068
412	2068
418	2068
636	2068
337	2069
419	2069
533	2069
645	2069
645	2070
416	2071
411	2071
502	2071
671	2071
682	2071
337	2072
383	2072
408	2072
413	2072
419	2072
415	2072
459	2072
636	2072
682	2072
715	2072
337	2073
409	2073
413	2073
415	2073
416	2073
411	2073
485	2073
671	2073
415	2074
418	2074
411	2074
459	2074
337	2075
383	2075
408	2075
409	2075
413	2075
419	2075
415	2075
416	2075
459	2075
485	2075
503	2075
636	2075
682	2075
715	2075
337	2076
383	2076
409	2076
413	2076
415	2076
459	2076
671	2076
682	2076
413	2077
411	2077
459	2077
682	2077
745	2077
383	2078
337	2079
413	2079
415	2079
416	2079
411	2079
508	2079
671	2079
337	2080
383	2080
408	2080
409	2080
413	2080
415	2080
533	2080
636	2080
682	2080
715	2080
383	2081
409	2081
413	2081
411	2081
459	2081
485	2081
636	2081
715	2081
745	2081
337	2082
383	2082
409	2082
413	2082
419	2082
415	2082
416	2082
459	2082
508	2082
682	2082
715	2082
413	2083
503	2084
645	2084
383	2085
404	2085
408	2085
416	2085
459	2085
508	2085
636	2085
682	2085
408	2086
419	2086
411	2086
459	2086
508	2086
636	2086
671	2086
348	2087
408	2087
412	2087
418	2087
636	2087
383	2088
419	2088
416	2088
482	2088
508	2088
671	2088
682	2088
408	2089
459	2089
482	2089
636	2089
408	2090
419	2090
411	2090
459	2090
482	2090
508	2090
636	2090
715	2090
636	2091
715	2091
408	2092
411	2092
437	2092
459	2092
482	2092
503	2092
583	2092
671	2092
408	2093
411	2093
583	2093
408	2094
416	2094
383	2095
408	2095
416	2095
411	2095
365	2096
419	2096
411	2096
503	2096
645	2096
740	2096
583	2097
645	2097
365	2098
459	2098
408	2099
411	2099
482	2099
636	2099
358	2100
391	2100
408	2100
411	2100
433	2100
437	2100
442	2100
482	2100
497	2100
503	2100
508	2100
514	2100
671	2100
358	2101
391	2101
408	2101
411	2101
433	2101
437	2101
442	2101
482	2101
497	2101
503	2101
508	2101
514	2101
671	2101
365	2102
419	2102
411	2102
459	2102
482	2102
503	2102
508	2102
583	2102
645	2102
557	2103
365	2104
383	2104
408	2104
723	2104
365	2105
358	2106
365	2106
404	2106
410	2106
419	2106
411	2106
442	2106
482	2106
502	2106
508	2106
583	2106
667	2106
671	2106
723	2106
502	2107
514	2107
383	2108
408	2108
419	2108
411	2108
482	2108
636	2108
419	2109
411	2109
459	2109
419	2110
411	2110
459	2110
338	2111
358	2111
404	2111
391	2111
410	2111
411	2111
437	2111
482	2111
508	2111
583	2111
596	2111
604	2111
610	2111
667	2111
671	2111
747	2111
749	2111
750	2111
751	2111
752	2111
753	2111
754	2111
755	2111
756	2111
358	2112
411	2112
442	2112
482	2112
496	2112
596	2112
750	2112
754	2112
755	2112
756	2112
757	2112
758	2112
759	2112
410	2113
442	2113
482	2113
502	2113
503	2113
508	2113
514	2113
583	2113
723	2113
739	2113
760	2113
410	2114
433	2114
447	2114
482	2114
757	2114
338	2115
459	2115
497	2115
503	2115
583	2115
671	2115
756	2115
503	2116
338	2117
410	2117
411	2117
437	2117
497	2117
667	2117
670	2117
757	2117
761	2117
762	2117
763	2117
391	2118
514	2118
583	2118
750	2118
764	2118
410	2119
437	2119
482	2119
497	2119
514	2119
583	2119
757	2119
338	2120
437	2120
498	2120
508	2120
667	2120
761	2120
763	2120
765	2120
338	2121
411	2121
437	2121
583	2121
667	2121
670	2121
723	2121
338	2122
391	2122
410	2122
411	2122
465	2122
482	2122
497	2122
508	2122
654	2122
670	2122
671	2122
703	2122
761	2122
762	2122
766	2122
767	2122
768	2122
411	2123
503	2123
508	2123
654	2123
769	2123
605	2124
737	2124
482	2125
667	2125
689	2125
757	2125
762	2125
764	2125
770	2125
338	2126
349	2126
404	2126
411	2126
469	2126
503	2126
508	2126
654	2126
667	2126
750	2126
771	2126
772	2126
338	2127
404	2127
411	2127
503	2127
508	2127
654	2127
667	2127
750	2127
769	2127
771	2127
772	2127
338	2128
391	2128
410	2128
465	2128
482	2128
497	2128
514	2128
604	2128
636	2128
667	2128
670	2128
703	2128
757	2128
762	2128
764	2128
768	2128
773	2128
338	2129
482	2129
514	2129
604	2129
636	2129
667	2129
757	2129
764	2129
689	2130
774	2130
404	2131
514	2131
519	2131
636	2131
689	2131
404	2132
497	2132
503	2132
597	2132
604	2132
654	2132
758	2132
766	2132
767	2132
775	2132
776	2132
777	2132
778	2132
404	2133
497	2133
503	2133
597	2133
604	2133
654	2133
758	2133
766	2133
767	2133
775	2133
776	2133
777	2133
778	2133
365	2134
383	2134
408	2134
465	2134
723	2134
645	2135
689	2135
758	2135
338	2136
361	2136
503	2136
758	2136
361	2137
465	2137
482	2137
757	2137
779	2137
\.


--
-- Data for Name: shows; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY shows (id, artist_id, tour_id, year_id, era_id, date, avg_rating_weighted, avg_duration, display_date, created_at, updated_at) FROM stdin;
\.


--
-- Name: shows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('shows_id_seq', 1, false);


--
-- Name: source_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('source_review_id_seq', 1, false);


--
-- Data for Name: source_reviews; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY source_reviews (id, source_id, rating, title, review, author, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: source_sets; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY source_sets (id, source_id, index, is_encore, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: source_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('source_sets_id_seq', 1, false);


--
-- Data for Name: source_tracks; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY source_tracks (id, source_id, source_set_id, track_position, duration, title, slug, mp3_url, md5, created_at, updated_at) FROM stdin;
\.


--
-- Name: source_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('source_tracks_id_seq', 1, false);


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY sources (id, show_id, is_soundboard, is_remaster, avg_rating, num_reviews, upstream_identifier, has_jamcharts, description, taper_notes, source, taper, transferrer, lineage, created_at, updated_at, artist_id, avg_rating_weighted, duration) FROM stdin;
\.


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('sources_id_seq', 1, false);


--
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY tours (id, artist_id, start_date, end_date, name, created_at, updated_at, slug, upstream_identifier) FROM stdin;
11	2	2016-05-23	2016-06-26	2016 U.S. Tour	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04	2016-us-tour	2016 U.S. Tour
12	2	2016-02-18	2016-05-10	Not Part of a Tour	2016-06-28 10:28:06-04	2016-06-28 14:28:06.034849-04	not-part-of-a-tour	Not Part of a Tour
13	2	2015-10-29	2015-12-31	2015 U.S. Tour	2016-06-28 10:28:06-04	2016-06-28 14:28:06.040775-04	2015-us-tour	2015 U.S. Tour
14	1	2015-06-27	2015-07-05	Fare Thee Well	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04	fare-thee-well	Fare Thee Well
15	1	1995-05-19	1995-07-09	Summer Tour 1995	2016-06-28 11:08:51-04	2016-06-28 15:08:50.923494-04	summer-tour-1995	Summer Tour 1995
16	1	1995-03-17	1995-04-07	Spring Tour 1995	2016-06-28 11:08:51-04	2016-06-28 15:08:51.169763-04	spring-tour-1995	Spring Tour 1995
17	1	1995-02-19	1995-02-26	Winter Tour 1995	2016-06-28 11:08:51-04	2016-06-28 15:08:51.308154-04	winter-tour-1995	Winter Tour 1995
18	1	1994-09-16	1994-12-19	Fall Tour 1994	2016-06-28 11:08:51-04	2016-06-28 15:08:51.35203-04	fall-tour-1994	Fall Tour 1994
19	1	1994-06-08	1994-08-04	Summer Tour 1994	2016-06-28 11:08:52-04	2016-06-28 15:08:51.658004-04	summer-tour-1994	Summer Tour 1994
20	1	1994-02-25	1994-04-08	Winter/Spring Tour 1994	2016-06-28 11:08:52-04	2016-06-28 15:08:51.897282-04	winter-spring-tour-1994	Winter/Spring Tour 1994
21	1	1993-09-08	1993-12-19	Fall Tour 1993	2016-06-28 11:08:52-04	2016-06-28 15:08:52.092785-04	fall-tour-1993	Fall Tour 1993
22	1	1993-08-21	1993-08-27	Summer Tour 1993	2016-06-28 11:08:52-04	2016-06-28 15:08:52.349832-04	summer-tour-1993	Summer Tour 1993
23	1	1965-05-05	1993-06-26	Not Part of a Tour	2016-06-28 11:08:52-04	2016-06-28 15:08:52.384008-04	not-part-of-a-tour	Not Part of a Tour
24	1	1992-12-02	1992-12-17	Fall Tour 1992	2016-06-28 11:08:53-04	2016-06-28 15:08:52.817715-04	fall-tour-1992	Fall Tour 1992
25	1	1992-05-19	1992-07-01	Spring/Summer Tour 1992	2016-06-28 11:08:53-04	2016-06-28 15:08:52.913504-04	spring-summer-tour-1992	Spring/Summer Tour 1992
26	1	1992-02-22	1992-03-24	Winter Tour 1992	2016-06-28 11:08:53-04	2016-06-28 15:08:53.136723-04	winter-tour-1992	Winter Tour 1992
27	1	1990-10-13	1990-11-01	Europe '90	2016-06-28 11:08:54-04	2016-06-28 15:08:54.092349-04	europe-90	Europe '90
28	1	1987-07-04	1987-07-26	Dylan & The Dead	2016-06-28 11:08:56-04	2016-06-28 15:08:56.30615-04	dylan-the-dead	Dylan & The Dead
29	1	1974-09-09	1974-09-21	Europe '74	2016-06-28 11:09:04-04	2016-06-28 15:09:03.671462-04	europe-74	Europe '74
30	1	1974-06-16	1974-08-06	Summer Tour 1974	2016-06-28 11:09:04-04	2016-06-28 15:09:03.783613-04	summer-tour-1974	Summer Tour 1974
31	1	1974-05-12	1974-06-08	Spring Tour 1974	2016-06-28 11:09:04-04	2016-06-28 15:09:03.950147-04	spring-tour-1974	Spring Tour 1974
32	1	1972-04-07	1972-05-26	Europe '72	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04	europe-72	Europe '72
33	1	1967-01-14	1967-11-11	Grateful Dead Tour	2016-06-28 11:09:08-04	2016-06-28 15:09:08.307508-04	grateful-dead-tour	Grateful Dead Tour
\.


--
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('tours_id_seq', 33, true);


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY venues (id, artist_id, latitude, longitude, name, location, upstream_identifier, created_at, updated_at) FROM stdin;
59	\N	40.7142691000000028	-74.0059729000000033	Citi Field	New York, New York	setlistfm:5bd6d310	2016-06-28 10:28:06-04	2016-06-28 14:28:05.852112-04
60	\N	38.7228945999999965	-77.5361005000000034	Jiffy Lube Live	Bristow, Virginia	setlistfm:3d66993	2016-06-28 10:28:06-04	2016-06-28 14:28:05.95384-04
61	\N	43.0831300999999982	-73.7845650999999947	Saratoga Performing Arts Center	Saratoga Springs, New York	setlistfm:4bd63b2e	2016-06-28 10:28:06-04	2016-06-28 14:28:05.967371-04
62	\N	39.9259462999999997	-75.1196199000000036	BB&T Pavilion	Camden, New Jersey	setlistfm:63d5f21b	2016-06-28 10:28:06-04	2016-06-28 14:28:05.979794-04
63	\N	40.0455917999999969	-86.0085954999999984	Klipsch Music Center	Noblesville, Indiana	setlistfm:43d73f3b	2016-06-28 10:28:06-04	2016-06-28 14:28:05.991361-04
64	\N	39.1620035999999985	-84.4568862999999936	Riverbend Music Center	Cincinnati, Ohio	setlistfm:2bd4a04a	2016-06-28 10:28:06-04	2016-06-28 14:28:06.000659-04
65	\N	35.4817431999999968	-86.0885992999999985	Great Stage Park	Manchester, Tennessee	setlistfm:2bd6181e	2016-06-28 10:28:06-04	2016-06-28 14:28:06.010912-04
66	\N	35.2270869000000033	-80.8431267999999932	PNC Music Pavilion	Charlotte, North Carolina	setlistfm:43d4e71b	2016-06-28 10:28:06-04	2016-06-28 14:28:06.019823-04
67	\N	37.7749999999999986	-122.418999999999997	The Fillmore	San Francisco, California	setlistfm:23d6d4c7	2016-06-28 10:28:06-04	2016-06-28 14:28:06.027024-04
68	\N	34.0519999999999996	-118.244	Jimmy Kimmel Live	Los Angeles, California	setlistfm:4bd7c3d6	2016-06-28 10:28:06-04	2016-06-28 14:28:06.034849-04
69	\N	34.1388961999999978	-118.353411500000007	Universal Studios	Universal City, California	setlistfm:bd6255e	2016-06-28 10:28:06-04	2016-06-28 14:28:06.038442-04
70	\N	33.9616801000000024	-118.353131099999999	The Forum	Inglewood, California	setlistfm:73d6366d	2016-06-28 10:28:06-04	2016-06-28 14:28:06.040775-04
71	\N	37.7749999999999986	-122.418999999999997	Bill Graham Civic Auditorium	San Francisco, California	setlistfm:13d6354d	2016-06-28 10:28:06-04	2016-06-28 14:28:06.055879-04
72	\N	36.1749705000000006	-115.137223000000006	MGM Grand Garden Arena	Las Vegas, Nevada	setlistfm:5bd6378c	2016-06-28 10:28:06-04	2016-06-28 14:28:06.069478-04
73	\N	39.9205411000000012	-105.086650399999996	1st Bank Center	Broomfield, Colorado	setlistfm:63d7aeff	2016-06-28 10:28:06-04	2016-06-28 14:28:06.105684-04
74	\N	44.9799653999999975	-93.263836100000006	Target Center	Minneapolis, Minnesota	setlistfm:3d62113	2016-06-28 10:28:06-04	2016-06-28 14:28:06.118451-04
75	\N	38.6272732999999988	-90.1978888999999953	Scottrade Center	St. Louis, Missouri	setlistfm:5bd61fd0	2016-06-28 10:28:06-04	2016-06-28 14:28:06.125317-04
76	\N	36.1658899000000034	-86.7844431999999983	Bridgestone Arena	Nashville, Tennessee	setlistfm:23d6746f	2016-06-28 10:28:06-04	2016-06-28 14:28:06.131914-04
77	\N	33.7489953999999983	-84.3879823999999985	Philips Arena	Atlanta, Georgia	setlistfm:43d637a3	2016-06-28 10:28:06-04	2016-06-28 14:28:06.1386-04
78	\N	36.072635499999997	-79.7919753999999983	Greensboro Coliseum	Greensboro, North Carolina	setlistfm:4bd6cfb6	2016-06-28 10:28:06-04	2016-06-28 14:28:06.145236-04
79	\N	39.9611755000000031	-82.9987942000000061	Nationwide Arena	Columbus, Ohio	setlistfm:1bd63994	2016-06-28 10:28:06-04	2016-06-28 14:28:06.152728-04
80	\N	42.8864468000000016	-78.8783688999999981	First Niagara Center	Buffalo, New York	setlistfm:3d7e1b7	2016-06-28 10:28:06-04	2016-06-28 14:28:06.158801-04
81	\N	42.2625931999999978	-71.8022933999999964	DCU Center	Worcester, Massachusetts	setlistfm:13d63961	2016-06-28 10:28:06-04	2016-06-28 14:28:06.166757-04
82	\N	40.7142691000000028	-74.0059729000000033	Madison Square Garden	New York, New York	setlistfm:23d63cc7	2016-06-28 10:28:06-04	2016-06-28 14:28:06.173589-04
83	\N	38.8950000000000031	-77.0360000000000014	Verizon Center	Washington, Washington, D.C.	setlistfm:3bd6383c	2016-06-28 10:28:06-04	2016-06-28 14:28:06.18023-04
84	\N	39.9523349999999979	-75.1637889999999942	Wells Fargo Center	Philadelphia, Pennsylvania	setlistfm:3bd65058	2016-06-28 10:28:06-04	2016-06-28 14:28:06.186477-04
85	\N	42.6525792999999993	-73.7562317000000007	Times Union Center	Albany, New York	setlistfm:4bd6cb36	2016-06-28 10:28:06-04	2016-06-28 14:28:06.205921-04
86	\N	41.8500330000000034	-87.6500522999999987	Soldier Field	Chicago, Illinois	setlistfm:4bd637ce	2016-06-28 11:08:51-04	2016-06-28 15:08:50.768036-04
87	\N	37.3541079999999965	-121.955235599999995	Levi's Stadium	Santa Clara, California	setlistfm:63d4564f	2016-06-28 11:08:51-04	2016-06-28 15:08:50.896897-04
88	\N	38.7131072999999972	-90.4298401000000069	Riverport Amphitheatre	Maryland Heights, Missouri	setlistfm:53d637cd	2016-06-28 11:08:51-04	2016-06-28 15:08:50.942842-04
89	\N	40.0455917999999969	-86.0085954999999984	Deer Creek Music Center	Noblesville, Indiana	setlistfm:53d6c761	2016-06-28 11:08:51-04	2016-06-28 15:08:50.960488-04
90	\N	40.4406248000000019	-79.9958864000000034	Three Rivers Stadium	Pittsburgh, Pennsylvania	setlistfm:43d637c3	2016-06-28 11:08:51-04	2016-06-28 15:08:50.97159-04
91	\N	42.6875323000000009	-83.2341028000000023	The Palace of Auburn Hills	Auburn Hills, Michigan	setlistfm:23d63847	2016-06-28 11:08:51-04	2016-06-28 15:08:50.980663-04
92	\N	38.8950000000000031	-77.0360000000000014	RFK Stadium	Washington, Washington, D.C.	setlistfm:bd6c942	2016-06-28 11:08:51-04	2016-06-28 15:08:50.999653-04
93	\N	42.6525792999999993	-73.7562317000000007	Knickerbocker Arena	Albany, New York	setlistfm:53d6d7ad	2016-06-28 11:08:51-04	2016-06-28 15:08:51.018099-04
94	\N	40.8339890000000025	-74.0970865000000032	Giants Stadium	East Rutherford, New Jersey	setlistfm:43d61fcb	2016-06-28 11:08:51-04	2016-06-28 15:08:51.03417-04
95	\N	44.9511109999999974	-73.0641669999999976	Franklin County Airport Field	Highgate, Vermont	setlistfm:7bd61e8c	2016-06-28 11:08:51-04	2016-06-28 15:08:51.05072-04
96	\N	32.6992188999999982	-117.112808599999994	Shoreline Amphitheatre	Mountain View, California	setlistfm:5bd6d7b4	2016-06-28 11:08:51-04	2016-06-28 15:08:51.094778-04
97	\N	45.5234515000000002	-122.676207099999999	Portland Meadows	Portland, Oregon	setlistfm:43d637c7	2016-06-28 11:08:51-04	2016-06-28 15:08:51.11473-04
98	\N	47.6062094999999985	-122.332070799999997	Memorial Stadium	Seattle, Washington	setlistfm:bd6c962	2016-06-28 11:08:51-04	2016-06-28 15:08:51.129098-04
99	\N	36.1749705000000006	-115.137223000000006	Sam Boyd Stadium	Las Vegas, Nevada	setlistfm:7bd62620	2016-06-28 11:08:51-04	2016-06-28 15:08:51.150146-04
100	\N	27.9475216000000017	-82.4584279000000038	Tampa Stadium	Tampa, Florida	setlistfm:53d637c5	2016-06-28 11:08:51-04	2016-06-28 15:08:51.169763-04
101	\N	33.5206608000000017	-86.8024900000000059	Birmingham-Jefferson Civic Center Coliseum	Birmingham, Alabama	setlistfm:5bd637c4	2016-06-28 11:08:51-04	2016-06-28 15:08:51.178491-04
102	\N	35.1495342999999991	-90.0489800999999943	The Pyramid Arena	Memphis, Tennessee	setlistfm:43d637bb	2016-06-28 11:08:51-04	2016-06-28 15:08:51.192331-04
103	\N	33.7489953999999983	-84.3879823999999985	The Omni	Atlanta, Georgia	setlistfm:4bd637ba	2016-06-28 11:08:51-04	2016-06-28 15:08:51.205073-04
104	\N	35.2270869000000033	-80.8431267999999932	Charlotte Coliseum	Charlotte, North Carolina	setlistfm:53d637b9	2016-06-28 11:08:51-04	2016-06-28 15:08:51.268792-04
105	\N	39.9523349999999979	-75.1637889999999942	CoreStates Spectrum	Philadelphia, Pennsylvania	setlistfm:3bd61060	2016-06-28 11:08:51-04	2016-06-28 15:08:51.2904-04
106	\N	37.8043722000000031	-122.270802599999996	Oakland-Alameda County Coliseum Arena	Oakland, California	setlistfm:3bd66474	2016-06-28 11:08:51-04	2016-06-28 15:08:51.308154-04
107	\N	40.760779399999997	-111.891047400000005	Delta Center	Salt Lake City, Utah	setlistfm:4bd637be	2016-06-28 11:08:51-04	2016-06-28 15:08:51.330447-04
108	\N	34.0519999999999996	-118.244	Los Angeles Sports Arena	Los Angeles, California	setlistfm:3d6c967	2016-06-28 11:08:51-04	2016-06-28 15:08:51.35203-04
109	\N	39.7391536000000016	-104.984703400000001	McNichols Sports Arena	Denver, Colorado	setlistfm:63d63e2f	2016-06-28 11:08:51-04	2016-06-28 15:08:51.446283-04
110	\N	40.7142691000000028	-74.0059729000000033	Madison Square Garden	New York, New York	setlistfm:23d63cc7	2016-06-28 11:08:51-04	2016-06-28 15:08:51.469196-04
111	\N	38.9340001999999998	-76.8966396999999944	USAir Arena	Landover, Maryland	setlistfm:23d6c093	2016-06-28 11:08:52-04	2016-06-28 15:08:51.511608-04
112	\N	42.3584308000000007	-71.0597731999999951	Boston Garden	Boston, Massachusetts	setlistfm:43d63f07	2016-06-28 11:08:52-04	2016-06-28 15:08:51.55316-04
113	\N	37.8715925999999996	-122.272746999999995	Berkeley Community Theatre	Berkeley, California	setlistfm:63d62ef7	2016-06-28 11:08:52-04	2016-06-28 15:08:51.633113-04
114	\N	39.8964539999999985	-82.4201539000000025	Buckeye Lake Music Center	Thornville, Ohio	setlistfm:5bd5d3e0	2016-06-28 11:08:52-04	2016-06-28 15:08:51.688278-04
115	\N	44.0520690999999971	-123.086753599999994	Autzen Stadium	Eugene, Oregon	setlistfm:bd6c966	2016-06-28 11:08:52-04	2016-06-28 15:08:51.840531-04
116	\N	38.5815719000000001	-121.494399599999994	Cal Expo Amphitheatre	Sacramento, California	setlistfm:43d6c35f	2016-06-28 11:08:52-04	2016-06-28 15:08:51.876832-04
117	\N	25.7742657999999984	-80.1936589000000026	Miami Arena	Miami, Florida	setlistfm:73d63ec5	2016-06-28 11:08:52-04	2016-06-28 15:08:51.897282-04
118	\N	28.5383354999999987	-81.3792365000000046	Orlando Arena	Orlando, Florida	setlistfm:6bd63ee2	2016-06-28 11:08:52-04	2016-06-28 15:08:51.917015-04
119	\N	40.7003793000000016	-73.5929055999999946	Nassau Veterans Memorial Coliseum	Uniondale, New York	setlistfm:1bd6c998	2016-06-28 11:08:52-04	2016-06-28 15:08:51.984763-04
120	\N	41.2397771999999989	-81.6381784999999951	Richfield Coliseum	Richfield, Ohio	setlistfm:73d62601	2016-06-28 11:08:52-04	2016-06-28 15:08:52.019564-04
121	\N	41.9953076999999979	-87.8845091999999966	Rosemont Horizon	Rosemont, Illinois	setlistfm:63d626d3	2016-06-28 11:08:52-04	2016-06-28 15:08:52.032916-04
122	\N	33.4483771000000019	-112.074037300000001	Desert Sky Pavilion	Phoenix, Arizona	setlistfm:3bd624cc	2016-06-28 11:08:52-04	2016-06-28 15:08:52.05244-04
123	\N	32.7153291999999993	-117.1572551	San Diego Sports Arena	San Diego, California	setlistfm:43d637ab	2016-06-28 11:08:52-04	2016-06-28 15:08:52.150177-04
124	\N	39.9523349999999979	-75.1637889999999942	The Spectrum	Philadelphia, Pennsylvania	setlistfm:23d6cc13	2016-06-28 11:08:52-04	2016-06-28 15:08:52.266231-04
125	\N	38.2542376000000033	-85.7594069999999959	Freedom Hall	Louisville, Kentucky	setlistfm:4bd627fa	2016-06-28 11:08:52-04	2016-06-28 15:08:52.43273-04
126	\N	42.7675593000000021	-78.7439188999999971	Rich Stadium	Orchard Park, New York	setlistfm:4bd6277a	2016-06-28 11:08:52-04	2016-06-28 15:08:52.44577-04
127	\N	36.1749705000000006	-115.137223000000006	Sam Boyd Silver Bowl	Las Vegas, Nevada	setlistfm:3d6c963	2016-06-28 11:08:53-04	2016-06-28 15:08:52.556515-04
128	\N	37.7749999999999986	-122.418999999999997	Candlestick Park	San Francisco, California	setlistfm:3bd624d4	2016-06-28 11:08:53-04	2016-06-28 15:08:52.575928-04
129	\N	35.9131995999999987	-79.0558445000000063	Dean Smith Center	Chapel Hill, North Carolina	setlistfm:73d63ee1	2016-06-28 11:08:53-04	2016-06-28 15:08:52.690744-04
130	\N	38.9340001999999998	-76.8966396999999944	Capital Centre	Landover, Maryland	setlistfm:5bd63f00	2016-06-28 11:08:53-04	2016-06-28 15:08:52.72581-04
131	\N	33.3061604999999972	-111.841250200000005	Compton Terrace	Chandler, Arizona	setlistfm:4bd6c752	2016-06-28 11:08:53-04	2016-06-28 15:08:52.885948-04
132	\N	40.382013299999997	-80.3928422999999981	Star Lake Amphitheater	Burgettstown, Pennsylvania	setlistfm:7bd63eb4	2016-06-28 11:08:53-04	2016-06-28 15:08:52.949814-04
133	\N	43.233408353999998	-79.949639868999995	Copps Coliseum	Hamilton, Ontario	setlistfm:23d6c41f	2016-06-28 11:08:53-04	2016-06-28 15:08:53.150745-04
134	\N	37.0298687000000015	-76.3452218000000045	Hampton Coliseum	Hampton, Virginia	setlistfm:2bd5942a	2016-06-28 11:08:53-04	2016-06-28 15:08:53.248487-04
135	\N	37.7749999999999986	-122.418999999999997	Golden Gate Park	San Francisco, California	setlistfm:3d6cdeb	2016-06-28 11:08:53-04	2016-06-28 15:08:53.341823-04
136	\N	39.7391536000000016	-104.984703400000001	Mile High Stadium	Denver, Colorado	setlistfm:3d6216b	2016-06-28 11:08:54-04	2016-06-28 15:08:53.621946-04
137	\N	39.0597259999999977	-94.883575399999998	Sandstone Amphitheater	Bonner Springs, Kansas	setlistfm:6bd63eae	2016-06-28 11:08:54-04	2016-06-28 15:08:53.630435-04
138	\N	42.7086411000000012	-83.4396633000000065	Pine Knob Music Theatre	Clarkston, Michigan	setlistfm:3d6c953	2016-06-28 11:08:54-04	2016-06-28 15:08:53.652148-04
139	\N	34.0519999999999996	-118.244	Los Angeles Memorial Coliseum	Los Angeles, California	setlistfm:3bd6642c	2016-06-28 11:08:54-04	2016-06-28 15:08:53.759533-04
140	\N	36.072635499999997	-79.7919753999999983	Greensboro Coliseum	Greensboro, North Carolina	setlistfm:4bd6cfb6	2016-06-28 11:08:54-04	2016-06-28 15:08:53.862396-04
141	\N	51.5084152563930999	-0.125532746315001997	Wembley Arena	London, England	setlistfm:13d6d901	2016-06-28 11:08:54-04	2016-06-28 15:08:54.092349-04
142	\N	48.8534099999999967	2.34880000000000022	Le Zénith	Paris, Île-de-France	setlistfm:7bd63aa8	2016-06-28 11:08:54-04	2016-06-28 15:08:54.114573-04
143	\N	53.5499999999999972	10	Alsterdorfer Sporthalle	Hamburg, Hamburg	setlistfm:43d623e3	2016-06-28 11:08:54-04	2016-06-28 15:08:54.129884-04
144	\N	50.1166667000000032	8.68333329999999926	Festhalle	Frankfurt, Hesse	setlistfm:7bd63ab0	2016-06-28 11:08:54-04	2016-06-28 15:08:54.137637-04
145	\N	52.5166667000000018	13.4000000000000004	ICC	Berlin, Berlin	setlistfm:63d61e5b	2016-06-28 11:08:54-04	2016-06-28 15:08:54.144164-04
146	\N	51.4500000000000028	7.01666670000000003	Grugahalle	Essen, North Rhine-Westphalia	setlistfm:7bd62238	2016-06-28 11:08:54-04	2016-06-28 15:08:54.159405-04
147	\N	59.3325765361753028	18.0649030208588002	Johanneshov Isstadion	Stockholm, Stockholm County	setlistfm:13d67d85	2016-06-28 11:08:54-04	2016-06-28 15:08:54.166463-04
148	\N	41.5733669000000035	-87.7844943999999998	World Music Theatre	Tinley Park, Illinois	setlistfm:63d6d23f	2016-06-28 11:08:54-04	2016-06-28 15:08:54.283059-04
149	\N	42.0653768000000028	-71.2478308000000027	Foxboro Stadium	Foxborough, Massachusetts	setlistfm:3d6d5b3	2016-06-28 11:08:54-04	2016-06-28 15:08:54.333957-04
150	\N	35.7720959999999977	-78.6386145000000027	Carter-Finley Stadium	Raleigh, North Carolina	setlistfm:13d62169	2016-06-28 11:08:54-04	2016-06-28 15:08:54.350963-04
151	\N	38.2542376000000033	-85.7594069999999959	Cardinal Stadium	Louisville, Kentucky	setlistfm:63d62667	2016-06-28 11:08:54-04	2016-06-28 15:08:54.365751-04
152	\N	33.8314057999999989	-118.282016499999997	Cal State Dominguez Hills	Carson, California	setlistfm:3d6c94b	2016-06-28 11:08:54-04	2016-06-28 15:08:54.465369-04
153	\N	41.7637111000000019	-72.6850931999999972	Hartford Civic Center	Hartford, Connecticut	setlistfm:13d63989	2016-06-28 11:08:55-04	2016-06-28 15:08:54.560825-04
154	\N	33.9616801000000024	-118.353131099999999	Great Western Forum	Inglewood, California	setlistfm:bd63db6	2016-06-28 11:08:55-04	2016-06-28 15:08:54.673643-04
155	\N	40.8339890000000025	-74.0970865000000032	Brendan Byrne Arena	East Rutherford, New Jersey	setlistfm:73d626dd	2016-06-28 11:08:55-04	2016-06-28 15:08:54.775198-04
156	\N	37.8715925999999996	-122.272746999999995	Greek Theatre	Berkeley, California	setlistfm:4bd6271e	2016-06-28 11:08:55-04	2016-06-28 15:08:54.841933-04
157	\N	42.7852922000000007	-88.4050960000000003	Alpine Valley Music Theatre	East Troy, Wisconsin	setlistfm:23d63cf7	2016-06-28 11:08:55-04	2016-06-28 15:08:54.881255-04
158	\N	39.9523349999999979	-75.1637889999999942	JFK Stadium	Philadelphia, Pennsylvania	setlistfm:23d62497	2016-06-28 11:08:55-04	2016-06-28 15:08:54.984376-04
159	\N	42.0653768000000028	-71.2478308000000027	Sullivan Stadium	Foxborough, Massachusetts	setlistfm:13d6d5bd	2016-06-28 11:08:55-04	2016-06-28 15:08:54.997572-04
160	\N	37.8043722000000031	-122.270802599999996	Oakland-Alameda County Coliseum	Oakland, California	setlistfm:7bd6c224	2016-06-28 11:08:55-04	2016-06-28 15:08:55.025246-04
161	\N	37.4241060000000019	-122.166075599999999	Frost Amphitheatre	Stanford, California	setlistfm:bd7393a	2016-06-28 11:08:55-04	2016-06-28 15:08:55.032518-04
162	\N	33.6694649000000013	-117.823110700000001	Irvine Meadows	Irvine, California	setlistfm:2bd62086	2016-06-28 11:08:55-04	2016-06-28 15:08:55.049324-04
163	\N	44.8407979999999995	-93.2982798999999972	Met Center	Bloomington, Minnesota	setlistfm:6bd62eee	2016-06-28 11:08:55-04	2016-06-28 15:08:55.069672-04
164	\N	43.038902499999999	-87.9064735999999982	Mecca Arena	Milwaukee, Wisconsin	setlistfm:73d6c2fd	2016-06-28 11:08:55-04	2016-06-28 15:08:55.075456-04
165	\N	39.1620035999999985	-84.4568862999999936	Riverfront Coliseum	Cincinnati, Ohio	setlistfm:7bd63ed8	2016-06-28 11:08:55-04	2016-06-28 15:08:55.207874-04
166	\N	42.2775627973979979	-83.7408828735351989	Crisler Arena	Ann Arbor, Michigan	setlistfm:73d63ed9	2016-06-28 11:08:55-04	2016-06-28 15:08:55.215538-04
167	\N	40.4406248000000019	-79.9958864000000034	Civic Arena	Pittsburgh, Pennsylvania	setlistfm:4bd6234e	2016-06-28 11:08:55-04	2016-06-28 15:08:55.229044-04
168	\N	37.8043722000000031	-122.270802599999996	Henry J. Kaiser Convention Center	Oakland, California	setlistfm:13d6c945	2016-06-28 11:08:55-04	2016-06-28 15:08:55.290364-04
169	\N	33.766962300000003	-118.189234799999994	Long Beach Arena	Long Beach, California	setlistfm:bd63982	2016-06-28 11:08:55-04	2016-06-28 15:08:55.356866-04
170	\N	32.7830555999999973	-96.8066666999999939	Reunion Arena	Dallas, Texas	setlistfm:63d63ecb	2016-06-28 11:08:55-04	2016-06-28 15:08:55.375969-04
171	\N	29.7632836000000012	-95.3632714999999962	The Summit	Houston, Texas	setlistfm:1bd6c9f0	2016-06-28 11:08:55-04	2016-06-28 15:08:55.385059-04
172	\N	29.9549999999999983	-90.0750000000000028	Kiefer UNO Lakefront Arena	New Orleans, Louisiana	setlistfm:3d62ddb	2016-06-28 11:08:55-04	2016-06-28 15:08:55.393425-04
173	\N	27.7708605999999989	-82.6792661000000066	Bayfront Center	St. Petersburg, Florida	setlistfm:73d626d5	2016-06-28 11:08:55-04	2016-06-28 15:08:55.400944-04
174	\N	47.2528768999999969	-122.444290600000002	Tacoma Dome	Tacoma, Washington	setlistfm:5bd61f78	2016-06-28 11:08:56-04	2016-06-28 15:08:55.577684-04
175	\N	36.6002378000000022	-121.894676099999998	Laguna Seca Raceway	Monterey, California	setlistfm:1bd6c94c	2016-06-28 11:08:56-04	2016-06-28 15:08:55.585026-04
176	\N	44.131737600000001	-70.4931140000000056	Oxford Plains Speedway	Oxford, Maine	setlistfm:bd619fe	2016-06-28 11:08:56-04	2016-06-28 15:08:55.626895-04
177	\N	43.1547844999999981	-77.6155567999999931	Silver Stadium	Rochester, New York	setlistfm:7bd626e8	2016-06-28 11:08:56-04	2016-06-28 15:08:55.67041-04
178	\N	43.0831300999999982	-73.7845650999999947	Saratoga Performing Arts Center	Saratoga Springs, New York	setlistfm:4bd63b2e	2016-06-28 11:08:56-04	2016-06-28 15:08:55.680844-04
179	\N	42.3314269999999979	-83.0457538	Joe Louis Arena	Detroit, Michigan	setlistfm:23d6d013	2016-06-28 11:08:56-04	2016-06-28 15:08:55.793064-04
180	\N	42.2625931999999978	-71.8022933999999964	The Centrum	Worcester, Massachusetts	setlistfm:43d63ffb	2016-06-28 11:08:56-04	2016-06-28 15:08:55.801713-04
181	\N	37.7749999999999986	-122.418999999999997	San Francisco Civic Auditorium	San Francisco, California	setlistfm:73d4c665	2016-06-28 11:08:56-04	2016-06-28 15:08:55.934106-04
182	\N	40.7142691000000028	-74.0059729000000033	Late Night With David Letterman	New York, New York	setlistfm:7bd4e288	2016-06-28 11:08:56-04	2016-06-28 15:08:56.131539-04
183	\N	41.8239890999999986	-71.4128343000000001	Providence Civic Center	Providence, Rhode Island	setlistfm:1bd6c9bc	2016-06-28 11:08:56-04	2016-06-28 15:08:56.222881-04
184	\N	38.0682553999999982	-120.539645699999994	Calaveras County Fairgrounds	Angels Camp, California	setlistfm:2bd6309a	2016-06-28 11:08:56-04	2016-06-28 15:08:56.242137-04
185	\N	40.6460622000000029	-111.497972899999994	Park West	Park City, Utah	setlistfm:1bd6c1b8	2016-06-28 11:08:56-04	2016-06-28 15:08:56.256235-04
186	\N	37.9374938999999998	-107.812285200000005	Town Park	Telluride, Colorado	setlistfm:bd6c94e	2016-06-28 11:08:56-04	2016-06-28 15:08:56.270748-04
187	\N	39.6535987999999975	-105.191099600000001	Red Rocks Amphitheatre	Morrison, Colorado	setlistfm:7bd63674	2016-06-28 11:08:56-04	2016-06-28 15:08:56.283304-04
188	\N	33.8352932000000024	-117.914503600000003	Anaheim Stadium	Anaheim, California	setlistfm:7bd6262c	2016-06-28 11:08:56-04	2016-06-28 15:08:56.30615-04
189	\N	37.2709704000000031	-79.9414266999999938	Roanoke Civic Center	Roanoke, Virginia	setlistfm:2bd61c92	2016-06-28 11:08:56-04	2016-06-28 15:08:56.365975-04
190	\N	43.8334146329999967	-79.5329134290000042	Kingswood Music Theatre	Vaughan, Ontario	setlistfm:53d73ffd	2016-06-28 11:08:56-04	2016-06-28 15:08:56.398571-04
191	\N	34.2783352000000008	-119.293167600000004	Ventura County Fairgrounds	Ventura, California	setlistfm:1bd6c92c	2016-06-28 11:08:56-04	2016-06-28 15:08:56.44289-04
192	\N	41.8500330000000034	-87.6500522999999987	UIC Pavilion	Chicago, Illinois	setlistfm:7bd62658	2016-06-28 11:08:57-04	2016-06-28 15:08:56.542579-04
193	\N	41.0814446999999987	-81.5190053000000034	Rubber Bowl	Akron, Ohio	setlistfm:73d6c24d	2016-06-28 11:08:57-04	2016-06-28 15:08:56.798801-04
194	\N	39.1620035999999985	-84.4568862999999936	Riverbend Music Center	Cincinnati, Ohio	setlistfm:2bd4a04a	2016-06-28 11:08:57-04	2016-06-28 15:08:56.806603-04
195	\N	44.9799653999999975	-93.263836100000006	Hubert H. Humphrey Metrodome	Minneapolis, Minnesota	setlistfm:3bd62414	2016-06-28 11:08:57-04	2016-06-28 15:08:56.826123-04
196	\N	43.6614709999999988	-70.2553259000000025	Cumberland County Civic Center	Portland, Maine	setlistfm:7bd626cc	2016-06-28 11:08:57-04	2016-06-28 15:08:56.982392-04
197	\N	43.1547844999999981	-77.6155567999999931	Rochester Community War Memorial	Rochester, New York	setlistfm:2bd6283a	2016-06-28 11:08:57-04	2016-06-28 15:08:57.180061-04
198	\N	37.5537575000000032	-77.4602617000000038	Richmond Coliseum	Richmond, Virginia	setlistfm:4bd61fd6	2016-06-28 11:08:57-04	2016-06-28 15:08:57.207012-04
199	\N	34.0007104000000027	-81.0348144000000019	Carolina Coliseum	Columbia, South Carolina	setlistfm:bd6c14e	2016-06-28 11:08:57-04	2016-06-28 15:08:57.220838-04
200	\N	33.7489953999999983	-84.3879823999999985	Fox Theater	Atlanta, Georgia	setlistfm:4bd63f56	2016-06-28 11:08:57-04	2016-06-28 15:08:57.227908-04
201	\N	27.9475216000000017	-82.4584279000000038	USF Sun Dome	Tampa, Florida	setlistfm:63d6265b	2016-06-28 11:08:57-04	2016-06-28 15:08:57.24087-04
202	\N	26.0112014000000009	-80.1494900999999942	Sportatorium	Hollywood, Florida	setlistfm:bd625e2	2016-06-28 11:08:57-04	2016-06-28 15:08:57.252081-04
203	\N	32.6400541000000004	-117.084195500000007	DeVore Stadium	Chula Vista, California	setlistfm:43d6c377	2016-06-28 11:08:57-04	2016-06-28 15:08:57.265365-04
204	\N	39.0997265999999968	-94.5785666999999961	Starlight Theater	Kansas City, Missouri	setlistfm:13d6c92d	2016-06-28 11:08:57-04	2016-06-28 15:08:57.321205-04
205	\N	35.4675602000000012	-97.5164276000000001	Zoo Amphitheatre	Oklahoma City, Oklahoma	setlistfm:53d62f55	2016-06-28 11:08:57-04	2016-06-28 15:08:57.362336-04
206	\N	30.3407629000000014	-97.5569456000000059	Manor Downs	Manor, Texas	setlistfm:53d62b11	2016-06-28 11:08:57-04	2016-06-28 15:08:57.369772-04
207	\N	29.7632836000000012	-95.3632714999999962	Southern Star Amphitheater	Houston, Texas	setlistfm:6bd626b6	2016-06-28 11:08:57-04	2016-06-28 15:08:57.375744-04
208	\N	39.3279619999999994	-120.183253300000004	Boreal Mountain Resort	Truckee, California	setlistfm:73d61ab5	2016-06-28 11:08:57-04	2016-06-28 15:08:57.384777-04
209	\N	39.2403841	-76.8394183999999996	Merriweather Post Pavilion	Columbia, Maryland	setlistfm:53d61ff5	2016-06-28 11:08:57-04	2016-06-28 15:08:57.414595-04
210	\N	40.2859239000000002	-76.650246800000005	Hersheypark Stadium	Hershey, Pennsylvania	setlistfm:43d61fd7	2016-06-28 11:08:57-04	2016-06-28 15:08:57.427938-04
211	\N	41.133944900000003	-81.4845585000000057	Blossom Music Center	Cuyahoga Falls, Ohio	setlistfm:5bd627e0	2016-06-28 11:08:57-04	2016-06-28 15:08:57.442384-04
212	\N	42.1014831000000029	-72.5898109999999974	Springfield Civic Center	Springfield, Massachusetts	setlistfm:33d62839	2016-06-28 11:08:58-04	2016-06-28 15:08:57.61446-04
213	\N	43.0481221000000005	-76.1474244000000056	Carrier Dome	Syracuse, New York	setlistfm:63d626ef	2016-06-28 11:08:58-04	2016-06-28 15:08:57.779799-04
214	\N	44.3106240999999983	-69.7794896999999992	Augusta Civic Center	Augusta, Maine	setlistfm:1bd6c900	2016-06-28 11:08:58-04	2016-06-28 15:08:57.813118-04
215	\N	42.008332799999998	-91.6440683000000007	Five Seasons Center	Cedar Rapids, Iowa	setlistfm:33d624bd	2016-06-28 11:08:58-04	2016-06-28 15:08:57.937256-04
216	\N	39.7683765000000022	-86.1580423000000053	Sports and Music Center	Indianapolis, Indiana	setlistfm:1bd6c944	2016-06-28 11:08:58-04	2016-06-28 15:08:57.958002-04
217	\N	40.2737002000000004	-76.8844179000000025	City Island	Harrisburg, Pennsylvania	setlistfm:13d6c931	2016-06-28 11:08:58-04	2016-06-28 15:08:57.997139-04
218	\N	44.0520690999999971	-123.086753599999994	Silva Hall (Hult Center)	Eugene, Oregon	setlistfm:bd6c932	2016-06-28 11:08:58-04	2016-06-28 15:08:58.078202-04
219	\N	41.3081527000000008	-72.9281577999999939	New Haven Veterans Memorial Coliseum	New Haven, Connecticut	setlistfm:3d731f3	2016-06-28 11:08:58-04	2016-06-28 15:08:58.126164-04
220	\N	39.9523349999999979	-75.1637889999999942	Convention Hall	Philadelphia, Pennsylvania	setlistfm:13d60965	2016-06-28 11:08:58-04	2016-06-28 15:08:58.140024-04
221	\N	43.0944999000000024	-79.0567111000000011	Niagara Falls Convention Center	Niagara Falls, New York	setlistfm:1bd6d9ec	2016-06-28 11:08:58-04	2016-06-28 15:08:58.160814-04
222	\N	36.1749705000000006	-115.137223000000006	Aladdin Theater	Las Vegas, Nevada	setlistfm:1bd62508	2016-06-28 11:08:58-04	2016-06-28 15:08:58.228799-04
223	\N	37.9735346000000007	-122.531087400000004	Marin County Veteran's Auditorium	San Rafael, California	setlistfm:1bd6c938	2016-06-28 11:08:58-04	2016-06-28 15:08:58.235589-04
224	\N	44.2794911000000013	-73.9798712999999992	Olympic Center	Lake Placid, New York	setlistfm:3d6c93f	2016-06-28 11:08:58-04	2016-06-28 15:08:58.329801-04
225	\N	36.9102310000000031	-121.756894599999995	Santa Cruz County Fairgrounds	Watsonville, California	setlistfm:bd6c93e	2016-06-28 11:08:58-04	2016-06-28 15:08:58.398176-04
226	\N	38.6926881999999992	-122.996666500000003	Nevada County Fairgrounds	Grass Valley, California	setlistfm:13d6c93d	2016-06-28 11:08:58-04	2016-06-28 15:08:58.406645-04
227	\N	35.6869751999999991	-105.937798999999998	Santa Fe Downs	Santa Fe, New Mexico	setlistfm:1bd6c934	2016-06-28 11:08:58-04	2016-06-28 15:08:58.417656-04
228	\N	43.6135001999999972	-116.203450500000002	Boise State University Pavilion	Boise, Idaho	setlistfm:43d6c33b	2016-06-28 11:08:58-04	2016-06-28 15:08:58.456306-04
229	\N	47.6062094999999985	-122.332070799999997	Seattle Center Coliseum	Seattle, Washington	setlistfm:3bd62004	2016-06-28 11:08:58-04	2016-06-28 15:08:58.481278-04
230	\N	45.5234515000000002	-122.676207099999999	Portland Memorial Coliseum	Portland, Oregon	setlistfm:43d62f4b	2016-06-28 11:08:58-04	2016-06-28 15:08:58.487846-04
231	\N	42.0428051999999965	-88.0797950000000043	Poplar Creek Music Theater	Hoffman Estates, Illinois	setlistfm:bd6c142	2016-06-28 11:08:59-04	2016-06-28 15:08:58.591176-04
232	\N	44.9444100999999989	-93.0932741999999962	St. Paul Civic Center	St. Paul, Minnesota	setlistfm:3d6c9cf	2016-06-28 11:08:59-04	2016-06-28 15:08:58.604815-04
233	\N	43.0730517000000006	-89.4012302000000005	Dane County Coliseum	Madison, Wisconsin	setlistfm:bd62122	2016-06-28 11:08:59-04	2016-06-28 15:08:58.6131-04
234	\N	44.8831248999999985	-68.6719769999999983	Alfond Arena (U of Maine)	Orono, Maine	setlistfm:1bd6c930	2016-06-28 11:08:59-04	2016-06-28 15:08:58.702261-04
235	\N	44.4758824999999973	-73.2120720000000063	Patrick Gymnasium	Burlington, Vermont	setlistfm:63d626c3	2016-06-28 11:08:59-04	2016-06-28 15:08:58.776706-04
236	\N	42.0986867000000018	-75.9179737999999986	Broome County Veterans Memorial Arena	Binghamton, New York	setlistfm:1bd7a118	2016-06-28 11:08:59-04	2016-06-28 15:08:58.785012-04
237	\N	39.6295259999999985	-79.955896800000005	West Virginia University Coliseum	Morgantown, West Virginia	setlistfm:6bd64a72	2016-06-28 11:08:59-04	2016-06-28 15:08:58.792601-04
238	\N	37.7749999999999986	-122.418999999999997	The Warfield	San Francisco, California	setlistfm:63d63667	2016-06-28 11:08:59-04	2016-06-28 15:08:58.806116-04
239	\N	33.4147680000000022	-111.909309500000006	Compton Terrace	Tempe, Arizona	setlistfm:3d4fd37	2016-06-28 11:08:59-04	2016-06-28 15:08:58.840228-04
240	\N	37.8043722000000031	-122.270802599999996	Civic Auditorium	Oakland, California	setlistfm:5bd74700	2016-06-28 11:08:59-04	2016-06-28 15:08:58.847313-04
241	\N	18.4666667000000011	-77.9166666999999933	Bob Marley Performing Arts Center	Montego Bay, Saint James	setlistfm:13d6c935	2016-06-28 11:08:59-04	2016-06-28 15:08:58.883586-04
242	\N	38.0293058999999971	-78.4766781000000009	University Hall	Charlottesville, Virginia	setlistfm:bd621b6	2016-06-28 11:08:59-04	2016-06-28 15:08:58.982707-04
243	\N	28.039465400000001	-81.9498042000000027	Civic Center	Lakeland, Florida	setlistfm:5bd62754	2016-06-28 11:08:59-04	2016-06-28 15:08:58.991134-04
244	\N	26.7153424999999984	-80.0533745999999979	West Palm Beach Auditorium	West Palm Beach, Florida	setlistfm:63d6c283	2016-06-28 11:08:59-04	2016-06-28 15:08:58.997775-04
245	\N	29.9549999999999983	-90.0750000000000028	Saenger Performing Arts Theater	New Orleans, Louisiana	setlistfm:63d626ab	2016-06-28 11:08:59-04	2016-06-28 15:08:59.005046-04
246	\N	34.1083448999999987	-117.289765200000005	Glen Helen Regional Park	San Bernardino, California	setlistfm:2bd7e88a	2016-06-28 11:08:59-04	2016-06-28 15:08:59.012298-04
247	\N	44.0487341999999984	-123.350929399999998	Oregon County Fair Site	Veneta, Oregon	setlistfm:bd6c92e	2016-06-28 11:08:59-04	2016-06-28 15:08:59.024333-04
248	\N	41.6611277000000015	-91.5301682999999997	University of Iowa	Iowa City, Iowa	setlistfm:bd63d96	2016-06-28 11:08:59-04	2016-06-28 15:08:59.032049-04
249	\N	38.6272732999999988	-90.1978888999999953	Kiel Auditorium	St. Louis, Missouri	setlistfm:43d623cb	2016-06-28 11:08:59-04	2016-06-28 15:08:59.088136-04
250	\N	37.7749999999999986	-122.418999999999997	Moscone Center	San Francisco, California	setlistfm:3d6c923	2016-06-28 11:08:59-04	2016-06-28 15:08:59.155148-04
251	\N	39.2903847999999982	-76.6121892999999972	Baltimore Civic Center	Baltimore, Maryland	setlistfm:3d6c9cb	2016-06-28 11:08:59-04	2016-06-28 15:08:59.181196-04
252	\N	43.3095163999999997	-73.6440058000000022	Glens Falls Civic Center	Glens Falls, New York	setlistfm:13d6c155	2016-06-28 11:08:59-04	2016-06-28 15:08:59.208155-04
253	\N	43.0481221000000005	-76.1474244000000056	Onondaga War Memorial Auditorium	Syracuse, New York	setlistfm:3d6c9eb	2016-06-28 11:08:59-04	2016-06-28 15:08:59.272633-04
254	\N	36.8468146000000019	-76.2852182999999968	The Scope	Norfolk, Virginia	setlistfm:63d6c243	2016-06-28 11:08:59-04	2016-06-28 15:08:59.291674-04
255	\N	35.9940329000000006	-78.8986189999999965	Cameron Indoor Stadium	Durham, North Carolina	setlistfm:bd6c9aa	2016-06-28 11:08:59-04	2016-06-28 15:08:59.300697-04
256	\N	38.5449065000000033	-121.740516700000001	Recreation Hall (UC Davis)	Davis, California	setlistfm:bd6c922	2016-06-28 11:08:59-04	2016-06-28 15:08:59.30938-04
257	\N	39.5296329000000028	-119.813802699999997	Reno Centennial Coliseum	Reno, Nevada	setlistfm:13d6c921	2016-06-28 11:08:59-04	2016-06-28 15:08:59.316516-04
258	\N	34.0519999999999996	-118.244	Pauley Pavilion (UCLA)	Los Angeles, California	setlistfm:bd6c9f2	2016-06-28 11:08:59-04	2016-06-28 15:08:59.322863-04
259	\N	32.7153291999999993	-117.1572551	Golden Hall	San Diego, California	setlistfm:63d62e7b	2016-06-28 11:08:59-04	2016-06-28 15:08:59.329758-04
260	\N	37.5629916999999978	-122.325525400000004	Fiesta Hall (County Fairgrounds)	San Mateo, California	setlistfm:1bd6c920	2016-06-28 11:08:59-04	2016-06-28 15:08:59.454028-04
261	\N	40.0149856000000028	-105.270545600000005	CU Events Center	Boulder, Colorado	setlistfm:43d4d3c3	2016-06-28 11:08:59-04	2016-06-28 15:08:59.465992-04
262	\N	41.6005448000000015	-93.6091064000000017	Des Moines Civic Center	Des Moines, Iowa	setlistfm:13d6c90d	2016-06-28 11:08:59-04	2016-06-28 15:08:59.474357-04
263	\N	39.7683765000000022	-86.1580423000000053	Market Square Arena	Indianapolis, Indiana	setlistfm:5bd623d4	2016-06-28 11:08:59-04	2016-06-28 15:08:59.488771-04
264	\N	40.1164204999999967	-88.2433829000000003	Assembly Hall	Champaign, Illinois	setlistfm:1bd6212c	2016-06-28 11:09:00-04	2016-06-28 15:08:59.504345-04
265	\N	39.7589478000000014	-84.1916068999999965	Hara Arena	Dayton, Ohio	setlistfm:63d5d61b	2016-06-28 11:09:00-04	2016-06-28 15:08:59.519374-04
266	\N	41.3887868890716035	2.15898513793945002	Palau dels Esports	Barcelona, Catalonia	setlistfm:13d6c105	2016-06-28 11:09:00-04	2016-06-28 15:08:59.53526-04
267	\N	48.8534099999999967	2.34880000000000022	Hippodrome de Pantin	Paris, Île-de-France	setlistfm:53d6475d	2016-06-28 11:09:00-04	2016-06-28 15:08:59.545338-04
268	\N	52.3729999999999976	4.90000000000000036	Melkweg	Amsterdam, North Holland	setlistfm:73d6da59	2016-06-28 11:09:00-04	2016-06-28 15:08:59.555038-04
269	\N	49.9924999999999997	8.4350000000000005	Walter-Köbel-Halle	Rüsselsheim, Hesse	setlistfm:4bd49b92	2016-06-28 11:09:00-04	2016-06-28 15:08:59.575394-04
270	\N	48.137432549810903	11.5754914283751997	Olympiahalle	Munich, Bavaria	setlistfm:2bd6cc7a	2016-06-28 11:09:00-04	2016-06-28 15:08:59.58451-04
271	\N	53.0751556794029966	8.80777359008789062	Stadthalle	Bremen, Bremen	setlistfm:5bd6c720	2016-06-28 11:09:00-04	2016-06-28 15:08:59.598992-04
272	\N	55.6776812020993006	12.5709342956543004	Forum København	Copenhagen, Capital Region	setlistfm:73d61e69	2016-06-28 11:09:00-04	2016-06-28 15:08:59.614905-04
273	\N	51.5084152563930999	-0.125532746315001997	Rainbow Theatre	London, England	setlistfm:5bd62f80	2016-06-28 11:09:00-04	2016-06-28 15:08:59.624224-04
274	\N	55.9500000000000028	-3.20000000000000018	Edinburgh Playhouse	Edinburgh, Scotland	setlistfm:2bd424b2	2016-06-28 11:09:00-04	2016-06-28 15:08:59.733895-04
275	\N	42.8864468000000016	-78.8783688999999981	Buffalo Memorial Auditorium	Buffalo, New York	setlistfm:bd6d5aa	2016-06-28 11:09:00-04	2016-06-28 15:08:59.748977-04
276	\N	40.8617301999999967	-78.7303073000000069	Stabler Arena	Bethlehem, Pennsylvania	setlistfm:3d6c12f	2016-06-28 11:09:00-04	2016-06-28 15:08:59.75616-04
277	\N	44.0520690999999971	-123.086753599999994	McArthur Court (U of Oregon)	Eugene, Oregon	setlistfm:3d6c9db	2016-06-28 11:09:00-04	2016-06-28 15:08:59.82299-04
278	\N	40.760779399999997	-111.891047400000005	Salt Palace	Salt Lake City, Utah	setlistfm:6bd6c2de	2016-06-28 11:09:00-04	2016-06-28 15:08:59.846562-04
279	\N	39.0997265999999968	-94.5785666999999961	Municipal Auditorium	Kansas City, Missouri	setlistfm:63d6c23f	2016-06-28 11:09:00-04	2016-06-28 15:08:59.946841-04
280	\N	42.4406284000000014	-76.4966071000000056	Barton Hall	Ithaca, New York	setlistfm:1bd7bdc0	2016-06-28 11:09:00-04	2016-06-28 15:08:59.9918-04
281	\N	40.4862157999999965	-74.4518187999999981	Athletic Center (Rutgers U)	New Brunswick, New Jersey	setlistfm:bd6c91e	2016-06-28 11:09:00-04	2016-06-28 15:09:00.000323-04
282	\N	40.7142691000000028	-74.0059729000000033	The Tomorrow Show	New York, New York	setlistfm:23d5a807	2016-06-28 11:09:00-04	2016-06-28 15:09:00.041515-04
283	\N	43.1009030999999965	-75.2326640999999938	Utica Memorial Auditorium	Utica, New York	setlistfm:3d6c913	2016-06-28 11:09:00-04	2016-06-28 15:09:00.195679-04
284	\N	38.9806659999999994	-76.9369188999999949	Cole Field House	College Park, Maryland	setlistfm:6bd62a1e	2016-06-28 11:09:00-04	2016-06-28 15:09:00.224918-04
285	\N	40.4406248000000019	-79.9958864000000034	Stanley Theater	Pittsburgh, Pennsylvania	setlistfm:5bd637bc	2016-06-28 11:09:00-04	2016-06-28 15:09:00.232951-04
286	\N	41.4994954000000007	-81.6954087999999956	Cleveland Music Hall	Cleveland, Ohio	setlistfm:63d62643	2016-06-28 11:09:00-04	2016-06-28 15:09:00.250384-04
287	\N	41.8500330000000034	-87.6500522999999987	Uptown Theater	Chicago, Illinois	setlistfm:1bd6c9e4	2016-06-28 11:09:00-04	2016-06-28 15:09:00.264885-04
288	\N	34.1083448999999987	-117.289765200000005	Swing Auditorium	San Bernardino, California	setlistfm:6bd62e22	2016-06-28 11:09:00-04	2016-06-28 15:09:00.424678-04
289	\N	37.9060368000000025	-122.544976300000002	Mill Valley Recreation Center	Mill Valley, California	setlistfm:13d6c911	2016-06-28 11:09:00-04	2016-06-28 15:09:00.431888-04
290	\N	29.6516343999999989	-82.324826200000004	Florida Gymnasium	Gainesville, Florida	setlistfm:43d437db	2016-06-28 11:09:00-04	2016-06-28 15:09:00.443211-04
291	\N	40.7142691000000028	-74.0059729000000033	Radio City Music Hall	New York, New York	setlistfm:23d624c7	2016-06-28 11:09:00-04	2016-06-28 15:09:00.46621-04
292	\N	44.1003510000000034	-70.2147764000000052	State Fairgrounds	Lewiston, Maine	setlistfm:bd6c916	2016-06-28 11:09:01-04	2016-06-28 15:09:00.796552-04
293	\N	41.4994954000000007	-81.6954087999999956	Public Hall	Cleveland, Ohio	setlistfm:6bd626c6	2016-06-28 11:09:01-04	2016-06-28 15:09:00.869449-04
294	\N	46.7657748999999967	-89.275698300000002	Grand Center	Grand Rapids, Michigan	setlistfm:13d6c915	2016-06-28 11:09:01-04	2016-06-28 15:09:00.875019-04
295	\N	38.8114363999999981	-89.9531570000000045	Southern Illinois University Edwardsville	Edwardsville, Illinois	setlistfm:63d762ff	2016-06-28 11:09:01-04	2016-06-28 15:09:00.921198-04
296	\N	61.2180555999999996	-149.900277799999998	West High Auditorium	Anchorage, Alaska	setlistfm:13d6c909	2016-06-28 11:09:01-04	2016-06-28 15:09:00.94554-04
297	\N	47.6587802999999965	-117.426046600000006	Spokane Coliseum	Spokane, Washington	setlistfm:bd6c14a	2016-06-28 11:09:01-04	2016-06-28 15:09:01.005082-04
298	\N	40.0149856000000028	-105.270545600000005	Folsom Field	Boulder, Colorado	setlistfm:43d6c3f7	2016-06-28 11:09:01-04	2016-06-28 15:09:01.031287-04
299	\N	44.8407979999999995	-93.2982798999999972	Metropolitan Sports Center	Bloomington, Minnesota	setlistfm:bd6c9a2	2016-06-28 11:09:01-04	2016-06-28 15:09:01.056343-04
300	\N	43.038902499999999	-87.9064735999999982	Milwaukee Auditorium	Milwaukee, Wisconsin	setlistfm:13d6c9e5	2016-06-28 11:09:01-04	2016-06-28 15:09:01.063677-04
301	\N	40.8020059999999987	-77.856390200000007	Penn State Recreation Hall	University Park, Pennsylvania	setlistfm:33d6c0a5	2016-06-28 11:09:01-04	2016-06-28 15:09:01.134871-04
302	\N	33.5206608000000017	-86.8024900000000059	Boutwell Auditorium	Birmingham, Alabama	setlistfm:3d629af	2016-06-28 11:09:01-04	2016-06-28 15:09:01.211938-04
303	\N	40.7142691000000028	-74.0059729000000033	NBC Studios	New York, New York	setlistfm:2bd63c3a	2016-06-28 11:09:01-04	2016-06-28 15:09:01.218409-04
304	\N	40.8567662999999968	-74.1284763999999967	Capitol Theatre	Passaic, New Jersey	setlistfm:7bd6c264	2016-06-28 11:09:01-04	2016-06-28 15:09:01.220375-04
305	\N	39.1141707999999966	-94.6274570000000068	Memorial Hall	Kansas City, Kansas	setlistfm:33d5f825	2016-06-28 11:09:01-04	2016-06-28 15:09:01.283296-04
306	\N	39.7683765000000022	-86.1580423000000053	Indiana Convention Center	Indianapolis, Indiana	setlistfm:7bd6c288	2016-06-28 11:09:01-04	2016-06-28 15:09:01.310163-04
307	\N	41.6667778999999996	-70.184741399999993	Cape Cod Coliseum	South Yarmouth, Massachusetts	setlistfm:13d6c901	2016-06-28 11:09:01-04	2016-06-28 15:09:01.492377-04
308	\N	43.1547844999999981	-77.6155567999999931	Holleder Stadium	Rochester, New York	setlistfm:3d6c907	2016-06-28 11:09:02-04	2016-06-28 15:09:01.57574-04
309	\N	45.5234515000000002	-122.676207099999999	Portland International Raceway	Portland, Oregon	setlistfm:33d7500d	2016-06-28 11:09:02-04	2016-06-28 15:09:01.636349-04
310	\N	38.5815719000000001	-121.494399599999994	Sacramento Memorial Auditorium	Sacramento, California	setlistfm:4bd6c3aa	2016-06-28 11:09:02-04	2016-06-28 15:09:01.64298-04
311	\N	42.3803675999999996	-72.5231430000000046	Alumni Stadium (U of Mass)	Amherst, Massachusetts	setlistfm:1bd6c904	2016-06-28 11:09:02-04	2016-06-28 15:09:01.660074-04
312	\N	42.5584264000000019	-71.2689469999999972	Billerica Forum	Billerica, Massachusetts	setlistfm:3d6c9fb	2016-06-28 11:09:02-04	2016-06-28 15:09:01.666487-04
313	\N	40.6884319999999988	-75.2207322999999946	Allan Kirby Field House (Lafayette College)	Easton, Pennsylvania	setlistfm:13d6c9f9	2016-06-28 11:09:02-04	2016-06-28 15:09:01.689788-04
314	\N	37.3393857000000011	-121.894955499999995	Spartan Stadium	San Jose, California	setlistfm:3bd63c1c	2016-06-28 11:09:02-04	2016-06-28 15:09:01.75658-04
315	\N	37.9735346000000007	-122.531087400000004	Studio Rehersal, Club Front	San Rafael, California	setlistfm:7bd612c0	2016-06-28 11:09:02-04	2016-06-28 15:09:01.765525-04
316	\N	37.7272727000000003	-89.2167500999999987	S.I.U. Arena	Carbondale, Illinois	setlistfm:5bd6dbb4	2016-06-28 11:09:02-04	2016-06-28 15:09:01.801344-04
317	\N	36.1539816000000016	-95.9927749999999946	Tulsa Fairgrounds Pavilion	Tulsa, Oklahoma	setlistfm:bd6c9fe	2016-06-28 11:09:02-04	2016-06-28 15:09:01.808556-04
318	\N	42.3314269999999979	-83.0457538	Masonic Temple Theatre	Detroit, Michigan	setlistfm:2bd774ba	2016-06-28 11:09:02-04	2016-06-28 15:09:01.8335-04
319	\N	42.8864468000000016	-78.8783688999999981	Shea's Performing Arts Center	Buffalo, New York	setlistfm:5bd607bc	2016-06-28 11:09:02-04	2016-06-28 15:09:01.839733-04
320	\N	37.7749999999999986	-122.418999999999997	Winterland Arena	San Francisco, California	setlistfm:63d6c643	2016-06-28 11:09:02-04	2016-06-28 15:09:01.951191-04
321	\N	32.7830555999999973	-96.8066666999999939	Dallas Convention Center	Dallas, Texas	setlistfm:13d6c9f1	2016-06-28 11:09:02-04	2016-06-28 15:09:01.986256-04
322	\N	32.2987572999999983	-90.1848102999999952	Mississippi Coliseum	Jackson, Mississippi	setlistfm:4bd6c3e6	2016-06-28 11:09:02-04	2016-06-28 15:09:02.001684-04
323	\N	36.1658899000000034	-86.7844431999999983	Nashville Municipal Auditorium	Nashville, Tennessee	setlistfm:bd6c9ee	2016-06-28 11:09:02-04	2016-06-28 15:09:02.020181-04
324	\N	27.9475216000000017	-82.4584279000000038	Curtis Hixon Convention Hall	Tampa, Florida	setlistfm:1bd6c9b4	2016-06-28 11:09:02-04	2016-06-28 15:09:02.034219-04
325	\N	25.7742657999999984	-80.1936589000000026	Jai-Alai Fronton	Miami, Florida	setlistfm:3d6c9b3	2016-06-28 11:09:02-04	2016-06-28 15:09:02.042365-04
326	\N	42.3584308000000007	-71.0597731999999951	Boston Music Hall	Boston, Massachusetts	setlistfm:5bd62f8c	2016-06-28 11:09:02-04	2016-06-28 15:09:02.136523-04
327	\N	40.7142691000000028	-74.0059729000000033	Saturday Night Live	New York, New York	setlistfm:bd6c9f6	2016-06-28 11:09:02-04	2016-06-28 15:09:02.150732-04
328	\N	30.0086110999999995	31.2122221999999994	Son Et Lumiere Theater	Giza, 	setlistfm:13d6c9e1	2016-06-28 11:09:02-04	2016-06-28 15:09:02.189918-04
329	\N	41.2586095999999998	-95.9377920000000017	Omaha Civic Auditorium	Omaha, Nebraska	setlistfm:2bd48446	2016-06-28 11:09:02-04	2016-06-28 15:09:02.289227-04
330	\N	39.0997265999999968	-94.5785666999999961	Arrowhead Stadium	Kansas City, Missouri	setlistfm:6bd6261a	2016-06-28 11:09:02-04	2016-06-28 15:09:02.303556-04
331	\N	34.435829499999997	-119.827638899999997	Campus Stadium (UC Santa Barbara)	Goleta, California	setlistfm:13d6c9b1	2016-06-28 11:09:02-04	2016-06-28 15:09:02.316809-04
332	\N	42.7284117000000023	-73.6917851000000041	RPI Fieldhouse	Troy, New York	setlistfm:33d6c41d	2016-06-28 11:09:02-04	2016-06-28 15:09:02.375405-04
333	\N	43.7022928000000022	-72.2895352999999972	Thompson Arena (Dartmouth College)	Hanover, New Hampshire	setlistfm:1bd6c9e8	2016-06-28 11:09:02-04	2016-06-28 15:09:02.389906-04
334	\N	40.5142025999999973	-88.9906311999999957	Horton Field House (Illinois State U)	Normal, Illinois	setlistfm:3d6c9ef	2016-06-28 11:09:02-04	2016-06-28 15:09:02.397532-04
335	\N	37.9886892000000032	-84.4777152999999998	Rupp Arena	Lexington, Kentucky	setlistfm:43d62347	2016-06-28 11:09:02-04	2016-06-28 15:09:02.41258-04
336	\N	39.9611755000000031	-82.9987942000000061	Franklin Co. Veterans Memorial	Columbus, Ohio	setlistfm:23d6c0a3	2016-06-28 11:09:02-04	2016-06-28 15:09:02.419701-04
337	\N	38.4192496000000006	-82.4451540000000023	Huntington Civic Center	Huntington, West Virginia	setlistfm:3bd62844	2016-06-28 11:09:02-04	2016-06-28 15:09:02.463591-04
338	\N	37.2707022000000023	-76.7074570999999992	William and Mary Hall	Williamsburg, Virginia	setlistfm:3d62d13	2016-06-28 11:09:02-04	2016-06-28 15:09:02.470589-04
339	\N	37.2295732999999984	-80.4139392999999956	Virginia Tech University	Blacksburg, Virginia	setlistfm:43d6c3a7	2016-06-28 11:09:02-04	2016-06-28 15:09:02.478364-04
340	\N	30.3321837999999993	-81.655651000000006	Jacksonville Memorial Coliseum	Jacksonville, Florida	setlistfm:6bd6265a	2016-06-28 11:09:03-04	2016-06-28 15:09:02.504895-04
341	\N	42.527762199999998	-92.4454654000000033	Unidome	Cedar Falls, Iowa	setlistfm:23d624d7	2016-06-28 11:09:03-04	2016-06-28 15:09:02.529597-04
342	\N	37.9577016	-121.290779599999993	Stockton Civic Auditorium	Stockton, California	setlistfm:33d4f0a1	2016-06-28 11:09:03-04	2016-06-28 15:09:02.574809-04
343	\N	36.7477271999999999	-119.772366099999999	Selland Arena	Fresno, California	setlistfm:bd63d12	2016-06-28 11:09:03-04	2016-06-28 15:09:02.590172-04
344	\N	35.3732921000000005	-119.018712500000007	Bakersfield Civic Auditorium	Bakersfield, California	setlistfm:13d6c9d9	2016-06-28 11:09:03-04	2016-06-28 15:09:02.596121-04
345	\N	34.420830500000001	-119.698190100000005	Arlington Theatre	Santa Barbara, California	setlistfm:43d6375b	2016-06-28 11:09:03-04	2016-06-28 15:09:02.628529-04
346	\N	34.0519999999999996	-118.244	Shrine Auditorium	Los Angeles, California	setlistfm:7bd6d2d4	2016-06-28 11:09:03-04	2016-06-28 15:09:02.636276-04
347	\N	42.8270136000000008	-75.5446237999999965	Cotterell Court, Colgate University	Hamilton, New York	setlistfm:2bd44062	2016-06-28 11:09:03-04	2016-06-28 15:09:02.711376-04
348	\N	43.700113788000003	-79.4163041940000056	Field House (Seneca College)	Toronto, Ontario	setlistfm:3d6c9df	2016-06-28 11:09:03-04	2016-06-28 15:09:02.718798-04
349	\N	42.3314269999999979	-83.0457538	Cobo Arena	Detroit, Michigan	setlistfm:3bd638c4	2016-06-28 11:09:03-04	2016-06-28 15:09:02.725997-04
350	\N	39.1653250000000028	-86.5263857000000058	Indiana University Assembly Hall	Bloomington, Indiana	setlistfm:bd6294e	2016-06-28 11:09:03-04	2016-06-28 15:09:02.73281-04
351	\N	41.9294736000000015	-88.7503647000000058	Chick Evans Field House	DeKalb, Illinois	setlistfm:5bd6d724	2016-06-28 11:09:03-04	2016-06-28 15:09:02.741255-04
352	\N	30.4507462000000011	-91.1545509999999979	LSU Assembly Center	Baton Rouge, Louisiana	setlistfm:5bd73ba4	2016-06-28 11:09:03-04	2016-06-28 15:09:02.768194-04
353	\N	32.7830555999999973	-96.8066666999999939	Moody Coliseum (SMU)	Dallas, Texas	setlistfm:3d6c9d3	2016-06-28 11:09:03-04	2016-06-28 15:09:02.775759-04
354	\N	29.7632836000000012	-95.3632714999999962	Hofheinz Pavilion	Houston, Texas	setlistfm:43d6c733	2016-06-28 11:09:03-04	2016-06-28 15:09:02.808859-04
355	\N	35.2225668000000027	-97.4394776999999976	Lloyd Noble Center	Norman, Oklahoma	setlistfm:7bd6c2ec	2016-06-28 11:09:03-04	2016-06-28 15:09:02.824316-04
356	\N	35.0840000000000032	-106.650999999999996	University Arena - University Of New Mexico	Albuquerque, New Mexico	setlistfm:4bd7cf3e	2016-06-28 11:09:03-04	2016-06-28 15:09:02.837286-04
357	\N	33.4147680000000022	-111.909309500000006	ASU Activity Center	Tempe, Arizona	setlistfm:53d633a5	2016-06-28 11:09:03-04	2016-06-28 15:09:02.844047-04
358	\N	45.5234515000000002	-122.676207099999999	Paramount Theatre	Portland, Oregon	setlistfm:7bd6c2dc	2016-06-28 11:09:03-04	2016-06-28 15:09:02.8535-04
359	\N	47.6062094999999985	-122.332070799999997	Paramount Theatre	Seattle, Washington	setlistfm:43d61ff3	2016-06-28 11:09:03-04	2016-06-28 15:09:02.867095-04
360	\N	40.2973319000000032	-74.3582040999999947	Raceway Park	Englishtown, New Jersey	setlistfm:13d6c9d5	2016-06-28 11:09:03-04	2016-06-28 15:09:02.881111-04
361	\N	33.9616801000000024	-118.353131099999999	The Forum	Inglewood, California	setlistfm:73d6366d	2016-06-28 11:09:03-04	2016-06-28 15:09:02.909056-04
362	\N	37.5537575000000032	-77.4602617000000038	The Mosque	Richmond, Virginia	setlistfm:4bd627a6	2016-06-28 11:09:03-04	2016-06-28 15:09:02.933335-04
363	\N	33.2098407000000009	-87.5691735000000051	Memorial Coliseum (U of Alabama)	Tuscaloosa, Alabama	setlistfm:1bd6c9c8	2016-06-28 11:09:03-04	2016-06-28 15:09:03.01219-04
364	\N	38.6272732999999988	-90.1978888999999953	St. Louis Arena	St. Louis, Missouri	setlistfm:43d63fef	2016-06-28 11:09:03-04	2016-06-28 15:09:03.02391-04
365	\N	41.8500330000000034	-87.6500522999999987	Auditorium Theatre	Chicago, Illinois	setlistfm:2bd620a2	2016-06-28 11:09:03-04	2016-06-28 15:09:03.033269-04
366	\N	40.7142691000000028	-74.0059729000000033	The Palladium	New York, New York	setlistfm:13d6c9cd	2016-06-28 11:09:03-04	2016-06-28 15:09:03.090953-04
367	\N	34.435829499999997	-119.827638899999997	Robertson Gym (UC Santa Barbara)	Goleta, California	setlistfm:3d6c9c3	2016-06-28 11:09:03-04	2016-06-28 15:09:03.219114-04
368	\N	37.7057657000000006	-122.461916599999995	Cow Palace	Daly City, California	setlistfm:6bd626d2	2016-06-28 11:09:03-04	2016-06-28 15:09:03.231729-04
369	\N	39.9611755000000031	-82.9987942000000061	Mershon Auditorium	Columbus, Ohio	setlistfm:6bd60a82	2016-06-28 11:09:03-04	2016-06-28 15:09:03.296007-04
370	\N	40.7281575000000018	-74.0776417000000009	Roosevelt Stadium	Jersey City, New Jersey	setlistfm:5bd62f88	2016-06-28 11:09:03-04	2016-06-28 15:09:03.379335-04
371	\N	41.7637111000000019	-72.6850931999999972	Colt Park	Hartford, Connecticut	setlistfm:7bd636f4	2016-06-28 11:09:03-04	2016-06-28 15:09:03.387399-04
372	\N	37.7749999999999986	-122.418999999999997	Orpheum Theatre	San Francisco, California	setlistfm:1bd6c9c4	2016-06-28 11:09:03-04	2016-06-28 15:09:03.395159-04
373	\N	39.9284458999999998	-75.2737955000000056	Tower Theatre	Upper Darby, Pennsylvania	setlistfm:5bd63b70	2016-06-28 11:09:03-04	2016-06-28 15:09:03.469251-04
374	\N	40.7142691000000028	-74.0059729000000033	Beacon Theatre	New York, New York	setlistfm:bd6c9ba	2016-06-28 11:09:04-04	2016-06-28 15:09:03.519039-04
375	\N	37.7749999999999986	-122.418999999999997	Great American Music Hall	San Francisco, California	setlistfm:4bd4c71e	2016-06-28 11:09:04-04	2016-06-28 15:09:03.612676-04
376	\N	37.7749999999999986	-122.418999999999997	Kezar Stadium	San Francisco, California	setlistfm:23d62cab	2016-06-28 11:09:04-04	2016-06-28 15:09:03.626008-04
377	\N	48.8534099999999967	2.34880000000000022	Palais des Sports	Paris, Île-de-France	setlistfm:23d62c9b	2016-06-28 11:09:04-04	2016-06-28 15:09:03.671462-04
378	\N	47.316666699999999	5.01666670000000003	Parc des Expositions	Dijon, Bourgogne	setlistfm:4bd4a3f6	2016-06-28 11:09:04-04	2016-06-28 15:09:03.687492-04
379	\N	51.5084152563930999	-0.125532746315001997	Alexandra Palace	London, England	setlistfm:43d62fbb	2016-06-28 11:09:04-04	2016-06-28 15:09:03.761782-04
380	\N	41.7637111000000019	-72.6850931999999972	Dillon Stadium	Hartford, Connecticut	setlistfm:2bd62cfa	2016-06-28 11:09:04-04	2016-06-28 15:09:03.808157-04
381	\N	41.8500330000000034	-87.6500522999999987	International Amphitheater	Chicago, Illinois	setlistfm:3d6c99f	2016-06-28 11:09:04-04	2016-06-28 15:09:03.830975-04
382	\N	34.0983425000000011	-118.326743399999998	Hollywood Bowl	Hollywood, California	setlistfm:33d62cf9	2016-06-28 11:09:04-04	2016-06-28 15:09:03.838926-04
383	\N	41.6005448000000015	-93.6091064000000017	State Fairgrounds	Des Moines, Iowa	setlistfm:13d6c1b5	2016-06-28 11:09:04-04	2016-06-28 15:09:03.906387-04
384	\N	47.6062094999999985	-122.332070799999997	Edmundson Pavilion (U of Washington)	Seattle, Washington	setlistfm:1bd6c9b0	2016-06-28 11:09:04-04	2016-06-28 15:09:03.965114-04
385	\N	49.2496573929999997	-123.119340402999995	Pacific Coliseum	Vancouver, British Columbia	setlistfm:53d6c705	2016-06-28 11:09:04-04	2016-06-28 15:09:03.982925-04
386	\N	46.8721460000000008	-113.993998199999993	Adams Field House	Missoula, Montana	setlistfm:3bd63088	2016-06-28 11:09:04-04	2016-06-28 15:09:03.991458-04
387	\N	39.5296329000000028	-119.813802699999997	University of Nevada	Reno, Nevada	setlistfm:13d6c9b5	2016-06-28 11:09:04-04	2016-06-28 15:09:03.998561-04
388	\N	39.1620035999999985	-84.4568862999999936	Cincinnati Gardens	Cincinnati, Ohio	setlistfm:bd6c11e	2016-06-28 11:09:04-04	2016-06-28 15:09:04.085152-04
389	\N	33.4147680000000022	-111.909309500000006	Feyline Field	Tempe, Arizona	setlistfm:3d6c9af	2016-06-28 11:09:04-04	2016-06-28 15:09:04.155392-04
390	\N	31.7587198000000015	-106.486931400000003	El Paso County Coliseum	El Paso, Texas	setlistfm:3d6250f	2016-06-28 11:09:04-04	2016-06-28 15:09:04.161991-04
391	\N	39.7391536000000016	-104.984703400000001	Denver Coliseum	Denver, Colorado	setlistfm:73d62a49	2016-06-28 11:09:04-04	2016-06-28 15:09:04.171643-04
392	\N	42.0411414000000008	-87.6900586999999945	McGaw Memorial Hall	Evanston, Illinois	setlistfm:1bd6c9ac	2016-06-28 11:09:04-04	2016-06-28 15:09:04.227904-04
393	\N	39.7683765000000022	-86.1580423000000053	State Fair Coliseum	Indianapolis, Indiana	setlistfm:3d6c9a3	2016-06-28 11:09:04-04	2016-06-28 15:09:04.24792-04
394	\N	35.4675602000000012	-97.5164276000000001	Fairgrounds Arena	Oklahoma City, Oklahoma	setlistfm:43d61f3f	2016-06-28 11:09:04-04	2016-06-28 15:09:04.279741-04
395	\N	42.3806287000000026	-76.8732921000000005	Grand Prix Racecourse	Watkins Glen, New York	setlistfm:3d6c9a7	2016-06-28 11:09:04-04	2016-06-28 15:09:04.412691-04
396	\N	34.1388961999999978	-118.353411500000007	Universal Amphitheatre	Universal City, California	setlistfm:bd6c9a6	2016-06-28 11:09:04-04	2016-06-28 15:09:04.425081-04
397	\N	47.6062094999999985	-122.332070799999997	Seattle Center Arena	Seattle, Washington	setlistfm:33d6d415	2016-06-28 11:09:04-04	2016-06-28 15:09:04.446444-04
398	\N	40.8000011000000029	-96.6669598999999948	Pershing Center	Lincoln, Nebraska	setlistfm:3bd6c450	2016-06-28 11:09:05-04	2016-06-28 15:09:04.649493-04
399	\N	44.9444100999999989	-93.0932741999999962	St. Paul Auditorium	St. Paul, Minnesota	setlistfm:7bd64e98	2016-06-28 11:09:05-04	2016-06-28 15:09:04.719013-04
400	\N	37.4241060000000019	-122.166075599999999	Maples Pavilion, Stanford University	Stanford, California	setlistfm:73d7ee1d	2016-06-28 11:09:05-04	2016-06-28 15:09:04.73692-04
401	\N	29.4241218999999994	-98.4936282000000034	Civic Auditorium	San Antonio, Texas	setlistfm:3d6192f	2016-06-28 11:09:05-04	2016-06-28 15:09:04.783794-04
402	\N	32.7830555999999973	-96.8066666999999939	Memorial Auditorium	Dallas, Texas	setlistfm:7bd62eec	2016-06-28 11:09:05-04	2016-06-28 15:09:04.795896-04
403	\N	30.2671530000000004	-97.743060799999995	Municipal Auditorium	Austin, Texas	setlistfm:1bd6c99c	2016-06-28 11:09:05-04	2016-06-28 15:09:04.803321-04
404	\N	37.6922361000000024	-97.3375448000000034	Century II	Wichita, Kansas	setlistfm:2bd630b2	2016-06-28 11:09:05-04	2016-06-28 15:09:04.828676-04
405	\N	35.4675602000000012	-97.5164276000000001	Civic Center Music Hall	Oklahoma City, Oklahoma	setlistfm:73d626b5	2016-06-28 11:09:05-04	2016-06-28 15:09:04.837372-04
406	\N	42.3314269999999979	-83.0457538	Ford Auditorium	Detroit, Michigan	setlistfm:13d6c991	2016-06-28 11:09:05-04	2016-06-28 15:09:04.85934-04
407	\N	39.1620035999999985	-84.4568862999999936	Cincinnati Music Hall	Cincinnati, Ohio	setlistfm:23d6c0c3	2016-06-28 11:09:05-04	2016-06-28 15:09:04.921508-04
408	\N	43.038902499999999	-87.9064735999999982	Performing Arts Center	Milwaukee, Wisconsin	setlistfm:3d6c997	2016-06-28 11:09:05-04	2016-06-28 15:09:04.929901-04
409	\N	36.1658899000000034	-86.7844431999999983	Alumni Lawn, Vanderbilt University	Nashville, Tennessee	setlistfm:6bd5aae6	2016-06-28 11:09:05-04	2016-06-28 15:09:04.950786-04
410	\N	38.6272732999999988	-90.1978888999999953	The Fabulous Fox Theatre	St. Louis, Missouri	setlistfm:1bd63540	2016-06-28 11:09:05-04	2016-06-28 15:09:04.958788-04
411	\N	38.8950000000000031	-77.0360000000000014	American University	Washington, Washington, D.C.	setlistfm:53d62751	2016-06-28 11:09:05-04	2016-06-28 15:09:05.002498-04
412	\N	40.7281575000000018	-74.0776417000000009	Stanley Theatre	Jersey City, New Jersey	setlistfm:1bd6c994	2016-06-28 11:09:05-04	2016-06-28 15:09:05.010155-04
413	\N	41.5581524999999985	-73.051496599999993	The Palace Theater	Waterbury, Connecticut	setlistfm:3d6c98b	2016-06-28 11:09:05-04	2016-06-28 15:09:05.036327-04
414	\N	34.0983425000000011	-118.326743399999998	Hollywood Palladium	Hollywood, California	setlistfm:73d63a75	2016-06-28 11:09:05-04	2016-06-28 15:09:05.138754-04
415	\N	44.0487341999999984	-123.350929399999998	Old Renaissance Faire Grounds	Veneta, Oregon	setlistfm:2bd62c06	2016-06-28 11:09:05-04	2016-06-28 15:09:05.164363-04
416	\N	37.3393857000000011	-121.894955499999995	San Jose Civic Auditorium	San Jose, California	setlistfm:3d631cf	2016-06-28 11:09:05-04	2016-06-28 15:09:05.197854-04
417	\N	51.5084152563930999	-0.125532746315001997	Lyceum Theatre	London, England	setlistfm:4bd72be2	2016-06-28 11:09:05-04	2016-06-28 15:09:05.274899-04
418	\N	48.137432549810903	11.5754914283751997	Deutsches Museum	Munich, Bavaria	setlistfm:63d6468f	2016-06-28 11:09:05-04	2016-06-28 15:09:05.358247-04
419	\N	49.6116667000000007	6.12999999999999989	Radio Luxembourg	Luxembourg, Luxembourg	setlistfm:bd6192e	2016-06-28 11:09:05-04	2016-06-28 15:09:05.366305-04
420	\N	50.6333332999999968	3.06666669999999986	Citadelle de Lille	Lille, Nord-Pas-de-Calais	setlistfm:53d4a311	2016-06-28 11:09:05-04	2016-06-28 15:09:05.375235-04
421	\N	51.9224999999999994	4.47916700000000034	De Doelen	Rotterdam, South Holland	setlistfm:5bd62b54	2016-06-28 11:09:05-04	2016-06-28 15:09:05.384754-04
422	\N	52.3729999999999976	4.90000000000000036	Concertgebouw	Amsterdam, North Holland	setlistfm:7bd6c65c	2016-06-28 11:09:05-04	2016-06-28 15:09:05.394334-04
423	\N	53.5333333000000025	-2.61666670000000012	Bickershaw Festival	Wigan, England	setlistfm:3bd62cfc	2016-06-28 11:09:05-04	2016-06-28 15:09:05.405344-04
424	\N	48.8534099999999967	2.34880000000000022	L'Olympia Bruno Coquatrix	Paris, Île-de-France	setlistfm:43d6cf8f	2016-06-28 11:09:05-04	2016-06-28 15:09:05.417126-04
425	\N	53.5499999999999972	10	Musikhalle	Hamburg, Hamburg	setlistfm:63d62e73	2016-06-28 11:09:05-04	2016-06-28 15:09:05.436665-04
426	\N	50.1166667000000032	8.68333329999999926	Jahrhunderthalle	Frankfurt, Hesse	setlistfm:3bd638fc	2016-06-28 11:09:05-04	2016-06-28 15:09:05.443834-04
427	\N	51.2217225723832001	6.7761611938476598	Rheinhalle	Düsseldorf, North Rhine-Westphalia	setlistfm:43d62fc3	2016-06-28 11:09:05-04	2016-06-28 15:09:05.453495-04
428	\N	53.0751556794029966	8.80777359008789062	Beat Club	Bremen, Bremen	setlistfm:33d62cf1	2016-06-28 11:09:05-04	2016-06-28 15:09:05.461794-04
429	\N	55.6776812020993006	12.5709342956543004	Tivoli	Copenhagen, Capital Region	setlistfm:3bd6c848	2016-06-28 11:09:05-04	2016-06-28 15:09:05.466287-04
430	\N	56.1567365813134032	10.2107620239258008	Aarhus University	Aarhus, Central Jutland	setlistfm:23d62cf7	2016-06-28 11:09:05-04	2016-06-28 15:09:05.473395-04
431	\N	54.972999999999999	-1.6140000000000001	Newcastle City Hall	Newcastle, England	setlistfm:73d6cec5	2016-06-28 11:09:05-04	2016-06-28 15:09:05.491533-04
432	\N	51.5084152563930999	-0.125532746315001997	Wembley Empire Pool	London, England	setlistfm:73d62e65	2016-06-28 11:09:06-04	2016-06-28 15:09:05.500546-04
433	\N	40.7142691000000028	-74.0059729000000033	Academy of Music	New York, New York	setlistfm:23d6d4fb	2016-06-28 11:09:06-04	2016-06-28 15:09:05.547589-04
434	\N	42.2775627973979979	-83.7408828735351989	Hill Auditorium	Ann Arbor, Michigan	setlistfm:63d6ca37	2016-06-28 11:09:06-04	2016-06-28 15:09:05.629224-04
435	\N	40.7142691000000028	-74.0059729000000033	Felt Forum	New York, New York	setlistfm:2bd62866	2016-06-28 11:09:06-04	2016-06-28 15:09:05.662477-04
436	\N	35.0840000000000032	-106.650999999999996	Civic Auditorium	Albuquerque, New Mexico	setlistfm:7bd726e4	2016-06-28 11:09:06-04	2016-06-28 15:09:05.755781-04
437	\N	32.7254089999999991	-97.3208496000000025	Texas Christian University	Fort Worth, Texas	setlistfm:53d70b31	2016-06-28 11:09:06-04	2016-06-28 15:09:05.771629-04
438	\N	33.7489953999999983	-84.3879823999999985	Municipal Auditorium	Atlanta, Georgia	setlistfm:3d60953	2016-06-28 11:09:06-04	2016-06-28 15:09:05.78421-04
439	\N	37.7749999999999986	-122.418999999999997	Harding Theater	San Francisco, California	setlistfm:4bd70b46	2016-06-28 11:09:06-04	2016-06-28 15:09:05.790718-04
440	\N	39.9611755000000031	-82.9987942000000061	Ohio Theatre	Columbus, Ohio	setlistfm:53d667f5	2016-06-28 11:09:06-04	2016-06-28 15:09:05.808281-04
441	\N	39.1620035999999985	-84.4568862999999936	Taft Theatre	Cincinnati, Ohio	setlistfm:1bd61d50	2016-06-28 11:09:06-04	2016-06-28 15:09:05.813792-04
442	\N	41.4994954000000007	-81.6954087999999956	Allen Theater	Cleveland, Ohio	setlistfm:4bd6db2e	2016-06-28 11:09:06-04	2016-06-28 15:09:05.82247-04
443	\N	43.1547844999999981	-77.6155567999999931	Palestra	Rochester, New York	setlistfm:43d627cf	2016-06-28 11:09:06-04	2016-06-28 15:09:05.838074-04
444	\N	42.3314269999999979	-83.0457538	Eastown Theatre	Detroit, Michigan	setlistfm:5bd7e72c	2016-06-28 11:09:06-04	2016-06-28 15:09:05.849674-04
445	\N	44.9799653999999975	-93.263836100000006	Northrop Auditorium	Minneapolis, Minnesota	setlistfm:5bd6c3f4	2016-06-28 11:09:06-04	2016-06-28 15:09:05.880094-04
446	\N	43.2103473000000022	-75.4323961000000054	Gaelic Park	Riverdale, New York	setlistfm:23d6d4e3	2016-06-28 11:09:06-04	2016-06-28 15:09:05.889746-04
447	\N	37.6054922000000005	-122.473863699999995	Terminal Island Federal Prison	San Pedro, California	setlistfm:3bd4f8d0	2016-06-28 11:09:06-04	2016-06-28 15:09:05.97404-04
448	\N	41.3081527000000008	-72.9281577999999939	Yale Bowl	New Haven, Connecticut	setlistfm:6bd62eea	2016-06-28 11:09:06-04	2016-06-28 15:09:05.981387-04
449	\N	37.7749999999999986	-122.418999999999997	Fillmore West	San Francisco, California	setlistfm:13d71555	2016-06-28 11:09:06-04	2016-06-28 15:09:05.990142-04
450	\N	49.1000000000000014	2.13333329999999988	Château d'Hérouville	Hérouville, Île-de-France	setlistfm:bd4299e	2016-06-28 11:09:06-04	2016-06-28 15:09:05.997854-04
451	\N	40.7142691000000028	-74.0059729000000033	Fillmore East	New York, New York	setlistfm:4bd6cbda	2016-06-28 11:09:06-04	2016-06-28 15:09:06.016882-04
452	\N	35.9940329000000006	-78.8986189999999965	Wallace Wade Stadium	Durham, North Carolina	setlistfm:5bd617b0	2016-06-28 11:09:06-04	2016-06-28 15:09:06.061577-04
453	\N	44.8011820999999983	-68.7778138000000041	Bangor Auditorium	Bangor, Maine	setlistfm:7bd7a670	2016-06-28 11:09:06-04	2016-06-28 15:09:06.068627-04
454	\N	41.8239890999999986	-71.4128343000000001	Rhode Island Auditorium	Providence, Rhode Island	setlistfm:2bd600aa	2016-06-28 11:09:06-04	2016-06-28 15:09:06.116388-04
455	\N	42.6011813000000004	-76.1804843000000034	Alumni Arena SUNY Cortland	Cortland, New York	setlistfm:1bd7f5d8	2016-06-28 11:09:06-04	2016-06-28 15:09:06.124184-04
456	\N	40.3487180999999993	-74.6590472000000034	Dillon Gym	Princeton, New Jersey	setlistfm:7bd5a25c	2016-06-28 11:09:06-04	2016-06-28 15:09:06.129175-04
457	\N	40.0692665999999988	-75.9955030999999934	David Mead Field House	Meadville, Pennsylvania	setlistfm:bd5e5ca	2016-06-28 11:09:06-04	2016-06-28 15:09:06.137944-04
458	\N	40.9645293000000024	-76.8844100999999966	Bucknell University	Lewisburg, Pennsylvania	setlistfm:33d624ed	2016-06-28 11:09:06-04	2016-06-28 15:09:06.145031-04
459	\N	41.408968999999999	-75.6624122000000057	Catholic Youth Center	Scranton, Pennsylvania	setlistfm:4bd48762	2016-06-28 11:09:06-04	2016-06-28 15:09:06.153318-04
460	\N	40.0378754999999984	-76.305514400000007	Franklin and Marshall College	Lancaster, Pennsylvania	setlistfm:4bd6274a	2016-06-28 11:09:06-04	2016-06-28 15:09:06.167071-04
461	\N	40.7142691000000028	-74.0059729000000033	The Grand Ballroom at Manhattan Center	New York, New York	setlistfm:73d63e29	2016-06-28 11:09:06-04	2016-06-28 15:09:06.190403-04
462	\N	41.6611277000000015	-91.5301682999999997	University of Iowa Fieldhouse	Iowa City, Iowa	setlistfm:63d6ca7f	2016-06-28 11:09:06-04	2016-06-28 15:09:06.222737-04
463	\N	43.0730517000000006	-89.4012302000000005	University of Wisconsin	Madison, Wisconsin	setlistfm:3d6216f	2016-06-28 11:09:06-04	2016-06-28 15:09:06.238548-04
464	\N	42.7369792000000004	-84.4838653999999991	Jenison Fieldhouse, Michigan State University	East Lansing, Michigan	setlistfm:5bd7e75c	2016-06-28 11:09:06-04	2016-06-28 15:09:06.24408-04
465	\N	41.0017642999999978	-73.665683400000006	Capitol Theatre	Port Chester, New York	setlistfm:73d61ea1	2016-06-28 11:09:06-04	2016-06-28 15:09:06.293562-04
466	\N	44.0520690999999971	-123.086753599999994	Lane Community College	Eugene, Oregon	setlistfm:33d70899	2016-06-28 11:09:06-04	2016-06-28 15:09:06.355014-04
467	\N	38.5449065000000033	-121.740516700000001	Freeborn Hall	Davis, California	setlistfm:53d63b35	2016-06-28 11:09:06-04	2016-06-28 15:09:06.361695-04
468	\N	34.0686206999999968	-118.027566699999994	Legion Stadium	El Monte, California	setlistfm:2bd7089a	2016-06-28 11:09:06-04	2016-06-28 15:09:06.374348-04
469	\N	38.4404674999999969	-122.714431399999995	Sonoma County Fairgrounds	Santa Rosa, California	setlistfm:43d74373	2016-06-28 11:09:06-04	2016-06-28 15:09:06.403894-04
470	\N	39.9611755000000031	-82.9987942000000061	Club Agora	Columbus, Ohio	setlistfm:3bd708a4	2016-06-28 11:09:06-04	2016-06-28 15:09:06.412847-04
471	\N	41.8500330000000034	-87.6500522999999987	The Syndrome	Chicago, Illinois	setlistfm:33d46029	2016-06-28 11:09:06-04	2016-06-28 15:09:06.446036-04
472	\N	40.7142691000000028	-74.0059729000000033	Anderson Theater	New York, New York	setlistfm:3d7d5cb	2016-06-28 11:09:06-04	2016-06-28 15:09:06.450574-04
473	\N	42.3584308000000007	-71.0597731999999951	Boston University	Boston, Massachusetts	setlistfm:53d67f95	2016-06-28 11:09:06-04	2016-06-28 15:09:06.456905-04
474	\N	42.3584308000000007	-71.0597731999999951	WBCN Radio	Boston, Massachusetts	setlistfm:7bd6d2c0	2016-06-28 11:09:06-04	2016-06-28 15:09:06.458892-04
475	\N	40.6499999999999986	-73.9500000000000028	46th St. Rock Palace	Brooklyn, New York	setlistfm:2bd708a6	2016-06-28 11:09:06-04	2016-06-28 15:09:06.473974-04
476	\N	40.6042704999999984	-73.6554078000000061	Action House	Island Park, New York	setlistfm:33d708a1	2016-06-28 11:09:06-04	2016-06-28 15:09:06.482754-04
477	\N	40.9256537999999992	-73.1409429999999929	SUNY Stony Brook Gymnasium	Stony Brook, New York	setlistfm:3bd60874	2016-06-28 11:09:07-04	2016-06-28 15:09:06.522487-04
478	\N	38.6272732999999988	-90.1978888999999953	Kiel Opera House	St. Louis, Missouri	setlistfm:73d626b9	2016-06-28 11:09:07-04	2016-06-28 15:09:06.569342-04
479	\N	38.8950000000000031	-77.0360000000000014	McDonough Arena, Georgetown University	Washington, Washington, D.C.	setlistfm:4bd707ea	2016-06-28 11:09:07-04	2016-06-28 15:09:06.574126-04
480	\N	39.9523349999999979	-75.1637889999999942	Irvine Auditorium	Philadelphia, Pennsylvania	setlistfm:43d627d3	2016-06-28 11:09:07-04	2016-06-28 15:09:06.587988-04
481	\N	40.9253763000000035	-74.2765368000000024	William Paterson University	Wayne, New Jersey	setlistfm:6bd73e42	2016-06-28 11:09:07-04	2016-06-28 15:09:06.592027-04
482	\N	40.7653796000000028	-73.8173563999999942	The Colden Auditorium, Queens College	Flushing, New York	setlistfm:bd7a59a	2016-06-28 11:09:07-04	2016-06-28 15:09:06.597254-04
483	\N	40.760779399999997	-111.891047400000005	Terrace Ballroom	Salt Lake City, Utah	setlistfm:7bd602b0	2016-06-28 11:09:07-04	2016-06-28 15:09:06.608572-04
484	\N	34.1477848999999978	-118.144515499999997	Pasadena Civic Auditorium	Pasadena, California	setlistfm:2bd6d002	2016-06-28 11:09:07-04	2016-06-28 15:09:06.613304-04
485	\N	37.7749999999999986	-122.418999999999997	KQED Studios	San Francisco, California	setlistfm:43d64fc3	2016-06-28 11:09:07-04	2016-06-28 15:09:06.677437-04
486	\N	32.7153291999999993	-117.1572551	Community Concourse Theatre	San Diego, California	setlistfm:1bd60948	2016-06-28 11:09:07-04	2016-06-28 15:09:06.731911-04
487	\N	37.7749999999999986	-122.418999999999997	The Matrix	San Francisco, California	setlistfm:6bd6d212	2016-06-28 11:09:07-04	2016-06-28 15:09:06.738315-04
488	\N	37.9735346000000007	-122.531087400000004	Euphoria Ballroom	San Rafael, California	setlistfm:3bd70814	2016-06-28 11:09:07-04	2016-06-28 15:09:06.741089-04
489	\N	49.8843986239999992	-97.1470447150000069	Winnipeg Stadium	Winnipeg, Manitoba	setlistfm:2bd62036	2016-06-28 11:09:07-04	2016-06-28 15:09:06.789561-04
490	\N	37.8715925999999996	-122.272746999999995	Pauley Ballroom	Berkeley, California	setlistfm:73d74ee9	2016-06-28 11:09:07-04	2016-06-28 15:09:06.801832-04
491	\N	21.306944399999999	-157.858333299999998	Civic Auditorium	Honolulu, Hawaii	setlistfm:5bd72714	2016-06-28 11:09:07-04	2016-06-28 15:09:06.833392-04
492	\N	53	-2.23333329999999997	Lower Finney Green Farm	Newcastle-under-Lyme, England	setlistfm:23d70817	2016-06-28 11:09:07-04	2016-06-28 15:09:06.863057-04
493	\N	39.9523349999999979	-75.1637889999999942	Temple University	Philadelphia, Pennsylvania	setlistfm:33d62411	2016-06-28 11:09:07-04	2016-06-28 15:09:06.868015-04
494	\N	38.5833861999999996	-90.4067849999999993	Merramec Community College	Kirkwood, Missouri	setlistfm:23d70813	2016-06-28 11:09:07-04	2016-06-28 15:09:06.886647-04
495	\N	33.7489953999999983	-84.3879823999999985	Sports Arena	Atlanta, Georgia	setlistfm:53d71789	2016-06-28 11:09:07-04	2016-06-28 15:09:06.895158-04
496	\N	42.2625931999999978	-71.8022933999999964	Worcester Polytechnic Institute	Worcester, Massachusetts	setlistfm:5bd6c3dc	2016-06-28 11:09:07-04	2016-06-28 15:09:06.899736-04
497	\N	42.2781401000000017	-74.9159946000000048	SUNY Delhi	Delhi, New York	setlistfm:33d734cd	2016-06-28 11:09:07-04	2016-06-28 15:09:06.90369-04
498	\N	42.3750969999999967	-71.1056078999999954	MIT East Campus Courtyard	Cambridge, Massachusetts	setlistfm:3bd66414	2016-06-28 11:09:07-04	2016-06-28 15:09:06.907367-04
499	\N	42.3750969999999967	-71.1056078999999954	Kresge Auditorium, M.I.T.	Cambridge, Massachusetts	setlistfm:6bd5aae2	2016-06-28 11:09:07-04	2016-06-28 15:09:06.917391-04
500	\N	41.5623209000000031	-72.650648799999999	Wesleyan University	Middletown, Connecticut	setlistfm:bd6696a	2016-06-28 11:09:07-04	2016-06-28 15:09:06.922186-04
501	\N	42.0986867000000018	-75.9179737999999986	Harpur College	Binghamton, New York	setlistfm:33d70831	2016-06-28 11:09:07-04	2016-06-28 15:09:06.926508-04
502	\N	42.2542365999999987	-77.7905508999999995	SAC Gym, Alfred State College	Alfred, New York	setlistfm:2bd5ec4e	2016-06-28 11:09:07-04	2016-06-28 15:09:06.937053-04
503	\N	39.7391536000000016	-104.984703400000001	Mammoth Gardens	Denver, Colorado	setlistfm:43d6cb0b	2016-06-28 11:09:07-04	2016-06-28 15:09:06.967883-04
504	\N	37.7749999999999986	-122.418999999999997	Family Dog	San Francisco, California	setlistfm:63d6d21b	2016-06-28 11:09:07-04	2016-06-28 15:09:06.973284-04
505	\N	39.1620035999999985	-84.4568862999999936	Armory Fieldhouse, University of Cincinnati	Cincinnati, Ohio	setlistfm:1bd405d0	2016-06-28 11:09:07-04	2016-06-28 15:09:07.025312-04
506	\N	26.0523109999999996	-80.143934299999998	Pirates World	Dania Beach, Florida	setlistfm:73d736b9	2016-06-28 11:09:07-04	2016-06-28 15:09:07.033342-04
507	\N	42.8864468000000016	-78.8783688999999981	Kleinhans Music Hall	Buffalo, New York	setlistfm:7bd61654	2016-06-28 11:09:07-04	2016-06-28 15:09:07.06229-04
508	\N	33.4483771000000019	-112.074037300000001	Star Theatre	Phoenix, Arizona	setlistfm:4bd48332	2016-06-28 11:09:07-04	2016-06-28 15:09:07.064847-04
509	\N	34.0194542999999996	-118.491191200000003	Santa Monica Civic Auditorium	Santa Monica, California	setlistfm:1bd62d4c	2016-06-28 11:09:07-04	2016-06-28 15:09:07.070405-04
510	\N	40.7142691000000028	-74.0059729000000033	Ungano's	New York, New York	setlistfm:13d7d5dd	2016-06-28 11:09:07-04	2016-06-28 15:09:07.136047-04
511	\N	29.9549999999999983	-90.0750000000000028	The Warehouse	New Orleans, Louisiana	setlistfm:23d6cc67	2016-06-28 11:09:07-04	2016-06-28 15:09:07.171372-04
512	\N	45.5234515000000002	-122.676207099999999	Springer's Inn	Portland, Oregon	setlistfm:43d71b2b	2016-06-28 11:09:07-04	2016-06-28 15:09:07.220328-04
513	\N	44.5645658999999981	-123.262043500000004	Oregon State University	Corvallis, Oregon	setlistfm:6bd712ce	2016-06-28 11:09:07-04	2016-06-28 15:09:07.224253-04
514	\N	42.3584308000000007	-71.0597731999999951	Boston Tea Party	Boston, Massachusetts	setlistfm:53d6cbd9	2016-06-28 11:09:07-04	2016-06-28 15:09:07.258838-04
515	\N	25.4687224000000008	-80.4775568999999962	Homestead-Miami Speedway	Homestead, Florida	setlistfm:bd6c586	2016-06-28 11:09:07-04	2016-06-28 15:09:07.280415-04
516	\N	32.7830555999999973	-96.8066666999999939	McFarlin Auditorium	Dallas, Texas	setlistfm:bd631e6	2016-06-28 11:09:07-04	2016-06-28 15:09:07.286657-04
517	\N	34.0519999999999996	-118.244	Thelma Theater	Los Angeles, California	setlistfm:33d70ca9	2016-06-28 11:09:07-04	2016-06-28 15:09:07.356717-04
518	\N	38.5815719000000001	-121.494399599999994	California Exposition & State Fair	Sacramento, California	setlistfm:63d7cec3	2016-06-28 11:09:07-04	2016-06-28 15:09:07.397221-04
519	\N	38.0524208000000002	-122.2130236	Lanai Theater	Crockett, California	setlistfm:2bd70cb6	2016-06-28 11:09:07-04	2016-06-28 15:09:07.404076-04
520	\N	37.3393857000000011	-121.894955499999995	San Jose State University Student Union Ballroom	San Jose, California	setlistfm:bd63d36	2016-06-28 11:09:07-04	2016-06-28 15:09:07.434164-04
521	\N	40.7142691000000028	-74.0059729000000033	Cafe au Go-Go	New York, New York	setlistfm:33d70cb1	2016-06-28 11:09:07-04	2016-06-28 15:09:07.471994-04
522	\N	30.3029721000000016	-90.9720451000000025	International Speedway	Prairieville, Louisiana	setlistfm:23d70cb3	2016-06-28 11:09:07-04	2016-06-28 15:09:07.49455-04
523	\N	45.8640034000000014	-122.806492199999994	Pelletier Farm	Saint Helens, Oregon	setlistfm:6bd756fe	2016-06-28 11:09:08-04	2016-06-28 15:09:07.508867-04
524	\N	47.6062094999999985	-122.332070799999997	Aqua Theater	Seattle, Washington	setlistfm:3bd70cbc	2016-06-28 11:09:08-04	2016-06-28 15:09:07.514052-04
525	\N	41.9545366999999985	-73.6337376000000035	Max Yasgur's Farm	Bethel, New York	setlistfm:73d7a63d	2016-06-28 11:09:08-04	2016-06-28 15:09:07.521146-04
526	\N	40.7653796000000028	-73.8173563999999942	The Pavilion at Flushing Meadow Park	Flushing, New York	setlistfm:2bd7101e	2016-06-28 11:09:08-04	2016-06-28 15:09:07.531939-04
527	\N	40.7142691000000028	-74.0059729000000033	Playboy Studios	New York, New York	setlistfm:23d70cbf	2016-06-28 11:09:08-04	2016-06-28 15:09:07.567307-04
528	\N	33.7489953999999983	-84.3879823999999985	Piedmont Park	Atlanta, Georgia	setlistfm:53d627f5	2016-06-28 11:09:08-04	2016-06-28 15:09:07.569565-04
529	\N	41.8500330000000034	-87.6500522999999987	Kinetic Playground	Chicago, Illinois	setlistfm:53d6cbf9	2016-06-28 11:09:08-04	2016-06-28 15:09:07.573045-04
530	\N	38.833881599999998	-104.821363399999996	Reed' Ranch	Colorado Springs, Colorado	setlistfm:6bd7560e	2016-06-28 11:09:08-04	2016-06-28 15:09:07.58284-04
531	\N	38.4404674999999969	-122.714431399999995	Veterans' Memorial Auditorium	Santa Rosa, California	setlistfm:43d74707	2016-06-28 11:09:08-04	2016-06-28 15:09:07.587113-04
532	\N	40.7142691000000028	-74.0059729000000033	Central Park	New York, New York	setlistfm:53d61fa5	2016-06-28 11:09:08-04	2016-06-28 15:09:07.596922-04
533	\N	36.6002378000000022	-121.894676099999998	Monterey Performing Arts Center	Monterey, California	setlistfm:23d70cbb	2016-06-28 11:09:08-04	2016-06-28 15:09:07.608526-04
534	\N	36.7477271999999999	-119.772366099999999	William Saroyan Theatre	Fresno, California	setlistfm:7bd6c2f4	2016-06-28 11:09:08-04	2016-06-28 15:09:07.613625-04
535	\N	26.0206456999999993	-80.1839357000000064	Hollywood Seminole Indian Reservation	West Hollywood, Florida	setlistfm:4bd4833e	2016-06-28 11:09:08-04	2016-06-28 15:09:07.679821-04
536	\N	37.8349262999999993	-122.129687099999998	Campolindo High School	Moraga, California	setlistfm:63d7560f	2016-06-28 11:09:08-04	2016-06-28 15:09:07.687871-04
537	\N	32.7153291999999993	-117.1572551	Aztec Bowl	San Diego, California	setlistfm:2bd6c05a	2016-06-28 11:09:08-04	2016-06-28 15:09:07.690577-04
538	\N	34.1477848999999978	-118.144515499999997	Rose Palace	Pasadena, California	setlistfm:3bd75424	2016-06-28 11:09:08-04	2016-06-28 15:09:07.692221-04
539	\N	44.9799653999999975	-93.263836100000006	Labor Temple	Minneapolis, Minnesota	setlistfm:33d70c01	2016-06-28 11:09:08-04	2016-06-28 15:09:07.706061-04
540	\N	42.3584308000000007	-71.0597731999999951	The Ark	Boston, Massachusetts	setlistfm:5bd7c740	2016-06-28 11:09:08-04	2016-06-28 15:09:07.719928-04
541	\N	42.2625931999999978	-71.8022933999999964	Clark University	Worcester, Massachusetts	setlistfm:1bd6259c	2016-06-28 11:09:08-04	2016-06-28 15:09:07.738865-04
542	\N	40.4258686000000012	-86.9080655000000064	Memorial Union Ballrom	West Lafayette, Indiana	setlistfm:7bd75608	2016-06-28 11:09:08-04	2016-06-28 15:09:07.74326-04
543	\N	38.6272732999999988	-90.1978888999999953	Washington University	St. Louis, Missouri	setlistfm:63d6d213	2016-06-28 11:09:08-04	2016-06-28 15:09:07.771104-04
544	\N	41.2586095999999998	-95.9377920000000017	The Music Box	Omaha, Nebraska	setlistfm:7bd60e60	2016-06-28 11:09:08-04	2016-06-28 15:09:07.778246-04
545	\N	40.0149856000000028	-105.270545600000005	University of Colorado	Boulder, Colorado	setlistfm:63d6c2df	2016-06-28 11:09:08-04	2016-06-28 15:09:07.783136-04
546	\N	40.760779399999997	-111.891047400000005	Student Union Ballroom	Salt Lake City, Utah	setlistfm:73d75609	2016-06-28 11:09:08-04	2016-06-28 15:09:07.788219-04
547	\N	32.2217429000000024	-110.926479	University of Arizona	Tucson, Arizona	setlistfm:63d4aaf3	2016-06-28 11:09:08-04	2016-06-28 15:09:07.792454-04
548	\N	37.7749999999999986	-122.418999999999997	Avalon Ballroom	San Francisco, California	setlistfm:3bd62cc4	2016-06-28 11:09:08-04	2016-06-28 15:09:07.796367-04
549	\N	36.1749705000000006	-115.137223000000006	Ice Palace	Las Vegas, Nevada	setlistfm:3bd728b0	2016-06-28 11:09:08-04	2016-06-28 15:09:07.81536-04
550	\N	37.6390972000000019	-120.996878199999998	Student Centre	Modesto, California	setlistfm:6bd7560a	2016-06-28 11:09:08-04	2016-06-28 15:09:07.820837-04
551	\N	37.3021632999999966	-120.482967700000003	Merced County Fairgrounds	Merced, California	setlistfm:3d65d33	2016-06-28 11:09:08-04	2016-06-28 15:09:07.826176-04
552	\N	37.7749999999999986	-122.418999999999997	Hilton Hotel	San Francisco, California	setlistfm:43d7ab6b	2016-06-28 11:09:08-04	2016-06-28 15:09:07.832161-04
553	\N	38.1040863999999999	-122.256636700000001	The Dream Bowl	Vallejo, California	setlistfm:33d70c55	2016-06-28 11:09:08-04	2016-06-28 15:09:07.879057-04
554	\N	39.9523349999999979	-75.1637889999999942	Electric Factory	Philadelphia, Pennsylvania	setlistfm:43d61f23	2016-06-28 11:09:08-04	2016-06-28 15:09:07.890145-04
555	\N	39.1141707999999966	-94.6274570000000068	Soldiers & Sailors Auditorium	Kansas City, Kansas	setlistfm:53d48735	2016-06-28 11:09:08-04	2016-06-28 15:09:07.916127-04
556	\N	25.9812024999999984	-80.1483790000000056	Gulfstream Park	Hallandale Beach, Florida	setlistfm:3d7d90b	2016-06-28 11:09:08-04	2016-06-28 15:09:07.984425-04
557	\N	29.7632836000000012	-95.3632714999999962	Catacombs Club	Houston, Texas	setlistfm:6bd4beda	2016-06-28 11:09:08-04	2016-06-28 15:09:07.987798-04
558	\N	38.2542376000000033	-85.7594069999999959	Bellarmine University	Louisville, Kentucky	setlistfm:7bd65af0	2016-06-28 11:09:08-04	2016-06-28 15:09:07.996723-04
559	\N	39.1620035999999985	-84.4568862999999936	Hyde Park Teen Center	Cincinnati, Ohio	setlistfm:43d4833b	2016-06-28 11:09:08-04	2016-06-28 15:09:08.002032-04
560	\N	39.9611755000000031	-82.9987942000000061	Veterans Memorial Auditorium	Columbus, Ohio	setlistfm:5bd66338	2016-06-28 11:09:08-04	2016-06-28 15:09:08.023779-04
561	\N	39.7284944999999965	-121.837477699999994	Silver Dollar Fairgrounds	Chico, California	setlistfm:2bd73c96	2016-06-28 11:09:08-04	2016-06-28 15:09:08.029841-04
562	\N	32.959489099999999	-117.265314599999996	Del Mar Fairgrounds	Del Mar, California	setlistfm:2bd6ccba	2016-06-28 11:09:08-04	2016-06-28 15:09:08.05353-04
563	\N	47.8626013000000015	-121.816509499999995	Betty Nelson's Organic Raspberry Farm	Sultan, Washington	setlistfm:13d70d91	2016-06-28 11:09:08-04	2016-06-28 15:09:08.05944-04
564	\N	37.7749999999999986	-122.418999999999997	Carousel Ballroom	San Francisco, California	setlistfm:6bd7ea4e	2016-06-28 11:09:08-04	2016-06-28 15:09:08.115699-04
565	\N	38.2206101000000018	-90.3959542999999996	Festus National Guard Armory	Festus, Missouri	setlistfm:7bd49200	2016-06-28 11:09:08-04	2016-06-28 15:09:08.141231-04
566	\N	37.3393857000000011	-121.894955499999995	Santa Clara Fairgrounds	San Jose, California	setlistfm:6bd636b2	2016-06-28 11:09:08-04	2016-06-28 15:09:08.148104-04
567	\N	40.7142691000000028	-74.0059729000000033	Electric Circus	New York, New York	setlistfm:23d7e0bf	2016-06-28 11:09:08-04	2016-06-28 15:09:08.150514-04
568	\N	40.7142691000000028	-74.0059729000000033	Low Library Plaza	New York, New York	setlistfm:5bd48358	2016-06-28 11:09:08-04	2016-06-28 15:09:08.158321-04
569	\N	33.8352932000000024	-117.914503600000003	Melodyland	Anaheim, California	setlistfm:5bd747f0	2016-06-28 11:09:08-04	2016-06-28 15:09:08.191591-04
570	\N	37.7749999999999986	-122.418999999999997	Haight Street at Cole	San Francisco, California	setlistfm:1bd70d9c	2016-06-28 11:09:08-04	2016-06-28 15:09:08.239767-04
571	\N	39.1666700000000034	-120.143330000000006	Kings Beach	Lake Tahoe, California	setlistfm:3bd70cfc	2016-06-28 11:09:08-04	2016-06-28 15:09:08.24359-04
572	\N	45.5234515000000002	-122.676207099999999	Crystal Ballroom	Portland, Oregon	setlistfm:73d63659	2016-06-28 11:09:08-04	2016-06-28 15:09:08.2588-04
573	\N	44.0520690999999971	-123.086753599999994	EMU Ballroom	Eugene, Oregon	setlistfm:63d626b3	2016-06-28 11:09:08-04	2016-06-28 15:09:08.265413-04
574	\N	47.6062094999999985	-122.332070799999997	Eagles Auditorium	Seattle, Washington	setlistfm:23d6d4ef	2016-06-28 11:09:08-04	2016-06-28 15:09:08.267253-04
575	\N	40.8020712000000003	-124.163672899999995	Eureka Municipal Auditorum	Eureka, California	setlistfm:73d6063d	2016-06-28 11:09:08-04	2016-06-28 15:09:08.296394-04
576	\N	42.3584308000000007	-71.0597731999999951	Psychedelic Supermarket	Boston, Massachusetts	setlistfm:3d495f3	2016-06-28 11:09:08-04	2016-06-28 15:09:08.305689-04
577	\N	37.3541079999999965	-121.955235599999995	Continental Ballroom	Santa Clara, California	setlistfm:53d73f01	2016-06-28 11:09:08-04	2016-06-28 15:09:08.342733-04
578	\N	38.5210237000000006	-122.976942699999995	Dance Hall	Rio Nido, California	setlistfm:6bd7ea76	2016-06-28 11:09:08-04	2016-06-28 15:09:08.350226-04
579	\N	45.5088374999999985	-73.5878089999999929	Place Ville Marie	Montreal, Quebec	setlistfm:6bd4ba0e	2016-06-28 11:10:08-04	2016-06-28 15:10:08.382398-04
580	\N	43.700113788000003	-79.4163041940000056	O'Keefe Centre	Toronto, Ontario	setlistfm:63d6164b	2016-06-28 11:10:08-04	2016-06-28 15:10:08.386804-04
581	\N	37.4418834000000018	-122.143019499999994	El Camino Park	Palo Alto, California	setlistfm:5bd76fbc	2016-06-28 11:10:08-04	2016-06-28 15:10:08.393982-04
582	\N	36.6002378000000022	-121.894676099999998	Monterey County Fairground	Monterey, California	setlistfm:43d6cbfb	2016-06-28 11:10:08-04	2016-06-28 15:10:08.419928-04
583	\N	40.7142691000000028	-74.0059729000000033	Tompkins Square Park	New York, New York	setlistfm:13d62d79	2016-06-28 11:10:08-04	2016-06-28 15:10:08.432353-04
584	\N	32.6992188999999982	-117.112808599999994	Awalt High School	Mountain View, California	setlistfm:23d4808b	2016-06-28 11:10:08-04	2016-06-28 15:10:08.436052-04
585	\N	37.7749999999999986	-122.418999999999997	Fillmore Auditorium	San Francisco, California	setlistfm:bd4396e	2016-06-28 11:10:08-04	2016-06-28 15:10:08.4588-04
586	\N	49.2496573929999997	-123.119340402999995	Garden Auditorium	Vancouver, British Columbia	setlistfm:63d6360b	2016-06-28 11:10:09-04	2016-06-28 15:10:08.626987-04
587	\N	37.7749999999999986	-122.418999999999997	Longshoreman's Hall	San Francisco, California	setlistfm:43d7d35f	2016-06-28 11:10:09-04	2016-06-28 15:10:08.682123-04
588	\N	34.0519999999999996	-118.244	Trouper's Hall	Los Angeles, California	setlistfm:23d7f09b	2016-06-28 11:10:09-04	2016-06-28 15:10:08.687436-04
589	\N	34.0519999999999996	-118.244	Carthay Studios	Los Angeles, California	setlistfm:2bd480aa	2016-06-28 11:10:09-04	2016-06-28 15:10:08.691531-04
590	\N	34.0519999999999996	-118.244	Danish Hall	Los Angeles, California	setlistfm:13d70d9d	2016-06-28 11:10:09-04	2016-06-28 15:10:08.696933-04
591	\N	34.0519999999999996	-118.244	A.I.A.A. Hall	Los Angeles, California	setlistfm:23d480ab	2016-06-28 11:10:09-04	2016-06-28 15:10:08.701372-04
592	\N	34.0519999999999996	-118.244	Ivar Theater	Los Angeles, California	setlistfm:3bd480b4	2016-06-28 11:10:09-04	2016-06-28 15:10:08.709564-04
593	\N	37.4418834000000018	-122.143019499999994	Big Beat Club	Palo Alto, California	setlistfm:73d58e6d	2016-06-28 11:10:09-04	2016-06-28 15:10:08.753027-04
594	\N	37.9735346000000007	-122.531087400000004	Muir Beach Lodge	San Rafael, California	setlistfm:43d753bf	2016-06-28 11:10:09-04	2016-06-28 15:10:08.756242-04
595	\N	37.4538274000000015	-122.182187099999993	Magoo's Pizza	Menlo Park, California	setlistfm:4bd753c6	2016-06-28 11:10:09-04	2016-06-28 15:10:08.760574-04
\.


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('venues_id_seq', 595, true);


--
-- Data for Name: years; Type: TABLE DATA; Schema: public; Owner: alecgorge
--

COPY years (id, show_count, recording_count, duration, avg_duration, avg_rating, artist_id, year, created_at, updated_at) FROM stdin;
\.


--
-- Name: years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alecgorge
--

SELECT pg_catalog.setval('years_id_seq', 1, false);


--
-- Name: artists_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: eras_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY eras
    ADD CONSTRAINT eras_pkey PRIMARY KEY (id);


--
-- Name: featuresets_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY features
    ADD CONSTRAINT featuresets_pkey PRIMARY KEY (id);


--
-- Name: setlist_show_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_show_pkey PRIMARY KEY (id);


--
-- Name: setlist_show_upstream_identifier_key; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_show_upstream_identifier_key UNIQUE (upstream_identifier);


--
-- Name: setlist_song_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_songs
    ADD CONSTRAINT setlist_song_pkey PRIMARY KEY (id);


--
-- Name: shows_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows
    ADD CONSTRAINT shows_pkey PRIMARY KEY (id);


--
-- Name: source_review_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_reviews
    ADD CONSTRAINT source_review_pkey PRIMARY KEY (id);


--
-- Name: source_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_sets
    ADD CONSTRAINT source_sets_pkey PRIMARY KEY (id);


--
-- Name: source_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_tracks
    ADD CONSTRAINT source_tracks_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: sources_upstream_identifier_key; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_upstream_identifier_key UNIQUE (upstream_identifier);


--
-- Name: tours_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- Name: venues_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: years_pkey; Type: CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY years
    ADD CONSTRAINT years_pkey PRIMARY KEY (id);


--
-- Name: setlist_songs_artist_id_slug; Type: INDEX; Schema: public; Owner: alecgorge
--

CREATE UNIQUE INDEX setlist_songs_artist_id_slug ON setlist_songs USING btree (artist_id, slug);


--
-- Name: shows_artist_id_display_date_key; Type: INDEX; Schema: public; Owner: alecgorge
--

CREATE UNIQUE INDEX shows_artist_id_display_date_key ON shows USING btree (artist_id, display_date);


--
-- Name: tour_artist_id_tour_slug; Type: INDEX; Schema: public; Owner: alecgorge
--

CREATE UNIQUE INDEX tour_artist_id_tour_slug ON tours USING btree (artist_id, slug);


--
-- Name: venues_upstream_identifier_key; Type: INDEX; Schema: public; Owner: alecgorge
--

CREATE UNIQUE INDEX venues_upstream_identifier_key ON venues USING btree (artist_id, upstream_identifier);


--
-- Name: eras_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY eras
    ADD CONSTRAINT eras_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: featuresets_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY features
    ADD CONSTRAINT featuresets_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: setlist_show_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_show_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: setlist_show_venue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_show_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES venues(id) ON UPDATE CASCADE;


--
-- Name: setlist_shows_era_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_shows_era_id_fkey FOREIGN KEY (era_id) REFERENCES eras(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: setlist_shows_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_shows
    ADD CONSTRAINT setlist_shows_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES tours(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: setlist_song_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_songs
    ADD CONSTRAINT setlist_song_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: setlist_song_plays_played_setlist_show_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_songs_plays
    ADD CONSTRAINT setlist_song_plays_played_setlist_show_id_fkey FOREIGN KEY (played_setlist_show_id) REFERENCES setlist_shows(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: setlist_song_plays_played_setlist_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY setlist_songs_plays
    ADD CONSTRAINT setlist_song_plays_played_setlist_song_id_fkey FOREIGN KEY (played_setlist_song_id) REFERENCES setlist_songs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shows_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows
    ADD CONSTRAINT shows_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shows_era_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows
    ADD CONSTRAINT shows_era_id_fkey FOREIGN KEY (era_id) REFERENCES eras(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: shows_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows
    ADD CONSTRAINT shows_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES tours(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: shows_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY shows
    ADD CONSTRAINT shows_year_id_fkey FOREIGN KEY (year_id) REFERENCES years(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: source_review_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_reviews
    ADD CONSTRAINT source_review_source_id_fkey FOREIGN KEY (source_id) REFERENCES sources(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: source_sets_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_sets
    ADD CONSTRAINT source_sets_source_id_fkey FOREIGN KEY (source_id) REFERENCES sources(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: source_tracks_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_tracks
    ADD CONSTRAINT source_tracks_set_id_fkey FOREIGN KEY (source_set_id) REFERENCES source_sets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: source_tracks_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY source_tracks
    ADD CONSTRAINT source_tracks_source_id_fkey FOREIGN KEY (source_id) REFERENCES sources(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sources_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sources_show_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_show_id_fkey FOREIGN KEY (show_id) REFERENCES shows(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: tours_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY tours
    ADD CONSTRAINT tours_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: venues_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: years_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alecgorge
--

ALTER TABLE ONLY years
    ADD CONSTRAINT years_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: alecgorge
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM alecgorge;
GRANT ALL ON SCHEMA public TO alecgorge;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
