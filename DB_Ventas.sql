--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


--
-- Name: fun_inventario_u_existencia(); Type: FUNCTION; Schema: public; Owner: tapw
--

CREATE FUNCTION public.fun_inventario_u_existencia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
            UPDATE inventario SET existencia = (existencia -1) WHERE id_producto = NEW.id_producto;
            RETURN NULL;
        END;
    $$;


ALTER FUNCTION public.fun_inventario_u_existencia() OWNER TO tapw;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: almacen; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.almacen (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE public.almacen OWNER TO tapw;

--
-- Name: alamcen_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.alamcen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alamcen_id_seq OWNER TO tapw;

--
-- Name: alamcen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.alamcen_id_seq OWNED BY public.almacen.id;


--
-- Name: app_users; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.app_users (
    id integer NOT NULL,
    username character varying,
    email character varying,
    password character varying,
    isactive boolean,
    id_empleado integer,
    id_rol integer
);


ALTER TABLE public.app_users OWNER TO tapw;

--
-- Name: app_users_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.app_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_users_id_seq OWNER TO tapw;

--
-- Name: app_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.app_users_id_seq OWNED BY public.app_users.id;


--
-- Name: bitacora; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.bitacora (
    id integer NOT NULL,
    email character varying,
    token character varying,
    fec_ini timestamp without time zone,
    fec_fin timestamp without time zone
);


ALTER TABLE public.bitacora OWNER TO tapw;

--
-- Name: bitacora_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.bitacora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitacora_id_seq OWNER TO tapw;

--
-- Name: bitacora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.bitacora_id_seq OWNED BY public.bitacora.id;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    nombre character varying,
    ape character varying
);


ALTER TABLE public.cliente OWNER TO tapw;

--
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_id_seq OWNER TO tapw;

--
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- Name: cliente_ruta; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.cliente_ruta (
    id_cliente integer,
    lat character varying,
    lon character varying,
    id_ruta integer,
    id_empleado integer
);


ALTER TABLE public.cliente_ruta OWNER TO tapw;

--
-- Name: empleado; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.empleado (
    id integer NOT NULL,
    nombre character varying,
    ape character varying
);


ALTER TABLE public.empleado OWNER TO tapw;

--
-- Name: empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.empleado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.empleado_id_seq OWNER TO tapw;

--
-- Name: empleado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.empleado_id_seq OWNED BY public.empleado.id;


--
-- Name: estatus; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.estatus (
    nombre character varying,
    id integer NOT NULL
);


ALTER TABLE public.estatus OWNER TO tapw;

--
-- Name: estatus_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.estatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estatus_id_seq OWNER TO tapw;

--
-- Name: estatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.estatus_id_seq OWNED BY public.estatus.id;


--
-- Name: id_device; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.id_device (
    id integer NOT NULL,
    token character varying
);


ALTER TABLE public.id_device OWNER TO tapw;

--
-- Name: id_device_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.id_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.id_device_id_seq OWNER TO tapw;

--
-- Name: id_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.id_device_id_seq OWNED BY public.id_device.id;


--
-- Name: inventario; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.inventario (
    id integer NOT NULL,
    id_almacen integer,
    id_producto integer,
    existencia integer,
    CONSTRAINT existencia_chk1 CHECK ((existencia >= 0))
);


ALTER TABLE public.inventario OWNER TO tapw;

--
-- Name: inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.inventario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventario_id_seq OWNER TO tapw;

--
-- Name: inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.inventario_id_seq OWNED BY public.inventario.id;


--
-- Name: pedido; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.pedido (
    id integer NOT NULL,
    id_empleado integer,
    id_producto integer,
    id_cliente integer,
    fecha timestamp without time zone,
    fecha_entrega date,
    id_estatus integer
);


ALTER TABLE public.pedido OWNER TO tapw;

--
-- Name: pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pedido_id_seq OWNER TO tapw;

--
-- Name: pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.pedido_id_seq OWNED BY public.pedido.id;


--
-- Name: producto; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.producto (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE public.producto OWNER TO tapw;

--
-- Name: producto_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.producto_id_seq OWNER TO tapw;

--
-- Name: producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.rol (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE public.rol OWNER TO tapw;

--
-- Name: rol_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_id_seq OWNER TO tapw;

--
-- Name: rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.rol_id_seq OWNED BY public.rol.id;


--
-- Name: ruta; Type: TABLE; Schema: public; Owner: tapw
--

CREATE TABLE public.ruta (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE public.ruta OWNER TO tapw;

--
-- Name: ruta_id_seq; Type: SEQUENCE; Schema: public; Owner: tapw
--

CREATE SEQUENCE public.ruta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_id_seq OWNER TO tapw;

--
-- Name: ruta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tapw
--

ALTER SEQUENCE public.ruta_id_seq OWNED BY public.ruta.id;


--
-- Name: almacen id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.almacen ALTER COLUMN id SET DEFAULT nextval('public.alamcen_id_seq'::regclass);


--
-- Name: app_users id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users ALTER COLUMN id SET DEFAULT nextval('public.app_users_id_seq'::regclass);


--
-- Name: bitacora id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.bitacora ALTER COLUMN id SET DEFAULT nextval('public.bitacora_id_seq'::regclass);


--
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- Name: empleado id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.empleado ALTER COLUMN id SET DEFAULT nextval('public.empleado_id_seq'::regclass);


--
-- Name: estatus id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.estatus ALTER COLUMN id SET DEFAULT nextval('public.estatus_id_seq'::regclass);


--
-- Name: id_device id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.id_device ALTER COLUMN id SET DEFAULT nextval('public.id_device_id_seq'::regclass);


--
-- Name: inventario id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.inventario ALTER COLUMN id SET DEFAULT nextval('public.inventario_id_seq'::regclass);


--
-- Name: pedido id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id SET DEFAULT nextval('public.pedido_id_seq'::regclass);


--
-- Name: producto id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);


--
-- Name: rol id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.rol ALTER COLUMN id SET DEFAULT nextval('public.rol_id_seq'::regclass);


--
-- Name: ruta id; Type: DEFAULT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.ruta ALTER COLUMN id SET DEFAULT nextval('public.ruta_id_seq'::regclass);


--
-- Data for Name: almacen; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.almacen (id, nombre) FROM stdin;
1	Super Almacenes Portillo
\.


--
-- Data for Name: app_users; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.app_users (id, username, email, password, isactive, id_empleado, id_rol) FROM stdin;
2	empleado_02	empleado_02@correo.com	12345	t	2	2
3	admin	admin@correo.com	12345	t	10	1
1	empleado_01	empleado_01@correo.com	12345&	t	1	2
\.


--
-- Data for Name: bitacora; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.bitacora (id, email, token, fec_ini, fec_fin) FROM stdin;
117	usuario@email.com	2d3f666e7695c45c90194fdb80d4d825	2018-04-29 12:05:11.768456	2018-04-29 12:08:11.768456
119	usuario@email.com	4aeaae83fc285e8e87d0a777e801b1a3	2018-04-29 12:12:33.186542	2018-04-29 12:15:33.186542
121	usuario@email.com	afb5f4635bb184fe153a9604af576b29	2018-04-29 13:11:35.729976	2018-04-29 13:14:35.729976
123	usuario@email.com	e986be35b47f632c036deda125f2c11a	2018-04-29 13:25:57.002756	2018-04-29 13:26:57.002756
125	usuario@email.com	bf9e4e9eecfd0d62b8340df989320e05	2018-04-29 14:57:05.326519	2018-04-29 14:58:05.326519
127	usuario@email.com	c61b9c85ace2885007f13b2ccaacaf9e	2018-04-29 15:46:24.162631	2018-04-29 15:47:24.162631
129	usuario@email.com	c31a773f106dd5898f47627123b49b86	2018-04-29 16:33:27.536973	2018-04-29 16:36:06.286697
216	usuario@email.com	3dc4ae15ddc392e6417fb44ffa14f40e	2018-05-05 19:33:55.302536	2018-05-05 19:35:55.302536
218	usuario@email.com	b2549c424a34bca11c69d7fe9d621141	2018-05-05 19:50:05.666277	2018-05-05 19:52:05.666277
131	usuario@email.com	03c9bba1cba1869ea9f1e8213f32b48b	2018-04-29 16:40:09.053027	2018-04-29 16:43:44.574599
133	usuario@email.com	9e384fc5a05c4e0ca1f93ca718f5e854	2018-04-29 17:18:33.742513	2018-04-29 17:19:33.742513
135	usuario@email.com	e43fc80f4a06da13fa856453b3c73db8	2018-04-29 20:34:47.095609	2018-04-29 20:35:47.095609
137	usuario@email.com	4ed5dd3d5dc4f3551fb33b36aaebd7f3	2018-04-29 20:38:39.48824	2018-04-29 20:40:50.532424
139	usuario@email.com	7a2537a29d31f76721e612b4307bcad1	2018-04-29 22:08:50.003299	2018-04-29 22:09:50.003299
141	usuario@email.com	4dad2ceec2b8ebff5a04f3c101cfc8bd	2018-04-29 22:47:18.22242	2018-04-29 22:48:18.22242
142	usuario@email.com	22753c0e63fc15c7ad26ceb1547bd1d3	2018-04-30 07:22:31.935828	2018-04-30 07:23:31.935828
144	usuario@email.com	7942da34e71403f5cdf966bf141dcde6	2018-04-30 09:20:07.101618	2018-04-30 09:22:07.101618
146	usuario@email.com	16298667403e607f852317e7dec92285	2018-04-30 09:28:50.85212	2018-04-30 09:30:50.85212
148	usuario@email.com	b48cb077b660605f0dad47709e5966d1	2018-04-30 09:45:36.73685	2018-04-30 09:47:36.73685
150	usuario@email.com	f0da0aecbd43205409b36c1ef1b1d06a	2018-04-30 09:52:02.052962	2018-04-30 09:54:02.052962
152	usuario@email.com	7c4cc69364bc641344015384461affe0	2018-04-30 10:47:45.237548	2018-04-30 10:49:45.237548
154	usuario@email.com	768a1bb42147938ee94ff6359c86c0b6	2018-04-30 12:41:17.623276	2018-04-30 12:43:17.623276
156	usuario@email.com	c5faefe3a38b0b4b7aa0ce9c835aa192	2018-04-30 12:58:13.211378	2018-04-30 13:00:13.211378
158	usuario@email.com	ff42162920dd9f9cac7037edb5ef09bc	2018-04-30 13:16:01.566409	2018-04-30 13:18:01.566409
220	usuario@email.com	ccd239cd6a41a3bd5f03d4ef656fe2a6	2018-05-05 20:15:12.622929	2018-05-05 20:17:12.622929
221	empleado_01@empresa.fregona	732f9010f41b27e18653715cda716ee7	2018-05-31 20:26:55.732245	2018-05-31 20:28:55.732245
160	usuario@email.com	f1867507df39bdab8fb03ad153abfc16	2018-04-30 13:22:04.948551	2018-04-30 13:26:36.908791
162	usuario@email.com	851f6a2044fe7f74c3c87edcf134c2b7	2018-04-30 20:07:59.612275	2018-04-30 20:09:59.612275
164	usuario@email.com	fa08d0c8e9e59c83f395de12df5bd53f	2018-04-30 20:20:25.523217	2018-04-30 20:22:25.523217
166	usuario@email.com	bd7b67699c24efe51e43bf3de8814431	2018-04-30 21:13:25.439652	2018-04-30 21:15:25.439652
167	usuario@email.com	b1a548113cb362ee0cea420f9eea2534	2018-05-01 09:37:13.325552	2018-05-01 09:39:13.325552
169	usuario@email.com	30f1a332943edbd49c2487030daa338d	2018-05-01 10:42:00.407465	2018-05-01 10:44:00.407465
223	empleado_01@correo.com	986ac1470d16c1c0f3564203132851b0	2018-06-04 23:42:00.875762	2018-06-04 23:44:00.875762
224	empleado_01@correo.com	f15571ea61d54e889725d20ceecd1491	2018-06-05 07:31:36.037603	2018-06-05 07:33:36.037603
226	empleado_01@correo.com	2644c957b5b8e272dd7344bd59d4c593	2018-06-05 09:12:46.06842	2018-06-05 09:19:46.06842
228	empleado_01@correo.com	a7c8737b7d5a2f02f8298552b396db0f	2018-06-05 09:31:25.621616	2018-06-05 09:38:25.621616
230	empleado_01@correo.com	94ad880ffe0a0361a413f5566e72cc42	2018-06-05 14:17:24.536687	2018-06-05 14:24:24.536687
232	empleado_01@correo.com	426f67fd7666df337c11e607446172f6	2018-06-05 14:20:48.552356	2018-06-05 14:27:48.552356
234	empleado_01@correo.com	d34cf05e751b0803c52ece50d3558970	2018-06-05 14:29:42.123322	2018-06-05 14:36:42.123322
236	empleado_01@correo.com	65735e851e0e6d3e8f3806960966d028	2018-06-05 14:41:27.573309	2018-06-05 14:48:27.573309
171	usuario@email.com	abff175191e6f696097ab11637a8ba4a	2018-05-01 10:50:23.75232	2018-05-01 10:59:07.403409
173	usuario@email.com	436dc611abdded501845af0af600ecc2	2018-05-01 13:38:53.164575	2018-05-01 13:40:53.164575
175	usuario@email.com	8e5731df1980686c0f37c3627ff30be6	2018-05-01 14:01:56.189405	2018-05-01 14:03:56.189405
177	usuario@email.com	336aa75c313ab7ec26109b6e55795f46	2018-05-03 14:30:55.075595	2018-05-03 14:32:55.075595
238	empleado_01@correo.com	689121840ba9a805aabd6b0fb7250fe8	2018-06-05 15:44:58.295524	2018-06-05 15:51:58.295524
240	empleado_01@correo.com	1b9024a6d5e2df64995bfd0ad2d9e0b3	2018-06-05 16:12:48.71393	2018-06-05 16:19:48.71393
179	usuario@email.com	7724e52dc677a98efda9072d79c86b5e	2018-05-03 15:03:43.795679	2018-05-03 15:08:19.011249
181	usuario@email.com	0116a10bf1f82d1ba0e92f412823c157	2018-05-03 15:41:58.888213	2018-05-03 15:43:58.888213
183	usuario@email.com	b973eda1ef367f3b4567566d71dd4501	2018-05-03 21:19:27.487638	2018-05-03 21:21:27.487638
185	usuario@email.com	19940c7a30c045af594bb8b363fbaebf	2018-05-03 21:36:26.169966	2018-05-03 21:38:26.169966
187	usuario@email.com	52225d52bd1972ebf1eceef4116a1f17	2018-05-03 21:54:10.070824	2018-05-03 21:56:10.070824
188	usuario@email.com	1e02576ad4a049115af9bef5ebdadaf3	2018-05-04 00:34:40.160684	2018-05-04 00:36:40.160684
189	usuario@email.com	54f4c0391c640486008602e6770d7e14	2018-05-04 14:49:34.833454	2018-05-04 14:51:34.833454
191	usuario@email.com	ba613463cddd231fa814f53faa10e661	2018-05-04 15:14:08.252037	2018-05-04 15:16:08.252037
193	usuario@email.com	c0d675b42e57938181189a3608e8f86e	2018-05-04 15:25:29.835984	2018-05-04 15:27:29.835984
195	usuario@email.com	2a090a4704c331b45075608e1bd3b510	2018-05-04 15:29:45.662218	2018-05-04 15:31:45.662218
197	usuario@email.com	898467dfe3ac96cbd620b77f90f3ffb9	2018-05-04 15:44:54.161749	2018-05-04 15:46:54.161749
199	usuario@email.com	74e5e1dd1724d99ff7ba726d1f291764	2018-05-05 00:56:54.984337	2018-05-05 00:58:54.984337
201	usuario@email.com	3989adefba6ad0ac2e9064114be2a698	2018-05-05 01:39:45.464945	2018-05-05 01:41:45.464945
242	empleado_01@correo.com	0b19c8c8aa3b10e4fca750eb5a35ffbe	2018-06-05 16:18:53.968775	2018-06-05 16:25:53.968775
203	usuario@email.com	1c48831e656b63ee72cafd5b70c9f0e2	2018-05-05 04:40:59.392488	2018-05-05 04:46:09.655915
204	usuario@email.com	0919c89d1bf61a58f082b8688d70ce6a	2018-05-05 15:19:20.925522	2018-05-05 15:21:20.925522
206	usuario@email.com	cbeabe2de72a422efa781e018fae0f98	2018-05-05 15:25:23.667396	2018-05-05 15:27:23.667396
208	usuario@email.com	574801812141546863d997fbc4cd91d0	2018-05-05 15:32:10.668788	2018-05-05 15:34:10.668788
210	usuario@email.com	5b4b6ddfe5ffac42e18213e1db59e02c	2018-05-05 15:44:54.931681	2018-05-05 15:46:54.931681
212	usuario@email.com	5ee4c2d9483ad9b1801f459520d39dad	2018-05-05 16:18:40.701595	2018-05-05 16:20:40.701595
214	usuario@email.com	096748a57d4abb6220fe3224489761b5	2018-05-05 19:24:01.753866	2018-05-05 19:26:01.753866
244	empleado_01@correo.com	4f7e1a6d923455fc892cf5202d49a16e	2018-06-05 16:33:18.978037	2018-06-05 16:40:18.978037
246	empleado_01@correo.com	c2e5436de189a7de932e69daac18823f	2018-06-05 16:57:28.73478	2018-06-05 17:04:28.73478
248	empleado_01@correo.com	71f3652052f3b6354365e6df08349233	2018-06-05 19:51:50.830263	2018-06-05 19:58:50.830263
250	empleado_01@correo.com	09a00babfc8f1d7a5e3130f60d20f8b7	2018-06-05 23:12:00.43847	2018-06-05 23:19:00.43847
252	empleado_01@correo.com	9b8b549ff668d9b3860c163aabdbdbbd	2018-06-06 02:12:03.909532	2018-06-06 02:19:03.909532
253	empleado_01@correo.com	b2c38d029a49c455bfa8cf31a4699ae2	2018-06-06 19:21:30.767994	2018-06-06 19:28:30.767994
255	empleado_01@correo.com	954a42391df92ece86bb5fdfae16a39f	2018-06-06 23:04:36.409957	2018-06-06 23:11:36.409957
257	empleado_01@correo.com	c51edbc96f69c4d694a67967315b8eac	2018-06-06 23:44:50.723613	2018-06-06 23:51:50.723613
259	empleado_01@correo.com	deb348606f5e43f0b44fadebd86fe6e5	2018-06-06 23:45:38.685813	2018-06-06 23:52:38.685813
261	empleado_01@correo.com	d73661090172f7b02736b33b7fd19379	2018-06-07 00:24:17.393668	2018-06-07 00:31:17.393668
263	empleado_01@correo.com	754549efeaab93155cc37a9c5571adc0	2018-06-07 05:23:11.878836	2018-06-07 05:30:11.878836
265	empleado_01@correo.com	bb1199d5a68a21a0cb8cbf538c122865	2018-06-07 05:25:27.216303	2018-06-07 05:32:27.216303
264	empleado_01@correo.com	1cb144d5a7550aa70f262d35f107106d	2018-06-07 05:24:47.140036	2018-06-07 05:31:47.140036
227	empleado_01@correo.com	4961da5d25d3dc93c7d7f4db60ac13bc	2018-06-05 09:29:40.50533	2018-06-05 09:36:40.50533
118	usuario@email.com	89f86db35f5e9d5df73802efe4a73c76	2018-04-29 12:06:04.512758	2018-04-29 12:09:04.512758
120	usuario@email.com	744de67cc3c4380f9b6f0f8ec8bf345a	2018-04-29 12:19:03.641084	2018-04-29 12:22:03.641084
229	empleado_01@correo.com	84e02fd430aba870ee7202ae5bf3ab72	2018-06-05 10:26:06.50009	2018-06-05 10:33:06.50009
122	usuario@email.com	e40beb11938305f25d406c73ba02bf63	2018-04-29 13:25:31.885527	2018-04-29 13:26:31.885527
124	usuario@email.com	8d7805c4b7746849cedde78b5aa0fa90	2018-04-29 14:54:59.278755	2018-04-29 14:55:59.278755
126	usuario@email.com	c366fc962f815d69c8ef2d349de59397	2018-04-29 15:39:44.742276	2018-04-29 15:40:44.742276
128	usuario@email.com	e4a296cf6a39e411ffb73e125fd6a019	2018-04-29 15:56:06.01324	2018-04-29 15:58:23.238757
130	usuario@email.com	976295f0796c633f9a23ba9f04aeab98	2018-04-29 16:35:39.288399	2018-04-29 16:37:46.573711
132	usuario@email.com	5af30cc1dd0f561cde6e55d920848d67	2018-04-29 17:17:02.804668	2018-04-29 17:18:02.804668
134	usuario@email.com	92be98cf9d465fdd56bdb1f52da1894b	2018-04-29 19:38:37.333081	2018-04-29 20:34:21.207822
136	usuario@email.com	463dc05c4b4dbde0a1b0e4fb6f898819	2018-04-29 20:35:41.028367	2018-04-29 20:36:41.028367
138	usuario@email.com	9114144a9b4f10f4a9528594b51e4b15	2018-04-29 21:54:01.430071	2018-04-29 21:56:12.216088
140	usuario@email.com	8406680ae9a4171515979b0e83b93082	2018-04-29 22:37:26.593388	2018-04-29 22:38:26.593388
143	usuario@email.com	e4d5be5bd32ca432413b054fda245354	2018-04-30 07:25:29.002625	2018-04-30 07:26:29.002625
145	usuario@email.com	b387a53bfa85045a0da22e79a9e042ac	2018-04-30 09:26:25.435189	2018-04-30 09:28:25.435189
147	usuario@email.com	1247965d276b68a7cb147ec7912c4a23	2018-04-30 09:44:21.032956	2018-04-30 09:46:21.032956
149	usuario@email.com	28389c971af284ca627e589673d8403f	2018-04-30 09:50:18.820607	2018-04-30 09:52:18.820607
151	usuario@email.com	afae6b66a75e5b829205a78fa9063482	2018-04-30 10:46:44.734408	2018-04-30 10:48:44.734408
153	usuario@email.com	ed09ba4b1c4d40678435709a01414dbb	2018-04-30 11:32:23.215691	2018-04-30 11:34:23.215691
155	usuario@email.com	4a45fde6db68e684debc21245adea4be	2018-04-30 12:42:28.769702	2018-04-30 12:44:28.769702
266	empleado_01@correo.com	d2aa53ed1b1d3f2f56b853a586ac8e1b	2018-06-07 05:29:06.760674	2018-06-07 05:36:06.760674
231	empleado_01@correo.com	f6b0e10ab58934f0a68b647db23e711a	2018-06-05 14:18:21.936127	2018-06-05 14:25:21.936127
157	usuario@email.com	6d853e484a2eeb019c1a5e9939a42076	2018-04-30 13:06:21.813489	2018-04-30 13:16:33.202234
159	usuario@email.com	807cece39f933b78d5d66743ba165d58	2018-04-30 13:20:15.142325	2018-04-30 13:22:15.142325
161	usuario@email.com	354a3f7c4d0a567d941fd9c6df096d9a	2018-04-30 13:31:35.717975	2018-04-30 13:33:35.717975
163	usuario@email.com	872701f8013a9b36e419fb4042f71be4	2018-04-30 20:15:26.27293	2018-04-30 20:17:26.27293
165	usuario@email.com	61d693b8a360d7ff9bd28545fe0f363c	2018-04-30 20:34:52.229533	2018-04-30 20:36:52.229533
168	usuario@email.com	464c97f0f776a2303a3ec8a992979e9d	2018-05-01 09:41:02.705096	2018-05-01 09:43:02.705096
170	usuario@email.com	96a4e5b22d73d6922153c0314b860da7	2018-05-01 10:49:11.987063	2018-05-01 10:51:11.987063
172	usuario@email.com	213cd20487c7fe1f9bc72d774fe03408	2018-05-01 11:09:32.07997	2018-05-01 11:11:32.07997
233	empleado_01@correo.com	62b6599bb14c5d8b8ebd30bbe5e4f1eb	2018-06-05 14:27:24.236331	2018-06-05 14:34:24.236331
174	usuario@email.com	e085f66457923aea1740b68bd9193ab3	2018-05-01 13:39:36.312135	2018-05-01 13:43:11.481179
235	empleado_01@correo.com	58cd9d0b63d8c0d6f4738c4a4f70e7e4	2018-06-05 14:37:29.598243	2018-06-05 14:44:29.598243
176	usuario@email.com	44374c049e0345c5961a8740417575d2	2018-05-01 14:03:17.898081	2018-05-01 14:07:30.114415
178	usuario@email.com	199a4dea9cde23b969f0c0e5e1a5659c	2018-05-03 14:44:12.880338	2018-05-03 14:46:12.880338
180	usuario@email.com	9711a2e51b383fe85820be63fbd076ea	2018-05-03 15:18:16.30909	2018-05-03 15:20:16.30909
182	usuario@email.com	16bc98d7eee163f6c2227cd5335ef3d0	2018-05-03 15:48:04.706352	2018-05-03 15:51:09.363162
184	usuario@email.com	49b172cb11008ed6d9ad0f172e33d0da	2018-05-03 21:23:19.11156	2018-05-03 21:25:19.11156
186	usuario@email.com	f5d2bf76bbd5affd5c25c8bed1e2d246	2018-05-03 21:47:05.685807	2018-05-03 21:49:05.685807
190	usuario@email.com	52be0dac81eb24c0f2f3df00ec439afe	2018-05-04 14:59:42.811926	2018-05-04 15:01:42.811926
192	usuario@email.com	507d0b37b249c10e3bb27de8e5929d1e	2018-05-04 15:22:52.582022	2018-05-04 15:24:52.582022
194	usuario@email.com	7e67a0ec874aa2be264163fbff88bb4d	2018-05-04 15:27:51.083417	2018-05-04 15:29:51.083417
196	usuario@email.com	3236092e329c3dc9b1b49a986c07ceb4	2018-05-04 15:36:01.984742	2018-05-04 15:38:01.984742
198	usuario@email.com	7e617a77553ad07caafe8ec522a90fea	2018-05-04 15:47:56.226377	2018-05-04 15:49:56.226377
200	usuario@email.com	d66e1cf9cd7646ff17880e9f1db01cd3	2018-05-05 01:23:28.890066	2018-05-05 01:25:28.890066
202	usuario@email.com	55097481b1047101723b4369a310ef5f	2018-05-05 03:45:00.473593	2018-05-05 03:47:00.473593
205	usuario@email.com	b2d672104080a23017aa71d933dbafbb	2018-05-05 15:22:23.405876	2018-05-05 15:24:23.405876
207	usuario@email.com	5d6565d5a0f5ad8760504393b5cf8aea	2018-05-05 15:29:57.015391	2018-05-05 15:31:57.015391
209	usuario@email.com	608b4c202e16b095bfccb56d41d5a0e5	2018-05-05 15:37:02.821819	2018-05-05 15:39:02.821819
211	usuario@email.com	5612faeb87a33b8a31a56ea00e5201d8	2018-05-05 15:50:45.479256	2018-05-05 15:52:45.479256
237	empleado_01@correo.com	385ad57cfef4e18478b46b00f9ce72c8	2018-06-05 15:42:01.07253	2018-06-05 15:49:01.07253
239	empleado_01@correo.com	8f6d1a44a3d320d81711518974b41eb1	2018-06-05 16:09:36.703117	2018-06-05 16:16:36.703117
241	empleado_01@correo.com	3434bf84d4d77933aaa70f983e9cda02	2018-06-05 16:17:53.009457	2018-06-05 16:24:53.009457
213	usuario@email.com	a74e51884484bd915de3224d00f99458	2018-05-05 18:24:36.898337	2018-05-05 18:26:36.898337
215	usuario@email.com	cea8ebbad01684c6af1c43f2a67e5b28	2018-05-05 19:25:43.710576	2018-05-05 19:27:43.710576
217	usuario@email.com	881f30b40ff6c7487d8b13b3747fe058	2018-05-05 19:37:06.93911	2018-05-05 19:39:06.93911
219	usuario@email.com	1c96fac1001951fdcfe8341a728953e1	2018-05-05 20:02:48.019509	2018-05-05 20:04:48.019509
243	empleado_01@correo.com	d95b3c8beb80273e7643faaa7c4ff636	2018-06-05 16:26:42.612723	2018-06-05 16:33:42.612723
222	empleado_01@empresa.fregona	c7665711d2d47d6c52aaf3d914cc6f32	2018-05-31 20:31:33.359505	2018-05-31 20:33:33.359505
245	empleado_01@correo.com	689478ef19455adcd03929bb8d524560	2018-06-05 16:35:38.066358	2018-06-05 16:42:38.066358
267	empleado_01@correo.com	506f8744f87348c8f818cb4133decfea	2018-06-07 05:30:15.836227	2018-06-07 05:37:15.836227
225	empleado_01@correo.com	70f718eab2011e55400c50a74ba90698	2018-06-05 07:44:21.085144	2018-06-05 07:51:21.085144
247	empleado_01@correo.com	ac79a3a9dd418e0c63b6e55c34360215	2018-06-05 19:08:18.789945	2018-06-05 19:15:18.789945
249	empleado_01@correo.com	c8a8f27c17984ad4ab4906db61f94dcd	2018-06-05 20:53:14.371553	2018-06-05 21:00:14.371553
251	empleado_01@correo.com	8115d2fb464f827b8b284c3a3c5a15b6	2018-06-06 02:11:12.451461	2018-06-06 02:18:12.451461
254	empleado_01@correo.com	baade218808355af29553fae0bd7c1b5	2018-06-06 19:47:00.204122	2018-06-06 19:54:00.204122
256	ZW1wbGVhZG9fMDFAY29ycmVvLmNvbQ==	2aa8abe6da672d6e1e56ae0bd4d2648e	2018-06-06 23:08:59.551141	2018-06-06 23:15:59.551141
258	empleado_01@correo.com	c4fc5bee7971be9f5dde4c5382cd6e06	2018-06-06 23:45:27.337153	2018-06-06 23:52:27.337153
260	empleado_01@correo.com	f6cc250d520b04bb8bc13ebed524ef01	2018-06-06 23:52:59.068052	2018-06-06 23:59:59.068052
262	empleado_01@correo.com	ea5d6035248cfdf408f8b1ea4fc25f42	2018-06-07 00:37:44.072873	2018-06-07 00:44:44.072873
268	empleado_01@correo.com	0e3a059a9155d0049773079fa0d664b1	2018-06-07 05:32:23.494636	2018-06-07 05:39:23.494636
269	empleado_01@correo.com	b77424872c59d1f82ac3513f79d6f2c9	2018-06-07 05:32:52.920232	2018-06-07 05:39:52.920232
270	empleado_01@correo.com	c492ff8b56001de176dde09e662a1ef2	2018-06-07 05:40:23.110976	2018-06-07 05:47:23.110976
271	empleado_01@correo.com	c9e4ef3156dd2b9e328c33d9d9fd5809	2018-06-07 05:41:15.278289	2018-06-07 05:48:15.278289
272	empleado_01@correo.com	21aaa12b2d39a87a0c992360b21644b6	2018-06-07 05:48:02.131224	2018-06-07 05:55:02.131224
273	empleado_01@correo.com	430c2e386bc11989d67d10dd3340d9d6	2018-06-07 05:52:35.082254	2018-06-07 05:59:35.082254
274	empleado_01@correo.com	7fff60eabe56cb13c202294f06b66048	2018-06-07 05:53:47.95819	2018-06-07 06:00:47.95819
275	empleado_01@correo.com	bbaebecea079049cac562d5d2a29614b	2018-06-07 05:56:02.73227	2018-06-07 06:03:02.73227
276	empleado_01@correo.com	6b9f6b52b7172e7cd972d64e6b8fe5a0	2018-06-07 11:54:18.201397	2018-06-07 12:01:18.201397
277	empleado_01@correo.com	798da9cc9b449ac990e171f73f8c1e17	2018-06-07 11:57:43.579631	2018-06-07 12:00:34.26099
278	empleado_01@correo.com	22ebe55b4b609067fe0f0d22de8e3739	2018-06-07 12:01:13.822171	2018-06-07 12:08:13.822171
279	empleado_01@correo.com	2d8741a1958cfed7cfff3d59bf116722	2018-06-07 12:03:03.272823	2018-06-07 12:10:03.272823
280	empleado_01@correo.com	d2c19d69197b3ba98f29938cd3b3ded8	2018-06-07 12:04:55.412007	2018-06-07 12:11:55.412007
281	empleado_01@correo.com	5c704e2f261b04fe085c131170e0de00	2018-06-07 14:30:48.205902	2018-06-07 14:37:48.205902
282	empleado_01@correo.com	f1316111eae2d24a7706cb119f802c64	2018-06-07 14:32:02.56205	2018-06-07 14:39:02.56205
283	empleado_01@correo.com	f808be161db87753106feec6ceb17b05	2018-06-07 14:37:47.368256	2018-06-07 14:44:47.368256
284	empleado_01@correo.com	10795e590f38969d6713e5e2af5e4b80	2018-06-07 14:43:07.837675	2018-06-07 14:50:07.837675
285	empleado_01@correo.com	5e36788e7f3308d576042254e1c03e9c	2018-06-07 14:47:08.406608	2018-06-07 14:54:08.406608
286	empleado_01@correo.com	66851c86d598b4ee1325fe8773e40de0	2018-06-07 14:50:08.259787	2018-06-07 14:57:08.259787
287	empleado_01@correo.com	cf47d6387c24f6869d9cfb1cb162b980	2018-06-07 14:51:31.24645	2018-06-07 14:58:31.24645
288	empleado_01@correo.com	4e79a8620597b912b08a57f4fc1c6071	2018-06-07 14:53:28.973091	2018-06-07 15:00:28.973091
289	empleado_01@correo.com	ca453ae6a322fa1a03f6795d196466a3	2018-06-07 14:55:25.793601	2018-06-07 15:02:25.793601
290	empleado_01@correo.com	09d9e60c59262a1fbcf521d79e0e4aaa	2018-06-07 14:57:09.157699	2018-06-07 15:04:09.157699
291	empleado_01@correo.com	91ac16cba232be452643cf864b9b9b63	2018-06-07 15:03:52.410781	2018-06-07 15:10:52.410781
1	usuario@email.com	7b69f205f7d303f6b2d91ddf33a02e5b	2018-04-28 11:52:40.760591	2018-06-07 17:22:48.327034
292	empleado_01@correo.com	b8ef99e7f45b484aee8ec935e4db067d	2018-06-07 15:40:59.083055	2018-06-07 15:47:59.083055
293	empleado_01@correo.com	978f3530b6e6559f83657db779d7115d	2018-06-07 15:44:09.985386	2018-06-07 15:51:09.985386
294	empleado_01@correo.com	577cddf8dca48d1a5ed03f607c75dab4	2018-06-07 15:47:09.638138	2018-06-07 15:54:09.638138
295	empleado_01@correo.com	a2ff4db0f56f87472accfa6a2df7a2c5	2018-06-07 15:47:58.023149	2018-06-07 15:54:58.023149
296	empleado_01@correo.com	936f804a20972c29997208b1b2ed18b1	2018-06-07 15:57:28.265698	2018-06-07 16:04:28.265698
297	empleado_01@correo.com	d09d4d0931c881a5c3db53d8f6e354c6	2018-06-07 15:58:42.856452	2018-06-07 16:05:42.856452
298	empleado_01@correo.com	588ab110a6d1c69859b9d3ff6ccbf285	2018-06-07 16:00:51.797468	2018-06-07 16:07:51.797468
299	empleado_01@correo.com	b68c4e6418941bf76c205c2c585e8e21	2018-06-07 16:02:06.131107	2018-06-07 16:09:06.131107
300	empleado_01@correo.com	a35eeeab058a0da36151341f7db57393	2018-06-07 16:05:09.746002	2018-06-07 16:12:09.746002
301	empleado_01@correo.com	1787e93bcfb79bc795eb7adc1c2cf4ba	2018-06-07 16:06:22.797841	2018-06-07 16:13:22.797841
302	empleado_01@correo.com	7eaaf27cb515446e23b2329473411a52	2018-06-07 16:11:04.766685	2018-06-07 16:18:04.766685
303	empleado_01@correo.com	b567303cc417fd7c2290ee42e798a178	2018-06-07 16:17:33.909874	2018-06-07 16:24:33.909874
304	empleado_01@correo.com	ed71e40d720f60fbe3e1d5bf3cc6797d	2018-06-07 16:21:22.197251	2018-06-07 16:28:22.197251
305	empleado_01@correo.com	011ea062382f5201138aa4d307763fac	2018-06-07 16:25:26.30615	2018-06-07 16:32:26.30615
306	empleado_01@correo.com	c2a67320a52c243cea10a5040a431bcb	2018-06-07 16:27:24.001936	2018-06-07 16:34:24.001936
307	empleado_01@correo.com	30d1a6d66945420057a95f44cb1caca6	2018-06-07 16:34:35.916111	2018-06-07 16:41:35.916111
308	empleado_01@correo.com	b44f79f5abaa20c3df94376cd31eacc0	2018-06-07 16:36:04.218353	2018-06-07 16:43:04.218353
309	empleado_01@correo.com	1dc3e90e6f9bf1292feceac085e87c28	2018-06-07 17:46:50.840677	2018-06-07 18:25:53.583662
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.cliente (id, nombre, ape) FROM stdin;
1	Godard	Keri
2	Imelda	Blues
3	Cassey	Jedraszczyk
4	Rea	Meads
5	Obediah	Loughlin
6	Annnora	Donett
7	Yorker	Harvett
8	Stesha	Wiley
9	Winifield	Clackers
10	Lorelle	Labuschagne
11	Rockwell	Finder
12	Janetta	Willshear
13	Raimondo	Rooze
14	Cornela	McAvaddy
15	Sara-ann	Gatrill
16	Angeline	Kos
17	Giustino	Barette
18	Evy	Frodsam
19	Jolyn	Booi
20	Lyman	Ladbrooke
22	Steman	Loko
24	Peet	Zah-Jut
25	Juan	Kamaney
26	Mario	Bros
27	Yisus	God
29	Saint	Seiya
30	Marcus	Finix
31	Juan	Perez
32	Niño	Malo
33	Kiko	Tesoro
34	Chavo	Ocho
35	Hermoso	Peralta
36	Tony	Motola
37	God	Zilla
38	Señor	Hank
39	Damesio	Jhon
40	Mario	Escobar
41	Pedro	Pikapiedra
42	Pablo	Mármol
43	Son	Goku
44	Doña	Loka
45	Pepito	Perez
46	Federico	Tesoro
47	Pepe	Pekas
48	Pamela	Xuy
49	PitoXu	Evolution
51	Homero	Simpson
52	Chilindrina	Chillona
53	Muñeqita	De Hule
23	Simon	El gran Varón
50	Neal	Caffrey
72	jojo	jiji
\.


--
-- Data for Name: cliente_ruta; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.cliente_ruta (id_cliente, lat, lon, id_ruta, id_empleado) FROM stdin;
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.empleado (id, nombre, ape) FROM stdin;
1	Bowie	Pickervance
2	Farah	Reckus
3	Anne-corinne	Jillitt
4	Juliette	Rome
5	Husain	Flaherty
6	Lester	Dudny
7	Marie	Channer
8	Conni	Gietz
9	Torrin	Hallitt
10	Georgianne	Lucock
12	Drake	Bell
\.


--
-- Data for Name: estatus; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.estatus (nombre, id) FROM stdin;
Procesando	1
Completado	2
\.


--
-- Data for Name: id_device; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.id_device (id, token) FROM stdin;
1	dNav8T35DtA:APA91bGtwnuxXFuGdrFDR6aGq6gBUGZvMwi2mYicpXfACSps0z4Z_kpmT8njcPQXPwB4hCQjwIMi5YCCfVdFwjoBE9lmJeCWp1IDiBGobHVItvyzdxU2p1sDEJ94qX6dQMtPYxy1E7S3
\.


--
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.inventario (id, id_almacen, id_producto, existencia) FROM stdin;
3	1	8	12
5	1	17	22
4	1	12	29
2	1	5	14
6	1	2	15
7	1	3	20
8	1	4	11
9	1	6	14
10	1	7	17
11	1	9	19
13	1	11	18
14	1	13	14
15	1	14	18
16	1	15	50
17	1	16	33
1	1	1	18
12	1	10	22
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.pedido (id, id_empleado, id_producto, id_cliente, fecha, fecha_entrega, id_estatus) FROM stdin;
9	1	8	53	2018-05-05 20:16:05.582495	2018-05-15	2
2	1	1	1	2018-04-21 03:58:48.373467	2018-05-01	2
3	1	2	3	2018-04-21 04:00:35.358372	2018-05-01	2
4	1	1	1	2018-04-24 13:20:50.252184	2018-05-04	2
6	1	5	5	2018-05-05 18:04:55.859777	2018-05-15	2
7	1	6	50	2018-05-05 19:37:45.281746	2018-05-15	2
8	1	22	12	2018-05-05 19:50:49.834689	2018-05-15	2
14	1	1	5	2018-05-19 18:46:52.515447	2018-05-29	2
15	1	1	5	2018-05-19 19:16:16.519294	2018-05-19	2
16	1	1	6	2018-05-19 19:20:42.065161	2018-05-29	1
18	1	5	17	2018-05-19 19:57:51.112028	2018-05-29	1
19	1	5	17	2018-05-19 20:10:30.098727	2018-05-29	1
21	12	60	13	2018-05-31 22:15:27.65907	2018-06-10	1
23	12	23	29	2019-07-02 19:02:00	2019-07-12	1
24	1	60	50	2018-06-05 07:46:04.125079	2018-06-15	1
25	1	54	7	2018-01-01 03:03:00	2020-07-04	1
26	12	6	14	2018-07-01 05:00:00	2018-11-05	1
28	7	5	7	2015-08-01 00:08:00	2014-04-02	1
29	8	5	4	2015-03-03 03:01:00	2016-03-03	1
30	6	1	8	2017-05-09 10:12:00	2015-03-10	1
31	1	1	5	2018-06-07 12:08:12.584901	2018-06-17	1
32	1	1	1	2018-06-07 12:08:29.92815	2018-06-17	1
33	4	10	10	2014-02-08 09:11:00	2015-04-04	1
\.


--
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.producto (id, nombre) FROM stdin;
1	Pastry - Raisin Muffin - Mini
2	Pasta - Elbows, Macaroni, Dry
3	Bread - White, Sliced
4	Versatainer Nc - 9388
5	Lettuce - California Mix
6	Pepsi - Diet, 355 Ml
7	Cheese - Parmigiano Reggiano
8	Chicken - Leg, Fresh
9	Breakfast Quesadillas
10	Bread - French Baquette
11	Sauce - Hp
12	Broom And Broom Rack White
13	Oil - Food, Lacquer Spray
14	Wine - Ej Gallo Sonoma
15	Beef - Ground Lean Fresh
16	Ice Cream Bar - Rolo Cone
17	Wine - Red, Lurton Merlot De
18	Pepper - Chillies, Crushed
19	Sauce - Hollandaise
20	Tart Shells - Barquettes, Savory
21	Gelatine Leaves - Bulk
22	Nut - Pecan, Pieces
23	Wine - Guy Sage Touraine
24	Club Soda - Schweppes, 355 Ml
25	Soup Campbells - Italian Wedding
26	Nut - Pumpkin Seeds
27	Wine - Spumante Bambino White
28	Cheese - Bocconcini
29	Rum - Light, Captain Morgan
30	Tray - Foam, Square 4 - S
31	Croissant, Raw - Mini
32	Lettuce Romaine Chopped
33	Veal - Leg
34	Myers Planters Punch
35	Bread - White, Unsliced
36	Squid - Breaded
37	Kahlua
38	Hog / Sausage Casing - Pork
39	Rum - White, Gg White
40	Fish - Artic Char, Cold Smoked
41	Bread Base - Goodhearth
42	Flour - Fast / Rapid
43	Bread Roll Foccacia
44	Garlic - Peeled
45	Mushroom - Porcini Frozen
46	Pasta - Rotini, Dry
47	Plaintain
48	Sage Derby
49	Olives - Green, Pitted
50	Filter - Coffee
55	Rancheritos
54	Crujitos
56	Chetos
60	Mazapan
\.


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.rol (id, nombre) FROM stdin;
1	ADMIN
2	USER
\.


--
-- Data for Name: ruta; Type: TABLE DATA; Schema: public; Owner: tapw
--

COPY public.ruta (id, nombre) FROM stdin;
\.


--
-- Name: alamcen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.alamcen_id_seq', 1, true);


--
-- Name: app_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.app_users_id_seq', 3, true);


--
-- Name: bitacora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.bitacora_id_seq', 309, true);


--
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.cliente_id_seq', 72, true);


--
-- Name: empleado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.empleado_id_seq', 13, true);


--
-- Name: estatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.estatus_id_seq', 2, true);


--
-- Name: id_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.id_device_id_seq', 1, true);


--
-- Name: inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.inventario_id_seq', 17, true);


--
-- Name: pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.pedido_id_seq', 33, true);


--
-- Name: producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.producto_id_seq', 66, true);


--
-- Name: rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.rol_id_seq', 2, true);


--
-- Name: ruta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tapw
--

SELECT pg_catalog.setval('public.ruta_id_seq', 1, false);


--
-- Name: almacen almacen_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.almacen
    ADD CONSTRAINT almacen_pk PRIMARY KEY (id);


--
-- Name: app_users app_users_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pk PRIMARY KEY (id);


--
-- Name: app_users app_users_uq1; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_uq1 UNIQUE (username);


--
-- Name: app_users app_users_uq2; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_uq2 UNIQUE (email);


--
-- Name: app_users app_users_uq3; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_uq3 UNIQUE (id_empleado);


--
-- Name: bitacora bitacota_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.bitacora
    ADD CONSTRAINT bitacota_pk PRIMARY KEY (id);


--
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pk PRIMARY KEY (id);


--
-- Name: cliente_ruta cliente_ruta_uniq1; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente_ruta
    ADD CONSTRAINT cliente_ruta_uniq1 UNIQUE (id_cliente, id_empleado);


--
-- Name: empleado empleado_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pk PRIMARY KEY (id);


--
-- Name: estatus estatus_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.estatus
    ADD CONSTRAINT estatus_pk PRIMARY KEY (id);


--
-- Name: id_device id_device_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.id_device
    ADD CONSTRAINT id_device_pk PRIMARY KEY (id);


--
-- Name: inventario inventario_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pk PRIMARY KEY (id);


--
-- Name: inventario inventario_unq1; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_unq1 UNIQUE (id_almacen, id_producto);


--
-- Name: pedido pedido_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pk PRIMARY KEY (id);


--
-- Name: producto producto_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pk PRIMARY KEY (id);


--
-- Name: rol rol_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pk PRIMARY KEY (id);


--
-- Name: ruta ruta_pk; Type: CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pk PRIMARY KEY (id);


--
-- Name: pedido trigger_inventario_u_existencia; Type: TRIGGER; Schema: public; Owner: tapw
--

CREATE TRIGGER trigger_inventario_u_existencia AFTER INSERT ON public.pedido FOR EACH ROW EXECUTE PROCEDURE public.fun_inventario_u_existencia();


--
-- Name: app_users app_users_fk1; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado(id);


--
-- Name: cliente_ruta cliente_ruta_fk1; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente_ruta
    ADD CONSTRAINT cliente_ruta_fk1 FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);


--
-- Name: cliente_ruta cliente_ruta_fk2; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente_ruta
    ADD CONSTRAINT cliente_ruta_fk2 FOREIGN KEY (id_ruta) REFERENCES public.ruta(id);


--
-- Name: cliente_ruta cliente_ruta_fk3; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.cliente_ruta
    ADD CONSTRAINT cliente_ruta_fk3 FOREIGN KEY (id_empleado) REFERENCES public.empleado(id);


--
-- Name: inventario inventario_fk1; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_fk1 FOREIGN KEY (id_almacen) REFERENCES public.almacen(id);


--
-- Name: inventario inventario_fk2; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_fk2 FOREIGN KEY (id_producto) REFERENCES public.producto(id);


--
-- Name: pedido pedido_fk1; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado(id);


--
-- Name: pedido pedido_fk2; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_fk2 FOREIGN KEY (id_producto) REFERENCES public.producto(id);


--
-- Name: pedido pedido_fk3; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_fk3 FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);


--
-- Name: pedido pedido_fk4; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_fk4 FOREIGN KEY (id_estatus) REFERENCES public.estatus(id);


--
-- Name: app_users rol_fk1; Type: FK CONSTRAINT; Schema: public; Owner: tapw
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT rol_fk1 FOREIGN KEY (id_rol) REFERENCES public.rol(id);


--
-- PostgreSQL database dump complete
--

