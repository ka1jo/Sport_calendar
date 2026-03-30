--
-- PostgreSQL database dump
--

\restrict D7iZqvazgGqGmijigKRgGUJuobOvkca96jS35POmA962k2dlaVjRhaox7daUKG1

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.1

-- Started on 2026-03-30 13:12:24

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 16471)
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    _tournament_id integer NOT NULL,
    home_team_id integer NOT NULL,
    away_team_id integer NOT NULL,
    _referee_id integer,
    start_time timestamp without time zone NOT NULL,
    venue character varying(150),
    score character varying(50)
);


ALTER TABLE public.event OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16470)
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_event_id_seq OWNER TO postgres;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 226
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_event_id_seq OWNED BY public.event.event_id;


--
-- TOC entry 228 (class 1259 OID 16502)
-- Name: event_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_result (
    event_id integer NOT NULL,
    team_id integer NOT NULL,
    score integer
);


ALTER TABLE public.event_result OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16519)
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    player_id integer NOT NULL,
    player_name character varying(100),
    "position" character varying(50),
    team_id integer
);


ALTER TABLE public.player OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16456)
-- Name: referee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referee (
    referee_id integer NOT NULL,
    referee_name character varying(150) CONSTRAINT referee_name_not_null NOT NULL,
    referee_country character varying(100),
    _sport_id integer NOT NULL
);


ALTER TABLE public.referee OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16455)
-- Name: referee_referee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referee_referee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referee_referee_id_seq OWNER TO postgres;

--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 224
-- Name: referee_referee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referee_referee_id_seq OWNED BY public.referee.referee_id;


--
-- TOC entry 221 (class 1259 OID 16420)
-- Name: sport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sport (
    sport_id integer NOT NULL,
    sport_name character varying(50) NOT NULL
);


ALTER TABLE public.sport OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16419)
-- Name: sport_sport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sport_sport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sport_sport_id_seq OWNER TO postgres;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 220
-- Name: sport_sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sport_sport_id_seq OWNED BY public.sport.sport_id;


--
-- TOC entry 223 (class 1259 OID 16434)
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    team_id bigint NOT NULL,
    team_name character varying(100) CONSTRAINT team_name_not_null NOT NULL,
    team_country character varying(50),
    _sport_id bigint,
    logo character varying(255),
    stadium character varying(255)
);


ALTER TABLE public.team OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: team_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_team_id_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 222
-- Name: team_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_team_id_seq OWNED BY public.team.team_id;


--
-- TOC entry 219 (class 1259 OID 16388)
-- Name: tournament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournament (
    tournament_id bigint CONSTRAINT users_id_not_null NOT NULL,
    tournament_name character varying(64) CONSTRAINT users_first_name_not_null NOT NULL,
    tournament_type character varying(64) CONSTRAINT users_last_name_not_null NOT NULL,
    tournament_country character varying(128) CONSTRAINT users_email_not_null NOT NULL,
    tournament_season character varying,
    _sport_id integer
);


ALTER TABLE public.tournament OWNER TO postgres;

--
-- TOC entry 4785 (class 2604 OID 16474)
-- Name: event event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN event_id SET DEFAULT nextval('public.event_event_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16459)
-- Name: referee referee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referee ALTER COLUMN referee_id SET DEFAULT nextval('public.referee_referee_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 16423)
-- Name: sport sport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sport ALTER COLUMN sport_id SET DEFAULT nextval('public.sport_sport_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16437)
-- Name: team team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);


--
-- TOC entry 4965 (class 0 OID 16471)
-- Dependencies: 227
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (event_id, _tournament_id, home_team_id, away_team_id, _referee_id, start_time, venue, score) FROM stdin;
2	2	3	4	2	2019-10-23 09:45:00	Klagenfurt Arena	3-2
3	1	2	1	1	2026-04-01 18:30:00	National Stadium	\N
1	1	1	2	1	2019-07-18 18:30:00	London Stadium	2-1
\.


--
-- TOC entry 4966 (class 0 OID 16502)
-- Dependencies: 228
-- Data for Name: event_result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_result (event_id, team_id, score) FROM stdin;
1	1	2
1	2	1
2	3	4
2	4	3
\.


--
-- TOC entry 4967 (class 0 OID 16519)
-- Dependencies: 229
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (player_id, player_name, "position", team_id) FROM stdin;
1	Jarrod Bowen	Forward	1
2	James Ward-Prowse	Midfielder	1
3	Declan Rice	Midfielder	1
4	Aaron Cresswell	Defender	1
5	Łukasz Fabiański	Goalkeeper	1
6	Michail Antonio	Forward	1
7	Matheus Cunha	Forward	2
8	José Sá	Goalkeeper	2
9	Rúben Neves	Midfielder	2
10	Conor Coady	Defender	2
11	Pedro Neto	Forward	2
12	João Moutinho	Midfielder	2
13	Thomas Koch	Center	3
14	Nick Petersen	Forward	3
15	Sebastian Osterloh	Defense	3
16	Stefan Ulmer	Defense	3
17	Martin Ulmer	Goalie	3
18	David Wurm	Forward	3
19	Peter Schneider	Forward	4
20	Sebastian Wraneschitz	Goalie	4
21	Alex Trivellato	Defense	4
22	Michael Schiechl	Center	4
23	Lukas Haudum	Forward	4
24	David Kickert	Defense	4
\.


--
-- TOC entry 4963 (class 0 OID 16456)
-- Dependencies: 225
-- Data for Name: referee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referee (referee_id, referee_name, referee_country, _sport_id) FROM stdin;
1	Mike Dean	England	1
2	John Doe	Austria	2
3	Jane Smith	Austria	2
\.


--
-- TOC entry 4959 (class 0 OID 16420)
-- Dependencies: 221
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sport (sport_id, sport_name) FROM stdin;
1	Football
2	Ice Hockey
\.


--
-- TOC entry 4961 (class 0 OID 16434)
-- Dependencies: 223
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (team_id, team_name, team_country, _sport_id, logo, stadium) FROM stdin;
1	West Ham United	England	1	logos/football/west_ham.png	London Stadium
2	Wolverhampton Wanderers	England	1	logos/football/wolverhampton.png	Molineux Stadium
3	KAC	Austria	2	logos/hockey/kac.png	KAC Arena
4	Vienna Capitals	Austria	2	logos/hockey/vienna_capitals.png	Erste Bank Arena
\.


--
-- TOC entry 4957 (class 0 OID 16388)
-- Dependencies: 219
-- Data for Name: tournament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tournament (tournament_id, tournament_name, tournament_type, tournament_country, tournament_season, _sport_id) FROM stdin;
2	Austrian Ice Hockey League	league	Austria	2025/2026	2
1	EPL	league	England	2025/2026	1
\.


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 226
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_event_id_seq', 3, true);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 224
-- Name: referee_referee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referee_referee_id_seq', 3, true);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 220
-- Name: sport_sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sport_sport_id_seq', 1, false);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 222
-- Name: team_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_team_id_seq', 4, true);


--
-- TOC entry 4795 (class 2606 OID 16481)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- TOC entry 4797 (class 2606 OID 16508)
-- Name: event_result event_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT event_result_pkey PRIMARY KEY (event_id, team_id);


--
-- TOC entry 4799 (class 2606 OID 16524)
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (player_id);


--
-- TOC entry 4793 (class 2606 OID 16464)
-- Name: referee referee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referee
    ADD CONSTRAINT referee_pkey PRIMARY KEY (referee_id);


--
-- TOC entry 4789 (class 2606 OID 16427)
-- Name: sport sport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_pkey PRIMARY KEY (sport_id);


--
-- TOC entry 4791 (class 2606 OID 16441)
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (team_id);


--
-- TOC entry 4787 (class 2606 OID 16396)
-- Name: tournament users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT users_pkey PRIMARY KEY (tournament_id);


--
-- TOC entry 4803 (class 2606 OID 16497)
-- Name: event event__referee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event__referee_id_fkey FOREIGN KEY (_referee_id) REFERENCES public.referee(referee_id);


--
-- TOC entry 4804 (class 2606 OID 16482)
-- Name: event event__tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event__tournament_id_fkey FOREIGN KEY (_tournament_id) REFERENCES public.tournament(tournament_id);


--
-- TOC entry 4805 (class 2606 OID 16492)
-- Name: event event_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.team(team_id);


--
-- TOC entry 4806 (class 2606 OID 16487)
-- Name: event event_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.team(team_id);


--
-- TOC entry 4807 (class 2606 OID 16509)
-- Name: event_result event_result_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT event_result_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(event_id);


--
-- TOC entry 4808 (class 2606 OID 16514)
-- Name: event_result event_result_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT event_result_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 4800 (class 2606 OID 16428)
-- Name: tournament fk_tournament_sport; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT fk_tournament_sport FOREIGN KEY (_sport_id) REFERENCES public.sport(sport_id);


--
-- TOC entry 4809 (class 2606 OID 16525)
-- Name: player player_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 4802 (class 2606 OID 16465)
-- Name: referee referee__sport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referee
    ADD CONSTRAINT referee__sport_id_fkey FOREIGN KEY (_sport_id) REFERENCES public.sport(sport_id);


--
-- TOC entry 4801 (class 2606 OID 16442)
-- Name: team team__sport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team__sport_id_fkey FOREIGN KEY (_sport_id) REFERENCES public.sport(sport_id);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE event; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.event TO test_user;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 226
-- Name: SEQUENCE event_event_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.event_event_id_seq TO test_user;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE event_result; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.event_result TO test_user;


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE player; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.player TO test_user;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE referee; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.referee TO test_user;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE sport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sport TO test_user;


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE team; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.team TO test_user;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE tournament; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tournament TO test_user;


-- Completed on 2026-03-30 13:12:24

--
-- PostgreSQL database dump complete
--

\unrestrict D7iZqvazgGqGmijigKRgGUJuobOvkca96jS35POmA962k2dlaVjRhaox7daUKG1

