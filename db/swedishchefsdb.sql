--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-03-31 00:59:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;
SET check_function_bodies = FALSE;
SET client_min_messages = WARNING;

--
-- TOC entry 2056 (class 1262 OID 12135)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE irdbpostgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;
SET check_function_bodies = FALSE;
SET client_min_messages = WARNING;

--
-- TOC entry 2057 (class 1262 OID 12135)
-- Dependencies: 2056
-- Name: postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';

--
-- TOC entry 180 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 180
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

--
-- TOC entry 179 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;

--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 179
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- TOC entry 535 (class 1247 OID 16446)
-- Name: <enum 'Origin'>; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE "Origin" AS ENUM (
  'Africa',
  'Asia',
  'Australia',
  'Europe',
  'NorthAmerica',
  'Oceania',
  'SouthAmerica',
  'Worldwide'
);

--
-- TOC entry 532 (class 1247 OID 16394)
-- Name: Cuisine; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE "Cuisine" AS ENUM (
  'african',
  'chinese',
  'japanese',
  'korean',
  'vietnamese',
  'thai',
  'indian',
  'british',
  'irish',
  'french',
  'italian',
  'mexican',
  'spanish',
  'middleEastern',
  'jewish',
  'american',
  'cajun',
  'southern',
  'greek',
  'german',
  'nordic',
  'easternEuropean',
  'caribbean',
  'latinAmerican'
);


SET default_tablespace = '';

SET default_with_oids = FALSE;

--
-- TOC entry 173 (class 1259 OID 16669)
-- Name: Ingredient; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE "Ingredient" (
  id              INTEGER           NOT NULL,
  name            CHARACTER VARYING NOT NULL,
  image_uri       CHARACTER VARYING,
  scientific_name CHARACTER VARYING,
  origin          "Origin"
);

--
-- TOC entry 172 (class 1259 OID 16667)
-- Name: Ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Ingredient_id_seq"
START WITH 0
INCREMENT BY 1
MINVALUE 0
NO MAXVALUE
CACHE 1;

--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 172
-- Name: Ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Ingredient_id_seq" OWNED BY "Ingredient".id;

--
-- TOC entry 178 (class 1259 OID 16717)
-- Name: IngredientsInRecipes; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE "IngredientsInRecipes" (
  recipe_id        INTEGER           NOT NULL,
  ingredient_id    INTEGER           NOT NULL,
  original_string  CHARACTER VARYING NOT NULL,
  amount           DOUBLE PRECISION,
  unit             CHARACTER VARYING,
  unit_short       CHARACTER VARYING,
  ingredient_index INTEGER           NOT NULL
);

--
-- TOC entry 177 (class 1259 OID 16693)
-- Name: Nutritional Content; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE "Nutritional Content" (
  id                    INTEGER          NOT NULL,
  ingredient_id         INTEGER,
  calories              DOUBLE PRECISION NOT NULL,
  total_fat_g           DOUBLE PRECISION NOT NULL,
  saturated_fat_g       DOUBLE PRECISION NOT NULL,
  cholesterol_mg        DOUBLE PRECISION NOT NULL,
  sodium_mg             DOUBLE PRECISION NOT NULL,
  total_carbohydrates_g DOUBLE PRECISION NOT NULL,
  dietary_fiber_g       DOUBLE PRECISION NOT NULL,
  sugar_g               DOUBLE PRECISION NOT NULL,
  protein_g             DOUBLE PRECISION NOT NULL,
  vitamin_a_iu          DOUBLE PRECISION NOT NULL,
  vitamin_c_mg          DOUBLE PRECISION NOT NULL,
  calcium_mg            DOUBLE PRECISION NOT NULL,
  iron_mg               DOUBLE PRECISION NOT NULL,
  CONSTRAINT "Nutritional Content_calcium_mg_check" CHECK ((calcium_mg >= 0)),
  CONSTRAINT "Nutritional Content_calories_check" CHECK ((calories >= 0)),
  CONSTRAINT "Nutritional Content_cholesterol_mg_check" CHECK ((cholesterol_mg >= 0)),
  CONSTRAINT "Nutritional Content_dietary_fiber_g_check" CHECK ((dietary_fiber_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_iron_mg_check" CHECK ((iron_mg >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_protein_g_check" CHECK ((protein_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_saturated_fat_g_check" CHECK ((saturated_fat_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_sodium_mg_check" CHECK ((sodium_mg >= 0)),
  CONSTRAINT "Nutritional Content_sugar_g_check" CHECK ((sugar_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_total_carbohydrates_g_check" CHECK ((total_carbohydrates_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_total_fat_g_check" CHECK ((total_fat_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_vitamin_a_iu_check" CHECK ((vitamin_a_iu >= 0)),
  CONSTRAINT "Nutritional Content_vitamin_c_mg_check" CHECK ((vitamin_c_mg >= (0) :: DOUBLE PRECISION))
);

--
-- TOC entry 176 (class 1259 OID 16691)
-- Name: Nutritional Content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Nutritional Content_id_seq"
START WITH 0
INCREMENT BY 1
MINVALUE 0
NO MAXVALUE
CACHE 1;

--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 176
-- Name: Nutritional Content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Nutritional Content_id_seq" OWNED BY "Nutritional Content".id;

--
-- TOC entry 175 (class 1259 OID 16682)
-- Name: Recipe; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE "Recipe" (
  id               INTEGER           NOT NULL,
  title            CHARACTER VARYING NOT NULL,
  image_uri        CHARACTER VARYING,
  instructions     CHARACTER VARYING,
  cuisine          "Cuisine",
  ready_in_minutes INTEGER,
  servings         INTEGER,
  vegetarian       BOOLEAN,
  vegan            BOOLEAN,
  gluten_free      BOOLEAN,
  dairy_free       BOOLEAN
);

--
-- TOC entry 174 (class 1259 OID 16680)
-- Name: Recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Recipe_id_seq"
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 174
-- Name: Recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Recipe_id_seq" OWNED BY "Recipe".id;

--
-- TOC entry 1907 (class 2604 OID 16672)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Ingredient"
  ALTER COLUMN id SET DEFAULT nextval('"Ingredient_id_seq"' :: REGCLASS);

--
-- TOC entry 1909 (class 2604 OID 16696)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Nutritional Content"
  ALTER COLUMN id SET DEFAULT nextval('"Nutritional Content_id_seq"' :: REGCLASS);

--
-- TOC entry 1908 (class 2604 OID 16685)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Recipe"
  ALTER COLUMN id SET DEFAULT nextval('"Recipe_id_seq"' :: REGCLASS);

--
-- TOC entry 2046 (class 0 OID 16669)
-- Dependencies: 173
-- Data for Name: Ingredient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Ingredient" (id, name, image_uri, scientific_name, origin) FROM STDIN;
0	NULLNAME	ingredient_img	ingredient_sci_name	Africa
1	black-eyed pea	https://upload.wikimedia.org/wikipedia/commons/d/d0/BlackEyedPeas.JPG	Vigna unguiculata subsp. unguiculata	Africa
2	carrot	https://upload.wikimedia.org/wikipedia/commons/b/bd/13-08-31-wien-redaktionstreffen-EuT-by-Bi-frie-037.jpg	Daucus carota	Asia
3	green bell pepper	https://upload.wikimedia.org/wikipedia/commons/5/59/Capsicum3.JPG	Capsicum annuum	NorthAmerica
4	onion	https://upload.wikimedia.org/wikipedia/commons/a/a2/Mixed_onions.jpg	Allium cepa	Africa
5	peanut butter	https://upload.wikimedia.org/wikipedia/commons/b/bb/96_-_IMG_20150804_111725.jpg	\N	NorthAmerica
6	salt	https://upload.wikimedia.org/wikipedia/commons/7/78/Salt_shaker_on_white_background.jpg	Sodium chloride	Worldwide
7	water	https://upload.wikimedia.org/wikipedia/commons/1/18/Water_drop_impact_on_a_water-surface_-_%285%29.jpg	Dihydrogen oxide	Worldwide
8	baking powder	https://upload.wikimedia.org/wikipedia/commons/2/2d/BakingPowder.jpg	Sodium aluminum sulfate	Europe
9	banana	https://upload.wikimedia.org/wikipedia/commons/4/44/Bananas_white_background_DS.jpg	Musa acuminata Colla	Oceania
10	butter	https://upload.wikimedia.org/wikipedia/commons/f/fd/Western-pack-butter.jpg	\N	Worldwide
11	canola oil	https://upload.wikimedia.org/wikipedia/commons/e/eb/CanolaOil_bottle.jpg	Brassicaceae family	Asia
12	cinnamon	https://upload.wikimedia.org/wikipedia/commons/d/de/Cinnamomum_verum_spices.jpg	Cinnamomum aromaticum	Asia
13	cream cheese	https://upload.wikimedia.org/wikipedia/commons/f/f7/Philly_cream_cheese.jpg	\N	Europe
14	egg	https://upload.wikimedia.org/wikipedia/commons/e/ee/Egg_colours.jpg	\N	Worldwide
15	all-purpose flour	https://upload.wikimedia.org/wikipedia/commons/6/64/All-Purpose_Flour_%284107895947%29.jpg	\N	Asia
16	nutmeg	https://upload.wikimedia.org/wikipedia/commons/3/3b/Muscade.jpg	Myristica fragrans	Asia
17	honey	https://static.pexels.com/photos/8257/spoon-honey-jar.jpg	Fructose, glocuse	Worldwide
18	lemon juice	https://upload.wikimedia.org/wikipedia/commons/b/b0/Jif_Lemon.jpg	Citrus limon	Asia
19	maple syrup	https://upload.wikimedia.org/wikipedia/commons/1/18/Maple_syrup.jpg	\N	NorthAmerica
20	whole milk	https://upload.wikimedia.org/wikipedia/commons/0/0e/Milk_glass.jpg	\N	Worldwide
21	white bread	https://upload.wikimedia.org/wikipedia/commons/2/2c/Wei%C3%9Fbrot-1.jpg	\N	Worldwide
22	bacon	https://upload.wikimedia.org/wikipedia/commons/e/e8/RawBacon.JPG	\N	Worldwide
23	garlic	https://upload.wikimedia.org/wikipedia/commons/4/49/Opened_garlic_bulb_with_garlic_clove.jpg	Allium sativum	Worldwide
24	cabbage	https://upload.wikimedia.org/wikipedia/commons/f/fa/Cabbages_Green_and_Purple_2120px.jpg	Brassica oleracea (Capitata Group)	Europe
25	leek	https://upload.wikimedia.org/wikipedia/commons/4/43/Leek.jpg	Allium ampeloprasum	Europe
26	mace	https://upload.wikimedia.org/wikipedia/commons/3/3e/Mace_%28%E0%A6%9C%E0%A6%AF%E0%A6%BC%E0%A6%BF%E0%A6%A4%E0%A7%8D%E0%A6%B0%E0%A6%BF%29.JPG	Myristica fragrans	Asia
27	potato	https://upload.wikimedia.org/wikipedia/commons/4/47/Russet_potato_cultivar_with_sprouts.jpg	Solanum tuberosum	SouthAmerica
28	sesame oil	https://upload.wikimedia.org/wikipedia/commons/0/0a/Sesame_oil.jpg	\N	Asia
29	radish	https://upload.wikimedia.org/wikipedia/commons/4/49/Remscheid_L%C3%BCttringhausen_-_Bauernmarkt_18_ies.jpg	Raphanus sativus	Europe
30	hoisin sauce	https://upload.wikimedia.org/wikipedia/commons/3/3f/Hoisin_sauce.jpg	\N	Asia
31	snow pea	https://upload.wikimedia.org/wikipedia/commons/0/07/Peas_-_Studio_-_2011.jpg	Pisum sativum	Europe
32	sriracha sauce	https://upload.wikimedia.org/wikipedia/commons/6/62/Sriracha_Hot_Sauce_Bottles_Freshii_Restaurant_Family_Dinner_Downtown_Grand_Rapids_June_27,_2014_1_%2814552677466%29.jpg	\N	Asia
33	black turtle bean	https://upload.wikimedia.org/wikipedia/commons/c/ce/Black_Turtle_Bean.jpg	Phaseolus vulgaris	SouthAmerica
34	allspice	https://upload.wikimedia.org/wikipedia/commons/5/5b/Allspice.JPG	Pimenta dioica	NorthAmerica
35	canned black turtle beans	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Black_beans.jpg/1024px-Black_beans.jpg	\N	SouthAmerica
36	chickpea	https://upload.wikimedia.org/wikipedia/commons/7/79/Bengal_gram,_chickpea_%28_%E0%A6%9B%E0%A7%8B%E0%A6%B2%E0%A6%BE%E0%A6%B0_%E0%A6%A1%E0%A6%BE%E0%A6%B2%29.JPG	Cicer arietinum	SouthAmerica
37	canned chickpeas	https://c1.staticflickr.com/9/8646/16085956040_3780024bd3_b.jpg	\N	SouthAmerica
38	frozen green peas	https://upload.wikimedia.org/wikipedia/commons/e/e3/Frozen_peas.JPG	Pisum sativum	Europe
39	yogurt	https://upload.wikimedia.org/wikipedia/commons/e/ea/Turkish_strained_yogurt.jpg	\N	Europe
40	corn starch	http://3.bp.blogspot.com/-GSgCOGH_uNY/VXIjn17j8AI/AAAAAAAADIA/Fo5m6SVZhu0/s1600/cornstarch-kz.jpg	\N	NorthAmerica
41	paprika	https://upload.wikimedia.org/wikipedia/commons/9/97/Spanishsmokedpaprika.jpg	Capsicum annuum	NorthAmerica
42	ground beef	https://upload.wikimedia.org/wikipedia/commons/d/d1/Hackfleisch-1.jpg	Bos taurus	Asia
43	parsley	https://upload.wikimedia.org/wikipedia/commons/9/97/Parsley.jpg	Petroselinum crispum	Europe
44	dried parsley	https://upload.wikimedia.org/wikipedia/commons/8/8c/Parsley_Dried.JPG	Petroselinum crispum	Europe
45	oregano	https://pixabay.com/static/uploads/photo/2014/04/10/15/39/oregano-321037_960_720.jpg	Origanum vulgare	Europe
46	sesame seed	https://upload.wikimedia.org/wikipedia/commons/3/38/Sesame_seeds.JPG	Sesamum indicum	Africa
47	tomato	https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg	Solanum lycopersicum	SouthAmerica
48	cumin	https://upload.wikimedia.org/wikipedia/commons/9/9d/4622_-_Cumino_al_mercato_di_Ortigia%2C_Siracusa_-_Foto_Giovanni_Dall'Orto%2C_20_marzo_2014.jpg	Cuminum cyminum	Africa
49	cumin seed	https://upload.wikimedia.org/wikipedia/commons/6/64/Cumin_seed_whole.JPG	Cuminum cyminum	Africa
50	brown sugar	https://upload.wikimedia.org/wikipedia/commons/8/82/Brown_sugar_examples.JPG	\N	Worldwide
51	bean sprout	https://upload.wikimedia.org/wikipedia/commons/7/73/Moyashi.jpg	Vigna radiata	Asia
52	raw shrimp	https://upload.wikimedia.org/wikipedia/commons/1/11/Shrimp_Shell_%2811833859924%29.jpg	Penaeidae and Pandalidae	Worldwide
53	daikon	https://upload.wikimedia.org/wikipedia/commons/c/cb/Daikon.Japan.jpg	Raphanus sativus (Longipinratus Group)	Asia
54	shiitake mushroom	https://upload.wikimedia.org/wikipedia/commons/3/3d/Shiitake_mushrooms_1.jpg	Lentinus edodes	Asia
55	white mushroom	https://upload.wikimedia.org/wikipedia/commons/f/ff/Champignons_Agaricus.jpg	Agaricus bisporus	Europe
56	portabello mushroom	https://upload.wikimedia.org/wikipedia/commons/3/3e/Portobello_mushrooms.jpg	Agaricus bisporus	Europe
57	cooked shrimp	https://upload.wikimedia.org/wikipedia/commons/6/60/NCI_steamed_shrimp.jpg	\N	Worldwide
58	black pepper	https://upload.wikimedia.org/wikipedia/commons/9/97/Black_Pepper_IMG_4866_-_02.jpg	Piper nigrum	Asia
59	red pepper	https://upload.wikimedia.org/wikipedia/commons/9/91/Capsicum_frutescens.jpg	Capsicum frutescens or Capsicum annuum	NorthAmerica
60	white pepper	https://upload.wikimedia.org/wikipedia/commons/2/26/White_pepper_whole.JPG	Piper nigrum	Asia
61	crushed red pepper	https://upload.wikimedia.org/wikipedia/commons/5/5b/Red_pepper_flakes.jpg	Capsicum annuum	NorthAmerica
62	green pea	https://upload.wikimedia.org/wikipedia/commons/b/b2/1-Green_peas.jpg	Pisum sativum	Europe
63	chickpea flour	https://upload.wikimedia.org/wikipedia/commons/5/5e/Gram_flour_AvL.jpg	\N	Asia
64	reduced fat milk	https://upload.wikimedia.org/wikipedia/commons/f/f1/Kirkland_Milk_Jug.JPG	\N	Worldwide
65	lentil	https://upload.wikimedia.org/wikipedia/commons/8/81/Green_lentils.jpg	Lens culinaris	Asia
66	red lentil	https://upload.wikimedia.org/wikipedia/commons/a/a5/Red_lentils_-_jules.jpg	Lens culinaris	Asia
67	canned tomatoes	https://c1.staticflickr.com/3/2363/1579500807_8362e0c924_b.jpg	\N	Worldwide
68	canned crushed tomatoes	https://upload.wikimedia.org/wikipedia/commons/b/b7/Canned_tomatoes.jpg	\N	Worldwide
69	cauliflower	https://upload.wikimedia.org/wikipedia/commons/f/ff/Cauliflowerr.jpg	Brassica oleracea (Botrytis Group)	Asia
70	tomato paste	https://upload.wikimedia.org/wikipedia/commons/e/e8/Tomato_paste_on_spoon.jpg	\N	Europe
71	vegetable oil	https://c2.staticflickr.com/6/5589/14937958628_8f6fedc5a3_b.jpg	\N	NorthAmerica
72	olive oil	https://pixabay.com/static/uploads/photo/2015/10/02/15/59/olive-oil-968657_960_720.jpg	\N	Europe
73	cashew	https://upload.wikimedia.org/wikipedia/commons/f/fd/Cashews_1314.jpg	Anacardium occidentale	SouthAmerica
74	soy sauce	https://upload.wikimedia.org/wikipedia/commons/a/a1/Kikkoman_Soy_Sauce%2C_Perspective-view%2C_jp-type%2C.jpg	\N	Asia
75	green chili pepper	https://upload.wikimedia.org/wikipedia/commons/8/88/Aesthetic_green_Chillies.JPG	Capsicum frutescens	SouthAmerica
76	red bell pepper	https://upload.wikimedia.org/wikipedia/commons/5/5c/Red_bell_pepper.jpg	Capsicum annuum	NorthAmerica
77	dried chili peppers	https://upload.wikimedia.org/wikipedia/commons/c/c4/Dry_Chili_pepper.jpg	Capsicum frutescens	Asia
78	chili pepper paste	https://upload.wikimedia.org/wikipedia/commons/2/21/Kimchi_and_Gochujang_by_johl.jpg	Capsicum frutescens	Asia
79	tomato sauce	https://upload.wikimedia.org/wikipedia/commons/0/0f/Tomate_natural_triturado.jpg	\N	NorthAmerica
80	curry powder	https://upload.wikimedia.org/wikipedia/commons/2/22/Curry_Ist.jpg	\N	Asia
81	orange bell pepper	https://upload.wikimedia.org/wikipedia/commons/0/08/Orange_bell-peppers_Rouffignac.jpg	Capsicum annuum	NorthAmerica
82	yellow bell pepper	https://upload.wikimedia.org/wikipedia/commons/f/f6/Yellow_Bell_Pepper_group_store.jpg	Capsicum annuum	NorthAmerica
83	rosemary	https://pixabay.com/static/uploads/photo/2013/01/08/01/43/rosemary-74365_960_720.jpg	Rosmarinus officinalis	Europe
84	dried rosemary	https://pixabay.com/static/uploads/photo/2015/11/18/16/52/rosemary-1049501_960_720.jpg	Rosmarinus officinalis	Europe
85	thyme	https://upload.wikimedia.org/wikipedia/commons/e/ea/Thyme-Bundle.jpg	Thymus vulgaris	Worldwide
86	dried thyme	https://upload.wikimedia.org/wikipedia/commons/c/c5/Spice_thyme_scale.jpg	Thymus vulgaris	Worldwide
87	basil	https://upload.wikimedia.org/wikipedia/commons/9/90/Basil-Basilico-Ocimum_basilicum-albahaca.jpg	Ocimum basilicum	Asia
88	dried basil	https://upload.wikimedia.org/wikipedia/commons/7/72/Basilic-spice.jpg	Ocimum basilicum	Asia
89	jam	https://upload.wikimedia.org/wikipedia/commons/2/21/Ribotroshhashana.jpg	\N	Worldwide
90	dried shrimp	https://upload.wikimedia.org/wikipedia/commons/a/a3/Dried_shrimp_Indonesia_udang_kering.JPG	\N	Asia
91	chives	https://upload.wikimedia.org/wikipedia/commons/6/64/Chives_144211774.jpg	Allium schoenoprasum	Worldwide
92	cilantro	https://upload.wikimedia.org/wikipedia/commons/5/51/A_scene_of_Coriander_leaves.JPG	Coriandrum sativum	Asia
93	dried coriander	https://upload.wikimedia.org/wikipedia/commons/e/e3/Coriander.png	Coriandrum sativum	Asia
94	green onion	https://upload.wikimedia.org/wikipedia/commons/4/41/Spring_onion.jpg	Allium cepa or Allium fistulosum	Worldwide
95	chili powder	https://upload.wikimedia.org/wikipedia/commons/0/00/BolivianChilePowder2.JPG	\N	NorthAmerica
96	sea salt	https://upload.wikimedia.org/wikipedia/commons/d/d8/Saltmill.jpg	Sodium chloride	Worldwide
97	kosher salt	https://upload.wikimedia.org/wikipedia/commons/7/78/Kosher_Salt.JPG	Sodium chloride	Worldwide
98	distilled vinegar	https://pixabay.com/static/uploads/photo/2015/05/15/17/16/vinegar-768948_960_720.jpg	\N	NorthAmerica
99	cider vinegar	https://upload.wikimedia.org/wikipedia/commons/6/68/Apple_cider_vinegar.jpg	\N	NorthAmerica
100	red or white wine vinegar	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Essig-1.jpg/783px-Essig-1.jpg	\N	Europe
101	balsamic vinegar	https://upload.wikimedia.org/wikipedia/commons/7/7e/Balsamico-1.jpg	\N	Europe
102	canned tuna	https://upload.wikimedia.org/wikipedia/commons/8/8d/Canned_and_packaged_tuna_on_supermarket_shelves.jpg	\N	Oceania
103	tuna	https://upload.wikimedia.org/wikipedia/commons/f/f9/Yellowfin_tuna_nurp.jpg	Thunnus thynnus (L.)	Worldwide
104	vegetable bouillon	https://upload.wikimedia.org/wikipedia/commons/f/f5/Br%C3%BChw%C3%BCrfel-1.jpg	\N	Europe
105	vegetable broth	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Europe
106	cooking spray	https://c1.staticflickr.com/3/2061/2148331981_48fa2949d4.jpg	\N	NorthAmerica
107	scotch bonnet pepper	https://upload.wikimedia.org/wikipedia/commons/9/96/HotPeppersinMarket.jpg	Capsicum chinense	SouthAmerica
108	habanero	https://upload.wikimedia.org/wikipedia/commons/8/86/Habanero_closeup_edit2.jpg	Capsicum chinense	SouthAmerica
109	egg yolk	https://upload.wikimedia.org/wikipedia/commons/3/35/Raw_egg.jpg	\N	Worldwide
110	whole-wheat flour	https://upload.wikimedia.org/wikipedia/commons/6/66/Whole_wheat_grain_flour_being_scooped.jpg	\N	Worldwide
111	mixed vegetables	https://farm4.staticflickr.com/3184/3073658608_6aab855d29_o.jpg	\N	Worldwide
112	canned pineapple	https://pixabay.com/static/uploads/photo/2015/02/14/18/10/pineapple-636562_960_720.jpg	\N	NorthAmerica
113	pineapple	https://pixabay.com/static/uploads/photo/2015/02/14/18/10/pineapple-636562_960_720.jpg	\N	SouthAmerica
114	granulated sugar	https://upload.wikimedia.org/wikipedia/commons/a/a1/Raw_cane_sugar_light.JPG	Sucrose	Worldwide
115	half and half	https://upload.wikimedia.org/wikipedia/commons/c/c9/Berkeley_Farms_Fat-Free_Half_%26_Half.jpg	\N	Worldwide
116	egg white	https://upload.wikimedia.org/wikipedia/commons/9/9c/Bowl_of_egg_whites_no_bg.png	\N	Worldwide
117	almond	https://upload.wikimedia.org/wikipedia/commons/4/46/Almonds_macro_3.jpg	Prunus dulcis	Asia
118	chipotle peppers in adobo sauce	http://www.finecooking.com/CMS/uploadedImages/Images/Cooking/Articles/Issues_81-90/fc82kt080-03_xlg.jpg	\N	NorthAmerica
119	canned green chili peppers	https://upload.wikimedia.org/wikipedia/commons/4/4c/Starr_070730-7846_Capsicum_annuum.jpg	\N	NorthAmerica
120	bird's eye chili	https://upload.wikimedia.org/wikipedia/commons/3/35/Phrik_khi_nu.jpg	Capsicum annuum	Asia
121	curry paste	https://upload.wikimedia.org/wikipedia/commons/f/fe/Curry_pastes_Thailand.JPG	\N	Asia
122	cayenne pepper	http://www.dekookbijbel.be/images/ingredienten/Pepers/cayenne.jpg	Capsicum frutescens or Capsicum annuum	NorthAmerica
123	sweet onion	https://upload.wikimedia.org/wikipedia/commons/2/25/Sweet_onions_1.jpg	Allium cepa	NorthAmerica
124	barbecue sauce	https://upload.wikimedia.org/wikipedia/commons/1/1f/Barbecue_sauce.JPG	\N	NorthAmerica
125	tamari	https://upload.wikimedia.org/wikipedia/commons/8/88/Tamari.jpg	\N	Asia
126	sour cream	https://upload.wikimedia.org/wikipedia/commons/2/2a/Sour_cream.jpg	\N	Europe
127	low-fat sour cream	https://upload.wikimedia.org/wikipedia/commons/2/2a/Sour_cream.jpg	\N	Europe
128	red potato	https://c1.staticflickr.com/3/2454/3724216864_8362537f09.jpg	Solanum tuberosum	SouthAmerica
129	Russet potato	https://upload.wikimedia.org/wikipedia/commons/4/47/Russet_potato_cultivar_with_sprouts.jpg	Solanum tuberosum	SouthAmerica
130	apple	https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg	Malus domestica	Europe
131	Granny Smith apple	https://upload.wikimedia.org/wikipedia/commons/d/d7/Granny_smith_and_cross_section.jpg	Malus domestica	Oceania
132	hot sauce	https://c2.staticflickr.com/4/3897/14992505446_08fb54e0a1_b.jpg	\N	NorthAmerica
133	Tabasco sauce	https://upload.wikimedia.org/wikipedia/commons/d/d2/Tabasco-varieties.jpg	\N	NorthAmerica
134	vanilla extract	https://upload.wikimedia.org/wikipedia/commons/7/71/Madagascar_bourbon_vanilla_x.jpg	Vanilla planifolia	NorthAmerica
135	jalapeno	https://upload.wikimedia.org/wikipedia/commons/d/d6/Immature_jalapeno_capsicum_annuum_var_annuum.jpeg	Capsicum anuum	NorthAmerica
136	cremini mushroom	https://pixabay.com/static/uploads/photo/2015/05/07/12/40/mushrooms-756406_960_720.jpg	Agaricus bisporus	Europe
137	Worcestershire sauce	https://upload.wikimedia.org/wikipedia/commons/d/d9/Lea_%26_Perrins_worcestershire_sauce_150ml.jpg	\N	Europe
138	lime	https://upload.wikimedia.org/wikipedia/commons/6/68/Lime-Whole-Split.jpg	Citrus latifolia	Asia
139	lime juice	https://upload.wikimedia.org/wikipedia/commons/6/68/Lime-Whole-Split.jpg	Citrus latifolia	Asia
140	grapeseed oil	https://upload.wikimedia.org/wikipedia/commons/2/2a/Grapeseed-oil.jpg	Vitis vinifera	Europe
141	ginger	https://pixabay.com/static/uploads/photo/2014/07/11/14/41/ginger-389906_960_720.jpg	Zingiber officinale	Asia
142	ground ginger	https://upload.wikimedia.org/wikipedia/commons/c/c4/Ginger_powder.JPG	Zingiber officinale	Asia
143	garlic powder	https://upload.wikimedia.org/wikipedia/commons/e/ef/Garlic_Powder%2C_Penzeys_Spices%2C_Arlington_Heights_MA.jpg	Allium sativum	Asia
144	sage	https://pixabay.com/static/uploads/photo/2013/01/08/01/23/sage-74325_960_720.jpg	Salvia officinalis	Europe
145	lemon	https://upload.wikimedia.org/wikipedia/commons/c/c7/Lemon-Whole-Split.jpg	Citrus limon	Asia
146	lemon zest	https://upload.wikimedia.org/wikipedia/commons/7/77/Baking_%289682271210%29.jpg	Citrus limon	Asia
147	salt pork	https://upload.wikimedia.org/wikipedia/en/9/92/Streakolean.jpg	\N	NorthAmerica
148	napa cabbage	https://upload.wikimedia.org/wikipedia/commons/d/d9/NAPA_cabbage_at_Asian_supermarket_in_New_Jersey.jpg	Brassica rapa subsp. pekinensis	Europe
149	red cabbage	https://upload.wikimedia.org/wikipedia/commons/9/98/Rotkohl_%28Brassica_oleracea_convar%29.JPG	Brassica oleracea (Capitata Group)	Europe
150	savoy cabbage	https://upload.wikimedia.org/wikipedia/commons/a/a8/Wirsingkohl.jpg	Brassica oleracea (Capitata Group)	Europe
151	bok choy	https://upload.wikimedia.org/wikipedia/commons/e/e3/Baby_Pak_Choi_%2801%29.JPG	Brassica rapa (Chinensis Group)	Europe
152	mint	https://upload.wikimedia.org/wikipedia/commons/a/a1/FreshMint.jpg	Mentha spicata	Europe
153	dried mint	https://upload.wikimedia.org/wikipedia/commons/a/a1/FreshMint.jpg	Mentha spicata	Europe
154	sweet potato	https://upload.wikimedia.org/wikipedia/commons/3/38/5aday_sweet_potato.jpg	Ipomoea batatas	SouthAmerica
155	yam	https://upload.wikimedia.org/wikipedia/commons/e/eb/YamsatBrixtonMarket.jpg	Dioscorea spp.	Africa
156	butterhead lettuce	https://upload.wikimedia.org/wikipedia/commons/4/42/Lettuce_%284988502260%29.jpg	Lactuca sativa var. capitata	Africa
157	romaine lettuce	https://upload.wikimedia.org/wikipedia/commons/4/41/Romaine.jpg	Lactuca sativa var. logifolia	Africa
158	iceberg lettuce	https://upload.wikimedia.org/wikipedia/commons/d/da/Iceberg_lettuce_in_SB.jpg	Lactuca sativa var. capitata	Africa
159	harissa	https://upload.wikimedia.org/wikipedia/commons/8/86/Harissa-1.jpg	\N	Africa
160	serrano pepper	https://upload.wikimedia.org/wikipedia/commons/1/15/Serranochilis.jpg	Capsicum anuum	NorthAmerica
161	Greek yogurt	https://upload.wikimedia.org/wikipedia/commons/e/ea/Turkish_strained_yogurt.jpg	\N	Europe
162	turmeric	https://upload.wikimedia.org/wikipedia/commons/5/5b/Curcuma_longa_roots.jpg	Curcuma longa L.	Asia
163	fish sauce	https://upload.wikimedia.org/wikipedia/commons/7/70/Thaifishsauce0609.jpg	\N	Asia
164	spinach	https://upload.wikimedia.org/wikipedia/commons/f/fe/Spinach_leaves.jpg	Spinacia oleracea	Asia
165	frozen spinach	https://pixabay.com/static/uploads/photo/2013/07/18/14/53/spinach-163955_960_720.jpg	Spinacia oleracea	Asia
166	onion powder	https://upload.wikimedia.org/wikipedia/en/3/36/Onion_Powder,_Penzeys_Spices,_Arlington_Heights_MA.jpg	Allium cepa	Worldwide
167	pasilla	https://upload.wikimedia.org/wikipedia/commons/d/d5/Pasillachiles.jpg	Capsicum anuum	NorthAmerica
168	cheddar cheese	https://upload.wikimedia.org/wikipedia/commons/1/18/Somerset-Cheddar.jpg	\N	Europe
169	green bean	https://pixabay.com/static/uploads/photo/2014/11/06/17/31/green-beans-519439_960_720.jpg	Phaseolus vulgaris	NorthAmerica
170	canned peas	https://c1.staticflickr.com/3/2683/4029677448_b93f825613_b.jpg	\N	Europe
171	barbecued chicken breast	https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Chicken_BBQ.jpg/1024px-Chicken_BBQ.jpg	Gallus gallus	Worldwide
172	mozzarella cheese	https://upload.wikimedia.org/wikipedia/commons/5/50/Mozzarella_cheese.jpg	\N	Europe
173	salted butter	https://upload.wikimedia.org/wikipedia/commons/f/fd/Western-pack-butter.jpg	\N	Worldwide
174	long-grain rice	https://upload.wikimedia.org/wikipedia/commons/c/c9/Frozen_rice_-_jules.jpg	\N	Asia
175	medium-grain rice	https://upload.wikimedia.org/wikipedia/commons/9/9b/Botan_Calrose_rice_2.jpg	\N	Asia
176	short-grain rice	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Arborio_Rice_%283769693295%29.jpg/1280px-Arborio_Rice_%283769693295%29.jpg	\N	Asia
177	brown rice	https://c2.staticflickr.com/4/3159/2889140143_b99fd8dd4c_z.jpg?zz=1	Oryza sativa L.	Asia
178	cornmeal	https://upload.wikimedia.org/wikipedia/en/5/58/Breading.jpg	Zea mays	NorthAmerica
179	catfish	https://upload.wikimedia.org/wikipedia/commons/0/0e/Fisch_im_Restaurant.jpg	Ictalurus punctatus (Rafinesque)	Worldwide
180	molasses	https://upload.wikimedia.org/wikipedia/commons/9/9f/Bottle_of_Molasses.jpg	\N	Worldwide
181	bread crumbs	https://upload.wikimedia.org/wikipedia/commons/e/e1/Breadcrumb.jpg	\N	Worldwide
182	soft bread crumbs	http://photo.torange.biz/26/26982/HD26982.jpg	\N	Worldwide
183	parmesan cheese	https://upload.wikimedia.org/wikipedia/commons/5/5b/Parmigiano_reggiano_piece.jpg	\N	Europe
184	oxtail	https://upload.wikimedia.org/wikipedia/commons/9/94/Raw_oxtail-01.jpg	\N	Worldwide
185	garam masala	https://upload.wikimedia.org/wikipedia/commons/5/58/Garammasalaphoto.jpg	\N	Asia
186	cardamom	https://upload.wikimedia.org/wikipedia/commons/6/68/Black_and_green_cardamom.jpg	Elettaria cardamomum	Asia
187	rice noodles	https://upload.wikimedia.org/wikipedia/commons/f/f2/Reisnudeln.JPG	\N	Asia
188	cooked rice	https://upload.wikimedia.org/wikipedia/commons/7/77/Steamed_rice_in_bowl_01.jpg	\N	Worldwide
189	hoagie roll	https://upload.wikimedia.org/wikipedia/commons/8/89/Fresh_hoagie_rolls_%286189590468%29.jpg	\N	Worldwide
191	orange	https://upload.wikimedia.org/wikipedia/commons/7/7b/Orange-Whole-%26-Split.jpg	Citrus sinensis	Asia
192	navel orange	https://upload.wikimedia.org/wikipedia/commons/7/7f/Navel_orange_sectioned.jpg	Citrus sinensis	NorthAmerica
193	orange juice	https://upload.wikimedia.org/wikipedia/commons/5/5a/Oranges_and_orange_juice.jpg	Citrus sinensis	NorthAmerica
194	tamarind	https://upload.wikimedia.org/wikipedia/commons/c/c1/Tamarind2.jpg	Tamarindus indica	Africa
196	yeast	https://upload.wikimedia.org/wikipedia/commons/9/90/Dry_yeast.jpg	Saccharomyces cerevisiae	Worldwide
197	cream of tartar	https://upload.wikimedia.org/wikipedia/commons/8/84/Potassium_hydrogen_tartrate_%281%29.JPG	Potassium bitartrate	Worldwide
198	compressed yeast	https://upload.wikimedia.org/wikipedia/commons/e/e9/Compressed_fresh_yeast_-_1.jpg	Saccharomyces cerevisiae	Worldwide
199	brioche	https://upload.wikimedia.org/wikipedia/commons/4/4a/Brioche.jpg	\N	Europe
200	clam	https://upload.wikimedia.org/wikipedia/commons/8/8f/Clams.JPG	Bivalvia	Worldwide
201	canned clams	https://upload.wikimedia.org/wikipedia/commons/8/8f/Clams.JPG	Bivalvia	Worldwide
202	canned pumpkin	https://upload.wikimedia.org/wikipedia/commons/1/12/One-pie_pumpkin.jpg	Cucurbita pepo	NorthAmerica
203	mussel	https://upload.wikimedia.org/wikipedia/commons/4/45/CornishMussels.JPG	Mytilus edulis L.	Worldwide
204	octopus	https://upload.wikimedia.org/wikipedia/commons/4/44/Korean.cuisine-Sannakji.hoe-01.jpg	Octopus vulgaris Lamarck	Worldwide
205	oyster	https://upload.wikimedia.org/wikipedia/commons/3/37/Oysters_p1040741.jpg	Crassostrea virginica (Gmelin)	Worldwide
206	canned oysters	https://upload.wikimedia.org/wikipedia/commons/3/37/Oysters_p1040741.jpg	Crassostrea virginica (Gmelin)	Worldwide
207	biscuit mix	https://upload.wikimedia.org/wikipedia/commons/d/de/Bisquick_biscuits_%285062690206%29.jpg	\N	NorthAmerica
208	pita bread	https://upload.wikimedia.org/wikipedia/commons/2/23/Nablus_souq_pita_118_-_Aug_2011.jpg	\N	Asia
209	bulgur	https://upload.wikimedia.org/wikipedia/commons/8/8a/Bulgur2.jpg	Triticum spp.	Asia
210	cake flour	https://c1.staticflickr.com/1/28/225792129_6c456298a9_b.jpg	\N	Worldwide
211	dark rye flour	https://upload.wikimedia.org/wikipedia/commons/c/c1/Lithuanian_traditional_bread.jpg	Secale cereale	Worldwide
212	rice flour	https://upload.wikimedia.org/wikipedia/en/c/cb/Mochiko.jpg	Oryza spp.	Asia
213	brown rice flour	https://c2.staticflickr.com/8/7024/6497652507_4e31c7a595_b.jpg	Oryza spp.	Asia
214	oat flour	https://pixabay.com/static/uploads/photo/2015/03/31/16/52/oats-701299_960_720.jpg	Avena sativa	Europe
215	sun-dried tomato	https://upload.wikimedia.org/wikipedia/commons/c/cf/Sun-dried_tomatoes.jpg	Solanum lycopersicum	NorthAmerica
216	dill weed	https://pixabay.com/static/uploads/photo/2013/03/01/18/05/branch-87433_960_720.jpg	Anethum graveolens	Europe
217	dried dill weed	https://upload.wikimedia.org/wikipedia/commons/0/02/Dill-spice.jpg	Anethum graveolens	Europe
218	dill seed	https://upload.wikimedia.org/wikipedia/commons/d/d6/Dill_seed.JPG	Anethum graveolens	Europe
219	whole-wheat pita bread	https://upload.wikimedia.org/wikipedia/commons/2/23/Nablus_souq_pita_118_-_Aug_2011.jpg	\N	Asia
220	corn flour	https://c2.staticflickr.com/4/3296/3132083414_8193ddd6f8_z.jpg?zz=1	Zea mays	NorthAmerica
221	Italian bread	https://upload.wikimedia.org/wikipedia/commons/b/b2/Ciabatta_cut.JPG	\N	Europe
222	baguette	https://upload.wikimedia.org/wikipedia/commons/f/f5/Baguettes_-_stonesoup.jpg	\N	Europe
223	coriander seed	https://upload.wikimedia.org/wikipedia/commons/e/e3/Coriander.png	Coriandrum sativum	Worldwide
224	baking soda	https://pixabay.com/static/uploads/photo/2015/05/15/17/16/baking-soda-768950_960_720.jpg	Sodium bicarbonate	NorthAmerica
225	bay leaf	https://upload.wikimedia.org/wikipedia/commons/3/37/Indian_bay_leaf_-_tejpatta_-_indisches_Lorbeerblatt.jpg	Laurus nobilis	Europe
226	margarine	https://upload.wikimedia.org/wikipedia/commons/2/2d/Margarine_BMK.jpg	\N	Europe
227	tomato puree	https://upload.wikimedia.org/wikipedia/commons/9/94/Tomato_passata.jpg	\N	Europe
228	cracked pepper	http://www.publicdomainpictures.net/pictures/30000/nahled/cracked-black-peppercorns.jpg	Piper nigrum	\N
229	powdered sugar	https://upload.wikimedia.org/wikipedia/commons/0/0c/PowderedSugar.png	\N	Worldwide
230	semisweet chocolate chips	https://upload.wikimedia.org/wikipedia/commons/9/96/Semi-sweet_chocolate_chips.jpg	\N	NorthAmerica
231	white chocolate	https://pixabay.com/static/uploads/photo/2014/06/30/20/05/white-chocolate-380702_960_720.jpg	\N	Europe
232	tarragon	https://upload.wikimedia.org/wikipedia/commons/c/c1/Dried_Taragon.JPG	Artemisia dracunculus	Europe
233	zucchini	https://upload.wikimedia.org/wikipedia/commons/7/7c/Zucchini-Whole.jpg	Cucurbita pepo	Europe
234	summer squash	https://upload.wikimedia.org/wikipedia/commons/0/0a/CSA-Yellow-Squash.jpg	Cucurbita spp.	NorthAmerica
235	acorn squash	https://upload.wikimedia.org/wikipedia/commons/2/28/Acornsquash.jpg	Cucurbita maxima	NorthAmerica
236	winter squash	https://upload.wikimedia.org/wikipedia/commons/b/bd/Squashes.jpg	Cucurbita spp.	NorthAmerica
237	cucumber	https://upload.wikimedia.org/wikipedia/commons/a/a3/Cucumber_BNC.jpg	Cucumis sativus	Asia
238	eggplant	https://upload.wikimedia.org/wikipedia/commons/f/f9/Three_Types_of_Eggplant.jpg	Solanum melongena	Asia
239	broccoli	https://upload.wikimedia.org/wikipedia/commons/0/03/Broccoli_and_cross_section_edit.jpg	Brassica oleracea var. italica	Europe
240	broccoli raab	https://upload.wikimedia.org/wikipedia/commons/7/76/Rapini.jpg	Brassica ruvo	Europe
241	avocado	https://upload.wikimedia.org/wikipedia/commons/5/5d/Avocado_with_cross_section_edit.jpg	Persea americana	NorthAmerica
242	yellow corn	https://upload.wikimedia.org/wikipedia/commons/7/79/VegCorn.jpg	Zea mays	NorthAmerica
243	canned yellow corn	https://pixabay.com/static/uploads/photo/2014/11/24/23/00/corn-544720_960_720.jpg	Zea mays	NorthAmerica
244	frozen yellow corn	https://upload.wikimedia.org/wikipedia/commons/e/e1/Sweet_Corns.jpg	Zea mays	NorthAmerica
245	white hominy	https://upload.wikimedia.org/wikipedia/commons/6/6a/Hominy_%28maize%29.JPG	Zea mays	NorthAmerica
246	canned black-eyed peas	https://c2.staticflickr.com/4/3281/2801477663_06bf3c7199.jpg	Vigna unguiculata subsp. unguiculata	Africa
247	canned cannellini beans	https://upload.wikimedia.org/wikipedia/commons/5/5f/White_beans.jpg	\N	Europe
248	canned kidney beans	https://c1.staticflickr.com/7/6025/6018279017_cb7b30726f_b.jpg	\N	NorthAmerica
249	red kidney bean	https://upload.wikimedia.org/wikipedia/commons/2/27/Red_Rajma_BNC.jpg	Phaseolus vulgaris	NorthAmerica
250	celery	https://upload.wikimedia.org/wikipedia/commons/4/44/C%C3%A9leri.jpg	Apium graveolens	Europe
251	asparagus	https://upload.wikimedia.org/wikipedia/commons/3/3d/Asparagus-Bundle.jpg	Asparagus officinalis	Worldwide
252	tofu	https://upload.wikimedia.org/wikipedia/commons/3/31/Dong_Dou_Fu_%28tofu%29.jpg	Glycine max	Asia
253	corn oil	https://upload.wikimedia.org/wikipedia/commons/1/1f/Corn_oil_%28mais%29.jpg	Zea mays	NorthAmerica
254	peanut oil	https://upload.wikimedia.org/wikipedia/commons/1/16/Peanut_oil_bottle.jpg	Arachis hypogaea	Asia
255	sunflower oil	\N	Helianthus annuus	\N
256	safflower oil	\N	\N	\N
257	coconut oil	\N	\N	\N
258	mustard oil	\N	\N	\N
259	shortening	\N	\N	\N
260	ground turkey	https://upload.wikimedia.org/wikipedia/commons/c/c4/Ground_turkey_%284515834437%29.jpg	Meleagris gallopavo	NorthAmerica
261	shallot	https://upload.wikimedia.org/wikipedia/commons/5/53/Shallots-Whole.jpg	Allium ascalonicum	Asia
262	mango	https://upload.wikimedia.org/wikipedia/commons/7/79/Alphonso_mango.jpg	Mangifera indica	Asia
263	saffron	\N	Crocus sativus	\N
264	kiwifruit	https://upload.wikimedia.org/wikipedia/commons/5/59/Kiwi1.1.jpg	Actinidia deliciosa	Oceania
265	kale	\N	Brassica oleracea (Acephala Group)	Europe
266	kai-lan	\N	 Brassica oleracea var. alboglabra	Asia
267	frozen kale	\N	\N	\N
268	low-sodium soy sauce	https://upload.wikimedia.org/wikipedia/commons/c/c7/Kikkoman_Soy_Sauce,_Front-view_jp-type_,.jpg	\N	Asia
269	salsa	\N	\N	NorthAmerica
270	salsa verde	\N	\N	NorthAmerica
271	chicken broth	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
272	beef broth	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
273	low-sodium chicken broth	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
274	low-sodium beef broth	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
275	chicken stock	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
276	beef stock	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
277	fish stock	https://upload.wikimedia.org/wikipedia/commons/0/08/Bruehe-2.jpg	\N	Worldwide
278	chicken bouillon	https://upload.wikimedia.org/wikipedia/commons/f/f5/Br%C3%BChw%C3%BCrfel-1.jpg	\N	Worldwide
279	beef bouillon	https://upload.wikimedia.org/wikipedia/commons/f/f5/Br%C3%BChw%C3%BCrfel-1.jpg	\N	Worldwide
280	salt and pepper	https://c1.staticflickr.com/5/4002/4572668303_280b2d7868_b.jpg	\N	Worldwide
281	mayonnaise	\N	\N	\N
282	ketchup	\N	\N	\N
283	mustard	\N	\N	\N
284	mustard seed	\N	Sinapis alba and Brassica juncea	\N
285	fennel	\N	Foeniculum vulgare	\N
286	fennel seed	\N	Foeniculum vulgare	\N
287	honey mustard	\N	\N	\N
288	clarified butter	https://upload.wikimedia.org/wikipedia/commons/4/43/Butterschmalz-2.jpg	\N	Worldwide
289	ground lamb	\N	Ovis aries	\N
290	clove	https://upload.wikimedia.org/wikipedia/commons/4/4b/ClovesDried.jpg	Syzygium aromaticum	Asia
291	lean ground beef	\N	Bos taurus	\N
292	ground chicken	\N	Gallus gallus	\N
293	ground pork	\N	\N	\N
294	lean ground pork	\N	\N	\N
295	poppy seed	https://upload.wikimedia.org/wikipedia/commons/6/69/Poppy_seeds.jpg	Papaver somniferum	Europe
296	beef chuck	https://upload.wikimedia.org/wikipedia/commons/4/45/Chuck_steaks.jpg	Bos taurus	\N
297	rice vinegar	https://upload.wikimedia.org/wikipedia/commons/d/db/Korean_Rice_Vinegar.jpg	\N	Asia
298	vanilla pudding mix	\N	\N	\N
299	lemon pudding mix	\N	\N	\N
300	hummus	\N	\N	\N
301	tahini	\N	\N	\N
302	baby corn	https://pixabay.com/static/uploads/photo/2014/07/11/17/27/baby-corn-390075_960_720.jpg	Zea mays	Asia
303	light corn syrup	\N	\N	\N
304	cane syrup	\N	\N	\N
305	agave nectar	\N	\N	\N
306	strawberry	\N	Fragaria X ananassa	\N
307	raspberry	\N	Rubus spp.	\N
308	blueberry	\N	Vaccinium spp.	\N
309	frozen raspberries	\N	\N	\N
310	light whipping cream	\N	\N	\N
311	heavy whipping cream	\N	\N	\N
312	whipped cream	https://upload.wikimedia.org/wikipedia/commons/1/16/Cr%C3%A8me_Chantilly.jpg	\N	\N
313	frozen whipped topping	https://c1.staticflickr.com/8/7529/16042518496_9e85ede4ed_b.jpg	\N	\N
314	chorizo	\N	\N	\N
315	potato flakes	\N	\N	\N
316	marinara sauce	\N	\N	Europe
317	rum	\N	\N	\N
318	cooking wine	\N	\N	\N
319	red wine	\N	\N	\N
320	white wine	\N	\N	\N
321	raisin	\N	Vitis vinifera	\N
322	golden raisin	\N	Vitis vinifera	\N
323	anise seed	\N	Pimpinella anisum	\N
324	yucca	\N	Manihot esculenta	\N
325	caraway seed	\N	Carum carvi	\N
326	lotus root	\N	Nelumbo nucifera	\N
327	ricotta cheese	\N	\N	\N
328	low-fat ricotta cheese	\N	\N	\N
329	Romano cheese	\N	\N	\N
330	feta cheese	\N	\N	\N
331	low-fat cheddar cheese	\N	\N	\N
332	sharp cheddar cheese	\N	\N	\N
333	marjoram	\N	Origanum majorana	\N
334	monterey jack cheese	\N	\N	\N
335	low-fat mozzarella cheese	\N	\N	\N
336	lime zest	\N	Citrus latifolia	\N
337	sweetened condensed milk	\N	\N	\N
338	evaporated milk	\N	\N	\N
339	low-fat Swiss cheese	https://upload.wikimedia.org/wikipedia/commons/8/89/Swiss_cheese_cubes.jpg	\N	\N
340	graham cracker	https://upload.wikimedia.org/wikipedia/commons/8/87/Graham-Cracker-Stack.jpg	\N	NorthAmerica
341	Gruyere cheese	https://upload.wikimedia.org/wikipedia/commons/f/fa/Gruy%C3%A8re.jpg	\N	Europe
342	Brie cheese	https://upload.wikimedia.org/wikipedia/commons/8/88/Brie_01.jpg	\N	Europe
343	blue cheese	\N	\N	\N
344	goat cheese	\N	\N	\N
345	Velveeta cheese	\N	\N	\N
346	skim milk	\N	\N	\N
347	almond milk	\N	\N	\N
348	buttermilk	\N	\N	\N
349	low-fat buttermilk	\N	\N	\N
350	coconut milk	https://upload.wikimedia.org/wikipedia/commons/9/92/Cocomilkjf.JPG	Cocos nucifera	Worldwide
351	chocolate milk	https://upload.wikimedia.org/wikipedia/commons/7/7d/New_chocolate_milk.JPG	\N	\N
352	lemongrass	https://upload.wikimedia.org/wikipedia/commons/b/bd/YosriNov04Pokok_Serai.JPG	Collinsonia canadensis	Asia
353	chicken breast	\N	Gallus gallus	\N
354	skinless boneless chicken breast	\N	Gallus gallus	\N
355	skinless chicken thigh	\N	Gallus gallus	\N
356	chicken sausage	\N	Gallus gallus	\N
357	apple juice	\N	\N	\N
358	quinoa	https://upload.wikimedia.org/wikipedia/commons/4/43/Red_quinoa.png	Chenopodium quinoa Willd.	SouthAmerica
359	rutabaga	\N	Brassica napus var. napobrassica	\N
360	arrowroot	\N	Maranta arundinacea	\N
361	parsnip	\N	Pastinaca sativa	\N
362	raw chicken	https://c1.staticflickr.com/5/4010/4688558649_0feab91c63_b.jpg	Gallus gallus	Worldwide
363	cooked chicken	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cooked_chicken_strips.JPG/1280px-Cooked_chicken_strips.JPG	Gallus gallus	Worldwide
364	orzo	https://upload.wikimedia.org/wikipedia/commons/6/61/EMS-108038-Orzo-rule.JPG	\N	Europe
365	spaghetti	\N	\N	Europe
366	whole-wheat pasta	https://c2.staticflickr.com/4/3451/3185661603_ccfae65578_b.jpg	\N	Europe
367	chicken drumstick	\N	Gallus gallus	Worldwide
368	rotisserie chicken	\N	Gallus gallus	Worldwide
369	cooked chicken breast	\N	Gallus gallus	Worldwide
370	skinless chicken drumstick	\N	Gallus gallus	Worldwide
371	okra	\N	Abelmoschus esculentus	\N
372	chicken thigh	\N	Gallus gallus	Worldwide
373	cherry tomato	https://upload.wikimedia.org/wikipedia/commons/1/10/Tomates_cerises_Luc_Viatour.jpg	Solanum lycopersicum	NorthAmerica
374	grape tomato	https://upload.wikimedia.org/wikipedia/commons/f/f1/Grape_tomatoes_on_the_vine.JPG	Solanum lycopersicum	Asia
375	plum tomato	https://upload.wikimedia.org/wikipedia/commons/b/b4/Plum_Tomatoes%2C_Lexington_MA.jpg	Solanum lycopersicum	Europe
376	skinless light chicken meat	\N	Gallus gallus	Worldwide
377	snapper	\N	Lutjanidae	\N
378	chicken wing	\N	Gallus gallus	\N
379	sorghum flour	\N	\N	\N
380	peanut	https://upload.wikimedia.org/wikipedia/commons/4/49/Peanuts_%281%29.jpg	Arachis hypogaea	\N
381	walnut	https://upload.wikimedia.org/wikipedia/commons/7/7f/Walnuts_by_RustedStrings.jpg	Juglans regia	\N
382	pecan	https://upload.wikimedia.org/wikipedia/commons/7/7a/Pecans-4352.jpg	Carya illinoinensis	\N
383	roasted peanut	\N	\N	\N
384	dry-roasted peanut	\N	\N	\N
385	collard greens	https://upload.wikimedia.org/wikipedia/commons/e/e9/Collard-Greens-Bundle.jpg	Brassica oleracea var. viridis	Europe
386	frozen artichoke hearts	\N	Cynara scolymus	\N
387	canned artichoke hearts	\N	Cynara scolymus	\N
388	artichoke	\N	Cynara scolymus	\N
389	littleneck clam	https://upload.wikimedia.org/wikipedia/commons/4/4b/Ruditapes_philippinarum.jpg	Venerupis philippinarum	Asia
390	caviar	\N	\N	Worldwide
391	raw salmon	\N	Oncorhynchus tshawytscha (Walbaum)	\N
392	canned salmon	\N	\N	\N
393	smoked salmon	\N	\N	\N
394	kielbasa	https://upload.wikimedia.org/wikipedia/commons/9/9a/Kielbasas.jpg	\N	Europe
395	water chestnut	https://upload.wikimedia.org/wikipedia/commons/b/ba/Wasserkastanie_2.jpg	Eleocharis dulcis	Asia
396	pork shoulder	\N	Sus scrofa domesticus	Worldwide
397	pork butt	\N	Sus scrofa domesticus	Worldwide
398	pork chop	\N	Sus scrofa domesticus	Worldwide
399	pork liver	\N	Sus scrofa domesticus	Worldwide
400	pork belly	\N	Sus scrofa domesticus	Worldwide
401	lean pork chop	\N	Sus scrofa domesticus	Worldwide
402	pork loin	\N	Sus scrofa domesticus	Worldwide
403	lean pork loin	\N	Sus scrofa domesticus	Worldwide
404	pork sparerib	\N	Sus scrofa domesticus	Worldwide
405	cooked lamb stew meat	\N	Ovis aries	Europe
406	lamb	\N	Ovis aries	Europe
407	lamb shoulder	\N	Ovis aries	Europe
408	lamb stew meat	\N	Ovis aries	Europe
409	lamb loin	\N	Ovis aries	Europe
410	goat	https://upload.wikimedia.org/wikipedia/commons/6/63/Goat_chops.jpg	Capra aegagrus hircus	Asia
411	hazelnut	\N	Corylus spp.	\N
412	squid	https://upload.wikimedia.org/wikipedia/commons/f/fb/Lipari-Calmars.jpg	Loligoidae and Ommastrephidae	Worldwide
413	cooked octopus	https://upload.wikimedia.org/wikipedia/commons/0/09/Octopuses_in_Tsukiji.JPG	Octopus vulgaris Lamarck	Worldwide
414	wasabi	\N	Wasabia japonica	\N
415	horseradish	\N	\N	\N
416	laver seaweed	\N	Porphyra laciniata	\N
417	stevia	https://upload.wikimedia.org/wikipedia/commons/9/9a/Stevia_plant.jpg	\N	SouthAmerica
418	wonton wrappers	\N	\N	Asia
419	egg noodles	\N	\N	\N
420	chow mein noodles	\N	\N	\N
421	cooked spaghetti	\N	\N	\N
422	cooked egg noodles	\N	\N	\N
423	soba noodles	\N	\N	\N
424	vermicelli	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Fideo_%28coiled_vermicelli%29.JPG/1280px-Fideo_%28coiled_vermicelli%29.JPG	\N	\N
425	ramen noodles	https://upload.wikimedia.org/wikipedia/commons/a/a8/Fresh_ramen_noodle_001.jpg	\N	Asia
426	udon noodles	https://upload.wikimedia.org/wikipedia/commons/9/97/Kakeudon.jpg	\N	Asia
427	cellophane noodles	\N	\N	\N
428	flour tortilla	\N	\N	\N
429	corn tortilla	\N	\N	\N
430	tortilla chips	\N	\N	\N
431	Brussels sprouts	\N	Brassica oleracea (Gemmifera Group)	\N
432	pine nut	\N	Pinus spp.	\N
433	low-fat yogurt	\N	\N	\N
434	fresh cream	https://upload.wikimedia.org/wikipedia/commons/6/6c/Strawberries_and_cr%C3%A8me_fra%C3%AEche.jpg	\N	Europe
435	dulce de leche	\N	\N	\N
436	almond butter	\N	\N	\N
437	oatmeal	https://upload.wikimedia.org/wikipedia/commons/3/39/Oatmeal.jpg	Avena sativa	Europe
438	turnip	\N	Brassica rapa (Rapifera Group)	\N
439	duck egg	\N	\N	\N
440	plum	\N	Prunus spp.	\N
441	pepperoni	\N	\N	\N
442	buckwheat flour	\N	\N	\N
443	andouille sausage	https://upload.wikimedia.org/wikipedia/commons/5/5a/Andouille.jpg	\N	Europe
444	puff pastry	https://upload.wikimedia.org/wikipedia/commons/9/90/Pate_feuilletee_2.jpg	\N	Europe
445	phyllo dough	https://upload.wikimedia.org/wikipedia/commons/9/9e/Baklava.jpg	\N	Asia
446	pie crust	\N	\N	\N
447	beef brisket	https://pixabay.com/static/uploads/photo/2016/03/05/19/42/beef-1238479_960_720.jpg	Bos taurus	\N
448	corned beef brisket	https://upload.wikimedia.org/wikipedia/commons/7/7b/Cooked_corned_beef.JPG	Bos taurus	\N
449	self-rising flour	https://upload.wikimedia.org/wikipedia/commons/0/09/Flours.jpg	\N	Worldwide
450	pate	https://upload.wikimedia.org/wikipedia/commons/3/37/Foie_gras_IMGP2356.jpg	\N	\N
451	slivered almonds	https://c1.staticflickr.com/5/4035/4364750275_ef4ae80661_b.jpg	\N	\N
452	flank steak	https://upload.wikimedia.org/wikipedia/commons/6/64/Flank_Steak_piece_of_meat.jpg	Bos taurus	\N
453	beef sirloin	https://upload.wikimedia.org/wikipedia/commons/5/56/Faux-filet.jpg	Bos taurus	\N
454	galangal	https://upload.wikimedia.org/wikipedia/commons/e/e4/Lesser_galangal_Kencur_Luc_Viatour.jpg	Zingiberaceae family	Asia
455	beef tenderloin	https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Eye_Fillet,_Grass-Fed_Beef.jpg/1280px-Eye_Fillet,_Grass-Fed_Beef.jpg	Bos taurus	\N
456	Creole seasoning	https://c1.staticflickr.com/5/4074/4827885241_799d70583b_z.jpg	\N	NorthAmerica
457	Italian seasoning	https://upload.wikimedia.org/wikipedia/commons/3/33/Italian_Herb_Mix,_Penzeys_Spices,_Arlington_Heights_MA.jpg	\N	Europe
458	mirin	https://upload.wikimedia.org/wikipedia/commons/a/a1/Japanese_Mirin.JPG	\N	Asia
459	sauerkraut	https://upload.wikimedia.org/wikipedia/commons/b/b5/Kiszona_kapusta.JPG	\N	Europe
460	beer	https://farm5.staticflickr.com/4110/5200218267_2215c03778_o.jpg	\N	Asia
461	miso	https://upload.wikimedia.org/wikipedia/commons/e/ed/Miso_paste_by_wilbanks_in_Nishiki_Ichiba%2C_Kyoto.jpg	\N	Asia
462	five-spice powder	https://upload.wikimedia.org/wikipedia/commons/b/b3/Five_spice_powder.jpg	\N	Asia
463	vanilla bean	https://upload.wikimedia.org/wikipedia/commons/3/30/Vanilla_6beans.JPG	Vanilla planifolia	NorthAmerica
464	sausage	https://upload.wikimedia.org/wikipedia/commons/8/8b/Kielbasa7.jpg	\N	Worldwide
465	sausage casing	https://upload.wikimedia.org/wikipedia/commons/3/31/Casing1.JPG	\N	Asia
466	Kalamata olive	https://upload.wikimedia.org/wikipedia/commons/6/64/Olives_in_bowl.jpg	Olea europaea	Europe
467	oyster sauce	https://upload.wikimedia.org/wikipedia/commons/7/78/OysterSauce2.jpg	\N	Asia
468	olive	https://upload.wikimedia.org/wikipedia/commons/0/09/Olives_au_marche_de_Toulon_p1040238.jpg	Olea europaea	Asia
469	amaretto	https://upload.wikimedia.org/wikipedia/commons/8/8b/Amaretto_Bottles_4.JPG	\N	Europe
470	almond extract	https://upload.wikimedia.org/wikipedia/commons/9/95/Almond_Nuts.jpg	Prunus dulcis	Asia
471	tzatziki	https://upload.wikimedia.org/wikipedia/commons/7/76/Greek_yoghurt_cucumbers_garlic.jpg	\N	Europe
472	bulgogi sauce	https://upload.wikimedia.org/wikipedia/commons/7/73/Korean.food-Bulgogi-02.jpg	\N	Asia
473	cherry	https://upload.wikimedia.org/wikipedia/commons/c/c7/Italienische_S%C3%BC%C3%9Fkirschen.JPG	Prunus avium	Europe
474	Anaheim pepper	https://upload.wikimedia.org/wikipedia/commons/4/40/New_Mexico_green_chile.jpg	Capsicum anuum	NorthAmerica
475	peach	\N	Prunus persica	\N
476	orange zest	\N	Citrus sinensis	\N
477	applesauce	\N	\N	\N
478	kombu	https://upload.wikimedia.org/wikipedia/commons/1/10/Kombu.jpg	Laminaria spp.	Asia
479	shredded coconut	https://c2.staticflickr.com/2/1282/4689571459_fd6db8e913_b.jpg	Cocos nucifera	Worldwide
480	paneer	https://upload.wikimedia.org/wikipedia/commons/3/36/Panir_Paneer_Indian_cheese_fresh.jpg	\N	Asia
481	kimchi	https://upload.wikimedia.org/wikipedia/commons/a/a3/Gimchi.jpg	\N	Asia
482	garlic salt	\N	\N	\N
483	Nutella	https://upload.wikimedia.org/wikipedia/commons/9/9b/Nutella_ak.jpg	\N	Europe
484	Old Bay Seasoning	https://upload.wikimedia.org/wikipedia/commons/4/4f/Old_Bay_Seasoning.jpg	\N	NorthAmerica
485	tomatillo	\N	Physalis philadelphica	\N
486	whiskey	https://upload.wikimedia.org/wikipedia/commons/8/8f/Irish_Whiskey2.jpg	\N	Europe
487	Baileys Irish Cream	https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Baileys_with_Baileys_Rock.JPG/576px-Baileys_with_Baileys_Rock.JPG	\N	Europe
488	dry custard	https://upload.wikimedia.org/wikipedia/commons/7/7d/Bird's-Custard.jpg	\N	Europe
489	round steak	https://upload.wikimedia.org/wikipedia/commons/9/9e/Beef_round_top_round_steak_in_pan,_raw.jpg	Bos taurus	Worldwide
490	taro	https://upload.wikimedia.org/wikipedia/commons/c/c2/Colocasia_esculenta_dsc07801.jpg	Colocasia esculenta	Asia
491	jicama	\N	Pachyrhizus spp.	\N
492	tangerine	\N	Citrus reticulata	\N
493	rhubarb	\N	Rheum rhabarbarum	\N
494	xylitol	https://upload.wikimedia.org/wikipedia/commons/9/95/Xylitol_crystals.jpg	Xylitol	\N
495	corn husk	http://res.freestockphotos.biz/pictures/7/7801-close-up-of-a-dried-corn-husk-pv.jpg	Zea mays	NorthAmerica
496	crawfish	https://upload.wikimedia.org/wikipedia/commons/3/3b/Lots_of_crawfish.jpg	Astacus, Orconectes, and Procambarus spp.	NorthAmerica
497	blue crab	https://upload.wikimedia.org/wikipedia/commons/9/99/The_Childrens_Museum_of_Indianapolis_-_Atlantic_blue_crab.jpg	Callinectes sapidus Rathbun	NorthAmerica
498	grouper	https://upload.wikimedia.org/wikipedia/commons/2/29/Epinephelus_malabaricus.jpg	Epinephelus spp.	Worldwide
499	tilapia	https://upload.wikimedia.org/wikipedia/commons/b/b3/Oreochromis-niloticus-Nairobi.JPG	Tilapiini tribe	Africa
500	halibut	https://upload.wikimedia.org/wikipedia/commons/2/20/Pacific_Halibut.JPG	Hippoglossus hippoglossus (L.) and H. stenolepis Schmidt	NorthAmerica
501	hamburger bun	https://upload.wikimedia.org/wikipedia/commons/1/10/Sesame_seed_hamburger_buns.jpg	\N	NorthAmerica
502	rice paper	https://upload.wikimedia.org/wikipedia/commons/3/34/Rice_paper.jpg	\N	Asia
503	spring roll wrapper	https://upload.wikimedia.org/wikipedia/commons/0/03/Summer_roll.jpg	\N	Asia
504	skirt steak	https://upload.wikimedia.org/wikipedia/commons/2/2a/Skirt_Steak.jpg	Bos taurus	Worldwide
505	garlic paste	https://upload.wikimedia.org/wikipedia/commons/4/43/Roasted_Garlic_Paste.jpg	Allium sativum	Asia
506	file powder	https://upload.wikimedia.org/wikipedia/commons/5/58/Zherbes.jpg	Sassafras albidum	NorthAmerica
507	seasoned salt	https://upload.wikimedia.org/wikipedia/commons/0/04/Lawry's_Seasoned_Salt.jpg	\N	NorthAmerica
508	chili oil	https://upload.wikimedia.org/wikipedia/commons/b/b8/Chilioil.jpg	\N	Asia
509	lemon pepper	https://upload.wikimedia.org/wikipedia/commons/0/01/Lemon_pepper_-_Zitronenpfeffer.jpg	\N	Worldwide
510	vodka	https://upload.wikimedia.org/wikipedia/commons/c/c6/Wodkaflaschen.JPG	\N	Asia
511	dry sherry	https://upload.wikimedia.org/wikipedia/commons/f/f8/Del_Duque_Amontillado_Sherry.jpg	\N	Europe
512	brandy	https://upload.wikimedia.org/wikipedia/commons/9/9a/Cognac_glass.jpg	\N	Europe
513	dark chocolate	https://upload.wikimedia.org/wikipedia/commons/3/36/Schokolade-schwarz.jpg	Theobroma cacao	NorthAmerica
514	mixed greens	https://c1.staticflickr.com/9/8062/8196883582_745c9fcbfc_b.jpg	\N	Worldwide
\.


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 172
-- Name: Ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Ingredient_id_seq"', 515, TRUE);

--
-- TOC entry 2051 (class 0 OID 16717)
-- Dependencies: 178
-- Data for Name: IngredientsInRecipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "IngredientsInRecipes" (recipe_id, ingredient_id, original_string, amount, unit, unit_short, ingredient_index) FROM STDIN;
1	1	2 cups dried black-eyed peas	2.0	cups	c	0
1	2	2 cups sliced carrots	2.0	cups	c	1
1	3	1 cup green pepper, diced	1.0	cup	c	2
1	4	1 large chopped onion	1.0	cup	c	3
1	5	peanut butter	4.0	tablespoon	T	4
1	6	3/4 teaspoon salt	0.75	teaspoon	t	5
1	7	6 cups water	6.0	cups	c	6
2	0	1 tablespoon amchar masala	1.0	tablespoon	T	0
2	65	1 cup brown lentils	1.0	cup	c	1
2	68	1 can crushed tomatoes	1.0	can	can	2
2	69	1 cauliflower head, cut into bite size pieces	1.0	\N	\N	3
2	185	2 tablespoons masala molida, also known as berbere	2.0	tablespoons	T	4
2	23	2 garlic cloves, minced	2.0	cloves	cloves	5
2	4	1 onion, diced	1.0	\N	\N	6
2	38	2 cups frozen peas	2.0	cups	c	7
2	39	1/4 cup plain yogurt (optional)	0.25	cup	c	8
2	70	1 can tomato paste	1.0	can	can	9
2	71	2 tablespoons vegetable oil	2.0	tablespoons	T	10
3	37	14 ounces can chickpeas (garbanzo beans), drained and rinsed	14.0	ounces	oz	0
3	140	1 tablespoon grapeseed or canola oil	1.0	tablespoon	T	1
3	23	10 Cloves garlic, (3 tbsp.) minced	3.0	tbsp	T	2
3	159	2 tablespoons harissa	2.0	tablespoons	T	3
3	25	1 leek, finely chopped	1.0	\N	\N	4
3	18	A tablespoon of lemon juice	1.0	tablespoon	T	5
3	4	1 small Onion, minced	1.0	\N	\N	6
3	187	1 package fresh pasta or a large handful of rice noodles	1.0	package	pkg	7
3	164	1/2 package of fresh spinach leaves or 3 good handfuls	0.5	package	pkg	8
3	70	3 tablespoons tomato paste or ketchup (yep, ketchup works great!)	3.0	tablespoons	T	9
3	7	1 liter (4 cups) water, chicken broth, vegetable broth	4.0	cups	c	10
4	3	Bell Peppers for garnishing	1.0	serving	serving	0
4	362	1.5 Cups of Chopped Chicken	1.5	Cups	Cups	1
4	71	2.5 Cooking spoons of oil	2.5	tablespoons	T	2
4	80	1 teaspoon of Curry	1.0	teaspoon	t	3
4	23	2 garlic cloves	2.0	cloves	cloves	4
4	141	Small piece of Chopped ginger	1.0	piece	\N	5
4	4	2 handfuls of Chopped onions	2.0	handfuls	handfuls	6
4	58	Pepper	1.0	serving	serving	7
4	6	Salt	1.0	serving	serving	8
4	154	1/2 small sweet potato (Chopped)	0.5	\N	\N	9
4	85	Pinch of thyme	1.0	pinch	pinch	10
4	47	1 Chopped small tomato	1.0	\N	\N	11
4	79	1.5 cups of Blended tomato	1.5	cups	c	12
4	5	1 cup of groundnut (Blended) or peanut Butter	1.0	cup	c	13
5	225	2 Bay leaves	2.0	\N	\N	0
5	80	1 Teaspoon of curry powder	1.0	Teaspoon	Teaspoon	1
5	23	1 Clove of garlic	1.0	Clove	Clove	2
5	104	3 Cubes of Maggi	3.0	\N	\N	3
5	4	1 Small bulb of Onion	1.0	\N	\N	4
5	58	1 Teaspoon of dry pepper	1.0	Teaspoon	Teaspoon	5
5	174	2 Cups of Rice	2.0	Cups	Cups	6
5	47	7 Medium sized Roma Tomatoes	7.0	\N	\N	7
5	6	2 Teaspoons of Salt	2.0	Teaspoons	Teaspoons	8
5	107	3 Scotch Bonnet Peppers	3.0	\N	\N	9
5	85	A pinch of Thyme	1.0	pinch	pinch	10
5	227	1 Small can of Tomato puree	1.0	can	can	11
5	71	2 Cooking spoons of Vegetable Oil	2.0	tablespoons	T	12
5	7	3 Cups of water	3.0	Cups	Cups	13
6	80	1 teaspoon of curry	1.0	teaspoon	t	0
6	23	2 garlic cloves	2.0	cloves	cloves	1
6	141	1 teaspoon of grated ginger	1.0	teaspoon	t	2
6	104	Seasoning cubes	2.0	cubes	cubes	3
6	111	1/2 cup of chopped vegetables (optional)	0.5	cup	c	4
6	4	1 small onion (chopped)	1.0	\N	\N	5
6	112	1/2 cup of chopped pineapples	0.5	cup	c	6
6	174	1 cup of parboiled rice	1.0	cup	c	7
6	105	1/2 cup of stock juice	0.5	cup	c	8
6	85	1/4 teaspoon of thyme	0.25	teaspoon	t	9
6	70	2 tablespoons of tomato paste	2.0	tablespoons	T	10
6	79	1.5 cups of blended tomatoes	1.5	cups	c	11
6	3	bell pepper	1.0	\N	\N	12
6	107	scotch bonnet pepper	1.0	\N	\N	13
6	71	1.5 cooking spoons of vegetable oil	1.5	tablespoons	T	14
7	8	5 1/2 teaspoons baking powder	5.5	teaspoons	t	0
7	9	2 ripe but firm bananas, sliced thin	2.0	\N	\N	1
7	10	1/2 cup butter or margarine - (1/4 lb)	0.5	cup	c	2
7	11	4 t. canola (or vegetable) oil	4.0	t	t	3
7	12	1/2 t. cinnamon	0.5	t	t	4
7	13	8 ounces cream cheese	8.0	ounces	oz	5
7	14	3 eggs	3.0	\N	\N	6
7	15	10 1/2 cups all-purpose flour	10.5	cups	c	7
7	16	dash of fresh ground nutmeg	1.0	dash	dash	8
7	17	1 T. honey	1.0	T	T	9
7	18	1/2 t. lemon juice	0.5	t	t	10
7	19	maple syrup, for serving	4.0	servings	servings	11
7	20	1 c. milk	1.0	c	c	12
7	6	1/2 teaspoon salt	0.5	teaspoon	t	13
7	21	8 slices of good quality white sandwich bread	8.0	slices	slices	14
8	224	1/2 teaspoon baking soda	0.5	teaspoon	t	0
8	9	2 medium bananas	2.0	\N	\N	1
8	114	1 1/2 cups organic evaporated cane sugar	1.5	cups	c	2
8	230	Extra Chocolate Chips for decoration, optional	8.0	servings	servings	3
8	230	1 10 oz bag chocolate chips	10.0	oz	oz	4
8	5	1 3/4 cups organic creamy peanut butter	1.75	cups	c	5
8	14	3 Eggs	3.0	\N	\N	6
8	226	7 oz margarine spread, room temperature (leave out for an hour)	7.0	oz	oz	7
8	97	1 1/2 teaspoons Kosher Salt	1.5	teaspoons	t	8
8	50	1/2 cup organic light brown sugar, packed	0.5	cup	c	9
8	0	1 cup potato starch (I use Bob's Red Mill flours)	1.0	cup	c	10
8	229	1 1/2 cups organic powdered sugar	1.5	cups	c	11
8	379	1 cup sorghum flour	1.0	cup	c	12
8	0	1/2 cup tapioca starch	0.5	cup	c	13
8	134	1 teaspoon vanilla extract	1.0	teaspoon	t	14
8	0	1 cup vegan sour cream ( I use Way Fare)	1.0	cup	c	15
8	212	1 1/2 cup white rice flour	1.5	cup	c	16
9	124	1/2 cup barbecue sauce	0.5	cup	c	0
9	171	4 ounces Cooked & chopped barbecue meat (pork, chicken)	4.0	ounces	oz	1
9	4	6 Sliced rings of red onion (up to 8)	6.0	\N	\N	2
9	0	1 12" Pizza Crust	1.0	\N	\N	3
9	172	2 cups Shredded mozzarella cheese	2.0	cups	c	4
9	365	cup Pizza sauce or meatless spaghetti	1.0	cup	c	5
10	168	to taste shredded cheddar or mozzerella	1.0	oz	oz	0
10	363	to taste cooked, sliced chicken, cooked onions, red peppers, chop	1.0	serving	serving	1
10	196	1 package (1/4 ounce) dry yeast	0.25	ounce	oz	2
10	15	1 1/4 cups all-purpose flour	1.25	cups	c	3
10	114	1 tablespoon granulated sugar or honey	1.0	tablespoon	T	4
10	72	1 tablespoon olive oil	1.0	tablespoon	T	5
10	6	1 teaspoon of salt	1.0	teaspoon	t	6
10	7	1 1/4 cups warm water	1.25	cups	c	7
10	110	3 cups whole wheat flour	3.0	cups	c	8
11	10	3 tablespoons butter, divided	3.0	tablespoons	T	0
11	303	White corn syrup, to taste	2.0	servings	servings	1
11	124	1 (18 oz.) reg. flavor Open Pit	18.0	oz	oz	2
11	0	1 (8 oz.) bottle Italian dressing	8.0	oz	oz	3
11	0	1 env. meat marinade	1.0	\N	\N	4
11	4	1/2 onion, finely chopped	0.5	\N	\N	5
11	398	6 pork chops	6.0	\N	\N	6
11	137	1 teaspoon Worcestershire	1.0	teaspoon	t	7
12	118	1 tbs Chilis in Adobo sauce	1.0	tbs	tbs	0
12	99	2 tablespoons apple cider vinegar	2.0	tablespoons	T	1
12	447	2 Tbs pan drippings from the Brisket (can use olive oil if making separately)	2.0	Tb	Tb	2
12	447	1 4-6lb beef brisket	4.0	lb	lb	3
12	50	1/3 cup brown sugar	0.3333333333333333	cup	c	4
12	122	1 cayenne pepper	1.0	\N	\N	5
12	228	1 Tbs fresh cracked black pepper	1.0	Tb	Tb	6
12	283	2 Tsp dark Dijon mustard (go for the good stuff)	2.0	Tsp	Tsp	7
12	23	1 clove clove garlic, minced	1.0	clove	clove	8
12	48	1 Tbs ground cumin	1.0	Tb	Tb	9
12	17	1/4 cup honey	0.25	cup	c	10
12	282	1 1/2 cup ketchup	1.5	cup	c	11
12	97	2 Tbs kosher salt – plus any additional to taste at end	2.0	Tb	Tb	12
12	460	1 Cup Lager	1.0	Cup	Cup	13
12	4	1 cup chopped onions	1.0	cup	c	14
12	228	1/2 tsp fresh cracked black peppers	0.5	tsp	t	15
12	61	1/4 tsp red pepper flakes	0.25	tsp	t	16
12	6	2 teaspoons salt	2.0	teaspoons	t	17
12	41	1 tbsp smoked paprika	1.0	tbsp	T	18
12	123	2 large sweet onions – slice very thin	2.0	\N	\N	19
13	241	2 avocados, peeled, cored, sliced and diced	2.0	\N	\N	0
13	35	2 cans (15 ounce) black beans, rinsed and drained	15.0	ounce	oz	1
13	243	1 can corn	1.0	can	can	2
13	92	1 bunch of fresh cilantro, stems removed, leaves finely chopped	1.0	bunch	bunch	3
13	23	4 tablespoons minced garlic	4.0	tablespoons	T	4
13	3	1 green bell pepper, cored, seeded, and diced	1.0	\N	\N	5
13	94	1 bunch green onions, sliced	1.0	bunch	bunch	6
13	132	1/4 teaspoon hot sauce, or to taste	0.25	teaspoon	t	7
13	139	1/4 juice of lime	0.25	\N	\N	8
13	81	1 orange bell pepper, cored, seeded, and diced	1.0	\N	\N	9
13	4	1/2 of a medium red onion, finely chopped	0.5	\N	\N	10
13	280	Salt and pepper to taste	4.0	servings	servings	11
13	47	2 cans Rotel tomatoes	2.0	cans	cans	12
13	82	1 yellow bell pepper, cored, seeded, and diced	1.0	\N	\N	13
14	101	1 ounce quality balsamic vinegar	1.0	ounce	oz	0
14	35	1 can (15 oz) black beans, drained	15.0	oz	oz	1
14	246	1 can (15 oz) blackeyed peas, drained	15.0	oz	oz	2
14	243	1 can canned corn	1.0	can	can	3
14	45	1 teaspoon dried oregano	1.0	teaspoon	t	4
14	92	1/2 bunch fresh cilantro, leaves only	0.5	bunch	bunch	5
14	23	2 cloves garlic	2.0	cloves	cloves	6
14	374	1 pint super-sweet grape tomatoes, quartered	1.0	pint	pt	7
14	3	1 green bell pepper, fine-chopped	1.0	\N	\N	8
14	48	1 teaspoon ground cumin	1.0	teaspoon	t	9
14	135	3 jalapeño chilies, minced	3.0	\N	\N	10
14	72	1 ounce light olive oil	1.0	ounce	oz	11
14	72	1 ounce extra-virgin olive oil	1.0	ounce	oz	12
14	100	2 oz red wine vinegar	2.0	oz	oz	13
14	6	1/2 teaspoon each salt, ground black pepper, and garlic powder	0.5	teaspoon	t	14
14	94	1 bunch scallions, including light green tops, sliced across into angled rings	1.0	bunch	bunch	15
14	4	1/2 large yellow onion, nicely chopped	0.5	\N	\N	16
15	8	1 tablespoon Baking Powder	1.0	tablespoon	T	0
15	10	3 tablespoons Butter, melted	3.0	tablespoons	T	1
15	247	14 ounces can Cannellini Beans	14.0	ounces	oz	2
15	67	14 ounces can Diced Tomatoes	14.0	ounces	oz	3
15	95	1 tablespoon Chile Powder, plus more for sprinkling over top	1.0	tablespoon	T	4
15	12	Pinch of Cinnamon	1.0	pinch	pinch	5
15	178	1 cup Cornmeal	1.0	cup	c	6
15	48	1/2 teaspoon Cumin	0.5	teaspoon	t	7
15	14	2 Eggs	2.0	\N	\N	8
15	332	3 cups (12 ounces) Extra Sharp Cheddar Cheese, shredded	12.0	ounces	oz	9
15	15	1 cup all-purpose Flour	1.0	cup	c	10
15	244	1 cup Corn, frozen or canned (drained)	1.0	cup	c	11
15	23	5 cloves Garlic, minced	5.0	cloves	cloves	12
15	119	4 ounces can Green Chiles, diced	4.0	ounces	oz	13
15	260	1 pound + 1/2 Ground Beef or Ground Turkey	1.0	pound	lb	14
15	97	Sea or Kosher salt and Fresh Black Pepper	8.0	servings	servings	15
15	20	1 cup Milk	1.0	cup	c	16
15	16	Pinch of Nutmeg	1.0	pinch	pinch	17
15	72	Olive oil for sauteing	8.0	servings	servings	18
15	45	1 teaspoon Oregano	1.0	teaspoon	t	19
15	59	Red Pepper, optional	8.0	servings	servings	20
15	41	1/2 teaspoon Paprika, smoked or regular	0.5	teaspoon	t	21
15	126	1/2 cup Sour Cream, plus more for serving	0.5	cup	c	22
15	6	1/2 teaspoon Table Salt or 1 teaspoon Sea/Kosher Salt	0.5	teaspoon	t	23
15	7	1/2 cup water	0.5	cup	c	24
15	137	2 teaspoons Worcestershire Sauce	2.0	teaspoons	t	25
15	4	2 large yellow onions, diced	2.0	\N	\N	26
16	0	4 pounds baby back ribs	4.0	pounds	lb	0
16	50	1/2 cup brown sugar	0.5	cup	c	1
16	122	1/2 teaspoon cayenne	0.5	teaspoon	t	2
16	95	4 teaspoons chile powder	4.0	teaspoons	t	3
16	99	3/4 cup cider vinegar	0.75	cup	c	4
16	48	2 teaspoons cumin	2.0	teaspoons	t	5
16	283	2 tablespoons Dijon mustard	2.0	tablespoons	T	6
16	86	2 teaspoons dried thyme	2.0	teaspoons	t	7
16	23	1 Clove Garlic, Minced	1.0	Clove	Clove	8
16	143	2 teaspoons garlic powder	2.0	teaspoons	t	9
16	48	2 teaspoons ground cumin	2.0	teaspoons	t	10
16	0	2 teaspoons instant coffee granules	2.0	teaspoons	t	11
16	0	1 teaspoon liquid smoke	1.0	teaspoon	t	12
16	180	3 tablespoons molasses	3.0	tablespoons	T	13
16	71	1 tablespoon oil	1.0	tablespoon	T	14
16	41	2 teaspoons paprika	2.0	teaspoons	t	15
16	58	1 teaspoon pepper	1.0	teaspoon	t	16
16	6	1/2 tsp. salt	0.5	tsp	t	17
16	74	1/2 cup soy sauce	0.5	cup	c	18
16	227	28 ounces can tomato puree	28.0	ounces	oz	19
17	224	1/4 teaspoon baking soda	0.25	teaspoon	t	0
17	10	1/2 cup butter, cut into cubes	0.5	cup	c	1
17	435	dulce de leche	24.0	servings	servings	2
17	14	3 eggs	3.0	\N	\N	3
17	15	1 1/4 cups flour	1.25	cups	c	4
17	0	1 tablespoon instant espresso powder	1.0	tablespoon	T	5
17	230	1 1/4 cups semisweet chocolate chip	1.25	cups	c	6
17	114	1/2 cup sugar	0.5	cup	c	7
17	134	1 tablespoon vanilla extract	1.0	tablespoon	T	8
18	196	1 package active dry yeast	1.0	package	pkg	0
18	58	to taste Freshly-ground black pepper	4.0	servings	servings	1
18	172	fresh buffalo mozzarella, cut into bite sized pieces	1.0	oz	oz	2
18	97	coarse grey salt	4.0	servings	servings	3
18	178	1 cup cornmeal, fine grind	1.0	cup	c	4
18	242	2 ears corn, freshly shucked	2.0	\N	\N	5
18	72	extra-virgin olive oil	4.0	servings	servings	6
18	87	handful fresh basil, torn	1.0	handful	handful	7
18	0	pickled garlic (from your favorite olive bar)	4.0	servings	servings	8
18	23	6 cloves garlic chopped	6.0	cloves	cloves	9
18	17	1 tbsp wild honey	1.0	tbsp	T	10
18	17	2 tablespoons Honey	2.0	tablespoons	T	11
18	47	24 italian tomatoes, cut in half lengthwise	24.0	\N	\N	12
18	61	dried red pepper flakes	4.0	servings	servings	13
18	96	pinch sea salt	1.0	pinch	pinch	14
18	7	1 cup warm water	1.0	cup	c	15
18	110	1 1/2 cups white whole wheat flour	1.5	cups	c	16
19	0	2 tablespoons light caesar dressing	2.0	tablespoons	T	0
19	18	2 tablespoons freshly squeezed lemon juice	2.0	tablespoons	T	1
19	72	1 tablespoon Olive oil	1.0	tablespoon	T	2
19	41	1/4 teaspoon paprika	0.25	teaspoon	t	3
19	183	8 tablespoons Parmesan cheese, shredded	8.0	tablespoons	T	4
19	58	add black pepper to taste	2.0	servings	servings	5
19	157	1 8 oz head of Romaine	8.0	oz	oz	6
19	391	6 ounces Salmon fillet	6.0	ounces	oz	7
19	6	1/4 teaspoon salt	0.25	teaspoon	t	8
19	451	1 tablespoon slivered almonds	1.0	tablespoon	T	9
20	37	29 oz. can chick peas – drained	29.0	oz	oz	0
20	0	Slices of deli ham	1.0	Slices	Slices	1
20	23	3 cloves Garlic Crushed	3.0	cloves	cloves	2
20	48	1/2 teaspoon ground cumin	0.5	teaspoon	t	3
20	135	1 marinated jalapeño – with seeds	1.0	\N	\N	4
20	139	1 Zest of lime – plus juice of lime	1.0	\N	\N	5
20	72	3 tablespoons of olive oil	3.0	tablespoons	T	6
20	4	Red onion- grilled	1.0	serving	serving	7
20	168	Shredded cheddar cheese	1.0	serving	serving	8
20	428	Your favorite tortillas	1.0	serving	serving	9
21	15	4 cups of all purpose flour	4.0	cups	c	0
21	67	2 large cans of peeled tomatoes	2.0	cans	cans	1
21	196	2 teaspoons dry yeast	2.0	teaspoons	t	2
21	23	4 cloves large of garlic, chopped	4.0	cloves	cloves	3
21	72	2 tablespoons Olive oil	2.0	tablespoons	T	4
21	4	2 large onions, chopped	2.0	\N	\N	5
21	319	1/2 cup of red wine	0.5	cup	c	6
21	83	1 teaspoon rosemary	1.0	teaspoon	t	7
21	85	1 teaspoon thyme	1.0	teaspoon	t	8
21	87	1 teaspoon basil	1.0	teaspoon	t	9
21	45	1 teaspoon oregano	1.0	teaspoon	t	10
21	114	6 cups Sugar	6.0	cups	c	11
21	7	cups of warm water	1.0	cups	c	12
21	6	Salt, white pepper	1.0	serving	serving	13
21	60	white pepper	1.0	serving	serving	14
22	3	1 medium bell pepper, chopped	1.0	\N	\N	0
22	246	1 (14 oz) can black eyed peas, drained	14.0	oz	oz	1
22	91	chopped chives or green onions, to taste	8.0	servings	servings	2
22	92	finely chopped cilantro, to taste***	8.0	servings	servings	3
22	23	2 garlic cloves, minced	2.0	cloves	cloves	4
22	269	1 cup picante sauce	1.0	cup	c	5
22	4	1/2 cup (1 small to medium) yellow or purple onion, chopped (the purple is sweeter)	0.5	cup	c	6
22	245	1 (15 oz) can white hominy or sweet corn, drained	15.0	oz	oz	7
22	47	2 mediums tomatoes, chopped	2.0	\N	\N	8
23	56	10 ounces baby bella mushrooms, thickly sliced	10.0	ounces	oz	0
23	181	1 cup fresh whole wheat bread crumbs (I used a food processor to turn 3 pieces of high-fiber 1/4 cup parsley, chopped	1.0	cup	c	1
23	283	1 tablespoon Dijon mustard	1.0	tablespoon	T	2
23	86	1 teaspoon dried thyme	1.0	teaspoon	t	3
23	14	1 large egg and 1 egg white, lightly beaten	1.0	\N	\N	4
23	291	1 1/2 pounds lean ground beef (93 percent lean or better)	1.5	pounds	lb	5
23	72	1/4 cup olive oil	0.25	cup	c	6
23	58	teaspoon salt and fresh ground pepper to taste (I used about 1/2 each)	1.0	teaspoon	t	7
23	460	12 ounces bottle of stout beer	12.0	ounces	oz	8
23	123	1 medium sweet onion, diced	1.0	\N	\N	9
23	339	3 ounces low-fat Swiss cheese, shredded	3.0	ounces	oz	10
24	0	4 cups Cheerios	4.0	cups	c	0
24	5	1 cup Creamy peanut butter, (up to 1-1/2)	1.0	cup	c	1
24	0	2 cups Crisp rice cereal	2.0	cups	c	2
24	384	2 cups Dry roasted peanuts	2.0	cups	c	3
24	303	1 cup Light corn syrup	1.0	cup	c	4
24	0	2 cups M&M's	2.0	cups	c	5
24	114	3/4 cup sugar	0.75	cup	c	6
24	134	1/4 teaspoon vanilla extract	0.25	teaspoon	t	7
25	305	1 teaspoon agave	1.0	teaspoon	t	0
25	0	1 tablespoon organic crunchy peanut butter	1.0	tablespoon	T	1
25	346	1/2 cup non-fat milk	0.5	cup	c	2
25	437	cup quick cooking oats	1.0	cup	c	3
25	0	1 teaspoon unsweetened cocoa	1.0	teaspoon	t	4
26	347	1 cup almond milk or other non-dairy milk (see my almond milk recipe)	1.0	cup	c	0
26	9	2 bananas, smashed (I used frozen)	2.0	\N	\N	1
26	5	1/2 cup peanut butter	0.5	cup	c	2
26	306	1/2 cup strawberries (about 3 strawberries) or 1 Tbsp strawberry jam	0.5	cup	c	3
27	8	1 tablespoon Baking powder	1.0	tablespoon	T	0
27	9	2 Bananas,ripe, mashed	2.0	\N	\N	1
27	50	1/2 cup packed brown sugar	0.5	cup	c	2
27	14	2 Eggs	2.0	\N	\N	3
27	15	1 3/4 cups flour	1.75	cups	c	4
27	20	1/4 cup Milk	0.25	cup	c	5
27	5	1/2 cup peanut butter	0.5	cup	c	6
27	6	1/2 teaspoon salt	0.5	teaspoon	t	7
27	71	2 tablespoons Vegetable oil	2.0	tablespoons	T	8
28	10	3/4 cup butter or margarine melted	0.75	cup	c	0
28	230	18 ounces Chocolate chips	18.0	ounces	oz	1
28	337	tablespoon cup plus 2 sweetened condensed milk	1.0	tablespoon	T	2
28	13	1/2 cup cream cheese	0.5	cup	c	3
28	340	12 double graham crackers (5 x 2 ½- inches)	12.0	\N	\N	4
28	311	1 3/4 cups heavy cream, divided	1.75	cups	c	5
28	5	1 cup natural peanut butter	1.0	cup	c	6
28	6	1/4 teaspoon salt	0.25	teaspoon	t	7
29	0	1/4 cup peppermint flavored candies, crushed	0.25	cup	c	0
29	0	1/2 tsp peppermint extract	0.5	tsp	t	1
29	0	6-8 drops Red food coloring	6.0	drops	drops	2
29	134	1 Container vanilla frosting (12 ounce)	12.0	ounce	oz	3
29	231	2 Cups white chocolate chips	2.0	Cups	Cups	4
30	8	1 tablespoon baking powder	1.0	tablespoon	T	0
30	10	2 tablespoons Butter or margarine	2.0	tablespoons	T	1
30	14	4 large eggs, room temperature	4.0	\N	\N	2
30	15	2 1/2 cups sifted all-purpose flour	2.5	cups	c	3
30	311	1 cup (1/2 pint) heavy cream	1.0	cup	c	4
30	145	1 lemon	1.0	\N	\N	5
30	0	1 1/2 cups lemon curd, homemade or store-bought	1.5	cups	c	6
30	20	1 cup milk	1.0	cup	c	7
30	295	cup poppy seeds, plus more for sprinkling	1.0	cup	c	8
30	6	Pinch of salt	1.0	pinch	pinch	9
30	114	1 1/4 cups sugar	1.25	cups	c	10
30	134	1 tablespoon vanilla extract	1.0	tablespoon	T	11
31	99	1/4 cup apple cider vinegar	0.25	cup	c	0
31	49	1/2 teaspoon cumin seeds	0.5	teaspoon	t	1
31	50	2 tablespoons dark brown sugar	2.0	tablespoons	T	2
31	286	1/2 teaspoon fennel seeds	0.5	teaspoon	t	3
31	141	2 tablespoons minced ginger	2.0	tablespoons	T	4
31	97	Kosher salt	4.0	servings	servings	5
31	139	1/2 cup fresh lime juice	0.5	cup	c	6
31	262	2 cups mango puree	2.0	cups	c	7
31	180	2 tablespoons molasses	2.0	tablespoons	T	8
31	4	1 onion, finely minced	1.0	\N	\N	9
31	41	1 tablespoon paprika	1.0	tablespoon	T	10
31	396	3 pounds 1 boneless pork shoulder (Boston butt), about, excess fat removed, cut into chun	3.0	pounds	lb	11
31	199	Brioche rolls, split	4.0	servings	servings	12
31	160	1 serrano pepper, thinly sliced (seeds discarded if you don't like it spicy)	1.0	\N	\N	13
31	71	1/4 cup vegetable oil	0.25	cup	c	14
31	137	1/4 cup Worcestershire sauce	0.25	cup	c	15
32	124	2 teaspoons barbecue sauce	2.0	teaspoons	t	0
32	0	2 tablespoons Barbecue seasoning	2.0	tablespoons	T	1
32	30	1 teaspoon hoisin sauce	1.0	teaspoon	t	2
32	17	2 teaspoons honey	2.0	teaspoons	t	3
32	145	1 lemon	1.0	\N	\N	4
32	391	2 6-ounce salmon fillets, patted dry	12.0	ounce	oz	5
32	96	Kosher salt or sea salt	2.0	servings	servings	6
33	8	1 tablespoon baking powder	1.0	tablespoon	T	0
33	23	Bulb of garlic	1.0	lb	lb	1
33	72	1 Tablespoon olive oil	1.0	Tablespoon	Tablespoon	2
33	4	1 red onion, cubed	1.0	\N	\N	3
33	23	1 roasted bulb of garlic	1.0	\N	\N	4
33	83	1 tsp rosemary	1.0	tsp	t	5
33	6	1/2 teaspoon salt	0.5	teaspoon	t	6
33	172	1 cup shredded mozzarella	1.0	cup	c	7
33	346	1/2 cup skim milk	0.5	cup	c	8
33	154	2 medium sweet potatoes, peeled and cubed	2.0	\N	\N	9
33	85	1 tsp thyme	1.0	tsp	t	10
33	7	4 cups of water	4.0	cups	c	11
33	110	1 cup whole wheat flour	1.0	cup	c	12
34	15	1 cup of all purpose flour	1.0	cup	c	0
34	58	1 teaspoon of black pepper	1.0	teaspoon	t	1
34	181	2 cups of breadcrumbs	2.0	cups	c	2
34	353	1 cup of chopped chicken breast	1.0	cup	c	3
34	95	1 teaspoon of chili powder	1.0	teaspoon	t	4
34	14	2 eggs	2.0	\N	\N	5
34	23	1 garlic clove	1.0	clove	clove	6
34	142	1/4 teaspoon of ginger powder	0.25	teaspoon	t	7
34	278	2 seasoning cubes	2.0	\N	\N	8
34	71	Oil for deep frying	2.0	servings	servings	9
34	6	Pinch of Salt	1.0	pinch	pinch	10
35	130	1 Sweet apple, peeled, cored, and sliced	1.0	\N	\N	0
35	130	4 Sweet apples, whole, cored, peel intact	4.0	\N	\N	1
35	360	1 Tbsp Arrowroot mixed with 2tbsp de-alcoholised, (slurry) red wine	1.0	Tbsp	Tbsp	2
35	325	1 tsp Caraway seed	1.0	tsp	t	3
35	356	3 Lower fat smoked chicken-apple sausages	3.0	\N	\N	4
35	218	1 tsp Dill seed	1.0	tsp	t	5
35	43	2 Tbsps Chopped fresh parsley	2.0	Tbsps	Tbsps	6
35	72	1 tsp Light olive oil with a dash of toasted sesame oil	1.0	tsp	t	7
35	273	1 cup Low sodium chicken stock	1.0	cup	c	8
35	284	4 tsps Dry English mustard mixed with 4tsp	4.0	tsps	t	9
35	16	1/8 tsp Grated nutmeg	0.125	tsp	t	10
35	4	2 medium Onions, peeled and sliced thin	2.0	\N	\N	11
35	129	4 lrg Russet potatoes, peeled and quartered	4.0	\N	\N	12
35	359	4 medium Rutabagas, peeled and quartered	4.0	\N	\N	13
35	96	1/2 tsp Finely ground sea salt	0.5	tsp	t	14
35	60	1/8 tsp Freshly ground white pepper	0.125	tsp	t	15
35	319	1 cup De-alcoholised dry red wine	1.0	cup	c	16
35	284	1 tsp Yellow mustard seed	1.0	tsp	t	17
36	10	75 grams butter	75.0	grams	g	0
36	109	1 free-range egg yolk	1.0	\N	\N	1
36	289	600 grams minced lamb	600.0	grams	g	2
36	275	100 milliliters chicken, beef or lamb stock	100.0	milliliters	ml	3
36	20	55 milliliters milk	55.0	milliliters	ml	4
36	72	2 tablespoons olive oil	2.0	tablespoons	T	5
36	4	2 onions, finely chopped	2.0	\N	\N	6
36	15	2 tablespoons plain flour	2.0	tablespoons	T	7
36	27	700 grams potatoes	700.0	grams	g	8
36	83	rosemary	4.0	servings	servings	9
36	280	salt and freshly ground black pepper	4.0	servings	servings	10
36	85	thyme	4.0	servings	servings	11
36	47	1 small tin chopped tomatoes	1.0	\N	\N	12
37	10	1 cup butter	1.0	cup	c	0
37	304	10 ounces golden syrup	10.0	ounces	oz	1
37	14	1 large egg, lightly beaten	1.0	\N	\N	2
37	14	4 medium eggs	4.0	\N	\N	3
37	15	1 3/4 cups all-purpose flour	1.75	cups	c	4
37	182	1 ounce fresh bread crumbs	1.0	ounce	oz	5
37	18	juice of 1 lemon	1.0	\N	\N	6
37	146	Zest of 1 lemon	1.0	\N	\N	7
37	180	1 tablespoon molasses	1.0	tablespoon	T	8
37	6	1/2 teaspoon salt	0.5	teaspoon	t	9
37	229	1/4 cup confectioner's sugar	0.25	cup	c	10
38	470	1 teaspoon Almond extract	1.0	teaspoon	t	0
38	0	Fresh Berries	10.0	servings	servings	1
38	0	1/2 cup Mrs Richardson's Butterscotch Caramel sauce	0.5	cup	c	2
38	298	1 large box instant vanilla pudding	1.0	box	box	3
38	20	3 cups milk	3.0	cups	c	4
38	313	1 tub Cool Whip	1.0	tub	tub	5
38	0	1 pound cake	1.0	\N	\N	6
39	8	4 teaspoons baking powder	4.0	teaspoons	t	0
39	10	1 stick butter, melted	1.0	stick	stick	1
39	168	1/2 pound Cheddar cheese, grated	0.5	pound	lb	2
39	15	1 1/4 cups all-purpose flour	1.25	cups	c	3
39	20	1/2 cup milk	0.5	cup	c	4
39	295	1 teaspoon poppy seeds	1.0	teaspoon	t	5
39	315	2/3 cup instant mashed potato flakes	0.6666666666666666	cup	c	6
39	6	1/2 teaspoon salt	0.5	teaspoon	t	7
39	7	2/3 cup water	0.6666666666666666	cup	c	8
39	178	1/2 cup yellow cornmeal	0.5	cup	c	9
40	10	4 tablespoons (1/2 stick) butter, softened	4.0	tablespoons	T	0
40	2	1 pound carrots, peeled and sliced	1.0	pound	lb	1
40	250	4 celery stalks, chopped	4.0	stalks	stalks	2
40	275	6 cups chicken stock	6.0	cups	c	3
40	15	1/2 cup flour	0.5	cup	c	4
40	292	2 pounds ground chicken	2.0	pounds	lb	5
40	132	A few dashes of hot sauce	3.0	dashes	dashes	6
40	97	Kosher salt and freshly ground black pepper	6.0	servings	servings	7
40	72	2 tablespoons olive oil)	2.0	tablespoons	T	8
40	38	1 (10-ounce) package frozen peas	10.0	ounce	oz	9
40	0	2 teaspoons poultry seasoning	2.0	teaspoons	t	10
40	129	2 1/2 pounds russet potatoes, peeled and cubed	2.5	pounds	lb	11
40	332	2 cups shredded sharp cheddar cheese	2.0	cups	c	12
40	123	1 sweet yellow onion, peeled and diced	1.0	\N	\N	13
41	20	3/4 cup milk	0.75	cup	c	0
41	449	2 cups self raising flour	2.0	cups	c	1
41	89	strawberry jam and cream, for serving	4.0	servings	servings	2
41	10	50g unsalted butter, softened	50.0	g	g	3
42	455	400 grams beef tenderloin	400.0	grams	g	0
42	283	Dijon mustard for brushing meat or if you can find English mustard, even better.	2.0	servings	servings	1
42	109	2 Egg yolks	2.0	\N	\N	2
42	55	400 grams mushrooms	400.0	grams	g	3
42	72	Olive oil	2.0	servings	servings	4
42	0	4 slices proscuitto	4.0	slices	slices	5
42	444	200 grams puff pastry	200.0	grams	g	6
42	280	Salt and pepper	2.0	servings	servings	7
43	276	1 cup beef stock or broth	1.0	cup	c	0
43	10	2 tablespoons butter	2.0	tablespoons	T	1
43	2	1 carrot, peeled and finely chopped	1.0	\N	\N	2
43	13	2 tablespoons cream cheese (or sour cream)	2.0	tablespoons	T	3
43	109	1 large egg yolk	1.0	\N	\N	4
43	15	2 tablespoons all-purpose flour	2.0	tablespoons	T	5
43	43	2 tablespoons chopped fresh parsley leaves, for garnish	2.0	tablespoons	T	6
43	85	2 teaspoons thyme (fresh or dried)	2.0	teaspoons	t	7
43	42	1 3/4 pounds ground beef or ground lamb*	1.75	pounds	lb	8
43	64	1/2 cup 1% milk (or heavy cream for richer flavor)	0.5	cup	c	9
43	72	1 tablespoon extra-virgin olive oil, 1 turn of the pan	1.0	tablespoon	T	10
43	4	1 onion, chopped	1.0	\N	\N	11
43	38	1/2 cup to 1 frozen peas, a couple of handfuls	0.5	cup	c	12
43	27	2 pounds potatoes, such as russet, peeled and cubed	2.0	pounds	lb	13
43	280	Salt and freshly ground black pepper	6.0	servings	servings	14
43	41	1 teaspoon sweet paprika	1.0	teaspoon	t	15
43	70	2 tablespoons tomato paste	2.0	tablespoons	T	16
43	137	2 teaspoons Worcestershire, eyeball it	2.0	teaspoons	t	17
44	305	1/3 cup agave nectar (or 1/3 cup sugar)	0.3333333333333333	cup	c	0
44	477	3/4 cup unsweetened applesauce	0.75	cup	c	1
44	8	2 teaspoons baking powder	2.0	teaspoons	t	2
44	224	1/2 teaspoon baking soda	0.5	teaspoon	t	3
44	473	1 cup Fresh Cherries, pitted and frozen	1.0	cup	c	4
44	178	1 cup Fine Grind Cornmeal (Bob's Red Mill)	1.0	cup	c	5
44	142	2 teaspoons ground ginger	2.0	teaspoons	t	6
44	16	1 teaspoon ground nutmeg	1.0	teaspoon	t	7
44	214	2-1/2 cups Oat Flour (Bob's Red Mill)	2.0	cups	c	8
44	39	1/4 cup plain yogurt	0.25	cup	c	9
44	6	1/2 teaspoon salt	0.5	teaspoon	t	10
44	134	2 teaspoons vanilla extract	2.0	teaspoons	t	11
44	381	1/2 cup walnuts, chopped	0.5	cup	c	12
45	10	1 teaspoon butter	1.0	teaspoon	t	0
45	69	1 head cauliflower	1.0	head	head	1
45	356	2 chicken sausage	2.0	\N	\N	2
45	0	1 tablespoon fat-free cream cheese	1.0	tablespoon	T	3
45	15	1 teaspoon flour	1.0	teaspoon	t	4
45	20	1/4 cup milk	0.25	cup	c	5
45	55	1 cup mushrooms, sliced	1.0	cup	c	6
45	319	1 tablespoon red wine	1.0	tablespoon	T	7
45	273	3/4 cup reduced sodium chicken broth	0.75	cup	c	8
45	280	salt and pepper to taste	2.0	servings	servings	9
45	4	1/2 yellow onion	0.5	\N	\N	10
46	8	1 1/2 teaspoons baking powder	1.5	teaspoons	t	0
46	114	3 tablespoons caster sugar	3.0	tablespoons	T	1
46	14	1 egg, slightly beaten	1.0	\N	\N	2
46	18	tablespoon of lemon juice	1.0	tablespoon	T	3
46	20	175 milliliters milk	175.0	milliliters	ml	4
46	6	1/4 teaspoon salt	0.25	teaspoon	t	5
46	449	350 grams Self Raising Flour	350.0	grams	g	6
46	10	1 stick unsalted butter, softened at room temperature	1.0	stick	stick	7
46	134	1/2 teaspoon vanilla extract	0.5	teaspoon	t	8
46	0	1 1/2 dried culinary lavender	1.5	\N	\N	9
47	271	1 cup chicken broth	1.0	cup	c	0
47	242	2 cups corn kernels	2.0	cups	c	1
47	291	1 pound lean ground beef	1.0	pound	lb	2
47	4	2 tablespoons chopped onion	2.0	tablespoons	T	3
47	27	4 mediums potatoes, peeled and quartered	4.0	\N	\N	4
47	331	8 ounces reduced fat cheddar cheese, grated	8.0	ounces	oz	5
47	6	Salt to taste	4.0	servings	servings	6
48	15	2 cups all purpose flour	2.0	cups	c	0
48	8	2 teaspoons baking powder	2.0	teaspoons	t	1
48	224	1/4 teaspoon baking soda	0.25	teaspoon	t	2
48	10	1 tablespoon Butter	1.0	tablespoon	T	3
48	14	1 large egg, beaten well	1.0	\N	\N	4
48	14	2 eggs	2.0	\N	\N	5
48	89	Thick jam or fruit preserves	4.0	servings	servings	6
48	114	1/4 cup granulated white sugar	0.25	cup	c	7
48	20	cup milk	1.0	cup	c	8
48	20	1 tablespoon milk	1.0	tablespoon	T	9
48	6	Salt , to taste	4.0	servings	servings	10
48	134	1 1/2 teaspoons pure vanilla extract	1.5	teaspoons	t	11
49	8	1 teaspoon baking powder	1.0	teaspoon	t	0
49	224	1 teaspoon Baking soda	1.0	teaspoon	t	1
49	50	milk to brush and brown sugar to top	4.0	servings	servings	2
49	10	1 pound Butter or margarine	1.0	pound	lb	3
49	348	60 milliliters (2 fl oz or 1/4 cup) buttermilk	60.0	milliliters	ml	4
49	230	40 grams (1.3 oz or 1/4 cup) chocolate chips	40.0	grams	g	5
49	15	4 cups Flour	4.0	cups	c	6
49	6	1 pinch salt	1.0	pinch	pinch	7
49	327	70 grams (3 oz) whole milk ricotta cheese	3.0	oz	oz	8
49	114	1 cup sugar	1.0	cup	c	9
49	134	2 milliliters (1/4) tsp vanilla extract	2.0	milliliters	ml	10
50	8	2 1/4 teaspoon baking powder	2.25	teaspoon	t	0
50	10	2 tablespoons Butter	2.0	tablespoons	T	1
50	12	1/4 teaspoon cinnamon	0.25	teaspoon	t	2
50	14	1 egg lightly beaten mixed with a tablespoon of water for egg wash	1.0	\N	\N	3
50	15	2 cup flour	2.0	cup	c	4
50	114	1/3 cup granulated white sugar	0.3333333333333333	cup	c	5
50	311	1/2 cup heavy cream	0.5	cup	c	6
50	145	1 lemon	1.0	\N	\N	7
50	20	2-3 tablespoon milk	2.0	tablespoon	T	8
50	229	powdered sugar	8.0	servings	servings	9
50	6	3/4 teaspoon salt	0.75	teaspoon	t	10
50	306	1 pint strawberries	1.0	pint	pt	11
51	114	2 tablespoons of caster sugar	2.0	tablespoons	T	0
51	311	300 milliliters cream	300.0	milliliters	ml	1
51	488	3 tablespoons of custard powder	3.0	tablespoons	T	2
51	89	a packet of Cottee's cold jelly- as per packet instruction	1.0	packet	packet	3
51	20	500 milliliters milk	500.0	milliliters	ml	4
51	306	strawberries- washed and hulled	1.0	serving	serving	5
51	114	2 tablespoons of sugar (add more if you want to have the sweet custard)	2.0	tablespoons	T	6
52	2	1 carrot	1.0	\N	\N	0
52	216	1 bunch of dill, chopped	1.0	bunch	bunch	1
52	14	2 eggs ( or egg substitutes for vegans, you can also add 3-4 tbsp dry yeast flakes)	2.0	\N	\N	2
52	58	1/2 tsp ground pepper	0.5	tsp	t	3
52	55	1 kg mushrooms	1.0	kg	kg	4
52	4	2 onions, diced	2.0	\N	\N	5
52	43	1 bunch of parsley, chopped	1.0	bunch	bunch	6
52	76	1 red bell pepper	1.0	\N	\N	7
52	128	1 kg red skin potatoes	1.0	kg	kg	8
52	96	sea salt, to taste	12.0	servings	servings	9
52	255	2 tbsp unrefined sunflower oil	2.0	tbsp	T	10
52	41	1 tsp sweet paprika	1.0	tsp	t	11
52	0	100g textured vegetable protein	100.0	g	g	12
52	86	1 tbsp dry thyme	1.0	tbsp	T	13
53	86	1/2 tsp dried thyme leaves	0.5	tsp	t	0
53	450	1/2 lb goose or duck, liver pate or 17 oz. can liver pate	0.5	lb	lb	1
53	14	1 egg, separated	1.0	\N	\N	2
53	20	2 tsps milk	2.0	tsps	t	3
53	55	1 8 oz. pkg. mushrooms, finely chopped	8.0	oz	oz	4
53	4	1 med. sized onion, minced	1.0	\N	\N	5
53	58	1/4 tsp pepper	0.25	tsp	t	6
53	444	1 17 1/4 oz. pkg. frozen puff pastry	17.25	oz	oz	7
53	319	2 Tbsps red wine	2.0	Tbsps	Tbsps	8
53	455	1 6 lb. whole beef tenderloin roast	6.0	lb	lb	9
53	6	1/2 tsp salt	0.5	tsp	t	10
54	455	4 individual portion size fillets tenderloin beef	4.0	fillet	fillet	0
54	512	2 Tbsps brandy (optional)	2.0	Tbsps	Tbsps	1
54	10	3 Tbsps butter	3.0	Tbsps	Tbsps	2
54	14	1 beaten egg	1.0	\N	\N	3
54	23	1 clove garlic, cut before using	1.0	clove	clove	4
54	450	1 can liver pate	1.0	can	can	5
54	0	1 Tbsp mixed herbs	1.0	Tbsp	Tbsp	6
54	55	1 cup finely chopped mushrooms	1.0	cup	c	7
55	241	1 medium avocado, mashed to a paste	1.0	\N	\N	0
55	92	1 teaspoon freshly chopped cilantro- optional	1.0	teaspoon	t	1
55	496	1/2 cup cook and peeled crayfish tails	0.5	cup	c	2
55	72	1 teaspoon extra-virgin olive oil	1.0	teaspoon	t	3
55	6	salt, to taste	4.0	servings	servings	4
55	100	2 teaspoons sherry vinegar	2.0	teaspoons	t	5
55	47	1 tomato	1.0	\N	\N	6
56	9	8 bananas	8.0	\N	\N	0
56	50	1/2 cup Brown sugar	0.5	cup	c	1
56	10	1/2 cup butter	0.5	cup	c	2
56	12	1 teaspoon cinnamon	1.0	teaspoon	t	3
56	14	10 Eggs	10.0	\N	\N	4
56	115	1/4 cup Half& Half	0.25	cup	c	5
56	0	1 loaf Hawaiian Bread (challah works well)	1.0	loaf	loaf	6
56	311	2 cups heavy cream	2.0	cups	c	7
56	19	1/4 cup Maple Syrup	0.25	cup	c	8
56	6	1/2 teaspoon Salt	0.5	teaspoon	t	9
56	114	1/4 cup Sugar	0.25	cup	c	10
56	134	1 teaspoon Vanilla	1.0	teaspoon	t	11
57	9	1 cup Bananas (mashed)	1.0	cup	c	0
57	10	1/2 cup butter	0.5	cup	c	1
57	109	4 egg yolks	4.0	\N	\N	2
57	114	1/2 cup granulated sugar, divided	0.5	cup	c	3
57	311	2 cups heavy cream	2.0	cups	c	4
57	97	1/8 teaspoon kosher salt	0.125	teaspoon	t	5
57	50	1/4 cup light brown sugar	0.25	cup	c	6
57	317	1 tablespoon rum	1.0	tablespoon	T	7
57	463	1 vanilla bean	1.0	\N	\N	8
57	20	1 1/4 cups whole milk	1.25	cups	c	9
58	188	6 cups cooked rice	6.0	cups	c	0
58	94	2 bunches green onions, chopped	2.0	bunches	bunches	1
58	4	1 large onion, chopped	1.0	\N	\N	2
58	43	1 bunch parsley, chopped	1.0	bunch	bunch	3
58	58	pepper to taste	6.0	servings	servings	4
58	402	2 pounds pork meat	2.0	pounds	lb	5
58	399	1 1/2 pounds pork liver	1.5	pounds	lb	6
58	6	5 teaspoons salt	5.0	teaspoons	t	7
59	58	1 1/2 teaspoons freshly-ground black pepper	1.5	teaspoons	t	0
59	122	2 1/2 teaspoons cayenne	2.5	teaspoons	t	1
59	250	1/2 cup chopped celery	0.5	cup	c	2
59	188	6 cups cooked medium-grain rice	6.0	cups	c	3
59	23	4 cloves garlic finely chopped	4.0	cloves	cloves	4
59	3	1/2 cup chopped green bell peppers	0.5	cup	c	5
59	4	1 cup chopped onions	1.0	cup	c	6
59	94	1 cup chopped green onions tops (green part only)	1.0	cup	c	7
59	43	1 cup finely-chopped parsley	1.0	cup	c	8
59	397	2 1/2 pounds pork butt, cut into 1" cubes	2.5	pounds	lb	9
59	399	1 pound pork liver, rinsed in cool water	1.0	pound	lb	10
59	6	2 teaspoons salt	2.0	teaspoons	t	11
59	464	sausage casings, 1 1/2" diameter, about 4 feet in length	1.0	\N	\N	12
59	7	2 quarts water	2.0	quarts	quarts	13
60	58	1 tsp black pepper	1.0	tsp	t	0
60	104	1/2 vegan Bouillon cube	0.5	\N	\N	1
60	248	1 15oz can kidney beans	15.0	oz	oz	2
60	67	1 14.5 oz can petite diced tomatoes	14.5	oz	oz	3
60	2	2 carrots, diced	2.0	\N	\N	4
60	250	1 celery stalk, diced	1.0	stalk	stalk	5
60	456	2 tsp Tony Chachere's Creole Seasoning	2.0	tsp	t	6
60	23	3 garlic cloves, minced	3.0	cloves	cloves	7
60	94	1/2 cup green onions, chopped	0.5	cup	c	8
60	0	3 tsp Tony Chachere's Instant Roux	3.0	tsp	t	9
60	177	2 cups whole grain rice	2.0	cups	c	10
60	4	1 onion, diced	1.0	\N	\N	11
60	43	1/3 cup parsley, chopped	0.3333333333333333	cup	c	12
60	6	1 tsp salt	1.0	tsp	t	13
60	70	2 Tbsp tomato paste	2.0	Tbsp	Tbsp	14
60	0	2 veggie sausage links	2.0	\N	\N	15
60	7	3/4 cup water	0.75	cup	c	16
60	7	3 1/2 cups water	3.5	cups	c	17
61	22	3 strips of Bacon	3.0	strips	strips	0
61	3	1 Bell Pepper, any Color, Chopped	1.0	\N	\N	1
61	271	3/4 cup Chicken, Seafood, or Veggie Broth	0.75	cup	c	2
61	456	1 teaspoon of Cajun Spice	1.0	teaspoon	t	3
61	23	3 cloves of Garlic, Minced	3.0	cloves	cloves	4
61	143	1/2 teaspoon of Garlic Powder	0.5	teaspoon	t	5
61	94	3 Green Onions, Chopped	3.0	\N	\N	6
61	311	1/4 cup of Heavy Cream	0.25	cup	c	7
61	509	1/2 teaspoon of Lemon Pepper	0.5	teaspoon	t	8
61	0	1 pd of Lobster	1.0	pound	lb	9
61	484	1 teaspoon of Old Bay Seasoning	1.0	teaspoon	t	10
61	166	1/2 teaspoon of Onion Powder	0.5	teaspoon	t	11
61	45	1/2 teaspoon of Oregano	0.5	teaspoon	t	12
61	58	Pepper to taste	1.0	serving	serving	13
61	6	1/4 tsp salt	0.25	tsp	t	14
62	122	1 tsp cayenne pepper	1.0	tsp	t	0
62	143	1 tsp garlic powder	1.0	tsp	t	1
62	457	1 tsp italian seasoning	1.0	tsp	t	2
62	72	3 tbsp olive oil	3.0	tbsp	T	3
62	166	1 tsp onion powder	1.0	tsp	t	4
62	41	2 tsp paprika	2.0	tsp	t	5
62	58	1/2 tsp pepper	0.5	tsp	t	6
62	129	2 large russet potatoes	2.0	\N	\N	7
62	6	3/4 tsp salt	0.75	tsp	t	8
63	443	9 oz andouille sausage, cut into 1/2 inch rounds	9.0	oz	oz	0
63	225	2 bay leaves, left whole	2.0	\N	\N	1
63	3	1/2 t white pepper	0.5	t	t	2
63	58	1 Tablespoon Black Pepper	1.0	Tablespoon	Tablespoon	3
63	122	1 Tablespoon Cayenne Pepper	1.0	Tablespoon	Tablespoon	4
63	250	3 stalks celery, cut into 1 inch pieces	3.0	stalks	stalks	5
63	277	3 C fish stock or clam juice	3.0	C	C	6
63	188	2 C white rice, cooked, washed and drained	2.0	C	C	7
63	497	1/2 # canned or fresh crab meat	0.5	\N	\N	8
63	45	1 Tablespoon Dried Oregano	1.0	Tablespoon	Tablespoon	9
63	86	1 Tablespoon Dried Thyme	1.0	Tablespoon	Tablespoon	10
63	23	3 large cloves of garlic, chopped	3.0	cloves	cloves	11
63	135	1 jalapeno pepper, seeded	1.0	\N	\N	12
63	81	1 red or orange Bell pepper, chopped coarse	1.0	\N	\N	13
63	206	1 10 oz jar of oysters or 8-10 oysters with their juices	10.0	oz	oz	14
63	254	1/2 C peanut oil	0.5	C	C	15
63	52	1 pound shrimp	1.0	pound	lb	16
63	15	1/2 C white flour	0.5	C	C	17
64	251	8 ounces of Asparagus Spears, Cut into Thirds	8.0	ounces	oz	0
64	22	3 slices of Bacon	3.0	slices	slices	1
64	277	2 cups seafood broth	2.0	cups	c	2
64	456	1 tablespoon of Cajun Spice	1.0	tablespoon	T	3
64	242	1 cup of Corn	1.0	cup	c	4
64	23	3 cloves of garlic, crushed	3.0	cloves	cloves	5
64	311	1/2 cup of Heavy Cream	0.5	cup	c	6
64	509	1 teaspoon of Lemon Pepper	1.0	teaspoon	t	7
64	484	1/2 teaspoon of Old Bay Seasoning	0.5	teaspoon	t	8
64	4	1 Small Onion, Chopped	1.0	\N	\N	9
64	280	Salt and Pepper to Taste	8.0	servings	servings	10
64	57	1 pound Peeled and Cooked Shrimp	1.0	pound	lb	11
64	67	14 1/2 Oz. Can of Diced Tomatoes	14.0	\N	\N	12
65	456	1 teaspoon Cajun or creole seasoning (like Tony Chachere's), divided	1.0	teaspoon	t	0
65	237	1 whole English cucumber, sliced thinly	1.0	\N	\N	1
65	269	1/4 cup prepared pico de gallo	0.25	cup	c	2
65	100	2 tablespoons white wine vinegar (red wine vinegar also works well)	2.0	tablespoons	T	3
65	280	salt and pepper to taste	2.0	servings	servings	4
65	52	8 ounces large uncooked shrimp, peeled with tails on (about 20), thawed	8.0	ounces	oz	5
65	18	1 tablespoon freshly squeezed lemon juice or white/white wine vinegar	1.0	tablespoon	T	6
66	10	2 tablespoons butter, divided	2.0	tablespoons	T	0
66	67	1 cup canned chopped tomatoes	1.0	cup	c	1
66	250	2 celery ribs, minced	2.0	rib	rib	2
66	278	1 chicken bouillon cube	1.0	\N	\N	3
66	496	1 package (2-pound) frozen crawfish tails, thawed*	2.0	pound	lb	4
66	456	1 tablespoon Creole seasoning	1.0	tablespoon	T	5
66	15	cup all-purpose flour	1.0	cup	c	6
66	43	1 tablespoon chopped fresh parsley	1.0	tablespoon	T	7
66	23	2 garlic cloves minced	2.0	cloves	cloves	8
66	3	1/2 green bell pepper, minced	0.5	\N	\N	9
66	94	1 bunch green onions, finely chopped	1.0	bunch	bunch	10
66	0	1 package (8-ounce) linguine	8.0	ounce	oz	11
66	4	2 tablespoons onion, finely chopped	2.0	tablespoons	T	12
66	183	Shredded Parmesan cheese	8.0	servings	servings	13
66	43	Garnish: chopped fresh parsley	8.0	servings	servings	14
66	58	1/4 teaspoon pepper	0.25	teaspoon	t	15
66	6	salt	8.0	servings	servings	16
66	310	1 pint whipping cream	1.0	pint	pt	17
67	87	1 teaspoon basil	1.0	teaspoon	t	0
67	225	1 Bay leaf	1.0	\N	\N	1
67	79	8 ounces can tomato sauce	8.0	ounces	oz	2
67	67	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	3
67	250	5 celery stalks	5.0	stalks	stalks	4
67	275	2 cups chicken stock	2.0	cups	c	5
67	498	2 pounds grouper or a white fish	2.0	pounds	lb	6
67	23	20 grams garlic finely chopped	20.0	grams	g	7
67	3	1 green pepper	1.0	\N	\N	8
67	371	okra	10.0	servings	servings	9
67	4	3/4 cup onion, chopped	0.75	cup	c	10
67	41	paprika, to taste	10.0	servings	servings	11
67	58	alt and pepper, to taste	10.0	servings	servings	12
67	464	2 links hot sausage	2.0	links	links	13
67	85	1/2 teaspoon thyme	0.5	teaspoon	t	14
68	443	3 ounces fully cooked andouille sausage	3.0	ounces	oz	0
68	67	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	1
68	122	1/2 teaspoon cayenne pepper	0.5	teaspoon	t	2
68	250	1 cup thinly-sliced celery	1.0	cup	c	3
68	271	3 ounces can chicken broth - (14 1/2 ea)	3.0	ounces	oz	4
68	370	8 chicken drumsticks skinned	8.0	\N	\N	5
68	314	chorizo sausage diced	8.0	servings	servings	6
68	333	1 teaspoon dried marjoram	1.0	teaspoon	t	7
68	86	1/4 tsp. dried thyme	0.25	tsp	t	8
68	23	4 garlic cloves crushed	4.0	cloves	cloves	9
68	177	2/3 cup long-grain brown rice	0.6666666666666666	cup	c	10
68	371	1/2 pound fresh okra cut 1/2" slices	0.5	pound	lb	11
68	4	3/4 cup onion, chopped	0.75	cup	c	12
68	76	1 red bell pepper diced	1.0	\N	\N	13
68	52	1/2 pound medium shrimp peeled, deveined	0.5	pound	lb	14
69	177	1/2 cup uncooked brown rice	0.5	cup	c	0
69	456	1 tsp. cajun seasoning	1.0	tsp	t	1
69	67	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	2
69	250	1 cup celery, chopped	1.0	cup	c	3
69	356	2 fully cooked chicken sausage Links (about 6 oz) sliced into coins – I used Trader Joe's Sweet Italian Chicken Sausage	6.0	oz	oz	4
69	45	1/4 tsp. dried oregano	0.25	tsp	t	5
69	86	1/4 tsp. dried thyme	0.25	tsp	t	6
69	23	16 Garlic , peeled	16.0	\N	\N	7
69	132	1/2 tsp. hot sauce, or more to taste	0.5	tsp	t	8
69	273	1 cup low-sodium chicken broth	1.0	cup	c	9
69	4	3/4 cup onion, chopped	0.75	cup	c	10
69	52	6 oz. raw shrimp, tails removed, deveined, chopped	6.0	oz	oz	11
69	82	1 large green bell pepper, seeded, chopped – I used yellow	1.0	\N	\N	12
70	443	1 pound andouille, turkey, kielbasa or smoked sausage, cubed	1.0	pound	lb	0
70	225	3 bay leaves	3.0	\N	\N	1
70	497	1 dozen fresh or frozen blue crabs, cleaned and shells removed (substitute: 2 pounds fresh crabmeat, crawfish, oyster, or turtle)	12.0	\N	\N	2
70	67	1 can whole peeled tomatoes, chopped	1.0	can	can	3
70	250	4 stalks celery, chopped	4.0	stalks	stalks	4
70	456	Creole seasoning to taste	9.0	servings	servings	5
70	86	1/2 teaspoon dried thyme	0.5	teaspoon	t	6
70	506	2 tablespoons filé powder	2.0	tablespoons	T	7
70	15	1/2 cup flour	0.5	cup	c	8
70	23	3 cloves of garlic, minced	3.0	cloves	cloves	9
70	94	1 cup chopped green onions	1.0	cup	c	10
70	3	2 green peppers, chopped	2.0	\N	\N	11
70	58	2 teaspoons ground black pepper	2.0	teaspoons	t	12
70	371	1 pound fresh or frozen sliced okra	1.0	pound	lb	13
70	4	1 large onion, chopped	1.0	\N	\N	14
70	43	1/2 cup chopped parsley	0.5	cup	c	15
70	174	1 bag Louisiana rice (or white rice)	1.0	bag	bag	16
70	6	salt, to taste	9.0	servings	servings	17
70	52	2 pounds fresh or frozen medium-size shrimp, in shells if possible, for stock	2.0	pounds	lb	18
70	133	All the Tabasco sauce you can handle	1.0	can	can	19
70	70	1 ounce tomato paste	1.0	ounce	oz	20
70	71	4 teaspoons vegetable oil or shortening	4.0	teaspoons	t	21
70	137	1 teaspoon Worcestershire sauce	1.0	teaspoon	t	22
71	10	2 1/2 tablespoons Butter	2.5	tablespoons	T	0
71	12	2 tablespoons powdered cinnamon	2.0	tablespoons	T	1
71	14	2 eggs, beaten	2.0	\N	\N	2
71	15	5 cups all-purpose flour	5.0	cups	c	3
71	20	3/4 cup milk	0.75	cup	c	4
71	142	1/2 teaspoon powdered ginger	0.5	teaspoon	t	5
71	229	1/2 cup powdered sugar	0.5	cup	c	6
71	6	salt	1.0	serving	serving	7
71	259	Shortening (butter Crisco)	1.0	serving	serving	8
71	114	1/2 cup sugar	0.5	cup	c	9
71	134	1/2 teaspoon almond or vanilla extract (optional)	0.5	teaspoon	t	10
71	7	1 1/2 teaspoons warm water (powdered sugar and 1 pkg. colored decorating sugar	1.5	teaspoons	t	11
72	443	1 1/2 pounds smoked Andouille sausage, sliced	1.5	pounds	lb	0
72	225	2 bay leaves	2.0	\N	\N	1
72	3	1 bell pepper, chopped	1.0	\N	\N	2
72	11	1 tablespoon Canola oil	1.0	tablespoon	T	3
72	250	5 stalks celery, diced	5.0	stalks	stalks	4
72	456	Creole seasoning to taste	6.0	servings	servings	5
72	86	1 teaspoon dried thyme leaves	1.0	teaspoon	t	6
72	23	1 clove garlic chopped	1.0	clove	clove	7
72	174	White long grain rice	6.0	servings	servings	8
72	4	1 large onion, chopped	1.0	\N	\N	9
72	249	1 pound dried red kidney beans	1.0	pound	lb	10
72	280	Salt and pepper to taste	6.0	servings	servings	11
72	0	1 large smoked ham hock	1.0	\N	\N	12
72	133	Tabasco sauce to taste	6.0	servings	servings	13
72	137	Few dashes of Worcestershire sauce to taste	3.0	dashes	dashes	14
73	225	2 bay leaves	2.0	\N	\N	0
73	250	3 ribs celery, finely diced	3.0	ribs	ribs	1
73	86	1 teaspoon dried thyme leaves	1.0	teaspoon	t	2
73	506	1 tablespoon filé powder	1.0	tablespoon	T	3
73	277	4 quarts shrimp stock, crab stock or fish stock	4.0	quarts	quarts	4
73	15	1/2 cup flour	0.5	cup	c	5
73	23	6 cloves garlic, minced	6.0	cloves	cloves	6
73	3	2 green bell peppers, diced	2.0	\N	\N	7
73	188	8 cups cooked long-grain white rice	8.0	cups	c	8
73	497	1 pound fresh lump crab meat, picked over for shells and cartilage	1.0	pound	lb	9
73	71	1/2 cup oil	0.5	cup	c	10
73	371	2 pounds okra, chopped	2.0	pounds	lb	11
73	4	2 medium onions, diced	2.0	\N	\N	12
73	205	2 dozen oysters, freshly shucked, liquor reserved	24.0	\N	\N	13
73	280	Salt and freshly ground black pepper to taste	12.0	servings	servings	14
73	456	1 tablespoon Creole seasoning blend	1.0	tablespoon	T	15
73	52	2 pounds medium shrimp, peeled and deveined	2.0	pounds	lb	16
73	227	1 cup tomato purée	1.0	cup	c	17
73	47	4 tomatoes, seeded and diced	4.0	\N	\N	18
74	34	1tsp. allspice	1.0	tsp	t	0
74	257	1 tbsp. coconut oil	1.0	tbsp	T	1
74	80	6 tbsp. curry powder	6.0	tbsp	T	2
74	23	1 tablespoon Garlic, granulated	1.0	tablespoon	T	3
74	3	1 large green pepper (chopped)	1.0	\N	\N	4
74	4	1/2 medium Onion, chopped	0.5	\N	\N	5
74	58	2 tsp. black pepper pepper	2.0	tsp	t	6
74	6	1 1/2 teaspoons salt	1.5	teaspoons	t	7
74	94	3 scallions (chopped)	3.0	\N	\N	8
74	107	1 scotch bonnet pepper or habanero (seeded and minced)	1.0	\N	\N	9
74	355	3lb of chicken thighs, legs or breast (skinless)	3.0	lb	lb	10
74	154	2 sweet potatoes (chopped)	2.0	\N	\N	11
74	85	1tbsp. thyme	1.0	tbsp	T	12
74	7	2 cups water	2.0	cups	c	13
75	33	1 pound dry organic black turtle beans	1.0	pound	lb	0
75	50	1 tablespoon Brown sugar	1.0	tablespoon	T	1
75	257	2 tablespoons organic coconut oil (or olive oil)	2.0	tablespoons	T	2
75	92	1/2 cup fresh cilantro, chopped	0.5	cup	c	3
75	94	2 green onions, roughly chopped	2.0	\N	\N	4
75	34	1 tablespoon Ground Allspice	1.0	tablespoon	T	5
75	142	2 tsp ground ginger	2.0	tsp	t	6
75	135	4 jalapenos, seeded and chopped	4.0	\N	\N	7
75	4	1/2 onion, roughly chopped	0.5	\N	\N	8
75	96	2 tsp course sea salt	2.0	tsp	t	9
75	154	4 cups local or organic sweet potatoes peeled and chopped into 1/2 inch cubes	4.0	cups	c	10
75	85	1/2 tsp thyme	0.5	tsp	t	11
75	105	8 cups of vegetable broth or water	8.0	cups	c	12
76	34	1 tsp allspice	1.0	tsp	t	0
76	372	4 bone in chicken thighs	4.0	\N	\N	1
76	50	2 tbsp brown sugar	2.0	tbsp	T	2
76	12	1 tsp cinnamon	1.0	tsp	t	3
76	23	3 cloves garlic, roughly chopped	3.0	cloves	cloves	4
76	94	2 green onions, roughly chopped	2.0	\N	\N	5
76	142	1 tsp ground ginger	1.0	tsp	t	6
76	457	1 tsp italian seasoning	1.0	tsp	t	7
76	135	1 jalapeno, roughly chopped	1.0	\N	\N	8
76	139	3 limes, juiced	3.0	\N	\N	9
76	4	1/2 onion, roughly chopped	0.5	\N	\N	10
76	58	1 tsp pepper	1.0	tsp	t	11
76	0	6 oz. pineapple juice	6.0	oz	oz	12
76	6	1 tbsp salt	1.0	tbsp	T	13
77	479	1/4 cup coconut	0.25	cup	c	0
77	479	2 tablespoons coconut	2.0	tablespoons	T	1
77	13	1 package (8 ounce) cream cheese, softened	8.0	ounce	oz	2
77	109	2 egg yolks	2.0	\N	\N	3
77	15	1/4 cup all-purpose flour	0.25	cup	c	4
77	311	1/2 cup heavy whipping cream	0.5	cup	c	5
77	299	1 package (2.9 ounce) lemon pudding mix	2.9	ounce	oz	6
77	138	lime slices	1.0	slicesslices	slicesslices	7
77	139	3 tablespoons lime juice	3.0	tablespoons	T	8
77	336	1 teaspoon grated lime peel	1.0	teaspoon	t	9
77	446	1 (15 ounce) refrigerated pie crust	15.0	ounce	oz	10
77	126	6 tablespoons sour cream	6.0	tablespoons	T	11
77	114	1/4 cup sugar	0.25	cup	c	12
77	114	1/2 cup sugar	0.5	cup	c	13
77	10	4 teaspoons unsalted butter	4.0	teaspoons	t	14
77	7	2 cups water	2.0	cups	c	15
77	231	1 cup white chocolate chips	1.0	cup	c	16
78	490	8 ounces fresh callaloo leaves, Swiss chard, or baby spinach leaves	8.0	ounces	oz	0
78	275	2 cups chicken stock	2.0	cups	c	1
78	350	2 cups coconut milk	2.0	cups	c	2
78	257	2 tbsp. coconut oil	2.0	tbsp	T	3
78	188	cooked long grain rice or prepared foo-foo (plantain)	4.0	servings	servings	4
78	497	6 ounces fresh crab meat, picked over for shell bits	6.0	ounces	oz	5
78	85	1 tsp. fresh thyme	1.0	tsp	t	6
78	23	2 Cloves garlic, chopped	2.0	Cloves	Cloves	7
78	108	1 fresh habanero chile, seeds removed and chopped	1.0	\N	\N	8
78	371	10 fresh okra, chopped	10.0	\N	\N	9
78	4	1/2 cup chopped onion	0.5	cup	c	10
78	280	salt and pepper to taste	4.0	servings	servings	11
78	147	1 1/2 ounces salt pork or bacon, chopped	1.5	ounces	oz	12
78	94	1 cup chopped scallions	1.0	cup	c	13
79	350	2 cups of coconut milk	2.0	cups	c	0
79	40	1 tablespoon of corn starch	1.0	tablespoon	T	1
79	80	2 tablespoons of curry powder	2.0	tablespoons	T	2
79	23	1 clove of garlic (chopped)	1.0	clove	clove	3
79	104	Seasoning cubes	1.0	cubes	cubes	4
79	0	1 medium piece of Mackerel (chopped in 4 pieces)	1.0	piece	\N	5
79	4	1/2 bulb of onion	0.5	\N	\N	6
79	249	1/2 cup of red kidney beans	0.5	cup	c	7
79	174	1 cup of Rice	1.0	cup	c	8
79	107	3 scotch bonnet peppers	3.0	\N	\N	9
80	0	1 (8 -10 lb.) Duck	8.0	lb	lb	0
80	462	1/4 teaspoon five spice powder	0.25	teaspoon	t	1
80	30	Hoisin sauce	12.0	servings	servings	2
80	17	1 teaspoon honey	1.0	teaspoon	t	3
80	303	1 teaspoon light corn syrup	1.0	teaspoon	t	4
80	297	1 teaspoon rice wine vinegar	1.0	teaspoon	t	5
80	6	2 teaspoons salt	2.0	teaspoons	t	6
80	94	Scallions	12.0	servings	servings	7
80	7	1 gallon boiling water	1.0	gallon	gallon	8
80	60	1/4 teaspoon white pepper	0.25	teaspoon	t	9
81	436	1 tablespoon smooth almond butter	1.0	tablespoon	T	0
81	11	1/2 cup canola oil	0.5	cup	c	1
81	2	2 carrots, shredded	2.0	\N	\N	2
81	508	Chili oil, optional	4.0	servings	servings	3
81	118	1 teaspoon adobo chipotle pepper puree	1.0	teaspoon	t	4
81	92	1/4 cup coarsely chopped fresh cilantro leaves	0.25	cup	c	5
81	141	1 tablespoon chopped fresh ginger	1.0	tablespoon	T	6
81	152	1/4 cup chopped fresh mint leaves	0.25	cup	c	7
81	94	1/4 cup thinly sliced green onion	0.25	cup	c	8
81	17	2 tablespoons honey	2.0	tablespoons	T	9
81	138	lime halves, for garnish	1.0	halves	halves	10
81	148	1/2 head Napa cabbage, shredded	0.5	head	head	11
81	297	1/4 cup rice wine vinegar	0.25	cup	c	12
81	383	1/2 cup chopped roasted peanuts	0.5	cup	c	13
81	157	1/2 head romaine lettuce, shredded	0.5	head	head	14
81	368	2 cups shredded rotisserie chicken	2.0	cups	c	15
81	280	Salt and freshly ground pepper	4.0	servings	servings	16
81	28	2 teaspoons toasted sesame oil	2.0	teaspoons	t	17
81	5	1 tablespoon smooth peanut butter	1.0	tablespoon	T	18
81	31	1/2 cup snow peas, cut in half lengthwise on a diagonal	0.5	cup	c	19
81	74	1 tablespoon soy sauce	1.0	tablespoon	T	20
82	3	1/4 cup bell pepper, diced	0.25	cup	c	0
82	2	1/4 cup carrot, slivered	0.25	cup	c	1
82	0	1/4 cup fat-free mayonnaise	0.25	cup	c	2
82	141	1 teaspoon ginger root, freshly grated	1.0	teaspoon	t	3
82	94	2 green onions, sliced	2.0	\N	\N	4
82	268	1/2 tablespoon low-sodium soy sauce	0.5	tablespoon	T	5
82	354	8 ounces cooked boneless, skinless chicken breast, thinly sliced or shredded (about 3 cups) or 1 can Kirkland	3.0	cups	c	6
82	31	1/2 cup snow peas, cut in half lengthwise on a diagonal	0.5	cup	c	7
82	164	2 cups torn spinach leaves or other greens of your choosing	2.0	cups	c	8
83	11	2 tablespoons canola oil	2.0	tablespoons	T	0
83	12	2 cinnamon sticks	2.0	\N	\N	1
83	74	1/2 cup dark soy sauce	0.5	cup	c	2
83	23	4 cloves garlic	4.0	cloves	cloves	3
83	141	2 large ginger slices	2.0	slices	slices	4
83	12	1 teaspoon ground cinnamon	1.0	teaspoon	t	5
83	290	1 teaspoon ground cloves	1.0	teaspoon	t	6
83	142	1 teaspoon ground ginger	1.0	teaspoon	t	7
83	135	1 jalapeno, chopped	1.0	\N	\N	8
83	74	1/4 cup light soy sauce	0.25	cup	c	9
83	326	1 lotus root	1.0	\N	\N	10
83	400	1 pound pork belly	1.0	pound	lb	11
83	318	1/2 cup ShaoHsing Rice Cooking wine	0.5	cup	c	12
83	6	salt to taste	2.0	servings	servings	13
83	28	1 teaspoon sesame oil	1.0	teaspoon	t	14
83	261	1 shallot, chopped	1.0	\N	\N	15
83	323	2 tablespoons star anise	2.0	tablespoons	T	16
83	114	1/2 cup rock sugar (yellow or white)	0.5	cup	c	17
83	7	4 cups water	4.0	cups	c	18
83	324	1 yucca, steamed	1.0	\N	\N	19
84	151	4 baby bok choy	4.0	\N	\N	0
84	372	1 pound boneless chicken thighs, thinly sliced	1.0	pound	lb	1
84	275	6 cups chicken stock	6.0	cups	c	2
84	78	Chile-garlic paste	6.0	servings	servings	3
84	141	5 slices of fresh ginger	5.0	slices	slices	4
84	23	5 garlic cloves, cracked	5.0	cloves	cloves	5
84	94	3/4 cup green onions, diced	0.75	cup	c	6
84	51	1 cup mung bean sprouts	1.0	cup	c	7
84	55	8 ounces mushrooms, any variety	8.0	ounces	oz	8
84	427	5 ounces bean thread noodles, or rice stick noodles	5.0	ounces	oz	9
84	297	1/2 cup rice vinegar	0.5	cup	c	10
84	28	1 tablespoon of sesame oil	1.0	tablespoon	T	11
84	74	1/3 cup soy sauce	0.3333333333333333	cup	c	12
84	7	6 cups water	6.0	cups	c	13
85	323	1/2 tbsp anise seed	0.5	tbsp	T	0
85	99	2 tbsp apple cider vinegar	2.0	tbsp	T	1
85	225	3-5 bay leaves	3.0	\N	\N	2
85	250	2-4 celery stalks	2.0	stalks	stalks	3
85	228	1/2 tbsp cracked pepper	0.5	tbsp	T	4
85	228	1 /2 tbsp cracked pepper	12.0	tbsp	T	5
85	462	1/2 tsp Chinese five spice powder	0.5	tsp	t	6
85	23	1 head of garlic, minced	1.0	head	head	7
85	141	1 ginger, two inches in length, sliced into 1/4 inch slices	1.0	\N	\N	8
85	17	1 tbsp honey	1.0	tbsp	T	9
85	6	1 tbsp iodized salt	1.0	tbsp	T	10
85	74	3/4 cup light soy sauce	0.75	cup	c	11
85	55	1 can whole mushrooms, sliced in half (it's chunkier that way)	1.0	can	can	12
85	404	1 1/2 kilogram pork spareribs	1.5	kilogram	kilogram	13
85	261	2 medium-sized shallots	2.0	\N	\N	14
85	71	2 tbsp vegetable oil	2.0	tbsp	T	15
85	7	3 cups water	3.0	cups	c	16
85	4	1 large white onion, sliced	1.0	\N	\N	17
86	24	2 cups cabbage, chopped	2.0	cups	c	0
86	42	1/2 pound ground beef/pork	0.5	pound	lb	1
86	6	1 pinch of salt	1.0	pinch	pinch	2
86	71	Vegetable oil enough to cover the wonton in the pan	1.0	serving	serving	3
86	395	2 cups chopped water chestnuts	2.0	cups	c	4
86	418	12 sheets wonton wrappers	12.0	sheets	sheets	5
87	99	1 tsp. (5ml) of organic apple cider vinegar	5.0	ml	ml	0
87	58	1 teaspoon crushed black pepper	1.0	teaspoon	t	1
87	46	1 1/2 tablespoons black sesame seeds	1.5	tablespoons	T	2
87	2	3 carrots	3.0	\N	\N	3
87	72	1/4 C extra-virgin olive oil + 7-8 Tbsp for frying	0.25	C	C	4
87	24	1/2 green cabbage	0.5	\N	\N	5
87	97	1/2 teaspoon kosher salt	0.5	teaspoon	t	6
87	149	1/2 red cabbage	0.5	\N	\N	7
87	369	3 chicken breasts (bone in, preferably organic) roasted and shredded	3.0	\N	\N	8
87	157	2 bunches romaine lettuce hearts	2.0	bunches	bunches	9
87	94	6 scallions	6.0	\N	\N	10
87	28	3 tablespoons sesame oil	3.0	tablespoons	T	11
87	0	juice of 1 mandarin (cut crosswise then tablespoon into jar over a strainer)	1.0	\N	\N	12
87	0	3 tablespoons white sesame seeds	3.0	tablespoons	T	13
87	494	1 1/2 tablespoons xylitol (I use Epic Dental brand)	1.5	tablespoons	T	14
87	492	6-8 fresh satsuma mandarins	6.0	\N	\N	15
88	14	3 eggs, beaten	3.0	\N	\N	0
88	141	2 slices fresh ginger	2.0	slices	slices	1
88	23	4 Garlic Cloves, minced	4.0	cloves	cloves	2
88	143	1 TBSP Garlic Powder	1.0	TBSP	TBSP	3
88	141	3 TBSP Ginger, minced	3.0	TBSP	TBSP	4
88	94	6 Green Onion, thinly sliced	6.0	\N	\N	5
88	142	1 TBSP Ground Ginger	1.0	TBSP	TBSP	6
88	58	1 TBSP Ground Pepper	1.0	TBSP	TBSP	7
88	30	3 TBSP Hoisin	3.0	TBSP	TBSP	8
88	174	1 cup long grain rice	1.0	cup	c	9
88	268	4 TBSP Low Sodium Soy Sauce	4.0	TBSP	TBSP	10
88	72	1 TBSP Olive Oil	1.0	TBSP	TBSP	11
88	166	1 TBSP Onion Powder	1.0	TBSP	TBSP	12
88	0	1 cup frozen peas and carrots, thawed	1.0	cup	c	13
88	402	6 oz pork tenderloin	6.0	oz	oz	14
88	6	1 TBSP Salt	1.0	TBSP	TBSP	15
89	23	4 garlic cloves, finely chopped	4.0	cloves	cloves	0
89	266	5 stalks of asian kale	5.0	stalks	stalks	1
89	54	8 fresh shitake mushrooms, sliced	8.0	\N	\N	2
89	0	350 grams fresh hokkien noodles (blanch as per packet instructions)	350.0	grams	g	3
89	467	3 tablespoons oyster sauce (to taste)	3.0	tablespoons	T	4
89	261	2 shallots, thinly sliced	2.0	\N	\N	5
89	74	2 tablespoons sweet soy sauce/kecap manis	2.0	tablespoons	T	6
90	15	3 cups of all purpose flour	3.0	cups	c	0
90	91	1 bunch of chinese chives, chopped	1.0	bunch	bunch	1
90	40	corn starch (if needed)	1.0	serving	serving	2
90	294	2 pounds of lean ground pork	2.0	pounds	lb	3
90	6	4 teaspoons of salt (or 3 1/2 tsp. if you use the dried shrimp)	4.0	teaspoons	t	4
90	28	3 tablespoons of sesame oil	3.0	tablespoons	T	5
90	7	1 cup of cold water	1.0	cup	c	6
90	90	1 teaspoon tsp. of dried shrimp (optional) soaked in 2 of water or shao	1.0	teaspoon	t	7
91	188	4 cups steamed rice	4.0	cups	c	0
91	14	4 large eggs, lightly beaten	4.0	\N	\N	1
91	141	1 piece of ginger, roughly half a thumbsize	1.0	piece	\N	2
91	94	2/3 cup green onions, finely sliced at an angle	0.6666666666666666	cup	c	3
91	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	4
91	74	4 tablespoons Light soy sauce	4.0	tablespoons	T	5
91	402	1 500 gram pork loin with skin	500.0	gram	g	6
91	4	1 small red onion, finely diced	1.0	\N	\N	7
91	28	2 teaspoons Sesame oil	2.0	teaspoons	t	8
91	71	1/4 cup vegetable oil	0.25	cup	c	9
91	114	2 teaspoons white sugar	2.0	teaspoons	t	10
91	98	1 tablespoon white vinegar	1.0	tablespoon	T	11
92	302	6-7 baby corns, cut in round disks	6.0	\N	\N	0
92	3	1 small size bell pepper, chopped in small pieces	1.0	\N	\N	1
92	58	Black pepper to taste	2.0	servings	servings	2
92	2	1 med size carrot, chopped in small pieces	1.0	\N	\N	3
92	23	3 cloves of garlic, minced	3.0	cloves	cloves	4
92	141	1 tsp ginger, minced	1.0	tsp	t	5
92	268	1 Tbsp low sodium soy sauce	1.0	Tbsp	Tbsp	6
92	55	1 cup mushrooms, chopped	1.0	cup	c	7
92	4	1/4 cup green onions white part, chopped (Keep the chopped green part of green onions for garnishing)	0.25	cup	c	8
92	6	Salt to taste	2.0	servings	servings	9
92	28	2 teaspoons toasted sesame oil	2.0	teaspoons	t	10
92	46	1 tsp sesame seeds	1.0	tsp	t	11
93	58	Black pepper	2.0	servings	servings	0
93	343	50 g blue cheese of your choice	50.0	g	g	1
93	181	1/4 cup breadcrumbs	0.25	cup	c	2
93	10	1/2 tbs butter	0.5	tbs	tbs	3
93	91	Fresh chives, chopped	2.0	servings	servings	4
93	23	2 cloves garlic, minced	2.0	cloves	cloves	5
93	55	4 large mushrooms (about 400g), stems separated from caps	400.0	g	g	6
93	72	1 tablespoon olive oil	1.0	tablespoon	T	7
93	4	1 small Onion, halved lengthwise & cut crosswise into fine half rings	1.0	\N	\N	8
93	183	2 tbs Parmesan cheese, grated	2.0	tbs	tbs	9
93	43	3 tablespoons chopped parsley	3.0	tablespoons	T	10
93	420	400g Chow Mein Noodles or rice pasta	400.0	g	g	11
93	327	250g ricotta cheese	250.0	g	g	12
93	96	1/4 tsp sea salt	0.25	tsp	t	13
93	126	2 tbs sour cream	2.0	tbs	tbs	14
93	164	1 1/2 cups fresh spinach, finely chopped	1.5	cups	c	15
94	174	2 cup Basmati Rice	2.0	cups	c	0
94	33	1/2 cup Beans	0.5	cup	c	1
94	3	Bell peppers - I used half of red and yellow colour	1.0	servings	servings	2
94	24	1/4 cup Cabbage - finely grated	0.25	cup	c	3
94	2	1/4 cup minced carrot	0.25	cup	c	4
94	321	Cashews and raisins	2.0	servings	servings	5
94	135	Green chilies - 2 to 3 depending on your taste	2.0	\N	\N	6
94	242	1/4 cup Corn	0.25	cup	c	7
94	0	Ginger garlic paste - 1 tbspn	1.0	tbsp	T	8
94	4	1 small Onion - finely sliced	1.0	\N	\N	9
94	62	1/4 cup Green peas	0.25	cup	c	10
94	280	Salt and pepper to taste	2.0	servings	servings	11
94	74	Soya sauce - 1 tbspn	1.0	tbsp	T	12
94	79	chili sauce/tomato sauce - 1 tbspn	1.0	tbsp	T	13
94	71	Oil - 3 tablespoons	3.0	tbsp	T	14
95	50	1 teaspoon brown sugar	1.0	teaspoon	t	0
95	92	Cilantro (or parsley) for garnish	4.0	servings	servings	1
95	14	3 eggs, well beaten	3.0	\N	\N	2
95	23	2 cloves garlic, minced	2.0	cloves	cloves	3
95	141	1-inch piece of ginger, grated	1.0	inch	inch	4
95	94	2 green onions, thinly sliced, including the greens	2.0	\N	\N	5
95	72	1 Tbsp olive oil	1.0	Tbsp	Tbsp	6
95	38	1 cup frozen peas, thawed	1.0	cup	c	7
95	76	2/3 cup diced red bell pepper	0.6666666666666666	cup	c	8
95	4	2/3 cup diced red onion	0.6666666666666666	cup	c	9
95	174	4 cups day old cooked white rice (from about 2 cups of raw rice)	4.0	cups	c	10
95	393	2 cups cooked salmon in large chunks	2.0	cups	c	11
95	74	3 Tbsp soy sauce	3.0	Tbsp	Tbsp	12
96	275	2 cups of chicken stock	2.0	cups	c	0
96	104	Seasoning cubes	1.0	cubes	cubes	1
96	262	3 slices of mango cubed	3.0	slices	slices	2
96	111	1 cup of chopped vegetables	1.0	cup	c	3
96	174	1 cup of rice	1.0	cup	c	4
96	107	1 scotch bonnet pepper	1.0	\N	\N	5
97	239	2 cups cooked broccoli, chopped small	2.0	cups	c	0
97	69	head of cauliflower, raw	1.0	head	head	1
97	257	1 + 1 T coconut oil or butter	1.0	\N	\N	2
97	0	3 cups of cooked brown rice, cold	3.0	cups	c	3
97	23	5 cloves of garlic, chopped	5.0	cloves	cloves	4
97	140	1 + 1 T grapeseed oil	1.0	\N	\N	5
97	268	3T reduced-sodium soy sauce	3.0	T	T	6
97	38	1 cup frozen peas	1.0	cup	c	7
97	6	salt, to taste	2.0	servings	servings	8
97	94	additional chopped scallion tops for garnish	2.0	servings	servings	9
97	94	7 scallions, chopped (keep white/light green ends separate from dark green tops)	7.0	\N	\N	10
97	28	2t toasted sesame oil	2.0	t	t	11
97	46	toasted sesame seeds, optional	2.0	servings	servings	12
98	408	4-5 pounds stew cut meat*, cut into bite-sized chunks	4.0	pounds	lb	0
98	79	1 large can tomato sauce (approx 4 cups)	1.0	can	can	1
98	325	1 Tbsp. caraway seeds	1.0	Tbsp	Tbsp	2
98	275	1/2 cup beef or chicken stock (or water)	0.5	cup	c	3
98	15	flour for searing meat	12.0	servings	servings	4
98	23	2 garlic cloves, sliced thin	2.0	cloves	cloves	5
98	41	2 tsp. Hungarian Hot Paprika	2.0	tsp	t	6
98	97	kosher salt & pepper to taste	12.0	servings	servings	7
98	146	zest of 1 small lemon	1.0	\N	\N	8
98	72	olive oil for searing	12.0	servings	servings	9
98	4	2 large onions, sliced thin	2.0	\N	\N	10
98	41	1 Tbsp. mild paprika	1.0	Tbsp	T	11
98	15	flour seasoned with Kosher salt & cracked pepper-- about 1 cup flour, 1 Tbsp salt & pepper	1.0	cup	c	12
98	97	1/2 Tbsp salt	0.5	Tbsp	T	13
98	58	1/2 Tbsp pepper	0.5	Tbsp	T	14
98	70	2 Tbsp. tomato paste	2.0	Tbsp	T	15
99	56	8 oz fresh Bella mushrooms (crimini or regular okay)	8.0	oz	oz	0
99	0	1 packet beef stroganoff powder (McCormick)	1.0	packet	packet	1
99	23	1 small garlic clove, finely chopped	1.0	clove	clove	2
99	4	2 onions peeled, sliced	2.0	\N	\N	3
99	44	parsley flakes (garnish)	4.0	servings	servings	4
99	280	salt and pepper to taste	4.0	servings	servings	5
99	126	1 cup sour cream	1.0	cup	c	6
99	10	unsalted butter for rubbing squash, plus 1 tbsp	4.0	servings	servings	7
99	419	4 cups wide egg noodles	4.0	cups	c	8
99	137	2 tablespoons Worcestershire sauce	2.0	tablespoons	T	9
100	442	1/2 cup Buckwheat flour	0.5	cup	c	0
100	10	Melted butter	1.0	serving	serving	1
100	97	1 pch coarse salt	1.0	\N	\N	2
100	97	1 teaspoon coarse salt plus	1.0	teaspoon	t	3
100	14	6 lrgs eggs separated	6.0	\N	\N	4
100	15	2 cups All-purpose flour	2.0	cups	c	5
100	20	1 cup warm milk (105 to 115 degrees)	1.0	cup	c	6
100	114	1 pch sugar	1.0	\N	\N	7
100	114	1 tablespoon sugar plus	1.0	tablespoon	T	8
100	71	Vegetable oil for cooking	1.0	serving	serving	9
100	460	1/3 cup wheat beer	0.3333333333333333	cup	c	10
100	198	1 ounce fresh yeast	1.0	ounce	oz	11
101	390	3/4 gram jar caviar	0.75	gram	g	0
101	10	large knob of butter	2.0	servings	servings	1
101	126	2 tblsp sour cream	2.0	tb	tb	2
101	439	4 duck eggs	4.0	\N	\N	3
101	280	salt & freshly ground black pepper	2.0	servings	servings	4
101	7	2 tblsp water	2.0	tb	tb	5
102	170	1 can peas or 1 Cup of frozen peas	1.0	can	can	0
102	0	1 Can cream of mushroom soup	1.0	Can	Can	1
102	419	3 Cups egg noodles	3.0	Cups	Cups	2
102	55	4 oz fresh mushrooms – sliced	4.0	oz	oz	3
102	20	1/2 cup milk	0.5	cup	c	4
102	4	1 medium onion	1.0	\N	\N	5
102	58	1/2 tsp pepper	0.5	tsp	t	6
102	6	1/2 teaspoon salt	0.5	teaspoon	t	7
102	452	1.25 lbs beef flank or sirloin steak – cut across the grain, thin sliced	1.25	lbs	lb	8
102	345	8 oz. velveeta	8.0	oz	oz	9
102	7	1 cup water	1.0	cup	c	10
103	279	2 beef bouillon cubes	2.0	\N	\N	0
103	0	2 1/2 lb.s top round beef roast	2.5	lb	lb	1
103	15	2 tbsp.s flour	2.0	tbsp	T	2
103	58	1/2 tsp. ground pepper	0.5	tsp	t	3
103	71	3 tbsp.s oil	3.0	tbsp	T	4
103	4	1 lg. onion, sliced	1.0	\N	\N	5
103	41	3 tbsp.s paprika	3.0	tbsp	T	6
103	79	8 oz.s tomato sauce	8.0	oz	oz	7
103	7	4 c.s water, to cover meat	4.0	c	c	8
104	386	1 ounce x 9 package frozen artichoke hearts thawed	1.0	ounce	oz	0
104	296	1 1/2 pounds beef stew meat cut into 1 inch cubes	1.5	pounds	lb	1
104	272	1 (14 1/2 oz.) can beef broth	14.5	oz	oz	2
104	67	1 x 14 ounce can chunky tomatoes with garlic	14.0	oz	oz	3
104	70	1 x 6 ounce can tomato paste	6.0	oz	oz	4
104	421	3 cups hot cooked noodles	3.0	cups	c	5
104	126	cup dairy sour cream	1.0	cup	c	6
104	286	1 teaspoon caraway seed or fennel seed	1.0	teaspoon	t	7
104	23	1 Clove garlic, minced	1.0	Clove	Clove	8
104	4	2 mediums onions, chopped	2.0	\N	\N	9
104	27	3 mediums potatoes cut into 1 inch cubes	3.0	\N	\N	10
104	6	1 teaspoon Salt	1.0	teaspoon	t	11
105	10	1 ounce butter	1.0	ounce	oz	0
105	67	16 ozs canned tomatoes	16.0	ozs	oz	1
105	2	1 piece sm. carrot, sliced	1.0	piece	\N	2
105	296	4 ounces chuck steak, cubed	4.0	ounces	oz	3
105	482	Pinch of garlic salt	1.0	pinch	pinch	4
105	3	1 piece green pepper, seeded and sliced	1.0	piece	\N	5
105	4	2 onions, peeled and chopped	2.0	\N	\N	6
105	41	1 1/2 teaspoons Paprika	1.5	teaspoons	t	7
105	58	1/4 teaspoon Pepper	0.25	teaspoon	t	8
105	403	5 ounces lean pork, cubed	5.0	ounces	oz	9
105	6	1 teaspoon Salt (celery and the vinegar are naturally salty)	1.0	teaspoon	t	10
105	126	1/2 pint of sour cream	0.5	pint	pt	11
106	12	1 tsp cinnamon	1.0	tsp	t	0
106	14	2 eggs (or egg substitutes for vegans; you can also add 1-2 tbsp of dry yeast flakes)	2.0	\N	\N	1
106	181	150 g gluten-free bread crumbs	150.0	g	g	2
106	440	25 plums, pitted	25.0	\N	\N	3
106	128	1 kg mashed red skin potatoes (red potatoes have a higher amount of starch so the dough is stickier)	1.0	kg	kg	4
106	0	1/2 tsp rum extract	0.5	tsp	t	5
106	0	3-4 tbsp sucanat	3.0	tbsp	T	6
106	255	2 tbsp unrefined sunflower oil	2.0	tbsp	T	7
106	134	1 tsp vanilla extract	1.0	tsp	t	8
106	110	250 g whole wheat flour ( you can also use different flours like soy/almonds/rye flour)	250.0	g	g	9
107	225	4 Bay leaves	4.0	\N	\N	0
107	250	2 stalk celery	2.0	stalk	stalk	1
107	14	6 raw eggs	6.0	\N	\N	2
107	71	3 tablespoons oil, (I use corn or peanu	3.0	tablespoons	T	3
107	4	2 onions, peeled and chopped	2.0	\N	\N	4
107	43	2 tablespoons chopped parsley leaves	2.0	tablespoons	T	5
107	58	1/4 teaspoon black pepper corns	0.25	teaspoon	t	6
107	441	1 mild pepperoni sausage cut into 2 inch chunks (p	1.0	\N	\N	7
107	27	5 mediums potatoes, peeled and cut in small cubes	5.0	\N	\N	8
107	6	2 tablespoons salt	2.0	tablespoons	T	9
107	126	8 ounces sour cream	8.0	ounces	oz	10
107	7	3 quarts ,Water	3.0	quarts	quarts	11
107	98	3 tablespoons of good white vinegar	3.0	tablespoons	T	12
108	225	1 Bay leaf	1.0	\N	\N	0
108	2	4 Carrots	4.0	\N	\N	1
108	23	2 Cloves garlic, crushed.	2.0	Cloves	Cloves	2
108	4	1 medium onion sliced	1.0	\N	\N	3
108	0	1/2 teaspoon Onion salt	0.5	teaspoon	t	4
108	41	3 teaspoons paprika	3.0	teaspoons	t	5
108	58	1/4 teaspoon pepper to taste	0.25	teaspoon	t	6
108	296	1 Lean, (3-4 lb) chuck or rump roast	3.0	lb	lb	7
108	6	salt to taste	1.0	serving	serving	8
108	126	8 ounces sour cream	8.0	ounces	oz	9
108	79	2 can (8 oz) Hunt's tomato sauce with Mushrooms	8.0	oz	oz	10
108	71	2 tablespoons Vegetable oil	2.0	tablespoons	T	11
108	7	3 quarts ,Water	3.0	quarts	quarts	12
109	431	1 1/2 pounds brussels sprouts	1.5	pounds	lb	0
109	247	1 can white kidney beans	1.0	can	can	1
109	283	2 tablespoons coarse mustard	2.0	tablespoons	T	2
109	72	extra-virgin olive oil, kosher salt, and freshly-ground blac	4.0	servings	servings	3
109	23	4 large cloves garlic	4.0	cloves	cloves	4
109	311	1/4 cup heavy cream	0.25	cup	c	5
109	394	1 pound pork kielbasa	1.0	pound	lb	6
109	261	1 medium shallot	1.0	\N	\N	7
110	0	12 cooked baby beets	12.0	\N	\N	0
110	225	1 bay leaf	1.0	\N	\N	1
110	58	freshly ground black pepper	4.0	servings	servings	2
110	390	4 teaspoons Arenkha MSC caviar	4.0	teaspoons	t	3
110	72	6 tbsp extra-virgin olive oil	6.0	tbsp	T	4
110	285	1 head fennel, outside leaves discarded, finely sliced	1.0	head	head	5
110	18	2 tbsp lemon juice	2.0	tbsp	T	6
110	391	4 110g (4oz) skinless salmon fillets	16.0	oz	oz	7
110	232	tarragon stalks	1.0	stalks	stalks	8
110	232	few tarragon leaves	3.0	leaves	leaves	9
110	0	1 bunch watercress, picked over, washed & dried	1.0	bunch	bunch	10
110	320	1 tablespoon white wine	1.0	tablespoon	T	11
111	10	2 tablespoons butter	2.0	tablespoons	T	0
111	325	1-1/2 teaspoons caraway seeds	1.0	teaspoons	t	1
111	271	3 cups chicken broth	3.0	cups	c	2
111	15	1 cup All-purpose Flour	1.0	cup	c	3
111	23	1 large garlic clove, miced	1.0	clove	clove	4
111	311	2 cups • heavy cream, for whipping	2.0	cups	c	5
111	41	2 tablespoons sweet Hungarian paprika	2.0	tablespoons	T	6
111	4	1 cup onion, finely chopped	1.0	cup	c	7
111	396	4 pounds boneless pork shoulder, cut in 2-inch cubes	4.0	pounds	lb	8
111	6	1/4 teaspoon • Salt	0.25	teaspoon	t	9
111	459	1 pound (drained weight) sauerkraut	1.0	pound	lb	10
111	126	1/2 cup sour cream	0.5	cup	c	11
111	79	1/4 cup tomato puree or plain tomato sauce	0.25	cup	c	12
112	3	1 Pepper, Chopped	1.0	\N	\N	0
112	67	1 can of Diced Tomatoes	1.0	can	can	1
112	422	6 ounces of Egg Noodles, Cooked	6.0	ounces	oz	2
112	223	1 teaspoon of Coriander	1.0	teaspoon	t	3
112	48	1 teaspoon of Cumin	1.0	teaspoon	t	4
112	80	1/2 teaspoon of Curry	0.5	teaspoon	t	5
112	185	1 teaspoon of Garam Masala*	1.0	teaspoon	t	6
112	23	3 cloves of Garlic	3.0	cloves	cloves	7
112	141	1/2 teaspoon of Ginger	0.5	teaspoon	t	8
112	260	1 pound of Ground Turkey or 3 cups Leftover Turkey, chopped	1.0	pound	lb	9
112	4	1 Onion, Chopped	1.0	\N	\N	10
112	41	1 teaspoon of Paprika	1.0	teaspoon	t	11
112	126	1 cup of Sour Cream	1.0	cup	c	12
112	165	10 bags Oz. of Frozen Spinach or 1 of Fresh	10.0	bags	bags	13
112	271	1 cup of Chicken or Turkey Broth	1.0	cup	c	14
113	10	40g Butter	40.0	g	g	0
113	513	150g Good-quality dark chocolate	150.0	g	g	1
113	109	2 Egg yolks	2.0	\N	\N	2
113	14	1 Eggs	1.0	\N	\N	3
113	114	20g Granulated sugar	20.0	g	g	4
113	483	200g Nutella	200.0	g	g	5
113	6	1 pinch Salt	1.0	pinch	pinch	6
113	0	50cl Skimmed milk	50.0	cl	cl	7
113	15	250g Wheat flour	250.0	g	g	8
114	238	1 lrg eggplant unpeeled, diced	1.0	\N	\N	0
114	330	4 ounces diced feta cheese (optional)	4.0	ounces	oz	1
114	87	1/2 cup chopped fresh basil	0.5	cup	c	2
114	23	5 garlic cloves chopped	5.0	cloves	cloves	3
114	3	2 green bell peppers diced	2.0	\N	\N	4
114	72	3 tablespoons Olive Oil	3.0	tablespoons	T	5
114	4	1 onion cut 1" pieces	1.0	\N	\N	6
114	100	2 tablespoons red wine vinegar	2.0	tablespoons	T	7
114	47	2 lrg tomatoes chopped	2.0	\N	\N	8
114	233	1 lrg zucchini cut 1/2" pieces	1.0	\N	\N	9
115	15	1 cup all purpose flour (sifted)	1.0	cup	c	0
115	9	4 ripe bananas (works great with freckled ones) peeled, sliced lengthwise and quartered.	4.0	\N	\N	1
115	50	1/2 cup brown sugar	0.5	cup	c	2
115	12	1 pinch cinnamon	1.0	pinch	pinch	3
115	312	Optional fresh whipped cream	1.0	serving	serving	4
115	14	1 egg	1.0	\N	\N	5
115	20	1 cup milk	1.0	cup	c	6
115	16	1 pinch nutmeg	1.0	pinch	pinch	7
115	6	1 pinch salt	1.0	pinch	pinch	8
115	114	2 teaspoons sugar	2.0	teaspoons	t	9
115	10	1 teaspoon melted butter, plus 1/2 c. butter for greasing 1 stick of butter, cubed- (use unsalted butter to cont	1.0	teaspoon	t	10
116	22	2 smalls bacon rasher, sliced to strips	2.0	\N	\N	0
116	0	500 grams of gravy beef, trimmed and cut into 2cm pieces, coated in pl	500.0	grams	g	1
116	276	200 ml of beef stock	200.0	ml	ml	2
116	55	200 grams of button mushrooms	200.0	grams	g	3
116	311	2 tablespoons of cream	2.0	tablespoons	T	4
116	319	80 ml of dry red wine	80.0	ml	ml	5
116	43	1/4 cup of finely chopped fresh flat leaf parsley	0.25	cup	c	6
116	85	1 teaspoon of fresh thyme leaves	1.0	teaspoon	t	7
116	38	2 cups of green peas thawed	2.0	cups	c	8
116	4	1 teaspoon of olive oil 2 tablespoons of finely chopped brown onion	2.0	tablespoons	T	9
116	72	2 teaspoons of olive oil	2.0	teaspoons	t	10
116	4	4 pickling onions, peeled and halved	4.0	\N	\N	11
116	444	1 sheet of ready rolled butter puff pastry	1.0	sheet	sheet	12
116	280	A pinch of salt and pepper	1.0	pinch	pinch	13
116	70	2 teaspoons of tomato paste	2.0	teaspoons	t	14
116	105	2 tablespoons of vegetable stock	2.0	tablespoons	T	15
117	196	1 pkt active dry yeast	1.0	\N	\N	0
117	10	1 stick of butter	1.0	stick	stick	1
117	109	2 lrg egg yolks	2.0	\N	\N	2
117	14	3 lrg eggs	3.0	\N	\N	3
117	15	5 1/2 cups flour	5.5	cups	c	4
117	6	1/2 teaspoon salt	0.5	teaspoon	t	5
117	114	1/2 cup sugar	0.5	cup	c	6
117	7	cup water	1.0	cup	c	7
118	320	1/2 cup dry white wine	0.5	cup	c	0
118	43	3 sprigs fresh parsley	3.0	sprigs	sprigs	1
118	23	4 garlic cloves, finely chopped	4.0	cloves	cloves	2
118	97	Kosher salt	2.0	servings	servings	3
118	349	1/2 cup low-fat buttermilk	0.5	cup	c	4
118	203	2 pounds mussels, cleaned	2.0	pounds	lb	5
118	72	1 tbs olive oil	1.0	tbs	tbs	6
118	261	2 shallots, finely chopped	2.0	\N	\N	7
118	10	4 tablespoons unsalted light butter, cut into pieces	4.0	tablespoons	T	8
119	58	1/2 teaspoon black pepper	0.5	teaspoon	t	0
119	0	cooked penne	2.0	servings	servings	1
119	88	1 teaspoon dried basil	1.0	teaspoon	t	2
119	45	1 teaspoon dried oregano	1.0	teaspoon	t	3
119	238	1 cup diced eggplant	1.0	cup	c	4
119	23	2 cloves garlic, minced	2.0	cloves	cloves	5
119	0	1 tablespoon mascarpone cheese	1.0	tablespoon	T	6
119	72	1 tablespoon olive oil	1.0	tablespoon	T	7
119	4	1/4 cup diced onion	0.25	cup	c	8
119	76	1 cup diced red bell pepper	1.0	cup	c	9
119	6	Pinch salt	1.0	pinch	pinch	10
119	7	1/4 cup water	0.25	cup	c	11
119	233	1 cup diced zucchini	1.0	cup	c	12
119	79	1 cup tomato sauce, or ground peeled tomatoes	1.0	cup	c	13
120	296	4 lbs chuck roast	4.0	lbs	lb	0
120	23	7 cloves garlic,peeled	7.0	cloves	cloves	1
120	284	1 TBSP Ground Mustard	1.0	TBSP	TBSP	2
120	457	1 TBSP Italian Seasoning	1.0	TBSP	TBSP	3
120	274	32 oz low sodium beef broth	32.0	oz	oz	4
120	4	1 onion, cut into quarters	1.0	\N	\N	5
120	58	1 TBSP Pepper	1.0	TBSP	TBSP	6
120	221	4 rolls ( I used mini ciabatta rolls)	4.0	\N	\N	7
121	311	2 cups cream	2.0	cups	c	0
121	435	dulce de leche	1.0	serving	serving	1
121	109	5 large egg yolks	5.0	\N	\N	2
121	114	1/2 cup sugar	0.5	cup	c	3
122	276	4 cups - Beef Stock	4.0	cups	c	0
122	10	8 Tbs. - Butter	8.0	Tb	Tb	1
122	275	4 cups - Chicken Stock	4.0	cups	c	2
122	168	1 cup - Shredded Colby & Monterey Jack Cheese	1.0	cup	c	3
122	40	Corn Starch to thicken soup	1.0	serving	serving	4
122	222	8 Slices - French Bread (1 inch)	8.0	Slices	Slices	5
122	23	2 Tbs. - Johnny's Garlic Seasoning	2.0	Tb	Tb	6
122	0	1 Tbs. - Montreal Steak Seasoning	1.0	Tb	Tb	7
122	4	1 Large Onion (diced)	1.0	\N	\N	8
122	58	Pepper to taste	1.0	serving	serving	9
122	172	1 cup - Shredded Mozzarella Cheese	1.0	cup	c	10
122	71	2 Tbs. - Oil	2.0	Tb	Tb	11
123	15	1 1/2 tablespoons all purpose flour	1.5	tablespoons	T	0
123	272	2 cups beef broth	2.0	cups	c	1
123	296	1 pound beef chuck (stewing beef)	1.0	pound	lb	2
123	55	2 pints button mushrooms (about 20 mushrooms), rinsed, stems removed, cut in half	2.0	pints	pt	3
123	2	Carrots	4.0	servings	servings	4
123	122	1/4 teaspoon cayenne pepper	0.25	teaspoon	t	5
123	84	1/2 teaspoon dried rosemary	0.5	teaspoon	t	6
123	86	1/2 teaspoon dried thyme	0.5	teaspoon	t	7
123	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	8
123	4	1/2 cup chopped onion	0.5	cup	c	9
123	319	1 cup red wine	1.0	cup	c	10
124	10	1 tablespoon butter	1.0	tablespoon	T	0
124	14	4 lrg eggs	4.0	\N	\N	1
124	341	1 1/2 cups shredded gruyere cheese	1.5	cups	c	2
124	311	3 cups heavy cream	3.0	cups	c	3
124	7	3 tablespoons ice water	3.0	tablespoons	T	4
124	25	2 leeks	2.0	\N	\N	5
124	15	1 cup flour, plain	1.0	cup	c	6
124	6	salt	1.0	serving	serving	7
124	280	salt and pepper to taste	1.0	serving	serving	8
124	126	1 tablespoon sour cream	1.0	tablespoon	T	9
124	20	3 cups whole milk	3.0	cups	c	10
125	15	1 1/4 cups all-purpose flour	1.25	cups	c	0
125	22	6 slices bacon	6.0	slices	slices	1
125	10	3 tablespoons Butter	3.0	tablespoons	T	2
125	14	4 eggs	4.0	\N	\N	3
125	58	1/4 teaspoon ground pepper	0.25	teaspoon	t	4
125	25	2 Leek, chopped	2.0	\N	\N	5
125	20	2/3 cup milk	0.6666666666666666	cup	c	6
125	56	1 pound white or baby portobello mushrooms, sliced	1.0	pound	lb	7
125	128	3 red potatoes, boiled and sliced	3.0	\N	\N	8
125	6	pinch of salt	1.0	pinch	pinch	9
125	114	1/4 cup sugar	0.25	cup	c	10
125	7	4 cups of water	4.0	cups	c	11
126	251	75 grams Asparagus spears, blanched	75.0	grams	g	0
126	468	8 Black olives, pitted and quartered	8.0	\N	\N	1
126	239	75 grams Broccoli florets, blanched	75.0	grams	g	2
126	168	50 grams Cheddar cheese, grated	50.0	grams	g	3
126	14	2 eggs, beaten	2.0	\N	\N	4
126	330	50 grams Feta cheese, crumbled	50.0	grams	g	5
126	25	1 Leek cleaned and thinly sliced	1.0	\N	\N	6
126	20	Milk	4.0	servings	servings	7
126	172	75 grams Mozzarella, thinly sliced	75.0	grams	g	8
126	4	2 tablespoons Minced onion	2.0	tablespoons	T	9
126	0	1 teaspoon Pesto	1.0	teaspoon	t	10
126	392	418 grams Canned Alaska salmon (red or pink)	418.0	grams	g	11
126	280	Salt and black pepper	4.0	servings	servings	12
126	446	550 grams Ready-made shortcrust pastry	550.0	grams	g	13
126	310	300 ml Single cream	300.0	ml	ml	14
126	393	50 grams Smoked salmon	50.0	grams	g	15
126	94	4 Spring onions, chopped	4.0	\N	\N	16
126	0	50 grams Stilton cheese, crumbled	50.0	grams	g	17
126	47	4 Fresh tomatoes, skinned, de-seeded, chopped	4.0	\N	\N	18
127	387	14 ounces can of Artichokes, rinsed, chopped into bite size pieces	14.0	ounces	oz	0
127	67	14 ounces can Diced Tomatoes	14.0	ounces	oz	1
127	238	1 small eggplant	1.0	\N	\N	2
127	72	extra-virgin olive oil, for serving	4.0	servings	servings	3
127	23	4 cloves Garlic, minced	4.0	cloves	cloves	4
127	457	1 teaspoon Italian Seasoning	1.0	teaspoon	t	5
127	72	4 oz. olive oil (for sautéing and garnishing)	4.0	oz	oz	6
127	183	Fresh grated Parmesan or Romano, for serving	4.0	servings	servings	7
127	96	Sea salt and fresh pepper	4.0	servings	servings	8
127	365	8 ounces Spaghetti (like Barila Whole Grain)	8.0	ounces	oz	9
127	4	1 large Yellow Onion, diced	1.0	\N	\N	10
127	233	1 zucchini	1.0	\N	\N	11
128	342	1 Brie Log such as Alouette	1.0	\N	\N	0
128	238	1 small eggplant	1.0	\N	\N	1
128	72	1/2 cup extra-virgin olive oil	0.5	cup	c	2
128	375	2 ripe plum tomatoes	2.0	\N	\N	3
128	85	1 tsp. thyme (chopped)	1.0	tsp	t	4
128	234	2 medium-sized yellow squash, sliced	2.0	\N	\N	5
128	233	2 medium-sized zucchini, sliced	2.0	\N	\N	6
129	67	1 cup (28-ounce) can good-quality plum tomatoes, chopped, with their juices to make 2	28.0	ounce	oz	0
129	56	1 cup sliced crimini mushrooms (about 5 medium)	1.0	cup	c	1
129	181	1 tablespoon dry bread crumbs	1.0	tablespoon	T	2
129	320	1/2 cup dry white wine (sauvignon blanc is nice)	0.5	cup	c	3
129	238	1 medium eggplant (about 1 pound), cut into 1-inch cubes	1.0	pound	lb	4
129	87	1/2 cup chopped fresh basil for garnish	0.5	cup	c	5
129	83	1 tablespoon chopped fresh rosemary	1.0	tablespoon	T	6
129	85	1 tablespoon chopped fresh thyme	1.0	tablespoon	T	7
129	25	1 leek, white part only, thinly sliced	1.0	\N	\N	8
129	72	Olive oil	4.0	servings	servings	9
129	183	1 cup freshly grated Parmesan cheese	1.0	cup	c	10
129	58	Dash black pepper	1.0	Dash	Dash	11
129	76	1/2 red pepper	0.5	\N	\N	12
129	96	1 teaspoon sea salt	1.0	teaspoon	t	13
129	261	1 large shallot, finely chopped	1.0	\N	\N	14
129	233	1 cup thinly sliced zucchini (about 1 medium)	1.0	cup	c	15
130	239	2 cups broccoli florets, cut into small pieces	2.0	cups	c	0
130	10	1 tablespoon butter	1.0	tablespoon	T	1
130	283	2 teaspoons dijon mustard	2.0	teaspoons	t	2
130	14	1 large egg white	1.0	\N	\N	3
130	18	2 tablespoons lemon juice	2.0	tablespoons	T	4
130	85	1 tablespoon lemon thyme, fresh finely chopped	1.0	tablespoon	T	5
130	146	1 tablespoon lemon zest	1.0	tablespoon	T	6
130	64	1/4 cup low-fat milk	0.25	cup	c	7
130	127	4 tablespoons reduced fat sour cream	4.0	tablespoons	T	8
130	391	8 ounces wild Alaskan Salmon filets, cooked and flaked into pieces	8.0	ounces	oz	9
130	6	1 pinch salt	1.0	pinch	pinch	10
130	261	2 tablespoons shallot, finely minced	2.0	tablespoons	T	11
130	7	1/4 cup water	0.25	cup	c	12
130	110	1/2 cup whole wheat pastry flour	0.5	cup	c	13
131	45	¼ tsp dried oregano	0.25	tsp	t	0
131	238	1 eggplant (aubergine) or 4 cups chopped	1.0	\N	\N	1
131	72	2 Tbsp extra-virgin olive oil	2.0	Tbsp	Tbsp	2
131	87	2 Tbsp chopped fresh basil	2.0	Tbsp	Tbsp	3
131	23	1 tablespoon minced garlic	1.0	tablespoon	T	4
131	4	1 large onion, peeled & finely cut up	1.0	\N	\N	5
131	81	1/2 orange bell pepper chopped	0.5	\N	\N	6
131	76	1 medium red bell ( sweet ) pepper, washed, cleaned, pits & white bits removed, cut into little pieces	1.0	\N	\N	7
131	96	1 tsp sea salt	1.0	tsp	t	8
131	85	2 sprigs of thyme	2.0	sprigs	sprigs	9
131	47	2 tomato peeled and chopped	2.0	\N	\N	10
131	234	1 yellow squash chopped	1.0	\N	\N	11
131	233	1 zucchini (courgette) chopped	1.0	\N	\N	12
132	87	1/2 teaspoon basil	0.5	teaspoon	t	0
132	207	1 cup Bisquick	1.0	cup	c	1
132	11	1/2 cup vegetable or canola oil	0.5	cup	c	2
132	14	3 Eggs	3.0	\N	\N	3
132	23	1 garlic clove, minced	1.0	clove	clove	4
132	4	1/2 cup finely chopped onion	0.5	cup	c	5
132	45	1/2 teaspoon oregano	0.5	teaspoon	t	6
132	183	1/4 cup shredded Parmesan cheese	0.25	cup	c	7
132	43	2 tablespoons fresh Italian Parsley	2.0	tablespoons	T	8
132	58	1/2 teaspoon pepper	0.5	teaspoon	t	9
132	6	1/8 teaspoon salt	0.125	teaspoon	t	10
132	233	1 zucchini, chopped into bite sized pieces	1.0	\N	\N	11
133	308	blueberries	1.0	serving	serving	0
133	0	your favorite crêpes	1.0	serving	serving	1
133	330	crumbled feta cheese	1.0	serving	serving	2
133	89	raspberry fruit spread or jam	1.0	serving	serving	3
133	307	raspberries	1.0	serving	serving	4
134	12	cinnamon, optional	2.0	servings	servings	0
134	14	4 eggs	4.0	\N	\N	1
134	19	Maple syrup	2.0	servings	servings	2
134	0	Mixed fresh fruit	2.0	servings	servings	3
134	16	nutmeg, optional	2.0	servings	servings	4
134	72	olive oil or butter for frying	2.0	servings	servings	5
134	20	1/2 cup milk or soy milk	0.5	cup	c	6
134	222	6 slices toast	6.0	slices	slices	7
135	9	1 banana	1.0	\N	\N	0
135	0	120ml carbonated water	120.0	ml	ml	1
135	14	4 eggs	4.0	\N	\N	2
135	20	400ml milk	400.0	ml	ml	3
135	483	4 tablespoons nutella	4.0	tablespoons	T	4
135	71	6 tablespoons oil	6.0	tablespoons	T	5
135	15	400g white flour	400.0	g	g	6
136	240	1 bunch broccoli rabe, chopped	1.0	bunch	bunch	0
136	10	cup butter	1.0	cup	c	1
136	14	3 hard cooked eggs, diced	3.0	\N	\N	2
136	15	cups all-purpose flour	1.0	cups	c	3
136	23	1/2 clove garlic, minced	0.5	clove	clove	4
136	20	cup whole milk	1.0	cup	c	5
136	4	1 large onion quartered	1.0	\N	\N	6
136	183	Garnish: Parmesan cheese, lemon juice	3.0	servings	servings	7
136	43	1/4 cup parsley, minced	0.25	cup	c	8
136	58	1/8 teaspoon pepper	0.125	teaspoon	t	9
136	432	1/4 cup pine nuts	0.25	cup	c	10
136	0	1/4 pound sliced prosciutto, chopped	0.25	pound	lb	11
136	6	1/2 teaspoon salt	0.5	teaspoon	t	12
137	87	1 teaspoon Basil, dried(or marjoram)	1.0	teaspoon	t	0
137	181	1/3 cup breadcrumbs	0.3333333333333333	cup	c	1
137	14	1 extra large egg	1.0	\N	\N	2
137	293	500 grams Ground meat (a mix of pork and beef)	500.0	grams	g	3
137	20	30 60ml milk	1800.0	ml	ml	4
137	71	1/2 tablespoon Oil	0.5	tablespoon	T	5
137	4	70 grams Onions	70.0	grams	g	6
137	6	1 teaspoon salt	1.0	teaspoon	t	7
137	60	1 teaspoon White pepper	1.0	teaspoon	t	8
138	8	2 teaspoons baking powder	2.0	teaspoons	t	0
138	10	1/2 pound butter	0.5	pound	lb	1
138	0	175 grams Cranberries, dried	175.0	grams	g	2
138	14	6 eggs	6.0	\N	\N	3
138	15	375 grams German#405 flour, sifted	375.0	grams	g	4
138	145	3 Lemons	3.0	\N	\N	5
138	229	150 grams Powdered sugar	150.0	grams	g	6
138	6	1/2 teaspoon Salt, optional	0.5	teaspoon	t	7
138	114	1/2 pound sugar	0.5	pound	lb	8
138	310	75 ml Whipping cream	75.0	ml	ml	9
139	272	1 cup Beef broth	1.0	cup	c	0
139	181	3 tablespoons Bread crumbs	3.0	tablespoons	T	1
139	283	1 teaspoon Dijon mustard, hot	1.0	teaspoon	t	2
139	14	2 eggs, well-beaten	2.0	\N	\N	3
139	294	1/2 pound Lean ground pork, shoulder	0.5	pound	lb	4
139	291	1 pound Lean ground beef	1.0	pound	lb	5
139	4	1 small onion, grated	1.0	\N	\N	6
139	41	2 teaspoons paprika	2.0	teaspoons	t	7
139	43	2 tablespoons Parsley, chopped	2.0	tablespoons	T	8
139	6	to taste salt	4.0	servings	servings	9
139	7	3 tablespoons Cold water	3.0	tablespoons	T	10
140	117	sliced almonds for topping	12.0	servings	servings	0
140	8	2 teaspoons baking powder	2.0	teaspoons	t	1
140	10	1/3 cup 1 1/2 Tablespoon (100 g) butter, unsalted and at room temp.	100.0	g	g	2
140	116	3 egg whites	3.0	\N	\N	3
140	14	2 large eggs	2.0	\N	\N	4
140	15	1 1/4 cup (150 g) flour	150.0	g	g	5
140	493	21 ounces (600 g) rhubarb, peeled and cubed	600.0	g	g	6
140	0	1 3/4 ounces (50 g) roasted almonds, ground	50.0	g	g	7
140	6	1 3/4 cups Salt (sack salt, not Iodized)	1.75	cups	c	8
140	114	1 cup SUGAR, BROWN, 2 LB	1.0	cup	c	9
140	134	1 teaspoon (5 ml) vanilla extract	5.0	ml	ml	10
141	224	1 teaspoon Baking soda	1.0	teaspoon	t	0
141	10	1/4 cup Butter	0.25	cup	c	1
141	210	1 tablespoon Cake flour	1.0	tablespoon	T	2
141	109	3 lrg Egg yolks	3.0	\N	\N	3
141	14	4 lrg Eggs, separated	4.0	\N	\N	4
141	338	1 cup Evaporated milk	1.0	cup	c	5
141	349	1 cup Low-fat buttermilk	1.0	cup	c	6
141	382	1 cup Chopped pecans	1.0	cup	c	7
141	114	1/4 cup Sugar	0.25	cup	c	8
141	479	1 cup Shredded unsweetened coconut	1.0	cup	c	9
141	134	1 teaspoon Vanilla extract	1.0	teaspoon	t	10
141	231	4 ounces White chocolate, melted in 1/2 c boiling wat	4.0	ounces	oz	11
142	130	2 medium cooking apples, cored and cut into 8 wedges each	2.0	\N	\N	0
142	460	1 cup beer	1.0	cup	c	1
142	283	2 tablespoons coarse-grain brown mustard	2.0	tablespoons	T	2
142	325	2 teaspoons caraway seed	2.0	teaspoons	t	3
142	40	1 tablespoon cornstarch	1.0	tablespoon	T	4
142	34	1/2 teaspoon ground allspice	0.5	teaspoon	t	5
142	0	1 pound fully cooked knockwurst, bias-sliced into 2- to 2-1/2-inch pieces	1.0	pound	lb	6
142	180	2 tablespoons molasses	2.0	tablespoons	T	7
142	4	1/3 cup chopped onion	0.3333333333333333	cup	c	8
142	58	1/4 teaspoon pepper	0.25	teaspoon	t	9
142	359	1 large rutabaga, peeled & cut into 1" cubes	1.0	\N	\N	10
142	459	1 16-ounce can sauerkraut, drained and rinsed	16.0	ounce	oz	11
142	7	4 cups Water, boiling	4.0	cups	c	12
143	181	70g homemade breadcrumbs	70.0	g	g	0
143	40	50g cornflour, seasoned with salt and black pepper	50.0	g	g	1
143	14	1 Egg, lightly beaten	1.0	\N	\N	2
143	131	2 Green Apple, cored, halved and thinly sliced	2.0	\N	\N	3
143	281	4 tablespoons Mayonnaise	4.0	tablespoons	T	4
143	72	3 tablespoons olive oil	3.0	tablespoons	T	5
143	401	4 Pork Sirloin Chops, fat trimmed	4.0	\N	\N	6
143	514	1 package salad greens	1.0	package	pkg	7
143	283	4 tablespoons Wholegrain Mustard	4.0	tablespoons	T	8
143	318	1/2 Tablespoon Cooking Wine	0.5	Tablespoon	Tablespoon	9
144	58	1/2 tsp black pepper	0.5	tsp	t	0
144	181	70g homemade breadcrumbs	70.0	g	g	1
144	40	50g cornflour, seasoned with salt and black pepper	50.0	g	g	2
144	311	3/4 cup double cream	0.75	cup	c	3
144	14	2 eggs, lightly beaten	2.0	\N	\N	4
144	183	50g parmesan cheese, grated	50.0	g	g	5
144	396	2 pork escalopes (about 125g each)	250.0	g	g	6
144	255	4 tbs sunflower oil, for shallow frying	4.0	tbs	tbs	7
144	232	1 tsp tarragon, dry, finely chopped leaves only	1.0	tsp	t	8
144	105	3/4 cup vegetable stock from 1/2 cube	0.75	cup	c	9
144	320	1/4 cup white wine	0.25	cup	c	10
145	58	1/8 teaspoon Black Pepper	0.125	teaspoon	t	0
145	23	1 garlic clove, finely chopped	1.0	clove	clove	1
145	72	Olive oil	2.0	servings	servings	2
145	27	2 Large Potatoes, Diced	2.0	\N	\N	3
145	6	1/2 teaspoon Salt	0.5	teaspoon	t	4
145	459	2 cups 14 oz. sauerkraut with pickling liquid, about	2.0	cups	c	5
145	0	1 cup cubed smoked ham	1.0	cup	c	6
145	7	water, enough to cover the potatoes in the pot	2.0	servings	servings	7
146	22	4 slices bacon	4.0	slices	slices	0
146	13	8 ounces cream cheese at room temperature	8.0	ounces	oz	1
146	505	1 teaspoon garlic paste	1.0	teaspoon	t	2
146	281	1/2 cup mayonnaise	0.5	cup	c	3
146	280	salt and pepper to taste	6.0	servings	servings	4
146	459	32 oz sauerkraut	32.0	oz	oz	5
146	261	1/4 cup chopped shallot	0.25	cup	c	6
147	181	50g homemade bread crumbs	50.0	g	g	0
147	10	50 g butter	50.0	g	g	1
147	67	480g chopped tomatoes from a can	480.0	g	g	2
147	109	3 egg yolks	3.0	\N	\N	3
147	238	2-4 eggplants, thinly sliced	2.0	\N	\N	4
147	330	230g feta cheese, grated	230.0	g	g	5
147	15	50 g flour	50.0	g	g	6
147	23	4 cloves garlic, finely chopped	4.0	cloves	cloves	7
147	34	1/4 tsp ground allspice	0.25	tsp	t	8
147	12	1/4 tsp ground cinnamon	0.25	tsp	t	9
147	16	1/2 tsp ground nutmeg	0.5	tsp	t	10
147	291	400 g lean ground beef	400.0	g	g	11
147	20	250 ml warm milk	250.0	ml	ml	12
147	72	1 tbs olive oil	1.0	tbs	tbs	13
147	72	Olive oil	4.0	servings	servings	14
147	4	2 onions, finely chopped	2.0	\N	\N	15
147	58	Salt and ground white pepper	4.0	servings	servings	16
147	96	Sea salt	4.0	servings	servings	17
147	70	2 tbs tomato paste	2.0	tbs	tbs	18
148	181	1 cup bread crumbs	1.0	cup	c	0
148	14	1 egg, lightly beaten	1.0	\N	\N	1
148	238	1/2 eggplants, cut into strips	0.5	\N	\N	2
148	143	garlic powder	2.0	servings	servings	3
148	457	Italian seasoning	2.0	servings	servings	4
148	433	1/4 cup plain, low-fat yogurt	0.25	cup	c	5
148	41	paprika	2.0	servings	servings	6
148	6	salt	2.0	servings	servings	7
148	471	tzatziki	2.0	servings	servings	8
149	37	1 can chickpeas (15 ounces), drained except for about 1 tablespoon of the liquid	15.0	ounces	oz	0
149	23	2 cloves garlic, roasted	2.0	cloves	cloves	1
149	143	2 tablespoons garlic powder	2.0	tablespoons	T	2
149	0	1 large golden beet	1.0	\N	\N	3
149	135	1 jalapeño, roasted	1.0	\N	\N	4
149	18	1 tablespoon lemon juice	1.0	tablespoon	T	5
149	72	¼ cup olive oil	0.25	cup	c	6
149	6	Salt to taste	4.0	servings	servings	7
149	301	¼ cup tahini (sesame paste)	0.25	cup	c	8
149	162	Turmeric, paprika and olive oil for sprinkling on top	4.0	servings	servings	9
149	438	1 large turnip	1.0	\N	\N	10
150	237	2 cucumbers, seeded and sliced	2.0	\N	\N	0
150	330	1 1/2 cups crumbled feta cheese	1.5	cups	c	1
150	0	1/2 tsp Greek Seasoning	0.5	tsp	t	2
150	466	1 cup Kalamata olives, pitted and sliced	1.0	cup	c	3
150	215	1/3 cup diced oil packed sun-dried tomatoes, drained, oil reserved	0.3333333333333333	cup	c	4
150	4	1/2 red onion, sliced	0.5	\N	\N	5
150	297	1 Tbsp rice vinegar (I had to use apple cider, but I think rice would be better)	1.0	Tbsp	Tbsp	6
150	47	3 cups diced roma tomatoes	3.0	cups	c	7
151	237	1 large cucumber	1.0	\N	\N	0
151	72	high-quality extra-virgin olive oil	4.0	servings	servings	1
151	330	1/4 pound greek feta	0.25	pound	lb	2
151	466	1 dozen Kalamata olives	12.0	\N	\N	3
151	4	1 large red onion, sliced thinly	1.0	\N	\N	4
151	47	5 large ripe tomatoes	5.0	\N	\N	5
152	87	5 large leaves of basil, chiffonaded	5.0	leaves	leaves	0
152	330	1/2 pound Feta cheese, 1 lb	0.5	pound	lb	1
152	94	1 cup chopped green onions (green and white parts)	1.0	cup	c	2
152	18	1/2 cup freshly-squeezed lemon juice	0.5	cup	c	3
152	72	1/2 cup + 1 tbsp extra-virgin olive oil, divided	0.5	cup	c	4
152	364	3/4 pound (12 oz.) orzo (rice-shaped pasta)	12.0	oz	oz	5
152	43	1 cup chopped Italian parsley	1.0	cup	c	6
152	52	1 pound raw large shrimp, peeled and deveined	1.0	pound	lb	7
152	280	Salt and pepper	6.0	servings	servings	8
153	237	1 cucumber	1.0	\N	\N	0
153	45	1 tablespoon Dried Oregano	1.0	tablespoon	T	1
153	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
153	23	2 cloves Garlic, smashed	2.0	cloves	cloves	3
153	23	3 cloves garlic, minced	3.0	cloves	cloves	4
153	18	1 Juice of Lemon	1.0	\N	\N	5
153	18	tablespoon of fresh lemon juice	1.0	tablespoon	T	6
153	58	pepper	2.0	servings	servings	7
153	208	Pita Bread	2.0	servings	servings	8
153	39	2 tablespoons heaping Plain or Greek Yogurt	2.0	tablespoons	T	9
153	161	16 ounces plain Greek yogurt	16.0	ounces	oz	10
153	4	sliced red onions	2.0	servings	servings	11
153	100	2 teaspoons Red Wine Vinegar	2.0	teaspoons	t	12
153	6	Salt	2.0	servings	servings	13
153	354	1 pound boneless, skinless chicken breasts	1.0	pound	lb	14
153	47	sliced tomatoes	2.0	servings	servings	15
153	100	1/2 teaspoon white wine vinegar	0.5	teaspoon	t	16
154	36	200 g boiled chickpeas. Can also use canned chickpeas	200.0	g	g	0
154	41	1 tsp red paprika / red chili powder	1.0	tsp	t	1
154	23	2 cloves garlic (optional) – roughly chopped	2.0	cloves	cloves	2
154	18	1 tablespoon lemon juice	1.0	tablespoon	T	3
154	71	2 tsp cooking oil / olive oil – for tempering bell peppers	2.0	tsp	t	4
154	81	1 cup orange bell peppers – roughly chopped	1.0	cup	c	5
154	58	Pepper to taste	2.0	servings	servings	6
154	6	1/2 teaspoon salt	0.5	teaspoon	t	7
154	46	2 tsp roasted sesame seeds or 1 tablespoon tahini paste	2.0	tsp	t	8
154	114	1/2 tsp sugar	0.5	tsp	t	9
154	98	1 tsp white vinegar	1.0	tsp	t	10
155	37	1 can Chickpeas- any brand- Drain and wash	1.0	can	can	0
155	48	1 teaspoon Cumin	1.0	teaspoon	t	1
155	23	Couple of crushed garlic cloves	2.0	cloves	cloves	2
155	18	1 tablespoon lemon juice	1.0	tablespoon	T	3
155	468	Parsley, Paprika or Sumac and Olive	2.0	servings	servings	4
155	6	1/2 teaspoon salt	0.5	teaspoon	t	5
155	301	1/2 cup Tahini sauce	0.5	cup	c	6
156	468	1/4 cup black olives	0.25	cup	c	0
156	37	1 15-oz can garbanzo beans	15.0	oz	oz	1
156	2	1/2 cup shredded carrots	0.5	cup	c	2
156	237	1/2 cup julienned cucumber	0.5	cup	c	3
156	23	1 garlic clove	1.0	clove	clove	4
156	300	2 tablespoons hummus	2.0	tablespoons	T	5
156	18	1 tablespoon lemon juice	1.0	tablespoon	T	6
156	156	1/2 cup shredded lettuce	0.5	cup	c	7
156	6	1/2 teaspoon salt	0.5	teaspoon	t	8
156	301	1 1/2 tablespoons Tahini paste	1.5	tablespoons	T	9
156	428	1 10-inch tortilla	1.0	10-inch	10-inch	10
157	164	4 oz. baby spinach	4.0	oz	oz	0
157	71	3 tablespoons cooking oil	3.0	tablespoons	T	1
157	23	1 tablespoon garlic (chopped)	1.0	tablespoon	T	2
157	344	1 (4 oz.) fresh goat cheese, Chavrie log	4.0	oz	oz	3
157	406	8 2-ounce lamb loins	16.0	ounce	oz	4
157	72	2 tablespoons olive oil	2.0	tablespoons	T	5
157	280	salt and pepper to season	6.0	servings	servings	6
158	237	1 cucumber, seeded and diced	1.0	\N	\N	0
158	14	1 egg	1.0	\N	\N	1
158	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
158	43	1/4 cup chopped flat leaf parsley	0.25	cup	c	3
158	216	1 handful of minced fresh dill	1.0	handful	handful	4
158	23	12 Cloves garlic, peeled and cut in ha	12.0	Cloves	Cloves	5
158	161	1 pint Greek yogurt	1.0	pint	pt	6
158	289	1 pound ground lamb	1.0	pound	lb	7
158	501	4 hamburger buns	4.0	\N	\N	8
158	18	juice of 2 lemons	2.0	\N	\N	9
158	97	Kosher salt & pepper to taste	4.0	servings	servings	10
159	15	1/2 cup all purpose flour	0.5	cup	c	0
159	67	1 can diced tomatoes, undrained	1.0	can	can	1
159	226	cup margarine	1.0	cup	c	2
159	319	1/2 cup dry red wine, optional	0.5	cup	c	3
159	14	4 eggs, beaten	4.0	\N	\N	4
159	238	2 1/2 pounds eggplant, (3 large)	2.5	pounds	lb	5
159	172	3 cups lactose free mozzarella cheese, shredded	3.0	cups	c	6
159	20	4 cups Natrel Lactose Free Milk	4.0	cups	c	7
159	43	1/2 cup chopped fresh parsley	0.5	cup	c	8
159	23	2 clv garlic, chopped	2.0	\N	\N	9
159	289	2 pounds ground lamb	2.0	pounds	lb	10
159	72	5 tablespoons extra-virgin olive oil	5.0	tablespoons	T	11
159	4	2 mediums Onion, chopped	2.0	\N	\N	12
159	45	1 tablespoon dried oregano leaves	1.0	tablespoon	T	13
159	6	1 teaspoon salt	1.0	teaspoon	t	14
159	280	Salt and pepper to taste	12.0	servings	servings	15
159	70	1 can Tomato paste	1.0	can	can	16
159	233	3 zucchini, sliced, 1/4 inch thick	3.0	\N	\N	17
160	58	1/8 teaspoon black pepper	0.125	teaspoon	t	0
160	65	1 pound brown lentils	1.0	pound	lb	1
160	67	28 ounces can whole tomatoes	28.0	ounces	oz	2
160	2	12 ounces scrubbed and chopped carrots	12.0	ounces	oz	3
160	88	2 teaspoons dried basil	2.0	teaspoons	t	4
160	45	1 teaspoon dried oregano	1.0	teaspoon	t	5
160	86	1 teaspoon dried thyme	1.0	teaspoon	t	6
160	85	2 teaspoons fresh thyme (if none available, use 1 more tsp dried)	2.0	teaspoons	t	7
160	23	2 cloves garlic, chopped	2.0	cloves	cloves	8
160	18	2 tablespoons lemon juice, from 1 lemon	2.0	tablespoons	T	9
160	72	1 tablespoon olive oil	1.0	tablespoon	T	10
160	4	1/2 medium onion, chopped (about 3/4 cup)	0.75	cup	c	11
160	6	1/4 teaspoon salt	0.25	teaspoon	t	12
160	7	3 quarts cold water	3.0	quarts	quarts	13
161	0	1 pack package Angel hair spaghetti 12	1.0	\N	\N	0
161	79	1 large can tomato sauce	1.0	can	can	1
161	67	1 can diced tomatoes	1.0	can	can	2
161	87	Fresh basil	8.0	servings	servings	3
161	23	teaspoon 1/2 minced garlic	0.5	teaspoon	t	4
161	468	cup 1/4 green Greek olives (pitted)	0.25	cup	c	5
161	457	1 teaspoon Italian seasoning	1.0	teaspoon	t	6
161	291	1 pound of lean ground beef	1.0	pound	lb	7
161	18	1 tablespoon lemon juice	1.0	tablespoon	T	8
161	111	1 pound of vegetables (seasoned, roasted with olive oil)	1.0	pound	lb	9
161	55	1 cup sliced mushrooms (seasoned & roasted)	1.0	cup	c	10
161	4	2 teaspoons Onion, minced	2.0	teaspoons	t	11
161	45	teaspoon 1/2 oregano	0.5	teaspoon	t	12
161	183	cup 1/4 parmesan cheese	0.25	cup	c	13
161	58	teaspoon 1/2 black pepper	0.5	teaspoon	t	14
161	215	cup 1/4 of sun dried tomatoes, chopped	0.24	cup	c	15
162	99	1/4 cup apple cider vinegar	0.25	cup	c	0
162	2	1 carrot, grated	1.0	\N	\N	1
162	118	1/2 can chipotle chilies in adobo sauce (3-4 peppers chopped)	0.5	can	can	2
162	23	2 Cloves garlic, minced	2.0	Cloves	Cloves	3
162	161	1 cup Greek yogurt	1.0	cup	c	4
162	139	Juice of 1 lime	1.0	\N	\N	5
162	55	2 cups chopped mushrooms	2.0	cups	c	6
162	72	3 tablespoons olive oil	3.0	tablespoons	T	7
162	4	1 green onion stalk	1.0	\N	\N	8
162	396	1 5-lb pork shoulder roast	5.0	lb	lb	9
162	149	1 head purple cabbage	1.0	head	head	10
162	319	1/2 cup red wine	0.5	cup	c	11
162	6	2 tablespoons salt	2.0	tablespoons	T	12
162	280	Salt pepper to taste	12.0	servings	servings	13
162	105	1 cup vegetable broth	1.0	cup	c	14
162	4	1 yellow onion	1.0	\N	\N	15
163	37	1 15.5oz can chickpeas (garbanzo beans), drained and rinsed	15.5	oz	oz	0
163	238	3 pounds eggplant (about 3 medium)	3.0	pounds	lb	1
163	72	1/4 cup extra-virgin olive oil, divided	0.25	cup	c	2
163	23	1 garlic clove	1.0	clove	clove	3
163	18	2 tablespoons fresh lemon juice	2.0	tablespoons	T	4
163	58	Freshly ground pepper to taste	6.0	servings	servings	5
163	6	1/2 teaspoon salt	0.5	teaspoon	t	6
163	301	2 tablespoons tahini	2.0	tablespoons	T	7
164	14	3 extra-large eggs, lightly beaten	3.0	\N	\N	0
164	330	1 1/2 lbs. Feta cheese	1.5	lbs	lb	1
164	15	2 tablespoons all-purpose flour	2.0	tablespoons	T	2
164	216	2 tablespoons chopped fresh dill	2.0	tablespoons	T	3
164	165	4 boxes frozen spinach	4.0	boxes	boxes	4
164	72	1/2 cup (120 ml) olive oil	120.0	ml	ml	5
164	4	2 large onions, chopped	2.0	\N	\N	6
164	445	1 box Filo or Phyllo dough (purchase in freezer sectio	1.0	box	box	7
164	280	salt and pepper to taste	8.0	servings	servings	8
164	71	1/2 cup vegetable oil	0.5	cup	c	9
165	72	extra-virgin olive oil, for serving	1.0	serving	serving	0
165	330	6 ounces feta cheese	6.0	ounces	oz	1
165	23	1 garlic clove	1.0	clove	clove	2
165	18	2 Tablespoons lemon juice	2.0	Tablespoons	Tablespoons	3
165	146	zest of 1 lemon, a pinch of zest reserved for garnish	1.0	\N	\N	4
165	161	1/3 cup plain Greek yogurt	0.3333333333333333	cup	c	5
165	61	pinch of red pepper flakes	1.0	pinch	pinch	6
166	177	200 g brown rice	200.0	g	g	0
166	350	1 can (400 ml) coconut milk	400.0	ml	ml	1
166	353	400 g chicken breast, cubed	400.0	g	g	2
166	61	chili flakes, to taste	2.0	servings	servings	3
166	257	1 tablespoon coconut oil	1.0	tablespoon	T	4
166	80	2 teaspoons curry powder	2.0	teaspoons	t	5
166	185	2 teaspoons garam masala	2.0	teaspoons	t	6
166	23	2 cloves garlic	2.0	cloves	cloves	7
166	141	1 inch ginger	1.0	inch	inch	8
166	352	1 tablespoon lemon grass paste	1.0	tablespoon	T	9
166	31	200 g snow peas, frozen	200.0	g	g	10
166	70	1 tablespoon tomato paste	1.0	tablespoon	T	11
167	67	1 Cup canned crushed tomatoes	1.0	Cup	Cup	0
167	223	2 Teaspoons Coriander Seeds or 1 Teaspoon Powder	2.0	Teaspoons	Teaspoons	1
167	49	1 Teaspoon Cumin Seeds	1.0	Teaspoon	Teaspoon	2
167	7	12 Cups Filtered Water	12.0	Cups	Cups	3
167	141	2 Teaspoons Fresh organic Ginger	2.0	Teaspoons	Teaspoons	4
167	185	1 Tablespoon Garam Masala	1.0	Tablespoon	Tablespoon	5
167	23	2-3 organic Garlic Cloves	2.0	cloves	cloves	6
167	140	1/4 Cup Expeller Pressed Grapeseed Oil	0.25	Cup	Cup	7
167	66	3 Cups organic Red Lentils	3.0	Cups	Cups	8
167	96	1 Tablespoon + 1 Teaspoon Sea Salt or to taste	1.0	Tablespoon	Tablespoon	9
167	160	2-4 Serrano peppers	2.0	\N	\N	10
167	162	3 Tablespoons Turmeric	3.0	Tablespoons	Tablespoons	11
167	104	2 Vegetable Bouillon Cube	2.0	\N	\N	12
167	4	1/2 organic White Onion	0.5	\N	\N	13
168	357	24 ounces Apple cider or juice	24.0	ounces	oz	0
168	350	7 ounces Coconut milk	7.0	ounces	oz	1
168	80	2 teaspoons Curry powder	2.0	teaspoons	t	2
168	344	2 packages Chavrie fresh goat cheese (reserve 1 pkg. for garnishing)	2.0	packages	packages	3
168	131	2 inches Granny Smith apples (cut wedges)	2.0	inches	inches	4
168	25	2 Leeks (chopped and washed)	2.0	\N	\N	5
168	162	1/2 teaspoon Turmeric	0.5	teaspoon	t	6
168	71	2 ounces Vegetable oil	2.0	ounces	oz	7
168	55	1 cup Sliced white mushrooms	1.0	cup	c	8
169	63	2 tbsp Gram (chickpea) flour	2.0	tbsp	T	0
169	37	2 cans chickpeas drained and rinsed	2.0	cans	cans	1
169	95	8 tablespoons chili powder (or to taste)	8.0	tablespoons	T	2
169	92	Handful of fresh coriander (cilantro) chopped	1.0	Handful	Handful	3
169	48	2 tsp cumin powder	2.0	tsp	t	4
169	49	1.5 tsp black cumin seeds	1.5	tsp	t	5
169	92	Small handful of fresh coriander (cilantro)	1.0	handful	handful	6
169	185	1 tsp garam masala	1.0	tsp	t	7
169	23	3 cloves garlic finely chopped	3.0	cloves	cloves	8
169	120	1 hot green chili finely sliced	1.0	\N	\N	9
169	120	2 hot green chilis finely chopped	2.0	\N	\N	10
169	18	1 tbsp lemon juice	1.0	tbsp	T	11
169	284	1 tbsp mustard seeds	1.0	tbsp	T	12
169	4	1 small onion, chopped	1.0	\N	\N	13
169	227	3 cups passata (pureed tomato)	3.0	cups	c	14
169	38	1 cup frozen peas (take them out the freezer before you start cooking)	1.0	cup	c	15
169	3	3 green peppers (capsicum) roughly chopped into big chunks	3.0	\N	\N	16
169	194	2 tsp Tamarind	2.0	tsp	t	17
169	162	1 tsp Turmeric	1.0	tsp	t	18
170	225	6 Bay leaves	6.0	\N	\N	0
170	353	1 pound Chicken breast (boneless)	1.0	pound	lb	1
170	10	Butter as needed( I used oil+butter)	2.0	servings	servings	2
170	95	1 tablespoon chili powder	1.0	tablespoon	T	3
170	160	4 Green chilies	4.0	\N	\N	4
170	92	Cilantro leaves	1.0	leaves	leaves	5
170	434	1/4 cup Fresh Cream	0.25	cup	c	6
170	286	1/2 teaspoon Fennel seeds	0.5	teaspoon	t	7
170	185	1 teaspoon garam masala	1.0	teaspoon	t	8
170	282	1 teaspoon Ketchup	1.0	teaspoon	t	9
170	139	1 tablespoon Lime juice	1.0	tablespoon	T	10
170	0	A few nuts n raisins	9.0	servings	servings	11
170	4	1 Big Onion Chopped	1.0	\N	\N	12
170	59	1/2 teaspoon Pepper Powder	0.5	teaspoon	t	13
170	6	1/4 teaspoon salt	0.25	teaspoon	t	14
170	114	Sugar	2.0	servings	servings	15
170	47	1 medium sized tomato blanched n Pureed	1.0	\N	\N	16
170	39	1 tablespoon Yogurt	1.0	tablespoon	T	17
171	225	1 bay leaf	1.0	\N	\N	0
171	296	5 pounds Beef Chuck Roast	5.0	pounds	lb	1
171	67	1 16 oz. can tomatoes, cut up	16.0	oz	oz	2
171	80	1 t curry powder	1.0	t	t	3
171	80	2 t mild curry powder	2.0	t	t	4
171	23	3 cloves garlic, minced	3.0	cloves	cloves	5
171	141	1 slice of ginger, 1/2" wide	1.0	slice	slice	6
171	72	Olive oil	4.0	servings	servings	7
171	358	1 cup quinoa	1.0	cup	c	8
171	59	1/2 hot red chile, seeded and finely diced	0.5	\N	\N	9
171	319	1/4 cup red wine	0.25	cup	c	10
171	123	1/2 large sweet onion	0.5	\N	\N	11
171	70	1 T tomato paste	1.0	T	T	12
172	225	2 bay leaves	2.0	\N	\N	0
172	58	Freshly-ground black pepper to taste	1.0	serving	serving	1
172	59	4 smalls hot chilies seeded	4.0	\N	\N	2
172	296	2 pounds chuck steak cut 1" cubes	2.0	pounds	lb	3
172	288	Clarified butter as needed	1.0	serving	serving	4
172	290	6 whl cloves	6.0	\N	\N	5
172	49	teaspoon cumin seeds	1.0	teaspoon	t	6
172	23	14 garlic cloves	14.0	cloves	cloves	7
172	114	cup granulated sugar	1.0	cup	c	8
172	145	1 lemon juiced, pith removed, rind chopped, membranes removed, and pulp chopped	1.0	\N	\N	9
172	283	1 teaspoon English mustard	1.0	teaspoon	t	10
172	4	1 small onion finely sliced	1.0	\N	\N	11
172	295	3 tablespoons poppy seeds	3.0	tablespoons	T	12
172	142	teaspoon powdered ginger	1.0	teaspoon	t	13
172	6	salt (taste),	1.0	serving	serving	14
172	6	teaspoon salt	1.0	teaspoon	t	15
172	70	cup tomato paste	1.0	cup	c	16
172	162	teaspoon turmeric	1.0	teaspoon	t	17
172	100	cup red wine vinegar	1.0	cup	c	18
173	99	2 teaspoons apple cider vinegar	2.0	teaspoons	t	0
173	177	brown rice	8.0	servings	servings	1
173	69	1 head of cauliflower-cut into florets	1.0	head	head	2
173	37	1 15 oz can of chickpeas-drained and rinsed	15.0	oz	oz	3
173	49	1 teaspoon cumin seeds- toasted and crushed	1.0	teaspoon	t	4
173	80	1 tablespoon curry powder	1.0	tablespoon	T	5
173	0	1 teaspoon fenugreek- toasted and crushed	1.0	teaspoon	t	6
173	141	3 tablespoons fresh ginger-minced	3.0	tablespoons	T	7
173	48	1 tablespoon ground cumin	1.0	tablespoon	T	8
173	23	3 cloves garlic-minced	3.0	cloves	cloves	9
173	4	1 onion-sliced thinly	1.0	\N	\N	10
173	41	2 teaspoons paprika	2.0	teaspoons	t	11
173	27	2 potatoes-peeled and chopped	2.0	\N	\N	12
173	96	sea salt	8.0	servings	servings	13
173	114	1 pinch sugar	1.0	pinch	pinch	14
173	255	2 tablespoons sunflower oil	2.0	tablespoons	T	15
173	162	1 teaspoon tumeric	1.0	teaspoon	t	16
173	7	water-to cover	8.0	servings	servings	17
174	80	2 teaspoons Curry Powder	2.0	teaspoons	t	0
174	141	1 teaspoon fresh ginger	1.0	teaspoon	t	1
174	23	2 cloves of garlic	2.0	cloves	cloves	2
174	139	2 teaspoons Lime juice	2.0	teaspoons	t	3
174	4	1/4 cup red onions	0.25	cup	c	4
174	187	rice noodles	2.0	servings	servings	5
174	383	1/4 cup Natural roasted peanuts	0.25	cup	c	6
174	489	1 pound Black Angus Inside Round Steak (cut in thin slices)	1.0	pound	lb	7
174	0	1 teaspoon Sambal Oelek	1.0	teaspoon	t	8
174	74	2 tablespoons Soy sauce	2.0	tablespoons	T	9
175	434	Crème fraiche, 150ml	150.0	ml	ml	0
175	80	tablespoon Curry powder, 1	1.0	tablespoon	T	1
175	320	Dry white wine, 150ml	150.0	ml	ml	2
175	203	Mussels, 2kg	2.0	kg	kg	3
175	72	tablespoon Olive oil, 1	1.0	tablespoon	T	4
175	4	Onion (chopped), 1	1.0	\N	\N	5
175	43	tablespoon Parsley (chopped), 1	1.0	tablespoon	T	6
175	280	Salt and pepper to taste.	4.0	servings	servings	7
176	410	1 pound mutton [boneless and cut into 1" cubes]	1.0	pound	lb	0
176	174	1 1/4 cups basmati rice	1.25	cups	c	1
176	225	3 bay leaves	3.0	\N	\N	2
176	186	2 pods green cardamom	2.0	\N	\N	3
176	95	2 teaspoons red chili powder [optional]	2.0	teaspoons	t	4
176	77	8 wholes dry red chilies [adjust to taste]	8.0	\N	\N	5
176	223	1 teaspoon dry coriander powder	1.0	teaspoon	t	6
176	223	1 teaspoon coriander seeds	1.0	teaspoon	t	7
176	49	1 tablespoon Cumin seeds,	1.0	tablespoon	T	8
176	92	Fresh Cilantro leaves	1.0	leaves	leaves	9
176	0	Fried onions [optional]	3.0	servings	servings	10
176	26	2 blades mace [javitri]	2.0	\N	\N	11
176	263	1/4 tablespoon saffron [kesar] soaked in 2 cups milk [optional]	0.25	tablespoon	T	12
176	16	1/2 teaspoon nutmeg, grated	0.5	teaspoon	t	13
176	4	1 large onion, thinly sliced	1.0	\N	\N	14
176	58	10 whole black peppercorns	10.0	\N	\N	15
176	6	1/2 teaspoon salt	0.5	teaspoon	t	16
176	258	4 tablespoons oil [I used mustard, canola or sunflower can be used]	4.0	tablespoons	T	17
176	7	4 pints Water	4.0	pints	pt	18
176	117	Almonds/Raisins [optional]	3.0	servings	servings	19
177	8	1 small pinch baking powder	1.0	pinch	pinch	0
177	59	2 mediums hot chilies, minced	2.0	\N	\N	1
177	12	1 teaspoon cinnamon powder	1.0	teaspoon	t	2
177	92	1/4 cup chopped coriander	0.25	cup	c	3
177	49	2 teaspoons cumin seeds	2.0	teaspoons	t	4
177	0	6 curry leaves	6.0	\N	\N	5
177	23	1 tablespoon garlic, minced	1.0	tablespoon	T	6
177	18	1 tablespoon lemon juice or to taste	1.0	tablespoon	T	7
177	51	1 1/2 cups mung beans	1.5	cups	c	8
177	284	1 teaspoon mustard seeds	1.0	teaspoon	t	9
177	6	Salt to taste	4.0	servings	servings	10
177	114	Sugar to taste	4.0	servings	servings	11
177	255	1 tablespoon sunflower oil	1.0	tablespoon	T	12
177	47	1 medium tomato, chopped	1.0	\N	\N	13
177	162	1/2 teaspoon turmeric	0.5	teaspoon	t	14
178	80	3 tablespoons curry powder	3.0	tablespoons	T	0
178	92	2 tablespoons chopped fresh coriander (or parsley)	2.0	tablespoons	T	1
178	23	2 cloves garlic, crushed	2.0	cloves	cloves	2
178	289	1 pound ground lamb (or beef)	1.0	pound	lb	3
178	4	1 chopped med. onion	1.0	\N	\N	4
178	254	3 tablespoons peanut or corn oil	3.0	tablespoons	T	5
178	38	10 ounces frozen peas	10.0	ounces	oz	6
178	375	8 ripe plum tomatoes (or canned)	8.0	\N	\N	7
178	6	1/2 teaspoon salt	0.5	teaspoon	t	8
179	8	1 tiny pinch of baking powder	1.0	\N	\N	0
179	186	Pinch of cardamom powder (Cardamom powder is very strong so add only a pinch)	1.0	pinch	pinch	1
179	120	3 hot green chilies, minced (more or less if you prefer)	3.0	\N	\N	2
179	12	1/4 teaspoon cinnamon powder	0.25	teaspoon	t	3
179	223	1 teaspoon coriander powder	1.0	teaspoon	t	4
179	48	1 teaspoon cumin powder	1.0	teaspoon	t	5
179	286	1/4 teaspoon fennel powder	0.25	teaspoon	t	6
179	23	4 mediums cloves garlic, minced	4.0	cloves	cloves	7
179	141	1 tablespoon ginger, minced	1.0	tablespoon	T	8
179	4	1 Large Onion, Chopped	1.0	\N	\N	9
179	480	1 cup paneer (or tofu for vegans), lightly grilled	1.0	cup	c	10
179	6	1/2 teaspoon Salt	0.5	teaspoon	t	11
179	310	2 tablespoons single cream (optional)	2.0	tablespoons	T	12
179	164	10 cups fresh spinach, chopped	10.0	cups	c	13
179	255	2 tablespoons sunflower oil	2.0	tablespoons	T	14
179	47	1 kilogram tomatoes, Sliced into Quarters	1.0	kilogram	kilogram	15
179	162	1/2 teaspoon turmeric	0.5	teaspoon	t	16
179	7	1 cup water	1.0	cup	c	17
180	73	1/8 cup cashews	0.125	cup	c	0
180	95	1/2 teaspoon Red chili powder	0.5	teaspoon	t	1
180	223	1 teaspoon Coriander powder	1.0	teaspoon	t	2
180	40	1/4 cup corn starch	0.25	cup	c	3
180	48	1 teaspoon cumin powder	1.0	teaspoon	t	4
180	49	1 teaspoon cumin seeds	1.0	teaspoon	t	5
180	92	1/4 cup Fresh Cilantro, finely chopped	0.25	cup	c	6
180	185	1 teaspoon Garam Masala	1.0	teaspoon	t	7
180	505	1 Tbsp, Garlic Paste	1.0	Tbsp	Tbsp	8
180	0	1 Tbsp, Ginger paste	1.0	Tbsp	Tbsp	9
180	322	1/8 cup Golden Raisins	0.125	cup	c	10
180	120	2 Green Chilies, finely chopped	2.0	\N	\N	11
180	434	1/2 cup Fresh Cream / Half & Half	0.5	cup	c	12
180	64	2% Milk, as needed	4.0	servings	servings	13
180	4	3 mediums Onions,	3.0	\N	\N	14
180	480	1/4 cup Paneer, grated (cottage cheese)	0.25	cup	c	15
180	0	1/2 cup peas and carrots	0.5	cup	c	16
180	27	5 mediums Potatoes, boiled-peeled-grated	5.0	\N	\N	17
180	6	Salt to taste	4.0	servings	servings	18
180	227	1 cup Tomato puree	1.0	cup	c	19
180	162	1/4 teaspoon Turmeric powder	0.25	teaspoon	t	20
181	235	4 acorn squashes cut in half, gutted	4.0	\N	\N	0
181	174	1/2 cup basmati rice soaked in water	0.5	cup	c	1
181	47	1 beefsteak tomato- diced	1.0	\N	\N	2
181	73	handful cashew nuts- chopped a bit	1.0	handful	handful	3
181	121	5 tablespoons hefty Biryani paste (I use Patak's Brand)	5.0	tablespoons	T	4
181	95	1 tablespoon chili powder (it should be spicy!)	1.0	tablespoon	T	5
181	92	handful chopped cilantro	1.0	handful	handful	6
181	58	coarse black pepper	4.0	servings	servings	7
181	106	PAM original flavor	4.0	servings	servings	8
181	185	3 tablespoons garam masala	3.0	tablespoons	T	9
181	23	4 cloves garlic- crushed and minced	4.0	cloves	cloves	10
181	141	2 tablespoons ginger- freshly grated 	2.0	tablespoons	T	11
181	4	1 medium onion- cut into thick slices (garnishing)	1.0	\N	\N	12
181	4	1 medium red onion- diced	1.0	\N	\N	13
181	263	of saffron	4.0	servings	servings	14
181	6	salt to taste	4.0	servings	servings	15
181	76	4 small sweet peppers- diced	4.0	\N	\N	16
181	71	1/2 tablespoon vegetable oil	0.5	tablespoon	T	17
181	7	1 cup water	1.0	cup	c	18
181	4	1 medium white onion- diced	1.0	\N	\N	19
182	129	2 baking Potatoes	2.0	\N	\N	0
182	272	2 cups of beef broth	2.0	cups	c	1
182	10	2 tablespoons of Butter	2.0	tablespoons	T	2
182	92	1 bunch of Cilantro, Chopped	1.0	bunch	bunch	3
182	121	2 tablespoons of Curry	2.0	tablespoons	T	4
182	286	1/2 teaspoon of fennel powder	0.5	teaspoon	t	5
182	185	1/2 teaspoon of Garam Masala	0.5	teaspoon	t	6
182	23	3 cloves of Garlic, Minced	3.0	cloves	cloves	7
182	141	1 teaspoon of Ginger	1.0	teaspoon	t	8
182	405	5 1/2 pounds of Cooked Lamb stew meat	5.5	pounds	lb	9
182	55	6 ounces of Mushrooms, Chopped	6.0	ounces	oz	10
182	72	2 tablespoons of Olive Oil	2.0	tablespoons	T	11
182	4	1 Onion, Diced	1.0	\N	\N	12
182	45	1 tablespoon of Oregano	1.0	tablespoon	T	13
182	39	1/2 cup of Plain Yogurt	0.5	cup	c	14
182	83	1 tablespoon of Rosemary	1.0	tablespoon	T	15
182	6	1/2 teaspoon of Salt	0.5	teaspoon	t	16
182	70	1 can of Tomato Paste	1.0	can	can	17
183	296	1 1/2 lb. beef chuck meat, well-trimmed and cut into 1/2 inch pieces	1.5	lb	lb	0
183	10	1/2 cup butter	0.5	cup	c	1
183	272	1 (15 oz.) can of low-sodium beef broth	15.0	oz	oz	2
183	2	2 med carrots, peeled and chopped small	2.0	\N	\N	3
183	122	dash of cayenne pepper	1.0	dash	dash	4
183	283	1 1/2 t. Dijon mustard	1.5	t	t	5
183	284	1 t. dry mustard	1.0	t	t	6
183	14	1 Egg	1.0	\N	\N	7
183	15	3 T. flour	3.0	T	T	8
183	333	1 t. minced fresh marjoram	1.0	t	t	9
183	43	2 T. chopped fresh parsley	2.0	T	T	10
183	85	1 t. minced fresh thyme	1.0	t	t	11
183	23	1 clove minced garlic	1.0	clove	clove	12
183	7	1/3 c. ice water, plus more if needed	0.3333333333333333	c	c	13
183	4	1 med. onion	1.0	\N	\N	14
183	6	1 teaspoon salt	1.0	teaspoon	t	15
183	280	1 salt & pepper	1.0	\N	\N	16
183	332	8 oz. Irish cheddar, or sharp cheddar cheese, shredded	8.0	oz	oz	17
183	114	1 teaspoon sugar	1.0	teaspoon	t	18
183	71	1/4 cup vegetable oil	0.25	cup	c	19
183	7	2 cups hot water	2.0	cups	c	20
184	22	Optional: 2 rashers bacon, cooked until crisp and broken into pieces	1.0	rashers	rashers	0
184	10	Butter	8.0	servings	servings	1
184	24	1 med. cabbage	1.0	\N	\N	2
184	20	1 cup milk	1.0	cup	c	3
184	4	6 stems green onions, green and white parts, chopped	6.0	\N	\N	4
184	43	1 tablespoon parsley, chopped	1.0	tablespoon	T	5
184	58	1/2 tsp pepper	0.5	tsp	t	6
184	27	1 1/2 pounds potatoes, peeled	1.5	pounds	lb	7
184	6	1 tablespoon Salt	1.0	tablespoon	T	8
185	225	2 Bay Leaves	2.0	\N	\N	0
185	10	1 tbsp. butter, melted	1.0	tbsp	T	1
185	24	1 (2 lb.) cabbage, cut into wedges	2.0	lb	lb	2
185	2	8 mediums Carrots, Pared	8.0	\N	\N	3
185	448	5 pounds Corned-Beef brisket	5.0	pounds	lb	4
185	23	1 Clove Garlic	1.0	Clove	Clove	5
185	4	8 mediums yellow onions, peeled	8.0	\N	\N	6
185	43	Chopped parsley	6.0	servings	servings	7
185	58	10 Whole black Peppers	10.0	\N	\N	8
185	27	8 mediums Potatoes, pared	8.0	\N	\N	9
186	225	1 bay leaf	1.0	\N	\N	0
186	10	1 tbsp. butter, melted	1.0	tbsp	T	1
186	24	1 (2 lb.) cabbage, cut into wedges	2.0	lb	lb	2
186	2	1 lg. carrot, scraped and sliced	1.0	\N	\N	3
186	99	1/4 c. cider vinegar (good quality)	0.25	c	c	4
186	448	1 (4 lb.) corned beef brisket	4.0	lb	lb	5
186	40	1 tbsp. cornstarch	1.0	tbsp	T	6
186	284	1 tsp. dry mustard	1.0	tsp	t	7
186	109	2 egg yolks, beaten	2.0	\N	\N	8
186	43	1 bunch fresh parsley	1.0	bunch	bunch	9
186	415	1 tsp. horseradish	1.0	tsp	t	10
186	27	2 lbs. sm. new potatoes, peeled	2.0	lbs	lb	11
186	4	3 medium onions	3.0	\N	\N	12
186	58	1/4 teaspoon pepper	0.25	teaspoon	t	13
186	6	1/2 tsp. salt	0.5	tsp	t	14
186	114	2 tsp. sugar	2.0	tsp	t	15
186	7	1 c. water	1.0	c	c	16
187	225	1 bay leaf	1.0	\N	\N	0
187	272	2 cups beef broth	2.0	cups	c	1
187	50	1 tablespoon brown sugar	1.0	tablespoon	T	2
187	2	1/4 cup carrots, finely grated	0.25	cup	c	3
187	448	2 pounds corned beef brisket	2.0	pounds	lb	4
187	23	2 cloves garlic, minced	2.0	cloves	cloves	5
187	0	2 cups Guinness	2.0	cups	c	6
187	287	3 spicy honey mustard	3.0	\N	\N	7
187	361	1 pound parsnips, roughly chopped	1.0	pound	lb	8
187	27	2 cups potatoes, boiled and mashed roughly (try to use the floury kind of potato)	2.0	cups	c	9
187	0	2 tablespoons pickling spice	2.0	tablespoons	T	10
188	22	2-3 rashers bacon (optional)	2.0	slices	slices	0
188	23	2 To 3 cloves garlic, minced	2.0	cloves	cloves	1
188	24	1 pound green cabbage (kale can also be used)	1.0	pound	lb	2
188	25	2 medium leeks, split lengthwise and rinsed well	2.0	\N	\N	3
188	26	1/4 teaspoon mace	0.25	teaspoon	t	4
188	27	2 pounds yellow or red potatoes, scrubbed and cubed but not peeled	2.0	pounds	lb	5
188	6	Salt to taste	1.0	\N	\N	6
188	20	1 cup whole milk	1.0	cup	c	7
189	15	1/4 cup all purpose flour	0.25	cup	c	0
189	8	1 1/2 teaspoons baking powder	1.5	teaspoons	t	1
189	224	1 teaspoon Baking Soda	1.0	teaspoon	t	2
189	10	1/4 cup Butter	0.25	cup	c	3
189	348	1 1/2 cups Buttermilk	1.5	cups	c	4
189	321	2/3 cup raisins	0.6666666666666666	cup	c	5
189	6	1/2 teaspoon Salt	0.5	teaspoon	t	6
189	114	5 tablespoons sugar, divided	5.0	tablespoons	T	7
190	224	1 teaspoon Baking Soda	1.0	teaspoon	t	0
190	348	1 1/2 cups Buttermilk	1.5	cups	c	1
190	325	1 teaspoon Caraway Seeds	1.0	teaspoon	t	2
190	14	1 Egg	1.0	\N	\N	3
190	15	4 3/4 cups Flour	4.75	cups	c	4
190	17	3 tablespoons Honey	3.0	tablespoons	T	5
190	6	1/2 tsp salt	0.5	tsp	t	6
190	10	6 tbsp unsalted butter	6.0	tbsp	T	7
191	337	1/2 cup condensed milk	0.5	cup	c	0
191	40	1/4 cup cornstarch	0.25	cup	c	1
191	109	5 egg yolks	5.0	\N	\N	2
191	486	1 oz Irish Whiskey	1.0	oz	oz	3
191	50	1 cup light brown sugar	1.0	cup	c	4
191	20	2 cups homogenized milk	2.0	cups	c	5
191	15	2 1/2 cups pastry flour (all-purpose is fine)	2.5	cups	c	6
191	6	salt	10.0	servings	servings	7
191	10	6 tbsp unsalted butter	6.0	tbsp	T	8
191	510	1/4 cup cold vodka	0.25	cup	c	9
191	7	1/4 cup cold water	0.25	cup	c	10
192	10	1/4 cup butter	0.25	cup	c	0
192	267	5 ounces frozen kale cooked, squeezed dry	5.0	ounces	oz	1
192	20	3 tablespoons milk	3.0	tablespoons	T	2
192	4	1/4 cup chopped onions	0.25	cup	c	3
192	58	1/8 teaspoon pepper	0.125	teaspoon	t	4
192	27	4 mediums potatoes, peeled and quartered	4.0	\N	\N	5
192	6	1 teaspoon salt	1.0	teaspoon	t	6
193	460	1 bottle Irish Ale	1.0	bottle	bottle	0
193	10	60 grams butter	60.0	grams	g	1
193	311	4 tablespoons of cream	4.0	tablespoons	T	2
193	203	40 mussels	40.0	\N	\N	3
193	4	1 medium onion, finely chopped	1.0	\N	\N	4
193	0	5 pieces of pancetta, sliced into pieces	5.0	pieces	\N	5
193	280	Salt and freshly ground black pepper, to taste	4.0	servings	servings	6
193	23	3 whole cloves garlic (chopped)	3.0	cloves	cloves	7
193	43	1/4 cup freshly chopped parsley	0.25	cup	c	8
194	224	1/2 teaspoon baking soda	0.5	teaspoon	t	0
194	10	75g butter	75.0	g	g	1
194	348	1 3/4 c. buttermilk	1.75	c	c	2
194	210	1/2 c. (2 oz.) plain cake flour	2.0	oz	oz	3
194	197	1 1/2 t. cream of tartar	1.5	t	t	4
194	50	1/2 cup dark brown sugar	0.5	cup	c	5
194	0	1/2 c. dried apricots, chopped	0.5	c	c	6
194	437	2 1/2 c. (7 1/2 oz.) old-fashioned oatmeal	7.5	oz	oz	7
194	6	1/4 teaspoon salt	0.25	teaspoon	t	8
194	15	3/4 cup unbleached all-purpose flour	0.75	cup	c	9
194	381	1/2 cup coarsely chopped walnuts or almonds (2 ounces/60 grams)	0.5	cup	c	10
194	14	1 whole egg	1.0	\N	\N	11
194	110	1 c. (5 1/2 oz.) whole-wheat flour	5.5	oz	oz	12
195	8	1 tsp Baking powder	1.0	tsp	t	0
195	224	1 teaspoon baking soda	1.0	teaspoon	t	1
195	14	3 eggs	3.0	\N	\N	2
195	115	3 tablespoons of milk or half in half if the batter is too think	3.0	tablespoons	T	3
195	15	120g Plain flour	120.0	g	g	4
195	309	4 ounces frozen raspberries	4.0	ounces	oz	5
195	6	1/8 tsp pinch of salt	0.125	tsp	t	6
195	126	1 pint sour cream	1.0	pint	pt	7
195	114	1 cup white sugar	1.0	cup	c	8
196	323	3/4 teaspoon aniseed	0.75	teaspoon	t	0
196	224	2 teaspoons baking soda	2.0	teaspoons	t	1
196	317	1/3 cup dark rum	0.3333333333333333	cup	c	2
196	83	1 1/2 tablespoons chopped fresh rosemary	1.5	tablespoons	T	3
196	17	1 tablespoon honey	1.0	tablespoon	T	4
196	20	1 tablespoon milk	1.0	tablespoon	T	5
196	382	1/2 cup pecans, toasted and roughly chopped	0.5	cup	c	6
196	39	1 1/2 cups plain yogurt	1.5	cups	c	7
196	321	1/2 cup raisins	0.5	cup	c	8
196	6	2 teaspoons salt, divided	2.0	teaspoons	t	9
196	110	2 cups whole wheat flour	2.0	cups	c	10
197	225	Bouquet Garni: 2 bay leaves, 2 sprigs of thyme, 5 garlic cloves, 10 black peppercorns	2.0	\N	\N	0
197	447	1 corned beef or beef brisket (about 3 pounds)	3.0	pounds	lb	1
197	276	3 1/2 cups Swanson® Beef Broth or Swanson® Beef Stock	3.5	cups	c	2
197	2	Diced carrots	10.0	servings	servings	3
197	99	1/4 cup cider vinegar	0.25	cup	c	4
197	24	1 head green cabbage, trimmed and cut into 6 wedges (about 2 pounds)	1.0	head	head	5
197	4	2 medium onions, cut into quarters	2.0	\N	\N	6
197	27	5 diced potatoes	5.0	\N	\N	7
198	58	1 teaspoon freshly ground black pepper	1.0	teaspoon	t	0
198	250	2 stalks celery, finely chopped	2.0	stalks	stalks	1
198	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
198	23	5 cloves garlic, minced	5.0	cloves	cloves	3
198	18	Juice of 1 lemon	1.0	\N	\N	4
198	265	1 head kale, stemmed and roughly chopped (about 8 cups)	8.0	cups	c	5
198	97	2 teaspoons kosher salt	2.0	teaspoons	t	6
198	25	2 medium leeks, tough green outer leaves removed, washed well (see Kitchen Tip), and thinly sliced	2.0	\N	\N	7
198	129	3 large russet potatoes, peeled and cut into cubes (about 2 cups)	3.0	\N	\N	8
198	150	1/4 head savoy cabbage, roughly chopped (3 cups)	3.0	cups	c	9
198	105	8 cups Roasted Vegetable Stock or store-bought low-sodium vegetable broth	8.0	cups	c	10
199	487	1/2 cup baileys Irish Cream Syrup	0.5	cup	c	0
199	513	1 chunk Xocai Healthy Chocolate Nugget, grated	1.0	\N	\N	1
199	513	2 Xocai Healthy Chocolate Nuggets	2.0	\N	\N	2
199	486	4 tbsps Irish Whiskey	4.0	tbsps	T	3
199	312	1 Dollop of Whipped Cream	1.0	\N	\N	4
200	176	1 1/2 cups uncooked arborio rice	1.5	cups	c	0
200	251	1 1/2 pounds asparagus cut (sliced into 1 inch pieces)	1.5	pounds	lb	1
200	320	1/2 cup dry white wine	0.5	cup	c	2
200	43	1/4 cup chopped fresh parsley	0.25	cup	c	3
200	23	2 cloves minced garlic	2.0	cloves	cloves	4
200	18	1 tablespoon fresh lemon juice	1.0	tablespoon	T	5
200	146	1 teaspoon grated lemon rind	1.0	teaspoon	t	6
200	72	1 tablespoon olive oil	1.0	tablespoon	T	7
200	4	1/2 cup onion, chopped	0.5	cup	c	8
200	183	1/4 cup grated fresh parmesan cheese	0.25	cup	c	9
200	38	1/2 cup frozen peas (don't thaw)	0.5	cup	c	10
200	58	1/4 teaspoon pepper	0.25	teaspoon	t	11
200	176	or other short-grain rice	4.0	servings	servings	12
200	105	2 14.5 oz cans vegetable broth	29.0	oz	oz	13
200	7	Water	4.0	servings	servings	14
201	67	14.5 oz. can diced tomatoes	14.5	oz	oz	0
201	69	1 head of cauliflower, cut into bite-sized pieces (no larger that 1-inch)	1.0	head	head	1
201	14	2 eggs, well beaten	2.0	\N	\N	2
201	15	1 cup All-purpose flour	1.0	cup	c	3
201	87	3-4 T. chopped fresh basil	3.0	T	T	4
201	23	1 teaspoon minced garlic	1.0	teaspoon	t	5
201	143	3/4 t. garlic powder	0.75	t	t	6
201	58	1/8 t. fresh ground black pepper	0.125	t	t	7
201	72	2 tablespoons Olive oil	2.0	tablespoons	T	8
201	181	2 c. panko bread crumbs	2.0	c	c	9
201	183	3/4 c. fresh grated Parmesan cheese	0.75	c	c	10
201	61	pinch of crushed red pepper flakes	1.0	pinch	pinch	11
201	6	Salt to taste	4.0	servings	servings	12
201	7	1 T. water	1.0	T	T	13
202	207	2 1/4 cup baking mix (like Bisquick or Jiffy)	2.25	cup	c	0
202	87	pinch of basil	1.0	pinch	pinch	1
202	0	Herbed Parmesan Drop Biscuits	6.0	servings	servings	2
202	42	1 lb ground beef or equivalent amount of a ground beef/bulk Italian sausage mix	1.0	lb	lb	3
202	457	1 tsp Italian seasoning	1.0	tsp	t	4
202	20	1 cup milk	1.0	cup	c	5
202	45	pinch of oregano	1.0	pinch	pinch	6
202	183	1/4 cup grated Parmesan cheese	0.25	cup	c	7
202	183	Additional Parmesan cheese for topping	6.0	servings	servings	8
202	316	1 - 26 oz jar of pasta sauce or 1 can pizza sauce	26.0	oz	oz	9
202	441	Pepperoni slices (I used 1/2 of a package of Hormel brand)	0.5	\N	\N	10
202	0	1/2 cup shredded aged Provolone	0.5	cup	c	11
202	61	1/8 - 1/2 tsp crushed red pepper flakes	0.125	tsp	t	12
202	327	1/2 cup ricotta	0.5	cup	c	13
202	172	2 cups shredded mozzarella	2.0	cups	c	14
203	164	2 handfuls of baby spinach (how much you prefer/have room for, it wilts down a lot)	2.0	handfuls	handfuls	0
203	23	2-4 garlic cloves, minced	2.0	cloves	cloves	1
203	55	4-6 oz mushrooms, sliced	4.0	oz	oz	2
203	72	1 tablespoon olive oil	1.0	tablespoon	T	3
203	183	3 tablespoons parmesan cheese, sprinkled on top (optional)	3.0	tablespoons	T	4
203	328	1/2 c. part-skim ricotta	0.5	c	c	5
203	316	Pasta sauce: red jarred sauce, homemade or your favorite (Amount varies on your preference, I used maybe 1/3 of a jar)	0.3333333333333333	\N	\N	6
203	280	Salt and pepper to taste	4.0	servings	servings	7
203	335	4 oz 2% milk mozzarella cheese	4.0	oz	oz	8
203	123	1 sweet onion, diced	1.0	\N	\N	9
203	366	6 whole wheat lasagna noodles, broken into thirds	6.0	\N	\N	10
203	234	1 yellow squash, sliced and chopped	1.0	\N	\N	11
203	233	1 medium zucchini, shredded	1.0	\N	\N	12
204	247	1 can of Cannellini beans- Rinsed and drained	1.0	can	can	0
204	79	1 ounce of 15 can of tomato sauce	1.0	ounce	oz	1
204	67	1 can of diced tomatoes (no salt added)	1.0	can	can	2
204	2	2 carrots thinly sliced	2.0	\N	\N	3
204	275	7 cups of chicken stock	7.0	cups	c	4
204	228	Fresh cracked black pepper	1.0	serving	serving	5
204	0	1/2 box (maybe a little less than 1/2) of Ditalini pasta	0.5	box	box	6
204	23	6 cloves garlic, chopped	6.0	cloves	cloves	7
204	97	Kosher salt	1.0	serving	serving	8
204	80	Madras curry powder	1.0	serving	serving	9
204	41	Paprika	1.0	serving	serving	10
204	249	1 can of Dark Red Kidney beans- Rinsed and drained	1.0	can	can	11
204	61	Red pepper flakes	1.0	serving	serving	12
204	128	3 cups red potatoes, cubed	3.0	cups	c	13
204	164	3 cups of uncooked Spinach	3.0	cups	c	14
204	123	1 sweet onion	1.0	\N	\N	15
204	47	4 vine ripe tomatoes	4.0	\N	\N	16
205	101	2 tablespoons balsamic vinegar	2.0	tablespoons	T	0
205	87	1/4 cup Shredded fresh basil leaves	0.25	cup	c	1
205	72	6 tablespoons extra-virgin olive oil	6.0	tablespoons	T	2
205	172	1 pound fresh mozzarella cheese sliced 1/4" thick	1.0	pound	lb	3
205	183	3 tablespoons Parmesan cheese, grated	3.0	tablespoons	T	4
205	280	1 salt and freshly ground pepper to taste	1.0	\N	\N	5
205	47	4 ripe tomatoes sliced 1/4" inch thick	4.0	\N	\N	6
206	225	1 bay leaf	1.0	\N	\N	0
206	247	1 can cannellini beans	1.0	can	can	1
206	67	14 ounces can diced tomatoes	14.0	ounces	oz	2
206	2	3 carrots	3.0	\N	\N	3
206	275	32 ounces container chicken stock	32.0	ounces	oz	4
206	0	4 spicy Italian sausages	4.0	\N	\N	5
206	457	2 teaspoons Italian seasoning	2.0	teaspoons	t	6
206	72	1 tablespoon olive oil	1.0	tablespoon	T	7
206	4	1 onion	1.0	\N	\N	8
206	61	1/4 teaspoon red pepper flakes	0.25	teaspoon	t	9
206	280	Salt and Pepper	6.0	servings	servings	10
206	164	1 bag fresh spinach	1.0	bag	bag	11
207	225	2 bay leaves	2.0	\N	\N	0
207	67	28 ounces can of whole tomatoes	28.0	ounces	oz	1
207	0	1/2 cup of club soda	0.5	cup	c	2
207	277	5 cups of seafood stock/ fish stock (sub with chicken stock)	5.0	cups	c	3
207	43	Fresh parsley, chopped	3.0	servings	servings	4
207	23	4 cloves garlic	4.0	cloves	cloves	5
207	203	20 Mussels, fresh preferably, I used the frozen packs	20.0	\N	\N	6
207	4	1 onion, chopped	1.0	\N	\N	7
207	56	20 Baby Portobello mushrooms, sliced in half	20.0	\N	\N	8
207	6	2 teaspoons of salt	2.0	teaspoons	t	9
207	457	tablespoon Italian seasoning, 2	1.0	tablespoon	T	10
207	52	1 Shrimps, peeled and devined	1.0	\N	\N	11
207	499	Tilapia, cut into 1.5 chunks	3.0	servings	servings	12
207	47	1 fresh tomato (optional)	1.0	\N	\N	13
207	70	4 ounces can of tomato paste	4.0	ounces	oz	14
208	388	1 large artichoke (1 pound)	1.0	pound	lb	0
208	225	1 Bay Leaf	1.0	\N	\N	1
208	223	1/4 tsp coriander seeds	0.25	tsp	t	2
208	88	1/2 tsp dried basil	0.5	tsp	t	3
208	45	1/2 tsp dried oregano	0.5	tsp	t	4
208	23	1 Garlic Clove, sliced thin	1.0	clove	clove	5
209	59	2 fresh chilies	2.0	\N	\N	0
209	23	1 tablespoon minced garlic	1.0	tablespoon	T	1
209	58	Ground black pepper	3.0	servings	servings	2
209	18	2 lemons, juiced	2.0	\N	\N	3
209	43	1/2 cup of chopped parsley leaves	0.5	cup	c	4
209	0	250 grams of pasta shells (cook pasta according to packet's instructions)	250.0	grams	g	5
209	76	1 red pepper	1.0	\N	\N	6
209	102	400 grams of tuna, drained and flaked	400.0	grams	g	7
210	87	Generous handful basil leaves, torn	1.0	handful	handful	0
210	0	500 grams day-old country bread (preferably unsalted), thickly sliced	500.0	grams	g	1
210	72	extra-virgin olive oil to drizzle	4.0	servings	servings	2
210	23	4 garlic cloves minced	4.0	cloves	cloves	3
210	25	3 leeks, finely chopped	3.0	\N	\N	4
210	276	1 liter meat stock (made with beef and chicken)	1.0	liter	l	5
210	72	1/4 cup olive oil	0.25	cup	c	6
210	96	Sea salt and freshly ground black pepper	4.0	servings	servings	7
210	67	2 liters puréed canned Italian tomatoes	2.0	liters	l	8
211	101	1 tablespoon balsamic vinegar	1.0	tablespoon	T	0
211	431	1 1/2 pounds Brussels sprouts, cleaned and halved	1.5	pounds	lb	1
211	72	5 tablespoons extra-virgin olive oil	5.0	tablespoons	T	2
211	23	1 clove of garlic chopped	1.0	clove	clove	3
211	97	Kosher salt and freshly ground black pepper to taste	4.0	servings	servings	4
212	23	5 Garlic Cloves (finely chopped)	5.0	cloves	cloves	0
212	265	8 Leaves of Kale (stems removed and cut into ribbons)	8.0	Leaves	Leaves	1
212	72	1/4 teaspoon olive oil	0.25	teaspoon	t	2
212	4	1 onion, chopped	1.0	\N	\N	3
212	58	Pepper	4.0	servings	servings	4
212	358	1 cup Quinoa	1.0	cup	c	5
212	392	10 ounces Poached Salmon (flaked)*	10.0	ounces	oz	6
212	6	salt, dry mustard and Worcestershire sauce to taste	4.0	servings	servings	7
212	105	32 ounces Organic Vegetable Stock	32.0	ounces	oz	8
213	225	1 bay leaf	1.0	\N	\N	0
213	247	1 14 oz can cannellini beans	14.0	oz	oz	1
213	2	4 carrots	4.0	\N	\N	2
213	88	1 1/2 tsp Dried Basil	1.5	tsp	t	3
213	0	1 1/2 cups (6 oz) elbow macaroni	6.0	oz	oz	4
213	58	1 tsp Ground Pepper	1.0	tsp	t	5
213	72	2 tsps olive oil	2.0	tsps	t	6
213	4	1 onion	1.0	\N	\N	7
213	183	1 tsp Grated Parmesan Cheese	1.0	tsp	t	8
213	6	1 1/2 tsp salt	1.5	tsp	t	9
213	47	2 14 oz cans diced tomato	28.0	oz	oz	10
213	233	2 zucchini	2.0	\N	\N	11
214	88	1 teaspoon DRIED BASIL	1.0	teaspoon	t	0
214	45	1 teaspoon OREGANO	1.0	teaspoon	t	1
214	87	12 LARGE BASIL LEAVES	12.0	\N	\N	2
214	58	3/4 teaspoon CRACKED BLACK PEPPER	0.75	teaspoon	t	3
214	91	1 teaspoon FRESH MINCED CHIVES	1.0	teaspoon	t	4
214	45	1 teaspoon FRESH MINCED OREGANO	1.0	teaspoon	t	5
214	43	2 tablespoons FRESH MINCED PARSLEY	2.0	tablespoons	T	6
214	144	10 FRESH SAGE LEAVES- CUT INTO CHIFFONADE	10.0	\N	\N	7
214	23	4 MINCED GARLIC CLOVES	4.0	cloves	cloves	8
214	482	3/4 teaspoon GARLIC SALT	0.75	teaspoon	t	9
214	16	1/2 teaspoon GROUND NUTMEG	0.5	teaspoon	t	10
214	0	8 sheets OF LASAGNA	8.0	sheets	sheets	11
214	328	16 ounces LOW FAT RICOTTA CHEESE	16.0	ounces	oz	12
214	55	4 MUSHROOMS DICED	4.0	\N	\N	13
214	72	4 tablespoons OLIVE OIL	4.0	tablespoons	T	14
214	183	1/4 cup SHREDDED OR GRATED PARMESAN	0.25	cup	c	15
214	0	1/2 cup CUBE DICED PECORINO CHEESE	0.5	cup	c	16
214	61	1/2 teaspoon RED PEPPER FLAKES	0.5	teaspoon	t	17
214	172	1/4 cup SHREDDED MOZZARELLA	0.25	cup	c	18
214	164	1 cup SPINACH- WASHED	1.0	cup	c	19
214	47	28 OZ CAN WHOLE SAN MARZANO TOMATOES	28.0	\N	\N	20
214	233	1 SMALL ZUCCHINI SHREDDED	1.0	\N	\N	21
215	177	8 tsps brown rice miso	8.0	tsps	t	0
215	2	2 lg. carrots, cut into pieces	2.0	\N	\N	1
215	53	3/4 cup sliced daikon radish	0.75	cup	c	2
215	94	1/2 cup chopped green onion	0.5	cup	c	3
215	55	3/4 sliced shitake mushrooms	0.75	\N	\N	4
215	148	1 1/2 cups sliced napa cabbage	1.5	cups	c	5
215	28	2 Tbsps toasted sesame oil	2.0	Tbsps	Tbsps	6
215	31	1/2 cup snow peas	0.5	cup	c	7
215	7	8 cups water	8.0	cups	c	8
215	155	2 cups chopped yams (with peels)	2.0	cups	c	9
215	233	1 cup zucchini, cut into pieces	1.0	cup	c	10
216	2	1 Carrot thinly sliced	1.0	\N	\N	0
216	158	1/2 Iceberg lettuce head torn	0.5	\N	\N	1
216	74	2 tsps Light soy sauce	2.0	tsps	t	2
216	458	3 Tbsps Mirin (Japanese rice wine)	3.0	Tbsps	Tbsps	3
216	461	3/4 cup Red miso (soybean paste)	0.75	cup	c	4
216	28	1/4 tsp Sesame oil	0.25	tsp	t	5
216	46	1 Tbsp Toasted sesame seeds	1.0	Tbsp	Tbsp	6
216	114	3 Tbsps Sugar	3.0	Tbsps	Tbsps	7
216	7	2 Tbsps Hot water	2.0	Tbsps	Tbsps	8
217	367	6 chicken drumsticks	6.0	\N	\N	0
217	23	2 cloves of garlic diced	2.0	cloves	cloves	1
217	141	1 tablespoon of shredded ginger	1.0	tablespoon	T	2
217	17	1 teaspoon of honey	1.0	teaspoon	t	3
217	4	1 onion, sliced	1.0	\N	\N	4
217	6	Salt, pepper, garlic,	1.0	serving	serving	5
217	0	1 cup of teriyaki sauce	1.0	cup	c	6
217	71	1 teaspoon of vegetable oil	1.0	teaspoon	t	7
218	239	2 cups broccoli florets	2.0	cups	c	0
218	50	1 tablespoon brown sugar	1.0	tablespoon	T	1
218	40	1 tablespoon cornstarch	1.0	tablespoon	T	2
218	28	1 teaspoon dark sesame oil	1.0	teaspoon	t	3
218	453	1/2 pound beef sirloin or flank steak, cut into 1/2" strips	0.5	pound	lb	4
218	23	1 teaspoon garlic, minced	1.0	teaspoon	t	5
218	141	1 tablespoon ginger, peeled and minced	1.0	tablespoon	T	6
218	55	1 cup chopped mushrooms	1.0	cup	c	7
218	71	6 teaspoons Oil	6.0	teaspoons	t	8
218	76	1 cup sliced red bell pepper	1.0	cup	c	9
218	94	2 tablespoons chopped scallions	2.0	tablespoons	T	10
218	46	2 teaspoons sesame seeds, toasted	2.0	teaspoons	t	11
218	74	1/4 cup soy sauce	0.25	cup	c	12
219	50	2 TBSP Brown Sugar	2.0	TBSP	TBSP	0
219	40	1/2 TBSP cornstarch	0.5	TBSP	TBSP	1
219	23	2 TBSP Garlic, minced	2.0	TBSP	TBSP	2
219	141	2 TBSP Ginger, minced	2.0	TBSP	TBSP	3
219	94	1 Green onion, sliced	1.0	\N	\N	4
219	18	2 TBSP Lemon Juice	2.0	TBSP	TBSP	5
219	268	1/2 cup low sodium soy sauce	0.5	cup	c	6
219	458	2 TBSP Mirin	2.0	TBSP	TBSP	7
219	28	1 TBSP sesame oil	1.0	TBSP	TBSP	8
219	46	2 TBSP sesame seeds	2.0	TBSP	TBSP	9
219	54	6 oz shiitake mushrooms	6.0	oz	oz	10
219	354	2 Boneless Skinless Chicken Breasts	2.0	\N	\N	11
219	423	6 oz soba noodles	6.0	oz	oz	12
219	32	2 TBSP Sriracha	2.0	TBSP	TBSP	13
220	176	1 cup arborio rice	1.0	cup	c	0
220	91	1/4 cup chives, finely chopped+ to garnish	0.25	cup	c	1
220	23	3 cloves of garlic, finely chopped	3.0	cloves	cloves	2
220	236	1 hokkaido squash, small size	1.0	\N	\N	3
220	72	3 tablespoons olive oil	3.0	tablespoons	T	4
220	4	1 onion, medium size, finely chopped	1.0	\N	\N	5
220	183	20 grams parmesan cheese, grated	20.0	grams	g	6
220	183	40 grams parmigiano reggiano (parmesan), grated	40.0	grams	g	7
220	0	1/4 cup pomegranate seeds+ to garnish	0.25	cup	c	8
220	280	salt and pepper to taste	2.0	servings	servings	9
220	7	400 milliliters water (more or less)	400.0	milliliters	ml	10
221	164	6 cups baby spinach leaves (about 6 oz) rinsed, drained	6.0	oz	oz	0
221	353	1/2 pound boned skinned chicken breast rinsed and cut into 1/4" strips	0.5	pound	lb	1
221	188	6 cups cooked rice	6.0	cups	c	2
221	14	5 large eggs (yolks and whites separated)	5.0	\N	\N	3
221	271	1 cup fat-skimmed chicken broth	1.0	cup	c	4
221	141	2 tablespoons minced fresh ginger	2.0	tablespoons	T	5
221	4	1 onion - (6 oz) peeled, and	6.0	oz	oz	6
221	47	1/4 cup diced Roma tomato	0.25	cup	c	7
221	74	2 tablespoons Soy sauce	2.0	tablespoons	T	8
221	114	4 tablespoons sugar	4.0	tablespoons	T	9
221	71	1 cup salad oil	1.0	cup	c	10
222	2	1/2 Carrot -- shredded	0.5	\N	\N	0
222	275	4 cups Homemade chicken stock	4.0	cups	c	1
222	511	4 tablespoons Dry sherry	4.0	tablespoons	T	2
222	94	1 Green onion -- finely	1.0	\N	\N	3
222	145	1/2 Lemon -- thinly sliced	0.5	\N	\N	4
222	55	4 Mushrooms -- thinly sliced	4.0	\N	\N	5
222	74	2 tablespoons Soy sauce	2.0	tablespoons	T	6
222	252	1 Block Firm Tofu	1.0	\N	\N	7
222	252	Tofu -- 5 cubes per serving	5.0	cubes	cubes	8
223	24	1 lg. head cabbage (slawed)	1.0	head	head	0
223	94	3 green onions thinly sliced	3.0	\N	\N	1
223	58	1 teaspoon pepper	1.0	teaspoon	t	2
223	425	2 pkgs. Ramen Pride (oriental) noodles (do not cook or use broth)	2.0	pkgs	pkgs	3
223	297	6 tablespoons rice vinegar	6.0	tablespoons	T	4
223	6	2 teaspoons salt	2.0	teaspoons	t	5
223	46	2 tablespoons sesame seeds	2.0	tablespoons	T	6
223	451	8 tablespoons slivered almonds (2 1/4 oz. pkg.)	8.0	tablespoons	T	7
223	114	4 tablespoons sugar	4.0	tablespoons	T	8
223	71	1 cup salad oil	1.0	cup	c	9
224	2	3 small carrots, chop bite size	3.0	\N	\N	0
224	121	1/2 package Japanese curry, such as S & B Golden Curry (look for this in the Asian section of supermarkets or on Amazon.com)	0.5	package	pkg	1
224	71	1 tablespoon neutral oil	1.0	tablespoon	T	2
224	4	1 medium size onion, finely chopped	1.0	\N	\N	3
224	27	2 potatoes, chopped bite size	2.0	\N	\N	4
224	444	1 package puff pastry dough sheets	1.0	packagesheet	packagesheet	5
224	7	2 tablespoons Water	2.0	tablespoons	T	6
225	0	1 tablespoon tonkatsu sauce (vegetable and fruit sauce. I use Bull-Dog)	1.0	tablespoon	T	0
225	58	1/4 teaspoon Black pepper	0.25	teaspoon	t	1
225	353	1/4 pound boneless chicken breast, cut into small cubes	0.25	pound	lb	2
225	2	1 small carrot, finely chopped	1.0	\N	\N	3
225	14	2 eggs	2.0	\N	\N	4
225	23	2 garlic cloves, finely chopped	2.0	cloves	cloves	5
225	97	1/4 teaspoon kosher salt	0.25	teaspoon	t	6
225	11	2 tablespoons neutral oil (canola, grapeseed)	2.0	tablespoons	T	7
225	38	1 cup frozen green peas (thawed)	1.0	cup	c	8
225	0	3 cups cooked Japanese rice	3.0	cups	c	9
225	74	2 tablespoons soy sauce	2.0	tablespoons	T	10
226	2	2 carrots, thinly sliced	2.0	\N	\N	0
226	0	3 teaspoons Hon Dashi	3.0	teaspoons	t	1
226	141	1 tablespoon fresh ginger, minced	1.0	tablespoon	T	2
226	478	6 inches length of kombu, wiped with damp cloth	6.0	inches	inches	3
226	458	3 tablespoons mirin	3.0	tablespoons	T	4
226	461	3 tablespoons miso	3.0	tablespoons	T	5
226	187	package fresh Udon or fresh rice noodles	1.0	package	pkg	6
226	94	2 scallions, minced	2.0	\N	\N	7
226	74	1/2 cup soy sauce	0.5	cup	c	8
226	164	1/2 pound fresh spinach	0.5	pound	lb	9
226	114	1 tablespoon sugar	1.0	tablespoon	T	10
226	0	8 ounces firm tofu (preferably silken), cut in 1/2" cubes	8.0	ounces	oz	11
226	7	130 ml water	130.0	ml	ml	12
227	23	1/2 teaspoon Minced Garlic	0.5	teaspoon	t	0
227	141	1 1/2 teaspoons ginger root	1.5	teaspoons	t	1
227	458	1/2 cup Mirin	0.5	cup	c	2
227	426	4 ounces Udon noodles uncooked or vermicelli	4.0	oz	oz	3
227	94	1/2 cup green onion thinly sliced	0.5	cup	c	4
227	268	1 tablespoon low sodium soy sauce	1.0	tablespoon	T	5
227	28	1 tablespoon Oriental sesame oil	1.0	tablespoon	T	6
227	274	2 can reduced sodium beef broth (14.5 oz)	14.5	oz	oz	7
227	54	8 ounces shiitake mushrooms dried or fresh if dried, rehydrate before using stems disca	8.0	ounces	oz	8
227	508	1 1/2 teaspoons hot chile oil or 2 tsp vegetable oil plus 1/2 crushed red pepper flakes	1.5	teaspoons	t	9
228	59	1 hot chili pepper, seeded and finely minced	1.0	\N	\N	0
228	17	1 teaspoon honey	1.0	teaspoon	t	1
228	391	12 slices salmon, about 2 to 3 ounces	12.0	slices	slices	2
228	94	2 scallions, green part only, thinly sliced	2.0	\N	\N	3
228	28	2 teaspoons sesame oil divided	2.0	teaspoons	t	4
228	46	1 tablespoon sesame seeds	1.0	tablespoon	T	5
228	74	1/2 cup to mari soy sauce	0.5	cup	c	6
228	98	1 teaspoon vinegar	1.0	teaspoon	t	7
229	453	1 pound well-trimmed beef top sirloin 3 cups sliced napa cabbage	1.0	pound	lb	0
229	2	1/2 cup thin diagonally sliced carrots	0.5	cup	c	1
229	188	1 cup cooked rice	1.0	cup	c	2
229	31	24 pea pods, blanched	24.0	\N	\N	3
229	237	1/2 cup thin sliced cucumber	0.5	cup	c	4
229	511	3 tablespoons dry sherry	3.0	tablespoons	T	5
229	141	1/2 teaspoon grated fresh ginger	0.5	teaspoon	t	6
229	94	1 green onion, sliced diagonally (not to be cooked)	1.0	\N	\N	7
229	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	8
229	74	3 tablespoons light soy sauce	3.0	tablespoons	T	9
229	28	1 tablespoon Oriental dark roasted sesame oil	1.0	tablespoon	T	10
229	29	1/2 cup thin sliced radishes	0.5	cup	c	11
229	297	3 tablespoons rice wine vinegar	3.0	tablespoons	T	12
229	157	3 cups romaine lettuce, cut 1/4 inch	3.0	cups	c	13
229	114	1 tablespoon sugar	1.0	tablespoon	T	14
229	7	3 tablespoons water	3.0	tablespoons	T	15
230	10	1 cup butter	1.0	cup	c	0
230	114	25 grams Caster Sugar	25.0	grams	g	1
230	13	125 grams cream cheese at room temperature	125.0	grams	g	2
230	197	1/4 teaspoon cream of tartar	0.25	teaspoon	t	3
230	20	40 mls milk	40.0	mls	mls	4
230	193	1 tablespoon scant orange juice	1.0	tablespoon	T	5
230	476	1 tablespoon orange zest	1.0	tablespoon	T	6
230	6	1 teaspoon salt	1.0	teaspoon	t	7
230	449	40 grams self raising flour ( or cake flour)	40.0	grams	g	8
230	14	3 large eggs, white and yolk seperated	3.0	\N	\N	9
231	253	3 tablespoons canola or corn oil	3.0	tablespoons	T	0
231	80	2 1/2 tablespoons curry powder, plus more to taste	2.5	tablespoons	T	1
231	4	2 mediums onions, halved vertically and thinly sliced	2.0	\N	\N	2
231	38	1 cup frozen peas	1.0	cup	c	3
231	56	1 pound portobello mushrooms (stems and caps), cut into 1 inch cubes, or 1	1.0	pound	lb	4
231	40	1/4 cup plus 1 tablespoon cornstarch or potato starch	0.25	cup	c	5
231	27	1 1/2 pounds potatoes, cut into 1- to 1 1/2 inch cubes	1.5	pounds	lb	6
231	96	1 teaspoon sea salt, plus more to taste	1.0	teaspoon	t	7
231	125	2 1/2 tablespoons tamari, plus more to taste	2.5	tablespoons	T	8
231	252	tofu, cut	1.0	serving	serving	9
231	55	white mushrooms, halved or quartered (depending on size)	1.0	serving	serving	10
232	251	Asparagus	1.0	serving	serving	0
232	413	Cooked octopus	1.0	serving	serving	1
232	57	Cooked prawns	1.0	serving	serving	2
232	391	Salmon	1.0	serving	serving	3
232	390	Salmon caviar	1.0	serving	serving	4
232	416	Lava seaweed	1.0	serving	serving	5
232	54	Shiitake mushrooms	1.0	serving	serving	6
232	174	Japanese sticky rice	1.0	serving	serving	7
232	103	Raw tuna	1.0	serving	serving	8
232	414	Wasabi	1.0	serving	serving	9
233	77	Dried red chili peppers, optional	4.0	servings	servings	0
233	237	3 to 4 Japanese cucumbers	3.0	\N	\N	1
233	297	1 tablespoon rice vinegar	1.0	tablespoon	T	2
233	28	1 teaspoon sesame oil	1.0	teaspoon	t	3
233	74	2 tablespoons soy sauce	2.0	tablespoons	T	4
234	0	6 baby carrots, cut up	6.0	\N	\N	0
234	91	2 smalls chives, cut into squares	2.0	\N	\N	1
234	141	1 ginger	1.0	\N	\N	2
234	142	pinch of ginger powder-taste as you go to adjust flavors	1.0	pinch	pinch	3
234	55	8 shitaki mushrooms, cut up lengthwise	8.0	\N	\N	4
234	361	1 parsnip, cut up	1.0	\N	\N	5
234	61	pinch of red pepper flakes-taste as you go to adjust flavors	1.0	pinch	pinch	6
234	187	1/2 package of a of Thai Kitchen Thin Rice Noodles	0.5	package	pkg	7
234	164	bunch of fresh spinach	1.0	bunch	bunch	8
234	252	1/2 of a block of firm tofu	0.5	\N	\N	9
234	7	2 cups of water	2.0	cups	c	10
234	4	1 yellow onion, chopped up	1.0	\N	\N	11
234	233	1 zucchini, cut up	1.0	\N	\N	12
235	40	2-3 tbsp. corn starch	2.0	tbsp	T	0
235	319	1/2 cup dry red wine	0.5	cup	c	1
235	445	4-5 oz. Kataifi pastry (shredded phyllo)	4.0	oz	oz	2
235	116	2 egg whites, whisked	2.0	\N	\N	3
235	0	2 filet mignon steaks, about 1 " thick	2.0	\N	\N	4
235	141	1 tsp. finely chopped fresh ginger	1.0	tsp	t	5
235	23	1 Clove garlic, finely chopped	1.0	Clove	Clove	6
235	71	Oil for frying, brushing and grilling (a neutral oil such as Safflower is best)	2.0	servings	servings	7
235	181	1 cup panko (Oriental bread bread crumbs)	1.0	cup	c	8
235	61	1 tsp. hot pepper flakes (optional)	1.0	tsp	t	9
235	297	1 tbsp. rice vinegar	1.0	tbsp	T	10
235	74	2 tbsp. each: Light soy sauce, Raw Honey, Hoisin Sauce	2.0	tbsp	T	11
235	7	4 sweet water shrimp with tails on (available at most Asian markets)	4.0	\N	\N	12
236	0	Goji berries, some	2.0	servings	servings	0
236	478	Dried kombu (seaweed/kelp), 7g	7.0	g	g	1
236	458	tablespoon Mirin, 4	1.0	tablespoon	T	2
236	0	tablespoon Sake, 1	1.0	tablespoon	T	3
236	391	Salmon filet/loin, 250-300g	250.0	g	g	4
236	46	teaspoon Sesame seeds, 1-2	1.0	teaspoon	t	5
236	423	200g Soba (buckwheat noodles)	200.0	g	g	6
236	74	tablespoon Soya sauce, 4	1.0	tablespoon	T	7
236	114	tablespoon Sugar, 2	1.0	tablespoon	T	8
236	71	tablespoon Vegetable oil, 1	1.0	tablespoon	T	9
236	7	5 cups Water	5.0	cups	c	10
237	58	Freshly-ground black pepper to taste	6.0	servings	servings	0
237	2	2 large carrots, sliced	2.0	\N	\N	1
237	250	2 large celery stalks with leaves on, chopped	2.0	stalks	stalks	2
237	0	1 5-6 pound chicken	5.0	pound	lb	3
237	216	Optional: fresh dill or parsley for garnish	6.0	servings	servings	4
237	14	3 Eggs	3.0	\N	\N	5
237	216	3 sprigs fresh dill	3.0	sprigs	sprigs	6
237	0	1 cup matzo meal	1.0	cup	c	7
237	4	1 onion, quartered	1.0	\N	\N	8
237	43	3 sprigs parsley	3.0	sprigs	sprigs	9
237	6	1/4 teaspoon Salt	0.25	teaspoon	t	10
237	280	Salt and pepper, to taste	6.0	servings	servings	11
237	0	1/4 cup seltzer water	0.25	cup	c	12
237	71	4 tablespoons chicken fat or vegetable oil	4.0	tablespoons	T	13
238	8	4 tsp.s baking powder	4.0	tsp	t	0
238	12	2 tsp.s cinnamon	2.0	tsp	t	1
238	14	6 eggs	6.0	\N	\N	2
238	15	6 c.s unsifted all-purpose flour	6.0	c	c	3
238	322	1 c. golden raisins	1.0	c	c	4
238	382	1 can (6 oz.) pecans or walnuts, chopped (2 c.)	6.0	oz	oz	5
238	89	1 jar (18 oz.) strawberry or cherry jam	18.0	oz	oz	6
238	114	c. sugar	1.0	c	c	7
238	71	1 c. salad oil	1.0	cup	c	8
239	122	1/2 teaspoon cayenne	0.5	teaspoon	t	0
239	14	2 large eggs	2.0	\N	\N	1
239	143	1 teaspoon garlic powder	1.0	teaspoon	t	2
239	166	1 teaspoon onion powder	1.0	teaspoon	t	3
239	4	2 onions grated	2.0	\N	\N	4
239	27	3 large potatoes peeled and grated	3.0	\N	\N	5
239	212	2/3 cup rice flour	0.6666666666666666	cup	c	6
239	280	salt and pepper	16.0	servings	servings	7
240	127	applesauce and low-fat sour cream for serving	2.0	servings	servings	0
240	14	1 Egg, beaten	1.0	\N	\N	1
240	23	3 cloves of garlic, skinned and coarse grated	3.0	cloves	cloves	2
240	141	1/2 inch of ginger, skinned and coarse grated (optional for garlic flavoring)	0.5	inch	inch	3
240	361	1/2 C of parsnips, skinned and coarse grated	0.5	cup	c	4
240	254	peanut or other high temperature cooking oil	2.0	servings	servings	5
240	129	1 C of Yukon Gold or russet potatoes, skinned and coarse grated	1.0	cup	c	6
240	280	salt and pepper to taste	2.0	servings	servings	7
240	15	1 oz white flour	1.0	oz	oz	8
240	155	1/2 C of yams, skinned and coarse grated	0.5	cup	c	9
240	4	1/2 C of red or other onion, skinned and coarse grated	0.5	cup	c	10
241	15	7 cups bread flour	7.0	cups	c	0
241	50	¼ cup brown sugar	0.25	cup	c	1
241	14	2 eggs	2.0	\N	\N	2
241	6	1/4 teaspoon salt	0.25	teaspoon	t	3
241	71	1/2 cup vegetable oil	0.5	cup	c	4
241	7	3 tbsp. water	3.0	tbsp	T	5
241	196	2 packages regular yeast	2.0	packages	packages	6
242	213	1/2 brown rice flour (I use Bob's Red Mill)	0.5	\N	\N	0
242	114	2 tablespoons evaporated cane sugar	2.0	tablespoons	T	1
242	12	1 teaspoon Cinnamon	1.0	teaspoon	t	2
242	0	1/2 cup coconut creamer (I use So Delicious brand)	0.5	cup	c	3
242	350	1 1/2 cups vanilla coconut milk or unsweetened (I use So Delicious brand)	1.5	cups	c	4
242	109	10 egg yolks, beaten	10.0	\N	\N	5
242	12	1 1/2 teaspoons ground cinnamon	1.5	teaspoons	t	6
242	16	1/2 teaspoon ground nutmeg	0.5	teaspoon	t	7
242	97	2 tablespoons kosher salt, boiling pasta	2.0	tablespoons	T	8
242	112	1 can pineapple chunks, drained	1.0	can	can	9
242	226	1/2 tablespoon Earth Balance Soy Free Margarine	0.5	tablespoon	T	10
242	187	1 16 ounce package spiral gluten free rice pasta	16.0	ounce	oz	11
242	255	4 tablespoons sunflower oil	4.0	tablespoons	T	12
242	494	1/8 cup xylitol	0.125	cup	c	13
243	225	3 bay leaves	3.0	\N	\N	0
243	447	1 (4 pound) beef brisket	4.0	pound	lb	1
243	58	Freshly ground black pepper	10.0	servings	servings	2
243	67	1 16 oz. can of chopped tomatoes	16.0	oz	oz	3
243	2	2 carrots, coarsely chopped	2.0	\N	\N	4
243	250	3 celery stalks, cut into chunks	3.0	stalks	stalks	5
243	319	2 cups dry red wine	2.0	cups	c	6
243	43	1 handful fresh flat-leaf parsley leaves	1.0	handful	handful	7
243	83	4 sprigs fresh rosemary, needles striped from the stem and chopped	4.0	sprigs	sprigs	8
243	23	6 garlic cloves, pressed	6.0	cloves	cloves	9
243	97	1/2 teaspoon kosher salt	0.5	teaspoon	t	10
243	72	Olive oil	10.0	servings	servings	11
243	15	2 teaspoons plain flour	2.0	teaspoons	t	12
243	4	4 large red onions, halved	4.0	\N	\N	13
244	164	1/2 pound baby spinach, parboiled	0.5	pound	lb	0
244	2	2 carrots, julienned	2.0	\N	\N	1
244	23	2 cloves garlic, finely chopped	2.0	cloves	cloves	2
244	55	5 mushrooms, sliced (I like to use criminis)	5.0	\N	\N	3
244	72	2 tablespoons olive oil	2.0	tablespoons	T	4
244	6	Salt to taste	4.0	servings	servings	5
244	94	3 scallions, chopped	3.0	\N	\N	6
244	28	2 tablespoons sesame oil	2.0	tablespoons	T	7
244	46	Sesame seeds	4.0	servings	servings	8
244	74	3 tablespoons soy sauce	3.0	tablespoons	T	9
244	114	1 teaspoon sugar	1.0	teaspoon	t	10
244	123	1 sweet onion, sliced into thin strips	1.0	\N	\N	11
244	154	8 ounces sweet potato vermicelli noodles	8.0	ounces	oz	12
244	233	1/2 cup zucchini, sliced into half-moons	0.5	cup	c	13
245	130	1/2 apple or pear	0.5	\N	\N	0
245	156	1 bunch Boston bibb lettuce	1.0	bunch	bunch	1
245	50	1 tbsp brown sugar	1.0	tbsp	T	2
245	372	2 lbs chicken thighs	2.0	lbs	lb	3
245	23	3 garlic cloves	3.0	cloves	cloves	4
245	141	1 tsp ginger	1.0	tsp	t	5
245	61	1 tsp red pepper flakes	1.0	tsp	t	6
245	94	scallions	4.0	servings	servings	7
245	28	1 tsp sesame oil	1.0	tsp	t	8
245	46	1 tsp sesame seeds (garnish)	1.0	tsp	t	9
245	74	1/2 cup soy sauce	0.5	cup	c	10
246	164	3 cups fresh baby spinach	3.0	cups	c	0
246	51	1 1/2 cups bean sprouts	1.5	cups	c	1
246	453	3/4 pound thin strips sirloin, rib eye or bulgogi beef	0.75	pound	lb	2
246	2	1 cup carrots, julienned	1.0	cup	c	3
246	109	4 egg yolks	4.0	\N	\N	4
246	54	1 cup fresh shiitake mushrooms, thinly sliced	1.0	cup	c	5
246	23	1 garlic clove, minced	1.0	clove	clove	6
246	78	1/4 cup gochujang	0.25	cup	c	7
246	94	1 cup green onions, chopped	1.0	cup	c	8
246	481	10 ounces kimchi	10.0	ounces	oz	9
246	472	1 cup Korean barbecue bulgogi marinade	1.0	cup	c	10
246	6	Pinch of salt	1.0	pinch	pinch	11
246	28	1/4 cup sesame oil	0.25	cup	c	12
246	46	2 teaspoons toasted sesame seeds	2.0	teaspoons	t	13
246	176	4 cups short grain white rice, cooked	4.0	cups	c	14
246	114	Pinch of sugar	1.0	pinch	pinch	15
246	0	3 cups high grade Korean sushi rice	3.0	cups	c	16
246	252	3/4 cup firm tofu, rinsed and cut into 1-inch cubes	0.75	cup	c	17
246	233	1 cup zucchini, julienned	1.0	cup	c	18
247	0	2 lb beef short ribs	2.0	lb	lb	0
247	14	2 egg strips (optional; garnish)	2.0	\N	\N	1
247	23	4 cloves garlic minced	4.0	cloves	cloves	2
247	427	4 oz sweet potato or glass noodles (dangmyun)	4.0	oz	oz	3
247	58	1 tsp ground pepper	1.0	tsp	t	4
247	53	1/2 large Korea radish, cut into 1 inch slices	0.5	\N	\N	5
247	94	2 scallions, sliced into 1 inch pieces	2.0	\N	\N	6
247	96	2 tsp sea salt (Kosher okay too)	2.0	tsp	t	7
247	28	2 tsp sesame oil	2.0	tsp	t	8
247	46	1/2 tsp toasted sesame seeds (optional; garnish)	0.5	tsp	t	9
247	74	3 tbsp soy sauce	3.0	tbsp	T	10
248	23	5 garlic cloves (minced)	5.0	cloves	cloves	0
248	141	1 tablespoon ginger root minced or 2 tsp. ginger powder	1.0	tablespoon	T	1
248	95	4 tablespoons dried ground chili pepper	4.0	tablespoons	T	2
248	148	6 pounds Napa cabbage	6.0	pounds	lb	3
248	6	Salt (if needed)	6.0	servings	servings	4
248	94	2 cups sliced scallions	2.0	cups	c	5
248	114	1 tablespoon sugar;	1.0	tablespoon	T	6
249	50	1 cup brown sugar, packed	1.0	cup	c	0
249	96	4 cups coarse sea salt	4.0	cups	c	1
249	163	1/2 cup fish sauce	0.5	cup	c	2
249	23	12 garlic cloves	12.0	cloves	cloves	3
249	141	2 tbsp minced ginger	2.0	tbsp	T	4
249	0	4 cups gochugaru (Korean red chili flakes)	4.0	cups	c	5
249	94	3 green onions, cut into 2-inch pieces	3.0	\N	\N	6
249	148	3 Napa cabbages	3.0	\N	\N	7
249	29	2 cups radish (1/2 Korean radish), cut into matchstick pieces	2.0	cups	c	8
249	0	3 tbsp sweet rice flour (simmered with 3 cups water)	3.0	tbsp	T	9
249	4	1 yellow onion	1.0	\N	\N	10
249	0	4 tbsp saewujeot (salted shrimp)	4.0	tbsp	T	11
250	453	1/2 lb sirloin or tender cut beef, cut into thin strips	0.5	lb	lb	0
250	10	1 tablespoon Butter or margarine	1.0	tablespoon	T	1
250	428	8 (10-inch) flour tortillas	8.0	10-inch	10-inch	2
250	143	1 tsp garlic powder	1.0	tsp	t	3
250	94	2 green onions, thinly sliced diagonally	2.0	\N	\N	4
250	481	2 cups kimchi, drained and chopped	2.0	cups	c	5
250	72	1 tablespoon Olive oil	1.0	tablespoon	T	6
250	280	Salt & freshly ground pepper	4.0	servings	servings	7
250	46	2 tbsp sesame seeds, toasted	2.0	tbsp	T	8
250	332	1, 2 cup shredded Sharp Cheddar	2.0	cup	c	9
251	453	2 pounds Beef sirloin tips cut into pieces	2.0	pounds	lb	0
251	23	1 Clove minced garlic, or crushed	1.0	Clove	Clove	1
251	94	10 green onions, minced	10.0	\N	\N	2
251	28	3 tablespoons sesame oil	3.0	tablespoons	T	3
251	46	3 tablespoons toasted sesame seeds	3.0	tablespoons	T	4
251	74	1/4 cup soy sauce	0.25	cup	c	5
251	114	2 tablespoons sugar	2.0	tablespoons	T	6
252	452	1 pound Beef flank steak, sliced into 1/2-inch slices	1.0	pound	lb	0
252	58	Freshly ground black pepper	1.0	serving	serving	1
252	91	1 tablespoon Snipped chives	1.0	tablespoon	T	2
252	61	Crushed red pepper, to taste	1.0	serving	serving	3
252	141	1 tablespoon Chopped fresh ginger	1.0	tablespoon	T	4
252	23	2 cloves garlic (finely chopped)	2.0	cloves	cloves	5
252	174	2 cups Cooked white long grain rice	2.0	cups	c	6
252	6	Salt	1.0	serving	serving	7
252	28	1/4 cup sesame oil	0.25	cup	c	8
252	74	1 tablespoon soy sauce	1.0	tablespoon	T	9
253	164	4 cups fresh baby spinach	4.0	cups	c	0
253	51	1 1/2 cups bean sprouts	1.5	cups	c	1
253	481	10 ounces cabbage kimchi	10.0	ounces	oz	2
253	2	1 cup carrots, julienned	1.0	cup	c	3
253	54	1 cup fresh shiitake mushrooms, thinly sliced	1.0	cup	c	4
253	23	2 garlic cloves, minced	2.0	cloves	cloves	5
253	78	1/4 cup gochujang	0.25	cup	c	6
253	94	1 cup green onions, chopped	1.0	cup	c	7
253	472	1/2 cup Korean barbecue bulgogi marinade	0.5	cup	c	8
253	6	1 teaspoon Salt	1.0	teaspoon	t	9
253	28	1/4 cup sesame oil	0.25	cup	c	10
253	46	2 teaspoons toasted sesame seeds	2.0	teaspoons	t	11
253	176	4 cups short-grain white rice, cooked	4.0	cups	c	12
253	114	Pinch of sugar	1.0	pinch	pinch	13
253	252	1 cup firm tofu, rinsed and cut into 1-inch cubes	1.0	cup	c	14
253	233	1 cup zucchini, julienned	1.0	cup	c	15
254	0	Brine solution (3- 4 liters water+ 1 ½ cups coarse salt)	3.0	liters	l	0
254	78	3 tablespoons chilly paste (reduce for less spicy)/ korean gochujang paste	3.0	tablespoons	T	1
254	163	1/8 cup fish sauce	0.125	cup	c	2
254	23	1 whole garlic bulb, skinned	1.0	\N	\N	3
254	148	1 small napa cabbage, (abt ½ kg) quartered lengthways with stems attached and washed	1.0	\N	\N	4
254	61	15 grams chilly flakes	15.0	grams	g	5
254	29	150 grams radish, julienned	150.0	grams	g	6
254	188	1/4 bowl cooked rice	0.25	\N	\N	7
254	0	2 tablespoons fermented baby shrimps/ cincalok (you can even use brined fish/anchovies)	2.0	tablespoons	T	8
254	94	40 grams spring onions, cut into abt 2" lengths	40.0	grams	g	9
254	114	1/2 teaspoon sugar	0.5	teaspoon	t	10
255	2	1 medium organic carrot, thinly sliced	1.0	\N	\N	0
255	237	2 organic cucumbers, sliced	2.0	\N	\N	1
255	163	1 tablespoon of fish sauce (can find at grocery store in Asian section)	1.0	tablespoon	T	2
255	23	2 cloves organic garlic, minced	2.0	cloves	cloves	3
255	141	1/2 inch of grated organic ginger	0.5	inch	inch	4
255	17	1 tablespoon of honey	1.0	tablespoon	T	5
255	18	1/2 Juice of a lemon	0.5	\N	\N	6
255	59	cup of red pepper powder (can find at Korean market), plus more to taste	1.0	cup	c	7
255	6	3 tablespoons of salt	3.0	tablespoons	T	8
255	94	3 organic scallions, sliced, include green and white parts	3.0	\N	\N	9
255	28	1 teaspoon of toasted sesame oil	1.0	teaspoon	t	10
256	0	1 ahi tuna steak (approx. less than a 1 lb.)	1.0	\N	\N	0
256	152	5 small leaves of fresh mint	5.0	leaves	leaves	1
256	297	1/2 tablespoon rice vinegar (recommended: O Yuzu Rice Vinegar)	0.5	\N	\N	2
256	139	1 Juice of lime	1.0	\N	\N	3
256	160	1/2 of a Serrano pepper, very thinly sliced	0.5	\N	\N	4
256	28	1 tsp. sesame oil	1.0	tsp	t	5
256	74	5 tbsp. soy sauce	5.0	tbsp	T	6
256	154	3Serve immediately by mounding atop crackers, chips, micro-greens, or even roasted sweet potato slices.	1.0	slicesslices	slicesslices	7
257	241	1 avocado, peeled, pitted and sliced	1.0	\N	\N	0
257	164	2 cups fresh baby spinach	2.0	cups	c	1
257	58	1 tsp black pepper	1.0	tsp	t	2
257	428	6 burrito size tortillas	6.0	\N	\N	3
257	92	1/2 cup fresh cilantro, chopped	0.5	cup	c	4
257	23	2 garlic cloves, pressed	2.0	cloves	cloves	5
257	48	1 tsp ground cumin	1.0	tsp	t	6
257	135	1 jalapeño, seeded and diced	1.0	\N	\N	7
257	138	1 fresh lime, juiced	1.0	\N	\N	8
257	97	1/2 tsp kosher salt	0.5	tsp	t	9
257	138	1 fresh lime, cut into wedges	1.0	\N	\N	10
257	139	1/2 cup fresh lime juice	0.5	cup	c	11
257	72	1 Tbsp Olive oil	1.0	Tbsp	Tbsp	12
257	4	1/2 cup onion, diced	0.5	cup	c	13
257	4	1 small onion, diced	1.0	\N	\N	14
257	41	1/2 tsp paprika	0.5	tsp	t	15
257	47	2 Roma tomatoes, diced	2.0	\N	\N	16
257	453	1 lb sirloin, trimmed and diced (1/2 inch)	1.0	lb	lb	17
258	0	3 Tbs. - Capers Chopped (I left these out)	3.0	Tb	Tb	0
258	92	1 Bunch Cilantro Chopped	1.0	\N	\N	1
258	23	2 garlic cloves, finely minced	2.0	cloves	cloves	2
258	58	1/2 Tsp. - Fresh Ground Black Pepper	0.5	Tsp	Tsp	3
258	72	2 tablespoons olive oil	2.0	tablespoons	T	4
258	43	1 Bunch Parsley Chopped	1.0	\N	\N	5
258	61	1/2 Tsp. - Red Pepper Flakes	0.5	Tsp	Tsp	6
258	100	3 tablespoons red wine vinegar	3.0	tablespoons	T	7
258	6	1 1/2 Tsp. - Salt	1.5	Tsp	Tsp	8
259	251	1 pound green or white asparagus, woody ends snapped off & discarded	1.0	pound	lb	0
259	61	1/2 teaspoon chili pepper flakes	0.5	teaspoon	t	1
259	228	Freshly cracked black pepper	4.0	servings	servings	2
259	43	1 cup flat leaf parsley, lightly packed & rough chopped	1.0	cup	c	3
259	152	1/4 cup fresh mint leaves	0.25	cup	c	4
259	45	1/4 cup fresh oregano leaves	0.25	cup	c	5
259	23	3 to 5 garlic cloves, rough chopped	3.0	cloves	cloves	6
259	23	4 garlic cloves, peeled	4.0	cloves	cloves	7
259	97	Kosher salt	4.0	servings	servings	8
259	18	3 tablespoons lemon juice	3.0	tablespoons	T	9
259	72	1/4 cup of extra-virgin olive oil	0.25	cup	c	10
259	58	1 teaspoon freshly ground pepper	1.0	teaspoon	t	11
259	100	2 tablespoons Red wine vinegar	2.0	tablespoons	T	12
259	261	2 tablespoons shallot, chopped	2.0	tablespoons	T	13
259	504	2 skirt steaks	2.0	\N	\N	14
260	224	1/4 teaspoon baking soda	0.25	teaspoon	t	0
260	6	1/4 teaspoon salt	0.25	teaspoon	t	1
260	114	1 cup sugar	1.0	cup	c	2
260	463	1 vanilla bean, split and seeds scraped	1.0	\N	\N	3
260	20	1 quart whole milk	1.0	quart	quart	4
261	117	150 grams Almond cookies, crumbed	150.0	grams	g	0
261	40	1 tablespoon Cornstarch	1.0	tablespoon	T	1
261	13	450 grams Philiadelphia 13% balance cream cheese	450.0	grams	g	2
261	435	240 ml Dulce de leche	240.0	ml	ml	3
261	14	2 Eggs	2.0	\N	\N	4
261	18	Juice and zest of 1 lemon	1.0	\N	\N	5
261	6	Pinch of salt	1.0	pinch	pinch	6
261	114	1/2 cup organic sugar	0.5	cup	c	7
261	10	1 1/2 sticks cold butter cut into small pieces (if you use unsalted butter add a little 2 cups organic flour1/2 cup organic sugar1 teaspoon vanilla	1.5	sticks	sticks	8
261	39	150 grams 3. 5% yogurt	150.0	grams	g	9
262	15	2 cups organic flour	2.0	cups	c	0
262	114	1/2 cup organic sugar	0.5	cup	c	1
262	173	1 1/2 sticks cold salted butter cut into small pieces	1.5	sticks	sticks	2
262	134	1 teaspoon vanilla	1.0	teaspoon	t	3
263	469	2 tablespoons of amaretto cream (keep cold)	2.0	tablespoons	T	0
263	435	2 tablespoons of dulce de leche, or caramel, or 3 caramel squares	2.0	tablespoons	T	1
263	0	1 tub of vanilla Balkan style yogurt, 650g	1.0	tub	tub	2
264	72	1/2 cup extra-virgin olive oil	0.5	cup	c	0
264	452	1 1/2 pounds flank steak	1.5	pounds	lb	1
264	23	3 cloves garlic, peeled	3.0	cloves	cloves	2
264	45	2 tablespoons oregano	2.0	tablespoons	T	3
264	43	1 bunch parsley	1.0	bunch	bunch	4
264	100	1/4 cup red wine vinegar	0.25	cup	c	5
265	241	1 avocado, diced	1.0	\N	\N	0
265	78	1/4 teaspoon chile-garlic paste	0.25	teaspoon	t	1
265	92	1 Tb. chopped cilantro	1.0	Tb	Tb	2
265	0	3 Swai fillets, diced (about 1 lb.)	1.0	lb	lb	3
265	139	2 limes, juiced	2.0	\N	\N	4
265	72	Olive oil	4.0	servings	servings	5
265	280	Salt and pepper	4.0	servings	servings	6
265	261	1 cup shallot, diced (or ¼ red onion)	1.0	cup	c	7
265	47	1 medium tomato, seeded and finely chopped	1.0	\N	\N	8
266	8	2 teaspoons baking powder	2.0	teaspoons	t	0
266	10	3 teaspoons butter	3.0	teaspoons	t	1
266	12	1 tablespoon Cinnamon	1.0	tablespoon	T	2
266	197	1/2 teaspoon cream of tartar	0.5	teaspoon	t	3
266	14	3 Eggs	3.0	\N	\N	4
266	338	12 ounces can evaporated milk	12.0	ounces	oz	5
266	115	1/2 cup half-and-half	0.5	cup	c	6
266	0	1/2 cup masa harina	0.5	cup	c	7
266	20	1/4 cup milk	0.25	cup	c	8
266	152	mint leaves	10.0	leaves	leaves	9
266	306	Sliced strawberries	10.0	servings	servings	10
266	476	1 teaspoon orange zest	1.0	teaspoon	t	11
266	6	1 teaspoon salt	1.0	teaspoon	t	12
266	379	1/2 cup sorghum flour	0.5	cup	c	13
266	114	1 teaspoon sugar	1.0	teaspoon	t	14
266	337	14 ounces can sweetened condensed milk	14.0	ounces	oz	15
266	134	1 teaspoon vanilla	1.0	teaspoon	t	16
266	134	1 teaspoon vanilla extract	1.0	teaspoon	t	17
266	310	1 cup whipping cream	1.0	cup	c	18
266	0	1 teaspoon xanthan gum	1.0	teaspoon	t	19
267	455	2 pounds beef tenderloin, cut into 1 inch chunks or strips	2.0	pounds	lb	0
267	92	1/4 cup cilantro, freshly chopped for garnishment	0.25	cup	c	1
267	0	1 teaspoon Complete seasoning	1.0	teaspoon	t	2
267	48	1 teaspoon Cumin	1.0	teaspoon	t	3
267	0	1 bag of frozen french fries	1.0	bag	bag	4
267	23	3 garlic cloves, minced	3.0	cloves	cloves	5
267	3	1 green bell pepper, julienned	1.0	\N	\N	6
267	135	1 jalapeno pepper, seeded and chopped finely	1.0	\N	\N	7
267	375	8 inches plum tomatoes, halved and cut into 1 chunks	8.0	inches	inches	8
267	76	1 red bell pepper, julienned	1.0	\N	\N	9
267	100	1 teaspoon red wine vinegar	1.0	teaspoon	t	10
267	74	Soy sauce	4.0	servings	servings	11
267	4	1 yellow onion, chopped finely	1.0	\N	\N	12
268	241	3 ripe avocados	3.0	\N	\N	0
268	3	2 bell peppers	2.0	\N	\N	1
268	373	6 cherry tomatoes	6.0	\N	\N	2
268	92	2 sprigs of cilantro	2.0	sprigs	sprigs	3
268	499	4 tilapia fish fillets (about 650g)	650.0	g	g	4
268	23	2 cloves garlic	2.0	cloves	cloves	5
268	4	1/2 onion	0.5	\N	\N	6
268	58	pepper	2.0	servings	servings	7
268	6	salt	2.0	servings	servings	8
268	133	tabasco sauce	2.0	servings	servings	9
268	430	60g tortilla chips	60.0	g	g	10
269	3	1 large bell pepper, diced	1.0	\N	\N	0
269	35	1 (14 ounce) can black beans, rinsed and drained	14.0	ounce	oz	1
269	67	1 28-ounce can crushed or puréed tomatoes	28.0	ounce	oz	2
269	95	2 teaspoons chili powder	2.0	teaspoons	t	3
269	45	1 teaspoon dried oregano	1.0	teaspoon	t	4
269	143	1 teaspoon garlic powder	1.0	teaspoon	t	5
269	48	1/2 teaspoon ground cumin	0.5	teaspoon	t	6
269	72	1 1/2 tablespoons light or extra-virgin olive oil	1.5	tablespoons	T	7
269	4	1 cup chopped onion	1.0	cup	c	8
269	41	1 teaspoon paprika	1.0	teaspoon	t	9
270	35	1 can black beans, rinsed, drained and mashed	1.0	can	can	0
270	243	2 cups canned corn	2.0	cups	c	1
270	2	1 carrot, peeled and diced	1.0	\N	\N	2
270	250	1/2 cup celery, diced	0.5	cup	c	3
270	456	1 teaspoon Creole seasoning (more or less to taste)	1.0	teaspoon	t	4
270	15	1/2 cup all-purpose flour	0.5	cup	c	5
270	43	1 teaspoon fresh parsley, chopped	1.0	teaspoon	t	6
270	23	1-2 cloves garlic, minced	1.0	cloves	cloves	7
270	23	2 garlic cloves, minced	2.0	cloves	cloves	8
270	94	2 green onions, diced	2.0	\N	\N	9
270	58	1 teaspoon ground red pepper (more or less to taste)	1.0	teaspoon	t	10
270	58	1 teaspoon ground black pepper (more or less to taste)	1.0	teaspoon	t	11
270	135	1/2-1 jalapeño pepper, seeded and diced	0.5	\N	\N	12
270	139	Juice of 1 lime	1.0	\N	\N	13
270	437	1/4 cup oatmeal (I used a bit more)	0.25	cup	c	14
270	4	1 cup chopped onion	1.0	cup	c	15
270	181	1 cup panko breadcrumbs	1.0	cup	c	16
270	76	1/2 cup red pepper, seeded and diced	0.5	cup	c	17
270	269	1 cup salsa	1.0	cup	c	18
270	6	1/2 teaspoon salt	0.5	teaspoon	t	19
270	47	3 medium-sized tomatoes, diced	3.0	\N	\N	20
271	241	4 ripe avocados	4.0	\N	\N	0
271	468	8 black olives, sliced	8.0	\N	\N	1
271	61	1/2 teaspoon red chili pepper flakes	0.5	teaspoon	t	2
271	228	fresh cracked black pepper, to taste	4.0	servings	servings	3
271	237	1 large cucumber, peeled and ciced	1.0	\N	\N	4
271	93	1/4 cup coriander leaves, chopped	0.25	cup	c	5
271	140	1/4 cup grape seed, rice bran or extra light	0.25	cup	c	6
271	94	4 green onions, cut into 1-inch pieces	4.0	\N	\N	7
271	138	1/2 lime	0.5	\N	\N	8
271	336	zest of 2 limes	2.0	\N	\N	9
271	461	3 tablespoons unpasteurized shiro miso	3.0	tablespoons	T	10
271	492	1 Mandarin or Satsuma orange, peeled and segmented	1.0	\N	\N	11
271	52	8 prawns (about 1/2 lb), peeled	0.5	lb	lb	12
271	72	1 1/2 tablespoons extra light olive oil or rice bran oil (for cooking prawns <	1.5	tablespoons	T	13
271	0	12 smalls scallops or 4 large scallops, cleaned	12.0	\N	\N	14
271	261	1 shallot, minced	1.0	\N	\N	15
271	96	unrefined sea salt, taste	4.0	servings	servings	16
271	7	1 cup water	1.0	cup	c	17
272	241	1 Avocado	1.0	\N	\N	0
272	101	1 teaspoon Balsamic vinegar	1.0	teaspoon	t	1
272	48	1 teaspoon Cumin	1.0	teaspoon	t	2
272	242	3/4 cup Corn, freshly hulled (You can also use frozen corn, thawed)	0.75	cup	c	3
272	23	1 clove garlic	1.0	clove	clove	4
272	76	1/2 medium Red Pepper	0.5	\N	\N	5
273	92	1 cup cilantro, finely chopped	1.0	cup	c	0
273	72	extra-virgin olive oil	4.0	servings	servings	1
273	452	1 1 pound flank steak	1.0	pound	lb	2
273	23	3 garlic clove, minced	3.0	clove	clove	3
273	135	1/2 large jalapeno, seeded and minced ( whole 1 if brave)	0.5	\N	\N	4
273	18	1/2 Lemon, juice of	0.5	\N	\N	5
273	139	Juice of large 1/2 lime	0.5	\N	\N	6
273	280	Salt and pepper	4.0	servings	servings	7
273	94	4 scallions, white only finely chopped	4.0	\N	\N	8
273	47	2 medium tomatoes, finely chopped	2.0	\N	\N	9
274	188	Cooked rice	1.0	serving	serving	0
274	23	3 clv garlic, chopped	3.0	\N	\N	1
274	94	3 green onions, sliced	3.0	\N	\N	2
274	17	1 tablespoon (15 ml) honey	15.0	ml	ml	3
274	135	1 jalapeno pepper (seeded), 1/4 inch chunks	1.0	\N	\N	4
274	139	2 tablespoons (30 ml) lime juice	30.0	ml	ml	5
274	262	1 mango (seeded), 1/2 inch chunks	1.0	\N	\N	6
274	113	1 fresh pineapple, 1/2 inch chunks	1.0	\N	\N	7
274	76	1 sweet red pepper, 1/4 inch chunks	1.0	\N	\N	8
274	354	4 boneless, skinless chicken breasts	4.0	\N	\N	9
275	241	1 ripe avocado, pitted and scooped from skin	1.0	\N	\N	0
275	500	2 pounds white flaky fish (halibut, cod, etc.)	2.0	pounds	lb	1
275	428	8 soft taco flour tortillas	8.0	\N	\N	2
275	92	2 tablespoons fresh cilantro, minced	2.0	tablespoons	T	3
275	161	1/4 cup nonfat Greek yogurt	0.25	cup	c	4
275	135	1 small jalapeno, seeded and finely minced (use more or less based on personal preference)	1.0	\N	\N	5
275	156	1 cup shredded lettuce	1.0	cup	c	6
275	139	1 tablespoon fresh lime juice	1.0	tablespoon	T	7
275	336	1 tablespoon lime zest	1.0	tablespoon	T	8
275	72	2 tablespoons olive oil	2.0	tablespoons	T	9
275	4	2 tablespoons onion, finely diced	2.0	tablespoons	T	10
275	280	Salt and pepper, to taste	4.0	servings	servings	11
275	0	1 tablespoon clear tequila	1.0	tablespoon	T	12
275	47	3 tomatoes seeded, diced fine	3.0	\N	\N	13
276	474	1/2 cup Anaheim peppers, seeded, diced	0.5	cup	c	0
276	473	1 1/2 cups cherries, pitted, diced	1.5	cups	c	1
276	87	2 tablespoons chopped fresh basil	2.0	tablespoons	T	2
276	152	1 teaspoon fresh mint, chiffonade	1.0	teaspoon	t	3
276	23	1 clove garlic, minced	1.0	clove	clove	4
276	138	1 lime, zested and juiced (keep zest and juice)	1.0	\N	\N	5
276	262	1 mango, diced	1.0	\N	\N	6
276	72	2 small 1 tablespoones olive oil	2.0	tablespoon	T	7
276	475	1 peach, peeled and diced	1.0	\N	\N	8
276	113	1 cup fresh pineapple, diced	1.0	cup	c	9
276	391	12 ounces salmon fillet	12.0	ounces	oz	10
276	280	salt and pepper to taste	2.0	servings	servings	11
276	261	2 teaspoons minced shallot	2.0	teaspoons	t	12
277	92	1/4 cup chopped cilantro	0.25	cup	c	0
277	4	1/4 cup finely-chopped red onion	0.25	cup	c	1
277	262	2 cups finely-diced ripe mango	2.0	cups	c	2
277	139	juice of half a lime	4.0	\N	\N	3
277	113	1 cup finely-chopped fresh pineapple	1.0	cup	c	4
277	391	2 pounds skin-on salmon fillet cut in 4 pieces	2.0	pounds	lb	5
277	6	Salt	4.0	servings	servings	6
278	241	2 ripe avocados	2.0	\N	\N	0
278	58	black pepper	2.0	servings	servings	1
278	0	1 can pinto beans	1.0	can	can	2
278	275	2 cups chicken stock	2.0	cups	c	3
278	92	1 bunch cilantro	1.0	bunch	bunch	4
278	429	12 10-inch corn tortillas	12.0	10-inch	10-inch	5
278	23	4 cloves garlic	4.0	cloves	cloves	6
278	48	ground cumin	2.0	servings	servings	7
278	135	1 small jalapeno	1.0	\N	\N	8
278	138	1 lime	1.0	\N	\N	9
278	334	shredded monterey jack cheese	2.0	servings	servings	10
278	192	1 navel orange	1.0	\N	\N	11
278	71	oil for frying	2.0	servings	servings	12
278	396	2 lbs boneless pork shoulder	2.0	lbs	lb	13
278	4	2 cups red onion	2.0	cups	c	14
278	96	sea salt	2.0	servings	servings	15
278	126	sour cream	2.0	servings	servings	16
278	47	some fresh tomatoes	2.0	servings	servings	17
278	98	1 dash white vinegar	1.0	dash	dash	18
279	3	20 mini bell peppers (you can buy in a large bag)	20.0	\N	\N	0
279	35	7 oz canned black beans ( about 1/2 a can)	7.0	oz	oz	1
279	95	1 TBSP Chili Powder	1.0	TBSP	TBSP	2
279	118	3 oz chipotles in adobo ( about 1/2 a can)	3.0	oz	oz	3
279	67	7 oz canned fire roasted tomatoes ( about 1/2 a can)	7.0	oz	oz	4
279	23	1 tablespoon minced garlic	1.0	tablespoon	T	5
279	119	4 oz can green chilies	4.0	oz	oz	6
279	223	1 TSP Ground Coriander	1.0	\N	\N	7
279	48	1 TBSP Ground Cumin	1.0	TBSP	TBSP	8
279	260	10 oz lean ground turkey	10.0	oz	oz	9
279	41	1 TBSP Paprika	1.0	TBSP	TBSP	10
279	485	3 tomatillos	3.0	\N	\N	11
279	4	1/2 yellow onion	0.5	\N	\N	12
280	10	2 tablespoons of Butter	2.0	tablespoons	T	0
280	168	1 1/2 cups grated cheese	1.5	cups	c	1
280	119	4 Oz. Can of Green Chiles	4.0	oz	oz	2
280	95	1/2 teaspoon Chili Powder	0.5	teaspoon	t	3
280	92	1 bunch Small of Cilantro	1.0	bunch	bunch	4
280	48	1/2 teaspoon of Cumin	0.5	teaspoon	t	5
280	15	3 tablespoons of Flour	3.0	tablespoons	T	6
280	20	1 cup of Milk	1.0	cup	c	7
280	269	1 cup salsa	1.0	cup	c	8
280	430	2 cups Tortilla Chips	2.0	cups	c	9
281	241	1 avocado, cubed	1.0	\N	\N	0
281	35	15 oz can of black beans, rinsed and drained	15.0	oz	oz	1
281	428	4 large flour tortillas	4.0	\N	\N	2
281	262	1 small mango, cubed	1.0	\N	\N	3
281	72	1 teaspoon olive oil	1.0	teaspoon	t	4
281	4	1 1/2 cups of onion, diced	1.5	cups	c	5
281	45	1 teaspoon oregano	1.0	teaspoon	t	6
281	167	1 poblano (aka pasilla) pepper, seeded and chopped	1.0	\N	\N	7
281	280	salt and pepper to taste	2.0	servings	servings	8
281	332	1/2 cup sharp cheddar cheese	0.5	cup	c	9
282	99	1/4 cup apple cider vinegar	0.25	cup	c	0
282	2	1 carrot, grated	1.0	\N	\N	1
282	118	1/2 can chipotle chilies in adobo sauce (3-4 peppers chopped)	0.5	can	can	2
282	23	2 Cloves garlic, minced	2.0	Cloves	Cloves	3
282	161	1 cup Greek yogurt	1.0	cup	c	4
282	139	Juice of 1 lime	1.0	\N	\N	5
282	55	2 cups chopped mushrooms	2.0	cups	c	6
282	72	3 tablespoons olive oil	3.0	tablespoons	T	7
282	4	1 green onion stalk	1.0	\N	\N	8
282	396	1 5-lb pork shoulder roast	5.0	lb	lb	9
282	149	1 head purple cabbage	1.0	head	head	10
282	319	1/2 cup red wine	0.5	cup	c	11
282	6	2 tablespoons salt	2.0	tablespoons	T	12
282	280	Salt pepper to taste	12.0	servings	servings	13
282	105	1 cup vegetable broth	1.0	cup	c	14
282	4	1 yellow onion	1.0	\N	\N	15
283	0	2 teaspoons dried ancho chili powder	2.0	teaspoons	t	0
283	58	Freshly-ground black pepper to taste	4.0	servings	servings	1
283	122	Pinch of Cayenne pepper	1.0	pinch	pinch	2
283	92	1 tablespoon cilantro, chopped fine	1.0	tablespoon	T	3
283	141	1/2 tablespoon fresh ginger, minced	0.5	tablespoon	T	4
283	23	1 clove garlic, minced	1.0	clove	clove	5
283	143	1 teaspoon garlic powder	1.0	teaspoon	t	6
283	48	1 teaspoon ground cumin	1.0	teaspoon	t	7
283	135	1/2 jalapeno, minced	0.5	\N	\N	8
283	139	Juice of 1 lime	1.0	\N	\N	9
283	264	2 kiwis, peeled and and diced	2.0	\N	\N	10
283	97	1/2 teaspoon Kosher salt	0.5	teaspoon	t	11
283	262	2 Mangos, peeled and diced	2.0	\N	\N	12
283	72	2 tablespoons olive oil	2.0	tablespoons	T	13
283	402	1 3 pound Pork Tenderloin	3.0	pound	lb	14
283	4	1 red onion – sliced	1.0	\N	\N	15
283	6	Salt to taste	4.0	servings	servings	16
283	280	salt and pepper to taste	4.0	servings	servings	17
283	485	2 cups tomatillos, diced	2.0	cups	c	18
284	241	2 avocados, sliced	2.0	\N	\N	0
284	35	1 can black beans, rinsed and drained	1.0	can	can	1
284	242	1 1/2 cup corn	1.5	cup	c	2
284	143	2 tsp garlic powder	2.0	tsp	t	3
284	139	juice of 1 lime	1.0	\N	\N	4
284	72	1 tbsp olive oil	1.0	tbsp	T	5
284	4	1 small onion, diced	1.0	\N	\N	6
284	76	2 red bell peppers, diced	2.0	\N	\N	7
284	280	salt & pepper	4.0	servings	servings	8
284	332	1 lb sharp cheddar, grated	1.0	lb	lb	9
284	428	4 tortilla wraps	4.0	\N	\N	10
285	67	1 can (28oz) whole tomatoes with juice	28.0	oz	oz	0
285	92	1/2 cup fresh cilantro (large stems removed)	0.5	cup	c	1
285	23	1 clove garlic, minced	1.0	clove	clove	2
285	48	1/4 - 1/2 t. ground cumin	0.25	t	t	3
285	135	1 whole jalapeno, quartered, seeds removed, sliced thin.	1.0	\N	\N	4
285	139	juice from 1/2 a lime	2.0	\N	\N	5
285	4	1/4 of an onion chopped (approximately 1/4 cup)	0.25	\N	\N	6
285	6	Salt to taste	4.0	servings	servings	7
285	0	1/4 t. Penzey's Southwest seasoning (or another brand)	0.25	t	t	8
285	114	1/4 t. sugar	0.25	t	t	9
285	47	2 cans (10oz) Rotel tomatoes (or the store brand of diced tomatoes and green chilies)	10.0	oz	oz	10
286	3	1 whole Bell Pepper	1.0	\N	\N	0
286	58	black pepper	4.0	servings	servings	1
286	35	1 can 14.5-oz. Black Beans	1.0	can	can	2
286	2	1 whole Carrot	1.0	\N	\N	3
286	95	1 Tablespoon Chili Powder	1.0	Tablespoon	Tablespoon	4
286	95	1 teaspoon Chili Powder	1.0	teaspoon	t	5
286	242	8 Tablespoons Corn	8.0	Tablespoons	Tablespoons	6
286	428	4 whole Flour Burrito Tortillas	4.0	\N	\N	7
286	143	1 Tablespoon Garlic Powder	1.0	Tablespoon	Tablespoon	8
286	0	8 Tablespoons Guacamole	8.0	Tablespoons	Tablespoons	9
286	72	2 Tablespoons Olive Oil	2.0	Tablespoons	Tablespoons	10
286	4	1/2 whole Onion	0.5	\N	\N	11
286	166	1 Tablespoon Onion Powder	1.0	Tablespoon	Tablespoon	12
286	166	1 teaspoon Onion Powder	1.0	teaspoon	t	13
286	167	1 whole Pasilla Chile	1.0	\N	\N	14
286	269	4 Tablespoons Your Favorite Salsa	4.0	Tablespoons	Tablespoons	15
286	168	1/2 cups Shredded Cheddar Cheese, Divided	0.5	cups	c	16
286	126	4 Tablespoons Light Sour Cream	4.0	Tablespoons	Tablespoons	17
286	233	2 whole Zucchini	2.0	\N	\N	18
287	337	2 cups of condensed milk	2.0	cups	c	0
287	14	6 eggs	6.0	\N	\N	1
287	138	3 limes	3.0	\N	\N	2
287	114	3/4 cup sugar	0.75	cup	c	3
287	463	1 vanilla pod, sliced in half lengthwise	1.0	\N	\N	4
287	7	3 tablespoons water	3.0	tablespoons	T	5
287	20	2 cups whole milk	2.0	cups	c	6
288	8	1 teaspoon of Baking Powder	1.0	teaspoon	t	0
288	105	5 1/4 cups of Veggie Broth	5.25	cups	c	1
288	10	1 stick of Butter	1.0	stick	stick	2
288	95	2 teaspoons of Chili Powder	2.0	teaspoons	t	3
288	92	1 bunch Large of Chopped Cilantro	1.0	bunch	bunch	4
288	495	1 package of Corn Husks	1.0	package	pkg	5
288	48	2 teaspoons of Cumin	2.0	teaspoons	t	6
288	23	1 clove Garlic minced	1.0	clove	clove	7
288	94	3 Green Onions, Chopped	3.0	\N	\N	8
288	139	1/2 of a Lime, Juiced	0.5	\N	\N	9
288	220	2 cups of Masa	2.0	cups	c	10
288	71	Oil for deep frying	1.0	serving	serving	11
288	47	2 Roma Tomatoes, Chopped	2.0	\N	\N	12
288	6	Salt	1.0	serving	serving	13
288	168	1/2 cup of Shredded Cheddar Cheese	0.5	cup	c	14
288	233	1 Zucchini, Chopped	1.0	\N	\N	15
289	373	a handful of cherry tomatoes	1.0	handful	handful	0
289	3	1/2 green bell pepper	0.5	\N	\N	1
289	139	1 tablespoon of lime juice	1.0	tablespoon	T	2
289	262	2 Large Mangoes	2.0	\N	\N	3
289	152	A few scent leaves or mint leaves	3.0	leaves	leaves	4
289	76	1/2 red bell pepper	0.5	\N	\N	5
289	4	2 handfuls of chopped red onions	2.0	handfuls	handfuls	6
289	114	A pinch of sugar	1.0	pinch	pinch	7
290	209	2 cups Bulgur wheat	2.0	cups	c	0
290	344	11 ounces Chavrie® Goat Log	11.0	ounces	oz	1
290	18	1 ounce Lemon juice	1.0	ounce	oz	2
290	152	1 teaspoon Chopped mint	1.0	teaspoon	t	3
290	72	Olive oil	10.0	servings	servings	4
290	43	1/2 cup parsley, chopped	0.5	cup	c	5
290	4	1 cup Red onion (minced)	1.0	cup	c	6
290	280	Salt and Pepper to taste	10.0	servings	servings	7
290	47	1 ea. Tomato diced	1.0	\N	\N	8
290	7	8 ounces water	8.0	ounces	oz	9
291	2	8 small carrots	8.0	\N	\N	0
291	373	16 cherry tomatoes, halved	16.0	\N	\N	1
291	48	1 tbsp cumin	1.0	tbsp	T	2
291	216	2 tbsp fresh dill	2.0	tbsp	T	3
291	23	4 cloves garlic, minced	4.0	cloves	cloves	4
291	143	1 tbsp garlic powder	1.0	tbsp	T	5
291	161	1/2 cup greek yogurt	0.5	cup	c	6
291	58	1 tbsp ground pepper	1.0	tbsp	T	7
291	300	1/2 cup hummus	0.5	cup	c	8
291	18	juice of 1 lemon	1.0	\N	\N	9
291	174	1 cup long grain rice	1.0	cup	c	10
291	273	2 cups low sodium chicken broth	2.0	cups	c	11
291	72	1/2 tbsp olive oil	0.5	tbsp	T	12
291	72	1 tbsp olive oil	1.0	tbsp	T	13
291	4	1/2 onion, minced	0.5	\N	\N	14
291	166	1 tbsp onion powder	1.0	tbsp	T	15
291	43	1/2 cup parsley, roughly chopped	0.5	cup	c	16
291	58	1 tbsp pepper	1.0	tbsp	T	17
291	208	pita	4.0	servings	servings	18
291	6	1 tbsp salt	1.0	tbsp	T	19
291	354	3 boneless skinless chicken breasts	3.0	\N	\N	20
291	162	2 tbsp turmeric	2.0	tbsp	T	21
291	162	1 tsp turmeric powder	1.0	tsp	t	22
292	241	1/2 avocado, diced	0.5	\N	\N	0
292	122	1 teaspoon cayenne pepper	1.0	teaspoon	t	1
292	48	1/2 teaspoon cumin	0.5	teaspoon	t	2
292	237	1/2 cup English cucumber, diced	0.5	cup	c	3
292	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	4
292	94	5 green onions, chopped	5.0	\N	\N	5
292	43	1/2 cup parsley, chopped	0.5	cup	c	6
292	358	1 cup red quinoa	1.0	cup	c	7
292	29	5 red radishes, diced	5.0	\N	\N	8
292	100	3 1/2 tablespoons red wine vinegar	3.5	tablespoons	T	9
292	6	2 teaspoons salt	2.0	teaspoons	t	10
292	47	1/2 tomato	0.5	\N	\N	11
292	162	1 teaspoon turmeric	1.0	teaspoon	t	12
292	7	1 cup water	1.0	cup	c	13
292	82	1/2 cup yellow pepper,diced	0.5	cup	c	14
293	209	1/2 cup bulgur	0.5	cup	c	0
293	237	2 smalls cucumbers	2.0	\N	\N	1
293	43	1 bunch of flat leaf parsley	1.0	bunch	bunch	2
293	18	1/2 lemon juice from a lemon	0.5	\N	\N	3
293	72	3 tablespoons of olive oil	3.0	tablespoons	T	4
293	6	Salt	1.0	serving	serving	5
293	47	2 medium sized tomatoes	2.0	\N	\N	6
294	37	540 ml can of chickpeas, drained and rinsed	540.0	ml	ml	0
294	237	8 slices of cucumber	8.0	slices	slices	1
294	43	1 large handful parsley, chopped	1.0	handful	handful	2
294	23	2 cloves garlic, grated or finely chopped	2.0	cloves	cloves	3
294	501	4 hamburger buns (I used President's Choice multi-grain thins)	4.0	\N	\N	4
294	254	4 tbsp peanut oil	4.0	tbsp	T	5
294	4	1 small red onion, chopped	1.0	\N	\N	6
294	32	1/2 tsp sriracha sauce	0.5	tsp	t	7
294	301	2 tsp tahini	2.0	tsp	t	8
294	47	8 slices of tomato	8.0	slices	slices	9
294	471	Tzatziki for topping	4.0	servings	servings	10
295	37	2 cans garbanzo beans (chickpeas), drained and rinsed	2.0	cans	cans	0
295	95	1 tablespoon chili powder	1.0	tablespoon	T	1
295	223	1 tablespoon coriander	1.0	tablespoon	T	2
295	48	1 tablespoon cumin	1.0	tablespoon	T	3
295	15	4 tablespoons flour	4.0	tablespoons	T	4
295	43	1 large handful parsley, chopped	1.0	handful	handful	5
295	23	2 cloves garlic, grated or finely chopped	2.0	cloves	cloves	6
295	18	2 Zest and juice of lemons	2.0	\N	\N	7
295	208	4 pita pockets	4.0	\N	\N	8
295	4	1 small red onion, chopped	1.0	\N	\N	9
295	280	Salt and pepper, to taste	4.0	servings	servings	10
295	301	1/2 cup tahini	0.5	cup	c	11
295	162	1 1/2 teaspoons turmeric	1.5	teaspoons	t	12
295	71	1/4 cup vegetable oil	0.25	cup	c	13
295	7	3 tablespoons water	3.0	tablespoons	T	14
296	15	2 tablespoons all purpose flour	2.0	tablespoons	T	0
296	8	1 teaspoon baking powder	1.0	teaspoon	t	1
296	1	1 cup raw black eyed beans	1.0	cup	c	2
296	92	2 tablespoons coriander leaves/cilantro - chopped	2.0	tablespoons	T	3
296	223	2 teaspoons coriander powder	2.0	teaspoons	t	4
296	49	2 teaspoons cumin seeds	2.0	teaspoons	t	5
296	36	1 cup raw garbanzo beans/ chickpeas	1.0	cup	c	6
296	23	4 garlic cloves - chopped	4.0	cloves	cloves	7
296	4	1/2 cup onions - finely chopped	0.5	cup	c	8
296	43	1 tablespoon parsley - chopped	1.0	tablespoon	T	9
296	58	pepper	12.0	servings	servings	10
296	6	Salt	12.0	servings	servings	11
296	71	1 cup vegetable oil, for frying	1.0	cup	c	12
297	237	1 1/2 cups cucumber	1.5	cups	c	0
297	48	1 teaspoon cumin	1.0	teaspoon	t	1
297	330	3/4 cup crumbled feta cheese	0.75	cup	c	2
297	152	1/2 cup fresh chopped mint	0.5	cup	c	3
297	94	3/4 cup green onions, chopped	0.75	cup	c	4
297	466	1 cup kalamata olives	1.0	cup	c	5
297	145	1 lemon	1.0	\N	\N	6
297	72	1/4 cup olive oil	0.25	cup	c	7
297	43	1/4 cup chopped parsley	0.25	cup	c	8
297	208	3 pita breads	3.0	\N	\N	9
297	76	2 red bell peppers	2.0	\N	\N	10
297	280	Salt and Pepper	6.0	servings	servings	11
297	47	1 large tomato, chopped	1.0	\N	\N	12
297	233	4 Zucchini	4.0	\N	\N	13
298	276	2 cups water or lamb/beef stock	2.0	cups	c	0
298	14	2 Eggs	2.0	\N	\N	1
298	43	3 tablespoons minced fresh parsley	3.0	tablespoons	T	2
298	23	2 garlic cloves, minced	2.0	cloves	cloves	3
298	42	1 kilo lean ground beef or lamb	1.0	\N	\N	4
298	48	1 tablespoon ground cumin	1.0	tablespoon	T	5
298	4	1 small Onion, chopped finely	1.0	\N	\N	6
298	41	1 teaspoon paprika	1.0	teaspoon	t	7
298	3	2 mediums green peppers, seeded and cut diagonally into slices	2.0	slices	slices	8
298	280	salt and pepper	6.0	servings	servings	9
298	70	1 tablespoon tomato paste	1.0	tablespoon	T	10
298	47	3 large tomatoes, diced	3.0	\N	\N	11
298	10	2 tablespoons unsalted butter	2.0	tablespoons	T	12
298	72	1/4 cup virgin olive oil	0.25	cup	c	13
299	0	6 loaves Arabic Flat Bread	6.0	\N	\N	0
299	406	2 Kilos LARGE CUT UP PEACES OF LAMB (WITH BONES) or Lamb Shanks	2.0	\N	\N	1
299	7	2 Liters WATER TO BOIL MEAT	2.0	liters	l	2
299	4	2 Larges ONION	2.0	\N	\N	3
299	0	1/2 cup FRIED PINE NUTS	0.5	cup	c	4
299	174	3 cups RICE ( Short grain or any of your choice)	3.0	cups	c	5
299	10	1 1/2 cups BUTTER	1.5	cups	c	6
299	39	1 Kilo CONTAINER PLAIN whole milk YOGURT (Or you can just use JAMEED)	1.0	kilogram	kg	7
299	6	Salt	6.0	serving	serving	8
299	48	1 teaspoon Cumin, Turmeric, and any other spices if desired for	1.0	teaspoon	tsp	9
299	451	1/2 cup SLIVERED ALMONDS	0.5	cup	c	10
300	305	3 tablespoons agave nectar	3.0	tablespoons	T	0
300	12	1/2 teaspoon cinnamon	0.5	teaspoon	t	1
300	336	1/4 teaspoon lime zest	0.25	teaspoon	t	2
300	445	1/4 of a package of phyllo dough	0.25	\N	\N	3
300	114	cup sugar	1.0	cup	c	4
300	134	1/2 teaspoon vanilla extract	0.5	teaspoon	t	5
300	381	5 oz chopped walnuts	5.0	oz	oz	6
300	7	cup water	1.0	cup	c	7
301	67	1 400 gram can peeled tomatoes, (chopped)	400.0	gram	g	0
301	80	1 tablespoon curry powder, (1 to 2)	1.0	tablespoon	T	1
301	14	1 egg, lightly beaten	1.0	\N	\N	2
301	182	1 cup fresh breadcrumbs	1.0	cup	c	3
301	185	2 teaspoons garam masala	2.0	teaspoons	t	4
301	23	5 cloves garlic	5.0	cloves	cloves	5
301	141	1 teaspoon ginger	1.0	teaspoon	t	6
301	289	500 grams trim lamb mince	500.0	grams	g	7
301	71	1 tablespoon oil	1.0	tablespoon	T	8
302	37	16 oz can chickpeas, drained and rinsed	16.0	oz	oz	0
302	237	1/2 cucumber, halved and sliced	0.5	\N	\N	1
302	330	1/2 cup feta cheese, crumbled	0.5	cup	c	2
302	43	2 tablespoons fresh parsley	2.0	tablespoons	T	3
302	23	1 garlic clove, minced	1.0	clove	clove	4
302	23	4 garlic cloves, minced	4.0	cloves	cloves	5
302	93	1 teaspoon ground coriander	1.0	teaspoon	t	6
302	48	1 tablespoon ground cumin	1.0	tablespoon	T	7
302	18	juice from 2 lemons	2.0	\N	\N	8
302	41	1/2 teaspoon paprika	0.5	teaspoon	t	9
302	208	4 pitas	4.0	\N	\N	10
302	4	1/2 red onion, finely sliced	0.5	\N	\N	11
302	157	1 cup green leaf or romaine lettuce, shredded	1.0	cup	c	12
302	301	1 tablespoon of tahini	1.0	tablespoon	T	13
302	47	1 tomato, diced	1.0	\N	\N	14
302	471	1/4 cup tzatziki (optional)	0.25	cup	c	15
302	209	2 tablespoons cooked bulgar wheat	2.0	tablespoons	T	16
302	110	2 tablespoons whole wheat flour	2.0	tablespoons	T	17
302	4	1/2 yellow onion, chopped	0.5	\N	\N	18
302	0	1/2 cup tabouleh	0.5	cup	c	19
303	209	3 tablespoons cooked bulgur wheat	3.0	tablespoons	T	0
303	43	3 cups flat leaf parsley, about one bushel	3.0	cups	c	1
303	152	1 tablespoon fresh mint	1.0	tablespoon	T	2
303	94	3 tablespoons green onions, finely chopped	3.0	tablespoons	T	3
303	18	1 Juice from lemon	1.0	\N	\N	4
303	72	2 tablespoons olive oil	2.0	tablespoons	T	5
303	47	1/4 cup roma tomatoes, finely chopped	0.25	cup	c	6
304	353	6 chicken cutlets/4 chicken breasts	6.0	\N	\N	0
304	237	2 pickle cucumbers halved and cut into half moons	2.0	\N	\N	1
304	72	extra light olive oil	2.0	servings	servings	2
304	3	1 green pepper cut into strips	1.0	\N	\N	3
304	145	1/2 lemon	0.5	\N	\N	4
304	152	chopped mint	2.0	servings	servings	5
304	4	1/2 small onion thinly sliced	0.5	\N	\N	6
304	43	chopped parsley	2.0	servings	servings	7
304	208	3 whole-wheat pitas	3.0	\N	\N	8
304	375	2 plum tomatoes cut into strips	2.0	\N	\N	9
304	29	1 bunch of radishes sliced	1.0	bunch	bunch	10
304	280	Salt and pepper to taste	2.0	servings	servings	11
304	0	if you have sumac, add a bit to the dressing	2.0	servings	servings	12
305	42	600g minced beef	600.0	g	g	0
305	325	1 tsp ground caraway seeds	1.0	tsp	t	1
305	275	400ml chicken stock	400.0	ml	ml	2
305	77	10-12 dried red chili peppers	10.0	\N	\N	3
305	12	1/2 teaspoon Cinnamon	0.5	teaspoon	t	4
305	48	1/2 tsp cumin	0.5	tsp	t	5
305	92	Coriander leaves, half chopped, half whole or	8.0	servings	servings	6
305	14	1 egg	1.0	\N	\N	7
305	23	1 teaspoon Minced garlic	1.0	teaspoon	t	8
305	290	1 tsp ground cloves	1.0	tsp	t	9
305	223	1 tsp ground coriander	1.0	tsp	t	10
305	48	1 tsp ground cumin	1.0	tsp	t	11
305	159	2 tbs harissa*	2.0	tbs	tbs	12
305	72	1/4 cup olive oil (or vegetable oil)	0.25	cup	c	13
305	4	1 onion, finely chopped	1.0	\N	\N	14
305	59	1 red chili, finely chopped	1.0	\N	\N	15
305	6	1 teaspoon Salt	1.0	teaspoon	t	16
305	464	250g good quality sausage, chopped	250.0	g	g	17
305	96	1/2 tsp sea salt	0.5	tsp	t	18
305	47	480g chopped tomato	480.0	g	g	19
306	228	Freshly cracked black pepper, to taste	8.0	servings	servings	0
306	237	1/2 large cucumber, diced	0.5	\N	\N	1
306	152	2 tablespoons Fresh mint	2.0	tablespoons	T	2
306	43	1/2 cup chopped fresh parsley	0.5	cup	c	3
306	143	1 teaspoon garlic powder	1.0	teaspoon	t	4
306	94	2 green onions	2.0	\N	\N	5
306	18	1/2 cup lemon juice	0.5	cup	c	6
306	72	3 tablespoons olive oil	3.0	tablespoons	T	7
306	358	1 cup Quinoa	1.0	cup	c	8
306	47	1 tomato, diced	1.0	\N	\N	9
306	7	2 cups water	2.0	cups	c	10
307	92	1 tsp Coriander	1.0	tsp	t	0
307	48	1 tsp Cumin	1.0	tsp	t	1
307	216	2 tsp Dill, Finely Chopped	2.0	tsp	t	2
307	14	1 egg	1.0	\N	\N	3
307	23	3 cloves garlic, minced	3.0	cloves	cloves	4
307	0	1/2 cup nonfat greek yogurt	0.5	cup	c	5
307	260	2 lbs ground turkey	2.0	lbs	lb	6
307	300	1/4 cup hummus	0.25	cup	c	7
307	18	1/2 lemon, juiced	0.5	\N	\N	8
307	72	2 tbsp Olive OIl	2.0	tbsp	T	9
307	43	1/4 cup parsley, chopped	0.25	cup	c	10
307	58	2 tsp Pepper	2.0	tsp	t	11
307	219	4 whole-wheat pitas	4.0	\N	\N	12
307	4	1/4 Red Onion, thinly sliced	0.25	\N	\N	13
307	6	1 tsp Salt	1.0	tsp	t	14
307	47	1 tomato, cut into 1/4 inch slices, then halved	1.0	\N	\N	15
307	162	1 tsp Turmeric	1.0	tsp	t	16
307	4	1/2 yellow onion, finely chopped	0.5	\N	\N	17
308	305	1 teaspoon agave nectar	1.0	teaspoon	t	0
308	330	1/4 cup feta cheese (optional)	0.25	cup	c	1
308	43	1/2 cup flat leaf parsley leaves (or a mix of parsley and mint)	0.5	cup	c	2
308	23	2 cloves garlic, minced	2.0	cloves	cloves	3
308	97	1 teaspoon kosher salt	1.0	teaspoon	t	4
308	265	4 fresh Lacinato kale leaves	4.0	\N	\N	5
308	18	2 tablespoons lemon juice	2.0	tablespoons	T	6
308	65	11/2 cups cooked lentils (many markets carry vacuum-packed, precooked lentils, or boil 1 cup dried brown lentils in 2 cups salted water until tender, then drain)	1.5	cups	c	7
308	72	3 tablespoons olive oil	3.0	tablespoons	T	8
308	4	1 small onion, coarsely chopped	1.0	\N	\N	9
308	43	1 tablespoon minced parsley	1.0	tablespoon	T	10
308	237	1 large organic English or Persian cucumber with skin (about 1 cup shredded)	1.0	\N	\N	11
308	208	2 large pita breads	2.0	\N	\N	12
308	29	1 small bunch red radishes or other varietals such as watermelon or daikon (about 1/2 cup, shredded)	1.0	bunch	bunch	13
308	280	Salt and freshly ground black pepper to taste	6.0	servings	servings	14
308	150	1 small head savoy cabbage (about 2 heaping cups, shredded)	1.0	head	head	15
308	0	1 tablespoon za'atar	1.0	tablespoon	T	16
308	0	1/2 teaspoon ground sumac	0.5	teaspoon	t	17
309	10	1 1/2 cups melted butter	1.5	cups	c	0
309	311	1 cup heavy cream or light cream	1.0	cup	c	1
309	18	1 tsp lemon juice	1.0	tsp	t	2
309	445	1 1/2 pkgs. phyllo pastry dough	1.5	pkgs	pkgs	3
309	381	1 cup (1/2 lb.) walnuts or pistachios or combination	0.5	lb	lb	4
309	114	1 Tbsp sugar	1.0	Tbsp	Tbsp	5
309	7	2 cups water	2.0	cups	c	6
310	164	2 packages organic baby spinach	2.0	packages	packages	0
310	10	4 tablespoons butter	4.0	tablespoons	T	1
310	87	12 large fresh basil leaves	12.0	\N	\N	2
310	23	1 clove garlic	1.0	clove	clove	3
310	0	1 tablespoon Herbs de Provence	1.0	tablespoon	T	4
310	18	1/2 Juice of lemon	0.5	\N	\N	5
310	172	1 cup grated mozzarella cheese	1.0	cup	c	6
310	72	1 tablespoon olive oil	1.0	tablespoon	T	7
310	166	1 teaspoon onion powder	1.0	teaspoon	t	8
310	0	cups quick cooking grits (NOT instant)	1.0	cups	c	9
310	6	Salt	4.0	servings	servings	10
310	52	1 pound shrimp	1.0	pound	lb	11
310	215	2 sun dried tomatoes packed in olive oil	2.0	\N	\N	12
310	123	1 sweet onion finely chopped	1.0	\N	\N	13
310	7	cups boiling water	1.0	cups	c	14
311	470	1 teaspoon Almond extract	1.0	teaspoon	t	0
311	8	1/4 teaspoon Baking powder	0.25	teaspoon	t	1
311	224	1/2 teaspoon Baking soda	0.5	teaspoon	t	2
311	10	1 cup Butter or margarine, softened	1.0	cup	c	3
311	15	1 3/4 cups All-purpose flour	1.75	cups	c	4
311	6	1/4 teaspoon Salt	0.25	teaspoon	t	5
311	451	1/2 cup Slivered almonds	0.5	cup	c	6
311	114	1 cup Sugar	1.0	cup	c	7
312	470	1 teaspoon Almond extract	1.0	teaspoon	t	0
312	229	1/2 cup Confectioners sugar	0.5	cup	c	1
312	14	1 Egg, beaten	1.0	\N	\N	2
312	15	1 1/2 cups Unsifted flour	1.5	cups	c	3
312	226	3/4 cup Cold margarine, or butter	0.75	cup	c	4
312	351	6 Milk chocolate covered 1 cup Slivered almonds	6.0	\N	\N	5
312	337	14 ounces Sweetened condensed milk	14.0	ounces	oz	6
313	514	1 bunch each of the following: Collard Greens, Kale, Mustard Greens <	1.0	bunch	bunch	0
313	72	2 tablespoons of olive oil	2.0	tablespoons	T	1
313	4	1 finely diced onion	1.0	\N	\N	2
313	61	1 teaspoon of red pepper flakes (or to your taste)	1.0	teaspoon	t	3
313	507	1 teaspoon of seasoned salt (or to your taste)	1.0	teaspoon	t	4
313	7	1 cup of water	1.0	cup	c	5
314	348	1/4 cup buttermilk	0.25	cup	c	0
314	69	2 heads of cauliflower	2.0	heads	heads	1
314	122	1/2 teaspoon cayenne pepper	0.5	teaspoon	t	2
314	283	3 tablespoons Dijon mustard	3.0	tablespoons	T	3
314	284	1 1/2 teaspoons dry mustard	1.5	teaspoons	t	4
314	15	3 tablespoons Flour	3.0	tablespoons	T	5
314	23	2 garlic cloves, pressed	2.0	cloves	cloves	6
314	18	2 tablespoons fresh lemon juice	2.0	tablespoons	T	7
314	146	2 teaspoons lemon peel	2.0	teaspoons	t	8
314	127	1/4 cup low-fat sour cream	0.25	cup	c	9
314	181	1 1/2 cups whole wheat panko	1.5	cups	c	10
314	41	1 teaspoon paprika	1.0	teaspoon	t	11
314	183	150 grams grated Parmesan cheese	150.0	grams	g	12
314	328	1/4 cup low-fat ricotta	0.25	cup	c	13
314	280	Salt and pepper	6.0	servings	servings	14
314	354	2 pounds boneless, skinless chicken breast	2.0	pounds	lb	15
314	85	1 tablespoon minced thyme	1.0	tablespoon	T	16
315	226	1 -T margarine or butter, melted	1.0	T	T	0
315	16	dash nutmeg	1.0	dash	dash	1
315	507	1/4 -t seasoned salt	0.25	\N	\N	2
315	154	4 smalls sweet potatoes (about 1 lb)	1.0	lb	lb	3
316	8	1/2 teaspoon Baking powder	0.5	teaspoon	t	0
316	224	1/2 teaspoon Baking soda	0.5	teaspoon	t	1
316	0	1/2 teaspoon Banana extract	0.5	teaspoon	t	2
316	9	200 grams Riped Banana~ mash banana with a fork	200.0	grams	g	3
316	253	100 grams Corn oil	100.0	grams	g	4
316	14	2 eggs	2.0	\N	\N	5
316	15	160 grams Plain Flour- sift together with baking powder and baking sod	160.0	grams	g	6
316	20	1/4 cup milk	0.25	cup	c	7
316	114	2/3 cup sugar	0.6666666666666666	cup	c	8
316	134	1/2 teaspoon Vanilla extract	0.5	teaspoon	t	9
316	0	1/2 tablespoon sponge cake emulsifier	0.5	tablespoon	T	10
317	124	1 1/2 cups smokey barbecue sauce	1.5	cups	c	0
317	447	1 brisket, 5 lbs., first cut	1.0	\N	\N	1
317	50	3 tablespoons brown sugar	3.0	tablespoons	T	2
317	122	1/4 tsp cayenne pepper (use 1/2 tsp for more heat)	0.25	tsp	t	3
317	40	1/2 tbsp cornstarch	0.5	tbsp	T	4
317	48	1/2 tsp cumin	0.5	tsp	t	5
317	143	4 ounces garlic powder	4.0	ounces	oz	6
317	71	2 tbs. oil for searing	2.0	tbs	tbs	7
317	166	4 ounces onion powder	4.0	ounces	oz	8
317	280	Salt and pepper	8.0	servings	servings	9
317	41	1/2 tsp smoked paprika (optional)	0.5	tsp	t	10
318	460	1/4 cup beer or white wine	0.25	cup	c	0
318	460	12 ounces can of your favorite beer (I sugggest Hefeweizen's complementary fruity flavor)	12.0	ounces	oz	1
318	239	Large head broccoli	1.0	head	head	2
318	177	1 1/2 cups slow cook brown rice	1.5	cups	c	3
318	373	12 cherry tomatoes	12.0	\N	\N	4
318	283	3/4 cup Dijon mustard	0.75	cup	c	5
318	141	1 tablespoon fresh ginger or 1 tbsp wet ginger from a jar (no powder!)	1.0	tablespoon	T	6
318	23	1 tablespoon clove fresh garlic (minced) or 1 wet garlic from a jar (no powder!)	1.0	tablespoon	T	7
318	3	1 green pepper	1.0	\N	\N	8
318	58	2 tablespoons fresh ground pepper	2.0	tablespoons	T	9
318	145	1 juicy lemon	1.0	\N	\N	10
318	268	1/4 cup low sodium soy sauce	0.25	cup	c	11
318	180	2 tablespoons molasses	2.0	tablespoons	T	12
318	55	12 bite sized mushrooms	12.0	\N	\N	13
318	72	1/4 cup olive oil	0.25	cup	c	14
318	193	1/2 cup orange juice (or tablespoon/mash another orange	0.5	cup	c	15
318	58	1/2 teaspoon pepper	0.5	teaspoon	t	16
318	76	1 red pepper	1.0	\N	\N	17
318	4	1 red onion	1.0	\N	\N	18
318	0	1/2 cup Newman's Own Low-Fat Italian Salad Dressing	0.5	cup	c	19
318	6	1 tablespoon salt	1.0	tablespoon	T	20
318	32	2 tablespoons Sriracha or Tabasco sauce	2.0	tablespoons	T	21
318	7	3 1/2 cups water	3.5	cups	c	22
318	362	1 whole chicken (about 3 lbs)	3.0	lbs	lb	23
318	191	1 large orange	1.0	\N	\N	24
319	512	30 mls Brandy	30.0	mls	mls	0
319	109	4 Egg yolks	4.0	\N	\N	1
319	14	4 eggs	4.0	\N	\N	2
319	222	8 French bread slices, stale	8.0	slices	slices	3
319	20	4 cups milk	4.0	cups	c	4
319	321	1/2 cup Raisins	0.5	cup	c	5
319	114	cup Sugar	1.0	cup	c	6
319	10	125 grams Unsalted Butter	125.0	grams	g	7
319	134	1 teaspoon Vanilla extract	1.0	teaspoon	t	8
320	385	32 ounces (2 bags) frozen chopped collard greens (or spinach)	32.0	ounces	oz	0
320	61	1/4 teaspoon crushed red pepper	0.25	teaspoon	t	1
320	14	2 eggs	2.0	\N	\N	2
320	23	6 cloves garlic, roasted and finely chopped	6.0	cloves	cloves	3
320	140	3 tablespoons grapeseed oil	3.0	tablespoons	T	4
320	135	2 jalapeños, roasted, seeded and finely chopped	2.0	\N	\N	5
320	76	1/2 red bell pepper, roasted and chopped	0.5	\N	\N	6
320	6	1/4 teaspoon salt	0.25	teaspoon	t	7
321	239	1 medium head of broccoli, cut into florets	1.0	head	head	0
321	0	1 x pack Maggi So Juicy Mixed Herbs	1.0	\N	\N	1
321	72	1/4 cup olive oil (60 mL)	60.0	mL	mL	2
321	129	1 large Russet potato, peeled and diced	1.0	\N	\N	3
321	280	Freshly ground black pepper and salt	4.0	servings	servings	4
321	354	1 1/2 pounds of boneless, skinless chicken breasts	1.5	pounds	lb	5
321	154	3 large sweet potatoes, peeled and diced	3.0	\N	\N	6
321	10	2 tablespoons Chilled unsalted butter	2.0	tablespoons	T	7
322	80	3 tablespoons Dry Curry Powder	3.0	tablespoons	T	0
322	88	2 tablespoons Dried Basil Leaves	2.0	tablespoons	T	1
322	238	1 Eggplants	1.0	\N	\N	2
322	165	10 ounces Frozen chopped Spinach, with excess water squeezed out	10.0	ounces	oz	3
322	311	1/2 cup Half & Half or Heavy Cream	0.5	cup	c	4
322	334	12 ounces Montery Jack & Cheddar Cheese Mix	12.0	ounces	oz	5
322	135	2 Jalapenos, finely chopped	2.0	\N	\N	6
322	316	3 cups Marinara Sauce (home made or a jar of 24 oz store bought)	3.0	cups	c	7
322	56	12 Baby Portabella Mushrooms, sliced	12.0	\N	\N	8
322	280	Salt & Pepper, to taste	6.0	servings	servings	9
322	154	4 Sweet Potatoes	4.0	\N	\N	10
322	11	1 tablespoon Canola or Vegetable Cooking Oil	1.0	tablespoon	T	11
323	58	black pepper	4.0	servings	servings	0
323	356	6 ounces (about 3 links) chicken sausage, sliced	6.0	ounces	oz	1
323	275	6 cups chicken stock	6.0	cups	c	2
323	61	1/4 teaspoon chili flakes	0.25	teaspoon	t	3
323	86	1/2 teaspoon dried thyme	0.5	teaspoon	t	4
323	23	1 clove garlic, thinly sliced	1.0	clove	clove	5
323	223	1/2 teaspoon ground coriander	0.5	teaspoon	t	6
323	265	4 cups chopped kale, steamed until just wilted	4.0	cups	c	7
323	55	1/3 cup mushrooms, sliced	0.3333333333333333	cup	c	8
323	72	olive oil	4.0	servings	servings	9
323	96	sea salt	4.0	servings	servings	10
323	154	3 medium sweet potatoes, coarsely cubed	3.0	\N	\N	11
323	4	1 medium yellow onion, thinly sliced	1.0	\N	\N	12
324	12	1/2 Cinnamon stick	0.5	\N	\N	0
324	15	1 1/2 tablespoons All-purpose flour	1.5	tablespoons	T	1
324	23	1 Garlic clove, minced	1.0	clove	clove	2
324	407	750 grams lamb shoulder, cut into 4 cm cubes	750.0	grams	g	3
324	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	4
324	319	1/4 cup Red wine	0.25	cup	c	5
324	7	1 cup Water	1.0	cup	c	6
324	154	A (1/2-pound) sweet potato, peeled and cut into 1-inch pieces	0.5	pound	lb	7
325	225	8 whole bay leaves	8.0	\N	\N	0
325	2	bunch of carrots, cut up	1.0	bunch	bunch	1
325	48	pinch of cumin	1.0	pinch	pinch	2
325	80	pinch of curry	1.0	pinch	pinch	3
325	23	1 clove garlic	1.0	clove	clove	4
325	65	2 cups of dry lentils	2.0	cups	c	5
325	58	pinch of pepper	1.0	pinch	pinch	6
325	96	pinch of sea salt	1.0	pinch	pinch	7
325	5	1 tablespoon of smooth organic peanut butter (optional)	1.0	tablespoon	T	8
325	164	bunch of spinach	1.0	bunch	bunch	9
325	154	1 whole sweet potato, chopped up	1.0	\N	\N	10
325	7	2 cups water	2.0	cups	c	11
325	4	1 yellow onion, chopped up	1.0	\N	\N	12
326	130	2 apples, cored, peeled and sliced*	2.0	slices	slices	0
326	10	2 tablespoons butter or margarine	2.0	tablespoons	T	1
326	92	1/4 cup cilantro, chopped	0.25	cup	c	2
326	0	4 ounces Cotija cheese	4.0	ounces	oz	3
326	48	1 teaspoon cumin	1.0	teaspoon	t	4
326	140	2 tablespoons grapeseed oil, divided	2.0	tablespoons	T	5
326	17	2 tablespoons honey	2.0	tablespoons	T	6
326	139	Juice and zest of 1 lime	1.0	\N	\N	7
326	4	1 red onion, sliced	1.0	\N	\N	8
326	61	1/2 teaspoon red pepper flakes	0.5	teaspoon	t	9
326	154	5 pounds sweet potatoes	5.0	pounds	lb	10
326	428	6 tortillas (corn or flour)	6.0	\N	\N	11
327	101	2 tablespoons balsamic vinegar	2.0	tablespoons	T	0
327	87	3 leaves of basil, finely diced	3.0	leaves	leaves	1
327	371	10-15 two-inch long okra pods	10.0	\N	\N	2
327	280	Salt and Pepper to taste	1.0	serving	serving	3
327	47	1 large tomato, chopped	1.0	\N	\N	4
328	33	1 pound Dried Black Beans	1.0	pound	lb	0
328	271	6 cups Chicken Broth or Water	6.0	cups	c	1
328	118	3 tablespoons Chipotle chilies	3.0	tablespoons	T	2
328	48	2 tablespoons Ground Cumin	2.0	tablespoons	T	3
328	265	1 bunch kale	1.0	bunch	bunch	4
328	72	2 tablespoons olive oil	2.0	tablespoons	T	5
328	4	1 Onion – Chopped	1.0	\N	\N	6
328	280	Salt & Pepper	6.0	servings	servings	7
328	154	3 lbs sweet potatoes	3.0	lbs	lb	8
329	179	4 catfish fillets or whole dressed catfish	4.0	\N	\N	0
329	15	1/4 cup flour	0.25	cup	c	1
329	143	1/8 teaspoon Garlic Powder	0.125	teaspoon	t	2
329	6	2 1/2 teaspoons Salt	2.5	teaspoons	t	3
329	71	Vegetable oil	6.0	servings	servings	4
329	178	3/4 cup yellow cornmeal	0.75	cup	c	5
330	67	1 can (28- ounces) crushed tomatoes	28.0	ounces	oz	0
330	99	1 1/2 tablespoons cider vinegar	1.5	tablespoons	T	1
330	280	Coarse salt and freshly ground black pepper	1.0	serving	serving	2
330	118	1 can chipotle chile, packed in adobo sauce, minced	7.0	oz	oz	3
330	23	3 garlic cloves, minced	3.0	cloves	cloves	4
330	18	1/2 Juice of lemon	0.5	\N	\N	5
330	72	1 1/2 tablespoons extra-virgin olive oil	1.5	tablespoons	T	6
330	4	1 medium onion diced	1.0	\N	\N	7
330	180	1/4 cup unsulfured molasses	0.25	cup	c	8
330	137	1 1/2 tablespoons Worcestershire sauce	1.5	tablespoons	T	9
331	1	15 ounces black eyed peas, drained and rinsed	15.0	ounces	oz	0
331	92	1/2 cup chopped cilantro	0.5	cup	c	1
331	23	1/2 teaspoon minced garlic	0.5	teaspoon	t	2
331	132	3 drops hot sauce	3.0	drops	drops	3
331	139	1 The juice of lime	1.0	\N	\N	4
331	47	1 ripe roma tomato, chopped	1.0	\N	\N	5
331	270	3 tablespoons of good quality salsa verde	3.0	tablespoons	T	6
332	124	1/4 cup barbecue sauce	0.25	cup	c	0
332	10	1 Tbsp. butter	1.0	Tbsp	Tbsp	1
332	50	2 Tbsp. dark brown sugar	2.0	Tbsp	Tbsp	2
332	143	1 Tsp. garlic powder	1.0	Tsp	Tsp	3
332	282	3/4 cup ketchup	0.75	cup	c	4
332	284	1/2 Tsp. dry mustard powder	0.5	Tsp	Tsp	5
332	4	2 onions, diced	2.0	\N	\N	6
332	404	2 lbs. pork spare ribs	2.0	lbs	lb	7
332	280	salt and pepper, to taste	2.0	servings	servings	8
332	98	1/2 cup white vinegar	0.5	cup	c	9
332	137	2 Tbsp. Worcestershire sauce	2.0	Tbsp	Tbsp	10
333	247	1 can cannellini beans (15 ounces)	15.0	ounces	oz	0
333	271	1 quart chicken broth (or vegetable broth)	1.0	quart	quart	1
333	45	1 teaspoon dried Oregano	1.0	teaspoon	t	2
333	140	1 tablespoon grapeseed oil	1.0	tablespoon	T	3
333	265	1 head red kale, stems removed, leaves chopped	1.0	head	head	4
333	58	Salt & ground black pepper	4.0	servings	servings	5
333	154	1 medium sweet potato, peel on, chopped into 1/2-inch cubes	1.0	\N	\N	6
333	85	1/4 teaspoon Thyme	0.25	teaspoon	t	7
333	320	1/2 cup white wine (I used chardonnay)	0.5	cup	c	8
333	4	1/2 yellow onion, chopped up	0.5	\N	\N	9
334	176	2 c. Valencia or Arborio rice	2.0	c	c	0
334	386	3/4 c. frozen artichoke hearts	0.75	c	c	1
334	67	1 can (14 1/2 oz.) diced tomatoes	14.5	oz	oz	2
334	314	8 oz. chorizo sausage	8.0	oz	oz	3
334	320	1/3 c. dry white wine	0.3333333333333333	c	c	4
334	72	extra-virgin olive oil	6.0	servings	servings	5
334	43	chopped fresh flat-leaf parsely	1.0	leaf	leaf	6
334	23	8-9 med garlic cloves, minced	8.0	cloves	cloves	7
334	145	lemon wedges	6.0	servings	servings	8
334	273	3 c. low-sodium chicken broth	3.0	c	c	9
334	4	1 onion	1.0	\N	\N	10
334	38	1/2 c. frozen peas	0.5	c	c	11
334	76	1 red bell pepper	1.0	\N	\N	12
334	263	1/2 t. saffron threads	0.5	t	t	13
334	280	salt and pepper	6.0	servings	servings	14
334	52	1 lb. large shrimp	1.0	lb	lb	15
334	355	1 lb. boneless, skinless chicken thighs	1.0	lb	lb	16
335	387	5 artichoke hearts, unmarinated	5.0	\N	\N	0
335	174	1 cup uncooked basmati rice	1.0	cup	c	1
335	376	1 cup boned and skinned white meat of chicken, sliced	1.0	cup	c	2
335	275	2 cups hot, defatted chicken stock	2.0	cups	c	3
335	200	6 clams in their shells (scrub outside of shells)	6.0	\N	\N	4
335	62	1 cup peas, fresh or frozen	1.0	cup	c	5
335	23	2 cloves garlic, minced	2.0	cloves	cloves	6
335	72	1 teaspoon olive oil	1.0	teaspoon	t	7
335	4	1/2 cup chopped onion	0.5	cup	c	8
335	45	3/4 teaspoon oregano	0.75	teaspoon	t	9
335	52	6 lg. prawns, shelled and deveined	6.0	\N	\N	10
335	76	1/2 cup each sliced red bell pepper and sliced	0.5	cup	c	11
335	377	1 red snapper fillet, cut into 1 inch pieces	1.0	fillet	fillet	12
335	256	2 teaspoons safflower oil	2.0	teaspoons	t	13
335	263	1 teaspoon saffron threads	1.0	teaspoon	t	14
335	6	1 tablespoon herbal salt substitute	1.0	tablespoon	T	15
335	47	1/2 cup diced tomato	0.5	cup	c	16
335	7	2 cups boiling water	2.0	cups	c	17
336	225	1 Bay Leaf	1.0	\N	\N	0
336	314	1/2 pound Spanish Chorizo	0.5	pound	lb	1
336	128	1 pound red Fingerling Potatoes	1.0	pound	lb	2
336	23	2 cloves garlic	2.0	cloves	cloves	3
336	389	2 pounds Manila Clams	2.0	pounds	lb	4
336	72	1 tablespoon Olive Oil	1.0	tablespoon	T	5
336	43	1 tablespoon Chopped Parsley	1.0	tablespoon	T	6
336	320	2 cups White Wine	2.0	cups	c	7
337	58	freshly ground black pepper	4.0	servings	servings	0
337	242	2 cups corn kernels, from 2 large or 4 small ears of corn	2.0	cups	c	1
337	14	4 eggs, well beaten	4.0	\N	\N	2
337	327	1/4 cup fresh ricotta	0.25	cup	c	3
337	97	kosher salt	4.0	servings	servings	4
337	329	2 tablespoons grated Pecorino Romano cheese	2.0	tablespoons	T	5
337	20	1 cup whole milk	1.0	cup	c	6
338	369	1 package (about 10 ounces) refrigerated fully-cooked chicken breast strips (about 1 3/4 cups)	10.0	ounces	oz	0
338	275	4 cups Swanson® Chicken Broth or Swanson® Chicken Stock, heated	4.0	cups	c	1
338	162	1 teaspoon ground turmeric	1.0	teaspoon	t	2
338	174	2 cups uncooked regular long-grain white rice	2.0	cups	c	3
338	269	1 cup Pace® Picante Sauce	1.0	cup	c	4
338	57	3/4 pound small frozen peeled, deveined, cooked shrimp, thawed	0.75	pound	lb	5
338	394	1 package (16 ounces) turkey kielbasa, sliced	16.0	ounces	oz	6
338	71	1 tablespoon vegetable oil	1.0	tablespoon	T	7
339	14	1 Large Egg	1.0	\N	\N	0
339	298	1 (3 oz.) pkg. vanilla instant pudding	3.0	oz	oz	1
339	264	1 kiwi fruit, peeled	1.0	\N	\N	2
339	0	1 c. light cream	1.0	c	c	3
339	20	60ml Milk	60.0	ml	ml	4
339	306	1 1/2 cups strawberries (about ½ pint)	1.5	cups	c	5
339	0	1 (9 oz.) pkg. white or yellow cake mix	9.0	oz	oz	6
340	109	8 larges egg yolks	8.0	\N	\N	0
340	338	1 tall can Full Cream Evaporated Milk	1.0	\N	\N	1
340	337	1/2 can Sweetened Condense Milk	0.5	can	can	2
340	134	1 teaspoon vanilla extract	1.0	teaspoon	t	3
340	114	1 tablespoon white sugar for each mould	1.0	tablespoon	T	4
341	10	1 ounce Butter	1.0	ounce	oz	0
341	91	Chives for garnish	6.0	servings	servings	1
341	116	3 egg whites	3.0	\N	\N	2
341	115	1/2 cup half-and-half plus	0.5	cup	c	3
341	115	2 tablespoons half-and-half	2.0	tablespoons	T	4
341	25	1 pound Leeks	1.0	pound	lb	5
341	72	1 1/2 tablespoons olive oil	1.5	tablespoons	T	6
341	6	1/2 teaspoon salt	0.5	teaspoon	t	7
341	261	1 1/2 shallots chopped fine	1.0	\N	\N	8
341	310	1/2 cup whipping cream plus	0.5	cup	c	9
341	310	2 tablespoons whipping cream	2.0	tablespoons	T	10
342	225	1 bay leaf	1.0	\N	\N	0
342	271	1 quart fish stock or chicken broth	1.0	quart	quart	1
342	314	1 pound chorizo sausage, casing removed	1.0	pound	lb	2
342	72	2 teaspoons extra-virgin olive oil	2.0	teaspoons	t	3
342	23	6 cloves garlic, minced	6.0	cloves	cloves	4
342	145	1 lemon, cut into wedges	1.0	\N	\N	5
342	146	1 lemon, zested	1.0	\N	\N	6
342	203	24 mediums mussels, cleaned	24.0	\N	\N	7
342	43	1/4 cup parsley, chopped	0.25	cup	c	8
342	62	1 cup peas	1.0	cup	c	9
342	76	1 red bell pepper, chopped	1.0	\N	\N	10
342	61	1/2 teaspoon crushed red pepper flakes	0.5	teaspoon	t	11
342	174	2 cups dry rice	2.0	cups	c	12
342	263	1/4 teaspoon saffron threads	0.25	teaspoon	t	13
342	52	3/4 pound peeled and deveined shrimp	0.75	pound	lb	14
342	4	1 Spanish onion, chopped	1.0	\N	\N	15
342	85	6 sprigs thyme	6.0	sprigs	sprigs	16
342	498	1/2 pound firm white fish, cut into bite-size pieces	0.5	pound	lb	17
343	50	1 cup brown sugar	1.0	cup	c	0
343	109	10 egg yolk	10.0	\N	\N	1
343	338	1 can evaporated milk	1.0	can	can	2
343	18	1/4 teaspoon lemon juice	0.25	teaspoon	t	3
343	337	14 ounces Sweetened condensed MILK	14.0	ounces	oz	4
343	134	1 teaspoon vanilla essence	1.0	teaspoon	t	5
343	7	1 cup water	1.0	cup	c	6
344	0	1 cup cubed (1/2") cooked ham or Canadian bacon (4	1.0	cup	c	0
344	271	1 1/2 quarts fat-skimmed chicken broth	1.5	quarts	quarts	1
344	72	1 teaspoon olive oil	1.0	teaspoon	t	2
344	38	1 cup frozen petite peas	1.0	cup	c	3
344	76	2 pounds x red bell peppers - (1 1/2 total)	2.0	pounds	lb	4
344	263	1/4 teaspoon saffron threads (optional)	0.25	teaspoon	t	5
344	0	2 ounces pkt Spanish-style seasoned rice mix - (5 to 6 e	2.0	ounces	oz	6
344	52	1 1/2 pounds Shrimp, shelled and Deveined	1.5	pounds	lb	7
345	58	a pinch of freshly ground black pepper	1.0	pinch	pinch	0
345	378	8 pieces chicken wings	8.0	pieces	\N	1
345	314	6-8 oz solid chorizo sausage, cut into 1/4 inch rounds	6.0	oz	oz	2
345	45	2 t dried oregano	2.0	t	t	3
345	72	1/4 C extra-virgin olive oil	0.25	C	C	4
345	23	1 Clove Garlic, mashed	1.0	Clove	Clove	5
345	31	4 oz shelled green peas for garnish	4.0	oz	oz	6
345	97	a pinch of Kosher salt	1.0	pinch	pinch	7
345	145	4-8 lemon wedges for serving	4.0	\N	\N	8
345	389	36 littleneck clams	36.0	\N	\N	9
345	41	1 T smoky paprika	1.0	T	T	10
345	43	1/4 C Italian parsley leaves, chopped	0.25	C	C	11
345	263	1 teaspoon Saffron, crumbled	1.0	teaspoon	t	12
345	280	salt and pepper to taste	4.0	servings	servings	13
345	176	1 C short grain Spanish rice (we used La Bomba but Arborio can be substituted)	1.0	C	C	14
345	52	1 1/2 pounds Shrimp, shelled and Deveined	1.5	pounds	lb	15
345	47	1 of 14.5 oz whole tomatoes, drained, crushed and chopped coarse	1.0	\N	\N	16
345	7	2 C hot water	2.0	C	C	17
345	4	1 white onion, skinned and diced	1.0	\N	\N	18
346	225	1 bay leaf	1.0	\N	\N	0
346	169	pound fresh green beans diced	1.0	pound	lb	1
346	76	1 lrg red bell pepper cut wide strips	1.0	\N	\N	2
346	412	pound calamari cleaned, skinned,	1.0	pound	lb	3
346	170	canned peas, carrots, or chick (depending on your taste)	1.0	serving	serving	4
346	43	Chopped parsley (fresh is best)	1.0	serving	serving	5
346	23	1 full head of garlic	1.0	\N	\N	6
346	23	Minced garlic as much as you like	1.0	serving	serving	7
346	3	1 green pepper diced	1.0	\N	\N	8
346	389	12 Clams, littleneck Or mussels or both	12.0	\N	\N	9
346	72	Olive oil as needed	1.0	serving	serving	10
346	4	1 medium onion	1.0	\N	\N	11
346	375	3 Roma plum tomatoes - (to 4) minced	3.0	\N	\N	12
346	263	1 teaspoon Saffron, crumbled	1.0	teaspoon	t	13
346	52	pound medium shrimp in shells heads off	1.0	pound	lb	14
346	174	2 cups raw white rice	2.0	cups	c	15
347	367	8 chicken drumsticks or thighs	8.0	\N	\N	0
347	314	3 Chorizo, sliced 1/2" Thick (or Portuguese or Ita	3.0	\N	\N	1
347	228	Freshly cracked black pepper	10.0	servings	servings	2
347	43	Chopped parsley (fresh is best)	10.0	servings	servings	3
347	23	2 garlic cloves minced	2.0	cloves	cloves	4
347	174	500g long grain rice	500.0	g	g	5
347	389	12 Clams, littleneck Or mussels or both	12.0	\N	\N	6
347	72	15 milliliters olive oil	15.0	milliliters	ml	7
347	4	1 medium onion	1.0	\N	\N	8
347	402	500g fillet of pork, diced into small pieces	500.0	g	g	9
347	47	200g deep red tomatoes	200.0	g	g	10
347	10	1/4 cup Unsalted butter	0.25	cup	c	11
347	7	1.5L water	1.0	liter	l	12
347	52	8 large crevettes	8.0	\N	\N	13
347	0	50g jambon, smoked (pieces)	50.0	g	g	14
347	62	200g petit pois	200.0	g	g	15
348	225	1 bay leaf	1.0	\N	\N	0
348	353	1 1/2 pounds chicken breasts cut into chunks or whole chic	1.5	pounds	lb	1
348	275	3 1/2 cups chicken stock	3.5	cups	c	2
348	314	14 ounces chorizo	14.0	ounces	oz	3
348	97	coarse salt and pepper	6.0	servings	servings	4
348	48	1 teaspoon cumin	1.0	teaspoon	t	5
348	23	2 cloves garlic, chopped	2.0	cloves	cloves	6
348	3	1 green pepper, chopped	1.0	\N	\N	7
348	145	lemon wedges	6.0	servings	servings	8
348	176	2 cups short or medium grain rice	2.0	cups	c	9
348	72	1/2 cup olive oil	0.5	cup	c	10
348	4	1 medium onion, chopped	1.0	\N	\N	11
348	41	1 teaspoon paprika or pimenton	1.0	teaspoon	t	12
348	38	1/2 cup frozen peas	0.5	cup	c	13
348	76	1 red pepper, chopped	1.0	\N	\N	14
348	83	1 teaspoon rosemary	1.0	teaspoon	t	15
348	263	1 pinch saffron threads	1.0	pinch	pinch	16
348	52	1 pound shrimp with tails on	1.0	pound	lb	17
348	85	1 teaspoon thyme	1.0	teaspoon	t	18
348	47	1 tomato, chopped	1.0	\N	\N	19
348	320	1 cup white wine	1.0	cup	c	20
349	8	2 teaspoons baking powder	2.0	teaspoons	t	0
349	10	2 tablespoons butter	2.0	tablespoons	T	1
349	202	1 cup organic canned pumpkin, NOT pie filling	1.0	cup	c	2
349	50	3/4 cup dark brown sugar, packed firmly	0.75	cup	c	3
349	14	2 eggs	2.0	\N	\N	4
349	15	3 cups flour	3.0	cups	c	5
349	12	1 teaspoon ground cinnamon	1.0	teaspoon	t	6
349	290	1/8 teaspoon ground cloves	0.125	teaspoon	t	7
349	16	1/8 teaspoon ground nutmeg	0.125	teaspoon	t	8
349	20	1/2 cup milk	0.5	cup	c	9
349	6	1/2 teaspoon salt	0.5	teaspoon	t	10
349	259	1/2 cup shortening	0.5	cup	c	11
349	114	2 tablespoons sugar	2.0	tablespoons	T	12
350	99	3 tablespoons apple cider vinegar	3.0	tablespoons	T	0
350	237	3/4 of an English cucumber, peeled and seeded	0.75	\N	\N	1
350	44	2 teaspoons dried parsley	2.0	teaspoons	t	2
350	72	4 tablespoons extra-virgin olive oil	4.0	tablespoons	T	3
350	23	3 garlic cloves	3.0	cloves	cloves	4
350	374	1 1/2 cups grape tomatoes	1.5	cups	c	5
350	81	1/4 orange bell pepper, diced	0.25	\N	\N	6
350	181	4 tablespoons Panko bread crumbs	4.0	tablespoons	T	7
350	4	1/2 red onion, diced	0.5	\N	\N	8
350	0	2 slices rye bread	2.0	slices	slices	9
350	6	1/8 teaspoon salt	0.125	teaspoon	t	10
350	96	2 teaspoons fine sea salt	2.0	teaspoons	t	11
350	0	1/2 cup Daiya vegan cheddar crumbles	0.5	cup	c	12
350	47	3 ripe on the vine tomatoes, cored	3.0	\N	\N	13
350	7	1/4 cup water	0.25	cup	c	14
351	225	1 bay leaf	1.0	\N	\N	0
351	23	2 cloves of garlic, finely chopped	2.0	cloves	cloves	1
351	42	1 pound Ground beef	1.0	pound	lb	2
351	72	1 cup olive oil	1.0	cup	c	3
351	72	2 tablespoons of olive oil	2.0	tablespoons	T	4
351	4	1/2 cup onion, chopped	0.5	cup	c	5
351	4	Half an onion, finely chopped	20.0	servings	servings	6
351	43	2 tablespoons of chopped parsley	2.0	tablespoons	T	7
351	280	Salt and pepper to taste	20.0	servings	servings	8
351	114	1 teaspoon of sugar	1.0	teaspoon	t	9
351	41	pinch of Pimenton de la Vera (Dulce) or Spanish sweet paprika	1.0	pinch	pinch	10
351	47	600g tomatoes	600.0	g	g	11
351	21	4 slices of sandwich bread, only the white part, diced	4.0	slices	slices	12
351	14	1 large egg, whole	1.0	\N	\N	13
352	117	1/4 cup smoked almonds, toasted & rough chopped	0.25	cup	c	0
352	95	1/2 teaspoon chili powder	0.5	teaspoon	t	1
352	67	1 (15 ounce) can Fire Roasted Diced Tomatoes, drained	15.0	ounce	oz	2
352	43	2 tablespoons fresh flat-leaf parsley	2.0	tablespoons	T	3
352	45	2 tablespoons fresh oregano	2.0	tablespoons	T	4
352	83	1 teaspoon fresh rosemary	1.0	teaspoon	t	5
352	23	3 cloves of garlic, peeled & rough chopped	3.0	cloves	cloves	6
352	97	Kosher salt & freshly cracked black pepper	8.0	servings	servings	7
352	72	2 tablespoons olive oil	2.0	tablespoons	T	8
352	76	2 red bell peppers	2.0	\N	\N	9
352	100	2 tablespoons red wine vinegar	2.0	tablespoons	T	10
352	41	1 teaspoon smoked paprika	1.0	teaspoon	t	11
352	114	1 tablespoon sugar	1.0	tablespoon	T	12
353	61	1/4 teaspoon crushed red pepper (or more, to taste)	0.25	teaspoon	t	0
353	23	2 cloves garlic, minced	2.0	cloves	cloves	1
353	411	1/4 cup hazelnuts	0.25	cup	c	2
353	183	cup freshly grated Parmesan cheese	1.0	cup	c	3
353	100	2 tablespoons red wine vinegar, according to desired consistency	2.0	tablespoons	T	4
353	117	1/4 cup roasted almonds	0.25	cup	c	5
353	76	1 whole 12 oz. jar roasted red peppers (or about 2- 3 fresh red bell peppers, roasted)	12.0	oz	oz	6
353	6	1 teaspoon salt - (about)	1.0	teaspoon	t	7
353	215	1/4 tablespoon c. sun-dried tomatoes, packed in oil (or 1/4 c. soft sun-dried	0.25	tablespoon	T	8
354	251	1 bunch fresh asparagus, sliced into 2 inch length	1.0	bunch	bunch	0
354	2	1/4 carrot, sliced thinly	0.25	\N	\N	1
354	71	2 tablespoons cooking oil	2.0	tablespoons	T	2
354	163	1 1/2 tablespoons fish sauce (Nam Pla) (to your taste)	1.5	tablespoons	T	3
354	23	3 cloves garlic, chopped coarsely	3.0	cloves	cloves	4
354	114	1 teaspoon sugar	1.0	teaspoon	t	5
354	7	3 tablespoons of water	3.0	tablespoons	T	6
354	412	6 small squids (clean and cut into bite size)	6.0	\N	\N	7
355	58	1 teaspoon black pepper	1.0	teaspoon	t	0
355	50	3 tablespoons brown sugar	3.0	tablespoons	T	1
355	372	500 grams chicken thigh or breast meat, cut into cubes	500.0	grams	g	2
355	237	Cucumber, cut int wedges	30.0	servings	servings	3
355	50	3 tablespoons dark brown sugar	3.0	tablespoons	T	4
355	72	Extra oil for cooking	30.0	servings	servings	5
355	163	1 teaspoon fish sauce	1.0	teaspoon	t	6
355	163	3 teaspoons fish sauce	3.0	teaspoons	t	7
355	23	1 clove garlic, chopped	1.0	clove	clove	8
355	93	1 teaspoon ground coriander	1.0	teaspoon	t	9
355	48	1 teaspoon ground cumin	1.0	teaspoon	t	10
355	18	1 tablespoon lemon juice	1.0	tablespoon	T	11
355	18	3 tablespoons lemon juice	3.0	tablespoons	T	12
355	74	1 tablespoon light soya sauce	1.0	tablespoon	T	13
355	5	Peanut butter, to taste	30.0	servings	servings	14
355	121	2 tablespoons red curry paste	2.0	tablespoons	T	15
355	383	1 cup of coarse roasted peanuts	1.0	cup	c	16
355	4	Spanish onion, cut into wedges	1.0	\N	\N	17
355	162	1 teaspoon turmeric	1.0	teaspoon	t	18
355	350	4 cups unsweetened coconut milk	4.0	cups	c	19
355	71	1 tablespoon vegetable oil	1.0	tablespoon	T	20
356	87	1/2 cup packed holy basil leaves & flowers	0.5	cup	c	0
356	467	1 1/2 tablespoons oyster sauce	1.5	tablespoons	T	1
356	0	1 teaspoon Braggs Amino Acids	1.0	teaspoon	t	2
356	239	1 cup broccoli florets	1.0	cup	c	3
356	11	2 tablespoons canola oil	2.0	tablespoons	T	4
356	2	1 carrot, sliced	1.0	\N	\N	5
356	120	1 sliced orange chili (about 1 tablespoon)	1.0	tablespoon	T	6
356	120	1 tablespoon smashed small Thai chilies	1.0	tablespoon	T	7
356	23	3 garlic, minced	3.0	\N	\N	8
356	238	1/2 cup Japanese eggplant, sliced	0.5	cup	c	9
356	58	2 tablespoons fresh peppercorns	2.0	tablespoons	T	10
356	187	1 1/4 cup (1/2 lb) fresh wide rice noodles [or, 1/4 lb. + 1/4 lb. Yam-cake, or Shirataki noodles]	0.5	lb	lb	11
356	74	1 tablespoon fish sauce or white soy sauce (or more to taste)	1.0	tablespoon	T	12
356	417	1/4 teaspoon Stevia	0.25	teaspoon	t	13
356	125	1 1/2 teaspoon Tamari	1.5	teaspoon	t	14
356	252	1/2 cup firm tofu, patted dry and cut into bit-sized pieces (or 1/2 cup seafood such as squid & shrimp, or chicken)	0.5	cup	c	15
356	98	1/4 teaspoon vinegar	0.25	teaspoon	t	16
356	7	3/4 cup of water	0.75	cup	c	17
356	233	1/2 cup zucchini (1 medium), sliced	0.5	cup	c	18
357	120	2 chilies	2.0	\N	\N	0
357	163	3 tablespoons fish sauce	3.0	tablespoons	T	1
357	139	1 whole lime, juiced	1.0	\N	\N	2
357	156	lettuce	2.0	servings	servings	3
357	262	2 whole green mango. peeled and julienned	2.0	\N	\N	4
357	114	1 tablespoon sugar	1.0	tablespoon	T	5
357	47	2 wholes tomatoes, diced	2.0	\N	\N	6
358	59	5 small dried chile de arbols, or other red chilies (check the produce section or Hispanic foods aisle)	5.0	\N	\N	0
358	163	1/3 c. fish sauce	0.3333333333333333	c	c	1
358	23	3 large cloves garlic, coarsely chopped	3.0	cloves	cloves	2
358	373	12 cherry or grape tomatoes, halved	12.0	\N	\N	3
358	139	1/4 c. lime juice	0.25	c	c	4
358	4	1/2 c. very coarsely chopped onion	0.5	c	c	5
358	76	1 red bell pepper, coarsely chopped	1.0	\N	\N	6
358	114	1 pinch of sugar	1.0	pinch	pinch	7
359	87	1/2 cup (s) of fresh basil, chopped	0.5	cup	c	0
359	0	1 cup (s) of broccoli slaw mix (containing broccoli, carrots&	1.0	cup	c	1
359	372	1 1/2 cups (s) of chicken strips	1.5	cups	c	2
359	58	1 pinch of ground black pepper	1.0	pinch	pinch	3
359	51	3/4 cup (s) of mung bean sprouts	0.75	cup	c	4
359	5	1/4 cup (s) of natural peanut butter, creamy (no sugar!)	0.25	cup	c	5
359	380	cup (s) of peanuts, crushed	1.0	cup	c	6
359	297	1 tablespoon of rice wine vinegar	1.0	tablespoon	T	7
359	297	2 tablespoons of rice wine vinegar	2.0	tablespoons	T	8
359	157	6 large romaine lettuce leaves	6.0	\N	\N	9
359	96	1 teaspoon of sea salt	1.0	teaspoon	t	10
359	28	1 tablespoon of sesame oil	1.0	tablespoon	T	11
359	28	2 tablespoons of sesame oil	2.0	tablespoons	T	12
359	46	1 tablespoon of sesame seeds	1.0	tablespoon	T	13
359	74	2 tablespoons of shoyu or soy sauce	2.0	tablespoons	T	14
359	114	1 1/2 tablespoons of sugar	1.5	tablespoons	T	15
360	92	1/4 cup fresh cilantro, chopped	0.25	cup	c	0
360	23	1 teaspoon minced garlic	1.0	teaspoon	t	1
360	141	1 teaspoon minced ginger	1.0	teaspoon	t	2
360	350	1 can coconut milk (I don't recommend using light)	1.0	can	can	3
360	72	1 tablespoon olive oil	1.0	tablespoon	T	4
360	4	1 cup finely chopped onion	1.0	cup	c	5
360	66	1 cup red lentils, picked through for stones, and rinsed well	1.0	cup	c	6
360	6	1/2 teaspoon salt, or more to taste	0.5	teaspoon	t	7
360	154	1 inch medium sweet potato, cut into 1/2 pieces	1.0	inch	inch	8
360	121	2 teaspoons Thai red curry paste (if you like it spicy, use the full 2 teaspoons)	2.0	teaspoons	t	9
360	162	1/4 teaspoon turmeric	0.25	teaspoon	t	10
360	7	6 cups water	6.0	cups	c	11
361	14	2 eggs	2.0	\N	\N	0
361	23	clove garlic, minced fine	1.0	clove	clove	1
361	3	1/2 green pepper, chopped	0.5	\N	\N	2
361	71	Oil for fry	1.0	serving	serving	3
361	4	1 big onion, sliced	1.0	\N	\N	4
361	58	Pepper to taste	1.0	serving	serving	5
361	403	1 pound lean pork, sliced	1.0	pound	lb	6
361	174	2 cups rice	2.0	cups	c	7
361	6	Salt to taste	1.0	serving	serving	8
361	74	2 1/2 tablespoons soy sauce	2.5	tablespoons	T	9
361	114	2 teaspoons sugar	2.0	teaspoons	t	10
361	47	1 tomato, diced	1.0	\N	\N	11
361	7	4 cups water	4.0	cups	c	12
362	220	• 2 tbsp Corn Flour	2.0	tbsp	T	0
362	92	1/4 cup of coriander leaves- chopped	0.25	cup	c	1
362	14	1 Egg, Lightly Beaten	1.0	\N	\N	2
362	163	1 1/2 tablespoons fish sauce	1.5	tablespoons	T	3
362	169	200 g green beans	200.0	g	g	4
362	71	Oil for fry	2.0	servings	servings	5
362	59	1 -2 Red chili	1.0	\N	\N	6
362	121	2 tbsp Red Curry Paste	2.0	tbsp	T	7
362	6	salt	2.0	servings	servings	8
362	94	• 2 Spring Onion, Chopped	2.0	\N	\N	9
362	498	• 300 g White Fish Fillets, Uncooked	300.0	g	g	10
363	2	1 cup carrot, shredded	1.0	cup	c	0
363	120	2 to 3 chili padis	2.0	\N	\N	1
363	163	Fish sauce, to taste	6.0	servings	servings	2
363	23	1 clove of garlic, mashed	1.0	clove	clove	3
363	138	4 limes	4.0	\N	\N	4
363	262	3 cups raw green mangoes, shredded	3.0	cups	c	5
363	0	Thai palm sugar, to taste	6.0	servings	servings	6
363	383	4 tablespoons roasted coarse peanuts	4.0	tablespoons	T	7
363	261	2 shallots, mashed	2.0	\N	\N	8
363	90	1 tablespoon of dried shrimps, washed	1.0	tablespoon	T	9
363	47	1 tomato, cut into wedges	1.0	\N	\N	10
363	0	2 inches long beans cut into 1 pieces	2.0	inches	inches	11
364	225	2 bay leaves	2.0	\N	\N	0
364	0	1/2 inch roasted belacan	0.5	inch	inch	1
364	58	1 tsp black peppercorns	1.0	tsp	t	2
364	350	1/2 cup coconut milk	0.5	cup	c	3
364	49	1 tsp cumin seeds	1.0	tsp	t	4
364	93	2-3 sprigs coriander leaves (cut off roots and include the stems)	2.0	sprigs	sprigs	5
364	163	3 tbsp Fish Sauce	3.0	tbsp	T	6
364	454	1/2 inch galangal	0.5	inch	inch	7
364	23	2 teaspoons minced garlic	2.0	teaspoons	t	8
364	186	3 cardamoms (only the seeds)	3.0	\N	\N	9
364	406	500g lamb (or beef)	500.0	g	g	10
364	352	1 lemongrass	1.0	\N	\N	11
364	139	2 tablespoons lemon or lime juice	2.0	tablespoons	T	12
364	336	1/2 tsp lime rind	0.5	tsp	t	13
364	71	1/2 cup oil	0.5	cup	c	14
364	77	5-6 dried red chilies	5.0	\N	\N	15
364	128	2 potatoes - remove skin and cut into chunks (optional)	2.0	\N	\N	16
364	6	Salt for taste (only if need or use sparingly as fish sauce is salty)	5.0	servings	servings	17
364	261	2-3 Shallots, sliced.	2.0	slices	slices	18
365	239	2 cups broccoli, cut into mini florets	2.0	cups	c	0
365	132	1 teaspoon hot chili sauce	1.0	teaspoon	t	1
365	92	1/2 cup – 1 cilantro leaves, chopped	0.5	cup	c	2
365	163	1 tablespoon fish sauce	1.0	tablespoon	T	3
365	23	2 cloves garlic, minced	2.0	cloves	cloves	4
365	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	5
365	18	2 tablespoons lemon juice	2.0	tablespoons	T	6
365	72	2 tablespoons olive oil	2.0	tablespoons	T	7
365	4	1 cup onions, diced	1.0	cup	c	8
365	280	Salt and pepper	2.0	servings	servings	9
365	74	2 tablespoons soy sauce	2.0	tablespoons	T	10
365	76	1 cup sweet peppers, diced	1.0	cup	c	11
365	366	6 ounces whole wheat spaghetti	6.0	ounces	oz	12
366	0	8 oz bamboo shoots (sliced and drained)	8.0	oz	oz	0
366	50	¼ cup brown sugar	0.25	cup	c	1
366	353	1 lb chicken breast	1.0	lb	lb	2
366	350	13.5 oz coconut milk	13.5	oz	oz	3
366	163	1 teaspoon fish sauce (nam pla)	1.0	teaspoon	t	4
366	4	2 onions, slice	2.0	\N	\N	5
366	112	14 oz pineapple chunks (drained)	14.0	oz	oz	6
366	76	1/2 cup red bell pepper (julienne)	0.5	cup	c	7
366	121	1 tablespoon red curry paste	1.0	tablespoon	T	8
366	31	250 grams snow peas, trimmed	250.0	grams	g	9
367	188	Cooked jasmine rice	2.0	servings	servings	0
367	237	2 large cucumbers	2.0	\N	\N	1
367	0	6 Chinese sausages	6.0	\N	\N	2
367	51	1 cup fresh bean sprouts	1.0	cup	c	3
367	92	Fresh flat leaf parsley or cilantro leaves for garnish	1.0	leaves	leaves	4
367	114	3 teaspoons granulated sugar	3.0	teaspoons	t	5
367	94	4 green onions	4.0	\N	\N	6
367	139	1/2 cup fresh lime juice	0.5	cup	c	7
367	59	1 thinly sliced hot, fresh red chili pepper (optional)	1.0	\N	\N	8
367	74	2 teaspoons soy sauce	2.0	teaspoons	t	9
367	163	2 tablespoons Thai fish sauce	2.0	tablespoons	T	10
368	99	2 tablespoons apple cider vinegar (or rice vinegar)	2.0	tablespoons	T	0
368	151	8 ounces baby bok choy or regular bok choy (shredded	8.0	ounces	oz	1
368	74	4 tablespoons Nama Shoyu (soy sauce) or Bragg liquid Aminos	4.0	tablespoons	T	2
368	177	1 cup uncooked brown rice (make recipe below)	1.0	cup	c	3
368	73	1 cup raw cashew nuts	1.0	cup	c	4
368	479	1 1/4 cups dry unsweetened shredded coconut, lightly toasted	1.25	cups	c	5
368	0	1 flax egg (made with 1 Tbsp. ground flax seed & 3 Tbsp. water)	1.0	tablespoon	T	6
368	72	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	7
368	23	4 garlic cloves, minced	4.0	cloves	cloves	8
368	169	2 1/2 cups fresh green beans, cut in half	2.5	cups	c	9
368	138	lime wedges for serving	4.0	servings	servings	10
368	417	1/2 teaspoon stevia powder (or sweetener of choice)	0.5	teaspoon	t	11
369	87	1 bunch basil leaves, 2 c. leaves	1.0	bunch	bunch	0
369	275	8 cups chicken stock	8.0	cups	c	1
369	188	Hot cooked rice	4.0	servings	servings	2
369	163	2 tablespoons fish sauce	2.0	tablespoons	T	3
369	94	4 green onions	4.0	\N	\N	4
369	254	1 teaspoon organic peanut oil	1.0	teaspoon	t	5
369	120	3 hot red or green chilies	3.0	\N	\N	6
369	52	8 ounces shrimp, cooked, peeled, and deveined, 51 – 60 per pound	8.0	ounces	oz	7
369	74	2 teaspoons soy sauce	2.0	teaspoons	t	8
369	114	1 teaspoon sugar	1.0	teaspoon	t	9
370	73	A handful of cashew nuts	1.0	handful	handful	0
370	353	300-350g Chicken breast or thighs (about 3/4 pound)	0.75	pound	lb	1
370	78	1 tablespoon chili paste	1.0	tablespoon	T	2
370	74	1/2 tablespoon Dark soy sauce	0.5	tablespoon	T	3
370	77	Dried chilies	3.0	servings	servings	4
370	23	2 cloves garlic, minced	2.0	cloves	cloves	5
370	94	1 stalk green onion	1.0	stalk	stalk	6
370	4	1 onion (cut into wedges)	1.0	\N	\N	7
370	74	1 tablespoon soy sauce	1.0	tablespoon	T	8
371	50	1/4 cup Brown Sugar	0.25	cup	c	0
371	0	1 teaspoon Hot Chili Sauce	1.0	teaspoon	t	1
371	163	2 tablespoons Fish Sauce	2.0	tablespoons	T	2
371	141	2 tablespoons Minced Fresh Ginger	2.0	tablespoons	T	3
371	162	1 tablespoon ground Dried Turmeric	1.0	tablespoon	T	4
371	138	1 Lime	1.0	\N	\N	5
371	0	1 bunch Yu Choy	1.0	bunch	bunch	6
371	391	1 1/2 pounds Salmon Fillet	1.5	pounds	lb	7
372	151	1 large head bok choy, chopped	1.0	head	head	0
372	50	2 teaspoons brown sugar	2.0	teaspoons	t	1
372	2	1 c. julienned carrots	1.0	c	c	2
372	78	2 teaspoons hot chili paste (depending on how spicy you prefer your dish- start with 1 tsp and taste test it)	2.0	teaspoons	t	3
372	40	1 teaspoon corn starch dissolved in 1 tablespoon cold water	1.0	teaspoon	t	4
372	0	1 12 ounce block extra firm tofu, drained and pressed to remove water	12.0	ounce	oz	5
372	163	1 T. fish sauce	1.0	T	T	6
372	467	3 tablespoons oyster sauce	3.0	tablespoons	T	7
372	28	2 tablespoons Sesame oil	2.0	tablespoons	T	8
372	74	2 tablespoons soy sauce	2.0	tablespoons	T	9
373	11	1/2 c. canola oil, divided	0.5	c	c	0
373	2	1 c. julienned carrots	1.0	c	c	1
373	122	pinch of cayenne	1.0	pinch	pinch	2
373	92	1/2 c. cilantro leaves	0.5	c	c	3
373	163	1 T. fish sauce	1.0	T	T	4
373	23	1 garlic clove, finely minced	1.0	clove	clove	5
373	141	1 teaspoon Minced ginger	1.0	teaspoon	t	6
373	50	2 t. light brown sugar	2.0	t	t	7
373	139	3 T. fresh lime juice	3.0	T	T	8
373	148	1 small head of napa cabbage, shredded (about 3 c.)	3.0	c	c	9
373	149	1/2 head red cabbage	0.5	head	head	10
373	94	1 c. thinly sliced scallion	1.0	c	c	11
373	31	6 oz. snow peas, trimmed, sliced on the diagonal about 1/2-inch thick	6.0	oz	oz	12
373	462	1/2 t. Chinese five spice	0.5	t	t	13
373	32	1 t. sriracha	1.0	t	t	14
373	380	1 c. unsalted peanuts, divided	1.0	c	c	15
373	418	12 square wonton wrappers	12.0	square	square	16
373	82	1 yellow bell pepper, thinly sliced	1.0	\N	\N	17
374	238	1 small aubergine, chopped into chunks	1.0	\N	\N	0
374	87	20 grams pack basil, leaves picked	20.0	grams	g	1
374	50	1 teaspoon brown sugar	1.0	teaspoon	t	2
374	350	400 milliliters can reduced-fat coconut milk	400.0	milliliters	ml	3
374	59	3 red chilies	3.0	\N	\N	4
374	92	20 grams stalks from pack coriander	20.0	grams	g	5
374	233	1 courgette, chopped into chunks	1.0	\N	\N	6
374	23	2 garlic cloves	2.0	cloves	cloves	7
374	141	thumb-size piece ginger, grated	1.0	piece	\N	8
374	93	1 teaspoon ground coriander	1.0	teaspoon	t	9
374	174	jasmine rice, to serve	4.0	servings	servings	10
374	352	1 lemongrass, roughly chopped	1.0	\N	\N	11
374	336	1 zest lime	1.0	\N	\N	12
374	139	3 juice limes	3.0	\N	\N	13
374	55	140 grams mushrooms, halved	140.0	grams	g	14
374	58	1 teaspoon freshly ground pepper	1.0	teaspoon	t	15
374	76	1/2 red pepper, deseeded and roughly chopped	0.5	\N	\N	16
374	261	3 shallots, roughly chopped	3.0	\N	\N	17
374	74	5 tablespoons soy sauce	5.0	tablespoons	T	18
374	31	140 grams sugar snap peas	140.0	grams	g	19
374	252	200 grams firm tofu, cubed	200.0	grams	g	20
374	71	2 tablespoons vegetable oil	2.0	tablespoons	T	21
375	87	1/2 cup Thai basil or you can use regular basil	0.5	cup	c	0
375	156	small head of Boston lettuce, roughly chopped	1.0	head	head	1
375	59	small chili pepper, finely chopped	4.0	servings	servings	2
375	93	1/2 cup coriander (cilantro) leaves	0.5	cup	c	3
375	163	1/4 cup fish sauce	0.25	cup	c	4
375	23	1 clove garlic	1.0	clove	clove	5
375	139	2 tablespoons fresh lime juice	2.0	tablespoons	T	6
375	152	1/2 cup mint leaves	0.5	cup	c	7
375	76	red bell pepper, thinly sliced	4.0	servings	servings	8
375	297	1/4 cup rice vinegar	0.25	cup	c	9
375	57	8 large cooked shrimp, slice in half lengthways	8.0	\N	\N	10
375	503	8 large (8-inch) spring roll wrappers	8.0	\N	\N	11
375	114	1 tablespoon sugar	1.0	tablespoon	T	12
375	7	1/4 cup water	0.25	cup	c	13
375	0	Nuoc Cham (dipping sauce)	4.0	servings	servings	14
376	24	1 1/4 cups shredded cabbage	1.25	cups	c	0
376	2	1 1/4 cups shredded carrots	1.25	cups	c	1
376	78	1 teaspoon chili paste	1.0	teaspoon	t	2
376	350	1 tablespoon coconut milk	1.0	tablespoon	T	3
376	5	1/2 cup Creamy Peanut Butter	0.5	cup	c	4
376	87	15 fresh basil leaves, chopped	15.0	\N	\N	5
376	92	2 tablespoons fresh cilantro, chopped	2.0	tablespoons	T	6
376	141	1 tablespoon fresh ginger, grated	1.0	tablespoon	T	7
376	152	15 fresh mint leaves, chopped	15.0	\N	\N	8
376	23	1 Tbs.minced garlic	1.0	Tb	Tb	9
376	139	1 tablespoon fresh lime juice	1.0	tablespoon	T	10
376	380	1/4 cup peanuts, crushed	0.25	cup	c	11
376	187	1 1/4 ounces rice vermicelli	1.25	ounces	oz	12
376	94	2 scallions	2.0	\N	\N	13
376	28	1 teaspoon toasted (dark) sesame seed oil	1.0	teaspoon	t	14
376	74	1 1/2 tablespoons gluten free soy sauce (Tamari)	1.5	tablespoons	T	15
376	503	15 gluten free spring roll wrappers	15.0	\N	\N	16
376	114	1/2 tablespoon sugar	0.5	tablespoon	T	17
376	7	1/2 cup warm water	0.5	cup	c	18
377	2	2 carrots, sliced thin on the bias	2.0	\N	\N	0
377	353	4 large chicken breasts	4.0	\N	\N	1
377	92	1 cup cilantro leaves (or mint)	1.0	cup	c	2
377	61	1/4 teaspoon crushed red pepper	0.25	teaspoon	t	3
377	237	1/2 cucumber, sliced thin	0.5	\N	\N	4
377	53	2 daikon radishes, sliced thin on the bias	2.0	\N	\N	5
377	163	1/2 cup fish sauce	0.5	cup	c	6
377	23	1 clove garlic, minced	1.0	clove	clove	7
377	135	1 sliced jalapeno for extra heat	1.0	\N	\N	8
377	139	1/2 cup lime juice	0.5	cup	c	9
377	281	1/3 cup mayonnaise	0.3333333333333333	cup	c	10
377	297	1/4 cup rice vinegar	0.25	cup	c	11
377	6	1/4 teaspoon salt	0.25	teaspoon	t	12
377	189	6 soft sub bun	6.0	\N	\N	13
377	114	1/4 cup sugar	0.25	cup	c	14
377	7	1/4 cup hot tap water	0.25	cup	c	15
378	52	1/2 cup If non-vegetarian: add cooked baby shrimp	0.5	cup	c	0
378	51	2 cups approx. bean sprouts	2.0	cups	c	1
378	24	1/2 cup shredded or finely chopped cabbage	0.5	cup	c	2
378	2	1 cup shredded carrots	1.0	cup	c	3
378	59	1 teaspoon 1 red chili, minced, OR 1/2 to cayenne pepper (omit if you prefer very mild	1.0	teaspoon	t	4
378	91	1/2 cup chives	0.5	cup	c	5
378	163	2 tablespoons fish sauce OR vegetarian stir-fry sauce	2.0	tablespoons	T	6
378	87	1/2 cup fresh basil, roughly chopped	0.5	cup	c	7
378	92	1/2 cup fresh coriander, roughly chopped	0.5	cup	c	8
378	454	1 thumb-size piece galangal OR ginger, grated	1.0	\N	\N	9
378	23	3 cloves garlic, minced	3.0	cloves	cloves	10
378	94	2 green onions, sliced into matchstick pieces	2.0	\N	\N	11
378	139	2 tablespoons lime juice	2.0	tablespoons	T	12
378	445	1 16 oz package phyllo dough	16.0	oz	oz	13
378	54	6 shiitake mushrooms, cut into matchstick pieces	6.0	\N	\N	14
378	74	2 tablespoons regular soy sauce	2.0	tablespoons	T	15
378	114	1/4 teaspoon sugar	0.25	teaspoon	t	16
378	252	1/2 cup medium to firm tofu, sliced into matchstick pieces	0.5	cup	c	17
379	2	2 carrots, julienned	2.0	\N	\N	0
379	23	1 1/2 garlic clove	1.5	cloves	cloves	1
379	141	1/2 teaspoon ginger	0.5	teaspoon	t	2
379	30	3/4 cup hoisin sauce	0.75	cup	c	3
379	30	Garlic Lime Hoisin Sauce	10.0	servings	servings	4
379	491	1 jicama	1.0	\N	\N	5
379	156	1 head of butter leaf lettuce	1.0	head	head	6
379	139	2 tablespoons lime	2.0	tablespoons	T	7
379	76	1 red bell pepper	1.0	\N	\N	8
379	502	12 rice paper sheets	12.0	sheet	sheet	9
379	87	12 leaves of Thai basil	12.0	leaves	leaves	10
379	82	1 yellow bell pepper	1.0	\N	\N	11
379	32	1 teaspoon Sriracha (or to taste)	1.0	teaspoon	t	12
380	92	cilantro sprigs	1.0	sprigs	sprigs	0
380	237	1 cucumber, peeled in stripes, and sliced thinly	1.0	\N	\N	1
380	163	2 tablespoons of fish sauce	2.0	tablespoons	T	2
380	23	1 tablespoon minced garlic	1.0	tablespoon	T	3
380	58	2 tablespoons fresh ground black pepper	2.0	tablespoons	T	4
380	135	jalapeno	6.0	servings	servings	5
380	398	1 pound of pork chops, shoulder or loin. Sliced thinly	1.0	pound	lb	6
380	281	mayo	6.0	servings	servings	7
380	4	2 tablespoons of finely chopped onion	2.0	tablespoons	T	8
380	450	pate	6.0	servings	servings	9
380	0	pickled carrot and daikon	6.0	servings	servings	10
380	28	1 teaspoon of sesame seed oil	1.0	teaspoon	t	11
380	189	6 sub rolls	6.0	\N	\N	12
380	114	2 1/2 tablespoons sugar	2.5	tablespoons	T	13
380	71	1/4 cup vegetable oil	0.25	cup	c	14
381	151	4 cups baby bok choy leaves	4.0	cups	c	0
381	87	2 tablespoons shredded fresh basil leaves	2.0	tablespoons	T	1
381	50	1 teaspoon brown sugar	1.0	teaspoon	t	2
381	186	2 cardamom pods	2.0	\N	\N	3
381	163	3 tablespoons fish sauce	3.0	tablespoons	T	4
381	51	1 cup fresh bean sprouts	1.0	cup	c	5
381	141	1 (3-inch) piece peeled fresh ginger, thinly sliced	3.0	inch	inch	6
381	23	2 garlic cloves, halved	2.0	cloves	cloves	7
381	274	4 cups fat-free, less-sodium beef broth	4.0	cups	c	8
381	138	4 lime wedges	4.0	wedges	wedges	9
381	268	1 tablespoon less-sodium soy sauce	1.0	tablespoon	T	10
381	152	2 tablespoons shredded fresh mint leaves	2.0	tablespoons	T	11
381	461	2 tablespoons light miso	2.0	tablespoons	T	12
381	187	4 ounces uncooked wide (maifun) thin rice stick noodles	4.0	ounces	oz	13
381	28	1 teaspoon sesame oil	1.0	teaspoon	t	14
381	453	1 (8-ounce) sirloin steak	8.0	ounce	oz	15
381	31	1 cup snow peas, trimmed	1.0	cup	c	16
381	323	1 star anise	1.0	\N	\N	17
381	120	1 inch small fresh Thai chile, thinly sliced into rings (no thai chilies town anywhere!	1.0	inch	inch	18
381	7	1 cup water	1.0	cup	c	19
381	4	1 1/2 cups thinly sliced yellow onion	1.5	cups	c	20
382	87	1 bunch Thai basil or regular basil	1.0	bunch	bunch	0
382	0	5 pounds Beef bones with marrow	5.0	pounds	lb	1
382	453	1 pound Beef sirloin	1.0	pound	lb	2
382	59	2 tablespoons hot chili peppers (optional)	2.0	tablespoons	T	3
382	132	1 teaspoon Hot chili sauce	1.0	teaspoon	t	4
382	92	1 tablespoon Cilantro, chopped	1.0	tablespoon	T	5
382	12	1 Cinnamon stick	1.0	\N	\N	6
382	53	4 mediums daikon cut in 2-inch chunks	4.0	\N	\N	7
382	452	1 pound Flank steak	1.0	pound	lb	8
382	51	2 cups Fresh bean sprouts	2.0	cups	c	9
382	152	1 bunch Fresh mint	1.0	bunch	bunch	10
382	141	2 ounces Piece ginger, unpeeled	2.0	ounces	oz	11
382	138	2 Limes cut in wedges	2.0	\N	\N	12
382	4	2 large Onions, unpeeled, halved, and studded with 8 cloves	2.0	\N	\N	13
382	4	2 mediums Onions, thinly sliced	2.0	\N	\N	14
382	184	5 pounds Oxtails	5.0	pounds	lb	15
382	187	1 pound Rice noodles 1/4-inch wide (or banh pho)	1.0	pound	lb	16
382	280	Black pepper and salt to taste	42.0	servings	servings	17
382	94	2 Scallions, thinly sliced	2.0	\N	\N	18
382	261	3 Shallots, unpeeled	3.0	\N	\N	19
382	323	8 Star anise	8.0	\N	\N	20
382	114	3 tablespoons sugar	3.0	tablespoons	T	21
382	0	1 Tablespoon Nuoc mam (Vietnamese fish sauce)	1.0	Tablespoon	Tablespoon	22
383	30	2 teaspoons hoison sauce	2.0	teaspoons	t	0
383	92	Cilantro for garnish	1.0	serving	serving	1
383	237	1 cucumber, cut into thin, long strips	1.0	\N	\N	2
383	23	2 cloves garlic, minced	2.0	cloves	cloves	3
383	156	1 head of green lettuce, any kind	1.0	head	head	4
383	152	1 bunch mint	1.0	bunch	bunch	5
383	72	1 teaspoon olive oil	1.0	teaspoon	t	6
383	5	1/4 cup organic peanut butter	0.25	cup	c	7
383	76	1 red pepper, cut into thin long strips	1.0	\N	\N	8
383	187	Rice vermicelli noodles	1.0	serving	serving	9
383	502	Rice paper	1.0	serving	serving	10
383	52	1 pound fresh shrimp	1.0	pound	lb	11
383	7	1/4 cup water (more if needed)	0.25	cup	c	12
384	51	some bean sprouts	4.0	servings	servings	0
384	2	carrots (finely julienned)	4.0	servings	servings	1
384	114	2 tablespoons caster sugar	2.0	tablespoons	T	2
384	120	2 red birdeye chilies, sliced	2.0	\N	\N	3
384	163	3 tablespoons fish sauce	3.0	tablespoons	T	4
384	23	2 cloves garlic, minced	2.0	cloves	cloves	5
384	139	2 tablespoons lime juice	2.0	tablespoons	T	6
384	502	4 rice wrappers	4.0	\N	\N	7
384	187	30 grams rice vermicelli	30.0	grams	g	8
384	297	3 tablespoons rice vinegar	3.0	tablespoons	T	9
384	87	some Thai basil	4.0	servings	servings	10
384	52	12 tiger prawns (peeled, deveined)	12.0	\N	\N	11
385	8	1 tbsp double action baking powder	1.0	tbsp	T	0
385	196	1 tbsp. dry yeast	1.0	tbsp	T	1
385	15	400g Pau flour, sifted (or another low protein flour, super fine flour or cake flour)	400.0	g	g	2
385	6	1/2 teaspoon salt	0.5	teaspoon	t	3
385	259	3 tbsp. Shortening	3.0	tbsp	T	4
385	114	1 tablespoon sugar	1.0	tablespoon	T	5
385	7	250g water	250.0	g	g	6
385	211	100g wholemeal flour	100.0	g	g	7
\.


--
-- TOC entry 2050 (class 0 OID 16693)
-- Dependencies: 177
-- Data for Name: Nutritional Content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Nutritional Content" (id, ingredient_id, calories, total_fat_g, saturated_fat_g, cholesterol_mg, sodium_mg, total_carbohydrates_g, dietary_fiber_g, sugar_g, protein_g, vitamin_a_iu, vitamin_c_mg, calcium_mg, iron_mg) FROM STDIN;
1	1	336	1.26	0.331	0	16	60.03	10.6	6.9	23.52	50	1.5	110	8.27
2	2	41	0.24	0.037	0	69	9.58	2.8	4.74	0.93	16706	5.9	33	0.3
3	3	20	0.17	0.058	0	3	4.64	1.7	2.4	0.86	370	80.4	10	0.34
4	4	40	0.1	0.042	0	4	9.34	1.7	4.24	1.1	2	7.4	23	0.21
5	5	598	51.36	10.325	0	426	22.31	5	10.49	22.21	0	0	49	1.74
6	6	0	0	0	0	38758	0	0	0	0	0	0	24	0.33
7	7	0	0	0	0	4	0	0	0	0	0	0	3	0
8	8	53	0	0	0	10600	27.7	0.2	0	0	0	0	5876	11.02
9	9	89	0.33	0.112	0	1	22.84	2.6	12.23	1.09	64	8.7	5	0.26
10	10	717	81.11	50.489	215	11	0.06	0	0.06	0.85	2499	0	24	0.02
11	11	884	100	7.365	0	0	0	0	0	0	0	0	0	0
12	12	247	1.24	0.345	0	10	80.59	53.1	2.17	3.99	295	3.8	1002	8.32
13	13	350	34.44	20.213	101	314	5.52	0	3.76	6.15	1111	0	97	0.11
14	14	143	9.51	3.126	372	142	0.72	0	0.37	12.56	540	0	56	1.75
15	15	364	0.98	0.155	0	2	76.31	2.7	0.27	10.33	0	0	15	4.64
16	16	525	36.31	25.94	0	16	49.29	20.8	2.99	5.84	102	3	184	3.04
17	17	304	0	0	0	4	82.4	0.2	82.12	0.3	0	0.5	6	0.42
18	18	22	0.24	0.04	0	1	6.9	0.3	2.52	0.35	6	38.7	6	0.08
19	19	260	0.06	0.007	0	12	67.04	0	60.46	0.04	0	0	102	0.11
20	20	61	3.25	1.865	10	43	4.8	0	5.05	3.15	162	0	113	0.03
21	21	238	2.15	0.63	0	478	43.91	9.2	5	10.66	4	0	684	4.89
22	22	417	39.69	13.296	66	662	1.28	0	1	12.62	37	0	5	0.41
23	23	149	0.5	0.089	0	17	33.06	2.1	1	6.36	9	31.2	181	1.7
24	24	25	0.1	0.034	0	18	5.8	2.5	3.2	1.28	98	36.6	40	0.47
25	25	61	0.3	0.04	0	20	14.15	1.8	3.9	1.5	1667	12	59	2.1
26	26	475	32.38	9.51	0	80	50.5	20.2	0	6.71	800	21	252	13.9
27	27	77	0.09	0.025	0	6	17.49	2.1	0.82	2.05	2	19.7	12	0.81
28	28	884	100	14.2	0	0	0	0	0	0	0	0	0	0
29	29	16	0.1	0.032	0	39	3.4	1.6	1.86	0.68	7	14.8	25	0.34
30	30	220	3.39	0.568	3	1615	44.08	2.8	27.26	3.31	6	0.4	32	1.01
31	31	42	0.2	0.039	0	4	7.55	2.6	4	2.8	1087	60	43	2.08
32	32	93	0.93	0	0	2124	19.16	2.2	15.11	1.93	2574	26.9	18	1.64
33	33	339	0.9	0.232	0	9	63.25	15.5	2.12	21.25	17	0	160	8.7
34	34	263	8.69	2.55	0	77	72.12	21.6	0	6.09	540	39.2	661	7.06
35	35	91	0.29	0.075	0	384	16.55	6.9	0.23	6.03	4	2.7	35	1.9
36	36	378	6.04	0.603	0	24	62.95	12.2	10.7	20.47	67	4	57	4.31
37	37	88	1.95	0.204	0	278	13.49	4.4	0	4.92	15	0.1	35	1.23
38	38	77	0.4	0.066	0	108	13.62	4.5	5	5.22	2058	18	22	1.53
39	39	61	3.25	2.096	13	46	4.66	0	4.66	3.47	99	0.5	121	0.05
40	40	381	0.05	0.009	0	9	91.27	0.9	0	0.26	0	0	2	0.47
41	41	282	12.89	2.14	0	68	53.99	34.9	10.34	14.14	49254	0.9	229	21.14
42	42	198	12.73	5.335	62	68	0	0	0	19.42	0	0	12	1.99
43	43	36	0.79	0.132	0	56	6.33	3.3	0.85	2.97	8424	133	138	6.2
44	44	292	5.48	1.378	0	452	50.64	26.7	7.27	26.63	1939	125	1140	22.04
45	45	265	4.28	1.551	0	25	68.92	42.5	4.09	9	1701	2.3	1597	36.8
46	46	573	49.67	6.957	0	11	23.45	11.8	0.3	17.73	9	0	975	14.55
47	47	18	0.2	0.028	0	5	3.89	1.2	2.63	0.88	833	13.7	10	0.27
48	48	375	22.27	1.535	0	168	44.24	10.5	2.25	17.81	1270	7.7	931	66.36
49	49	375	22.27	1.535	0	168	44.24	10.5	2.25	17.81	1270	7.7	931	66.36
50	50	380	0	0	0	28	98.09	0	97.02	0.12	0	0	83	0.71
51	51	30	0.18	0.046	0	6	5.94	1.8	4.13	3.04	21	13.2	13	0.91
52	52	71	1.01	0.261	126	566	0.91	0	0	13.61	180	0	54	0.21
53	53	18	0.1	0.03	0	21	4.1	1.6	2.5	0.6	0	22	27	0.4
54	54	34	0.49	0	0	9	6.79	2.5	2.38	2.24	0	0	2	0.41
55	55	22	0.34	0.05	0	5	3.26	1	1.98	3.09	0	2.1	3	0.5
56	56	22	0.35	0.06	0	9	3.87	1.3	2.5	2.11	0	0	3	0.31
57	57	119	1.7	0.521	211	947	1.52	0	0	22.78	301	0	91	0.32
58	58	251	3.26	1.392	0	20	63.95	25.3	0.64	10.39	547	0	443	9.71
59	59	318	17.27	3.26	0	30	56.63	27.2	10.34	12.01	41610	76.4	148	7.8
60	60	296	2.12	0.626	0	5	68.61	26.2	0	10.4	0	21	265	14.31
61	61	318	17.27	3.26	0	30	56.63	27.2	10.34	12.01	41610	76.4	148	7.8
62	62	81	0.4	0.071	0	5	14.45	5.7	5.67	5.42	765	40	25	1.47
63	63	387	6.69	0.693	0	64	57.82	10.8	10.85	22.39	41	0	45	4.86
64	64	50	1.98	1.257	8	47	4.8	0	5.06	3.3	190	0.2	120	0.02
65	65	352	1.06	0.154	0	6	63.35	10.7	2.03	24.63	39	4.5	35	6.51
66	66	358	2.17	0.379	0	7	63.1	10.8	0	23.91	58	1.7	48	7.39
67	67	16	0.25	0.034	0	115	3.47	1.9	2.55	0.79	408	12.6	33	0.57
68	68	32	0.28	0.04	0	186	7.29	1.9	4.4	1.64	215	9.2	34	1.3
69	69	25	0.28	0.13	0	30	4.97	2	1.91	1.92	0	48.2	22	0.42
70	70	82	0.47	0.1	0	59	18.91	4.1	12.18	4.32	1525	21.9	36	2.98
71	71	884	100	14.9	0	0	0	0	0	0	0	0	0	0
72	72	884	100	13.808	0	2	0	0	0	0	0	0	1	0.56
73	73	553	43.85	7.783	0	12	30.19	3.3	5.91	18.22	0	0.5	37	6.68
74	74	53	0.57	0.073	0	5493	4.93	0.8	0.4	8.14	0	0	33	1.45
75	75	40	0.2	0.021	0	7	9.46	1.5	5.1	2	1179	242.5	18	1.2
76	76	31	0.3	0.027	0	4	6.03	2.1	4.2	0.99	3131	127.7	7	0.43
77	77	324	5.81	0.813	0	91	69.86	28.7	41.06	10.58	26488	31.4	45	6.04
78	78	40	0.44	0.042	0	9	8.81	1.5	5.3	1.87	952	143.7	14	1.03
79	79	24	0.3	0.041	0	474	5.31	1.5	3.56	1.2	435	7	14	0.96
80	80	325	14.01	1.648	0	52	55.83	53.2	2.76	14.29	19	0.7	525	19.1
81	81	27	0.21	0.031	0	2	6.32	0.9	0	1	200	183.5	11	0.46
82	82	27	0.21	0.031	0	2	6.32	0.9	0	1	200	183.5	11	0.46
83	83	131	5.86	2.838	0	26	20.7	14.1	0	3.31	2924	21.8	317	6.65
84	84	331	15.22	7.371	0	50	64.06	42.6	0	4.88	3128	61.2	1280	29.25
85	85	101	1.68	0.467	0	9	24.45	14	0	5.56	4751	160.1	405	17.45
86	86	276	7.43	2.73	0	55	63.94	37	1.71	9.11	3800	50	1890	123.6
87	87	23	0.64	0.041	0	4	2.65	1.6	0.3	3.15	5275	18	177	3.17
88	88	233	4.07	2.157	0	76	47.75	37.7	1.71	22.98	744	0.8	2240	89.8
89	89	278	0.07	0.01	0	32	68.86	1.1	48.5	0.37	0	8.8	20	0.49
90	90	119	1.7	0.521	211	947	1.52	0	0	22.78	301	0	91	0.32
91	91	30	0.73	0.146	0	3	4.35	2.5	1.85	3.27	4353	58.1	92	1.6
92	92	23	0.52	0.014	0	46	3.67	2.8	0.87	2.13	6748	27	67	1.77
93	93	279	4.78	0.115	0	211	52.1	10.4	7.27	21.93	5850	566.7	1246	42.46
94	94	32	0.19	0.032	0	16	7.34	2.6	2.33	1.83	997	18.8	72	1.48
95	95	282	14	2.5	0	1640	50	35	7	13	29650	0.6	330	17.28
96	96	282	14	2.5	0	1640	50	35	7	13	29650	0.6	330	17.28
97	97	0	0	0	0	38758	0	0	0	0	0	0	24	0.33
98	98	18	0	0	0	2	0.04	0	0.04	0	0	0	6	0.03
99	99	21	0	0	0	5	0.93	0	0.4	0	0	0	7	0.2
100	100	19	0	0	0	8	0.27	0	0	0.04	0	0.5	6	0.45
101	101	88	0	0	0	23	17.03	0	14.95	0.49	0	0	27	0.72
102	102	198	8.21	1.534	18	416	0	0	0	29.13	77	0	13	1.39
103	103	144	4.9	1.257	38	39	0	0	0	23.33	2183	0	8	1.02
104	104	300	20	10	0	16800	20	0	0	0	200	0	0	0
105	105	5	0.07	0.028	0	296	0.93	0	0.55	0.24	238	0.4	3	0.06
106	106	300	20	10	0	16800	20	0	0	0	200	0	0	0
107	107	30	1.1	0	0	1.1	5.6	3.3	3.3	1.1	800	66	11	0.4
108	108	30	1.1	0	0	1.1	5.6	3.3	3.3	1.1	800	66	11	0.4
109	109	322	26.54	9.551	1085	48	3.59	0	0.56	15.86	1442	0	129	2.73
110	110	340	2.5	0.43	0	2	71.97	10.7	0.41	13.21	9	0	34	3.6
111	111	72	0.52	0.098	0	47	13.47	4	0	3.33	5078	10.4	25	0.95
112	112	32	0.09	0.006	0	1	8.3	0.8	7.5	0.43	38	7.7	15	0.4
113	113	50	0.12	0.009	0	1	13.12	1.4	9.85	0.54	58	47.8	13	0.29
114	114	387	0	0	0	1	99.98	0	99.8	0	0	0	1	0.05
115	115	123	10.39	7.032	35	61	4.73	0	4.13	3.13	354	0.9	107	0.05
116	116	52	0.17	0	0	166	0.73	0	0.71	10.9	0	0	7	0.08
117	117	579	49.93	3.802	0	1	21.55	12.5	4.35	21.15	2	0	269	3.71
118	118	48	1.6	0	0	452	6.5	3.2	1.6	1.6	5000	0	0	2.12
119	119	21	0.27	0.028	0	397	4.6	1.7	0	0.72	126	34.2	36	1.33
120	120	48	1.6	0	0	452	6.5	3.2	1.6	1.6	5000	0	0	2.12
121	121	133	0	0	0	2333	20	6.7	6.7	1	3333	8	133	2.4
122	122	318	17.27	3.26	0	30	56.63	27.2	10.34	12.01	41610	76.4	148	7.8
123	123	133	0	0	0	2333	20	6.7	6.7	1	3333	8	133	2.4
124	124	172	0.63	0.045	0	1027	40.77	0.9	33.24	0.82	224	0.6	33	0.64
125	125	60	0.1	0.011	0	5586	5.57	0.8	1.7	10.51	0	0	20	2.38
126	126	198	19.35	10.14	59	31	4.63	0	3.41	2.44	447	0.9	101	0.07
127	127	135	12	7.47	39	89	4.26	0	0.16	2.94	372	0.9	104	0.07
128	128	70	0.14	0.035	0	18	15.9	1.7	1.29	1.89	7	8.6	10	0.73
129	129	97	0.13	0.032	0	14	21.44	2.3	1.08	2.63	10	8.3	18	1.07
130	130	52	0.17	0.028	0	1	13.81	2.4	10.39	0.26	54	4.6	6	0.12
131	131	58	0.19	0	0	1	13.61	2.8	9.59	0.44	100	0	5	0.15
132	132	11	0.37	0.052	0	2643	1.75	0.3	1.26	0.51	162	74.8	8	0.48
133	133	12	0.76	0.106	0	633	0.8	0.6	0.13	1.29	1640	4.5	12	1.16
134	134	288	0.06	0.01	0	9	12.65	0	12.65	0.06	0	0	11	0.12
135	135	29	0.37	0.092	0	3	6.5	2.8	4.12	0.91	1078	118.6	12	0.25
136	136	22	0.35	0.06	0	9	3.87	1.3	2.5	2.11	0	0	3	0.31
137	137	78	0	0	0	980	19.46	0	10.03	0	79	13	107	5.3
138	138	30	0.2	0.022	0	2	10.54	2.8	1.69	0.7	50	29.1	33	0.6
139	139	25	0.07	0.008	0	2	8.42	0.4	1.69	0.42	50	30	14	0.09
140	140	884	100	9.6	0	0	0	0	0	0	0	0	0	0
141	141	80	0.75	0.203	0	13	17.77	2	1.7	1.82	0	5	16	0.6
142	142	335	4.24	2.599	0	27	71.62	14.1	3.39	8.98	30	0.7	114	19.8
143	143	331	0.73	0.249	0	60	72.73	9	2.43	16.55	0	1.2	79	5.65
144	144	315	12.75	7.03	0	11	60.73	40.3	1.71	10.63	5900	32.4	1652	28.12
145	145	29	0.3	0.039	0	2	9.32	2.8	2.5	1.1	22	53	26	0.6
146	146	47	0.3	0.039	0	6	16	10.6	4.17	1.5	50	129	134	0.8
147	147	748	80.5	29.38	86	2684	0	0	0	5.05	0	0	6	0.44
148	148	12	0.17	0	0	11	2.23	0	0	1.1	263	3.2	29	0.74
149	149	31	0.16	0.021	0	27	7.37	2.1	3.83	1.43	1116	57	45	0.8
150	150	27	0.1	0.013	0	28	6.1	3.1	2.27	2	1000	31	35	0.4
151	151	13	0.2	0.027	0	65	2.18	1	1.18	1.5	4468	45	105	0.8
152	152	44	0.73	0.191	0	30	8.41	6.8	0	3.29	4054	13.3	199	11.87
153	153	285	6.03	1.577	0	344	52.04	29.8	0	19.93	10579	0	1488	87.47
154	154	86	0.05	0.018	0	55	20.12	3	4.18	1.57	14187	2.4	30	0.61
155	155	118	0.17	0.037	0	9	27.88	4.1	0.5	1.53	138	17.1	17	0.54
156	156	13	0.22	0.029	0	5	2.23	1.1	0.94	1.35	3312	3.7	35	1.24
157	157	17	0.3	0.039	0	8	3.29	2.1	1.19	1.23	8710	4	33	0.97
158	158	14	0.14	0.018	0	10	2.97	1.2	1.97	0.9	502	2.8	18	0.41
159	159	300	1	0	0	1.1	0	0	0	3	0.3	121	0.1	2
160	160	32	0.44	0.059	0	10	6.7	3.7	3.83	1.74	937	44.9	11	0.86
161	161	97	5	2.395	13	35	3.98	0	4	9	15	0	100	0
162	162	312	3.25	1.838	0	27	67.14	22.7	3.21	9.68	0	0.7	168	55
163	163	35	0.01	0.003	0	7851	3.64	0	3.64	5.06	12	0.5	43	0.78
164	164	23	0.39	0.063	0	79	3.63	2.2	0.42	2.86	9377	28.1	99	2.71
165	165	29	0.57	0.041	0	74	4.21	2.9	0.65	3.63	11726	5.5	129	1.89
166	166	341	1.04	0.219	0	73	79.12	15.2	6.63	10.41	0	23.4	384	3.9
167	167	345	15.85	0	0	89	51.13	26.8	0	12.35	35760	6.4	97	9.83
168	168	404	33.31	18.867	99	653	3.09	0	0.48	22.87	1242	0	710	0.14
169	169	31	0.22	0.05	0	6	6.97	2.7	3.26	1.83	690	12.2	37	1.03
170	170	58	0.48	0.086	0	185	10.6	3.3	3.2	3.01	1529	7.8	20	1.29
171	171	144	3.57	0.863	86	328	0	0	0	28.04	17	0	13	0.46
172	172	300	22.35	13.152	79	627	2.19	0	1.03	22.17	676	0	505	0.44
173	173	717	81.11	51.368	215	643	0.06	0	0.06	0.85	2499	0	24	0.02
174	174	365	0.66	0.18	0	5	79.95	1.3	0.12	7.13	0	0	28	4.31
175	175	360	0.58	0.158	0	1	79.34	1.4	0	6.61	0	0	9	4.36
176	176	358	0.52	0.14	0	1	79.15	2.8	0	6.5	0	0	3	4.23
177	177	367	3.2	0.591	0	5	76.25	3.6	0.66	7.54	0	0	9	1.29
178	178	362	3.59	0.505	0	35	76.89	7.3	0.64	8.12	214	0	6	3.45
179	179	95	2.82	0.722	58	43	0	0	0	16.38	50	0.7	14	0.3
180	180	290	0.1	0.018	0	37	74.73	0	74.72	0	0	0	205	4.72
181	181	395	5.3	1.203	0	732	71.98	4.5	6.2	13.35	0	0	183	4.83
182	182	266	3.33	0.698	0	490	49.42	2.7	5.67	8.85	1	0	144	3.61
183	183	392	25.83	16.41	68	1376	3.22	0	0.8	35.75	781	0	1184	0.82
184	184	674	70.89	29.45	99	26	0	0	0	8.21	0	0	26	0.72
185	185	400	0	0	0	0	70	8	0	10	0	0	0	0
186	186	311	6.7	0.68	0	18	68.47	28	0	10.76	0	21	383	13.97
187	187	364	0.56	0.153	0	182	80.18	1.6	0.12	5.95	0	0	18	0.7
188	188	130	0.28	0.077	0	1	28.17	0.4	0.05	2.69	0	0	10	1.2
189	189	296	8.7	2.5	0	361	50.7	4.5	4.8	0.01	0	0	98	3.5
191	191	49	0.3	0.035	0	0	11.89	2.5	0	1.04	230	48.5	40	0.09
192	192	49	0.15	0.017	0	1	12.54	2.2	8.5	0.91	247	59.1	43	0.13
193	193	45	0.2	0.024	0	1	10.4	0.2	8.4	0.7	200	50	11	0.2
194	194	239	0.6	0.272	0	28	62.5	5.1	38.8	2.8	30	3.5	74	2.8
196	196	325	7.61	1.001	0	51	41.22	26.9	0	40.44	0	0.3	30	2.17
197	197	258	0	0	0	52	61.5	0.2	0	0	0	0	8	3.72
198	198	105	1.9	0.243	0	30	18.1	8.1	0	8.4	0	0.1	19	3.25
199	199	307	6.4	1.577	50	566	52	3.7	4.3	9.5	26	0	59	3.52
200	200	86	0.96	0.187	30	601	3.57	0	0	14.67	300	0	39	1.62
201	201	142	1.59	0.309	50	112	5.9	0	0	24.25	496	0	65	2.68
202	202	34	0.28	0.146	0	241	8.09	2.9	3.3	1.1	15563	4.2	26	1.39
203	203	86	2.24	0.425	28	286	3.69	0	0	11.9	160	8	26	3.95
204	204	82	1.04	0.227	48	230	2.2	0	0	14.91	150	5	53	5.3
205	205	51	1.71	0.474	40	85	2.72	0	0.62	5.71	44	0	59	4.61
206	206	68	2.47	0.631	55	112	3.91	0	0	7.06	300	5	45	6.7
207	207	428	15.4	3.965	2	1276	63.4	2.1	11.65	8	4	0.3	179	2.77
208	208	275	1.2	0.166	0	536	55.7	2.2	1.3	9.1	0	0	86	2.62
209	209	342	1.33	0.232	0	17	75.87	12.5	0.41	12.29	9	0	35	2.46
210	210	367	1.43	0.34	0	2	77.32	0	0.54	8.89	0	0	20	5.06
211	211	325	2.22	0.269	0	2	68.63	23.8	2.31	15.91	11	0	37	4.97
212	212	366	1.42	0.386	0	0	80.13	2.4	0.12	5.95	0	0	10	0.35
213	213	363	2.78	0.557	0	8	76.48	4.6	0.66	7.23	0	0	11	1.98
214	214	404	9.12	1.607	0	19	65.7	6.5	0.8	14.66	0	0	55	4
215	215	258	2.97	0.426	0	107	55.76	12.3	37.59	14.11	874	39.2	110	9.09
216	216	43	1.12	0.06	0	61	7.02	2.1	0	3.46	7718	85	208	6.59
217	217	253	4.36	0.234	0	208	55.82	13.6	0	19.96	5850	50	1784	48.78
218	218	305	14.54	0.73	0	20	55.17	21.1	0	15.98	53	21	1516	16.33
219	219	262	1.71	0.147	0	527	55.89	6.1	2.87	9.8	6	0	15	3.06
220	220	363	3.69	0.532	0	5	76.59	6.4	1.61	8.46	5	0	138	8.5
221	221	271	3.5	0	0	550	50.1	3.2	3.17	8.8	1	0	78	2.94
222	222	272	2.42	0.529	0	602	51.88	2.2	4.62	10.75	1	0	52	3.91
223	223	298	17.77	0.99	0	35	54.99	41.9	0	12.37	0	21	709	16.32
224	224	0	0	0	0	27360	0	0	0	0	0	0	0	0
225	225	313	8.36	2.28	0	23	74.97	26.3	0	7.61	6185	46.5	834	43
226	226	719	80.5	16.7	0	943	0.9	0	0	0.9	3577	0.2	30	0
227	227	38	0.21	0.029	0	28	8.98	1.9	4.83	1.65	510	10.6	18	1.78
228	228	251	3.26	1.392	0	20	63.95	25.3	0.64	10.39	547	0	443	9.71
229	229	389	0	0	0	2	99.77	0	97.81	0	0	0	1	0.06
230	230	480	30	17.75	0	11	63.9	5.9	54.5	4.2	0	0	32	3.13
231	231	539	32.09	19.412	21	90	59.24	0.2	59	5.87	30	0.5	199	0.24
232	232	295	7.24	1.881	0	62	50.22	7.4	0	22.77	4200	50	1139	32.3
233	233	17	0.32	0.084	0	8	3.11	1	2.5	1.21	200	17.9	16	0.37
234	234	19	0.27	0.093	0	2	3.88	1	2.88	1.01	150	19.3	21	0.44
235	235	40	0.1	0.021	0	3	10.42	1.5	0	0.8	367	11	33	0.7
236	236	34	0.13	0.027	0	4	8.59	1.5	2.2	0.95	1367	12.3	28	0.58
237	237	15	0.11	0.037	0	2	3.63	0.5	1.67	0.65	105	2.8	16	0.28
238	238	25	0.18	0.034	0	2	5.88	3	3.53	0.98	23	2.2	9	0.23
239	239	34	0.37	0.039	0	33	6.64	2.6	1.7	2.82	623	89.2	47	0.73
240	240	22	0.49	0.05	0	33	2.85	2.7	0.38	3.17	2622	20.2	108	2.14
241	241	160	14.66	2.126	0	7	8.53	6.7	0.66	2	146	10	12	0.55
242	242	86	1.35	0.325	0	15	18.7	2	6.26	3.27	187	6.8	2	0.52
243	243	96	1.5	0.197	0	1	20.98	2.4	4.54	3.41	263	5.5	3	0.45
244	244	88	0.78	0.119	0	3	20.71	2.1	2.5	3.02	195	6.4	4	0.42
245	245	72	0.88	0.123	0	345	14.26	2.5	1.82	1.48	1	0	10	0.62
246	246	97	0.38	0.096	0	4	20.32	5	3.23	3.17	791	2.2	128	1.12
247	247	114	0.29	0.074	0	340	21.2	4.8	0.29	7.26	0	0	73	2.99
248	248	81	0.36	0.125	0	256	14.83	4.3	1.85	5.22	0	0.8	29	1.25
249	249	337	1.06	0.154	0	12	61.29	15.2	2.1	22.53	0	4.5	83	6.69
250	250	16	0.17	0.042	0	80	2.97	1.6	1.34	0.69	449	3.1	40	0.2
251	251	20	0.12	0.04	0	2	3.88	2.1	1.88	2.2	756	5.6	24	2.14
252	252	78	4.17	0.793	0	12	2.85	0.9	0.6	9.04	0	0.2	201	1.61
253	253	900	100	12.948	0	0	0	0	0	0	0	0	0	0
254	254	884	100	16.9	0	0	0	0	0	0	0	0	0	0.03
255	255	884	100	10.1	0	0	0	0	0	0	0	0	0	0.03
256	256	884	100	7.541	0	0	0	0	0	0	0	0	0	0
257	257	892	99.06	82.475	0	0	0	0	0	0	0	0	1	0.05
258	258	884	100	11.582	0	0	0	0	0	0	0	0	0	0
259	259	884	100	25	0	0	0	0	0	0	0	0	0	0
260	260	148	7.66	2.024	69	58	0	0	0	19.66	66	0	19	1.09
261	261	72	0.1	0.017	0	12	16.8	3.2	7.87	2.5	4	8	37	1.2
262	262	60	0.38	0.092	0	1	14.98	1.6	13.66	0.82	1082	36.4	11	0.16
263	263	310	5.85	1.586	0	148	65.37	3.9	0	11.43	530	80.8	111	11.1
264	264	61	0.52	0.029	0	3	14.66	3	8.99	1.14	87	92.7	34	0.31
265	265	49	0.93	0.091	0	38	8.75	3.6	2.26	4.28	9990	120	150	1.47
266	266	30	0.76	0.116	0	7	4.67	2.6	0.88	1.2	1720	29.6	105	0.59
267	267	28	0.46	0.059	0	15	4.9	2	0	2.66	6253	39.3	136	0.93
268	268	57	0.3	0.035	0	3598	5.59	0.7	0.5	9.05	0	0	30	1.35
269	269	29	0.17	0.021	0	711	6.64	1.9	4.01	1.52	461	1.9	30	0.42
270	270	38	0.89	0	0	600	6.36	1.9	3.5	1.13	217	12.3	9	0.65
271	271	6	0.21	0.013	2	371	0.44	0	0.43	0.64	2	0	4	0.07
272	272	7	0.22	0.11	0	372	0.04	0	0	1.14	0	0	6	0.17
273	273	16	0.6	0.179	0	30	1.2	0	0.13	2	0	0	4	0.21
274	274	6	0.07	0.042	0	225	0.2	0	0.2	1.14	0	0	3	0.04
275	275	36	1.2	0.321	3	143	3.53	0	1.58	2.52	3	0.2	3	0.21
276	276	13	0.09	0.035	0	198	1.2	0	0.54	1.97	0	0	8	0.27
277	277	16	0.81	0.203	1	156	0	0	0	2.26	6	0.1	3	0.01
278	278	267	13.88	3.43	13	23875	18.01	0	17.36	16.66	2	1.1	187	1.03
279	279	213	8.89	4.32	10	26000	17.4	0	16.71	15.97	0	0	60	1
280	280	125.5	1.63	0.696	0	19389	31.98	12.7	0.32	5.2	274	0	234	5.02
281	281	680	74.85	11.703	42	635	0.57	0	0.57	0.96	65	0	8	0.21
282	282	101	0.1	0.014	0	907	27.4	0.3	21.27	1.04	527	4.1	15	0.35
283	283	60	3.34	0.214	0	1104	5.83	4	0.92	3.74	109	0.3	63	1.61
284	284	508	36.24	1.989	0	13	28.09	12.2	6.79	26.08	31	7.1	266	9.21
285	285	31	0.2	0.09	0	52	7.3	3.1	3.93	1.24	963	12	49	0.73
286	286	345	14.87	0.48	0	88	52.29	39.8	0	15.8	135	21	1196	18.54
287	287	464	40.83	5	29	512	23.33	0.4	15.84	0.87	70	0.2	12	0.29
288	288	876	99.48	61.924	256	2	0	0	0	0.28	3069	0	4	0
289	289	282	23.41	10.19	73	59	0	0	0	16.56	0	0	16	1.55
290	290	274	13	3.952	0	277	65.53	33.9	2.38	5.97	160	0.2	632	11.83
291	291	137	5	2.182	62	66	0	0	0	21.41	14	0	9	2.38
292	292	143	8.1	2.301	86	60	0.04	0	0	17.44	0	0	6	0.82
293	293	263	21.19	7.87	72	56	0	0	0	16.88	7	0.7	14	0.88
294	294	121	4	1.42	59	67	0.21	0	0	21.1	0	0	15	0.86
295	295	525	41.56	4.517	0	26	28.13	19.5	2.99	17.99	0	1	1438	9.76
296	296	140	6.07	2.58	66	81	0.31	0	0	21.13	7	0	12	2.34
297	297	21	0	0	0	5	0.93	0	0.4	0	0	0	7	0.2
298	298	377	0.6	0.432	0	1441	92.9	0	92.9	0	2	0	12	0.01
299	299	378	0.7	0.1	0	1332	95.4	0	0	0	0	0	2	0.08
300	300	177	8.59	1.141	0	242	20.12	4	0.27	4.86	5	7.9	49	1.56
301	301	595	53.76	7.529	0	115	21.19	9.3	0.49	17	67	0	426	8.95
302	302	86	1.35	0.325	0	15	18.7	2	6.26	3.27	187	6.8	2	0.52
303	303	283	0.2	0	0	62	76.79	0	76.77	0	0	0	13	0
304	304	269	0	0	0	58	73.14	0	73.2	0	0	0	13	3.6
305	305	310	0.45	0	0	4	76.37	0.2	68.03	0.09	156	17	1	0.09
306	306	32	0.3	0.015	0	1	7.68	2	4.89	0.67	12	58.8	16	0.41
307	307	52	0.65	0.019	0	1	11.94	6.5	4.42	1.2	33	26.2	25	0.69
308	308	57	0.33	0.028	0	1	14.49	2.4	9.96	0.74	54	9.7	6	0.28
309	309	52	0.65	0	0	1	11.94	6.5	4.42	1.2	33	26.2	25	0.69
310	310	292	30.91	19.337	111	34	2.96	0	2.96	2.17	1013	0.6	69	0.03
311	311	340	36.08	23.032	113	27	2.74	0	2.92	2.84	1470	0.6	66	0.1
312	312	257	22.22	13.831	76	8	12.49	0	8	3.2	685	0	101	0.05
313	313	224	13.1	11.273	2	72	23.6	0	23.6	3	74	0	71	0.1
314	314	455	38.27	14.38	88	1235	1.86	0	0	24.1	0	0	8	1.59
315	315	354	0.41	0.169	0	77	81.17	6.6	3.36	8.34	11	81	27	1.21
316	316	50	1.61	0.218	2	437	7.43	1.8	4.91	1.39	617	2	26	0.73
317	317	231	0	0	0	1	0	0	0	0	0	0	0	0.12
318	318	50	0	0	0	626	6.3	0	1.55	0.5	0	0	9	0.4
319	319	85	0	0	0	4	2.61	0	0.62	0.07	2	0	8	0.46
320	320	82	0	0	0	5	2.6	0	0.96	0.07	0	0	9	0.27
321	321	299	0.46	0.058	0	11	79.18	3.7	59.19	3.07	0	2.3	50	1.88
322	322	302	0.46	0.151	0	12	79.52	4	59.19	3.39	0	3.2	53	1.79
323	323	337	15.9	0.586	0	16	50.02	14.6	0	17.6	311	21	646	36.96
324	324	160	0.28	0.074	0	14	38.06	1.8	1.7	1.36	13	20.6	16	0.27
325	325	333	14.59	0.62	0	17	49.9	38	0.64	19.77	363	21	689	16.23
326	326	74	0.1	0.03	0	40	17.23	4.9	0	2.6	0	44	45	1.16
327	327	174	12.98	8.295	51	84	3.04	0	0.27	11.26	445	0	207	0.38
328	328	138	7.91	4.927	31	99	5.14	0	0.31	11.39	384	0	272	0.44
329	329	387	26.94	17.115	104	1433	3.63	0	0.73	31.8	415	0	1064	0.77
330	330	264	21.28	14.946	89	917	4.09	0	4.09	14.21	422	0	493	0.65
331	331	173	7	4.342	21	873	1.91	0	0.52	24.35	207	0	415	0.42
332	332	410	33.82	19.368	99	644	2.13	0	0.27	24.25	994	0	711	0.16
333	333	271	7.04	0.529	0	77	60.56	40.3	4.09	12.66	8068	51.4	1990	82.71
334	334	373	30.28	19.066	89	600	0.68	0	0.5	24.48	769	0	746	0.72
335	335	254	15.92	10.114	64	619	2.77	0	1.13	24.26	481	0	782	0.22
336	336	30	0.2	0.022	0	2	10.54	2.8	1.69	0.7	50	29.1	33	0.6
337	337	321	8.7	5.486	34	127	54.4	0	54.4	7.91	267	2.6	284	0.19
338	338	134	7.56	4.591	29	106	10.04	0	10.04	6.81	233	1.9	261	0.19
339	339	179	5.1	3.304	35	199	3.4	0	1.33	28.4	152	0	961	0.17
340	340	430	10.6	1.633	0	459	77.66	3.4	24.85	6.69	2	0	77	3.78
341	341	413	32.34	18.913	110	714	0.36	0	0.36	29.81	948	0	1011	0.17
342	342	334	27.68	17.41	100	629	0.45	0	0.45	20.75	592	0	184	0.5
343	343	353	28.74	18.669	75	1146	2.34	0	0.5	21.4	721	0	528	0.31
344	344	364	29.84	20.639	79	415	0.12	0	0.12	21.58	1464	0	298	1.62
345	345	303	22	14.4	80	1499	9.8	0	8.1	16.3	1107	0.2	466	0.18
346	346	34	0.08	0.056	2	42	4.96	0	5.09	3.37	204	0	122	0.03
347	347	15	1.1	0	0	71	0.58	0	0	0.59	142	0	197	0.35
348	348	62	3.31	1.899	11	105	4.88	0	4.88	3.21	165	0	115	0.03
349	349	40	0.88	0.548	4	190	4.79	0	4.79	3.31	47	1	116	0.05
350	350	197	21.33	18.915	0	13	2.81	0	0	2.02	0	1	18	3.3
351	351	83	3.39	2.104	12	60	10.34	0.8	9.54	3.17	98	0.9	112	0.24
352	352	99	0.49	0.119	0	6	25.31	0	0	1.82	6	2.6	65	8.17
353	353	172	9.25	2.66	64	63	0	0	0	20.85	83	0	11	0.74
354	354	120	2.62	0.563	73	45	0	0	0	22.5	30	0	5	0.37
355	355	121	4.12	1.097	94	95	0	0	0	19.66	24	0	7	0.81
356	356	216	14.3	4.8	120	1034	8.1	0	1.9	13.6	0	0	100	4.8
357	357	46	0.13	0.022	0	4	11.3	0.2	9.62	0.1	1	0.9	8	0.12
358	358	368	6.07	0.706	0	5	64.16	7	0	14.12	14	0	47	4.57
359	359	37	0.16	0.027	0	12	8.62	2.3	4.46	1.08	2	25	43	0.44
360	360	65	0.2	0.039	0	26	13.39	1.3	0	4.24	19	1.9	6	2.22
361	361	75	0.3	0.05	0	10	17.99	4.9	4.8	1.2	0	17	36	0.59
362	362	213	14.83	4.24	90	70	0.13	0	0	18.33	771	2.6	11	1.31
363	363	234	13.27	3.7	107	79	0.06	0	0	26.78	636	0.5	15	1.66
364	364	371	1.51	0.277	0	6	74.67	3.2	2.67	13.04	0	0	21	3.3
365	365	371	1.51	0.277	0	6	74.67	3.2	2.67	13.04	0	0	21	3.3
366	366	352	2.93	0.428	0	6	73.37	9.2	2.74	13.87	0	0	29	3.62
367	367	161	9.2	2.459	92	106	0.11	0	0	18.08	46	0	8	0.71
368	368	144	3.57	0.863	86	328	0	0	0	28.04	17	0	13	0.46
369	369	165	3.57	1.01	85	74	0	0	0	31.02	21	0	15	1.04
370	370	116	3.71	0.949	89	114	0	0	0	19.41	22	0	9	0.76
371	371	33	0.19	0.026	0	7	7.45	3.2	1.48	1.93	716	23	82	0.62
372	372	221	16.61	4.524	98	81	0.25	0	0	16.52	78	0	7	0.68
373	373	18	0.2	0.028	0	5	3.89	1.2	2.63	0.88	833	13.7	10	0.27
374	374	18	0.2	0.028	0	5	3.89	1.2	2.63	0.88	833	13.7	10	0.27
375	375	18	0.2	0.028	0	5	3.89	1.2	2.63	0.88	833	13.7	10	0.27
376	376	114	1.65	0.44	58	68	0	0	0	23.2	27	0	12	0.73
377	377	100	1.34	0.285	37	64	0	0	0	20.51	106	1.6	32	0.18
378	378	191	12.85	3.535	111	84	0	0	0	17.52	29	0	11	0.46
379	379	359	3.34	0.528	0	3	76.64	6.6	1.94	8.43	0	0.8	12	3.14
380	380	567	49.24	6.279	0	18	16.13	8.5	4.72	25.8	0	0	92	4.58
381	381	654	65.21	6.126	0	2	13.71	6.7	2.61	15.23	20	1.3	98	2.91
382	382	691	71.97	6.18	0	0	13.86	9.6	3.97	9.17	56	1.1	70	2.53
383	383	599	52.5	8.655	0	320	15.26	9.4	4.18	28.03	0	0.8	61	1.52
384	384	587	49.66	7.723	0	410	21.26	8.4	4.9	24.35	0	0	58	1.58
385	385	32	0.61	0.055	0	17	5.42	4	0.46	3.02	5019	35.3	232	0.47
386	386	38	0.43	0.099	0	47	7.75	3.9	0	2.63	154	5.3	19	0.5
387	387	53	0.34	0.079	0	60	11.95	5.7	0.99	2.89	13	7.4	21	0.61
388	388	47	0.15	0.036	0	94	10.51	5.4	0.99	3.27	13	11.7	44	1.28
389	389	86	0.96	0.187	30	601	3.57	0	0	14.67	300	0	39	1.62
390	390	264	17.9	4.06	588	1500	4	0	0	24.6	905	0	275	11.88
391	391	179	10.43	3.1	50	47	0	0	0	19.93	453	4	26	0.25
392	392	129	4.97	0.862	55	403	0	0	0	19.68	57	0	215	0.64
393	393	117	4.32	0.929	23	672	0	0	0	18.28	87	0	11	0.85
394	394	325	29.63	9.684	61	928	3.72	0	2.05	10.84	27	19.1	24	0.75
395	395	153	0.76	0.112	0	2	33.64	0	0	2.88	138	24.7	12	0.97
396	396	236	17.99	6.24	71	65	0	0	0	17.18	7	0.7	15	1.05
397	397	186	12.36	4.348	62	61	0	0	0	17.42	8	0	16	1.12
398	398	194	12.27	4.27	63	69	0	0	0	19.56	20	0	35	0.66
399	399	134	3.65	1.17	301	87	2.47	0	0	21.39	21650	25.3	9	23.3
400	400	518	53.01	19.33	72	32	0	0	0	9.34	10	0.3	5	0.52
401	401	143	5.84	1.974	59	73	0	0	0	21.22	9	0	30	0.71
402	402	120	3.53	1.181	65	52	0	0	0	20.65	2	0	6	0.97
403	403	143	5.66	1.95	59	52	0	0	0	21.43	7	0.6	17	0.84
404	404	189	11.82	2.37	74	63	0	0	0	19.34	8	0	22	0.85
405	405	223	8.8	3.15	108	70	0	0	0	33.69	0	0	15	2.8
406	406	267	21.59	9.47	72	58	0	0	0	16.88	0	0	12	1.57
407	407	264	21.45	9.28	72	61	0	0	0	16.58	0	0	16	1.5
408	408	134	5.28	1.89	65	65	0	0	0	20.21	0	0	9	1.77
409	409	310	26.63	11.76	74	56	0	0	0	16.32	0	0	15	1.61
410	410	109	2.31	0.71	57	82	0	0	0	20.6	0	0	13	2.83
411	411	628	60.75	4.464	0	0	16.7	9.7	4.34	14.95	20	6.3	114	4.7
412	412	92	1.38	0.358	233	44	3.08	0	0	15.58	33	4.7	32	0.68
413	413	164	2.08	0.453	96	460	4.4	0	0	29.82	300	8	106	9.54
414	414	109	0.63	0	0	17	23.54	7.8	0	4.8	35	41.9	128	1.03
415	415	48	0.69	0.09	0	420	11.29	3.3	7.99	1.18	2	24.9	56	0.42
416	416	35	0.28	0.061	0	48	5.11	0.3	0.49	5.81	5202	39	70	1.8
417	417	0	0	0	0	0	100	0	0	0	0	0	0	0
418	418	291	1.5	0.263	9	572	57.9	1.8	0	9.8	14	0	47	3.36
419	419	384	4.44	1.18	84	21	71.27	3.3	1.88	14.16	62	0	35	4.01
420	420	475	15.43	2.229	0	1174	72.8	3.7	5.71	8.11	0	0	20	4.73
421	421	158	0.93	0.176	0	1	30.86	1.8	0.56	5.8	0	0	7	1.28
422	422	138	2.07	0.419	29	5	25.16	1.2	0.4	4.54	21	0	12	1.47
423	423	336	0.71	0.136	0	792	74.62	0	0	14.38	0	0	35	2.7
424	424	371	1.51	0.277	0	6	74.67	3.2	2.67	13.04	0	0	21	3.3
425	425	521	31.72	4.931	0	378	51.9	1.9	0.25	10.33	1	0	21	1.76
426	426	371	1.51	0.277	0	6	74.67	3.2	2.67	13.04	0	0	21	3.3
427	427	351	0.06	0.017	0	10	86.09	0.5	0	0.16	0	0	25	2.17
428	428	297	7.58	1.225	0	742	49.27	2.4	2.66	8.01	0	0	163	3.32
429	429	218	2.85	0.453	0	45	44.64	6.3	0.88	5.7	2	0	81	1.23
430	430	472	20.68	2.811	0	328	67.78	5.4	0.78	7.1	4	0	106	1.52
431	431	43	0.3	0.062	0	25	8.95	3.8	2.2	3.38	754	85	42	1.4
432	432	673	68.37	4.899	0	2	13.08	3.7	3.59	13.69	29	0.8	16	5.53
433	433	63	1.55	1	6	70	7.04	0	7.04	5.25	51	0.8	183	0.08
434	434	198	19.35	10.14	59	31	4.63	0	3.41	2.44	447	0.9	101	0.07
435	435	315	7.35	4.534	29	129	55.35	0	49.74	6.84	267	2.6	251	0.17
436	436	614	55.5	4.152	0	7	18.82	10.3	4.43	20.96	1	0	347	3.49
437	437	379	6.52	1.11	0	6	67.7	10.1	0.99	13.15	0	0	52	4.25
438	438	28	0.1	0.011	0	67	6.43	1.8	3.8	0.9	0	21	30	0.3
439	439	185	13.77	3.681	884	146	1.45	0	0.93	12.81	674	0	64	3.85
440	440	46	0.28	0.017	0	0	11.42	1.4	9.92	0.7	345	9.5	6	0.17
441	441	504	46.28	17.708	97	1582	1.18	0	0	19.25	0	0	19	1.33
442	442	335	3.1	0.677	0	11	70.59	10	2.6	12.62	0	0	41	4.06
443	443	309	28.23	9.313	61	827	0.94	0	0.94	11.98	0	0	11	0.59
444	444	551	38.1	9.643	0	249	45.1	1.5	0.74	7.3	1	0	10	2.56
445	445	299	6	1.47	0	483	52.6	1.9	0.18	7.1	0	0	11	3.21
446	446	457	26.07	8.159	0	409	48.62	2.5	3.72	6.16	1	0	19	2.6
447	447	155	7.37	2.59	62	79	0	0	0	20.72	0	0	5	1.92
448	448	198	14.9	4.73	54	1217	0.14	0	0	14.68	0	27	7	1.69
449	449	354	0.97	0.154	0	1193	74.22	2.7	0.22	9.89	0	0	338	4.67
450	450	462	43.84	14.45	150	697	4.67	0	0	11.4	3333	2	70	5.5
451	451	590	52.52	3.953	0	19	18.67	9.9	4.63	21.4	7	0	236	3.28
452	452	165	8.29	3.443	68	54	0	0	0	21.22	0	0	27	1.55
453	453	201	12.71	5.127	75	52	0	0	0	20.3	0	0	24	1.48
454	454	71	0.59	0	0	12	15.29	2.4	0	1.18	0	4.8	0	0.36
455	455	211	8.91	3.525	93	57	0	0	0	30.5	22	0	13	3.24
456	456	0	0	0	0	31818	0	0	0	0	0	0	0	0
457	457	0	0	0	0	0	0	0	0	0	0	0	0	0
458	458	222	0	0	0	80	54.5	0	0	0.1	0	0	0	0
459	459	19	0.14	0.034	0	661	4.28	2.9	1.78	0.91	18	14.7	30	1.47
460	460	43	0	0	0	4	3.55	0	0	0.46	0	0	4	0.02
461	461	198	6.01	1.025	0	3728	25.37	5.4	6.2	12.79	87	0	57	2.49
462	462	12	0	0	0	4	4	1	0	0	0	0	30	0.36
463	463	0	0	0	0	0	0	0	0	0	0	0	0	0
464	464	309	28.23	9.313	61	827	0.94	0	0.94	11.98	0	0	11	0.59
465	465	0	0	0	0	0	0	0	0	0	0	0	0	0
466	466	76	7.58	0	0	909	3.79	0	0	0	400	0	80	1.44
467	467	51	0.25	0.043	0	2733	10.92	0.3	0	1.35	0	0.1	32	0.18
468	468	115	10.68	1.415	0	735	6.26	3.2	0	0.84	403	0.9	88	3.3
469	469	296	0	0	0	25	31.69	0	31.69	0	0	0	0	0
470	470	579	49.93	3.802	0	1	21.55	12.5	4.35	21.15	2	0	269	3.71
471	471	117	8.33	3.33	17	183	6.67	0.67	0	3.33	0	0	70	0
472	472	220	2	0	0	2040	44	0	44	6	400	4.8	40	2.16
473	473	63	0.2	0.038	0	0	16.01	2.1	12.82	1.06	64	7	13	0.36
474	474	29	0.37	0.092	0	3	6.5	2.8	4.12	0.91	1078	118.6	12	0.25
475	475	39	0.25	0.019	0	0	9.54	1.5	8.39	0.91	326	6.6	6	0.25
476	476	97	0.2	0.024	0	3	25	10.6	0	1.5	420	136	161	0.8
477	477	42	0.1	0.008	0	2	11.27	1.1	9.39	0.17	29	1	4	0.23
478	478	43	0.56	0.247	0	233	9.57	1.3	0.6	1.68	116	3	168	2.85
479	479	660	64.53	57.218	0	37	23.65	16.3	7.35	6.88	0	1.5	26	3.32
480	480	318	28.27	17.67	88	106	3.53	0	0	21.2	1050	0	710	0
481	481	15	0.5	0.067	0	498	2.4	1.6	1.06	1.1	93	0	33	2.5
482	482	0	0	0	0	35000	0	0	0	0	0	0	0	0
483	483	541	32.43	10.811	0	41	56.78	2.7	56.76	5.41	0	0	110	1.98
484	484	0	0	0	0	26667	0	0	0	0	0	0	0	0
485	485	32	1.02	0.139	0	1	5.84	1.9	3.93	0.96	114	11.7	7	0.62
486	486	250	0	0	0	0	0.1	0	0.1	0	0	0	0	0.02
487	487	327	12.97	8.108	0	0	24.87	0	20	2.97	0	0	0	0
488	488	410	6.4	2.03	258	281	82.8	0	0	6.9	217	0.4	228	1.93
489	489	209	6.31	2.25	90	45	0	0	0	35.62	0	0	4	3.27
490	490	112	0.2	0.041	0	11	26.46	4.1	0.4	1.5	76	4.5	43	0.55
491	491	38	0.09	0.021	0	4	8.82	4.9	1.8	0.72	21	20.2	12	0.6
492	492	53	0.31	0.039	0	2	13.34	1.8	10.58	0.81	681	26.7	37	0.15
493	493	21	0.2	0.053	0	4	4.54	1.8	1.1	0.9	102	8	86	0.22
494	494	100	0	0	0	0	25	0	0	0	0	0	0	0
495	495	0	0	0	0	0	0	0	0	0	0	0	0	0
496	496	77	0.95	0.159	114	58	0	0	0	15.97	53	1.2	27	0.84
497	497	87	1.08	0.222	78	293	0.04	0	0	18.06	5	3	89	0.74
498	498	92	1.02	0.233	37	53	0	0	0	19.38	143	0	27	0.89
499	499	96	1.7	0.585	50	52	0	0	0	20.08	0	0	10	0.56
500	500	91	1.33	0.292	49	68	0	0	0	18.56	67	0	7	0.16
501	501	279	3.91	0.842	0	494	50.12	1.8	7.28	9.77	107	1.3	144	3.43
502	502	336	0.4	0.4	0	196	84	0	2	0	0	0	0	2.16
503	503	353	0	0	0	1000	76.47	0	2.94	5.88	0	0	60	0
504	504	205	10.06	3.85	85	76	0	0	0	26.66	0	0	11	2.83
505	505	100	0	0	0	33	20	0	0	3.33	0	7.8	0	3.6
506	506	0	0	0	0	0	0	0	0	0	0	0	0	0
507	507	0	0	0	0	31667	0	0	0	0	0	0	0	0
508	508	135	15	3	0	0	0	0	0	0	0	0	0	0
509	509	0	0	0	0	11429	0	0	0	0	0	0	0	0
510	510	231	0	0	0	1	0	0	0	0	0	0	0	0.01
511	511	116	0	0	0	0	1	0	0	0	0	0	0	0
512	512	224	0	0	0	0	0	0	0	0	0	0	0	0
513	513	598	42.63	24.489	3	20	45.9	10.9	23.99	7.79	39	0	73	11.9
514	514	11	0	0	0	46	2.11	0.7	0	0.7	4600	21	40	1.98
\.


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 176
-- Name: Nutritional Content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Nutritional Content_id_seq"', 515, FALSE);

--
-- TOC entry 2048 (class 0 OID 16682)
-- Dependencies: 175
-- Data for Name: Recipe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Recipe" (id, title, image_uri, instructions, cuisine, ready_in_minutes, servings, vegetarian, vegan, gluten_free, dairy_free) FROM STDIN;
1	African Bean Soup	https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg	<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>	african	45	4	t	t	t	t
2	Ethiopian Lentil Curry	https://spoonacular.com/recipeImages/Ethiopian-Lentil-Curry-642468.jpg	<ol><li>In a large pot heat oil over medium heat. Add onions and saut until translucent. Add minced garlic and continue to saut for another minute.</li><li>Combine cauliflower, peas and lentils in the pot, sprinkle with amchar massala and massala molida and saut for 5 minutes.</li><li>Pour crushed tomatoes and tomato paste into the pot and stir to combine. Add about two cups of water and bring curry to a boil.</li><li>Reduce heat, cover, and simmer on low until lentils are tender; about an hour.</li><li>Mix in plain yogurt and serve immediately.</li></ol>	african	75	6	t	f	t	f
3	North African Chickpea Soup	https://spoonacular.com/recipeImages/North-African-Chickpea-Soup-653275.jpg	<ol><li>In a large soup pot add the oil, onions and celery.  Cook over medium low heat until translucent.  Add the garlic and saute until fragrant.   Add the tomato paste and harissa.  Cook a minute then add the water or stock slowly while stirring to combine the flavor paste in the pot with the liquids.  Throw in the chickpeas and bring to a boil.  As soon as it reaches a boil, reduce heat to a simmer.</li><li>Add the pasta and cook according to the package directions.  My suggestion is that if you are using fresh pasta, give it a rinse under tap water to remove the starch before adding it to the soup.  It might make the broth cloudy.  If using rice noodles add them right before serving to prevent overcooked mushy noodles.  To cook rice noodles place them in a shallow dish and cover with hot water for 10-15 minutes to soften.</li><li>Just before serving taste for seasoning, adjust to your taste.  Adding too much salt earlier on could make things too salty because some of the ingredients can bring a lot of salt to the pot.  Then add the spinach, it will only take a minute to shrink into nearly nothing, but it is sure a powerhouse vegetable that amps up the nutrition in this meal quickly and without fuss.  A squeeze of fresh lemon juice after it has been taken off the heat will add a nice bright flavor to perk up those dreary dark days of winter.  Enjoy with some crusty bread.  A meal you can feel good about, filling yet light.</li></ol>	african	45	4	t	t	f	t
4	African Chicken Peanut Stew	https://spoonacular.com/recipeImages/african-chicken-peanut-stew-716268.jpg	Season and Boil the Chicken for 10 minutes with salt, pepper, seasoning, a handful of onions.Once the chicken is ready, in the same stock, Boil the chopped sweet potatoes till its almost cooked. Save the stock in a separate Bowl and the chicken and potatoes in a separate Bowl as well.In a pot, heat up one cooking spoon of oil and fry the chicken till it Browns. Take it out and heat up the other 1.5 cooking spoons of oil and fry the onions, tomatoes Both chopped and Blended, ginger and garlic.Add your seasoning, curry, thyme, parsley, salt and pepper to the pot.Pour in your stock, chicken and potatoes to cook further.Stir in your peanut Butter and allow to cook for 10 minutes on low heat.If your sauce gets too thick, add a little water to it. Serve with white rice or more sweet potatoes.You could also garnish the dish with Bell peppers.   	african	45	1	f	f	t	t
5	Party Jollof Rice	https://spoonacular.com/recipeImages/how-to-make-party-jollof-rice-716298.jpg	Wash rice by rubbing the rice between your palms in a bowl of water and draining the water till clear. Blend tomatoes, pepper and garlic and bring to boil till the excess water dries up. Chop Onions. Heat up vegetable oil and pour in chopped onions and fry. Pour in the can of tomato puree and fry.Pour in blended tomato and pepper mix into the pot and stir in. Pour in salt, dry pepper, curry, thyme, bay leaves and maggi cubes. Allow it to simmer on low heat for 3 minutes. Reduce the heat to the lowest level and pour in the washed rice. Pour in the water and stir and leave on low heat for 20 minutes or till the rice is soft. Tip: To get the party rice flavor, increase the heat on the rice and burn the bottom of the pot with the pot covered and stir the rice after 3 minutes of burning. Stir the rice and serve with any protein of your choice.	african	45	3	t	t	t	t
6	Pineapple Jollof Rice	https://spoonacular.com/recipeImages/pineapple-jollof-rice-716374.jpg	Heat up your oil, stir fry your pineapples and chopped vegetables for 30 seconds and take out of the oil. In the same oil, toss in your chopped onions, garlic and ginger and fry about a minute or two on medium heat.Stir in your tomato paste and fry for 2-3 minutes on medium heat. Pour in your blended tomato, pepper mix and stir. Season with seasoning cubes, curry, thyme and any other seasoning of your choice. Stir in your rice and reduce the heat to the lowest and allow to steam. Pour in your stock juice so it would cook the rice for the next 20-25 minutes on low heat. Constantly check to make sure the rice is soft and when it is, increase the heat and stir.Toss in the already sautéed pineapple and chopped vegetables and stir in. Serve with any protein of your choice. 	african	45	2	t	t	t	t
7	Banana & Cream Cheese Stuffed French Toast	https://spoonacular.com/recipeImages/Banana---Cream-Cheese-Stuffed-French-Toast-633971.jpg	<ol><li>In a small bowl combine the softened cream cheese, honey, cinnamon, nutmeg and lemon juice, set aside while preparing the batter.</li><li>Whisk together all of the batter ingredients until thoroughly mixed. (This is a breeze if you use a blender.) Pour the batter into a wide, shallow dish (like a pie plate).</li><li>Spread the filling mixture equally over 1 side of each slice of bread, divide the sliced bananas between 4 slices of the bread, top with the remaining 4 slices, press lightly.</li><li>Melt 2 t. butter and 2 t. oil in a 12 inch nonstick skillet over medium heat until the butter foams and then subsides. Working with one sandwich at a time dip both sides in the batter and let the excess drip away, add to the hot pan, repeat with a second sandwich. Cook until golden brown on the first side, around 3-5 minutes, flip and repeat on the second side. Repeat this process with the remaining, oil, butter and sandwiches. To serve, cut into triangles and serve with maple syrup.</li></ol>	american	45	4	t	f	f	f
8	Banana Chocolate Chip Cake With Peanut Butter Frosting	https://spoonacular.com/recipeImages/Banana-Chocolate-Chip-Cake-With-Peanut-Butter-Frosting---gluten-free--dairy-free--soy-free-634040.jpg	<ol><li>Preheat Oven Temperature to 350 degrees F</li><li>For the Cake:</li><li>Line the bottom of the round cake pans with parchment paper (I use precut ones sold at baking stores), grease cake pans, also under parchment paper. Set aside.</li><li>In a medium bowl, whisk flours, baking soda, and salt. Set aside.</li><li>Using an electric mixer or a stand mixer with a paddle attachment on medium high speed, beat sugar, Earth balance, and brown sugar until light and fluffy, about 3 minutes.</li><li>Add eggs one at a time, beating to blend after each egg, then add vanilla.</li><li>Add dry ingredients.</li><li>Mix on low speed, just to blend.</li><li>Add mashed bananas and sour cream; mix until just blended.</li><li>Fold in chocolate chips.</li><li>Divide the batter evenly among the two cake pans. Smooth tops.</li><li>Bake cakes for 35-45 minutes, until toothpick inserted in the center comes out clean.</li><li>Transfer to wire racks.</li><li>Let it cool in the pans for 15-30 minutes.</li><li>Invert cakes onto the wire racks; peel off parchment paper and let it cool completely, about an hour, before frosting.</li><li>For the Frosting:</li><li>Using an electric mixer, or a stand mixer with a paddle attachment, beat peanut butter, powdered sugar, Earth balance, and vanilla extract until light and fluffy, about 4 minutes.</li><li>Place 1 cake on a platter.</li><li>Spread 1 1/4 cups of frosting for the inner layer.</li><li>Place the other cake on top.</li><li>Frost the top and sides with remaining frosting.</li><li>Pipe along the bottom edge with a star tip.</li><li>Chill frosted cake for 2-3 hours to set.</li><li>Garnish with chocolate chips.</li><li>Serve chilled or room temperature. Chilled will result in a firm peanut butter frosting.</li><li>Note: For mess free decorating, put two halved sheets of parchment paper (cut apart) next to each other on the cake platter before putting the cake on it.</li><li>Slowly pull out from opposite ends of the cake when done piping.</li></ol>	american	45	8	f	f	t	f
9	Barbecue Pizza	https://spoonacular.com/recipeImages/Barbecue-Pizza-634274.jpg	<ol><li>Preheat oven to 400 degrees. Place pizza crust on a baking sheet. Evenly spread pizza sauce on crust. Top with cheese. In a separate bowl mix barbecue meat and sauce. Spread barbecue mixture on toip of cheese. Top with onion rings, as desired. Bake in oven for 10-12 minutes until cheese bubbles.</li></ol>	american	45	1	f	f	f	f
10	BBQ Chicken Pizza	https://spoonacular.com/recipeImages/Bbq-Chicken-Pizza-634485.jpg	<ol><li>Dissolve sugar in water; add yeast and oil.</li><li>In a separate bowl, combine flours.</li><li>Allow to sit until the yeast foams slightly (about 3 minutes).</li><li>Combine 2  cups of the flour and salt in a food processor. Pulse once or twice. Pour the yeast mixture.</li><li>Process the mixture, gradually adding enough of the remaining flour mixture so that the dough is no longer sticky. Remove from the processor; continue kneading until the dough is smooth and elastic (another 1015 minutes by hand).</li><li>Shape dough into a ball and put in an large oiled bowl, turning the dough to coat it with the oil.</li><li>Allow to rise until doubled in size (45 minutes to 1 hours).</li><li>Punch down the dough and divide into 2 pieces. This will make two 12 inch pizzas.</li><li>Shape each portion into a 12" circle either by hand or with a rolling pin, stretching out as necessary to achieve a thin dough. For a lighter crust, let the dough sit for a half hour after shaping before constructing pizza and baking.</li><li>Spread BBQ sauce over crust and top with chicken, cheese and desired toppings. (I used caramelized onions, roasted red peppers and chopped parsley)</li><li>Allow to rest in a warm location for 15 minutes.</li><li>Bake in a 475 degree oven until crust is golden, about 20 minutes.</li></ol>	american	45	1	f	f	f	f
11	BBQ Pork Steak	https://spoonacular.com/recipeImages/Bbq-Pork-Steak-634509.jpg	<ol><li>Marinate pork steak for 24 hours in meat marinate mix and Italian dressing. Remove from marinate and brown on grill for about 20 minutes. After preparing barbeque sauce, use liberally on grilling pork steak.</li><li>Sauce preparation: Mix sauce in small saucepan and cook to blend. Add corn syrup to taste.</li></ol>	american	45	2	f	f	t	t
12	Beer Braised Brisket with Ding Dang Good Sauce	https://spoonacular.com/recipeImages/Beer-Braised-Brisket-with-Ding-Dang-Good-Sauce-634751.jpg	<ol><li>In a food processor or blender, finely chop garlic. Add brown sugar, honey, mustard, ancho chili in adobo, mustard, oil, black pepper, cumin, paprika, cayenne and 2 tbs salt and process until smooth. Rub all over the brisket making sure to get into the nooks and crannies. Place brisket in a gallon size freezer bag  or if unable to fit into bag  wrap well with plastic wrap and put in the refrigerator x 1-2 days.</li><li>Allow brisket to come to room temp ( about an hour) before preparing. Preheat oven to 325. Separate and scatter onions in a large baking dish or roasting pan. Set brisket (fat side up) on top of the onions. Add beer to pan and any marinade the clings to the plastic wrap. Cover and seal with foil tightly. Braise in the oven until the meat is fall apart tender  about 5 hours. Begin to check after 4 hours. Meat should literally be falling apart when you stick it with a fork. When done, set oven to broil and broil for 5-10 minutes until top develops a crispy crust.</li><li>Allow brisket to cool for at least 10 minutes, remove from the pan and shred or slice. Remove the onions with a slotted spoon and mix into the brisket. Moisten with pan drippings and season with salt if needed.</li><li>For the Sauce</li><li>In a medium sauce pan over medium heat, add the pan drippings or olive oil and saut the onions until soft  5-7 minutes. Add the garlic and cook one minute longer,. Add the beer, bring to a boil and cook until reduced by half  about 10 minutes or so.</li><li>Add in the remaining ingredients and heat through.</li><li>Place sauce in a food processor or blender and puree until smooth. Can use immediately or can be refrigerated until ready to use.</li></ol>	american	45	8	f	f	t	t
13	Carolina Caviar - Black Bean Salsa	https://spoonacular.com/recipeImages/Carolina-Caviar---Black-Bean-Salsa-637157.jpg	<ol><li>Add all ingredients together in a large bowl; tasting and adjusting as you go!</li><li>Chill in the refrigerator overnight.</li><li>Adjust seasoning to preference levels after the salsa sets overnight and the flavors blend/marry.</li><li>Serve with tortilla chips.</li></ol>	american	45	4	t	t	t	t
14	Chile Underground's Texas Caviar	https://spoonacular.com/recipeImages/Chile-Undergrounds-Texas-Caviar-638533.jpg	<ol><li>Heat the oil in a large skillet over medium-high heat</li><li>Add onion and cook for just a minute or two with stirring</li><li>Add bell pepper and stir for another minute</li><li>Add minced chilies and tomatoes and stir for only a couple of minutes, to slightly soften the tomatoes</li><li>Add the garlic and stir for 30 seconds or so</li><li>Transfer skillet contents to a large mixing bowl</li><li>Combine in the peas, beans and corn</li><li>Stir in the sliced scallions; set aside</li><li>In a small mixing bowl, combine remaining ingredients and whisk until smooth</li><li>Pour sauce over the Caviar</li><li>Take most of the cilantro leaves and mince them</li><li>Add minced cilantro to the Caviar</li><li>Refrigerate for at least 2 hours.</li><li>Garnish with remaining cilantro leaves</li><li>Serve with hearty corn chips (no wimpy chips allowed!)</li></ol>	american	180	8	t	t	t	t
15	Chili Pie with Green Chile and Cheddar Cornbread Crust	https://spoonacular.com/recipeImages/Chili-Pie-with-Green-Chile-and-Cheddar-Cornbread-Crust-638568.jpg	<ol><li>In a large skillet saute onion in oil until soft and translucent, seasoning with salt and pepper. Add garlic and saute until fragrant. Remove 2/3 of the mixture from pan and set aside. Add green chilies with their juices and saute for 2-3 minutes. Remove and set aside in a separate bowl.</li><li>In the same skillet brown ground beef, crumbling it as it cooks. When cooked through carefully drain grease. Add the onion mixture, Chile powder, Worcestershire, oregano, paprika, cinnamon, nutmeg, red pepper and water. Mix thoroughly and continue cooking over medium-low heat as you add the tomatoes with juices, the beans and corn. Mix well and cook for 3-4 minutes.</li><li>Preheat oven to 400 degrees and grease a 9x13 inch casserole dish. Pour the meat mixture in and spread evenly over bottom. Sprinkle two cups of the cheese over top.</li><li>In a large bowl combine the flour, cornmeal, baking powder and salt.</li><li>In a separate medium bowl whisk the eggs, milk, butter and sour cream. Add this mixture to the dry mix and stir together.</li><li>Add the onion/green chile mixture and the remaining cup of cheese. Stir in. Pour over top of the meat mixture. Spread evenly. Sprinkle Chile powder over top.</li><li>Bake 25-30 minutes or until a toothpick comes clean from center of cornbread. Let set for 10 minutes before serving.</li></ol>	american	45	8	f	f	f	f
16	Coffee-Infused BBQ Baby Back Ribs	https://spoonacular.com/recipeImages/Coffee-Infused-Bbq-Baby-Back-Ribs-639893.jpg	<ol><li>Preheat the oven to 350 degrees. Mix the first seven ingredients in a small bowl.</li><li>Cut each rack in several pieces and rub the spices over all the rib sections. You can leave the ribs whole if you like the way they look better--I just think they are easier to handle on the grill in smaller pieces! Pour 4 cups of water and 1 tsp. of liquid smoke in a roasting pan.</li><li>Place the ribs in the pan, top up. Tightly cover the pan with foil and bake for 2 hours. Remove from the oven and rest until ready to grill. Meanwhile, add 1 Tb. oil to a sauce pan over medium heat. Add the garlic and saut for 1-2 minutes. Then add the rest of the ingredients for the BBQ sauce to the sauce pan. Simmer for at least 30 minutes, stirring occasionally.</li><li>Heat a grill over medium-low heat. Brush the ribs completely with BBQ sauce. Place them on the grill and cook for 20 minutes, turning and brushing every 5 minutes until the desired bark has developed.</li><li>It's fun to make your own BBQ sauce. But in a pinch, buy a bottled variety you like and simmer for a few minutes with the coffee granules!</li></ol>	american	45	6	f	f	t	t
17	Dulce De Leche Brownies	https://spoonacular.com/recipeImages/Dulce-De-Leche-Brownies-641726.jpg	<ol><li>Preheat the oven to 350 degrees.</li><li>Grease a 13x9 baking dish.</li><li>In a saucepan melt butter and 1 cup semi-sweet chocolate, stirring constantly over very low heat until the chocolate is melted. Stir in eggs one at a time, then stir in the sugar, vanilla, espresso powder, baking soda, and flour.</li><li>Stir in remaining chocolate chips.</li><li>Pour the batter into baking dish.</li><li>Use a knife or spatula to swirl the Dulce de Leche creating a marbled effect.</li><li>Bake for 35 to 45 minutes. The brownies center will be slightly firm when they are done. Remove from the oven and allow cool completely.</li></ol>	american	45	24	f	f	f	f
18	Fresh corn, roasted tomato & pickled garlic pizza with cornmeal crust	https://spoonacular.com/recipeImages/fresh-corn--roasted-tomato---pickled-garlic-pizza-with-cornmeal-crust-643471.jpg	<ol><li>roasted tomatoes recipe</li><li>preheat oven to 275 degrees.</li><li>line a rimmed baking sheet with parchment paper.</li><li>place tomatoes, cut side up, on top of paper.</li><li>drizzle honey over tomatoes.</li><li>sprinkle garlic and a pinch each salt and pepper over honey.  drizzle olive oil over tomatoes (2 passes of bottle).</li><li>place in preheated oven and roast for 3 hours.</li><li>remove from oven, scrape tomatoes and all juices into small bowl.</li><li>drizzle additional olive oil over tomatoes.</li><li>cover with saran wrap. store in refrigerator for up to 1 week.</li><li>cornmeal crust recipe</li><li>add water to bowl of upright mixer and sprinkle yeast over top.</li><li>using the paddle attachment, mix until yeast has dissolved.</li><li>add salt, olive oil and honey and mix to combine.</li><li>add  flour and process just until incorporated.</li><li>add the cornmeal and process until incorporated.</li><li>process an additional minute until the dough has formed into a ball. do not over mix.</li><li>remove dough from bowl, form into 4 smooth balls of equal size and place in an oiled bowl.</li><li>turn balls a few times to ensure they are totally covered in oil, cover bowl with saran wrap and place in a warm area. allow to rise until doubled in size  45 minutes to 1 hour.</li><li>remove from bowl and place on a lightly floured counter.</li><li>use a rolling pin to roll out dough into free form circles. each pizza crust should be about 1/2 inch thick.</li><li>place on pizza stone or baking sheet which has been lightly oiled with extra-virgin olive oil and sprinkled with coarse cornmeal. (the cornmeal adds a delicious flavor and helps ensure the pizza dough will not stick to pan.)</li><li>pizza assembly and recipe</li><li>preheat oven to 500 degrees.</li><li>drizzle pizza rounds with olive oil and lightly sprinkle with coarse grey salt.</li><li>sprinkle corn kernels, pickled garlic, marinated tomatoes and mozzarella over pizza....customize the amount of each topping to your liking.</li><li>drizzle oil over pizza, including the "naked" crust edges. use a pastry brush to cover the naked crust with oil.</li><li>place in preheated oven.</li><li>bake for 10-12 minutes or until crust is golden brown and cheese is bubbling.</li><li>remove from oven and sprinkle red pepper flakes and basil over top. slice and serve immediately</li></ol>	american	45	4	t	f	f	f
19	Salmon Caesar Salad	https://spoonacular.com/recipeImages/Healthy-Salmon-Caesar-Salad-646512.jpg	<ol><li>Directions: Heat up a skillet/frying pan and sir the Salmon in the coconut oil/olive oil (don't forget to add the salt and paprika to it) until very lightly browned on each side (i like my salmon slightly undercooked-its up to you if you want it more done). Top with freshly squeezed lemon juice and let it sit in the frying pan for about 1 minute. In a Large bowl, mix the romaine lettuce with the Caesar salad dressing and dump it out into a large plate, top off with Asiago/Parmesan cheese and you can also sprinkle the toasted almonds on now. Place the Salmon (sliced) on top. You can sprinkle it with some more fresh lemon juice:) and black pepper!</li></ol>	american	45	2	f	f	t	f
20	Hummus & Ham Tortilla	https://spoonacular.com/recipeImages/Hummus---Ham-Tortilla-647623.jpg	<ol><li>Combine all of the ingredients for the hummus in the food processor. Process the chick peas until smooth.</li><li>Grill the sliced onion on a heated griddle and set aside for the tortilla.</li><li>Heat a griddle and place the tortilla on the heated griddle. Top the heated tortilla with the shredded cheese first, then the ham, followed by the hummus and finally the grilled onions.</li></ol>	american	45	1	f	f	t	f
21	Jade's New York Style Pizza	https://spoonacular.com/recipeImages/Jades-New-York-Style-Pizza-648321.jpg	<ol><li>Prepare your toppings to taste.</li><li>The sauce:</li><li>Saute the onions and garlic in olive oil until soft.   Add the tomatoes, wine, herbs, salt and sugar. Bring to a boil, lower heat and simmer for 2 hours, stirring occasionally,  or until sauce is very thick.</li><li>The crust:</li><li>Mix together the flour and salt.  Dissolve the yeast in the water and add the pinch of sugar. When the yeast starts to clump and rise to the surface of the water, stir and add to the flour.  Blend well.</li><li>Knead the dough with the kitchen aid dough hook for 5 minutes or by hand for an agonizing 10 minutes. Divide the dough in half and form two balls.  Oil two bowls with the olive oil and put the dough balls inside, turning to coat with oil.   Cover and let rise for 1 1/2 hour.   Punch the balls flat, then form into balls again and wrap with saran wrap.   Allow to rise again for 1 hour.   Spray Pam or spread olive oil onto (2)  12 inch pizza pans.  Flatten each dough ball onto the center of the pan and press the dough outward until it covers the pan.</li><li>Preheat oven to 400 degrees.   Cover the pizza crusts first with sauce, then cheese, then any vegetable toppings, then cheese again and lastly any meat toppings.  Bake for 15 to 20 minutes.</li></ol>	american	45	1	t	t	f	t
22	Kat's Texas Caviar	https://spoonacular.com/recipeImages/Kats-Texas-Caviar-648791.jpg	<ol><li>Combine all in a large bowl and mix lightly.</li><li>Cover and chill for at least 2 hours, stirring occasionally.</li></ol>	american	45	8	t	t	t	t
23	Mushroom-Swiss Hamburger Pie	https://spoonacular.com/recipeImages/Mushroom-Swiss-Hamburger-Pie-652728.jpg	<ol><li>Preheat oven to 375F</li><li>Heat 1 teaspoon oil in a large skillet over medium heat and saute onions until translucent and just turning brown. Open the beer, take a sip and pour the rest in with the onions. Increase heat to medium-high and cook down until thick and syrupy.</li><li>Pour onion mixture into a large bowl, stir in thyme, mustard, salt and pepper and let cool. Add ground beef, breadcrumbs, parsley and eggs and mix thoroughly with clean hands.</li><li>Spray 9-inch pie plate with non stick and spread hamburger mixture evenly across the bottom and up the sides. Bake until meat reaches a temperature of 160F. Remove from oven and let stand 5 minutes.</li><li>Meanwhile, heat remaining oil over medium heat and lightly saute mushrooms.</li><li>Drain any fat from meat and top with mushrooms and shredded cheese. Turn oven to broil and cook until cheese is melted.</li><li>Makes 6 servings.</li></ol>	american	45	1	f	f	f	f
24	No-Bake Bars	https://spoonacular.com/recipeImages/No-Bake-Bars-653177.jpg	<ol><li>Happy Mother's Day! My husband made these bars last night. They are so good and unfortunately we have been eating them all day. He got the recipe from Wingert from Panama, Iowa.</li><li>In a large bowl, combine the first four ingredients; set aside. In a saucepan, bring corn syrup and sugar to a boil, stirring frequently. Remove from the heat; stir in peanut butter and vanilla. Pour over cereal mixture and toss to coat evenly. Spread into a greased 15X10X1 baking pan. Cool.</li><li>Cut into bars.</li><li>Yield: 15 bars</li></ol>	american	45	1	f	f	t	f
25	Peanut Butter And Chocolate Oatmeal	https://spoonacular.com/recipeImages/Peanut-Butter-And-Chocolate-Oatmeal-655219.jpg	<ol><li>Microwave all ingredients in a small bowl or mug for 1 minute, stir and enjoy!  Serve with crushed peanuts or almonds for some extra crunch!</li></ol>	american	45	1	t	f	t	f
26	Peanut Butter and Jelly Smoothie	https://spoonacular.com/recipeImages/Peanut-Butter-and-Jelly-Smoothie-655235.jpg	<ol><li>Place ingredients in a high speed blender like Blendtec for super smooth texture, blend on high.</li><li>If using a regular blender put milk and strawberries in then blend.</li><li>Next, add banana pieces and peanut butter, process until smooth.</li><li>Garnish with crushed peanuts and serve.</li></ol>	american	45	2	f	f	t	t
27	Peanut Butter Banana Muffins	https://spoonacular.com/recipeImages/Peanut-Butter-Banana-Muffins-655241.jpg	<ol><li>A real kid pleaser and a healthy snack, this moist muffin is prefect for peanut butter fans. Preheat the oven to 375F. In a large bowl, mix together the flour, brown sugar, baking powder, and salt. In a separate bowl, beat together the peanut butter, oil, eggs, milk and bananas. Stir the wet ingredients into the dry ingredients just until moistened.</li><li>Spoon the batter into 12 well-greased muffin cups. Bake for 20 to 25 minutes, or until a toothpick inserted in the centre of a muffin comes out clean.</li><li>MAKES: 12 MUFFINS</li></ol>	american	45	1	t	f	f	f
28	Peanut Butter Chocolate Chip Pie	https://spoonacular.com/recipeImages/Peanut-Butter-Chocolate-Chip-Pie-655270.jpg	<ol><li>Give the graham crackers a whirl in a food processor until fine crumbs,</li><li>Add the melted butter and a pinch of salt and mix thoroughly,</li><li>Pour the graham cracker and butter mixture into a 9-inch tart shell with a removable bottom. Press the mixture along the sides of the tart pan and along the bottom until evenly coated. Carefully place the tart pan in the freezer while you prepare the filling.</li><li>To make the filling combine the peanut butter, softened cream cheese and sweetened condensed milk in the bowl of an electric mixer fit with a paddle attachment.Blend the three ingredients until thoroughly incorporated, but dont over blend.</li><li>In a separate bowl, whip 3/4 cup of heavy cream to soft peaks.</li><li>Add the whipped cream to the peanut butter mixture and fold together until well incorporated.</li><li>Fold in chocolate chips.</li><li>Remove the tart pan from the freezer and spoon in the peanut butter filling. Spread evenly.</li><li>Whip up the remaining cup of heavy cream to stiff peaks</li><li>Spread on top of the peanut butter filling.</li><li>Refrigerate for at least two hours, or overnight.</li><li>Top with mini chocolate chips, or chocolate shavings</li><li>Enjoy!</li></ol>	american	45	1	f	f	t	f
29	Peppermint White Chocolate Fudge	https://spoonacular.com/recipeImages/Peppermint-White-Chocolate-Fudge-655687.jpg	<ol><li>Line an 8x8 pan with plastic wrap or wax paper</li><li>In a large bowl, melt white chocolate chips by microwaving 30 seconds at a time, stirring between sessions.</li><li>Add the container of vanilla frosting</li><li>Stir well</li><li>Add Peppermint flavoring and stir well</li><li>Reheat for 10 seconds if needed, so the mixture is still soft enough to pour</li><li>Pour mixture into lined pan</li><li>Place 6-8 drops of red food coloring on the top of the warm fudge</li><li>With a toothpick or knife, swirl the color into the top of the fudge</li><li>Sprinkle crushed candies over the top of the fudge</li><li>Cool in fridge until hard</li><li>Cut and enjoy!</li></ol>	american	45	8	f	f	t	f
30	Poppy Seed Cupcakes	https://spoonacular.com/recipeImages/Poppy-Seed-Cupcakes-656683.jpg	<ol><li>Preheat oven to 350 degree F.  Line cupcake pan with liners.</li><li>Sift together flour, baking powder, and salt two times into a bowl; set aside.  Grate zest of lemon into a small saucepan and add milk and poppy seeds.  Heat over high heat until steaming; let cool to room temperature.  Add vanilla extract.</li><li>In the bowl of an electric mixer fitted with the paddle attachment, cream butter until soft.  Gradually add sugar; beat on medium speed until very fluffy, about 5 minute, scarping down sides of bowl several times.  Add eggs one at a time, beating well after each addition; continue beating on medium-high speed until smooth, about 1 minute.</li><li>Add flour mixture in three additions, alternating with milk mixture and beginning and ending with flour.  Beat on low speed until just combined. Divide batter evenly for the cupcakes, about 2/3 full each.  Bake until tops are golden brown or until a cake tester inserted in center of cakes comes out clean, 20 to 25 minutes, rotating pans once if needed.   Let cupcakes cool completely on wire racks.  Cakes can be made a day ahead before serving if desired.</li><li>Cut out a cone from each cupcake and trim the ends of the cones.  Fill the hollowed cupcakes with lemon curd-whipped cream.  Replace each top.  Frost cupcake tops with more lemon curd-whipped cream and sprinkle some poppy seeds.</li></ol>	american	45	1	f	f	f	f
31	Pulled Pork Sandwich with Mango BBQ sauce	https://spoonacular.com/recipeImages/Pulled-Pork-Sandwich-with-Mango-BBQ-sauce-657226.jpg	<ol><li>Directions</li><li>Rub: Combine the rub ingredients, in a small bowl and massage it into the pork shoulder until well coated. Set aside while you make BBQ sauce. You could do this a day ahead and keep refrigerated until ready to use.</li><li>BBQ sauce: In a large saucepan, warm the oil, over low heat, until hot and shimmering. Add the cumin and fennel; they should splutter upon contact - be careful! Once the spluttering subsides, add the onions, ginger and serrano and a little salt, to taste. Saute until they soften but don't let them get any color. Add the rest of the sauce ingredients. Simmer about 5 minutes. Taste and season.</li><li>Add the pork shoulder to the saucepan, coating it with the sauce. Cover, and gently simmer until the pork falls apart easily, stirring and turning often, about 3 hours.</li><li>Remove the pork from the saucepan and shred it using 2 forks. Return it to the sauce and stir to coat with the sauce. Put a generous spoonful of the pork inside a brioche bun, top with a few slices of pickle and serve. Aarti's Note: prepare to have your loved one swoon over you!</li></ol>	american	45	4	f	f	f	t
32	Spice-Rubbed Lemon Barbecue Salmon	https://spoonacular.com/recipeImages/Spice-Rubbed-Lemon-Barbecue-Salmon-660926.jpg	<ol><li>Place the salmon fillets on a greased, foil-lined baking sheet.</li><li>Rub the top of the salmon with the barbecue seasoning. Let sit for 10 minutes while you preheat the broiler.</li><li>Place the baking sheet 4" - 6" from the heating element and broil for 6 - 8 minutes, until cooked through.</li><li>Remove from the broiler and let sit 5 minutes.</li><li>Combine the sauce ingredients (barbecue sauce, hoisin sauce, honey and zest of 1/2 lemon) in a small bowl.</li><li>Spoon the sauce into a small ziplock bag and squeeze down to the corner of the bag. Cut off a very small portion of the corner of the bag and squeeze the sauce generously over the salmon.</li><li>Serve with a lemon wedge from the other half of the lemon.</li></ol>	american	45	2	f	f	t	t
33	Whole Wheat No-Yeast Pizza with Roasted Garlic, Sweet Potatoes, and Onions	https://spoonacular.com/recipeImages/Whole-Wheat-No-Yeast-Pizza-with-Roasted-Garlic--Sweet-Potatoes--and-Onions-665294.jpg	<ol><li>Roasted Garlic Instructions:</li><li>Preheat oven to 400 degrees F.</li><li>Cut the top off the bulb of garlic, exposing the cloves.</li><li>Place the garlic on a sheet of foil large enough to wrap it up.</li><li>Drizzle olive oil over top of garlic bulb and sprinkle with salt.</li><li>Tightly wrap the garlic in the foil.</li><li>Place foil in the oven and cook for 45 minutes.</li><li>Remove and unwrap garlic. Turn upside down and squeeze the cloves out of the garlic skin</li><li>Whole Wheat Pizza Dough Instructions:</li><li>Place all ingredients (except 2 tbsp olive oil) in a food processor or a stand mixer with dough hook. If using a food processor, process until dough forms into a ball. Add extra water, 1 tbsp at a time if dough is too dry. If using a stand mixer, mix with dough hook until all of the flour is mixed together.</li><li>If you have time, place dough in plastic wrap and refrigerate for 20-30 minutes.</li><li>Lightly flour surface and roll dough out until it is 1/2 inch thick. I chose to use a large bowl and cut out circular pizzas. This required me to roll the dough out three times, making 2 larger pizzas and one smaller one. You could also opt to roll it out until it is a rectangle.</li><li>Place pizza on pizza stone or on greased cookie sheet. Set aside.</li><li>Brush pizza dough lightly with olive oil (no more than 2 tbsp total).</li><li>Pizza Topping Instructions:</li><li>Preheat oven to 400 degrees F.</li><li>Line a baking sheet with foil and spray with non-stick cooking spray.</li><li>Place cubed red onion and sweet potato on the sheet.</li><li>Drizzle with 1-2 tbsp olive oil, and sprinkle with thyme, rosemary, salt and pepper.</li><li>Roast for 25-30 minutes, mixing the vegetables around occasionally. (I roasted my garlic at the same time).</li><li>Remove and set aside.</li><li>Take your freshly roasted bulb of garlic and squeeze the garlic out into a mortar bowl (if you don't have one, use a bowl). Crush the garlic with either a pestle or the bottom of a spoon until it is a paste.</li><li>Spread the roasted garlic paste over the pizza dough.</li><li>Sprinkle/crumble your cheese of choice over the pizza dough.</li><li>Place the vegetables on top of the cheese.</li><li>Cook pizza for approximately 20 minutes (plus or minus a few minutes depending on your oven), waiting for the crust to become golden brown.</li><li>Enjoy!</li></ol>	american	45	3	t	f	f	f
34	Popcorn Chicken	https://spoonacular.com/recipeImages/popcorn-chicken-716358.jpg	In a bowl, season the chopped chicken breast with one seasoning cube, ginger powder, black pepper, chili powder, and garlic and set aside. Whisk your eggs and set aside.Season your breadcrumbs with the seasoning cubes and divide into 2 equal portions and set aside.In a blender or food processor, pour in your chicken breast, flour, 1 portion of breadcrumbs, and egg and blend till smooth.Scrape into a bowl and mold into little balls using the extra breadcrumbs to properly coat it. The smaller the balls the better as the chicken would cook through better.In a deep fryer or a huge pot of oil on medium heat, allow to heat but not be extra hot and dunk your popcorn chicken to fry till brown.Serve hot.	american	45	2	f	f	f	t
35	Bangers and Mash	https://spoonacular.com/recipeImages/bangers_and_mash-44789.jpg	None	british	134	1	f	f	t	t
36	Bridget Jones's Shepherd's Pie	https://spoonacular.com/recipeImages/Bridget-Joness-Shepherds-Pie-636096.jpg	<ol><li>Preheat the oven to 180 C.</li><li>In a large frying pan, heat a little olive oil and fry the chopped onion and garlic.</li><li>Add the mince, stirring, until browned all over.</li><li>While the meat is frying, break up any lumps with the back of the spoon.</li><li>Add the flour (this helps to thicken the juices) and stir.</li><li>Mix well and add the thyme and the rosemary and stir.</li><li>Add the chopped tomatoes and pour the stock mixture.</li><li>Add a pinch of salt and freshly ground black pepper and let it simmer for about 5 minutes.</li><li>For the mash, boil the potatoes, then drain them in a sieve and place into a clean bowl.</li><li>Add the milk, butter and egg yolk, and mash together.</li><li>Season with salt and freshly ground black pepper.</li><li>Pour the meat into an ovenproof dish and spread the mash on top, smooth over and mark with a spatula.</li><li>Put the dish into the oven and cook until the surface is bubbling and golden-brown.</li></ol>	british	45	4	f	f	f	f
37	British Treacle Tart	https://spoonacular.com/recipeImages/British-Treacle-Tart-636136.jpg	<ol><li>Combine flour, salt and confectioners sugar in a large bowl.  Using tips of fingers, rub butter into flour until it looks mostly like wet sand.  Make a well in the middle, and pour in the egg.  Gradually work the egg into the flour until a moist dough forms, using the heel of your hand to distribute any remaining large pieces of butter. Shape into a 5-inch disk and cover with plastic wrap.  Refrigerate for 1 hour. This can be done in a food processor.</li><li>Roll out dough into a 13-inch circle. Lay dough into an 11-inch tart pan with a removable bottom, and press against the sides to secure dough. Refrigerate for one hour.</li><li>Preheat oven to 325 F.  Dock the bottom of the crust with a fork, lay a large, crumpled piece of parchment on top, and pour in pie weights (or a pound of dried beans). Bake for 25 minutes, until crust is a light golden brown. Set aside.</li><li>Increase the temperature to 350 F</li><li>Mix together the golden syrup and molasses with the lemon juice. Beat the eggs in a bowl and add to the treacle mixture. Finally stir in the bread crumbs.</li><li>Pour the mixture into the prepared tart case.</li><li>Bake for 20  25 minutes until the crust and filling are golden brown and firm to the touch. You may have to cover the crust with aluminum foil to keep it from getting too brown or burning.</li><li>Serve warm with crme fraiche which balances really well with the sweetness of the tart or a good vanilla ice cream.</li></ol>	british	45	1	f	f	f	t
38	Caramel Almond Berry Trifle	https://spoonacular.com/recipeImages/Caramel-Almond-Berry-Trifle-636970.jpg	<ol><li>Mix large box of pudding and milk (according to directions)</li><li>Add one cap full of almond extract, mix well, and set aside to set.</li><li>After pudding has set, let's start the layers. First a thick layer of pudding, a layer of the pound cake, add berries, drizzle caramel sauce over berries, add Cool Whip layer, then repeat layers.</li><li>Top with additional berries and caramel.</li></ol>	british	30	10	f	f	t	f
39	Cheesy Potato Corn Scones	https://spoonacular.com/recipeImages/Cheesy-Potato-Corn-Scones-637675.jpg	<ol><li>Lightly greased a baking sheet; set aside.  In a small saucepan, bring the water just to a simmer; remove from heat.  Stir in potato flakes until moistened.  Stir in butter until it's incorporated to potato flakes.</li><li>In a large bowl, combine flour, cornmeal, 3/4 cup of the cheese, baking powder, salt, and poppy seeds; stir in potato mixture and milk.  With floured hand, gently knead and fold the dough for five to six strokes, or until the dough comes together in one mass.  Pat the dough lightly to flatten it into a 9-inch circle on prepared baking sheet.  Cut dough into eight wedges using a pizza cutter or floured knife (do not separate).  Sprinkle edges with remaining cheese.</li><li>Bake in a preheated 400 degree F oven for about 25 minutes or until lightly browned.  Gently pull or cut scones to separate.  Serve warm.</li></ol>	british	45	8	f	f	f	f
40	Chicken Shepherd's Pie	https://spoonacular.com/recipeImages/Chicken-Shepherds-Pie-638329.jpg	<ol><li>Preheat the oven to 425F.</li><li>Heat olive oil in a Dutch oven (or a deep ovenproof dish) over high heat. Add chicken and break up with a wooden spoon; season with salt, pepper, and poultry seasoning.</li><li>Place potatoes in a pot with water to cover. Cover and bring to a boil, then salt the water and cook potatoes for 15 minutes, or until tender.</li><li>Add onion, carrots, and celery to the Dutch oven and cook for 5 minutes.</li><li>While the vegetables are cooking, heat 2 tablespoons of the butter in a small pot over medium heat. Add flour and whisk for 1 minute, then whisk in the stock and season with salt, pepper, and Worcestershire. Cook for a few minutes, until thickened, then add to the chicken mixture.</li><li>Stir in the peas into the chicken mixture and turn off the heat.</li><li>Drain the potatoes and return the pot to the heat. Add the remaining 2 tablespoons of butter and melt over medium heat. Season with salt and pepper. Mash the potatoes and adjust the seasoning.</li><li>Spoon the potatoes onto the meat, and cover the potatoes with the cheese. Bake uncovered for 5-10 minutes until the top is golden.</li></ol>	british	45	6	f	f	f	f
41	Classic scones	https://spoonacular.com/recipeImages/Classic-scones-639637.jpg	<ol><li>Using fingertips, rub butter into flour until mixture resembles fine breadcrumbs.</li><li>Make a well in the centre of the dry ingredients and add milk, stirring with a metal spatula or butter knife until mixture comes away from the sides of the bowl. If mixture is dry, add a little extra milk.</li><li>Turn mixture onto a lightly floured bench and bring the dough together until a rough ball of dough is formed. Do not over-knead. Pat dough to 2 cm thickness. With a clean knife, quarter the dough or use a round cutter to cut rounds.</li><li>Arrange scones onto a baking paper lined tray and bake at 220C for 12-15 minutes until golden and they sound hollow when lightly tapped on the base.</li><li>Serve scones straight from the oven with jam and cream.</li></ol>	british	45	4	t	f	f	f
42	Easy Beef Wellington	https://spoonacular.com/recipeImages/Easy-Beef-Wellington-641848.jpg	<ol><li>Pre-heat the oven to 200c.</li><li>Heat some oil in a large pan and quickly fry the seasoned beef all over until its brown. Remove and allow to cool. The point of this is simply to sear the beef and seal all those juices in, you dont want to cook the meat at this stage. Allow to cool and brush generously with the mustard.</li><li>Roughly chop the mushrooms and blend in a food processor to form a puree. Scrape the mixture into a hot, dry pan and allow the water to evaporate. When sufficiently dry (the mixture should be sticking together easily), set aside and cool.</li><li>Roll out a generous length of cling wrap, lay out the four slices of proscuitto, each one slightly overlapping the last.  Spread the mushroom mixture evenly over the ham.</li><li>Place the beef fillet in the middle and keeping a tight hold of the cling film from the outside edge, neatly roll the parma ham and mushrooms over the beef into a tight barrel shape. Twist the ends to secure the clingfilm. Refrigerate for 10 -15 minutes, this allows the Wellington to set and helps keep the shape.</li><li>Roll out the pastry quite thinly to a size which will cover your beef. Unwrap the meat from the cling film. Egg wash the edge of the pastry and place the beef in the middle.</li><li>Roll up the pastry, cut any excess off the ends and fold neatly to the underside. Turnover and egg wash over the top. Chill again to let the pastry cool, approximately 5 minutes. Egg wash again before baking at 200c for 35  40 minutes. Rest 8 -10 minutes before slicing.</li></ol>	british	45	2	f	f	f	t
43	Easy Shepherd's Pie (Beef or Lamb Combo)	https://spoonacular.com/recipeImages/Easy-Shepherds-Pie-(Beef-And-or-Lamb-Combo)-642091.jpg	<ol><li>Boil potatoes in salted water until tender, about 12 minutes. Drain potatoes and pour them into a bowl.</li><li>Combine cream cheese (or sour cream), egg yolk and milk (or heavy cream). Add the cream mixture into potatoes and mash until potatoes are almost smooth.</li><li>While potatoes boil, preheat a large skillet over medium high heat. Add oil to hot pan with beef and/or lamb.</li><li>Season meat with salt and pepper. Brown and crumble meat for 3 or 4 minutes. If you are using lamb and the pan is fatty, spoon away some of the drippings.</li><li>Add chopped carrot* and onion to the meat. Cook veggies with meat 5 minutes, stirring frequently.</li><li>NOTE:*by finely chopping the carrots, they will cook a little faster.</li><li>Add the thyme.</li><li>OPTIONAL Add the tomato paste, which gives the meat filling a richer flavor.</li><li>In a second small skillet over medium heat cook butter and flour together 2 minutes. Whisk in broth and Worcestershire sauce. Thicken gravy 1 minute. Add gravy to meat and vegetables. Stir in peas.</li><li>Preheat broiler to high.</li><li>Fill a small rectangular casserole with meat and vegetable mixture. Spoon potatoes over meat evenly.</li><li>Top potatoes with paprika and broil 6 to 8 inches from the heat until potatoes are evenly browned. Top casserole dish with chopped parsley and serve</li></ol>	british	45	6	f	f	f	f
44	Fresh Cherry Scones	https://spoonacular.com/recipeImages/Fresh-Cherry-Scones-643450.jpg	<ol><li>Cut cherries in half and pit them (or use a cherry pitter). Place the cherries in a freezer-safe container and freeze for at least 3 hours prior to baking the scones. This ensures the cherries dont pop in the dough while theyre baking.</li><li>In a KitchenAid (with the wire whisk attachment) or food processor, add the oat flour, cornmeal, baking powder, baking soda, nutmeg, ginger and salt. Mix or pulse to combine dry ingredients. In a bowl, combine the applesauce, yogurt, vanilla extract and agave nectar.  Stir to combine Very slowly pour the wet ingredients into the mixer with the dry ingredients about a quarter of a cup at a time (similar idea to making pie crust), mixing on medium speed. Once all the wet ingredients are combined with the dry, add chopped walnuts and mix until integrated into the dough. Taking the dough in your hands, form it into a disc shape. Refrigerate in a sealable container or plastic wrap for 1 hour.</li><li>Preheat the oven to 375 degrees. Using a bread knife, cut the dough in half horizontally like you would a bun. Place half of the frozen cherries on one of the dough halves then place the other half of the dough on top. Press the dough halves together to seal the cherries in.  Press the remaining frozen cherries into the top of the dough. Using a serrated knife, cut diagonals into the dough in order to create eight triangles. Arrange on a parchment paper-lined baking sheet (be sure to give the triangles enough space to bake evenly). Bake for 23 minutes or until the tops of the scones are golden brown.  Serve with butter, jam, honey, or nutella.</li></ol>	british	45	8	t	f	t	f
45	Healthier Bangers and Mash	https://spoonacular.com/recipeImages/Healthier-Bangers-and-Mash-646417.jpg	<ol><li>Spray a cast iron skillet with cooking spray and place over medium heat. Saut onions for ten minutes. Add mushrooms and continue to saut for an additional ten minutes until they begin to caramelize.</li><li>In the meantime fill a saucepan halfway with warm water and bring to a simmer over medium heat. Add chicken sausages and cover for 20 minutes.</li><li>Fill a large pot with water and bring to a boil. Add cauliflower and cook uncovered for 20 minutes.</li><li>When the onions and mushrooms have caramelized sprinkle with flour and stir to combine. Pour in chicken broth and red wine, season with salt and pepper. Bring to a simmer and cook for 10-15 minutes stirring occasionally until thickened.</li><li>Remove sausages from pan and discard water. Spray pan with cooking spray and saut sausages until golden brown on all sides.</li><li>Meanwhile, strain cauliflower and place in a food processor with milk, butter, and cream cheese. Pulse until smooth, season with salt and pepper.</li><li>To serve place mashed cauliflower and sausages on a plate and cover with gravy.</li></ol>	british	45	2	f	f	f	f
46	Lavender Scones	https://spoonacular.com/recipeImages/Lavendar-Scones-649315.jpg	<ol><li>Tip flour into a bowl with salt and baking powder. Add butter and rub with your fingers until the mixture resembles breadcrumbs.  Add lavender and sugar and mix well.</li><li>Put the milk into a jug and heat for 30 seconds, add the vanilla and lemon juice. Set aside.  Put a baking sheet in the oven.</li><li>Make a well in the dry mixture and add the liquid.  Combine quickly with a knife.</li><li>Scatter flour on a board and pat the dough into a round about 4cm deep.  Do not over work.</li><li>Cut out rounds and place on the tray.  Re-round the dough and cut out more rounds until all dough is used.</li><li>Brush with beaten egg and bake for 10 mins, until risen and golden.</li></ol>	british	45	1	t	f	f	f
47	Lean Shepherd's Pie	https://spoonacular.com/recipeImages/Lean-Shepherds-Pie-649395.jpg	<ol><li>Brown ground beef with onion</li><li>Cook potatoes in water till soft, drain</li><li>Mash potatoes, add chicken broth as needed to make smooth mashed potatoes</li><li>Spread browned ground beef in bottom of 8x11 Pyrex dish</li><li>Spread mashed potatoes over beef layer</li><li>Spead corn kernels over mashed potato layer</li><li>Sprinkle grated cheese over corn layer</li><li>Bake at 350 for 25-30 minutes or until heated through and cheese is melted</li><li>When the pie comes out of the oven, lightly dust the top with a little pepper if desired.</li></ol>	british	45	4	f	f	t	f
48	Rich Jelly Scones	https://spoonacular.com/recipeImages/Rich-Jelly-Scones-658300.jpg	<ol><li>Pre-heat oven to 400 degrees.</li><li>Mix dry ingredients together.</li><li>Cut butter into the dry ingredients using a fork or hand-held pastry blender. When well blended, the mixture will have the look of crumbly sand.</li><li>Add the vanilla, eggs, and milk, mixing only long enough to blend the ingredients. *You do not want to begin to melt the butter into the flour mixture by over-mixing.</li><li>Turn the dough onto a lightly floured counter top or pastry board. Shape it into a round disc 8 inches across, slightly thicker in the center.</li><li>Using a long knife, cut the dough into eight even pie-shaped portions.</li><li>Place scones on a lightly greased baking sheet. Using a spoon, press a well into the wide end of each triangle, and fill the well with a spoonful of fruit jam. Brush the exposed surface of each scone with the milk/egg mixture,</li><li>Bake for twenty-five minutes, until scones are a beautiful golden brown.</li></ol>	british	45	4	f	f	f	f
49	Ricotta Chocolate Chips Scones	https://spoonacular.com/recipeImages/Ricotta-Chocolate-Chips-Scones-658326.jpg	<ol><li>Preheat the oven to 400F degress. Line a baking sheet with parchment paper.</li><li>In a bowl whisk together the flour, the sugar, the baking powder, the baking soda and the salt.</li><li>Cut in the ricotta and butter and lightly work with your fingers until the mixture resembles coarse sand. Gently stir in the buttermilk, the vanilla extract and the chocolate chips.</li><li>Turn the dough out onto a floured surface. Knead gently for 1  2 minutes, the dough should hold together but be a bit crumbly.</li><li>Place the dough on the prepared baking sheet lined with parchment paper. Pat the dough into a 3/4-inch-thick circle.</li><li>Cut  the dough into 4 wedges without separating them. Use a pastry brush to brush the surface of the dough with milk and then sprinkle with brown sugar.</li><li>Bake for about 15 minutes or until lightly browned. Let them cool on a cooling  rack.</li></ol>	british	45	4	f	f	f	f
50	Strawberries and Cream Scones	https://spoonacular.com/recipeImages/Strawberries-and-Cream-Scones-661725.jpg	<ol><li>Preheat the oven to 425F.</li><li>Cube and chill butter.</li><li>Combine dry ingredients (flour, sugar, baking powder, lemon zest, salt, and cinnamon) in a large bowl.</li><li>With your fingertips work the butter into the flour mixture.</li><li>Make a well in the center of the butter and flour mixture. Add the heavy cream and stir.</li><li>Add a tablespoon of milk and stir until the dough is moistened but not wet.</li><li>Add the diced strawberries.</li><li>Gently work the strawberries into the dough and knead it together.</li><li>Pat into an 8 inch circle and cut triangles. Do not be afraid of using flour, excess flour can always be dusted off.</li><li>Transfer scones to a parchment lined baking sheet.</li><li>Brush with egg wash.</li><li>Bake at 425F for 12-15 minutes or until the tops and edges are golden.</li><li>Cool on a cooling rack.</li><li>Drizzle with glaze (powdered sugar mixed with a bit of liquid of your choice)</li></ol>	british	45	8	f	f	f	f
51	Trifle In A Jiffy	https://spoonacular.com/recipeImages/Trifle-In-A-Jiffy-663815.jpg	<ol><li>Mix jelly as per packet instruction</li><li>Place cut up fruits in a glass and pour the jelly</li><li>Refrigerate</li><li>For the custard layer~Mix custard powder with 1/4 of milk and stir into a smooth mixture...</li><li>Pour the remainder of the milk into a saucepan, follow by the custard mix. Place on the stove on low heat...</li><li>Keep on whisking to avoid having a lumpy custard.</li><li>Custard will slowly thickened...</li><li>Spoon the custard onto the jelly layer and back into the refrigerator</li><li>For the cream layer ~using electric beater, beat the cream and sugar until peak</li></ol>	british	45	1	f	f	t	f
52	Vegetarian Mushroom Shepherd's Pie	https://spoonacular.com/recipeImages/Vegetarian-Mushroom-Shepherds-Pie-664680.jpg	<ol><li>Go to my blog for the full instructions: http://gourmandelle.com/vegetarian-mushroom-shepherds-pie-with-vegan-version/</li></ol>	british	45	12	t	f	t	t
53	Beef Wellington	https://spoonacular.com/recipeImages/beef_wellington-75081.jpg	None	british	139	10	f	f	f	f
54	Tenderloin Beef Wellington	https://spoonacular.com/recipeImages/tenderloin_beef_wellington-82518.jpg	None	british	25	1	f	f	t	t
55	Avocado and Crawfish Appetizers	https://spoonacular.com/recipeImages/Avocado-and-Crawfish-Appetizers-633123.jpg	<ol><li>Halve the tomato, scoop out and discard the seeds. Chop what is left and place in bowl with sherry vinegar, olive oil and salt. Gently whisk.</li><li>Just before you are ready to serve, fold the crayfish bits into the tomato mixture.</li><li>Halve the avocado, remove pit, scoop out some of the pulp and place spoons of the crayfish mixture inside. Serve some of the leftover avocado on the side.</li><li>It can make a colorful and pretty presentation....</li></ol>	cajun	45	4	f	f	t	t
56	Bananas Foster French Toast	https://spoonacular.com/recipeImages/Bananas-Foster-French-Toast-By-Mommie-Cooks-634234.jpg	<ol><li>Slice up your loaf of bread into 1 inch thick slices.</li><li>In a separate bowl, whisk together the eggs, half & half and cinnamon.</li><li>Dip each slice of bread in the egg mixture being sure to coat both sides.</li><li>Cook up on a griddle for about 2-3 minutes on each side or until cooked through.</li><li>In a pan on the stove set to medium low heat, melt up the butter and add in the brown sugar.</li><li>Add to the mixture the syrup, cinnamon, salt and vanilla.</li><li>Add in the bananas. Stir to coat bananas completely. Remove from heat.</li><li>To make the whipped cream, whip together your cream, maple syrup and sugar until stiff peaks form. Serve over the top of french toast.</li></ol>	cajun	45	1	f	f	f	f
57	Bananas Foster Ice Cream	https://spoonacular.com/recipeImages/Bananas-Foster-Ice-Cream-634237.jpg	<ol><li>In a heavy bottomed saucepan, heat the milk, salt and 1/4 cup sugar over med-low heat until steaming but not boiling and the sugar is dissolved.  Add the vanilla bean and vanilla bean caviar to the mixture.  Cover and let steep for 1 hour.</li><li>In a small saute pan, melt the butter, brown sugar and salt.  Bring to a boil stirring constantly until the mixture turns a deep golden brown.  Add the bananas and continue to saute the mixture for approximately 5 more minutes or until the bananas soften.  Stir in the rum and remove from heat.  Let the mixture cool to room temperature.</li><li>Fill a large bowl with ice and water.  Place a small bowl in the ice water and add the heavy cream.  Top the small bowl with a wire strainer and set aside.</li><li>In a small bowl, whisk together the egg yolks and remaining 1/4 cup sugar until light in color and ribbons begin to form.</li><li>Reheat the milk mixture over med-low heat and slowly add to egg mixture whisking constantly so the eggs do not scramble.  Return the milk/egg mixture to the pan and heat. Stir constantly with a heat resistant spatula being sure to scrape the sides and bottom until it begins to thicken (it will coat the back of the spatula).</li><li>Strain the milk mixture into the cream, remove the strainer and stir until combined.  Cover with plastic wrap and chill in the refrigerator for 2 hours or overnight.</li><li>Pour the mixture into the freezer can of an electric ice cream maker and freeze according to the manufacturers instructions.  When the mixture reaches soft serve consistency, add the banana mixture and continue churning until combined.</li><li>Transfer the ice cream to a freezer safe container and freeze.</li></ol>	cajun	45	2	f	f	t	f
58	Boudin	https://spoonacular.com/recipeImages/Boudin-635701.jpg	<ol><li>Cook pork meat, liver and seasonings in water (to cover) until meat falls apart; remove meat and reserve some broth.</li><li>Grind meat, onion, green onions and parsley (reserving about 1/2 cup each of green onion tops and parsley).</li><li>Mix ground meat mixture with the 1/2 cups of green onion tops and parsley, rice and enough broth to make a moist dressing.</li><li>Stuff dressing into cold water-soaked sausage casings, using a sausage stuffer.</li></ol>	cajun	45	6	f	f	t	t
59	Boudin Sausage	https://spoonacular.com/recipeImages/Boudin-Sausage-635708.jpg	<ol><li>In a large sauce pan, combine the pork butt, pork liver, water, onions, garlic, bell peppers, celery, 1 teaspoon salt, 1/4 teaspoon cayenne, and 1/4 teaspoon black pepper. Bring the liquid up to a boil and reduce to a simmer. Simmer for 1 1/12 hours, or until the pork and liver are tender. Remove from the heat and drain, reserving 1 1/2 cups of the broth.</li><li>Using a meat grinder with a 1/4-inch die, grind the pork mixture. 1/2 cup of the parsley, and 1/2 cup of the green onions, together. Turn the mixture into a mixing bowl. Stir in the rice, remaining salt, cayenne, black pepper, parsley, and green onions. Add the broth, 1/2 cup at a time, and mix thoroughly. Either using a feeding tube or a funnel, stuff the sausage into the casings and make 3-inch links.</li><li>Bring 1 gallon of salted water up to a boil. Poach the sausage for about 5 minutes, or until the sausage is firm to the touch and plump. Remove from the water and allow to cool.</li></ol>	cajun	45	1	f	f	t	t
60	Vegan Jambalaya	https://spoonacular.com/recipeImages/Cajun-Cuisine--Vegan-Jambalaya-636714.jpg	<ol><li>Place 2 cups rice, 3 1/2 cups water and salt in a medium pot. Cook until water boils. Turn heat down to low.</li><li>Cook for 45 minutes.</li><li>Meanwhile, chop carrots, celery, onions and garlic.</li><li>In a wok or large pot, heat 2 Tbsp olive oil.</li><li>Fry vegetables.</li><li>Add instant roux, creole seasoning, pepper, tomato paste.</li><li>Add water, and bouillon cube and simmer until sauce thickens.</li><li>Add sausage and cooked for 5 minutes and then add beans Add petite diced tomatoes and cook for another 5 to 7 minutes.</li><li>Add 3 cups of cooked rice to mixture.</li><li>Cook for 10 to 15 minutes until sauce has distributed.</li><li>Turn heat off and add green onions and parsley before serving.</li><li>This dish is not spicy at all, but full of flavor.</li><li>Feel free to substitute with real sausage and cooked chicken.</li></ol>	cajun	45	4	t	f	f	t
61	Cajun Lobster Pasta	https://spoonacular.com/recipeImages/Cajun-Lobster-Pasta-636732.jpg	<ol><li>Cook up your bacon in a small frying pan over medium heat. Remove the bacon and drain off the fat, reserving about a tablespoon.</li><li>To the pan add in your garlic and pepper. Cook it up on medium heat for about two to three minutes.</li><li>Add in the green onions. Let cook for an additional minute.</li><li>Chop up your bacon and add it to the pan along with the broth. Love me some bacon.</li><li>Now add in your spices; the cajun, old bay, onion powder, garlic powder, lemon pepper, oregano, and pepper.</li><li>Allow the mixture to heat back up and then turn your heat down to medium low. Add in your lobster and allow it about three to five minutes to heat up completely.</li><li>Last up, add in your cream.</li><li>Serve your finished lobster over fresh cooked pasta with a few pinches of parmesan cheese and a sprinkle of chopped green onions over the top.</li></ol>	cajun	45	1	f	f	t	f
62	Cajun Potato Wedges	https://spoonacular.com/recipeImages/Cajun-Potato-Wedges-636733.jpg	<ol><li>Preheat oven to 425 degrees Fahrenheit. Slice potatoes into  inch thick wedges that are half the length of the potato.</li><li>Make spice mixture: combine all spices and mix together in a small bowl.</li><li>Spray cookie sheet with olive oil cooking spray. Place potatoes on cookie sheet. Toss with olive oil. Sprinkle spice mixture over potatoes and toss.</li><li>Cook for 25 minutes. Flip over and cook for another 5 minutes.</li></ol>	cajun	45	4	t	t	t	t
63	Cajun Seafood and Andouille Sausage Gumbo	https://spoonacular.com/recipeImages/Cajun-Seafood-and-Andouille-Sausage-Gumbo-636736.jpg	<ol><li>1. In a small bowl, combine the seasoning ingredients and set aside.</li><li>2. In a medium bowl, combine the onions, peppers and celeryand set aside.</li><li>3. In a lightly oiled 5  quart Dutch oven, brown the sausage rounds over medium high heat and set aside.</li><li>4. Add the  C oil and when it starts to smoke, slowly combine the flour and cook while whisking until the roux reaches a dark reddish brown color.</li><li>5. Immediately add half of the vegetables and stir in for 1 minute. Then add the remaining vegetables, mix thoroughly and cook for 2 more minutes.</li><li>6. Add the seasoning mix, stir in well and cook 2 more minutes or so. Then add the garlic, stir in and cook for another minute.</li><li>7. Add the fish stock or clam juice and, mix well, bring to a boil and reduce to a simmer; then simmer this for about 30 minutes covered.</li><li>8. Add the reserved browned sausage rounds, the crab, shrimps and oysters with their liquid and cook over medium heat for about 10 minutes stirring occasionally.</li></ol>	cajun	45	4	f	f	f	t
64	Cajun Shrimp Chowder	https://spoonacular.com/recipeImages/Cajun-Shrimp-Chowda-636742.jpg	<ol><li>Grab up your frying pan and cook up the three strips of bacon. When they're cooked up, pull them out, chop them up, and drain the bacon fat, reserving about a tablespoon. Turn your heat up to medium and add in your asparagus, onion, and garlic. Cook it up for 2 to 3 minutes.</li><li>Add in the corn and tomatoes.</li><li>Mix it together, give it a minute or two to warm up and then add in the broth, the chopped bacon and your spices; the old bay, cajun, lemon pepper, and salt and pepper to taste.</li><li>Let the whole kit and kaboodle heat up for a good five minutes and then add in your cream.</li><li>And last but most definitely not least, grab up your shrimp and pop them into the pan.</li><li>Give the whole pan a swirl or two and allow the soup a couple minutes to heat back up.</li><li>Serve with green onions sprinkled over the top.</li></ol>	cajun	30	8	f	f	t	f
65	Cajun Shrimp and Marinated Cucumber Salad	https://spoonacular.com/recipeImages/Cajun-Shrimp-and-Marinated-Cucumber-Salad-636743.jpg	<ol><li>Preheat broiler to high.</li><li>Place shrimp on a small rimmed baking sheet. Sprinkle with 1/2 tsp cajun seasoning, lemon juice (or vinegar), 1 T oil (if using) and pinch or two of salt and black pepper.</li><li>Place in the oven on the upper third rack. Broil for 3-5 minutes until shrimp is completely opaque and pink.</li><li>Meanwhile, place cucumber slices in a bowl and toss with remaining 1/2 tsp cajun seasoning, 2 T vinegar, 2 T olive oil (if using), and salt and pepper to taste.</li><li>Divide cucumbers between two bowls, top each with half of the shrimp and a couple spoonfuls of pico de gallo.</li></ol>	cajun	15	2	f	f	t	t
66	Creamy Crawfish Pasta	https://spoonacular.com/recipeImages/Creamy-Crawfish-Pasta-640630.jpg	<ol><li>Cook linguine according to package directions; drain. Keep warm.</li><li>Melt butter in a Dutch oven over medium heat. Add flour, and cook, stirring constantly, 2 minutes or until blended. Add green onions and next 4 ingredients; saut 5 minutes or until tender. Add bouillon cube and next 7 ingredients; cook 10 minutes or until thickened. Stir in hot sauce, if desired. Serve over linguine noodles; sprinkle with shredded Parmesan cheese. Garnish, if desired.</li><li>Pounds peeled, medium-size fresh or frozen shrimp can be substituted for crawfish tails.</li></ol>	cajun	45	8	f	f	f	f
67	Jambalaya	https://spoonacular.com/recipeImages/Jambalaya-648427.jpg	<ol><li>Brown sausage. blacken fish with pepper and paprika. Brown in hot skillet. Saute onion, celery, green pepper, garlic until limp. Add stock and tomato sauce, spices, vegetable and meats to crock pot or large stock pot; boil for 1 hour on low or crock pot until done.</li></ol>	cajun	45	10	f	f	t	t
68	Jambalaya Soup	https://spoonacular.com/recipeImages/Jambalaya-Soup-648430.jpg	<ol><li>In saucepan, bring broth, tomatoes, garlic, herbs and pepper to a boil. In 5- or 6-quart slow cooker, mix onion, celery, rice and sausage. Add broth. Tuck in drumsticks, meaty-sides down, to cover. Cover; cook on LOW 7 to 8 hours, or on HIGH 2 1/2 to 3 hours, until rice has softened and chicken is tender.</li><li>Uncover; turn to HIGH. Add shrimp and okra; cover. Simmer 5 minutes, until shrimp are cooked and okra is crisp-tender. Remove drumsticks; remove bones, if desired. Ladle soup into bowls; add chicken to each serving.</li><li>Stovetop Method: In 5- or 6-quart covered Dutch oven, simmer all ingredients except shrimp and okra, 1 hour and 10 minutes. Add shrimp and okra; simmer 5 to 8 minutes.</li><li>This recipe yields 8 servings.</li></ol>	cajun	45	8	f	f	t	t
69	Jambalaya Stew	https://spoonacular.com/recipeImages/Jambalaya-Stew-648432.jpg	<ol><li>Add all ingredients except shrimp to a large pot on the stove. Mix thoroughly. Bring to a boil.</li><li>Reduce heat to medium low. Cover and simmer until vegetables are tender and rice is fluffy, about 35 minutes.</li><li>Add shrimp and re-cover. Continue to cook until shrimp are tender and cooked through, about 6 minutes.</li><li>If you like, season to taste with salt, black pepper, and additional hot sauce. Serve and enjoy!!!</li></ol>	cajun	45	4	f	f	t	t
70	Jean's Seafood Gumbo	https://spoonacular.com/recipeImages/Jeans-Seafood-Gumbo-648524.jpg	<ol><li>Fill a 14-16-quart pot with two quarts of water and bring to a boil.</li><li>Meanwhile, peel and devein the shrimp, keeping the heads and hulls. Set the shrimp aside in cold water. In the large "gumbo pot" boil heads and hulls for 30 minutes to an hour. This will give you Creole gumbo. Strain shrimp heads and hulls from stock and set aside. Discard heads and hull immediately. Otherwise, the next day your kitchen will smell like Bayou St. John.</li><li>Clean the fresh crabs  If the crabs are fresh, you must take time to clean them. Discard the hard back shell and some of the so-called "dead man," or yellow insides. Clean and separate crabs and set aside. (Note: If necessary, you can use meat from king, Dungeness, snow or stone crabs for your gumbo).</li><li>Before you fire up the stove again, cut up your celery, parsley, peppers, onions and garlic, especially if you're alone and there is no one to help you stir the pots. It takes time peeling the onions and garlic  Put the celery and parsley in a separate container from the other chopped ingredients and refrigerate until needed to keep them fresh.</li><li>Place the gumbo pot with the shrimp stock on the stove. Add cleaned crabs and bay leaves. Stir slowly. You don't want your shrimp stock messing up the floor. Add celery, parsley, and tomato paste to the gumbo brewing on the stove. Bring to a boil. Turn down heat, cover, and let simmer.</li><li>Here comes the roux -- a thick and flavorful sauce that has become one of the most important staples of Louisiana cuisine. Pour oil or shortening into a separate heavy skillet (please do not use a thin omelet pan) over a medium-low heat. Slowly stir in flour to make the roux. Keep your eyes on the skillet. If the phone rings, let the answering machine pick it up. Cook roux until it has a dark mahogany color. Do not stop stirring until roux appears nutty or grainy. If black specks appear, the roux is burned. Throw it out and start from scratch. A good roux could take 30 to 45 minutes cooking time.</li><li>Now you are ready to add the holy trinity of onions, garlic, and green peppers to the roux mixture. Stir ingredients in slowly because the flour is still sizzling. The moisture will begin to disappear. This is when Jean would add another quart or two of water to the gumbo pot. Add roux to the gumbo pot. Bring to a boil, stirring constantly. Lower heat and cover. The kitchen should smell good right now. Pour yourself another cold something-or-other. You're halfway there. Come back to look and stir in an hour or so.</li><li>Season to taste: add salt, pepper, thyme, Worcestershire sauce, Tabasco sauce and any Creole seasoning you like. Don't overdo it right now. Let the roux work its magic absorbing all the wonderful ingredients. Gumbo is usually very spicy, but you can keep it mild. Remember, if you have decided to use andouille sausage it is also hot.</li><li>Fry sausages and okra with a little bit of the leftover grease. Sprinkle a little leftover flour if the okra is fresh. Add to gumbo pot. Add chopped peeled tomatoes, stirring until well blended. Add more water if necessary. The roux will keep it thick and tasty. Return to a boil and simmer for 10 minutes. Reduce heat and let simmer, uncovered, for 2 1/2 to 3 hours over low heat.</li><li>Skim any excess fat. Add shrimp. Stir in slowly as you increase the heat one last time. It's time to stir in the fil powder. Cook another 20 to 30 minutes until the gumbo is thick. Taste and adjust seasonings one more time. Did I mention the rice? Seafood gumbo is served over Louisiana rice. Of course, you can substitute for your own favorite rice. Just plain old brown or white rice will do. Before serving, taste one more time and adjust seasoning. Turn off heat and remove seafood gumbo from the stove.</li><li>To cool down the pot before serving, place it in the sink with a few inches of ice-cold water. If needed, add additional salt and Tabasco sauce. If you can see through the gumbo to the bottom of the pot, work on your roux next time.</li></ol>	cajun	45	9	f	f	f	t
71	King Cake	https://spoonacular.com/recipeImages/King-Cake-648921.jpg	<ol><li>Scald milk. Pour over butter, sugar and salt. Mix together in large mixing bowl. Let cool to lukewarm. In another bowl, sprinkle yeast on 1/4 cup warm water (or use lukewarm water for compressed yeast). Stir softened yeast into milk mixture. Add beaten eggs. Stir a little flour in, beating until smooth. Add sufficient remaining flour to make soft dough, stirring until dough forms ball which leaves side of bowl.</li><li>Turn dough out onto lightly floured board. Press into flattened ball, about 1 1/2 inch thick. Knead until smooth and elastic, adding only enough flour to keep dough from sticking. Grease mixing bowl. Return dough to bowl, turning dough once to grease its surface. Coat top of dough lightly with softened shortening. Cover with folded kitchen towel. Let rise in warm, not hot, place about 50 minutes, or until double in bulk.</li><li>Punch dough down and turn out onto lightly floured board. Roll out into 10x16 inch rectangle to about 1/4 to 1/2 inch thick. Cut lengthwise into 3 strips. Spread each strip with melted butter. Sprinkle each strip with cinnamon, sugar and ginger mixture. (This is easiest if kept away from edges and mixture is "funneled" in the middle of the strips.) Fold each strip over on long side. Press to seal each strip. "Braid" dough and place on lightly greased baking sheet.</li><li>Cover ring lightly with folded kitchen towel. Let rise in warm place away from draft about 30 minutes or overnight. Bake in preheated 350 degree oven for 24-28 minutes. Drip (drizzle) confectioners' sugar mixture over top of hot bread. Sprinkle with colored "sanding" sugar or colored baking sugar.</li><li>Stuff "baby" or "surprise" into dough, from the bottom or under side after baking.</li></ol>	cajun	45	1	f	f	f	f
72	New Orleans Red Beans and Rice with Andouille Sausage	https://spoonacular.com/recipeImages/New-Orleans-Red-Beans-and-Rice-with-Andouille-Sausage-653055.jpg	<ol><li>Soak the beans overnight in cool water.  The next day, drain and add fresh water to cover beans in Dutch oven. Bring to a boil, then reduce to medium-high heat and simmer for 45-60 minutes or until tender, but not falling apart.  Drain.</li><li>Meanwhile, add oil to a skillet and saute onions, celery and bell pepper until translucent, about 8-10 minutes.  Add garlic and saute for 2 more minutes, stirring occasionally.  Add sauteed vegetables to beans, ham hock, sausage, seasonings, and just enough water to cover.</li><li>Bring to a boil, then reduce heat to a low simmer. Cook for 2 hours at least, preferably 3, until the gravy gets creamy. Adjust seasonings as you go along. Stir occasionally, making sure that it doesn't burn and/or stick to the bottom of the pot.</li><li>If the gravy does not get to the right consistancy, you can scoop some of the beans out and mash them, then return them to the pot and stir. Note: it's not considered cheating:)</li><li>Serve over long-grain rice.</li></ol>	cajun	45	6	f	f	t	t
73	Seafood Gumbo	https://spoonacular.com/recipeImages/Seafood-Gumbo-659638.jpg	<ol><li>Heat oil in a large heavy stockpot over medium-high heat.</li><li>Add the flour and stir constantly until a light brown roux is formed.</li><li>Add the onions, bell pepper, celery and garlic. Saut until the onions become translucent and the vegetables are tender.</li><li>Add the tomatoes and tomato pure and cook over medium heat for 10 minutes.</li><li>Add the Creole seasoning, thyme, bay leaves and about 1/2 teaspoon each of salt and pepper, and continue to cook another 10 minutes.</li><li>Add the okra, and cook for another 10 minutes, then add the stock. Bring to a boil, then reduce heat to simmer and cook another 30 minutes.</li><li>Reduce heat to low.</li><li>About 10 minutes prior to serving, add the shrimp, oysters and oyster liquor. Just prior to serving, add the crab meat (the crab meat does not need to be cooked, just stir until it is heated through.</li><li>Taste and correct seasonings if necessary.</li><li>Remove from heat and sprinkle the fil powder on the surface of the gumbo; cover and let stand for 15 minutes. Uncover and stir to mix.</li><li>Serve hot with French bread and cold beverages.</li></ol>	cajun	45	12	f	f	f	t
74	Authentic Jamaican Curry Chicken	https://spoonacular.com/recipeImages/Authentic-Jamaican-Curry-Chicken-633088.jpg	<ol><li>Season the chicken with all of the ingredients except for the potatoes and water and marinate up to 2 hours or overnight in the fridge.</li><li>Add the oil to a Dutch oven and on high heat, fry the only the chicken pieces until it is brown and seared on each side for about 10 minutes.</li><li>After the meat is nice and brown on both sides, add the remaining vegetable marinade, scotch bonnet pepper and water to the pot, cover and bring to a boil.</li><li>Add the potatoes and lower to a simmer and stew it for about 1 hour until it has a thick consistency.</li></ol>	caribbean	45	4	f	f	t	t
75	Caribbean black bean and sweet potato soup	https://spoonacular.com/recipeImages/Caribbean-black-bean-and-sweet-potato-soup-637099.jpg	<ol><li>Rinse beans and place in a large bowl. Cover beans with   4 inches of water and soak overnight (or 8 hours). Strain and rinse black beans.</li><li>In a large soup pot, heat the oil over medium heat. Add onion and jalapeno and saut for 10 minutes, until soft.</li><li>Add beans and vegetable broth or water. Stir in ginger, allspice, thyme and salt. Bring to a boil, then reduce heat and simmer for 1 hour 30 minutes.</li><li>Add sweet potatoes and brown sugar and simmer for an additional 30 minutes, until beans and sweet potatoes are soft.</li><li>Puree 1 cup of the soup in a blender and then add it back into the soup pot. Stir in cilantro and green onion. Salt and pepper to taste.</li></ol>	caribbean	45	6	t	t	t	t
76	Caribbean Chicken Thighs	https://spoonacular.com/recipeImages/Caribbean-Chicken-Thighs-637103.jpg	<ol><li>Prepare marinade: In a food processor, add lime juice, garlic, onion, jalapeno, and green onion . Pulse until pureed.</li><li>Pour into a small bowl, add pineapple juice, brown sugar, and spices. Mix together.</li><li>In a gallon plastic bag, add chicken, and marinade. Mix together. Place in fridge and let marinate for at least 4 hours to 24 hours.</li><li>Preheat broiler. Remove from bag and place chicken skin side down in a baking sheet lined with aluminum foil. Cook for 5 minutes till the tops are no longer pink. Flip over and cook for remaining 25 minutes till the skin is crispy.</li><li>Serve immediately. Enjoy!</li></ol>	caribbean	45	2	f	f	t	t
77	Caribbean Truffle Pie	https://spoonacular.com/recipeImages/Caribbean-Truffle-Pie-637116.jpg	<ol><li>Heat oven to 450 degrees. Allow 1 crust pouch to stand at room temperature for 15 to 20 minutes. (Refrigerate remaining crust for a later use.) Remove pie crust from pouch. Unfold crust; remove plastic sheet. Sprinkle with 2 tablespoons coconut; press in lightly. Carefully lift crust off second plastic sheet. Place crust, coconut side up, in 9-inch pie pan; press in bottom and up sides of pan. Flute edge; prick crust generously with fork. Bake at 450 degrees for 9 to 11 minutes or until golden brown. Cool crust while preparing streusel and filling. Reduce oven temperature to 425 degrees.</li><li>In small bowl, combine flour and 1/4 cup sugar. With pastry blender or fork, cut in butter until mixture resembles coarse crumbs. Stir in 1/4 cup coconut. Spread mixture in ungreased shallow baking pan. Bake at 425 degrees for 4 to 8 minutes or until golden brown, stirring every minutes. Set aside.</li><li>In medium saucepan, combine pudding mix, 1/2 cup sugar, lime juice and egg yolks; mix well. Stir in 2 cups water. Cook and stir over medium heat until mixture comes to a full boil. Remove from heat; stir in lime peel. In small bowl, combine white chocolate chips and 1/2 cup of the hot pudding mixture; stir until chips are melted.</li><li>In small bowl, beat cream cheese until light and fluffy. Add white chocolate chip mixture; beat until smooth. Spoon and spread in baked crust. Stir sour cream into remaining pie filling mixture; blend well. Spoon and spread over cream cheese layer. Refrigerate 2 hours or until chilled.</li><li>In small bowl, beat whipping cream until stiff peaks form. Pipe or spoon around edge of pie; garnish with line slices. Sprinkle streusel in center of pie. Store in refrigerator. </li></ol>	caribbean	150	8	f	f	f	f
78	Trinidad Callaloo Soup	https://spoonacular.com/recipeImages/Trinidad-Callaloo-Soup-663822.jpg	<ol><li>Saute onion, okra, salt pork, thyme, garlic, habanero and scallions until the okra and onions brown.</li><li>Stir in the callaloo with the chicken stock and simmer until the callaloo is tender.</li><li>Puree with a stick blender. Adjust seasoning to taste with salt and pepper.</li><li>Stir in coconut milk and crab, then warm gently.</li><li>Serve with rice.</li></ol>	caribbean	45	4	f	f	t	t
79	Rice and Peas with Coconut Curry Mackerel	https://spoonacular.com/recipeImages/rice-and-peas-with-coconut-curry-mackerel-716364.jpg	Pour 1 cup of coconut milk in a pot with 1 seasoning cube and allow to boil for a minute. Pour in your rice and peas in the boiling coconut milk and pour 2 cups of water and leave to boil till the rice and peas are soft on low heat. In a separate pot, season and bring the mackerel to boil in the rest of the coconut milk, curry powder and some water. Toss in the chopped onion, scotch bonnet peppers and garlic and allow to simmer on medium heat. Once the fish is cooked, add the corn starch to thicken the sauce and allow to simmer for 4 minutes on low heat. Serve with the rice and peas	caribbean	45	4	f	f	t	t
80	A Christmas With Peking Duck	https://spoonacular.com/recipeImages/A-Christmas-With-Peking-Duck-631888.jpg	<ol><li>Rinse duck and remove innards. Cut skin around neck and remove tail.</li><li>Hang duck neck-side-up over a large pot. Boil water.</li><li>Pour boiling water over the duck until skin is puffed up. Remove boiled water from pot.</li><li>Combine salt, white pepper, five spice powder and 2 tsp of hoison sauce.</li><li>Brush mixture on the outside and inside of the duck to marinate it.</li><li>Let mixture dry - about 2 hours.</li><li>Combine corn syrup, honey, rice vinegar and brush outside of the duck. Let duck air dry for 12-24 hours.</li><li>Preheat oven to 450 degrees. Roast duck for 40 minutes.</li><li>Let meat rest for 15 minutes after cooking. Cut the meat into thin slices and enjoy. Serve with Bao, Chinese pan cakes add hosin sauce and scallions.</li></ol>	chinese	45	12	f	f	t	t
81	Chinese Chicken Salad With Chipotle Dressing	https://spoonacular.com/recipeImages/Chinese-Chicken-Salad-With-Chipotle-Dressing-638642.jpg	<ol><li>Dressing:</li><li>Whisk together the vinegar, peanut &amp; almond butters, ginger, chipotle pepper puree, soy sauce, honey, sesame oil, and canola oil in a medium bowl. Season with salt and pepper, to taste.</li><li>Salad:</li><li>Combine cabbage, lettuce, carrots, snow peas, cilantro, and green onion in a large bowl. Add the dressing and toss to combine.</li><li>Transfer to a serving platter and top with the shredded chicken, chopped peanuts, and mint. Drizzle with chili oil, if desired.  Garnish with lime halves.</li></ol>	chinese	45	4	f	f	t	t
82	Chinese Chicken Salad With Creamy Soy Dressing	https://spoonacular.com/recipeImages/Chinese-Chicken-Salad-With-Creamy-Soy-Dressing-638649.jpg	<ol><li>Whisk mayonnaise, soy sauce and ginger together in a large bowl until blended.</li><li>Add chicken, snow peas, peppers, carrots and green onion; toss to mix and coat.</li><li>Serve over torn spinach leaves.</li></ol>	chinese	30	2	f	f	t	f
83	Chinese Five Spice Braised Pork Belly With Lotus Root and Steamed Yucca	https://spoonacular.com/recipeImages/Chinese-Five-Spice-Braised-Pork-Belly-With-Lotus-Root-and-Steamed-Yucca-638662.jpg	<ol><li>How to Steam Pork Belly:</li><li>Take a large pot and fill it a quarter of the way up with water.  Take your pork belly and place it in a heatproof bowl.  Add 1/4 cup of ShaoHsing Cooking Wine and one cinnamon stick and place it on a steamer rack inside the large pot.  Cover pot and allow pork to steam for 10-15 minutes or until the meat feels firm to the touch.</li><li>In a large heavy bottomed pot, heat the oil at medium high heat.  When almost smoking, add the spices along with the ginger, garlic and shallots.  Once the spices are aromatic, add the pork belly along with the cooking wine and remaining liquids to the pot.  Stir to mix well and add the rock sugar.  Once sugar is dissolved, reduce mixture to low heat and braise for 2 hours.  If the liquid becomes too low, simply add more water and adjust the sweetness and salty level to your tastes.</li><li>Peel the lotus root and cut into thin slices.  Place in the braising liquid and cook until slightly tender, about 20 minutes.  It will have a nice starchy and crunchy texture to it.  Meanwhile, take the yucca and place it in a heat proof bowl.  Allow to steam until cooked through, about 30 minutes.  Once done, peel off the skin and mash the yucca to a paste.  Add a little bit of salt and sesame oil, set aside until ready to serve.</li></ol>	chinese	180	2	f	f	t	t
84	Chinese Hot Pots Gluten-Free and Low-Carb	https://spoonacular.com/recipeImages/Chinese-Hot-Pots-Gluten-Free-and-Low-Carb-638668.jpg	<ol><li>In a large pot, bring the chicken stock, water, vinegar, soy sauce, sesame oil, ginger and garlic to a boil.</li><li>Add the chicken and simmer for 5-7 minutes, until just cooked through. Add the noodles. Stir, then cover and remove from heat.</li><li>Meanwhile chop all the veggies and place in serving bowls.</li><li>When ready to serve, allow each person to fill their bowls with fresh vegetables and a bit of chile sauce.</li><li>Then ladle the scalding hot soup over the veggies and let them sit for 5 minutes.</li><li>Mix and eat!</li></ol>	chinese	25	6	f	f	t	t
85	Five Spice Chinese Pork Stew	https://spoonacular.com/recipeImages/Five-Spice-Chinese-Pork-Stew-643011.jpg	<ol><li>In a large pot, add the pork with the rest of the ingredients for boiling. Add water, enough the cover by pork by 1/2 inch.</li><li>Boil on medium heat until the pork is fork tender. Once done, remove the pork from the pot.</li><li>Reserve the stock and run it through a fine sieve to strain the impurities.</li><li>In a wok or large pan, heat the oil and add the garlic. Allow to toast but be careful not to burn it.</li><li>Add the shallots and the white onion and saute until it sweats and goes slightly limp. Add the ginger and fry until very fragrant. Remove around 1/4 of the onion and ginger and reserve for garnish.</li><li>Add the pork and mix everything well until the pork is lightly toasted, around 2-3 minutes. Add the pork stock (the water used to boil the pork), followed the the soy sauce.</li><li>Add in the remaining ingredients and mix well. Cover the pot and allow the stew to reduce for 2  3 minutes. Add the mushrooms and cook for another minute. Remove from pan and serve hot, garnished with the sauteed onions and ginger, and with a heaping scoop of rice. Enjoy!</li></ol>	chinese	45	6	f	f	t	t
86	Fried Wonton	https://spoonacular.com/recipeImages/Fried-Wonton-643829.jpg	<ol><li>Cook in pan for 3-4 minutes.</li><li>Ketchup</li><li>Sugar</li><li>Garlic powder</li><li>Salt</li><li>Some water</li></ol>	chinese	45	1	f	f	t	t
87	Gluten Free Dairy Free Sugar Free Chinese Chicken Salad	https://spoonacular.com/recipeImages/Gluten-Free-Dairy-Free-Sugar-Free-Chinese-Chicken-Salad-644826.jpg	<ol><li>For the salad:</li><li>Finely slice the red, and green cabbage.</li><li>Remove ends and finely slice romaine lettuce.</li><li>Trim ends of scallions (white and green side) and finely slice.</li><li>Peel and grate carrots, or put into a mini food processor to finely chop.</li><li>Peel clementines then remove pith from slices.</li><li>Add all the ingredients into a large serving bowl.</li><li>For the dressing:</li><li>Add all the ingredients into a glass jar and shake until well blended, or whisk all the ingredients in a mixing bowl.</li><li>Pour dressing over salad, toss to combine well.</li><li>If making ahead, dress the salad just before serving.</li></ol>	chinese	45	6	f	f	t	t
88	Healthier Pork Fried Rice	https://spoonacular.com/recipeImages/Healthier-Pork-Fried-Rice-646425.jpg	<ol><li>1. Prepare Rice: Place 1 cup of rice, 2 cups of water ( or whatever the rice directions say) and the ginger slices in a medium pot. Bring to a boil, cover and them reduce heat to low. Simmer until rice is tender, about 20 minutes. Once done, take ginger slices out of pan.</li><li>2. Prepare pork: Meanwhile, preheat oven to 350 degrees Fahrenheit and a grill pan ( or grill) to high heat). Slice pork tenderloin into 1/2 inch strips and season strips with, garlic, onion, ginger, pepper and salt on both sides. Once the grill pan is hot, add the pork. Cook 3 minutes per side to get some good grill marks. Once done. Place on baking sheet and in over for 2 minutes. Take out of oven set aside and let rest.</li><li>3. In a frying pan or large pan on medium high heat, add olive oil. Once oil is hot, add garlic, ginger and green onion, cooking until onion is tender, about 1 minute ( make sure to stir garlic so it does not burn). Add peas and carrots, stir and cook until vegetables are tender about 3 minutes. Add eggs over veggies and stir till scrambled, about 1 minute. Add rice to pan. Gently fold rice in. Remove from heat. Add Pork, soy sauce and hoisin ( you may want to add more later, but go slow, it gets very strong quickly). Gently stir together till all rice is coated in sauce.</li><li>4. Serve and enjoy!</li></ol>	chinese	45	3	f	f	t	t
89	Noodles With Chinese Kale and Shitake Mushrooms	https://spoonacular.com/recipeImages/Noodles-With-Chinese-Kale---Shitake-Mushrooms-653255.jpg	<ol><li>Saute sliced shallots in 3 tbsps of oil until golden brown (see photo above). Remove the fried shallots and spread them out on a flat plate. Leave the remaining shallots-infused oil in the pan/wok.</li><li>Heat up the oil and saute the  mushrooms until aromatic.</li><li>Add garlic and saute further until aromatic.</li><li>Add kale and 2 tbsps of water. Cook until the vegetables become slightly soften.</li><li>Add noodles, sweet soy sauce and oyster sauce and mix to combine all the ingredients. If the noodles start to stick at the bottom of the pan/wok, add a little water. Cook for 3-5 minutes.</li><li>Sprinkle fried shallots over the noodles just before serving. You can  garnish the noodles with some fresh spring onions and chilles. It also goes well with sambal.</li></ol>	chinese	45	1	f	f	f	t
90	Pan Fried Pork and Chive Potstickers	https://spoonacular.com/recipeImages/Pan-Fried-Pork-and-Chive-Potstickers-654408.jpg	<ol><li>Begin by making the dough. Combine water and flour and mix until all flour is just incorporated. Let dough rest for 10 minutes.</li><li>Next, make the filling. Mix the pork, chives, dried shrimp, salt and sesame oil.</li><li>Youre now ready to start making your wrappers and filling the dumplings. Roll out the dough into long sushi roll and cut into small round 1 inch pieces.</li><li>Use a small rolling pin to flatten it into a wrapper about 3 inches wide.  You are looking for wrappers about the same thickness as gyoza, so when rolling out your own dough, its pretty thin.  Its really an art  you make small balls about 1-inch in diameter, then smash down with your hand.  Roll the pin around the edges until you get your thin wrapper, leaving it a little thicker in the middle and thinner on the edges.</li><li>Sprinkle some flour on a clean surface on the kitchen counter.</li><li>Place each wrapper on the floured surface with the floured side facing up.</li><li>Put 1 heaping tsp of the filling in the center of each wrapper.</li><li>Wet your finger in the cup of water and wet all around the outer edge of the wrappers.</li><li>Close it by folding it up and pressing two wetted sides together.</li><li>Set it down on a flat surface and make the bottom flat.</li><li>After about 20 to 30 finished dumplings, you can set a non-stick flat bottom skillet on the stove.</li><li>Add 1 tablespoon of vegetable oil in it and place the dumplings all around the skillet.</li><li>Add two cups of cold water, and then put a lid on the skillet. Turn the temperature to high.</li><li>When the water is dry, turn the fire to low. Take out the dumplings when they are golden brown and crispy at the bottom.</li><li>Serve with soy dipping sauce of chopped garlic, 1/2 c. of soy, 1/3 c. of rice wine vinegar, 1/2 tsp. of salt, 1/2 tbs. of sugar and 1/2 tbs. of sesame oil. If you like things hot, you can make a spicier dipping sauce out of hot chili paste, soy sauce and sesame oil.</li></ol>	chinese	45	1	f	f	f	t
91	Pork Fried Rice	https://spoonacular.com/recipeImages/Pork-Fried-Rice-656777.jpg	<ol><li>Cut pork into 1/4 inch slices, then cut into 1/4 inch strips and set aside.</li><li>Heat half the oil in a hot wok until the surface begins to quiver. Pour in beaten eggs and allow to cook for 10 seconds, then fold egg mixture over onto itself with a spatula and lightly scramble for about 1 minute. Carefully remove egg from wok with a spatula and drain on paper towel. Set aside.</li><li>Heat remaining oil in hot wok and stir fry onion and ginger for 30 seconds. Add sugar and stir fry for 30 more seconds. Add pork and stir fry for a further 30 seconds. Stir in hoisin sauce, soy sauce, vinegar, and sesame oil and cook, stirring, for 1 minute. Toss in rice and cooked egg and stir, using a spatula to break up the egg into smaller pieces, for 1 minute. Finally, add green onions and stir fry for a further 30 seconds or until well combined and rice is heated through.</li><li>Transfer rice to a platter and serve.</li></ol>	chinese	45	4	f	f	t	t
92	Skinny Veggie Fried Rice	https://spoonacular.com/recipeImages/Skinny-Veggie-Fried-Rice-660231.jpg	<ol><li>Heat a wok or skillet on med-high and add 1 tsp oil. To it add minced ginger and 1 tsp minced garlic. Saute until fragrant but not burnt. Add mushroom pieces. Cook until tender for 5-6 minutes. Keep mushrooms along with any juices aside in a bowl.</li><li>Heat wok again add 1 tsp oil. To it add remaining garlic. Saute until fragrant and add all the vegetables. Stir it all together on high flame. Add salt, black pepper and splash of soy sauce. Toss to coat and let them cook for few more minutes until they get tender but not soft. You want veggies to be cooked but with a little crunch. Now add the cold already cooked rice and stir it so it all gets mixed together. Do with a gentle hand. Let the rice get warm at med- high flame.Add the remaining 1 tsp oil along with salt, black pepper and soy sauce. Add the mushrooms and tofu(if using). Mix it all together. Toss and taste.</li><li>Garnish with chopped green parts of green onions and sesame seeds.</li></ol>	chinese	45	2	t	t	t	t
93	Stuffed mushrooms and Chow Mein noodles	https://spoonacular.com/recipeImages/Stuffed-mushrooms-and-Chow-Mein-noodles-662054.jpg	<ol><li>Blanch the spinach in a very little water in the microwave oven for 3 minutes on MAX. Drain and coarsely chop. Chop mushroom stems in a blender.</li><li>Melt the butter over low heat, add the onion and cook for 1 minute. Add chopped mushroom stems, and saut for 4-5 minutes, stirring often.</li><li>Add chopped spinach; stir well and saut 2 more minutes. Remove from the heat.</li><li>Mix and combine with a fork in a separate bowl ricotta, blue cheese, chives and pepper into a fine mixture, almost a paste.</li><li>Add chopped stalks and spinach mixture, stir and combine thoroughly.</li><li>Using a small teaspoon, place mounds of filling on the top of each mushroom cap, pressing slightly to get it down into the cavity.</li><li>Mix breadcrumbs and grated Parmesan cheese, sprinkle evenly over each mushroom. Drizzle each filled cap with olive oil.</li><li>Place the mushroom caps on a baking sheet lined with parchment paper or silicon sheet, and bake in the oven at 180C for 20 minutes or until the cheese browns a little. Allow to cool for 5 minutes or so before serving.</li><li>Meanwhile cook the Chow Mein or rice noodles as directed on the package; drain.</li><li>Mix and combine garlic, sour cream and salt and stir into the cooked pasta.</li><li>Sprinkle with chopped parsley and served with stuffed mushrooms.</li></ol>	chinese	45	2	f	f	f	f
94	Vegetable Fried Rice	https://spoonacular.com/recipeImages/Vegetable-Fried-Rice-664553.jpg	<ol><li>Cook the basmati rice with 4 cups water..</li><li>Meanwhile, in a saucepan add the oil and fry the onions..</li><li>Once they turn soft and translucent add the ginger garlic paste and green chilies and saute for a minute..</li><li>Then add all the vegetables,salt and pepper..</li><li>Sprinkle very little water and allow the veggies to cook for two minutes..</li><li>They should be half cooked..</li><li>Now add the soya sauce and chili sauce..</li><li>Now add the cooked rice to this vegetable mixture and stir this mixture for a minute or two in low flame..</li><li>Roast some cashews and raisins in ghee and also add them..</li><li>If you dont like the sweet taste you can omit the raisins..</li><li>Fried rice is ready..</li><li>It tastes good when served with gobi Manchurian..</li><li>Or just tomato sauce and raita will do..</li></ol>	chinese	45	2	t	t	t	t
95	Salmon Fried Rice	https://spoonacular.com/recipeImages/salmon-fried-rice-667701.jpg	<p><strong>1</strong> Dissolve the brown sugar in the soy sauce in a small bowl. Set aside.</p><p><strong>2</strong> Heat the olive oil in a large sauté pan or wok on medium high heat. Add the diced red onion and bell pepper and sauté until lightly browned, about 5 minutes. Lower the heat to medium and stir in the garlic and grated ginger. Cook for a minute more.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-1.jpg" alt="salmon-fried-rice-method-600-1"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-2.jpg" alt="salmon-fried-rice-method-600-2"></p><p><strong>3</strong> Add the beaten eggs and stir until just cooked. Add the cooked rice, increase the heat to medium high and cook for a couple minutes more, stirring often.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-3.jpg" alt="salmon-fried-rice-method-600-3"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-4.jpg" alt="salmon-fried-rice-method-600-4"></p><p>Add the peas, salmon, and green onions. (Be gentle with the salmon so you don't break it up too much.) Stir in the soy sauce mixture and remove from heat.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-5.jpg" alt="salmon-fried-rice-method-600-5"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-6.jpg" alt="salmon-fried-rice-method-600-6"></p><p>Garnish with cilantro to serve, serve immediately.</p>	chinese	25	4	f	f	t	t
96	Mango Fried Rice	https://spoonacular.com/recipeImages/mango-fried-rice-716311.jpg	Wash your rice and bring to boil on medium heat with very little water as you are still going to cook it in chicken stock. Once the rice is slightly soft and the initial water has dried up, reduce the heat and pour in the chicken stock and cook till the chicken stock is all absorbed and has dried up. The chicken stock if freshly made will have some oil from the chicken so your rice does not need oil. Increase the heat and stir in the chopped vegetables and pepper. Add your seasoning cube. Finally stir in your cubed mango and serve warm with any protein of your choice. I’d say chicken but it’s up to you.	chinese	45	2	t	t	t	t
97	Cauliflower Fried Rice - More Veggies Than Rice (But Your Kids Won't Notice)	https://spoonacular.com/recipeImages/cauliflower-fried-rice-more-veggies-than-rice-(but-your-kids-wont-notice)-716426.jpg		chinese	45	2	t	t	t	t
98	Austrian Goulash	https://spoonacular.com/recipeImages/Austrian-Goulash-633063.jpg	<ol><li>You will need a large Dutch oven with a lid for best results. Add just enough olive oil to coat the pan and turn the heat high enough to make the oil shimmer, but not smoke.</li><li>Pat the meat dry and dredge in flour, seasoned with kosher salt & cracked pepper.</li><li>Add one piece of meat to the hot oil to make sure that it sizzles. Add the remaining meat, without crowding the pan and sear for about 3-4 minutes per side. You want a golden crust that will give the gravy great flavor.</li><li>Cook the meat in batches, if necessary and set aside in a bowl-- to collect the juice.</li><li>When all the meat is seared, turn the heat to medium and add a little more olive oil to the pan and cook the onion until tender-- 3-4 minutes. Add the sliced garlic and cook till fragrant-- 30 seconds or so.</li><li>Add the tomato paste and paprika, and cook for 1-2 minutes.</li><li>Add the tomato sauce, caraway seeds, lemon zest and chicken stock and stir well.</li><li>Bring to a simmer for about 15 minutes and taste for seasoning. Adjust as necessary. If the sauce is too thick, thin with a little more chicken stock or water until it is the consistency of a gravy.</li><li>Simmer for 2 hours, or you can use a slow cooker for 4-6 hours.</li><li>This stew tastes even better if made one day in advance.  Serve or buttered egg noodles or spaetzle or Bavarian Bread Dumplings-- recipes coming soon to my blog!</li></ol>	easternEuropean	45	12	f	f	f	t
99	Beef Stroganoff with Bella Mushrooms	https://spoonacular.com/recipeImages/Beef-Stroganoff-w-Bella-Mushrooms-634699.jpg	<ol><li>1. Cut beef across grain into thin 2-inch strips or preferred sizes. For easier slicing, place beef in the freezer for about an hour. Cut the onions into thin rings, mushrooms thinly sliced (decapping is optional).</li><li>2. Cook beef strips in non-stick pan or skillet over medium heat for about 5 minutes or until browned. Add the mushrooms, onions, minced garlic, and butter, stirring occasionally, until onions are tender.</li><li>3. Meanwhile, in a sauce pan add the water and beef stroganoff sauce packet, stir constantly to avoid clumping. Cook according to packet directions, while adjusting the amount of sour cream and Worcestershire sauce according to taste preference. For extra sauce, add in beef broth or water.</li><li>4. Stir in the sauce with the beef mixture and cook for another 5 minutes or until sauce thickens up.</li><li>5. Top the sauce over the cooked egg noodles and garnish with parsley flakes. Enjoy!</li><li>*For original beef stroganoff sauce, simply melt 1 tbsp butter in pan over medium heat. Add 2 tbsp flour. Cook 1 minute, stirring with a whisk. Gradually add 1 cup beef broth and 1 tbsp Worcestershire sauce, stirring constantly. Cook 1 minute or until thickened and bubbly, stirring constantly to avoid clumping. Remove from heat and lastly add the sour cream. Add salt and pepper according to taste.</li></ol>	easternEuropean	45	4	f	f	f	f
100	Buckwheat Blini	https://spoonacular.com/recipeImages/Buckwheat-Blini-636388.jpg	<ol><li>In a large bowl, combine buckwheat flour, all purpose flour, 1 tablespoon sugar, and 1 teaspoon salt. In a medium bowl, combine warm milk and yeast, stirring until combined. Whisk in egg yolks and melted butter. Add milk mixture to dry ingredients and stir just until combined. Add beer, and stir to combine.</li><li>In a large bowl, combine egg whites, pinch of salt, and pinch of sugar. Beat egg whites until soft peaks form. Gently, but thoroughly, fold egg whites into batter. Cover, and let rise for 1 1/2 hours.</li><li>Heat a plett pan (Swedish pancake pan), which will keep your blini at a uniform size, or a skillet over medium heat until hot. Lightly oil pan and, using a 2-ounce ladle, pour batter into pan. Cook 45 seconds, turn, and cook for an additional 30 seconds.</li><li>These can also be baked: Heat oven to 500 degrees to 550 degrees. Use lightly oiled 2- to 2 1/2-inch diameter nonstick pans. Bake 4 to 5 minutes on one side, turn, and bake an additional 1 minute.</li><li>Serve the blini with smoked caviar and smoked salmon, and top with creme fraIche and lemon.</li><li>This recipe yields 20 blini.</li><li>Yield: 20 blini</li></ol>	easternEuropean	45	1	f	f	f	f
101	Duck Egg Omelette With Caviar and Sour Cream	https://spoonacular.com/recipeImages/Duck-Egg-Omelette-With-Caviar-and-Sour-Cream-641700.jpg	<ol><li>An omelette pan with a 15cm (6") base.</li><li>Make the omelettes one at a time.</li><li>Mix 2 eggs in a bowl with half the water, salt & pepper & beat lightly.</li><li>Melt some butter in pan over moderately high heat.</li><li>Add eggs when it is foaming.</li><li>Leave for a few seconds, then tilt pan & with a fork draw the egg from the edges into the centre so that the liquid egg flows into the space.</li><li>Continue for about 30 seconds until almost all the liquid egg has gone.</li><li>Then roll the omelette rather like a spring roll, tipping it onto a warm dinner plate.</li><li>Using a small sharp knife, make a slit down the centre of the omelette, spoon over some of the sour cream, top with half of the caviar, scatter with a little dill and serve immediately.</li><li>Make the 2nd omelette in the same way.</li></ol>	easternEuropean	45	2	f	f	t	f
102	Easy Weeknight Beef Stroganoff	https://spoonacular.com/recipeImages/Easy-Weeknight-Beef-Stroganoff-642147.jpg	<ol><li>In a large skillet  brown the steak and onions on medium high x 4 minutes. Add mushrooms and cook for another 2-3 minutes.</li><li>Stir in water and bring to a boil. Add the noodles and bring to a boil again. Reduce to simmer and cook x 7 minutes until the noodles are done.</li><li>Add the other ingredients, simmer until velveeta is melted. Adjust salt and pepper to taste.</li></ol>	easternEuropean	45	8	f	f	f	f
103	German Goulash	https://spoonacular.com/recipeImages/German-Goulash-644476.jpg	<ol><li>Cut roast in 1 inch cubes. In Dutch oven, brown meat, and onions in oil. Add water, bouillon cubes, flour, tomato sauce, paprika, and pepper. Simmer low for 2 hours, until meat is tender.</li><li>Serve over egg noodles.</li><li>This dish cooks up very well in a crock pot.</li></ol>	easternEuropean	45	4	f	f	f	t
104	Hungarian Beef Goulash	https://spoonacular.com/recipeImages/Hungarian-Beef-Goulash-647645.jpg	<ol><li>In a 3 1/2, 4 or 5 quart crockery cooker, place potatoes, onions and garlic.</li><li>Add beef. In a bowl combine broth, undrained tomatoes, tomato paste, paprika, caraway or fennel seed and salt. Pour over all. cover; cook on low heat setting for 10-12 hours or on high heat setting for 5-6 hours. Stir thawed artichoke hearts into cooker. Cover and let stand for 10 minutes. Serve over hot cooked noodles. Top each serving with a spoonful of sour cream.</li><li>Makes 6 servings.</li></ol>	easternEuropean	45	6	f	f	f	f
105	Hungarian Goulash Soup	https://spoonacular.com/recipeImages/Hungarian-Goulash-Soup-647656.jpg	<ol><li>Heat butter in large pan and fry onion until golden brown.  </li><li>Add meat and fry 5 more minutes.</li><li>Add carrot, green pepper, tomatoes, paprika, salt, pepper, and garlic salt. Stir well. </li><li>Add 3/4 pint water, cover and simmer for 1 hour, adding more water, if necessary.</li><li>Before serving, add cream. For variation, add a pinch of cumin and 2 cubed, peeled potatoes for the last 30 minutes of cooking.</li></ol>	easternEuropean	45	2	f	f	t	f
106	Hungarian Plum Dumplings	https://spoonacular.com/recipeImages/Hungarian-Plum-Dumplings-647659.jpg	<ol><li>Go to my blog for the full instructions: http://gourmandelle.com/hungarian-plum-dumplings-with-vegansugar-free-version/</li></ol>	easternEuropean	45	25	t	f	f	t
107	Hungarian Potato Soup	https://spoonacular.com/recipeImages/Hungarian-Potato-Soup-647661.jpg	<ol><li>In soup pot, saute celery and onions in oil until limp. Add to soup pot: parsley, potatoes, pepperoni chunks, pepper corns, Bay leaves and 2 quarts of water.</li><li>Simmer slowly for at least one hour, until potatoes are soft.</li><li>Add the 3 Tbsp. of vinegar. Taste and if soup does not have enough salt, add to taste. While soup is simmering, break 6 raw eggs, one egg at a time, into the pot. Space them so they will cook to a firm stage, without touching one another.</li><li>Do not stir soup! Serve soup, eggs and chunks of sausage in each soup plate. Put a heaping tablespoon of sour cream in each plate. Serve with good bread.</li><li>Serves 6.</li></ol>	easternEuropean	45	6	f	f	t	f
108	Hungarian Pot Roast	https://spoonacular.com/recipeImages/Hungarian-Pot-Roast-647662.jpg	<ol><li>And Jars"</li><li>Trim excess fat off meat. Sprinkle with paprika, salt and pepper. Brown in oil in Dutch oven over medium heat. Add water and bay leaf; simmer, covered, 2 hours, or until meat is almost tender. Place onions and carrots around meat. Add Hunt's tomato sauce, garlic and onion salt. Cover; simmer 50 minutes longer until meat and vegetables are tender. Just before serving, remove from heat and gradually stir in sour cream, if desired.</li></ol>	easternEuropean	45	1	f	f	t	f
109	Kielbasa With Brussels Sprouts In Mustard Cream Sauce	https://spoonacular.com/recipeImages/Kielbasa-With-Brussels-Sprouts-In-Mustard-Cream-Sauce-648895.jpg	<ol><li>Peel the shallot and cut into quarters.  Make a small pouch out of aluminum foil (2 layers thick) and place inside the shallot and garlic.  Coat with olive oil and a generous pinch of salt.  Seal the pouch tightly and place in the oven (I recommend the toaster oven) at 400F for 30 minutes.</li><li>Rinse and pick clean the brussels sprouts.  Cut each sprout in half, discarding any wilted or fugly outer leaves.  Steam (or boil, your choice) the brussels sprouts until tender when pierced with a fork.  Set aside.</li><li>Rinse and drain the beans.  Honestly, 1 can is a little too bean-heavy.  You may want to save about 1/3 of the beans for something else.  I know, Im telling you now after youve bought a whole can, as opposed to buying 2/3 of a can.</li><li>Slice the kielbasa on a steep bias into 1/4 slices.  Heat 1 tsp. of olive oil in a large, heavy bottomed non-nonstick skillet over medium high heat.  Arrange the kielbasa slices and fry until crispy on each side, about 3 minutes per side.  Itll smell like bacon, confusing your dog.  Set aside (the kielbasa, not your dog) on paper towels to drain.</li><li>If your skillet is full of porky goodness, keep it there.  Add a generous tablespoon of good olive oil and keep the heat at medium high.  Unwrap the garlic and shallot and smash them using the flat side of your knife.  They should be very soft.  Add them to the skillet and cook for about 1 minute.</li><li>Add the mustard and cream to the skillet and stir to combine.  Reduce the heat to medium low and add the brussels sprouts and beans (as many as you want to use).  Toss everything together to coat, then season to taste with a generous amount of salt and black pepper.</li><li>Plate the kielbasa on top of your brussels sprouts and beans in a large bowl to serve.</li></ol>	easternEuropean	45	4	f	f	t	f
110	Salmon, Watercress, Fennel and Baby Beetroot Salad With Lemony Caviar Dressing	https://spoonacular.com/recipeImages/Salmon--Watercress--Fennel-and-Baby-Beetroot-Salad-With-Lemony-Caviar-Dressing-659143.jpg	<ol><li>Place the salmon in a pan, cover with water, and add the wine, bay and tarragon stalks.  Bring to the boil and then immediately turn off and leave for a couple of minutes to cook in the residual heat. Remove to a plate with a slotted spoon and leave to cool before flaking into large pieces.</li><li>Make the dressing by lightly whisking the olive oil and lemon juice together. Stir in the Arnkha MSC and season with some black pepper.</li><li>Next, arrange the watercress, beets and fennel in 4 shallow salad bowls, then add the salmon and tarragon.  Drizzle over the Arnkha MSC dressing and serve.</li></ol>	easternEuropean	45	4	f	f	t	t
111	Transylvanian Goulash	https://spoonacular.com/recipeImages/Transylvanian-Goulash-663792.jpg	<ol><li>Wash sauerkraut under cold running water then soak in cold water for 20 minutes to reduce sourness. Strain well, pressing out excess water.</li><li>NOTE: I am a big fan of searing meat, because I think it gives sauces a deeper flavor. While the original recipe didn't say to do this-- I plan to sear the pork in some olive oil and then to continue with cooking the onion and garlic and carrying on with the rest of the steps.</li><li>Melt butter in a 5-quart casserole; add the onions. Cook over medium heat, stirring occasionally until lightly colored, 6 to 8 minutes.</li><li>Add the garlic, season with salt and cook a minute or two longer.</li><li>Stir in paprika, pour in 1/2 cup of broth and bring to boil.</li><li>Add the pork cubes. Spread sauerkraut over pork sprinkle with caraway seeds. Combine tomato puree, tomato paste and reserved broth, in a small bowl. Mix well and pour over sauerkraut. Bring to a boil.</li><li>If using a crock-pot, transfer contents of casserole to crock-pot insert. Cover, and cook on high, for 3 to 3-1/2 hours, or until pork is fork tender but still retains its shape.</li><li>If using a conventional oven, preheat to 250 degrees F. Cover casserole and transfer to the oven. Cook, covered, for 3 to 3-1/2 hours, or until pork cubes are tender but still retain their shape.</li><li>When the pork is tender, transfer meat and sauerkraut to a serving platter with high sides. Tent with foil to keep warm.</li><li>Transfer the sauce to a 2-quart pan. Set over medium heat. Combine flour, heavy cream and sour cream in a small bowl. Whisk until smooth. Stir mixture into sauce and simmer for 10 minutes longer. Do not boil. Season to taste with salt and pepper. Pour over meat and serve. Pass additional sour cream as a side.</li><li>NOTES: I added 2 Tablespoons of tomato paste to this recipe, which we thought gave the sauce deep depth of flavor. We also served this over creamy mashed potatoes. This freezes really well.</li></ol>	easternEuropean	45	8	f	f	f	f
112	Turkey Goulash	https://spoonacular.com/recipeImages/Turkey-Goulash-By-Mommie-Cooks-664031.jpg	<ol><li>If you're using ground turkey, start out by browning it up, then adding in your garlic, onion, and pepper. Cook it for 3-4 minutes. If you're using leftover cooked turkey, cook up the garlic, onion, and pepper in a tablespoon of oil for 3-4 minutes on medium heat and then add in the turkey.</li><li>Next you'll add in your spices; the garam masala, paprika, cumin, ginger, curry and coriander. Add in your tomatoes and stir it all together.</li><li>Next up you'll add in the stock and let it cook on medium heat for about 5 minutes.</li><li>Add in your spinach and give it a whirl or two until it heat up and wilts down into your meal.</li><li>Now stir in your cup of sour cream.</li><li>The final step is to add in your noodles.</li></ol>	easternEuropean	45	6	f	f	f	f
113	Chocolate Crepes Cake	https://spoonacular.com/recipeImages/Chocolate-Crepes-Cake-472333.jpg	<p style="margin-left: 120px;"><em><span></span></span></span></span></span></span></span></span>Quick And Easy Desserts</span></em></p><p><u>Making Crepes</u> :</p><div><br><div>Achieve 16 crepes as follows: <br><p>Prepare a hazelnut butter, that is to say, cook the butter in a saucepan over high heat for 1 minute, they will become brown.</p><p>In a bowl, add the flour, salt, sugar and form a fountain. Break the eggs in the center and mix gently pouring the milk gradually. Add the hazelnut butter and mixture together until it smooth dough, then let it sit for about 1 hour.</p><div>In a hot crepe pan (the same diameter as the cake pan used to mounting<br><div> the cake), pour a ladle of batter  into the pan<br><div> and cook for about 2 minutes on each side (by monitoring the color). <br><div>Then let them cool.</div></div></div></div><p><br><u>For Filling</u> :<br><br>Melt the chocolate and butter in a double boiler. When they are still warm, add the sugar. Add Nutella and mix well, then add the egg and egg yolks and mix well again.</p><p><br><u>For the Chocolate Glaze</u> :</p><div>Preheat oven to 180 °C (th. 6-7).<p>If necessary, cut the crepes the same size as the cake pan. butter the sides of the cake pan and put a circle of baking parchment paper on the bottom.</p><p>Start by putting down one crepe, and then cover it with chocolate mixture. Then put again another crepe and chocolate, and so on up the cake pan. Finish with a crepe.</p><div>Bake for 15 minutes, and then cool almost completely before unmolding on a platter.<p>Frost the chocolate cake</p><div>and decorate with the chips chocolate for example.<div>That's all if you want to make a <a href="http://www.qaedesserts.com/"><em>Quick And Easy Desserts</em></a><p>Notes :</p><p><em>"if you want </em><em>stands well </em><em>your cake, make enough pancakes."</em></p><p><em>More Recipes here : </em>http://www.qaedesserts.com</p></div></div></div></div></div></div>	french	120	6	f	f	f	f
114	Baked Ratatouille	https://spoonacular.com/recipeImages/Baked-Ratatouille-633754.jpg	<ol><li>Heat oil in a heavy, large Dutch oven over medium heat. Add garlic; stir 1 minute. Add eggplant, green bell peppers, tomatoes, onion, zucchini and basil. Saute for 5 minutes. Cover and simmer until all vegetables are tender, stirring occasionally, about 25 minutes.</li><li>Uncover pot and simmer until juice thickens, stirring occasionally, about 10 minutes. Mix in vinegar; season to taste with salt and pepper.</li><li>Preheat oven to 350 degrees. Spread in 9-inch pie dish. Sprinkle with cheese, if desired. Bake until heated through, about 20 minutes.</li><li>This recipe yields about 3 cups.</li><li>Yield: 3 cups</li></ol>	french	45	1	t	f	t	f
115	Banana Crepes	https://spoonacular.com/recipeImages/Banana-Crepes-634068.jpg	<ol><li>Make Batter:In a medium mixing bowl, mix the egg, milk and sugar together, set aside. In a small mixing bowl, combine flour, spices and salt. Pour the flour mixture into the egg and milk mixture and whisk rapidly. Pour in melted butter and stir. Set aside.</li><li>Make Crepes:Place 2 teaspoons of butter into a medium non-stick pan over high heat. When butter begins to melt, use a heat resistant spatula to spread it around the saut pan. Pick up the saut pan to guide the melting butter around in a circular motion. When it looks like pan is almost smoking hot, add one ladle of batter, (approximately 4 ounces) and pick up the saut pan to create a circular motion again to coat the pan with batter. Let batter cook for 25-30 seconds and then use spatula to scrape along the edges and underneath the crepe. Flip crepe and cook for another 25 seconds. Crepe should have a golden color, but not too tan. Place crepe onto a 3Make Filling:melt butter and brown sugar in a medium saute pan over medium high heat and stir. Add sliced bananas, stir and coat with brown sugar and butter. Taste for seasoning, may need to add salt. Add optional cream and stir. Keep warm.</li><li>Make Filling:melt butter and brown sugar in a medium saute pan over medium high heat and stir. Add sliced bananas, stir and coat with brown sugar and butter. Taste for seasoning, may need to add salt. Add optional cream and stir. Keep warm.</li><li>Assemble Crepes:Preheat the oven to 300F degreesAdd approximately half cup of filling into each crepe, roll and place in a warm place, or onto a baking sheet to heat all the crepes at one time.  Once all the crepes are  asembled, top with a dollop of whip cream and a sprinkle of powdered sugar, cinnamon and nutmeg.</li></ol>	french	45	1	t	f	f	f
116	Beef Bourguignon Pie With Mushy Green Pea	https://spoonacular.com/recipeImages/Beef-Bourguignon-Pie-With-Mushy-Green-Pea-634585.jpg	<ol><li>Making beef bourguignon</li><li>Cook bacon on medium heat until crispy. Absorb the excessive fat with paper and rest</li><li>In the same pan, add onions and cook until browned (approx. 3-5 minutes) and remove from pan</li><li>Add olive oil onto the same pan, cook mushrooms until browned and remove from pan</li><li>In the same pan, cook beef until browned. Then add cooked bacon and onions together with thyme and tomato paste. Stir fry until well combined.</li><li>Add wine and stock in and bring it to boil. Reduce to low heat and let it simmer (covered) for 1 hour</li><li>Add cooked mushrooms and continue to let it simmered (uncovered) until beef is tender (approx. 40-45 minutes). Then add in the parsley.</li><li>Making puff pie lid</li><li>Preheat the oven to 200'c (390'f) fan forced</li><li>Cut the puff pastry sheet to fit your baking dishes. Use cookie cutters to make creative shapes to decorate your puff pie lid such as flowers or alphabets or words (e.g. name, love etc). Bake the pastry on oil sprayed tray until light golden browned (5-10 minutes). Your tray must be at the middle of your fan oven.</li><li>Making mushy pea</li><li>On medium heat, cook onion until light golden browned.</li><li>Add cream and stock and bring to boil. Reduce heat to low and let it simmer for a few minutes.</li><li>Turn the heat off and mash it with folk gently. Season with salt and pepper.</li><li>To serve, spoon the beef bourguignon onto a baking dish (microwaved so it is warm). Close with the puff pie lid and serve with mushy green pea in another baking dish.</li></ol>	french	45	2	f	f	f	f
117	Braided Brioche	https://spoonacular.com/recipeImages/Braided-Brioche-635785.jpg	<ol><li>1. Add ingredients to bread machine pan according to manufacturer's directions.</li><li>2. Select sweet or dough cycle.</li><li>3. At the end of the cycle, scrape the dough onto a board lightly coated with all-purpose flour. Divide dough into 3 equal pieces. If making a 1 1/2-pound loaf, roll each piece to form a rope about 12 inches long. For a 2-pound loaf, roll each piece to form a rope about 14 inches long. Lay ropes parallel about 1 inch apart on a buttered 14 x 17 inch baking sheet. Pinch ropes together at one end, braid loosely, then pinch braid end together.</li><li>4. Cover loaf lightly with plastic wrap and let stand in a warm place until puffy, about 35 minutes. Remove plastic wrap.</li><li>5. Beat 1 large egg yolk to blend with 1 tablespoon water. Brush braid with egg mixture.</li><li>6. Bake braid in a 350 F oven until golden brown, about 30 minutes. Cool on a rack at least 15 minutes before slicing. Serve hot, warm, or cool.</li></ol>	french	45	1	f	f	f	t
118	Classic French Mussels	https://spoonacular.com/recipeImages/Classic-French-Mussels-Done-Light-639599.jpg	<ol><li>Scrub mussels with a stiff brush, discard any that are open and stay that way even when you close the shell. Discard any with broken shells.</li><li>Soak them in cool clean water for at least an hour. Mussels are alive and breathing and have taken in sand over time. This allows them to expel the sand.</li><li>Mussels have a small fibrous "beard" that should be removed. Pull it out toward the hinge of the shell to keep from injuring the mussel.</li><li>Heat the olive oil in a large pot over medium-high heat. Add the shallots and garlic and cook until soft, about 5 minutes. Add the mussels, wine, buttermilk, butter, and parsley and season well with the kosher salt. Give it a good stir, cover the pot, and cook until mussels open and are cooked through, 10 to 15 minutes. Divide the mussels and the juices between 2 bowls and serve with a crusty whole-grain bread to sop up that wonderful sauce.</li></ol>	french	45	2	f	f	t	f
119	Creamy Ratatouille Over Penne	https://spoonacular.com/recipeImages/Creamy-Ratatouille-640693.jpg	<ol><li>Heat olive oil in a large skillet over medium heat. Add onion, bell pepper, and zucchini and saut for about 7 minutes, stirring occasionally, until slightly softened.</li><li>Add eggplant and continue to saut mixture for another 3 minutes, stirring frequently. When vegetables are softened, add garlic and cook until fragrant, about 1 minute.</li><li>Add dried spices, salt, and pepper, followed by the tomato sauce and water. Allow mixture to come to a simmer and cook for 5 minutes, until slightly thickened.</li><li>Stir in mascarpone cheese and serve immediately.</li></ol>	french	45	2	t	f	f	f
120	Crock Pot Shredded French Dip	https://spoonacular.com/recipeImages/Crock-Pot-Shredded-French-Dip-640869.jpg	<ol><li>Place beef in crock pot. Add beef broth, garlic, onion, Italian seasoning, ground mustard, and pepper.</li><li>Turn on low for 7 hours.</li><li>Take out and place on cutting board. Using a fork, shred the beef. Strain au jus (broth from crock pot) so that there are no large chunks.</li><li>Slice rolls in half. Place  of the beef on each roll. Place au jus in 4 small individual bowls. Serve sandwiches and au jus together.</li></ol>	french	450	4	f	f	f	t
121	Dulce De Leche Creme Brulee	https://spoonacular.com/recipeImages/Dulce-De-Leche-Crme-Brle-641727.jpg	<ol><li>Oven: 325F</li><li>Place six ramekins in a water bath. Whisk eggs and sugar until pale, then slowly pour the hot cream into the yolks, whisking thoroughly. Pour custards into ramekins and bake ~35 min. until set. Chill at least 3 hours before serving.</li><li>To serve, sprinkle ~2 tsp sugar evenly over each custard and heat with a kitchen torch until a burnt crust forms atop each custard.</li></ol>	french	45	1	t	f	t	f
122	Dunkin French Onion Soup	https://spoonacular.com/recipeImages/Dunkin-French-Onion-Soup-641744.jpg	<ol><li>In a soup pot melt the 4 Tbs. Of the butter with the oil, saut the onions until just slightly caramelized, this will take about 20 minutes. When tender and a golden rich color add in the chicken and beef stock along with the pepper, Montreal steak seasoning and 1  Tbs. of the Johnny's garlic, simmer the soup for another 15 minutes. In the mean time use the remaining butter and Johnny's to turn your French bread into garlic bread, place onto a baking sheet and cook in a 350 degree oven just until the butter mixture has melted. Once the bread is ready remove the tray from the oven and turn the oven to broil, top each slice of bread </li></ol>	french	45	1	f	f	f	f
123	Easy Beef Bourguignon	https://spoonacular.com/recipeImages/Easy-Beef-Bourguignon-641842.jpg	<ol><li>Cut your vegetables and set aside (put mushrooms in a separate bowl).</li><li>Cut beef into bite size and put in a bowl. Sprinkle flour over and toss the meat around to coat lightly. With a large pot over high heat, add 1 tbsp olive oil. Wait for about a minute until the pot is really hot and add your beef (otherwise your meat will stay a grey color instead of a nice golden brown. If you do not have a large pot, do your beef in batches so as not to crowd the pot). Cook for about 5 minutes and turn the meat over. Cook for another 3-4 minutes until you get a nice color and remove from the pot (do not turn off the heat). Put aside in a bowl.</li><li>Add 1 tbsp olive oil to the pot and add onions, carrots, thyme and rosemary. Cook for about 7 minutes (stir frequently to keep the bottom of the pot from burning). Put the meat back in the pot and add wine. Bring to boil, lower the heat and simmer for 5 minutes. Add bay leaf, cayenne pepper, beef broth, and bring to boil. Lower the heat, cover, and simmer for 20 minutes.</li><li>Add mushrooms and simmer for 30 minutes. Remove bay leaf, season with salt and pepper, and serve.</li></ol>	french	45	4	f	f	f	t
124	Leek and Gruyere Quiche	https://spoonacular.com/recipeImages/Leek-and-Gruyere-Quiche-649434.jpg	<ol><li>Make crust in a food processor. Place flour and salt in work bowl. Add butter pieces and sour cream. Pulse to combine. With machine running, drizzle in ice water until a ball forms. Flour a work surface and roll out into a 12 inch round. Quickly foldinto quarters and gently lay in an 11 inch shallow, tin fluted tart pan; press into pan. Place in freezer 15 minutes (can be left frozen for up to a month). Preheat oven to 400 degrees. Place a layer of foil on top of crust and fill with dried beans. Prebake 15 minutes to 18 minutes, until just pale golden. Red</li><li>Place leeks and 1/4 cup water in a large skillet. Heat over medium-high heat and cook a few minutes to sweat (not brown them) until water evaporates and leeks are tender. Set aside to cool.</li><li>In a mixing bowl, combine milk, cream, eggs and seasoning. Beat with a whisk to combine. Add cheese. Place cooked leeks into prebaked shell and gently pour in custard. Immediately place in oven and bake 20 minutes to 25 minutes until puffed, brown and set. Cool 10 minutes and serve hot, or cool to room temperature.</li></ol>	french	45	1	f	f	f	f
125	Leek, Mushroom, and Bacon Quiche	https://spoonacular.com/recipeImages/Leek--Mushroom--and-Bacon-Quiche-649450.jpg	<ol><li>Preheat your oven to 400.</li><li>Dump flour, salt, and sugar into a food processor.</li><li>Pulse to combine.</li><li>Add cubes of butter straight from the freezer.</li><li>If your processor has a feed tube, pour the water through while it is running.</li><li>Chill the dough for an hour or so</li><li>Roll it out on a floured surface</li><li>Gently work it into the tart pan.</li><li>Line it with foil and pierce holes all over with a fork.</li><li>Place pie weights or dry beans in the foil</li><li>Blind bake for 8 to 9 minutes.</li><li>When done, lower the baking temperature to 375.</li><li>Fry up the bacon until crispy in a large saucepan.</li><li>Set aside.</li><li>Saute the leek in melted butter and leftover bacon fat over medium heat.</li><li>When they are translucent and fragrant, sprinkle in salt and pepper and add sliced mushrooms.</li><li>Allow the mushrooms to absorb excess fat and heat through. When they are finished, set aside.</li><li>Now whisk together eggs and milk.</li><li>Add salt, pepper, and leek and mushroom mixture.</li><li>Lay the slices of potato on the bottom of the tart pan.</li><li>Pour into the tart crust and top with parmesan shavings.</li><li>Bake for 20-35 minutes.</li></ol>	french	45	1	f	f	f	f
126	Party Quiches	https://spoonacular.com/recipeImages/Party-Quiches-654744.jpg	<ol><li>This recipe describes four quiches with different fillings. If preferred, one single filling may be chosen, but the ingredients must be multiplied by four.</li><li>1. Salmon with Broccoli and Stilton</li><li>2. Salmon with Asparagus and Cheddar</li><li>3. Salmon and Mozzarella</li><li>4. Salmon with Tomatoes and Feta Cheese</li><li>Pre-heat oven to 200 C, 400 F, Gas mark 6. Drain the cans of salmon. Flake and set aside.</li><li>Divide the pastry into four and roll out to line four 22.5 cm / 9inch flan dishes. Spread the salmon evenly over the base of each flan.</li><li>Arrange the broccoli in one flan, the asparagus in another, and the leeks and tomatoes in the other two. Sprinkle the spring onions over the asparagus quiche, onion over the broccoli, smoked salmon into the leeks and olives into the tomato.</li><li>Top the broccoli quiche with Stilton, the asparagus with Cheddar, the leek quiche with Mozzarella and the tomato with Feta cheese and pesto. Beat the remaining ingredients and pour into each flan. Bake for 10 minutes. Reduce the temperature to 160C, 325F, Gas mark 3 and cook for 40 minutes. Serve with salad.</li><li>Makes 4, serves 24-32. Approx. 255 kcals per serving</li></ol>	french	45	4	f	f	f	f
127	Ratatouille Pasta	https://spoonacular.com/recipeImages/Ratatouille-Pasta-657933.jpg	<ol><li>Saute the yellow onion in a large skillet or saute pan with enough Olive oil to coat the bottom of the pan, over medium-low heat until tender and translucent. Season with salt and pepper. Add garlic, saute until fragrant.</li><li>Add another tablespoon of Olive oil and the zucchini, eggplant and Italian seasoning. Continue sauteing until the zucchini and eggplant start to break down and become limp and tender.</li><li>Add the artichokes and tomatoes. Season with salt and pepper. Bring to a simmer for ten - fifteen minutes. Taste and re-season if needed.</li><li>Meanwhile cook the spaghetti to al dente according to package directions.</li><li>Toss with pasta and serve with a drizzle of extra-virgin Olive oil and Parmesan cheese.</li></ol>	french	45	4	f	f	f	f
128	Ratatouille With Brie	https://spoonacular.com/recipeImages/Ratatouille-With-Brie-657939.jpg	<ol><li>Remove outer peel from eggplant and dice into  inch pieces</li><li>Heat 1-2 oz. of olive oil in a heavy gauge skillet</li><li>Saut the diced eggplant for 2-3 minutes then place on a towel to drain</li><li>After draining place cooked eggplant into a small oval casserole dish</li><li>Preheat oven to 375 F</li><li>Carefully slice the zucchini , yellow squash , and tomatoes about  inch even slices</li><li>Slice the Brie also into  inch slices (utilizing a cheese wire makes simplifies this)</li><li>Begin placing sliced yellow squash , zucchini , sliced Brie and tomatoes in a shingled pattern working from the outside of the casserole towards the center</li><li>When all vegetables and cheese are placed in the casserole, drizzle with the remaining olive oil and sprinkle with chopped thyme</li><li>Season with salt and pepper and bake in the oven for 10-15 minutes until bubbly</li></ol>	french	45	4	t	f	t	f
129	Roasted Ratatouille Gratin	https://spoonacular.com/recipeImages/Roasted-Ratatouille-Gratin-658641.jpg	<ol><li>Cut up everything and set aside until needed. Do the eggplant last, as it turns brownish after being cut.</li><li>Preheat oven to 425 F.</li><li>Place whole red pepper on a baking sheet and roast for 20 minutes.</li><li>Spray another baking sheet with canola oil and place eggplant on it in a single layer.</li><li>Drizzle with 2 tablespoons olive oil and toss to combine. Sprinkle with salt and pepper.</li><li>Turn red pepper over after 20 minutes.</li><li>Add eggplant to oven, and roast until both are tender, about 15 minutes more.</li><li>While the eggplant and pepper are roasting, heat 2 tablespoons olive oil in a large soup pot over medium heat. Stir in leek and shallot and cook until softened, about 5 minutes.</li><li>Stir in zucchini and continue cooking, stirring occasionally, until zucchini is soft, 6-8 minutes.</li><li>Stir in mushrooms, 1 teaspoon salt, dash black pepper, and wine.</li><li>Simmer until mushrooms are soft, about 8 minutes.</li><li>Remove eggplant and pepper from oven.</li><li>Turn oven down to 400.</li><li>Cover pepper with aluminum foil. Covering it creates steam that will loosen its skin, making the skin easier to remove. Allow pepper to cool about 10 minutes before handling.</li><li>Stir in the eggplant, tomatoes and their juices, thyme, and rosemary.</li><li>Bring back up to a simmer.</li><li>After pepper has cooled, remove the skin, core, and seeds. Chop flesh and add to the stockpot.</li><li>Simmer, covered, for 5 minutes to combine flavors.</li><li>Taste, and add salt and pepper if needed.</li><li>Pour everything into an 8x8 baking dish.</li><li>Top with Parmesan and bread crumbs.</li><li>Bake until topping is browned, about 20 minutes.</li><li>Allow ratatouille to stand 10 minutes before serving.</li><li>Garnish each serving with fresh basil. Make sure to have more freshly grated Parmesan on hand to pass at the table.</li></ol>	french	45	4	f	f	f	f
130	Salmon and Broccoli Crepes	https://spoonacular.com/recipeImages/Salmon-and-Broccoli-Crepes-659037.jpg	<ol><li>Combine milk, water, egg and melted butter in a small bowl. Add flour and salt and whip until well blended. Allow to sit for 10 minutes.</li><li>Steam broccoli until just tender, and combine salmon, shallot, thyme, lemon juice, dijon and 1/2 cup sour cream. Chop pieces of salmon and broccoli with a spoon if you have extra large pieces. Warm salmon mixture in the microwave for 2 minutes.</li><li>Combine remaining sour cream and lemon zest.</li><li>Heat a medium non-stick skillet over medium heat and spray with cooking spray. Add 1/4 cup crepe batter to the pan and swirl around to create an even pancake. Cook 1  2 minutes on the first side to brown crepe, then flip and brown the other side. Crepes cook quickly because they are so thin. Remove to a plate and keep warm.</li><li>Fill a crepe with 1/4 salmon lengthwise and gently roll. Slice in half on a diagonal and top with a tablespoon of sour cream and lemon zest mixture.</li></ol>	french	45	4	f	f	f	f
131	Vegetarian Ratatouille	https://spoonacular.com/recipeImages/Vegetarian-Ratatouille-664689.jpg	<ol><li>Saute onion and garlic in a large saucepan over medium low heat until onions are translucent. Add tomatoes and stir. Add all the remaining ingredients and cook for 30 minutes on low stirring occasionally or until eggplant is tender.</li></ol>	french	45	6	t	t	t	t
132	Zucchini Quiche Appetizers	https://spoonacular.com/recipeImages/Zucchini-Quiche-Appetizers-665778.jpg	<ol><li>Preheat oven to 350 degrees F.</li><li>Grease bottom and sides of rectangular pan 13 x 9 x 2.</li><li>Stir together all ingredients; spread in pan.</li><li>Bake about 40 minutes or until golden brown.</li><li>Cut into 2" squares.  Cut squares diagonally in half into triangles.</li></ol>	french	45	1	f	f	f	f
133	Red, White and Blue Crepes	https://spoonacular.com/recipeImages/red-white-blue-crepes-happy-july-4th-driscollsberry-716414.jpg	Spread a teaspoon or so of jam onto the crêpe. Top with a handful of the mixed berries. Sprinkle the cheese over the fruit. Roll up and enjoy!	french	45	1	f	f	f	f
134	Muesli-Coated German Toast	https://spoonacular.com/recipeImages/muesli-coated-german-toast-149663.jpg	<p>I don't know why French toast is called French toast to begin with, but since I'm living in Germany I'm calling this variation German Toast. Start by pre-heating your over to 375 degrees F (about 190 degrees C).</p><p>1. whisk together the eggs and soy milk. Add cinnamon and nutmeg if desired.</p><p>2. dip the toasted bread into the egg/soy milk mixture and let soak for 30 seconds per side</p><p>4. dip the soaked bread into the muesli and press gently to coat</p><p>5. fry the slices in oil or butter in a hot skillet until golden brown, 2-3 minutes per side</p><p>6. place the finished German toasts in the oven for 5 minutes</p><p>Serve with maple syrup, honey, or Nutella and a fresh fruit salad.</p>	german	25	2	t	f	f	t
135	Nutella Banana Pancakes German Style	https://spoonacular.com/recipeImages/Nutella-Banana-Pancakes-German-Style-157514.jpg	<ol><li>Separate the egg whites from the yolks.</li><li>Beat the egg whites until they are stiff.</li><li>Mix egg yolks, flour, water, and milk in a big bowl until smooth.</li><li>Gently fold the stiff egg whites in.</li><li>Heat a large pan to medium to high heat with 1 tablespoon of oil per pancake. Distribute about 1 ladle of the batter in the pan and fry for about 2 minutes per side.</li><li>If you don't want to eat-cook-eat-cook, you could pre-heat the oven and make all the pancakes, keeping them warm in the oven until all are prepared before you dig in.</li></ol>	german	20	2	t	f	f	f
136	Brown Butter Spaetzle With Prosciutto and Broccoli Rabe	https://spoonacular.com/recipeImages/Brown-Butter-Spaetzle-With-Prosciutto-and-Broccoli-Rabe-636280.jpg	<ol><li>Put a large pot of salted water on the stove and over high heat to boil.</li><li>In a large bowl, crack the eggs and add milk, parsley, salt and pepper and mix until combined. Add in flour a little bit at a time and mix until combined. The dough will be a bit runny, and this is just fine. Let sit for 10 minutes to rest.</li><li>Put a colander or cheese grater over the pot of boiling water and spoon dough through holes. Youll have a bunch of wiggly noodle nuggets that drop into the pot. Cook these for 5 to 6 minutes until just tender. Drain.</li><li>Melt butter in a saut pan over high heat. When butter starts to separate and brown, have your ingredients at the ready. Youll know the butter is ready to go when you start smelling a sweet, nutty aroma.</li><li>Dump in the drained spaetzle, garlic, onion, pine nuts and broccoli rabe. Cook in browned butter for about 2 minutes, then remove from heat. Toss in prosciutto and top with a sprinkling of Parmesan cheese and lemon juice. Season with salt and pepper, to taste.</li></ol>	german	45	3	f	f	f	f
137	Frikadellen German Meat Patties	https://spoonacular.com/recipeImages/Frikadellen-German-Meat-Patties-643851.jpg	<ol><li>Peel and dice the onions, then saute in oil until transparent. Add sauteed onions to ground meat in a mixing bowl. Stir together breadcrumbs and milk and add to meat mixture.</li><li>Add egg, basil, salt and pepper and mix well. Dampen hands and form meat mixture into palm-sized patties.</li><li>Preheat non-stick skillet with a little oil. Pan-fry the meat patties over medium high heat until browned on both sides. Serve them with salad, fries and tzatziki. Alternatively they can be served with German dumplings and black pepper sauce.</li></ol>	german	45	18	f	f	f	f
138	German Lemon Cake With Cranberry aka Cranberry Zitronenkuchen	https://spoonacular.com/recipeImages/German-Lemon-Cake-With-Cranberry-Aka-Cranberry-Zitronenkuchen-644477.jpg	<ol><li>Grate the zest of two lemons, careful that you are grating only the coloured part of the rind. And squeeze the lemon to extract 11 tablespoons of juice. Grease and flour a 32x11 cm loaf pan. Preheat the oven to 180C/350F. Whisk together the flour and baking powder in a bowl.</li><li>Cream the butter, sugar and pinch of salt with a hand-held beater until light and fluffy. Add in eggs one at a time, alternately mixing in a tablespoon of flour mixture after each addition. Pour in the whipping cream, and then 8 tablespoons of lemon juice and finely grated zest. Fold to combine. Sift in the rest of the flour mixture and gently stir to combine. Finally fold the dried cranberries into the batter.</li><li>Pour the batter into the prepared loaf pan. Place the pan on the lower second rack and bake for about 80-90 minutes. After 35 minutes, cover the cake with a foil greased with butter. Remove and cool the cake in the tin briefly. Then remove the cake from the tin and allow it to cool completely.</li><li>Sift the powdered sugar in a bowl and add in the rest of lemon juice. Stir to combine. Pour evenly over the cake. Allow the glaze to set before slicing and serving.</li></ol>	german	45	8	f	f	f	f
139	German Meatloaf Falscher Hase	https://spoonacular.com/recipeImages/German-Meatloaf-Falscher-Hase-644482.jpg	<ol><li>Thoroughly mix ground meats, onion, bread crumbs, cold water, and eggs.</li><li>Season the mixture with salt, paprika, mustard, and parsley. Blend ingredients thoroughly and shape into a loaf.</li><li>Place the loaf in a baking pan and bake in a preheated oven for about 45 minutes. While meat is baking, gradually pour hot beef broth over the top of the meatloaf and basting occasionally. Serve with German bread dumplings.</li></ol>	german	45	4	f	f	f	t
140	German Rhubarb Cake with Meringue	https://spoonacular.com/recipeImages/German-Rhubarb-Cake-with-Meringue-644488.jpg	<ol><li>Preheat the oven to 350F Convection. Grease a round 26 cm Spring pan (9 1/2 inch).</li><li>Wash, dry and peel the rhubarb. Cut it in little pieces, mix with 2 tablespoon of sugar and let sit for at least 1/2 hour. It will extract a lot of water that needs to be drained. Pat rhubarb dry for further use.</li><li>In a kitchen machine beat together butter, sugar and vanilla extract until the butter is fluffy and the sugar is dissolved. Put in the eggs, one at a time and mix well.</li><li>In a separate bowl sift together flour, ground almonds, salt and baking powder, add slowly to the egg mixture. Dont over mix.</li><li>Fill dough into the spring pan, top with dried rhubarb and bake for 25 min.</li><li>In the mean time prepare the meringue/ baiser topping. Beat egg whites until stiff peaks form. Slowly add the sugar until meringue is firm and shiny.</li><li>Spread the meringue evenly over the rhubarb and decorate with almond slices. Return to the oven for another 15 min. Cover the cake with aluminum foil after 5 min. in case the meringue does turn too dark.</li><li>Cool completely before removing the cake from the pan.</li></ol>	german	45	12	f	f	f	t
141	German White Chocolate Cake	https://spoonacular.com/recipeImages/German-White-Chocolate-Cake-644504.jpg	<ol><li>CAKE</li><li>1. Position the racks in the upper and lower thirds and preheat oven to 350 deg F. Lightly butter the bottom and sides of three 8 inch round cake pans. Line the pans with parchment paper. Dust the bottom and sides with flour; tap out the excess.</li><li>2. Into a medium bowl, sift the cake flour and the baking soda. Using an electric mixer set at mdeium speed, cream the butter and the sugar in a large bowl until light and fluffy, about 5 minutes. Beat in one egg yolk at a time, blending well after each addition. Beat in the melted white chocolate mixture and the vanilla. At low speed, blend in the sifted flour mixture alternately with the buttermilk; do not overbeat. Fold in the coconut and pecans.</li><li>3. Beat the egg whites until stiff peaks form. Blend 1/3 of the egg whites into the cake mixture to lighten it; carefully fold in the remaining egg whites. Spoon the batter into the prepared pans.</li><li>4. Bake until the cake springs back when touched in the center and a cake tester inserted in the center of the pans comes out clean, about 35 to 40 minutes. Transfer the cakes in the pans to wire racks and cool 10 minutes. Invert the cakes onto the wire racks, carefully peel off the parchment paper, and cool completely.</li><li>FOR THE FROSTING:5. In a heavy medium saucepan over medium heat, combine the evaporated milk, sugar, butter, and egg yolks. Simmer for 10 minutes, stirring constantly. Do not let mixture boil fast; lower the heat if necessary.</li><li>Remove from heat and stir in the vanilla, pecans, and coconut. Plance the saucepan into a bowl filled with ice and stir constantly until the frosting is cool and slightly thickened.</li><li>6. Place a cake layer on a serving platter. Spread 1/4 of the frosting evenly over the cake layer, making sure to spread it all the way to the edges. Top with the second layer, and spread with 1/4 of the frosting. Top with the third cake layer. Evenly frost the top and sides of the cake with the remaining frosting.</li></ol>	german	45	6	f	f	f	f
142	Knockwurst with sauerkraut	https://spoonacular.com/recipeImages/Knockwurst-with-sauerkraut-648986.jpg	<ol><li>Butter a medium fry pan and heat the wurst until brown, about 10-12 minutes.</li><li>Drain the sauerkraut, rinse, and drain well.</li><li>In a large pot cook onion until onion is tender but not brown. Stir in beer.</li><li>In a 2-cup glass measure combine the water, cornstarch, brown mustard, molasses, caraway seed, allspice, and pepper; stir into onion mixture.</li><li>Cook and stir until thickened and bubbly. Add rutabaga; cover and cook 15 minutes.</li><li>Stir in the knockwurst, apple wedges, and sauerkraut. Cook, covered, 15 to 20 minutes more or until apples are tender.</li></ol>	german	45	4	f	f	f	t
143	Pork Schnitzel And Apple Salad	https://spoonacular.com/recipeImages/Pork-Schnitzel-And-Apple-Salad-656817.jpg	<ol><li>1. Using a meat mallet, pound pork slices evenly to 5mm thick. Marinate it with cornflour, cooking wine and lightly beaten egg for about 3 - 5 minutes.</li><li>2. Coat marinated pork slices evenly with breadcrumbs by pressing the meat down against the crumbs.</li><li>3. Heat oil in a frying pan on medium heat, cook pork schnitzel for 3 minutes on each side or until golden and cooked through. Drain well on paper towels.</li><li>4. Meanwhile, toss the pre-packed salad with accompany dressing before transferring them to a serving plate and top with apple slices. (you can soak apple slices with some lightly salted water to prevent it from oxidized and turns brown)</li><li>5. Next thickly slice pork and arrange on salad and drizzle mustard dressing over pork and serve.</li></ol>	german	45	4	f	f	f	t
144	Pork schnitzel with tarragon cream sauce	https://spoonacular.com/recipeImages/Pork-schnitzel-with-tarragon-cream-sauce-656819.jpg	<ol><li>Using the side of a rolling pin or a meat tenderiser, gently beat the pork until flattened to a 0.5cm thickness.</li><li>Sprinkle the seasoned flour onto a plate. Beat the eggs in a bowl. Mix the breadcrumbs with the grated parmesan and sprinkle the mixture onto another plate.</li><li>Dredge each escalope lightly in the flour on both sides, shaking off any excess, then dip into the egg, then press into the breadcrumb mixture, to coat on both sides. Chill in the fridge for 20 minutes before cooking.</li><li>Heat the oil in a frying pan over a medium heat and fry the schnitzels for 2-3 minutes on each side, or until golden-brown on both sides and completely cooked through (there should be no trace of pink in the middle). Remove from the pan and set aside to drain on kitchen paper.</li><li>For the sauce, pour the wine into a small saucepan, add the tarragon sprig and bring to the boil. Continue to boil for 1-2 minutes, or until the volume of liquid has almost completely reduced.</li><li>Pour in the stock and return the mixture to the boil. Boil for 3-4 minutes, or until reduced in volume by half, then add the cream and simmer for 2-3 minutes until thickened. Season, to taste, with salt and freshly ground black pepper, then stir in the chopped tarragon.</li><li>To serve, place one pork schnitzel onto each of two plates and spoon over the sauce. Garnish with wedges of lemon and serve with your choice of vegetables on the side.</li></ol>	german	45	2	f	f	f	f
145	Potatoes With Sauerkraut and Crunchy Smoked Ham	https://spoonacular.com/recipeImages/Potatoes-With-Sauerkraut-and-Crunched-Smoked-Turkey-Ham-657037.jpg	<ol><li>Directions:</li><li>Into a big enough pot, put potatoes, salt, and black pepper. Cover with water and bring to a boil over high heat. Add sauerkraut with pickling liquid, bring to a boil again, lower heat to medium, and cook until potatoes are soft, approximately 15 minutes. Drain the liquid, cover the pot, and set aside.</li><li>Into a hot skillet over medium heat, pour olive oil and add cubed smoked turkey ham. Cook until ham becomes browned and crunchy. Don't forget to add garlic to ham 2-3 minutes before ham is done.</li><li>Onto each plate arrange 6 potato halves, half of the sauerkraut, and pour over hot olive oil with crunched turkey ham. For those who are not meat fans, just olive oil and garlic will give the same delicious tasty results!</li></ol>	german	45	2	f	f	t	t
146	Sauerkraut Dip with Bacon and Garlic	https://spoonacular.com/recipeImages/Sauerkraut-Dip-with-Bacon-and-Garlic-659321.jpg	<ol><li>Cook bacon until crisp, then drain and crumble.</li><li>Drain off bacon drippings and cook shallot in the same skillet until soft. Discard drained bacon drippings.</li><li>Place drained sauerkraut and other ingredients in a food processor and run until smooth.</li></ol>	german	45	6	f	f	t	f
147	Classic Greek Moussaka	https://spoonacular.com/recipeImages/Classic-Greek-Moussaka-639606.jpg	<ol><li>Sprinkle the egg plant slices with salt and let them stand for 45 minutes. Then wash thoroughly to remove excess salt.</li><li>Thinly brush each slice with olive oil and bake in the preheated grill pan for several minutes on each side. Set aside. Repeat until all slices are grilled.</li><li>For the meat sauce lightly saute the onions in olive oil until tender.</li><li>Add ground beef and saute, stirring frequently to break up the clumps of meat, until the meat is no longer pink.</li><li>Stir in tomatoes, garlic, cinnamon, allspice, salt and pepper and simmer briefly on low heat.</li><li>Add in tomato paste and a little water if the sauce is to thick. Remove from heat and set aside.</li><li>For the bchamel sauce add flour to the melted butter, stirring constantly. When the mixture is evenly thick, gradually whisk in warm milk.  Gently bring to the boil, then remove from heat, season with pepper and nutmeg. Whisk in (vigorously) the egg yolks. Set aside.</li><li>Thinly coat with olive oil a suitable ovenproof baking dish, sprinkle the bottom with homemade bread crumbs.</li><li>Place a layer of egg plant, cover with some meat sauce and feta cheese and repeat this until the pan is almost full. Finish with a layer of feta cheese.</li><li>Top with bchamel sauce.</li><li>Cover with tin foil and bake in a preheated oven at 180C for 1 hour.</li><li>Remove moussaka from the oven and let it set at room temperature 45 minutes before serving.</li></ol>	greek	135	4	f	f	f	f
148	Eggplant Fries with Tzatziki Sauce	https://spoonacular.com/recipeImages/Eggplant-Fries-with-Tzatziki-Sauce-642287.jpg	<ol><li>Preheat oven to 450F</li><li>Mix salt, garlic powder, italian seasonings, paprika, and breadcrumbs in a bowl.</li><li>In another bowl, mix yogurt &amp; egg together.</li><li>-First place the eggplant strips into egg/yogurt mixture then coat them in breadcrumb mixture evenly.</li><li>Place them on a parchment paper lined or greased baking pan and bake for 10-15 minutes rotating once and until slightly brown.</li><li>Serve with tzatziki.</li></ol>	greek	25	2	t	f	f	f
149	Fire-Roasted Jalapeno Hummus with Turnip and Beet Chips	https://spoonacular.com/recipeImages/Fire-Roasted-Jalapeo-Hummus-with-Turnip-and-Beet-Chips-642893.jpg	<ol><li>Start by making the chips. Preheat oven to 415 degrees (and if you have a convection option on your oven, I recommend using it!). Slice turnip and beet thinly (peel on or off...I leave the peels on), place all slices in a plastic bag (I just use the plastic produce bags from the produce section of the store), drizzle in olive oil, add your salt and garlic powder, and shake it like Shake N Bake! Lay roots flat on a lightly-oiled cookie sheet (or two) and bake in the oven to desired crip level, between 11 and 15 minutes. The thicker slices will likely need to be turned over if they're not getting crispy within 10 minutes or so.</li><li>While the chips are baking, make the hummus. Wrap the cloves of garlic in foil. Using tongs, roast the jalapeo and wrapped garlic over a flame (I used my gas stove) until the flesh is blackened, soft and hot.  When cool enough to handle, remove the stem and seeds from the jalapeo.  Place all ingredients (including jalapeo flesh) in a blender or food processor, and blend until ingredients are combined and there are no more chunks. You may need to use a rubber spatula to stir around the ingredients in order to blend them well.  Spoon hummus into a serving bowl. Drizzle olive oil on top and sprinkle paprika and turmeric.  Serve with beet and turnip chips.</li></ol>	greek	45	4	t	t	t	t
150	Great Greek Salad	https://spoonacular.com/recipeImages/Great-Greek-Salad-645265.jpg	<ol><li>In a large salad bowl, toss together the cucumbers, olives, roma tomatoes, sun-dried tomatoes, 2 tablespoons reserved sun-dried tomato oil, red onion, vinegar, and seasoning.</li><li>Chill until serving.</li><li>Right before serving toss in the feta and stir to combine.</li></ol>	greek	15	4	t	f	t	f
151	Greek Side Salad	https://spoonacular.com/recipeImages/Greek-Salad-645348.jpg	<ol><li> Slice the vegetables into bite-size wedges</li><li>Toss in a bowl with olive oil </li><li>Place feta on top of the salad or break up into crumbles</li></ol>	greek	15	4	t	f	t	f
152	Greek Shrimp Orzo	https://spoonacular.com/recipeImages/Greek-Shrimp-Orzo-645354.jpg	<ol><li>Combine lemon juice and 1/2 cup olive oil.</li><li>Bring large pot of salted water to a boil over high heat.</li><li>Pour in orzo and cook until al dente.</li><li>Drain the pasta, pour into a large serving bowl, and immediately add lemon juice/olive oil mixture.  Stir well.</li><li>Heat a large skillet over medium-high heat and add 1 tbsp olive oil.  Add shrimp, salt and pepper, and cook for about 2 minutes, or until the shrimp are just done.</li><li>Add the shrimp, green onions, parsley, and feta to the orzo mixture.  Stir well.</li><li>Let the orzo sit for 1 hour.  If you make it earlier in the day, cover and refrigerate.  Bring to room temperature before serving.</li><li>Just before serving, add the basil and gently mix.  If desired, serve over a bed of spinach or lettuce.</li></ol>	greek	45	6	f	f	f	f
153	Grilled Chicken Gyros With Tzatziki	https://spoonacular.com/recipeImages/Grilled-Chicken-Gyros-With-Tzatziki-645646.jpg	<ol><li>Whisk together the garlic, lemon juice, vinegar, oil, yogurt, and oregano in a bowl. Add the chicken and rub the marinade in. Cover and refrigerate for at least an hour.</li><li>Preheat the grill to medium heat (or broiler, or pan on the stove).  Sprinkle the chicken with salt and pepper on both sides, and then grill until cooked through, about 5 minutes per side, depending  what size/type chicken you are using. Allow the chicken to rest for a few minutes before slicing into strips.</li><li>Meanwhile, heat your pitas in a fry pan, in the toaster or spray with a bit of oil and place right on a gas burner. Top the pita with the chicken, tzatziki, tomatoes and onions.</li><li>For the Tzatziki: Shred the cucumbers and then wrap in a towel and squeeze to remove as much moisture as possible. Don't skip this step!</li><li>Mix together the strained yogurt, shredded cucumbers, garlic, vinegar and lemon juice. Add salt and pepper to taste. Its best to refrigerate for 30 minutes or more before serving, so flavors can meld.</li><li>Drizzle a little olive oil over the top.</li></ol>	greek	75	2	f	f	f	f
154	Hummus with roasted orange peppers	https://spoonacular.com/recipeImages/Hummus-with-roasted-orange-peppers-647634.jpg	<ol><li>Find the directions for preparation here - http://divinespicebox.com/2014/06/08/hummus-with-roasted-orange-peppers/</li></ol>	greek	45	2	t	t	t	t
155	Hummus With Tahini Sauce	https://spoonacular.com/recipeImages/Hummus-With-Tahini-Sauce-647636.jpg	<ol><li>In a food processor mix all the ingredients and process them on high speed.</li><li>Pour into a serving bowl, garnish with parsley, Sumac, Cumin and Olive Oil, or you may garnish to your liking using whole chickpeas and Olive Oil.</li></ol>	greek	45	2	t	t	t	t
156	Hummus Wrap With Carrots and Cucumbers	https://spoonacular.com/recipeImages/Hummus-Wrap-With-Carrots-and-Cucumbers-647638.jpg	<ol><li>Start with hummus. Throw all the ingredients into a food processor and process until smooth. The mixture might be a bit thick and hard to process so you can add few tablespoons of water or a bit more olive oil.</li><li>Tip: if I dont have tahini at home I simply toast 1 or 2 Tbsp sesame seeds and throw to a food processor instead of tahini.</li><li>Spread 2 Tbsp hummus in the center of a tortilla leaving about an inch on a top and bottom and few inches on a sides.</li><li>Follow with the lettuce, carrots, cucumbers and olives.</li><li>Fold top and bottom edges of the tortilla, turn 90 degrees and wrap the remaining tortilla around the filling. Wrap the tortilla in aluminum foil to hold its shape. Cut into half.</li></ol>	greek	45	1	t	t	t	t
157	Lamb and Fresh Goat Cheese Roulade	https://spoonacular.com/recipeImages/Lamb-and-Fresh-Goat-Cheese-Roulade-649183.jpg	<ol><li>Heat 2 tbsp. olive oil in a saut pan over medium high heat.</li><li>Add the garlic and saut for 10 seconds then add the spinach and saut only until the spinach wilts.</li><li>Set aside to cool.</li><li>Lay out the lamb loin and butterfly to create a flat piece about 6 inches wide.</li><li>Season the loin with salt and pepper.</li><li>Squeeze the excess water from the spinach and spread evenly over the lamb loin.</li><li>Split the goat cheese in half lengthwise and then in half again to create 4 lengthwise quarters.</li><li>Place 2 quarters end to end on each prepared lamb loin.</li><li>Roll and truss each prepared loin.</li><li>Preheat oven to 375F.</li><li>In a large saut pan, heat cooking oil over medium high heat and sear each loin for 3-4 minutes on all sides.</li><li>Roast lamb loins in the oven for 10 -12 minutes until an internal temperature of 120F is reached.</li><li>Remove from the oven and let rest for 10 minutes.</li><li>Remove string and slice into  medallions.</li><li>Divide among 2 plates and serve.</li></ol>	greek	45	6	f	f	t	f
158	Lamb Burgers With Tzatziki Sauce	https://spoonacular.com/recipeImages/Lamb-Burgers-With-Tzatziki-Sauce-649195.jpg	<ol><li>For the lamb burger, mix 1 pound ground lamb, 1 egg, 1 splash of extra-virgin olive oil, the juice of 1 lemon, 1/4 cup chopped flat leaf parsley, and 6 cloves of chopped garlic. Season with kosher salt &amp; pepper to taste and let sit for  to 1 hour.</li><li>Grill burgers to your liking.</li><li>For the tzatziki sauce, mix together 1 pint Greek yogurt, 1 diced cucumber, juice of 1 lemon, 1 tablespoon extra-virgin olive oil, 6 garlic cloves (add garlic bit by bit until you have the level of garlic you like), 1 handful minced fresh dill, and kosher salt and fresh cracked pepper to taste. Refrigerate overnight to let the flavors intensify.</li><li>Serve the grilled burgers on toasted buns and add a dollop of the sauce on top.</li></ol>	greek	45	4	f	f	f	f
159	Lamb Moussaka	https://spoonacular.com/recipeImages/Lamb-Moussaka-649225.jpg	<ol><li>CUT eggplant into 1/4" (5mm) thick slices. Layer in colander, sprinkling each layer with salt. Let stand 30 minutes.</li><li>RINSE eggplant; pat dry. Place in single layer on baking sheet. Brush with olive oil. Broil, turning once for 4 to 6 minutes on each side, until golden and softened. Set aside. Repeat until all eggplants are cooked.</li><li>SAUTE zucchini in large oiled frying pan until tender-crisp. Set aside.</li><li>Meat Sauce:COOK lamb in large saucepan on high heat, breaking up with spoon, for 5 minutes. Drain off fat. Add onions, garlic and oregano. Cook on medium for 5 minutes. Add tomatoes, tomato paste and wine. Simmer 10 minutes, or until mixture starts to thicken. Stir in parsley, salt and pepper. Set aside.</li><li>White Sauce:MELT margarine in large saucepan. Add flour, mixing until smooth. Gradually add milk. Cook, stirring constantly until mixture comes to a boil and is thickened. Add salt and nutmeg. Add a bit of hot mixture to beaten eggs then return to saucepan and cook 2 minutes longer, stirring occasionally.</li><li>To Assemble:Tips:Place pan on a baking sheet or piece of foil to catch any drips that may boil over.</li><li>MAKE-AHEAD: After assembling, cool completely, uncovered in refrigerator. Cover with plastic wrap and refrigerate for 1 day or overwrap with heavy foil and freeze up to 3 weeks. Thaw in refrigerator 48 hours before baking.</li><li>Replace lamb with beef.</li><li>A thin bottom layer of sauteed sliced potatoes can be added.</li><li>A make-ahead layered Greek casserole that's ideal for potlucks and family reunions.</li></ol>	greek	45	12	f	f	f	f
160	Lemony Greek Lentil Soup	https://spoonacular.com/recipeImages/Lemony-Greek-Lentil-Soup-649886.jpg	<ol><li>Put the lentils, water, carrot and 1 teaspoon dried thyme into an 8-quart stockpot, cover and set over medium heat.</li><li>After 15 minutes, lower the heat somewhat and gently bring the water to a simmer, which should take another half an hour or so.</li><li>Once the lentils have reached the boiling point, turn off the burner and let them sit for 1 hour.</li><li>After the hour, bring the soup back to a simmer and add the lemon juice, dry basil, fresh thyme, oregano, pepper and salt and simmer for 1 hour.</li><li>Now, slowly saut the onion and garlic in the olive oil until the onion is tender.</li><li>Coarsely chop the tomatoes (I do this with kitchen scissors right in the can), and add them and the onion mixture to the soup. Adjust the salt to taste.</li><li>Bring everything back to the boiling point and simmer for another hour.  After this point, you can turn your burner to its lowest setting, and this soup will happily sit steaming with its lid cocked for several hours until you are ready to enjoy it.  Add more water if necessary.</li><li>Serve with crusty bread and a soft cheese like St. Andre or Cambazola</li></ol>	greek	45	6	f	f	t	t
161	Pasta With Roasted Vegetables and Greek Olives	https://spoonacular.com/recipeImages/Pasta-With-Roasted-Vegetables---Greek-Olives-654939.jpg	<ol><li>Preparation:</li><li>Cook spaghetti, rinse & drain, set aside </li><li>Sear the meat with onions, set aside (color equal flavor dont make gray and bubbly)</li><li>Roast vegetables with olive oil (sear them dont Cooke them)</li><li>Roast sliced mushrooms</li><li>For the sauce: combine all ingredients bring to boil then simmer on low heat for about 10 minutes</li><li>Serve:</li><li>Lay pasta in the bottom of the plate then the sauce, meat goes on top of sauce</li><li>Then start layering the vegetables the mushrooms, add a the cheese & olives</li><li>Garnish with fresh Basil.</li></ol>	greek	45	8	f	f	f	f
162	Pork Shoulder Tacos with Chipotle Greek Yogurt and Coleslaw	https://spoonacular.com/recipeImages/Pork-Shoulder-Tacos-with-Chipotle-Greek-Yogurt-and-Coleslaw-656820.jpg	<ol><li>To Make the pork shoulder:</li><li>Place all ingredients in the crock pot.  Cook for 5 hours on low.  Meat should be tender and easily shred when finished cooking.</li><li>To Make the Chipotle Greek Yogurt:</li><li>In a small bowl, add the Greek yogurt.  Crack open your can of chipotle chilies in adobo sauce and remove the seeds from 3 or 4 of the chilies (about half of the can). Finely chop and add to the Greek yogurt. Add about a teaspoon of the adobo sauce.  Stir. For a spicier sauce, add additional chipotle chilies.</li><li>To Make the no-mayo coleslaw:</li><li>Thinly slice the cabbage and chop the green onion.  Peel and julienne the carrot.  Add all veggies to a large mixing bowl.  Mix the lime juice, apple cider vinegar and olive oil together in a small bowl.  Drizzle the liquid over the veggies.  Add salt and pepper to taste and if youre one of those cilantro people, add a handful of chopped cilantro.  Mix thoroughly and serve on your taco.</li><li>To assemble the tacos, simply heat your favorite tortilla on the stove until warm. Spoon desired amount of meat, chipotle Greek yogurt sauce, and coleslaw on the tortilla and enjoy!</li><li>Nutritional information is per taco.</li></ol>	greek	45	12	f	f	t	f
163	Roasted Eggplant Hummus	https://spoonacular.com/recipeImages/Roasted-Eggplant-Hummus-658573.jpg	<ol><li>Preheat oven to 425 degrees.</li><li>On a large baking sheet toss eggplant, 2 tablespoons olive oil, salt and pepper and spread in a single layer.</li><li>Roast for 18-20 minutes.</li><li>Remove from oven and set aside.</li><li>In food processor combine, chickpeas, tahini, garlic, lemon juice, 2 tablespoons olive oil and pulse 3 or 4 times.</li><li>Add eggplant and blend on highest level until desired consistency.</li><li>Store in air tight containers in the refrigerator.</li></ol>	greek	45	6	t	t	t	t
164	Spanakopita (Greek Spinach Pie)	https://spoonacular.com/recipeImages/Spanakopita-(Greek-Spinach-Pie)-660843.jpg	<ol><li>Heat vegetable oil in a large saucepan over medium heat. Slowly cook and stir onions until softened. Mix in spinach, dill and flour. Cook approximately 10 minutes, or until most of the moisture has been absorbed. Remove from heat. Mix in feta cheese, eggs, salt and pepper.</li><li>Lay 1 sheet of phyllo dough in prepared baking pan, and brush lightly with olive oil. Lay another sheet of phyllo dough on top, brush with olive oil, and repeat process with 10 more sheets of phyllo. The sheets will overlap the pan.</li><li>Spread spinach and cheese mixture into pan and fold overhanging dough over filling. Brush with oil, then layer remaining sheets of phyllo dough, brushing each with oil. Tuck overhanging dough into pan to seal filling.</li><li>Bake in preheated oven for 30 to 40 minutes, until golden brown. Cut into squares and serve while hot.</li></ol>	greek	45	8	t	f	f	f
165	Easy Lemon Feta Greek Yogurt Dip	https://spoonacular.com/recipeImages/easy-lemon-feta-greek-yogurt-dip-716403.jpg		greek	45	1	t	f	t	f
166	Coconut Chicken Curry with Snow Peas and Rice	https://spoonacular.com/recipeImages/Coconut-Chicken-Curry-with-Snow-Peas-and-Rice-157311.jpg	<p>1. Heat coconut oil in a pan over medium-high heat. Pre-heat the oven to 190 C or 375 F. Start cooking the brown rice.</p><p>2. Add the cubed chicken breast to the pan for a couple minutes until browned. Transfer the chicken from the pan into a casserole dish.</p><p>3. Fry the garlic and ginger in the pan, adding more coconut oil if necessary. Add the spices until fragrant.</p><p>4. Add the coconut milk and tomato paste to the pan.</p><p>5. Start steaming the frozen snow peas, giving the flavors in the sauce some time to meld.</p><p>6. Pour the sauce over the chicken breast cubes.</p><p>7. Put the casserole dish in the oven for about 25 minutes, adding the snow peas for the last 10 minutes or so. Once the chicken is cooked through, stir in the lemon grass paste.</p><p>8. Serve the chicken curry over brown rice.</p><p><span></span></p>	indian	45	2	f	f	t	t
167	Indian Spiced Red Lentil Soup	https://spoonacular.com/recipeImages/Indian-Spiced-Red-Lentil-Soup-631752.jpg	<ol><li>Put Cilantro Stems in Water and bring to a boil then remove Stems (This step is optional)</li><li>Rinse the Lentils and add to Stem Broth</li><li>Bring Lentils to a boil then turn heat down to medium</li><li>Add a bit of Lentil water to the Bullion cubes, mash well then add to Lentils</li><li>In a saut pan add  Grapeseed Oil, Coriander Seeds (you can put the seeds in a coffee grinder if you prefer) Cumin Seeds, Turmeric, Garam Masala.</li><li>Saut on medium heat until fragrant approximately about 5 minutes.</li><li>Mince Serranos, grate Ginger, mince Onions, mince Garlic and add to pan then saut until Onions are soft.</li><li>Add Tomato Sauce and cook on medium low for about 10 minutes then add to cooked Lentils and cook for 20 more minutes on low heat.</li><li>If you like a smooth texture to your soup you can put all of it in a food processor (blender or hand blender) to puree` or only use half for a slightly textured soup or leave it if you like it that way.</li></ol>	indian	45	12	t	t	t	t
168	Apple Curry Soup	https://spoonacular.com/recipeImages/Apple-Curry-Soup-632528.jpg	<ol><li>Sweat leeks and mushrooms in vegetable oil until tender (without color) in a heavy gauge sauce pot</li><li>Add apples, apple cider, coconut milk, curry powder, turmeric. Bring to boil and simmer for 20 minutes.</li><li>Add the Chavrie and season with salt and pepper</li><li>Pour entire contents in a blender and puree or puree with a hand held mixer</li><li>Strain through a fine chinois. And keep warm</li><li>Serve hot</li><li>Garnish with slices of apple or a dollop of Chavrie</li></ol>	indian	45	1	t	f	t	f
169	Baked Chickpea and Chili Koftas in a Hot Jalfrezi Curry Sauce	https://spoonacular.com/recipeImages/Baked-Chickpea---Chili-Koftas-in-a-Hot-Jalfrezi-Curry-Sauce-633544.jpg	<ol><li>Preheat oven to 180 degrees celcius (356 Fahrenheit) and line a large baking tray with parchment paper.</li><li>Make the Kofta  Heat 2 tbsp water in a saute pan over a medium heat and add the onion, garlic and chili and cook for 4 minutes, transfer to a food processor (or use a stick blender) add the coriander and the Kofta Spice Mix and pulse until smooth.</li><li>In a large mixing bowl, mash the chickpeas until they are all crushed then add the mixture from step 2 along with the gram flour and mix thoroughly together, if its too wet, add a little more gram flour. Using damp hands take a heaped tablespoon of the kofta mixture and shape into a ball and place on the parchment paper, you should get 18  20 koftas. Cook in the oven for 20  25 minutes, they should firm up quite nicely in the oven.</li><li>Now make the Jalfrezi  Add the onion, ginger, garlic and chili to a food processor and pulse until smooth.</li><li>Heat 2 tbsp of water in a deep sauce pan, add the onion mixture from step 4 along with all the Jalfrezi Spice Mix and cook for 3 minutes to release the flavours before adding in the green peppers, passata, peas and lemon juice, bring to the boil then reduce the heat to medium, cover the pan and cook for 20 minutes and just before serving stir through the coriander. Serve in a bowl with the koftas placed on top!</li></ol>	indian	45	2	t	t	t	t
170	Balti Butter Chicken	https://spoonacular.com/recipeImages/Balti-Butter-Chicken-633960.jpg	<ol><li>Marinate the cleaned cubed chicken for all the ingredients and keep it in fridge for a minimum of 5 hours or the best overnight.</li><li>Grill it in a Tandoor oven or bake it conventional oven at 400 F for 30-40 minutes,till they are firm n brown.When the juices run out,take it n reserve.</li><li>Take a kadai n melt some butter,add the onion and green chilies and saute till pink.Take it out n blend in a mixer.</li><li>In the same pan,pour butter,splutter fennel seeds and roast the whole spices.</li><li>Now add the nuts and raisins and roast till brown n plump.(you can roast it separately n add to the gravy at last also)</li><li>Now bring back the onion paste and saute till brown.Add the reserved juice too..</li><li>Add the tomato puree and mix.</li><li>Add the chili powder,pepper powder ,salt and half of garam masala.Mix well and simmer for 2 minutes</li><li>Sprinkle the ketchup.</li><li>Now put the roasted chicken in it and cover with the gravy.</li><li>Simmer and cover with a lid for 5-8 minutes.</li><li>Now remove the lid and cook until the desired dryness level is achieved.</li><li>Add the fresh cream n stir in for a minute.</li><li>Sprinkle the Garam masala powder,a tad of sugar and mix well.</li><li>Garnish with cilantro leaves.</li><li>Add a wee bit of butter before serving..:)</li></ol>	indian	45	2	f	f	t	f
171	Beef and Tomato Curry Over Quinoa	https://spoonacular.com/recipeImages/Beef-and-Tomato-Curry-Over-Quinoa-634579.jpg	<ol><li>Season both sides of the beef with curry powder and set aside.</li><li>Cook the onion in the olive oil over medium heat in a sautee pan.</li><li>Add the garlic, ginger, and chile once the onion becomes translucent.</li><li>Add the curry powder and stir to coat everything in the pan.</li><li>Add the tomato paste and cook until the paste starts to darken, stirring often to prevent burning.</li><li>Deglaze with the wine and stir until the liquid is absorbed.</li><li>Transfer the contents of the pan into a crock pot.</li><li>Sear the beef over high heat on both sides, transfer to crock pot.</li><li>Add the can of tomatoes and bay leaf. If needed, add chicken stock or water so the beef is almost covered. Set your crock pot on low and cook until you can shred the beef with a fork. Check for seasoning and add salt and pepper to taste. (Remove bay leaf and ginger piece.)</li><li>Prepare quinoa according to package directions and serve tomato beef curry over the top.</li></ol>	indian	45	4	f	f	t	t
172	Beef Vindaloo	https://spoonacular.com/recipeImages/Beef-Vindaloo-634712.jpg	<ol><li>For marinade: Blend together garlic and red wine vinegar. Add chilies, cumin, turmeric, mustard, ginger, salt, sugar, lemon peel, juice, and pulp and blend well.</li><li>Place beef in bowl and pour marinade over it. Stir in poppy seeds and sit for 2 hours.</li><li>Heat clarified butter in pan and add onion. Cook until translucent, then add bay leaves and cloves. With slotted spoon, lift meat from marinade and add to onions. Increase heat to sear meat. Pour in marinade. Cover tightly, reduce heat and cook 1 hour.</li><li>After 1 hour, add tomato paste, stirring thoroughly, and cook another 30 minutes, until meat is tender. Season with salt and pepper.</li><li>This recipe yields 4 servings.</li><li>Comments: A specialty of The Sultan, Surfers' Paradise, Australia.</li></ol>	indian	45	1	f	f	t	f
173	Channa-Chickpea, Potato and Cauliflower Curry	https://spoonacular.com/recipeImages/Channa-Chickpea--Potato---Cauliflower-Curry-637426.jpg	<ol><li>In a large pot heat oil.</li><li>Add onions saute until very soft.</li><li>Add garlic and ginger, saute for 3-4 minutes.</li><li>Add spices, saute with potatoes until they are covered with the spice mixture.</li><li>Add water to cover.</li><li>Simmer until potatoes are soft.</li><li>Add chickpeas, and cauliflower.</li><li>Simmer with lid on for 20 minutes,stirring occasionally.</li><li>Season with salt,sugar and vinegar. Serve with brown rice</li></ol>	indian	45	8	t	t	t	t
174	Curry Beef Over Rice Noodles	https://spoonacular.com/recipeImages/Curry-Beef-Over-Rice-Noodles-641111.jpg	<ol><li>In nonstick skillet, add oil and saut beef over medium-high heat for 3-4 min. Add red onions, garlic, saut for about 4 minutes. Add fresh ginger, sambal oelek, curry powder; cook, stirring, until fragrant, about 45 seconds.</li><li>Add soy sauce, lime juice and peanuts.  Saut another 30 seconds.  Server over rice noodles.</li></ol>	indian	45	2	f	f	f	t
175	Curry Mussels	https://spoonacular.com/recipeImages/Curry-Mussels-641128.jpg	<ol><li>In a big pot or cocotte, put in olive oil and onion. Fry the onions until soft but not brown.</li><li>Then, put in white wine, parseley, salt, pepper, and cayenne pepper.</li><li>Stir for a few minutes before putting the mussels in the pot. Put the lid on and cook the mussels for about 2-3 minutes, shaking the pan occasionally.</li><li>Use tongs to lift out the mussels as they open, putting them into a warm dish. Throw away any mussels that havent opened after 3 minutes.</li><li>Strain the liquid through a fine sieve into a clean saucepan, leaving behind any grit or sand.</li><li>Bring to the boil and  boil for 2 minutes.</li><li>Add the curry powder and crme fraiche, stir. Reheat the sauce without boiling and let the sauce thicken.</li><li>Serve the mussels in individual bowls with the sauce poured over.</li><li>Sprinkle with some parsley.</li></ol>	indian	20	4	f	f	t	f
176	Dum Mutton Biryani	https://spoonacular.com/recipeImages/Dum-Mutton-Biryani-641739.jpg	<ol><li>N a pressure cooker,on medium high heat add mutton ,dry spices and 1 tsp salt to 2 cups water.Close the lid and let it pressure cook until the meat is 80%% cooked.This can be tested by opening the lid and squeezing the mutton pieces with fingers, it should be just tender & and not falling apart or soft.</li><li>Once cooked, reserve the stock from pressure cooker into a bowl, separate the mutton from spices and set aside the mutton pieces to cool.Throw away the collected spices.</li><li>Meanwhile,wash the rice thoroughly and set aside.</li><li>In a pan , heat the oil till ripples are formed on the surface.Stir-fry the cooled mutton pieces in this oil for about 1-2 minutes.Take the mutton out and in the same oil on medium heat ,add the onions and stir fry them untill golden brown.Once the onions are done, add the cumin seeds, red chili powder[if using] , dry coriander powder and saute for about 2 minutes.</li><li>Next, add the washed rice to the pan and saute for about 3 minutes.This gives the rice a nutty flavor.</li><li>After the rice is sauted, switch off the heat and add the mutton pieces, salt and about 2.5 cups of reserved stock to the pan.Let the rice soak for about 20 minutes.</li><li>To the soaked rice, add the saffron -milk ,cover with lid and let the rice cook on low- medium heat.The amount of rice I used took around 15 minutes to cook at low heat.You can adjust stock/water as per your rice variety.</li><li>While the rice is cooking,let the tava/girdle heat up on high heat.Switch off the heat once the rice is done and transfer the pan to the top of heated tava.Seal the edges of the pan and lid with kneaded dough on all sides so that no steam can escape .This process is called dum cooking wherein the dish is slowly cooked on very low heat, mostly in sealed containers, allowing the meats to cook, as much as possible, in their own juices andso thatthe aromas of spices are absorbed within the dish. You can read more about it here and here.</li><li>After cooking on dum for about 8-10 minutes remove the pan from tava and let it rest for about 10 minutes.</li><li>Thereafter, break the dough seal , transfer to a serving vessel and garnish with cilantro leaves ,fried onions & nuts [if using] .</li><li>Serve with raita and salad.</li><li>Notes:</li><li>Seasoning the water in which the rice will cook is very important else the biryani will be tasteless.</li><li>Be patient while the biryani cooks.Avoid opening the lid again and again and stirring while the rice cooks.</li><li>After dum cooking, it is mandatory to let the biryani rest for some time.Do not skip this step.</li><li>Enjoy!</li></ol>	indian	45	3	f	f	f	f
177	Gujarati Dry Mung Bean Curry	https://spoonacular.com/recipeImages/Gujarati-Dry-Mung-Bean-Curry-646043.jpg	<ol><li>Wash the mung beans and boil them in plenty of hot water with a pinch of baking powder until al-dente. If you have a pressure cooker thats about 6-7 whistles. Drain and set aside.</li><li>In a large pan heat the oil and add the mustard seeds (wait for them to pop) then add the cumin seeds, asafoetida, curry leaves, garlic and chilies. Saut until aromatic. Obviously dont let it burn.</li><li>Add the tomatoes, turmeric and mung beans and cook for two minutes. Be careful not to mash it up as you stir.</li><li>Add the salt, sugar, lemon juice and cinnamon powder and cook for a further two minutes.</li><li>Throw in the chopped coriander, combine and serve.</li></ol>	indian	45	4	t	t	t	t
178	Keema Curry	https://spoonacular.com/recipeImages/Keema-Curry-648809.jpg	<ol><li>Saute curry powder in oil over medium heat for 2 to 3 minutes. Add onions and brown. Add garlic and coriander and stir. Add meat and brown. Add salt and tomatoes, if using fresh tomatoes first peel, seed, and slice and cover. Cook over low heat for about 20 to 25 minutes. Add peas, mix in, cover again, and cook for about 5 minutes until peas are done.</li><li>Do not use a black cast iron skillet, the curry powder will get in the pores. Frozen peas work better (and are easier) than fresh.</li></ol>	indian	45	4	f	f	t	t
179	Luscious Palak Paneer	https://spoonacular.com/recipeImages/Luscious-Palak-Paneer-650484.jpg	<ol><li>Blanch the spinach in hot water with a tiny pinch of baking powder (which keeps it beautifully green!) and drain when wilted. Place in a blender and puree with a cup of water. Set the puree aside.</li><li>In a large pan heat the oil and add the onions, garlic, ginger, chilies and tomatoes. Cook for around 5 minutes on a high heat stirring constantly. Do not let it burn.</li><li>Add the spinach puree, turmeric powder, cumin powder, coriander powder, fennel powder, cinnamon powder, cardamom powder and salt to taste. Simmer on a medium heat until the oil separates from the spinach mixture.</li><li>Add the paneer and single cream if you wish and remove from the heat.</li><li>Serve with naan, rice, paratha or if you cant wait, a spoon.</li></ol>	indian	45	4	t	f	t	f
180	Mughlai Malai Kofta Curry	https://spoonacular.com/recipeImages/Mughlai-Malai-Kofta-Curry-652542.jpg	<ol><li>Boil the potatoes, cool, peel and grate them.</li><li>Grate paneer.</li><li>Wash all green chilies, deseed and chop them fine.</li><li>Peel carrots,grate them, add peas and some water, boil them in microwave for 10 mins. Once done, remove excess by passing &amp; squeezing it through a muslin cloth.</li><li>Peel onions, cut them into halves and boil with a cup of water for ten minutes. Drain excess water, cool onions and grind them into a smooth paste. Set Aside.</li><li>In a bowl, mix mashed potatoes, paneer, some chopped green chilies, boiled carrot-peas, corn flour and salt. Mix well. Divide into 20-22 equal sized balls. Stuff  raisins &amp; cashew into them. Deep fry in hot oil until slightly golden brown. Drain and keep aside. Fry one kofta and check for binding, if it breaks, add a little more cornflour. Deep fry in hot oil.</li><li>OR BAKE in a 375F pre-heat oven, by arranging &amp; spraying oil on these koftas placing them on a cookie sheet wraped with aluminum foil,for 10 mins. Keep a close watch, with the help of tongs, turn them once they are slight brown on one side.</li><li>On the other side heat oil in a kadai, add shahjeera, boiled onion paste and cook for five minutes. Add ginger &amp; garlic, few chopped green chilies, coriander powder, cumin powder, turmeric powder, and salt. cook for a minute.</li><li>Add tomato puree and red chili powder and cook on medium flame untill oil separates from gravy.</li><li>Add half&amp;half along with some water &amp; bring it to a boil and simmer for ten minutes on a slow flame. Stir occasionally.</li><li>Stir in fresh cream and garam masala powder.</li><li>Gently put all of these kofta's in the gravy when ready to serve. Simmer for another 2 mins and enjoy this rich, creamy gravy with Nan/Roti (Indian Flat Bread.)</li></ol>	indian	45	4	t	f	t	f
181	Roasted Acorn Squash Stuffed with Spicy Biryani	https://spoonacular.com/recipeImages/Roasted-Acorn-Squash-Stuffed-W-spicy-Biryani-(Veg-vegan)-658482.jpg	<ol><li>Preheat the oven to 400 degrees. On a baking sheet place the squash halves, spray with PAM and sprinkle with 1-2 tbsp garam masala. Place in the oven and BROIL till tender and charred- about 10-15 minutes.</li><li>While the squashes are roasting, in a large skillet, spray with PAM and add vegetable oil and set over medium heat. Add the cashews and saute until fragrant and slightly darkened. Add onions and peppers, sprinkle with black pepper and saute until soft, about 5-7 minutes. Once the onions and peppers are soft, but now brown, add the soaked basmati rice (make sure not to get any water in it!). Saute for 5-7 minutes. You want to toast the the rice.</li><li>Remove the squash from the oven and cool for a few minutes before handling. Score the squash into small cubes, WITHOUT cutting through the skin. Scoop the cubes out into a bowl and set aside. Keep the shell aside, DONT throw out!</li><li>Once the rice is toasted add 1 cup of water, pinch of saffron, cover and cook on medium-low heat, about 15 minutes. You want the rice to be cooked thru, not mushy so dont mix it around too much! Once the rice is cooked, add the cubed squash, tossing gently (you dont want the squash to break and mush around the rice). Add the Biryani paste and toss to coat. Mix in 3/4 of the chopped cilantro. Taste for salt and biryani flavor- it should be strong, spicy and aromatic.</li><li>In a small skillet, spray with PAM and set over medium-high heat. Add onion slices, and saute without breaking up the circles. Cook until brown-ish about 4-5 minutes. Set aside.</li><li>Fill each squash bowl with rice, just coming over the top. Top each one with an onion round and sprinkle with remaining chopped cilantro. Serve with yogurt or raita.</li><li>Biryani paste:</li><li>In a medium skillet, spray with pam, add oil and set over medium-high flame. Add onions and tomatoes, saute until golden-brown about 4-5 minutes. Add garlic, ginger, chili powder and cilantro. Saute until vegetables are soft and fragrant about 4-5 minutes. Add the biryani paste and mix well, making sure all the veggies are coated. Remove from the heat and let cool (10-15 minutes).</li><li>In a grinder/food processor, add the biryani mixture and grind until smooth (slightly chunky is ok). Store in an air tight container. Can be kept in the fridge for 1-2 weeks, or in the freezer- for a while!</li></ol>	indian	45	4	t	f	t	t
182	Slow Cooker Lamb Curry	https://spoonacular.com/recipeImages/Slow-Cooker-Lamb-Curry-660290.jpg	<ol><li>Pull out your slow cooker and add everything into the pot with the exception of the yogurt.</li><li>Now turn on your pot, setting it on low for the next 4-6 hours or high for the next 3-5.</li><li>When the time is up, open up your slow cooker, grab your yogurt and stir it into the curry.</li><li>Serve over rice.</li></ol>	indian	45	8	f	f	t	f
183	Beef Pot Pies with Irish Cheddar Crust	https://spoonacular.com/recipeImages/Beef-Pot-Pies-with-Irish-Cheddar-Crust-634660.jpg	<ol><li>Make the pastry: Place the cut up butter pieces in the freezer for 15 minutes to chill. Meanwhile, in the work bowl of a food processor combine flour, sugar, dry mustard, salt and cayenne pepper. Pulse to combine. After the butter has chilled, scatter the pieces over the flour mixture (still in the food processor), along with the cheddar. Pulse about 10 times. Sprinkle half the ice water over the dough, pulse about 3 times, repeat with remaining water, pulsing 3 more times. Pinch the dough to check if it sticks together, if not add a tablespoon or two more ice water, until it comes together. Dump the mix in a large bowl and press it together to form the dough. Divide dough in half, shaping each into a 4-inch disk. Wrap each piece in plastic wrap and refrigerate at least an hour.</li><li>Begin the filling: Pat the meat dry with paper towels and season with salt & pepper. Heat 2 t. oil in a large skillet over medium high heat until just smoking. Add the meat in a single layer and cook, without stirring, until the meat browns well on the underside, anywhere between 5-10 minutes (the meat will give off liquid, just let it evaporate - leave it alone!) Stir the meat and cook another couple minutes, until it looses the raw color. Remove to a plate and set aside.</li><li>Reduce heat to medium, add the remaining 2 t. oil and the onions and carrots. Saute until softened and starting to brown, stirring occasionally, around 5 minutes. Add the garlic, thyme and marjoram, cook until very fragrant, about a minute. Stir in flour, cook and stir about a minute. Slowly add in the beef broth and water, then the meat, along with any juices left on the plate. Bring to a simmer, then reduce the heat to low, to med-low. Cover and cook, (adjusting the heat as necessary to maintain a simmer) stirring occasionally until the meat is just becoming tender, around 45 minutes. Remove from heat, add in the Dijon and parsley. Adjust seasoning with salt & pepper. Set aside to cool.</li><li>Rolling out the crust, filling & baking the pot pies: Remove the dough from the refrigerator 10 minutes before rolling it out. Roll the dough out on a well-floured surface, large enough to cut out 3, 7-inch circles out of each half (save the scraps). Line each cup of a large-sized muffin tin with the dough. (It won't look very pretty, you just kind of have your way with it to get it pressed in there.) Refrigerate the filled tins as well as the dough scraps 15 minutes to firm back up.</li><li>Meanwhile, preheat oven to 400 degrees. After 15 minutes and the filling has cooled down quite a bit. Divide the mixture evenly between crusts. Divide the remaining dough into 6 balls. Roll out each piece wide enough to cover the pot pies. Pinch the top and bottom crust edges together to seal, and finish the edges in whatever decorative way you like. Brush the tops with the beaten egg. Bake 35-40 minutes, rotating the pan after 20 minutes. Remove from oven & let sit 5 minutes before (carefully) removing the pot pies from the tin.</li></ol>	irish	45	6	f	f	f	f
184	Colcannon	https://spoonacular.com/recipeImages/Colcannon-639900.jpg	<ol><li>Cut into top of cabbage and hollow it out, leaving 3-4 outside leaves intact, reserving the hollowed-out portion. Plunge the hollowed-out head into large amount of boiling water; simmer 5 minutes or until tender-crisp. It must hold its shape. Cool quickly in cold water; invert and drain.</li><li>Chop reserved cabbage pieces, measure 1 1/2 cups. Stir fry in butter along with green onions until tender. Set aside. Boil and mash potatoes adding milk and seasonings. Stir in the sauteed mixture and parsley.</li></ol>	irish	45	8	f	f	t	f
185	Corned Beef and Cabbage	https://spoonacular.com/recipeImages/Corned-Beef-and-Cabbage-640134.jpg	<ol><li>Wipe corned beef with damp paper towels. Place in large pan, cover with water. Add garlic, cloves, black peppercorns, and bay leaves. Bring to boil. Reduce heat; simmer 5 minutes. Skim surface and cover pan; simmer 3 to 4 hours, or until corned beef is fork-tender. Add carrots, potatoes, and onions during last 25 minutes.    Add cabbage wedges during last 15 minutes. Cook vegetables just till tender. Slice across the grain. Arrange slices on platte</li></ol>	irish	45	6	f	f	t	t
186	Corned Beef and Cabbage with Irish Mustard Sauce	https://spoonacular.com/recipeImages/Corned-Beef-And-Cabbage-With-Irish-Mustard-Sauce-640136.jpg	<ol><li>Combine corned beef and water to cover in a large Dutch oven; bring to a boil then remove from heat. Drain. Add fresh water to cover. Add onion, carrot, parsley, bay leaf, and pepper. Bring to a boil once again, then reduce to a low simmer. Skim off foam, if necessary. Cover and simmer 4 hours or until tender.</li><li>Remove onion and parsley. Add potatoes to Dutch oven. Simmer 10 minutes. Add cabbage wedges, and simmer 20 minutes or until vegetables are tender. Remove and discard bay leaf.</li><li>To make the Irish Mustard Sauce, combine cornstarch, sugar, dry mustard and salt in a medium saucepan; stir well. Add water and cook over low heat, stirring constantly, until thickened. Remove from heat. Stir in vinegar, butter and horseradish. Gradually stir about 1/4 of hot mixture into yolks; add to remaining hot mixture, stirring constantly. Cook over low heat, stirring constantly, until thickened.</li><li>Transfer corned beef and vegetables to a serving platter. Serve with Irish Mustard Sauce.  </li></ol>	irish	270	6	f	f	t	t
187	Guinness Braised Corned Beef and Cabbage	https://spoonacular.com/recipeImages/Guinness-Braised-Corned-Beef-and-Cabbage-646034.jpg	<ol><li>Season both sides of the corned beef liberally with pepper. The corning of the beef makes the beef salty enough, so no need to add more.</li><li>Heat 1 TBSP oil in a large, shallow oven-safe pot over medium-high heat. Add beef and sear each side for about 3 minutes, just to develop a nice brown crust. This will seal in the beef's juices.</li><li>Remove beef to a plate. Pour guinness into the pot to deglaze. Scrape up any browned bits. Add beef broth, pickling spice, brown sugar, bay leaf, and minced garlic. Bring mixture up to a simmer.</li><li>Return the beef to the pot with any additional juices that have accumulated on the plate.</li><li>Cover the pot and place on the bottom rack in your oven. Bake for 2 1/2 - 3 hours, or until a fork can easily be inserted into the meat.</li><li>Baste the meat with the surrounding juices every 30 minutes or so.</li><li>After 2 hours, add carrots, parsnips, and potatoes to the pot. They will only take about 25-30 minutes of simmering to cook.</li><li>Remove pot from the oven. Place beef on a cutting board and let it rest for 15 minutes before carving into thin slices (cut against the grain of the meat). Remove vegetables and arrange them on a serving platter. Cover with foil. Place the pot on the burner and bring sauce to a boil. Add cabbage and cook for about 7 minutes, until it has softened. Place the cabbage on the serving platter with the other vegetables.</li><li>Strain the sauce in the pot and stir in 2 or 3 TBSP of spicy honey mustard until dissolved. Place in a small dish or gravy boat with a ladle and serve alongside the beef.</li><li>After slicing the beef and arranging it on the serving platter, ladle the guinness mustard sauce over the top to rehydrate and glaze the beef and vegetables.</li></ol>	irish	45	6	f	f	f	t
188	Irish Colcannon	https://spoonacular.com/recipeImages/Irish-Colcannon-647974.jpg	<ol><li>Chop the cabbage and steam, using minimal water, until quite well done.</li><li>Boil potatoes. Clean and chop the leeks, including the first couple of inches of green, put into a saucepan with the milk and simmer until tender.</li><li>If using bacon, saute until crisp. When cool enough to handle, break into bite size pieces.</li><li>Drain potatoes and mash.</li><li>Stir in milk with leeks, cabbage, mace, garlic, and bacon. Gently mix to combine all ingredients, but take care not to over mash the potatoes.</li></ol>	irish	45	4	f	f	t	f
189	Irish Soda Bread with Raisins	https://spoonacular.com/recipeImages/Irish-Soda-Bread-with-Raisins-648004.jpg	<ol><li>Preheat oven to 375F. Spray 8-inch-diameter cake pan with nonstick spray. Whisk flour, 4 tablespoons sugar, baking powder, salt, and baking soda in large bowl to blend. Add butter. Using fingertips, rub in until coarse meal forms. Make well in center of flour mixture. Add buttermilk. Gradually stir dry ingredients into milk to blend. Mix in raisins.</li><li>Using floured hands, shape dough into ball. Transfer to prepared pan and flatten slightly (dough will not come to edges of pan). With a sharp knife, slice a shallow X across the top (optional). Sprinkle dough with remaining 1 tablespoon sugar.</li><li>Bake bread until brown and tester inserted into center comes out clean, about 40 minutes. Cool bread in pan 10 minutes. Transfer to rack. Serve warm or at room temperature.</li></ol>	irish	45	8	f	f	f	f
190	Irish Soda Bread	https://spoonacular.com/recipeImages/Irish-Soda-Bread-By-Mommie-Cooks-648006.jpg	<ol><li>To a bowl add together your dry ingredients; the flour, salt, and baking soda. Mix well.</li><li>Add in the caraway seed and combine.</li><li>Now add in the honey, egg, and buttermilk. Stir it up until a dough just begins to form.</li><li>Add in the melted butter and knead dough until all ingredients are combined. Don't overknead.</li><li>Form into a ball and cut a few 1" slits at the top.</li><li>Place dough on a baking sheet and place in an oven preheated to 350 degrees for 50 min. to an hour.</li><li>Test with a toothpick in the center to assure loaf is cooked completely.</li></ol>	irish	45	8	t	f	f	f
191	Irish Whiskey Pie	https://spoonacular.com/recipeImages/Irish-Whiskey-Pie-648010.png	<ol><li>For the crust:</li><li>Sift flour and salt together into a large bowl.</li><li>Using a food processor, a pastry blender or two knives and a good amount of patience, cut the butter into the flour.</li><li>Add water and vodka stirring after each addition until the dough comes together.</li><li>Form into a ball and cut it in half.</li><li>Flatten each half into a disc, wrap them in wax paper and refrigerate for at least half an hour before baking.</li><li>You will only need one half for this recipe, so feel free to freeze the other half for future pie emergencies.</li><li>When ready to bake, preheat oven to 375</li><li>Place pastry on a well-floured surface and using a well-floured rolling pin, roll out the pastry to fit a 9-inch pie plate.</li><li>Place pastry into the pie plate and trim and crimp the edges.</li><li>Prick the dough several times with a fork.</li><li>Wrap tin foil around the pastry and fill the center with pie weights or dried beans.</li><li>Place in the center of the oven and bake for 25 minutes.</li><li>Remove weights and tin foil and bake for an additional nine minutes or until golden brown.</li><li>Remove from the oven and let cool.</li><li>For the Filling:</li><li>In a medium sized bowl whisk together condensed milk, cornstarch and salt.</li><li>Add egg yolks one at a time, whisking until combined after each addition.  Set aside.</li><li>In a medium sized saucepan melt butter over moderate heat.</li><li>Add brown sugar and allow to bubble slightly.</li><li>Slowly whisk in milk.</li><li>Add egg mixture slowly, whisking constantly.</li><li>Bring back to a boil while whisking the mixture.</li><li>Once the mixture is boiling, let it cook while stirring for approximately one minute or until thick.</li><li>Remove from heat and stir in whiskey.</li><li>Pour into a cooled pie shell and cover with plastic wrap.</li><li>Place in the fridge and let set for four hours.</li><li>You may serve the pie with whipped cream if you wish, but I find it so rich that I like to eat it au naturale.</li></ol>	irish	45	10	t	f	f	f
192	Kale Colcannon	https://spoonacular.com/recipeImages/Kale-Colcannon-648718.jpg	<ol><li>Cook potatoes in a pot of boiling water until tender; drain, reserving water.</li><li>Place potatoes in a large bowl and mash potatoes with a hand masher or put through a ricer. Add 2 tablespoons butter, milk, salt and pepper to potatoes and gently mix until combined.</li><li>Add chopped kale to the reserved potato water. Cook 6-8 minutes or until tender. Drain well and chop.</li><li>Meanwhile, saut chopped onions in 2 tablespoons butter on medium-high until slightly brown. Add to potato mixture and combine.</li><li>Serve hot.</li></ol>	irish	45	4	f	f	t	f
193	Mussels in Irish Ale	https://spoonacular.com/recipeImages/Mussels-in-Irish-Ale-652760.jpg	<ol><li>Discard any mussels that are open before cooking and any that stay closed after cooking.</li><li>Place a large pot over a high heat and brown the pancetta pieces until just golden and sizzling. Add in a knob of butter, allow it to melt and then add the onion and garlic. Cook gently for three minutes until the onion is soft.</li><li>Add in the cider and allow to bubble away for a few minutes so all the flavours mingle in together. Tumble in the mussels, cover with a lid and allow them to steam for about four minutes until they open, making sure to give the pot a good shake once or twice during the cooking time.</li><li>Remove from the heat and stir in the cream and parsley and season with sea salt and ground black pepper.</li><li>Serve with some crusty bread to mop up the liquid!</li></ol>	irish	45	4	f	f	f	f
194	Oatmeal, Apricot, Walnut Soda Bread	https://spoonacular.com/recipeImages/Oatmeal--Apricot--Walnut-Soda-Bread-653500.jpg	<ol><li>In a medium bowl, combine 2 c. oats and buttermilk. Let sit for 1 hour.</li><li>Adjust oven rack to the upper-middle position and preheat to 400 degrees f. In a large bowl, combine flours, remaining 1/2 c. oats, brown sugar, baking soda, cream of tartar and salt. Add in the 2 T. softened butter and using your fingertips, rub the butter into the flour until the texture resembles coarse crumbs.</li><li>After the oats have soaked for an hour add the egg and mix well. Add this mix into the flour mixture along with the walnuts and apricots. Mix with a fork until it starts to come together (it still is going to be very loose). Turn the mix out onto a floured surface and knead a few times (around 12-14 times or so) to get everything to come together. Don't overdo it with the kneading or the bread will be tough.</li><li>Shape the dough into a round shape that is 6-inches in diameter and 2-inches high. Place on a large parchment-lined (or greased) baking sheet. Using a serrated knife, make a large X in the top of the loaf. Bake for 45- 50 minutes, until a skewer inserted in the center comes out clean. As soon as it is out of the oven, brush the crust with the melted butter. Let cool to room temperature before slicing.</li></ol>	irish	45	8	f	f	f	f
195	Raspberry Soda Bread	https://spoonacular.com/recipeImages/Raspberry-Soda-Bread--New-Take-On-An-Irish-Tradition-657898.jpg	<ol><li>Preheat oven to 325 degrees Grease two 8x4 inch loaf pans or muffins tins.</li><li>Mix the flour, sugar, baking soda, baking powder and salt. Add the eggs, sour cream and milk or half and half in necessary and mix until just combined. Gently fold in frozen raspberries. Distribute batter in the greased pans.</li><li>Allow the batter to sit for 20 min before baking.</li><li>Bake at 325 degrees for 1 hour. Muffins may take 10-15 min less.</li><li>Allow the bread rest and cool before serving.</li></ol>	irish	45	2	t	f	f	f
196	Rosemary Rum Raisin Soda Bread with Pecans	https://spoonacular.com/recipeImages/Rosemary-Rum-Raisin-Soda-Bread-with-Pecans-658803.jpg	<ol><li>Combine the rum and raisins in a small saucepan. Bring to a boil. Simmer for 30 seconds, then remove from heat. Cover and allow the raisins to macerate for at least 4 hours, but preferably overnight.</li><li>When youre ready to bake the bread, preheat the oven to 375F.</li><li>Coat a baking sheet with olive oil and lightly dust it with flour, or line it with parchment paper.</li><li>In a large mixing bowl whisk together the flours, baking soda, salt, and rosemary. Stir in the toasted pecans.</li><li>In a separate bowl combine the raisins with the rum, the yogurt, and honey.</li><li>Add the wet ingredients to the dry. Mix until the dough is too stiff to stir. Use your hands to bring it together in the bowl. Add additional yogurt one teaspoon at a time if its too dry. You want a stiff, slightly tacky ball.</li><li>Turn dough onto a lightly floured board and shape into a round loaf. (Dont over-knead the dough. Too much kneading will produce a tough bread.).</li><li>Transfer the loaf to the prepared baking sheet. Use a sharp knife to make deep slashes across the top of the loaf, 4-6 cuts about half way through. Brush the top with milk. Sprinkle with seeds or oats if using.</li><li>Bake for 40-45 minutes, until a toothpick comes out clean. When you tap the loaf, it will sound hollow.</li><li>Cool on a wire rack. Serve warm or at room temperature with a generous slather of butter.</li></ol>	irish	45	16	t	f	f	f
197	Slow Cooked Corned Beef and Cabbage	https://spoonacular.com/recipeImages/Slow-Cooked-Corned-Beef-and-Cabbage-660266.jpg	<ol><li>Stir the broth and vinegar into a 6-quart slow cooker. Add the onions, potatoes, carrots, beef and cabbage. Submerge the Bouquet Garni in the broth mixture.</li><li>Cover and cook on LOW for 8 to 9 hours or until the beef is fork-tender. Remove the Bouquet Garni.</li></ol>	irish	45	10	f	f	t	t
198	Vegan Colcannon Soup	https://spoonacular.com/recipeImages/Vegan-Colcannon-Soup-664419.jpg	<ol><li>Heat the oil in a large stockpot set over medium-high heat, until it shimmers. Add the leeks, garlic, and celery, and cook, stirring frequently, for 3 to 4 minutes, until the edges are golden. Add the parsnips, potatoes, cabbage, kale, stock, salt, and pepper and stir well. Reduce the heat to medium and cover.</li><li>Bring the soup to a boil; then reduce the heat to a low simmer. Cook for 30 to 35 minutes, until the vegetables are tender and soft. Add the lemon juice.</li><li>Using an immersion blender (or working in batches in a blender), pure until completely smooth. Serve immediately or store in an airtight container for up to 3 days.</li></ol>	irish	45	8	t	t	t	t
199	Xocai Irish Cream with Xocai Healthy Dark Chocolate Nuggets	https://spoonacular.com/recipeImages/Xocai-Irish-Cream-with-Xocai-Healthy-Dark-Chocolate-Nuggets-665480.jpg	<ol><li>Heat Irish cream syrup. Remove from heat and add Nuggets. Stir until melted. Cool. Mix 2 tbsp. of cream mixture with 2 tbsp. of whiskey and add to 1 cup of hot coffee. Repeat with second cup. Garnish with whipped cream and grated Nugget. Serves 2</li></ol>	irish	45	2	f	f	f	f
200	Asparagus Lemon Risotto	https://spoonacular.com/recipeImages/Asparagus-Lemon-Risotto-632935.jpg	<ol><li>In a large saucepan, combine broth and water. Bring to a simmer. Keep warm over low heat.</li><li>Heat oil in a large Dutch oven over medium heat. Add onion; saute 5 minutes or until tender. Add garlic; saute 30 seconds. Add rice; cook 2 minutes, stirring constantly. Stir in wine; cook 2 minutes or until liquid is nearly absorbed, stirring constantly. Mix in pepper. Add broth mixture, 1/2 cup at a time, stirring constantly, cook until each portion of broth is absorbed before adding the next (about 25 minutes). Add asparagus, and frozen peas,  during the last 10 minutes of cooking. Remove from heat; stir in cheese and remaining ingredients.</li><li>T(Cooking):"0:40"</li><li>NOTES :</li></ol>	italian	45	4	f	f	t	f
201	Crispy Italian Cauliflower Poppers Appetizer	https://spoonacular.com/recipeImages/Crispy-Italian-Cauliflower-Poppers-with-Marinara-640819.jpg	<ol><li>Preheat oven to 400 f. Brush a large baking sheet with a tablespoon of the olive oil. In a large, shallow dish combine the breadcrumbs, Parmesan, garlic powder, salt, pepper and 2 tablespoons of the olive oil. Toss well with a fork until the oil is completely dispersed into the bread crumbs. Combine the eggs with 1 tablespoon of water in a medium bowl. Place the flour in a large resealable bag.</li><li>Add half of the cauliflower florets to the bag with the flour, seal and shake to coat well. Remove the cauliflower to a fine mesh strainer and shake to remove excess flour. Place the floured cauliflower on a plate. Repeat with the remaining cauliflower.</li><li>Working with a few pieces at a time. Add to the beaten egg. Using a fork, turn and toss the florets in the egg to completely coat. Transfer to the breadcrumb mixture and coat, pressing the crumbs into the florets, the help them adhere. Place on the oiled baking sheet, making sure you leave a little space between each florets so they crisp up really well. Repeat this step with the rest of the cauliflower. Spray the tops of the breaded florets lightly with cooking spray. Bake the cauliflower for 20 minutes, Flip the pieces over and continue baking for about 15 more minutes, until the cauliflower is crunchy on the outside and tender on the inside.</li><li>While the cauliflower is baking, prepare the marinara. Pulse the undrained tomatoes in a food processor a few times until mostly broken down. Heat 1 tablespoon of the oil with the garlic and pepper flakes in a medium saucepan over medium heat until just sizzling. Add the tomatoes and simmer for about 10 minutes until the marinara thickens slightly and the flavors develop. Add 2 tablespoons of the fresh basil, season with salt and pepper if needed.</li><li>When the cauliflower is done baking, transfer to a serving dish and sprinkle with the remaining basil. Serve with the marinara.</li></ol>	italian	45	4	f	f	f	f
202	Easy Cheesy Pizza Casserole	https://spoonacular.com/recipeImages/Easy-Cheesy-Pizza-Casserole-641893.jpg	<ol><li>Brown ground beef in skillet; drain fat.  Mix in pasta or pizza sauce and pepper flakes; set aside.  Mix ricotta cheese with the herbs and Parmesan in a separate bowl; set aside.</li><li>Mix the dry ingredients for the biscuits.  Add milk and stir until combined.</li><li>Preheat oven to 375 degrees.  Spray a 13 x 9 pan with non-stick spray.  Drop biscuit dough by teaspoons in the bottom of pan, spacing evenly.  It's OK if there is space between the dough--it will expand as it's cooked.  Top with ground beef mixture and dot with the ricotta cheese mixture.  Bake at 375 for about 20 min or until biscuits are puffed and beginning to get golden brown.</li><li>Top with mozzarella and provolone cheeses and distribute pepperoni slices evenly over top, increase oven temperature to 425 degrees.  Return to oven and bake until cheeses are melted and beginning to bubble.  This should take about 10 minutes.</li><li>Remove from oven and let stand 5 minutes before slicing and serving.  May be topped with the additional Parmesan cheese.</li></ol>	italian	45	6	f	f	f	f
203	Easy Skillet Garden Lasagna	https://spoonacular.com/recipeImages/Easy-Skillet-Garden-Lasagna-642095.jpg	<ol><li>Preheat oven to 425 F.</li><li>Boil water for pasta and cook pasta according to directions, shaving a few minutes off the time.</li><li>Meanwhile water is boiling or pasta is cooking, heat a large oven-safe skillet over medium heat and add olive oil.</li><li>Add in your veggies and garlic, tossing to coat for about 10 minutes or until softened. If using spinach, add it last towards the end since it cooks really fast. Season with salt and pepper.</li><li>Add sauce, mozzarella and cooked lasagna noodles to the skillet with the veggies, gently tossing to distribute.</li><li>Cover with scoops of ricotta and sprinkle with fresh basil if you'd like.</li><li>Bake for 15-20 minutes, or until cheese is golden and bubbly. Serve with extra parmesan if you are a cheese lover like me!</li></ol>	italian	45	4	f	f	f	f
204	Hearty Minestrone Soup	https://spoonacular.com/recipeImages/Hearty-Minestrone-Soup-646577.jpg	<ol><li>Start by simmering your chicken stock on the stove. While it is simmering dice your onions, slice your carrots, crush your garlic, and add them to the pot. Then add the half can of tomato sauce and let the mixture cook on low to medium heat. Next add your diced tomatoes, potatoes, spinach, and beans. Keep the mixture on medium heat until your potatoes start to soften. Then you can turn the heat low and let it cook for as long as you would like. I seasoned the soup with Kosher salt, fresh cracked pepper, red pepper flakes,</li><li>A touch of paprika and a touch of Madras curry powder. You can season with whatever you would like to cater to your taste. When you are ready to eat the soup turn the heat back up and bring it to a low boil adding the pasta. You can turn it back down to low when the pasta is starting to get to al dente status. Then continue to cook on low until the pasta is cooked to your liking. We topped our individual bowls of the minestrone with a little shredded parmesan cheese! Hope you enjoy!</li></ol>	italian	45	1	f	f	f	t
205	Insalata Caprese With Pesto Vinaigrette	https://spoonacular.com/recipeImages/Insalata-Caprese-With-Pesto-Vinaigrette-647922.jpg	<ol><li>On a serving plate alternate slices of mozzarella and tomatoes.</li><li>Sprinkle with half of basil.</li><li>In a blender or food processor blend basil and all remaining ingredients together until smooth.</li><li>Drizzle over salad.</li></ol>	italian	45	1	f	f	t	f
206	Italian Sausage and Vegetable Soup	https://spoonacular.com/recipeImages/Italian-Sausage-and-Vegetable-Soup-648238.jpg	<ol><li>Heat oil in large pot over medium heat and add sausages, without the casings.</li><li>Mix sausage until it is broken up into small pieces and cook until sausages is browned and almost cooked through.</li><li>Add carrots, onions, bay leaf, Italian seasoning, red pepper flakes and salt and pepper. Cook 5-6 minutes longer, until onions start to soften.</li><li>Add chicken stock and diced tomatoes. Bring stock up to a simmer. Once the stock is at a simmer, reduce heat to low and simmer with the top on until vegetables are tender, about 10 minutes longer.</li><li>Turn the heat off and add cannellini beans and spinach and stir in until spinach wilts.</li></ol>	italian	45	6	t	t	t	t
207	Italian Seafood Stew	https://spoonacular.com/recipeImages/Italian-Seafood-Stew-648247.jpg	<ol><li>Prepare ingredients.</li><li>In a large pot, heat up 3 tbsp of olive oil and add garlic and onion. Sautee over medium heat.</li><li>Add salt, tomato paste, tomatoes with juice, stock, club soda, bay leaves and stir.</li><li>Simmer over medium low heat for 30 min.</li><li>Add mushrooms.</li><li>Add salt to taste.</li><li>Cook mussels according to package directions.</li><li>Add shrimp and fish into stew.</li><li>Add mussels.</li><li>Simmer for a few minutes.</li><li>Ready to serve with some baked bread.</li></ol>	italian	45	3	f	f	t	t
208	Italian Steamed Artichokes	https://spoonacular.com/recipeImages/Italian-Steamed-Artichokes-648257.jpg	<ol><li>Snip the thorns off the artichoke leaves. Place the garlic slices inside the leaves throughout the artichoke. Put the artichoke into a medium-size saucepan. Add water to come halfway up the artichoke.</li><li>Put the bay leaf in the water.</li><li>Crush the coriander seeds, oregano and basil together; sprinkle on top of the artichoke.</li><li>Cook over medium heat for 30 minutes, or until the leaves pull off easily.</li></ol>	italian	35	1	t	t	t	t
209	Italian Tuna Pasta	https://spoonacular.com/recipeImages/Italian-Tuna-Pasta-648279.jpg	<ol><li>Once pasta is cooked, drain and leave to cool for a minute.</li><li>Place small skillet on medium fire, drizzle olive oil, add in red pepper and stir-fry for 1-2 minutes. Put aside.</li><li>Toss pasta shells, red pepper, tuna, parsley, garlic, chilies and lemon juice. Season with ground black pepper to taste, spoon into serving bowls. Stir through ricotta and serve immediately.</li></ol>	italian	20	3	f	f	f	t
210	Pappa Al Pomodoro	https://spoonacular.com/recipeImages/Pappa-Al-Pomodoro-654614.jpg	<ol><li>Warm the olive oil and garlic in a medium cooking pot. When the garlic has coloured slightly, add the leeks. Saute over a low heat for 20 minutes, adding water as necessary to keep the vegetables from turning brown.</li><li>Stir in the stock and pured tomatoes and bring to the boil, then reduce the heat and simmer gently for 20 minutes.</li><li>Turn off the heat and add the bread, pushing it into the liquid with a wooden spoon.</li><li>Stir in the torn basil leaves and season to taste with salt and pepper. Leave to rest for 30 minutes.</li><li>Now whisk the soup energetically until it has a porridge-like consistency. Taste and adjust the seasoning.</li><li>Ladle into bowls, drizzle with extra-virgin olive oil and serve.</li></ol>	italian	45	4	f	f	f	t
211	Roasted Brussels Sprouts With Garlic	https://spoonacular.com/recipeImages/Roasted-Brussels-Sprouts-With-Garlic-658515.jpg	<ol><li>Heat oven to 450 degrees. Trim bottom of Brussels sprouts and remove any undesirable outer leaves. Slice each sprout in half from top to bottom.</li><li>Heat oil in a large heavy skillet over medium-high heat; put sprouts cut side down in one layer in pan. Add garlic, and sprinkle with salt and pepper.</li><li>Cook, undisturbed, until sprouts begin to brown on bottom, and transfer to oven. Cook, shaking pan occasionally, until sprouts are quite brown and tender, about 1/2 hour.</li><li>Taste, and adjust seasoning if necessary. Stir in balsamic vinegar, and serve hot or warm.</li></ol>	italian	45	4	t	t	t	t
212	Salmon Quinoa Risotto	https://spoonacular.com/recipeImages/Salmon-Quinoa-Risotto-659109.jpg	<ol><li>In a 4 quart saucepan, heat 2 tablespoons of olive oil over medium high heat.</li><li>When oil is shimmering, add diced onion.</li><li>Saute onion until transparent.  Add quinoa to onion mixture and stir, to toast quinoa, for 2 minutes.</li><li>Add 1 cup of vegetable stock to quinoa and onions.</li><li>Stir until stock is absorbed.  Once stock is absorbed, add 1 cup of stock.</li><li>Continue stirring until stock is absorbed.</li><li>Add remaining stock in 1/2 cup intervals, stirring until all stock is absorbed.</li><li>Remove from heat.</li><li>While preparing the onion quinoa mixture, heat 1 tablespoon of oil in a saute pan with chopped garlic (over medium high heat).</li><li>Once garlic is sizzling, add chopped kale to the pan.</li><li>Turn kale to coat with oil and garlic.</li><li>Turn kale mixture until fragrant (approximately 2 minutes).  Remove kale mixture from heat.</li><li>Once quinoa is complete, add kale and salmon.</li><li>Stir to combine.</li><li>Add salt and pepper to taste.</li></ol>	italian	45	4	f	f	t	t
213	Vegetable Minestrone Soup	https://spoonacular.com/recipeImages/Vegetable-Minestrone-Soup-664565.jpg	<ol><li>In a deep sauce pan or pot, heat about 2 tsps of oil or butter. Add bay leaf. When the bay leaf begins to splutter, add finely chopped onions and saute for a couple of mins until the onions are translucent.</li><li>In the meanwhile, boil water with a pinch of salt in another pot. Add pasta and cook for about 6 to 7 mins. When done, drain all the water and set the pasta aside.</li><li>Add the chopped zucchini and chopped carrots to the sauteed onions. Now, add salt and ground pepper and saute for a couple of mins. Empty the diced tomato cans into the sauce pan now. Add the remaining spices  red chili powder and dried basil to the tomatoes. Cover and let cook for at least 5 mins.</li><li>Empty the cannellini beans into a bowl. Rinse under running water to drain out all the canned liquid and add the beans to the sauce pan. Also, add the cooked pasta now. Add about 2 cups of water, cover and let cook for about 15 mins. Give a taste test and adjust salt if needed.</li><li>Serve with a hint of grated Parmesan cheese as garnish and some bread to dip into it!</li></ol>	italian	30	4	f	f	f	f
214	Veggie Lasagna Rolls with Peppery Pecorino Marinara	https://spoonacular.com/recipeImages/Veggie-Lasagna-Rolls-W--Peppery-Pecorino-Marinara-664737.jpg	<ol><li>PREHEAT THE OVEN TO 425*</li><li>COOK THE LASAGNA NOODLES PER PACKAGE</li><li>INSTRUCTIONS. RINSE W/ COOL WATER, DRAIN &amp;</li><li>SET ASIDE.</li><li>COMBINE ALL THE INGREDIENTS FOR THE RICOTTA  FILLING &amp; SET ASIDE.</li><li>BEGIN THE SAUCE. PLACE THE GARLIC &amp; OLIVE OIL IN  A SAUTE PAN, COOK UNTIL THE GARLIC JUST STARTS TO BROWN. ADD THE CANNED TOMATOES ALL AT ONCE AND COOK FOR 1-2 MINUTES. THE TOMATO JUICE WILL START TO CARAMELIZE. CRUSH THE WHOLE TOMATOES WITH THE BACK OF A SPOON. ADD THE DRIED BASIL, OREGANO AND SAGE AND COOK DOWN AT MEDIUM HAT FOR ABOUT 20 MINUTES, UNTIL THE SAUCE IS THICK. ADD THE CHEESE AND COOK FOR ANOTHER MINUTES, STIRRING THE CHEESE INTO THE SAUCE.</li><li>LAY THE LASAGNA NOODLES OUT ON A CUTTING BOARD AND SPREAD WITH THE RICOTTA FILLING. DIVIDE THE SPINACH EQUALLY ON THE NOODLES AND THEN TOP WITH THE BASIL LEAVES.</li><li>SPRINKLE THE MUSHROOMS AND ZUCCHINI ON TOP AND ROLL THE NOODLES MAKING A ROLLED NOODLE.</li><li>PLACE A SMALL SPOONFUL OF MARINARA IN A DISH, PLACE THE LASAGNA ROLLS ON TOP OF THE SAUCE. BAKE ABOUT 15 MINUTES UNTIL THE ROLLS ARE HOT AND THE SPINACH IS JUST WILTED.</li><li>TOP WITH THE MARINARA AND SOME SHAVED PECORINO. SERVE HOT.</li></ol>	italian	45	6	f	f	f	f
215	Japanese Vegetable Stew	https://spoonacular.com/recipeImages/japanese_vegetable_stew-17913.jpg	None	japanese	45	1	t	t	t	t
216	Japanese Salad Dressing	https://spoonacular.com/recipeImages/japanese_salad_dressing-37513.jpg	None	japanese	12	1	t	t	t	t
217	Baked Teriyaki Chicken Drumsticks	https://spoonacular.com/recipeImages/Baked-Teriyaki-Chicken-Drumsticks-633841.jpg	<ol><li>In a large bowl, mix teriyaki sauce, salt vegetable oil, honey, and ginger.  Add the chicken to the marinade.  Let the chicken marinade for about 4-5 hours.</li><li>Preheat oven to 450 degrees.  Add the sliced onions and diced garlic on the baking pan.  Lay the chicken on top of the onions and garlic.  Bake the chicken for 30 minutes turning once until cooked.</li></ol>	japanese	45	1	f	f	t	t
218	Beef Teriyaki Stir Fry	https://spoonacular.com/recipeImages/Beef-Teriyaki-Stir-Fry-634710.jpg	<ol><li>Whisk ingredients together in a small bowl and refrigerate for at least 30 minutes.</li><li>Heat oil in a large frying pan over medium heat. Add beef and saut for 3-4 minutes just to brown it on all sides.</li><li>Remove from pan and set aside.</li><li>Add vegetables and saut for 5 minutes more, until beginning to soften.</li><li>Stir in teriyaki sauce and allow mixture to come to a simmer.</li><li>Add beef and any drippings that have accumulated on the plate. Cook for 5 minutes, stirring occasionally.</li><li>In a small bowl, combine cornstarch with 2 tsp cold water to dissolve. Stir into the pan of beef and vegetables. Allow the mixture to simmer and thicken for 2 minutes. Toss to evenly coat vegetables and beef in teriyaki sauce. Serve.</li></ol>	japanese	45	2	f	f	t	t
219	Chicken Teriyaki with Soba Noodles	https://spoonacular.com/recipeImages/Chicken-Teriyaki-with-Soba-Noodles-638382.jpg	<ol><li>1. Preheat oven to 400 degrees Fahrenheit. Slice shiitakes into bite sized pieces. Place chicken breasts in a 9 by 13 glass dish.</li><li>2. Make sauce: In a small bowel, add all the ingredients and whisk together.</li><li>3. Pour sauce over chicken breasts. Place in oven and cook for 20 min. Take out of oven and add shiitakes. Toss shiitakes with the sauce that is around the chicken, flip chicken. Place in oven for 10 minutes more.  Once done,take out of oven.Let rest 5 minutes before slicing chicken into bite sized pieces.</li><li>4. Meanwhile, add water to a medium pot. Once brought to a boil, add soba noodles and cook for 7 minutes till done. Drain and rinse under cold water and add back to pot. Add shitakes and all of sauce to the soba noodles. Toss together.</li><li>5. Add 1/2 the soba noodles and shitakes to each plate. Add 1 sliced chicken breast to each plate. Garnish with green onion and sesame seeds. Serve immediately.</li><li>ENJOY!</li></ol>	japanese	45	2	f	f	f	t
220	Hokkaido Pomegranate Risotto	https://spoonacular.com/recipeImages/Hokkaido-Pomegranate-Risotto-646817.jpg	<ol><li>Method</li><li>Cut the top of the hokkaido squash horizontally, scoop out the seeds and then scrape off the flesh from the squash. (I got 1 cup of flesh from a small hokkaido)</li><li>Heat oil in a pan, add the garlic, onions and the rice and saute for  a couple of minutes, stirring continously, on high flame.</li><li>Add salt, pepper and the finely chopped hokkaido squash and mix well.</li><li>Reduce the heat to low and keep adding water little by little, as it is absorbed.</li><li>When the rice is cooked, add the chives, the parmesan and the pomegranate seeds, and mix well.</li><li>Spoon the risotto into the hokkaido shell and garnish it with pomegranate seeds, chives and parmesan crisps and serve hot.</li></ol>	japanese	45	2	f	f	t	f
221	Japanese Chicken Donburi	https://spoonacular.com/recipeImages/Japanese-Chicken-Donburi-648460.jpg	<ol><li>In a deep 10-inch or 12-inch frying pan over high heat, stir oil, onion, and ginger until onion is lightly browned, about 2 minutes.</li><li>Add broth, soy sauce, and sugar. Add chicken to pan. Bring to a boil.</li><li>Add spinach, cover, and cook until wilted, about 1 minute. Meanwhile, in a small bowl, beat eggs to blend.</li><li>Reduce heat to low, evenly distribute mixture in pan, and pour in eggs. With a spatula, push vegetables aside slightly so egg mixture can flow down through sauce. Cover and cook just until eggs are softly set, 2 to 2 1/2 minutes.</li><li>Meanwhile, spoon rice into bowls. Top equally with egg-spinach mixture, including juices. Sprinkle with tomato.</li></ol>	japanese	45	4	f	f	t	t
222	Japanese Clear Soup	https://spoonacular.com/recipeImages/Japanese-Clear-Soup-648462.jpg	<ol><li>1. In a large saucepan bring chicken stock to a boil. Stir in sherry and soy sauce. Reduce heat and simmer several minutes.</li><li>2. Arrange your choice of garnishes in small bowls to pass at the table.</li><li>Ladle broth into soup bowls and serve. </li><li>Microwave Version: 1. Place chicken stock in a deep 2-quart casserole. Microwave, uncovered, on 100%% power until stock boils, about 5 to 7 minutes.</li><li>2. Stir in sherry and soy sauce. Microwave on 30%% power 2 minutes.</li><li>3. Continue with step 2.</li></ol>	japanese	45	4	t	t	t	t
223	Japanese Coleslaw	https://spoonacular.com/recipeImages/Japanese-Coleslaw-648465.jpg	<ol><li>Brown almonds and sesame seeds in 1 tbsp. butter. Mix cabbage and onions. Just before serving, add almonds, seeds and crushed noodles to cabbage and mix with dressing.</li></ol>	japanese	45	1	f	f	f	t
224	Japanese Curry Puffs	https://spoonacular.com/recipeImages/Japanese-Curry-Puffs-648470.jpg	<ol><li>Preheat oven to 350 degrees.</li><li>In a pot over medium/high heat, add oil and onions. Cook for 2 minutes. Add potatoes and carrots, cook for 5 minutes. Add water and bring to the boil. Lower heat and simmer for 15 minutes. Add curry mix and cook for another 10 minutes.</li><li>On a sheet pan, cut puff pastry into squares (1 sheet should give you 4 squares) and with a spoon, fill the middle of 1/2 of the squares you have.</li><li>Bake for 20 minutes or until the crust is a golden brown and serve!</li></ol>	japanese	45	4	t	t	f	t
225	Japanese Fried Rice	https://spoonacular.com/recipeImages/Japanese-Fried-Rice-648474.jpg	<ol><li>In a pan over medium heat, add oil, garlic and cook for a minute. Add chopped carrots and cook for 2 minutes. Add chicken and cook for 2-3 minutes, until the chicken is cooked through.</li><li>Add rice and peas and mix well. Add soy sauce, tonkatsu sauce, black pepper and salt, and mix well. Push the rice to one side and break the eggs on the clear side. Slowly scramble the eggs and incorporate with the rice. Serve!</li></ol>	japanese	45	2	f	f	t	t
226	Japanese Noodle Soup	https://spoonacular.com/recipeImages/Japanese-Noodle-Soup-648481.jpg	<ol><li>In a saucepan bring the water to a boil with the kombu</li><li>Simmer the kombu for only 2 minutes, then discard.</li><li>Stir in the bonito flakes or Hon Dashi</li><li>Simmer, stirring for 3 minutes</li><li>Stir in the soy sauce, the mirin, and the sugar</li><li>Simmer the broth for 5 minutes</li><li>In a pot of water, cook the noodles till done, drain.</li><li>Add carrots and ginger to broth and simmer, covered, for 5 minutes</li><li>Stir in the spinach, noodles and tofu and simmer 1 minute</li><li>In small bowl, stir together 1/2 cup broth and miso</li><li>Pour miso back into pan of broth.</li><li>Ladle soup into bowls and sprinkle scallions on top.</li></ol>	japanese	45	1	t	t	f	t
227	Japanese Mushroom Noodle Soup	https://spoonacular.com/recipeImages/Japanese-Mushroom-Noodle-Soup-648483.jpg	<ol><li>Break noodles in half; cook according to package directions. Meanwhile, in large saucepan, heat chile oil over medium heat. Add mushrooms, garlic and ginger; cook 5 minutes, stirring occasionally. Add broth, mirin and soy sauce; bring to a boil. Simmer, uncovered, 10 minutes, stirring once.</li><li>Drain noodles, stir into soup. Stir in green onions and sesame oil. Ladle into shallow soup bowls.</li></ol>	japanese	45	4	f	f	f	t
228	Japanese Salmon With Sesame Seeds	https://spoonacular.com/recipeImages/Japanese-Salmon-With-Sesame-Seeds-648493.jpg	<ol><li>Place salmon in marinade made by mixing soy sauce, hot pepper, honey, vinegar, and 1 tbsp. sesame oil and allow to marinate for 2 hours. Lift fish from marinade, and dry well on paper towels.</li><li>Heat remaining sesame oil in skillet. Add salmon scallops and saute quickly, turning once, about 2 minutes on each side. Sprinkle with sesame seeds and scallions.</li></ol>	japanese	45	4	f	f	t	t
229	Japanese Steak Salad	https://spoonacular.com/recipeImages/Japanese-Steak-Salad-648500.jpg	<ol><li>Prepare Sesame Marinade and Dressing. Place beef top sirloin steak in plastic bag; add reserved marinade, turning to coat. Close bag securely and marinate in refrigerator 2 hours, turning once. Remove from marinade; place on rack in broiler pan so surface of meat is 3 to 4 inches from heat. Broil 14 to 16 minutes to doneness desired (rare to medium-rare), turning once. Let stand 5 minutes. Carve steak into thin slices.</li><li>Meanwhile, combine napa cabbage, romaine, carrots and radishes; place an equal amount of each on 4 individual plates. Arrange an equal number of cucumber slices in circle at top of salad greens on each plate. Mound 1/4 cup rice on each cucumber circle. Fan pea pods around both sides of rice. Arrange steak slices as spokes on salad greens, radiating down from rice. Serve dressing with salad. Makes 4 servings.</li><li>Combine dry sherry, soy sauce, vinegar, hoisin sauce and ginger; mix well. Divide mixture in half; reserve half for steak marinade. To prepare dressing, combine remaining mixture with water, green onion, sugar and oil; mix well. Yield: 1/3 cup marinade; 3/4 cup dressing.</li></ol>	japanese	45	8	f	f	t	t
230	Japanese Souffle Cheesecake	https://spoonacular.com/recipeImages/Japanese-Souffle-Cheesecake-648501.jpg	<ol><li> Add 500 ml water into a big baking tray ( that the tin you use for the cheesecake can fit in) and place the tray in the oven then preheat the oven to 160c.Line the base and side of a 18-20 cm springform/cake tin with parchment paper. Then use a big piece of foil to wrap the tin around from the bottom upto top of the tin side.</li><li>Place the butter, creamcheese and milk in a bowl set over a saucepan of barely simmering water, being careful not to let the bowl touch the water, then wait until the butter has melted, remove the bowl from the heat and give it a really good stir until the mixture is smooth, set aside and leave to cool at the room temperature.</li><li>Add the orange juice and zest to the creamcheese mixture, stir to blend then add the yolks and mix them until incorperated. Sift the flour and salt into another mixing bowl,pour over the cream cheese and egg mixture in the center of thr flour. Quickly whisk or stir everything until just blended ( don't overmix or the cake will be tough) </li><li>In a seperate mixing bowl , beat the egg white with cream of tartar until foamy, then gradually add the sugar ,few tablespoons at a time, and continue to beat at high speed until reach the soft-medium peak ( more than soft but not hard peak). Gently fold the white into the creamcheese mixture until blended.</li><li>Pour the batter into the prepared tin. Place the tin in the preheated baking tray and bake for 50-60 minutes or until  a toothpick inserted from center comes out clean. Turn the cake out on to a wire rack once taken from the oven ( the cake will shrink if left too long in the tin!). Leave to cool at room temperature, then let it set in the fridge for another hour or so before slicing and serve.</li></ol>	japanese	45	1	f	f	f	f
231	Japanese Style Curry	https://spoonacular.com/recipeImages/Japanese-Style-Curry-648504.jpg	<ol><li>Whisk the curry powder into 1 cup cold water in a small bowl and set aside.</li><li>Heat the oil in a large pot over medium-high heat. Add the onions and salt and saute, stirring occasionally, until the onions are translucent, about 8 minutes.</li><li>Add the mushrooms and saute until they begin to soften, about 2 minutes. Stir in the potatoes and saute for 1 minute more. Add 4 cups cold water and the curry mixture and bring to a boil. Reduce the heat to low, cover and simmer, stirring occasionally, until the potatoes can easily be pierced with a fork, about 20 minutes.</li><li>Whisk the cornstarch or potato starch with the tamari and 2 tablespoons cold water in a small bowl. Add to the curry and stir gently until the sauce thickens.</li><li>Gently stir in the tofu, if using, and the peas and cook until heated through, 5 to 10 minutes. Taste and adjust the seasonings with additional curry powder, salt and-or tamari, if desired. If you like, serve with small bowls of raisins and walnuts on the side.</li></ol>	japanese	45	1	f	f	t	t
232	Japanese Sushi	https://spoonacular.com/recipeImages/Japanese-Sushi-648506.jpg	<ol><li>Recipe one: Pour cooked rice into a tray. Finely slice the salmon and the tuna.</li><li>Put the seaweed onto a sushi mat and press rice down onto it.</li><li>Slice the mushrooms and asparagus pieces and lay along the rice. Add the wasabi. Roll the sushi and cut into slices. Serve with salmon caviar, wasabi and soy.</li><li>Recipe two: Squeeze the rice into balls and press the prawns, tuna or salmon into the top.</li></ol>	japanese	45	1	f	f	t	t
233	Kyuri Tsukemono	https://spoonacular.com/recipeImages/Kyuri-Tsukemono-649137.jpg	<ol><li>Rough chop cucumbers.</li><li>In a medium, securely sealable container, combine soy sauce, rice vinegar, and sesame oil.</li><li>Add cucumbers to the marinade, close container and shake.</li><li>Refrigerate for 1 to 2 hours. Shake cucumbers periodically, or leave overnight to marinate. Note, the longer the cucumbers are left in the marinade the saltier they become. I've left them in the marinade for up to 3 days and the cucumbers were good.</li><li>Serve and enjoy!</li></ol>	japanese	45	4	t	t	t	t
234	Miso Soup With Thin Noodles	https://spoonacular.com/recipeImages/Miso-Soup-With-Thin-Noodles-652078.jpg	<ol><li>Directions:</li><li>After the miso has been prepared, start adding the "stuff" to the soup pot. It can be your preference, but I opted to start with the onions and chives and then added the zucchini, parsnip, carrots, mushrooms and ginger. Cover the pot and let cook on a low flame for 20-30 minutes, tasting as you go. Add the tofu and pasta, allowing the pasta to cook for 8-10 minutes. Taste the soup, adding red pepper and turn off flame when ready. Place spinach on the bottom of your soup bowl. You can also place the spinach directly in the pot, but since it wilts so quickly I usually do it this way.</li><li>What do you usually add to your Miso Soup?</li><li>Seriously Soupy Serena</li></ol>	japanese	45	8	t	t	f	t
235	Oriental Filet Mignon on Crisp Kataifi with Shrimp Tempura	https://spoonacular.com/recipeImages/Oriental-Filet-Mignon-on-Crisp-Kataifi-with-Shrimp-Tempura-654072.jpg	<ol><li>Combine the first three ingredients in a shallow dish and add the filet mignon steaks. Spoon the marinade over them until they are well covered, set aside for about 30 minutes, covered with plastic wrap.</li><li>Heat oven to 400o.</li><li>Line a baking sheet with parchment, and divide the kataifi into two neat rounds. Drizzle lightly with a neutral oil, and bake until golden and crisp. Remove from oven and set aside.</li><li>Meanwhile, place the corn starch, whisked egg whites and panko in separate bowls.</li><li>Roll each shrimp first in the corn starch, then in the egg whites and the in the panko. Pat them firmly with your palms to make sure the panko sticks well. Set aside on paper towels on a plate or tray. Repeat with the rest of the shrimp.</li><li>Fill a large deep skillet with oil (such as Safflower or Canola), enough to cover the shrimp when frying.</li><li>Turn BBQ to high. Meanwhile, heat oil in frying pan until very hot, and fry the shrimp, turning once or twice, for about 2 minutes until golden. Place back on paper towels and set aside in a lightly warmed oven.</li><li>When BBQ is very hot, remove steaks from marinade and grill on high for about 3-4 minutes on each side. While the steaks are grilling, add the rice vinegar, garlic, pepper flakes and ginger to the remaining marinade, and warm it up in a small saucepan until boiling, then set aside.</li><li>To serve: On each dinner plate place one mound of kataifi, topped by sliced filet mignon, drizzle with 2 spoonfuls of marinade and top with 2 fried shrimp. Serve with your favorite steamed vegetable(s) or stir fry.</li></ol>	japanese	45	2	f	f	f	t
236	Soba Noodle In Kombu Dashi With Teriyaki Salmon	https://spoonacular.com/recipeImages/Soba-Noodle-In-Kombu-Dashi-With-Teriyaki-Salmon-660493.jpg	<ol><li>To make kombu dashi, soak the dried kelp/seaweed in water for 2 hours. Put the kombu and water in a cooking pot. Put on medium heat. Turn off the heat when the water comes to a boil. Then, remove the kombu with a strainer. The remaining liquid is your kombu dashi. You can leave some kombu in the soup.</li><li>Cook the soba noodles according to the packet. Drain and set aside.</li><li>To make teriyaki salmon, marinate salmon filet/loin with sake, soya sauce, mirin, and sugar.</li><li>Heat up a pan with oil. Put the skin side down and cook for 3 minutes or until crispy. Turn and cook the other side for another 2-3 minutes. Pour any remaining sauce.</li><li>Remove from heat. Drizzle any remaining sauce from the frying pan.</li><li>To serve the soba, heat up the broth. In a bowl, serve good portion of Soba noodles. Lardle good amount of kombu dashi over the noodles. Garnish with goji berries if desired. Place the teriyaki salmon on top of the noodles. Sprinkle with some toasted sesame seeds.</li></ol>	japanese	45	2	f	f	f	t
237	Classic Matzo Ball Soup	https://spoonacular.com/recipeImages/Classic-Matzo-Ball-Soup-639616.jpg	<ol><li>Wash the chicken with cold water and place in pot. Cover with water and bring to a simmer (do not boil or your broth won't be clear).</li><li>Skim off bubbling foam as it forms. Add celery, carrots, onion, herbs, salt and pepper and continue to simmer for about 45 minutes.</li><li>Pour soup through strainer and let cool. When broth has completely cooled, remove the chicken meat and skim off the fat and save for the matzo balls.</li><li>In a mixing bowl, mix together 4 eggs and 4 tablespoons chicken fat (or vegetable oil). Stir in the matzo meal and salt. Add 1/4 selter water. Cover and refrigerate for at least 1 hour.</li><li>Form the matzo dough into teaspoon-size balls.</li><li>Bring the chicken broth to a boil. Add the matzo balls, cover, and cook for 20 minutes.</li><li>Serve immediately.</li><li>Garnish with fresh dill or parsley.</li></ol>	jewish	45	6	f	f	t	t
238	Jewish Mandlebrot	https://spoonacular.com/recipeImages/Jewish-Mandlebrot-648587.jpg	<ol><li>1. In medium bowl, combine eggs and 1 cup each sugar and salad oil. Beat until well combined.</li><li>2. Sift flour with baking powder into very large bowl.</li><li>3. Make a well in the center; pour in egg mixture. Stir around the bowl using a wooden spoon, until well blended.</li><li>4. Turn dough out onto lightly floured pastry cloth. With flour knead until smooth, about 5 minutes.</li><li>5. Preheat oven to 350 degrees. Grease lightly roasting pans or cookie sheets. In small bowl mix together filling (nuts, sugar, cinnamon and raisins).</li><li>6. Divide dough into 5 equal parts.</li><li>7. Roll each into 10x12 rectangle. Roll out on oiled surface.</li><li>8. Brush lightly with tsp. oil. Spread 5 tbsp. preserves; sprinkle 1/2 cup mixture evenly around. From long side, roll as for jelly roll; pinch each end.</li><li>9. Place 5 loaves in pans 1/2 inch apart. Put seam side up. Bake 45-50 minutes or until golden brown.</li><li>10. Remove to wire rack; cool 10 minutes before removing from pan. Cool completely. Cut into 12 diagonal slices. If desired, sprinkle with confectioners' sugar..</li><li>11. Store covered in cool, dry place. Mellows with age.</li></ol>	jewish	45	12	t	f	f	f
239	Jojo's Potato Pancakes	https://spoonacular.com/recipeImages/Jojos-Potato-Pancakes-648608.jpg	<ol><li>As you grate your potatoes have a large bowl of ice water ready to put then in so that they do not brown.</li><li>Add all other ingredients to another bowl without mixing.  Drain potatoes well and then place on either a thin towel or cheese cloth and squeeze as much of the liquid out as possible, then add to the rest of the ingredients and mix.  Use your hands to bring mixture together and make into small flat pancakes.  If the mixture is too wet and will not form then add a bit more flour.     Add 1 or 2 tablespoons of olive oil to a very hot frying pan and fry one side of the pancake until crispy and brown.  Flip and cook the other side.   Serve these hot with apple sauce or sour cream.</li></ol>	jewish	45	16	t	f	t	t
240	Latkes	https://spoonacular.com/recipeImages/Latkes--Fried-Vegetable-Pancakes-from-Europe-and-the-Middle-East-649300.jpg	<ol><li>1. Skin the vegetables and in a standard food processor, grate them into a suitable bowl.</li><li>2. Take a handful of the grated vegetables and squeeze as much moisture from it as possible. Then place on a paper towel. Continue until you have squeezed out as much of the moisture as you can.</li><li>3. Clean and dry the original bowl and repeat the process of squeezing the vegetables dry but putting them in the bowl when finished. Then stir them to mix thoroughly.</li><li>4. In a separate bowl, beat the egg with the flour to form a sticky glue that will hold the latkes together.</li><li>5. Mix the sticky egg and flour with the vegetable mixture and form into flat pancakes about 3 to 4 inches in diameter then place on a cutting board.</li><li>6. Heat about 1/8 inch of peanut oil in a 10 inch cast iron skillet over medium high heat until a drop of water sizzles upon contact.</li><li>7. Place three of the pancakes into the skillet, press down with a spatula to thin them and cook until the edges start to turn deep brown. Flip them over carefully and cook for 2 to 3 minutes more.</li><li>8. Remove from pan and place on paper towels to drain excess oil.</li><li>9. Repeat until all are cooked and drained then place in a 175-200*F warming oven until ready to be served.</li></ol>	jewish	45	2	t	f	f	f
241	Mama's Challah	https://spoonacular.com/recipeImages/Mamas-Challah-650703.jpg	<ol><li>Mix in tall glass: 3 T. flour, 2 T. sugar, both packages of yeast. Stir mixture slightly then add  cup lukewarm water (100-115. measure using liquid thermometer) Let this bubble & rise to brim of glass for about 10 minutes. (NOTE: This should bubble up to the top. If it doesnt start to foam within in a few minutes, try again with warmer water.) In the meantime.</li><li>In medium bowl (bowl A), combine 3 cups flour and 2 tsp. salt</li><li>In larger bowl (bowl B) whisk together brown sugar, oil, 2 eggs</li><li>Pour contents from bowl A into bowl B</li><li>Add contents of glass into bowl B</li><li>Add another 1  cups lukewarm water (110-115 degrees) into bowl B</li><li>Add 4 more cups flour into bowl B</li><li>Mix everything with wooden spoon at quick pace! When its too thick to mix with spoon, transfer dough to floured wooden board or other surface for about 5 minutes.</li><li>Keep hands floured, add small amounts flour by hand when dough gets sticky. It should be smoothnot too loose, not too, firm, not too sticky. Scrap off bits of dough from board, so surface is clean, & smooth. Form into a round.</li><li>Lightly oil another large bowl, place dough in bowl, turn over to coat with oil.Cover bowl with lightly damp towel.</li><li>Have warm oven ready (NOTE: preheat oven to 150 then turn off before putting dough in)</li><li>Place bowl in oven for 45 minutes / 1 hour. At 45 minutes check to see if doubled in size.</li><li>Remove bowl from oven, dip fist into flour, very gently punch 10-12 times to punch out air.</li><li>Knead again on floured board 5 minutes, add a bit of oil to bowl again, make round; return dough to bowl, cover, return to oven, let rise again 30/40ish minutes.</li><li>Punch down again, knead into a round. Gently divide into 2 loaves with sharp knife do not saw. Pre-heat oven to 350.</li><li>Place 1 loaf aside in bowl. With remaining loaf, knead with 1 hand into ball (NOTE: if using raisins, add them here), then divide into 3 pieces, braid on lightly floured board. Roll out, fatter in middle, skinny on ends of each rope. Pinch ends together, tuck under. Repeat with other loaf.</li><li>Place on oiled cookie sheet. Make egg wash  mix 1 egg & a bit of water, brush over loaves. Bake 30 minutes.</li></ol>	jewish	45	16	t	f	f	t
242	Pineapple and Noodle Kugel	https://spoonacular.com/recipeImages/Noodle-Kugel-with-Pineapple-Gluten-free--Dairy-Free-653234.jpg	<ol><li>Preheat the oven temperature to 350 degrees F</li><li>Fill a medium stockpot with water set over high heat.  When water boils add 2 tablespoons kosher salt, then add pasta, stir well to prevent sticking.</li><li>Stir occasionally, cook for 8-10 minutes.</li><li>Let it sit in the water for a few minutes before transferring to a large glass, or heatproof bowl.</li><li>Meanwhile prepare other ingredients.</li><li>Pasta should cool off a bit during your preparation of the other ingredients.</li><li>Add coconut milk, creamer, pineapple, sugar, xylitol, cinnamon, nutmeg, oil, combine well.</li><li>Add egg yolks, stir to combine well.</li><li>Prepare the crumble.</li><li>Line 2 cupcake pans with cupcake liners.</li><li>Add noodle mixture into the cupcake liners with a dry 1/4 cup measuring spoon, filling it over the top.  Add any remaining liquid to each kugel that may look dry.</li><li>With your fingers, sprinkle  crumble over each (about 1/2 teaspoon for each).</li><li>Bake for 40-45 minutes.</li><li>Cool for 10 minutes before removing from cupcake pans.</li><li>Remove liners before serving if you like.  Serve hot or warm.</li></ol>	jewish	45	24	f	f	f	t
243	Red Wine Braised Beef Brisket	https://spoonacular.com/recipeImages/Red-Wine-Braised-Beef-Brisket-658125.jpg	<ol><li>Preheat the oven to 325 degrees F.</li><li>On a cutting board, mash the garlic and 1/2 teaspoon of the salt together into a paste. Add the rosemary and continue to mash until incorporated. Put the garlic-rosemary paste in a small bowl and add 2 tablespoons of olive oil; stir to combine.</li><li>Season both sides of the brisket with a fair amount of kosher salt and ground black pepper. Place a large roasting pan or Dutch oven over medium-high flame and coat with the remaining olive oil. Put the brisket in the roasting pan and sear to form a nice brown crust on both sides. Lay the vegetables all around the brisket and pour the rosemary paste over the whole thing. Add the wine and tomatoes; toss in the parsley and bay leaves. Cover the pan tightly with aluminum foil and transfer to the oven. Bake for about 3 to 4 hours, basting every 30 minutes with the pan juices, until the beef is fork tender.</li><li>Remove the brisket to a cutting board and let it rest for 15 minutes. Scoop the vegetables out of the roasting pan and onto a platter, cover to keep warm. Pour out some of the excess fat, and put the roasting pan with the pan juices on the stove over medium-high heat. Boil and stir for 5 minutes until the sauce is reduced by 1/2. (If you want a thicker sauce, mix 1 tablespoon of flour with 2 tablespoons of wine or water and blend into the gravy).</li><li>Slice the brisket across the grain (the muscle lines) at a slight diagonal.</li></ol>	jewish	45	10	f	f	f	t
244	Chapchae - Korean Stir-Fried Noodles	https://spoonacular.com/recipeImages/Chapchae-(Korean-Stir-Fried-Noodles)-637440.jpg	<ol><li>Cook noodles according to package directions</li><li>In a large pan or wok over medium heat, heat olive oil and 1 Tbsp sesame oil</li><li>Add onion slices and garlic and saut for about 1 min</li><li>Add rest of vegetables and cook for 4-5 min, until the vegetables are half-cooked and still a bit crispy</li><li>Turn heat to low and add cooked noodles, soy sauce, sugar, and the remaining sesame oil</li><li>Mix to combine and cook for another 2 min</li><li>Add salt or more soy sauce if needed (or if you want it a bit sweeter, add a touch more sugar)</li><li>If using sesame seeds, add them at finish</li></ol>	korean	15	4	t	t	t	t
245	Dak Bulgogi - Korean BBQ Chicken	https://spoonacular.com/recipeImages/Dak-Bulgogi-(Korean-BBQ-Chicken)-641208.jpg	<ol><li>Peel off thigh skins with a paring knife. Trim off excess fat. Cut into one single "steak" piece working around the bone. Save smaller pieces for cooking as well. Set aside in a large mixing bowl.</li><li>Pulse the marinade ingredients in a food processor until smooth.</li><li>Coat the chicken pieces with the marinade. Marinate overnight in the refrigerator or a minimum of 6-12 hours. With a skewer or toothpick, piercing the thighs for extra marinade absorption is optional.</li><li>Preheat a skillet or non stick pan over medium heat. Add the chicken thighs and cook for about 15-20 minutes or until cooked through. To ensure fully cooked thighs, use a meat thermometer and check for a reading of 165-170F.</li><li>Transfer to a serving plate and garnish with scallion. Serve with lettuce leaves. Enjoy!</li></ol>	korean	400	4	f	f	t	t
246	Dolsot Bibimbap	https://spoonacular.com/recipeImages/Dolsot-Bibimbap-641559.jpg	<ol><li>Marinate beef and tofu overnight in Korean barbecue marinade.</li><li>Cook rice and keep warm.</li><li>In sesame oil and a pinch of salt, saut carrots and zucchini until almost tender. If necessary add a bit more sesame oil and toss in the remaining vegetables, garlic and a pinch of sugar and continue to saut approximately 2 minutes, or until the vegetables are almost done (they will continue to cook in the dolsot or stone bowl)</li><li>Broil or barbecue the beef.</li><li>Pour a 1/2 - 1 teaspoon of sesame oil in the base of each stone bowl. Divide rice between the 4 stone bowls. Arrange all ingredients on top of the rice side by side around the bowl. Put a teaspoon (or more depending on taste) of the Korean chili paste on top of the vegetables and in the middle of the bowl place an egg yolk. Pour a tablespoon of sesame seed oil around the edge of the bowl.</li><li>Place stone bowl on top of stove and on high heat leave for approx 5 minutes or until you can hear the rice popping and crackling.</li><li>Remove from heat and serve. Be very careful as the stone bowl will be extremely hot.</li></ol>	korean	45	4	f	f	t	t
247	Galbi Tang (Korean Beef Short Ribs Soup)	https://spoonacular.com/recipeImages/Galbi-Tang-(Korean-Beef-Short-Ribs-Soup)-644135.jpg	<ol><li>1.Soak the ribs in a bowl of cold water for about an hour to drain the blood, changing the water if necessary.</li><li>2.Mix sliced radish and add with the seasoning sauce.</li><li>3.After soaking and rinsing the ribs, place in a large pot and cover with water until submerged. Add half onion, few garlic pieces, and a slice of ginger (this step is optional).</li><li>4.Bring to a boil for about 15 minutes, removing any foam or scum that float to the top.</li><li>5.Drain and rinse the ribs under cold water removing any impurities. Add new water just until ribs are submerged (more water can be added if desired).</li><li>6.Bring to a boil, and then simmer over medium heat for 20 minutes.</li><li>7.Add the radish and sauce mixture and cook for an additional 10 minutes.</li><li>8.Lastly, add the vermicelli noodles and scallions and cook for another few minutes.</li><li>9.Garnish with thinly cut egg strips and toasted sesame seeds.</li><li>10.Serve with rice and other banchan (side dishes).</li></ol>	korean	45	4	f	f	f	t
248	Kimchi	https://spoonacular.com/recipeImages/Kimchi-648910.jpg	<ol><li>Shred cabbage in 2 inch strips. Mix with half the salt. Let stand 30 minutes. Wash and drain.   </li><li>Mix the scallions, garlic, ginger, chili pepper, cabbage and the rest of salt. Pack into a crock or glass jar.</li><li>Put the containers aside for three or four days in a cool location. After that, store it in the refrigerator.</li></ol>	korean	45	6	t	t	t	t
249	Kimchi (Korean Fermented Spicy Cabbage)	https://spoonacular.com/recipeImages/Kimchi-Kimchee-Gimchi-(Korean-Fermented-Spicy-Cabbage)-648916.jpg	<ol><li>1. Remove discolored, bruised outer leaves of cabbage and rinse well under cold water. Cut cabbage head into desired pieces; smaller 2-inch pieces is recommended for easier access later.  In 3 separate large bowls, prepare one cup sea salt and water mixture for each bowl. Sprinkle remaining 1 cup of sea salt onto the leaves of the cabbages before soaking them in the salt water. Cabbages should be partially submerged in the salt water. Let sit for a minimum 6 hours but 12 hours is preferred.</li><li>2. Once finished soaking, rinse the cabbage leaves thoroughly under cold water several times. Remove water from the cabbage by giving them a squeeze (they should have a rubbery texture by now) to remove excess water. Set in a colander or basket for at least 2 hours so the water will drain out thoroughly. Meanwhile, prepare the red pepper mixture to be mixed with cabbage leaves.</li><li>3. Prepare 3 tbsp of the sweet rice flour with 3 cups of water into a small pot. Bring to a boil and whisk until the mixture turns into a glue-like consistency. Let cool and set aside.</li><li>4. In a food processor, puree onion, garlic, ginger and some water until smooth. Pour gochugaru (chili flakes) in a large mixing bowl, add the garlic mixture puree, cooled rice glue, fish sauce, salted shrimp, sugar, and sesame seeds. Mix well and add the sliced radish and green onions.</li><li>5. Lather each cabbage piece with red pepper mixture by rubbing them well (rubber gloves highly recommended). Continue until all the cabbage leaves are covered in the red pepper mixture. Pack them inside air-tight glass jars/containers.  Set out at room temperature for 2 days for fermentation to take place. After that, place in the refrigerator and serve as needed. The kimchi may keep for 2 or 3 months in the refrigerator.</li><li>*Making kimchi is not easy, but if done right, the rewards are endless. You can take the easy way out and purchase them at your local Korean grocery store and even possibly in the Asian foods section of your local grocery.</li></ol>	korean	45	20	f	f	t	t
250	Kogi Kimchi Quesadillas	https://spoonacular.com/recipeImages/Kogi-Kimchi-Quesadillas-649002.jpg	<ol><li>1. In a skillet or non-stick frying pan, melt the 2 tbsp butter and add the chopped kimchi, cook over medium heat until caramelized and slightly charred. Remove any excess liquid and set aside. Seasoning with garlic powder is recommended.</li><li>2. In the same pan, saute the thin slices of beef on medium heat until browned. Add salt and pepper for seasoning. Remove any excess liquid and set aside.</li><li>3. On large pan or griddle, heat over medium heat. Brush 1 tsp vegetable or olive oil on pan and coat evenly. Place 1 tortilla on pan and spread ingredients according to preference. Make sure to leave an inch from the edges clear and top with another tortilla. Slightly press down with hand to compress the quesadilla. Drizzle some oil on the top tortilla and brush evenly to coat.</li><li>4. Heat the quesadilla until browned on the bottom, flip carefully and continue cooking until browned and blistered on both sides. When finished, carefully transfer to a cutting board and let cool for a few minutes. Cut into 4 equal pieces and transfer to serving plate. Repeat with remaining ingredients to make 4 quesadillas. Mixing and matching ingredients to your liking is encouraged. ^^</li></ol>	korean	45	4	f	f	f	f
251	Korean BBQ Beef	https://spoonacular.com/recipeImages/Korean-Bbq-Beef-649024.jpg	<ol><li>(The Meades)</li><li>Mix it all together and marinate at least 2 hours. Can either cook it on the grill as kebabs or stir-fry by itself. Enjoy.</li><li>When I don't have sirloin tips, I use flank steak and it tastes just as good. Also, I substitute hot pepper sesame oil and also add cayenne pepper for more kick. The sugar allows the beef to caramelize a little (I tried using cane sugar once but it didn't caramelize).</li><li>NOTES: Just tried this recipe recently (4 or 5 times) and it is absolutely wonderful - from Omaha Steaks recipe book</li></ol>	korean	45	1	f	f	t	t
252	Korean Bulgogi	https://spoonacular.com/recipeImages/Korean-Bulgogi-649034.jpg	<ol><li>Season the beef with salt and pepper. In a mixing bowl, combine the oil, soy sauce, garlic and ginger. Season with crushed red pepper to taste.</li><li>Place the meat in a shallow bowl. Pour the marinade over the meat. Cover and refrigerate for at least 1 hour or overnight. Remove and bring to room temperature. Preheat the hibachi. Remove the meat from the pan, reserving the marinade. Place the marinade in a saucepan, over medium heat. Bring to a boil and cook for 6 to 8 minutes or until the mixture reduces by 3/4. Remove, set aside, and keep warm. Grill the meat for a couple of minutes on each side, for medium rare. To serve, spoon the rice in the center of each plate. Lay the strips of meat around the rice. Drizzle the sauce over the </li><li>Yield: 4 servings</li></ol>	korean	45	1	f	f	t	t
253	Vegetable Bibimbap	https://spoonacular.com/recipeImages/Vegetable-Bibimbap-664523.jpg	<ol><li>Marinate tofu overnight in Korean barbecue marinade.</li><li>Cook rice and keep warm</li><li>In sesame oil and a pinch of salt, saut carrots and zucchini until almost tender. If necessary add a bit more sesame oil and toss in the remaining vegetables, garlic and a pinch of sugar and continue to saut approximately 2 minutes, or until the vegetables are almost done (they will continue to cook in the dolsot or stone bowl)</li><li>Broil or barbecue the beef.</li><li>Pour 1/2 - 1 teaspoon of sesame oil in the base of each stone bowl. Divide rice between the 4 stone bowls. Arrange all ingredients on top of the rice side by side around the bowl. Put a teaspoon (or more depending on taste) of the Korean chili paste on top of the vegetables and in the middle of the bowl place an egg yolk. Pour a tablespoon of sesame seed oil around the edge of the bowl.</li><li>Place stone bowl on top of stove and on high heat leave for approx 5 minutes or until you can hear the rice popping and crackling.</li><li>Remove from heat and serve. Be very careful as the stone bowl will be extremely hot.</li></ol>	korean	45	4	f	f	t	t
254	Winter Kimchi	https://spoonacular.com/recipeImages/Winter-Kimchi-665379.jpg	<ol><li>Soak the quartered cabbage in the brine solution for 4 hours, weighing the cabbage down with a heavy plate.</li><li>Remove and drain.</li><li>Place garlic cloves, rice, fermented shrimp, fish sauce, sugar, chilly paste and chilly flakes in a food processor and zap to a smooth paste. Stir in spring onions.</li><li>Stuff the cabbage with the paste, making sure to stuff in between the individual leaves and coating every inch of it.</li><li>Place kimchi into an airtight container and leave at room temperature for a day before leaving it to ferment further in the fridge for at least another week before consuming. I left mine for about 3 weeks.</li></ol>	korean	45	1	f	f	t	t
255	Zomppa's Kimchi	https://spoonacular.com/recipeImages/Zomppas-Kimchi-665680.jpg	<ol><li>Peel skin off of cucumbers.</li><li>Slice the cucumbers in  of inch slices.</li><li>Place cumbers in a bowl with salt.  Let sit for 15 minutes.</li><li>With hands, squeeze liquid out of the cucumbers.</li><li>Place cucumbers back in bowl.  Add the garlic, ginger, red pepper powder, fish sauce, lemon juice, sesame oil and honey.</li><li>With hands, mush all ingredients together.  Taste.</li><li>Add more hot pepper, fish sauce or honey to adjust the taste to your liking.  8. Place in airtight container and let refrigerate for 3 hours before enjoying.</li></ol>	korean	45	1	f	f	t	t
256	Ahi Tuna Ceviche	https://spoonacular.com/recipeImages/Ahi-Tuna-Ceviche-632021.jpg	<ol><li>In medium bowl mix soy sauce, toasted sesame oil, rice vinegar, Serrano pepper, lime juice, mint, and sesame seeds. Then add diced tuna and toss to coat.</li><li>The tuna is ready to eat as soon as it's tossed and coated but you can marinate it for a few minutes if desired. The tuna will start to turn white almost immediately, a sign that it is cooking from the acidity of the lime juice. It is not necessary to cook the tuna. In fact, it is best served immediately while it is melt-in-your-mouth tender and moist.</li><li>Serve immediately by mounding atop crackers, chips, micro-greens, or even roasted sweet potato slices.</li></ol>	latinAmerican	45	3	f	f	t	t
257	Carne Asada Burritos	https://spoonacular.com/recipeImages/Carne-Asada-Burritos-637133.jpg	<ol><li>In a medium sized bowl combine beef, cumin, paprika, pepper, salt and lime juice. Toss to combine and coat meat. Cover and place in refrigerator for at least 30 minutes.</li><li>Prepare pico de gallo in a small bowl. Cover and let sit until ready to assemble burritos.</li><li>Prepare avocado slices and drizzle with fresh lime juice to keep them from browning.</li><li>In a large skillet heat olive oil over medium-high heat. Add onion and garlic to pan and cook just until garlic is fragrant. Add beef to pan and cook for 3-5 minutes.</li><li>Warm tortillas in a large pan over medium heat.</li><li>Place  cup meat, 2 tablespoons of pico de gallo, and a double layer of spinach leaves in the center of each tortilla. Fold sides over filling, then roll one edge over filling and roll until filling is completely covered. Place seam side down on plate.</li><li>Serve with lime wedge and sliced avocado.</li></ol>	latinAmerican	30	6	f	f	f	t
258	Chimichurri	https://spoonacular.com/recipeImages/Chimichurri-638619.jpg	<ol><li>Put the parsley, cilantro and garlic into a medium mixing bowl and toss to combine. Add the vinegar, salt, red and black pepper and stir. Pour in the olive oil and mix well to combine. Allow the mixture to sit for 30 minutes to allow the flavors to blend. This sauce is not only great on steak but I think it would also be wonderful on pork and chicken as well.</li></ol>	latinAmerican	45	4	t	t	t	t
259	Chimichurri Skirt Steak with Grilled Asparagus	https://spoonacular.com/recipeImages/Chimichurri-Skirt-Steak-with-Grilled-Asparagus-638626.jpg	<ol><li>Place all chimichurri sauce ingredients except for the olive oil in a food processor &amp; pulse until well chopped. While the food processor is going, slowly pour the olive oil into the mixture until blended.  Reserve half of the sauce to serve on the side with the meal.</li><li>Season skirt steaks with salt &amp; pepper on bother sides.  Spoon the remaining chimichurri sauce over the steaks &amp; let marinate for 30 minutes up to overnight.</li><li>Pre-heat the grill to 350 to 400 F.</li><li>In a plastic resealable bag, add asparagus, olive oil, garlic, salt &amp; pepper.  Shake to coat &amp; place in a grill basket.</li><li>Place the steak &amp; grill basket of asparagus directly over a hot grill.  Gently toss the asparagus for even grilling &amp; baste with garlic, olive oil mixture  10 minutes.</li><li>Grill the skirt steak to desired temperature  5 to 8 minutes per side.</li><li>Remove from grill &amp; let steak rest for 10 minutes before slice long strips.  Spoon reserved chimichurri sauce over steak &amp; serve with asparagus on the side.</li></ol>	latinAmerican	45	4	f	f	t	t
260	Dulce De Leche	https://spoonacular.com/recipeImages/Dulce-De-Leche-641723.jpg	<ol><li>Combine the first four ingredients in in a large saucepan and place over medium heat. Bring to a simmer, stirring occasionally, until the sugar has dissolved.</li><li>Once the sugar has dissolved, add the baking soda and stir to combine. Reduce the heat to low and cook uncovered at a bare simmer. Stir occasionally. Continue to cook for 1 hour.</li><li>Remove the vanilla bean after 1 hour and continue to cook until the mixture is a dark caramel color and has reduced to about 1 cup, approximately 1 1/2 to 2 hours.</li><li>Strain the mixture through a fine mesh strainer.</li></ol>	latinAmerican	45	4	t	f	t	f
261	Dulce De Leche Cheesecake	https://spoonacular.com/recipeImages/Dulce-De-Leche-Cheesecake-641730.jpg	<ol><li>Toss the cookie crumbs into the melted butter in a mixing bowl. Reserve 1 tablespoon of the mixture for the topping. Press the rest of the mixture onto the bottom and up 3cm high of a greased 24cm spring form pan. Chill until its ready for use.</li><li>Using electric mixer beat balance cream cheese and sugar in a large mixing bowl until smooth. Add yogurt and eggs, beating until just blended. Stir in cornstarch, dulce de leche, lemon juice and zest until blended.</li><li>Pour the mixture into the crust and sprinkle the top with reserved cookie crumbs. Steamed bake the cheesecake at 165C/330F for 65 minutes until almost set. Turn oven off. Leave the cake with the oven door ajar for 1 hour. Cool completely and chill at least 4 hours or overnight until firm.</li></ol>	latinAmerican	45	10	t	f	t	f
262	Dulce De Leche Shortbread Cookies	https://spoonacular.com/recipeImages/Dulce-De-Leche-Shortbread-Cookies-641731.jpg	<ol><li>Using your fingers, combine all the ingredients to make a uniform dough. If it seems a little dry (like mine was) add in a TSP of cold water until it is the correct dough consistency.</li><li>Roll out to 1/2 inch thickness  I was in a place with no rolling pin when I was making these so I used a wine bottle, it works really well if you are in a pinch!</li><li>Cut them into circles  I used a shot glass and that was actually the perfect size! They were either 1 big bite or 2 little ones, just enough at one time.</li><li>Dont forget to keep using your scraps to make more cookies.</li><li>Bake the cookies at 350 F for 10-15 minutes on a parchment lined cookie sheet.</li><li>When the cookies are cool, spread with 1 TBSP dulce de leche. If you want, sprinkle with either pink himalaya salt or sea salt. Enjoy!</li></ol>	latinAmerican	45	1	f	f	f	f
263	Dulce De Leche Swirled Amaretto Frozen Yogurt	https://spoonacular.com/recipeImages/Dulce-De-Leche-Swirled-Amaretto-Frozen-Yogurt-641732.jpg	<ol><li>Drained the yogurt overnight</li><li>Mix the amaretto cream into the yogurt & churn in your ice cream maker as according to the manufacturer's instruction.</li><li>Warm the dulce de leche, or caramel in the microwave for 30 seconds. When yogurt is done churning, layer drizzles of dulce de leche into the yogurt and store in the freezer.</li></ol>	latinAmerican	45	4	t	f	t	f
264	Flank Steak With Chimichurri Sauce	https://spoonacular.com/recipeImages/Flank-Steak-With-Chimichurri-Sauce-643055.jpg	<ol><li>For the Sauce: Mix parsley, oregano, red pepper flakes (if you are using) and garlic in a food processor or blender and mix until combined.  Drizzle in olive oil and red wine vinegar and process until combined. </li><li> Season sauce to taste with salt and pepper.  Let set for at least 1 hour.</li><li>Season steak with salt and pepper.  Grill over medium high heat for 5 minutes on each side for medium rare.  Let rest for 5 minutes.</li></ol>	latinAmerican	75	4	f	f	t	t
265	Fresh and Simple Swai Ceviche	https://spoonacular.com/recipeImages/Fresh-and-Simple-Swai-Ceviche-643428.jpg	<ol><li>Place the diced fish into  of the lime juice and refrigerate for at least 3 hours. Strain when ready to proceed.</li><li>Mix the veggies with the remaining lime juice.</li><li>Stir in the fish and cilantro. Drizzle with olive oil and add the chile-garlic sauce. Gently toss.</li><li>Salt and pepper to taste. Serve with tortilla chips or a salad.</li></ol>	latinAmerican	45	4	f	f	t	t
266	Gluten-Free Tres Leches Cake	https://spoonacular.com/recipeImages/Gluten-Free-Tres-Leches-Cake-644907.jpg	<ol><li>Preheat oven to 350 degrees. Generously butter a 13X9 baking dish. In a large bowl, beat  c sugar, egg yolks, and butter until light and fluffy, about 5 minutes. Fold in the vanilla extract, orange zest, cinnamon, sorghum flour, masa harina, baking powder, xanthan gum, and milk.</li><li>In another large bowl, beat egg whites to soft peaks, adding cream of tartar after about 20 seconds. Gradually add the remaining  c sugar and continue beating until egg whites are glossy and firm, but not dry.</li><li>Gently fold the egg whites into the cake mixture. Pour this batter into the baking dish, spreading out evenly.  Bake until the cake is golden and a toothpick inserted in the center comes out clean, about 25 minutes. Pierce cake all over with a toothpick.</li><li>Whisk together the milks, and pour evenly over cake. Allow to cool for a bit, and cover and place in refrigerator for 4 hours, up to overnight.</li><li>Before serving,  place the whipping cream, sugar, and vanilla in a mixer bowl and whisk to stiff peaks, and nice and thick. Spread over cake and top with strawberries and mint leaves.</li><li>Allow to chill in refrigerator until ready to serve.</li></ol>	latinAmerican	45	10	f	f	t	f
267	Lomo Saltado Beef Stir Fry	https://spoonacular.com/recipeImages/Lizs-Lomo-Saltado-650225.jpg	<ol><li>Prepare the frozen french fries according to directions. Set aside when complete and keep warm.</li><li>Heat a large wok or skillet over medium-high heat. Saute the onions and bell peppers until translucent, about 10 minutes. Add the garlic and jalapeno and cook for an additional minute. Mix everything until combined.</li><li>Add the beef chunks, cumin, complete seasoning, soy sauce and red wine vinegar sauce. Mix well and cook until beef is no longer pink about 5 to 7 minutes.</li><li>Add the tomato chunks and add the cover and cook for additional 5 minutes. When ready to serve, add the french fries and toss everything gently together.</li><li>Serve lomo saltado over a bed of white rice and garnish with freshly chopped cilantro leaves. Enjoy with aji sauce on the side.</li></ol>	latinAmerican	45	4	f	f	t	t
268	Crispy-Crowned Guacamole Fish Fillets	https://spoonacular.com/recipeImages/Crispy-Crowned-Guacamole-Fish-Fillets-157399.jpg	<ol><li>Prepare the guacamole by dicing the onion, cutting the tomatoes, and crushing the garlic. Mix these ingredients with the ripe avocado and spice with salt, pepper, cilantro, and tabasco.</li><li>Fry the fish for 5 minutes.</li><li>Crush the tortilla chips with your hands.</li><li>Cut the bell peppers in strips.</li><li>Place the fish on a plate, use a fork to distribute the guacamole on the fish and crown the fish with the crispy crushed tortilla chips.</li></ol>	mexican	30	2	f	f	t	t
269	Black Bean and Peppers Taco Filling	https://spoonacular.com/recipeImages/Black-Bean-and-Peppers-Taco-Filling-635058.jpg	<ol><li>In a skillet add olive oil, onions and bell pepper. Cook until tender, about 3  5 minutes. Add tomatoes and seasonings, saute for 10 minutes. Add black beans and cook until warm.</li><li>Serve with tortillas.</li><li>Additional toppings: Romaine Lettuce, Cheese, jalapenos, salsa, hot sauce, avocado, and greek yogurt</li></ol>	mexican	45	8	t	t	t	t
270	Black Bean and Veggie Burgers with Corn Salsa	https://spoonacular.com/recipeImages/Black-Bean-and-Veggie-Burgers-with-Corn-Salsa-635059.jpg	<ol><li>Mix all the salsa ingredients together and chill for about an hour before serving.</li><li>Preheat your oven to 425 degrees F. Spray two baking sheets lightly with the nonstick spray and set aside.</li><li>Add the carrot to a bowl with a little water, cover it and microwave for about two minutes. Once cooled, mash them and add them to the mashed black beans. Mix together then add the remaining vegetables and mix well.</li><li>Add the oatmeal, breadcrumbs, seasoning and salsa. Mix together until combined. Add the flour and mix well. If the mixture is too moist, add more flour and adjust the seasoning, as needed.</li><li>Form the mixture into patties and place them on the baking sheets. Bake for about 20 minutes, flipping them halfway through cooking. When the burgers are finished, serve with the Corn Salsa or your favorite topping.</li></ol>	mexican	45	8	t	t	f	t
271	Chilled Avocado and Cucumber Soup with Prawn and Scallop Salsa	https://spoonacular.com/recipeImages/Chilled-Avocado-and-Cucumber-Soup-With-Prawn-and-Scallop-Salsa-638588.jpg	<ol><li>In a small sauce pot, combine the minced shallots, red chili pepper flakes and oil.</li><li>Heat the oil over very low heat and simmer for about 3 minutes.</li><li>Remove from the heat and let stand for 3 minutes. Stir in the lime zest and the water.</li><li>Let stand for at least an hour, then strain the oil into a small bowl or jar.</li><li>Adding water in the oil with the lime zest dissolves and carries water-soluble flavors.</li><li>Set aside, while you prepare the soup.</li><li>Place the cucumber, avocado and green onion in a blender.</li><li>Squeeze the lime juice and add 2 tablespoon of the miso paste.</li><li>Blend the ingredients adding the water to dilute the mixture until smooth and creamy.</li><li>Season the soup (to taste) with more miso paste and lime juice if necessary.</li><li>Transfer the soup into a large bowl, cover and chill in the refrigerator for at least 2 hours.</li><li>To cook the prawns and scallops, heat a skillet over medium-high heat.</li><li>Then, season the prawns and scallops with salt and pepper on both sides.</li><li>Once the pan is nice and hot, add one tablespoon of the oil.</li><li>Add the prawns and scallops and cooked until they are done. </li><li>Remove and transfer to a bowl. Then, add the orange pieces, black olives and cilantro.</li><li>Cut the prawns into 3 or 4 pieces depending on the size and add these to the bowl.</li><li>Season with a little bit of sea salt and black pepper (if necessary) and drizzle with chili-lime oil.</li><li>Toss gently with a spoon to combine.</li><li>To serve the dish, bring out the four individual bowls and the avocado soup from the fridge.</li><li>Ladle the soup onto the bowls, then garnish with the prawn and scallop salsa and finish with more drizzle of the chili-lime oil.</li></ol>	mexican	45	4	f	f	t	t
272	Corn Avocado Salsa	https://spoonacular.com/recipeImages/Corn-Avocado-Salsa-640062.jpg	<ol><li>Preheat oven to 375 degrees.</li><li>Spread corn flat on a baking sheet.</li><li>Spray lightly with olive oil spray.</li><li>Roast corn in the oven for about 8-10 minutes. (Be careful not to brown too much or burn.)</li><li>Remove from heat and allow to cool.</li><li>Finely chop red pepper and garlic and mix in a bowl.</li><li>Peel and coarsely chop avocado and add to bowl.</li><li>Add cooled corn.</li><li>Mix in cumin and vinegar and blend well.</li></ol>	mexican	25	2	t	t	t	t
273	Flank Steak with Herbed Salsa	https://spoonacular.com/recipeImages/Flank-Steak-with-Herbed-Salsa-643061.jpg	<ol><li>Preheat a grill pan or light a grill.</li><li>In a medium bowl, combine the tomatoes with the scallions, cilantro, Jalapeno, garlic and lemon  lime juice. Season the salsa with salt and freshly ground pepper.</li><li>Season with salt and pepper the flank steak.</li><li>Using a grill pan brush a shadow of oil on the bottom of it. Place the pan over high heat and when hot add the flank steak. Cook until nicely charred outside and medium rare inside. About 3 minutes per side.</li><li>Transfer the steak to a carving board and let rest for 5 minutes.</li><li>Thinly slice the steak across the grain and serve with the herbed salsa.</li></ol>	mexican	45	4	f	f	t	t
274	Grilled Chicken With Pineapple Salsa	https://spoonacular.com/recipeImages/Grilled-Chicken-With-Pineapple-Salsa-645670.jpg	<ol><li>Make marinade of 1/3 cup lime juice, 1/3 cup olive oil, 1 teaspoon salt, and 1/4 teaspoon pepper.</li><li>Marinate chicken overnight. Combine salsa. Saute pineapple, mango, peppers, onions, and garlic. Add lime juice and honey and refrigerate (up to 24 hours).</li><li>Bring to room temperature to serve. Grill chicken breasts and serve with sauce and white rice.</li></ol>	mexican	45	1	f	f	t	t
275	Grilled Fish Tacos with Spicy Tequila-Lime Guacamole	https://spoonacular.com/recipeImages/Grilled-Fish-Tacos-W--Spicy-Tequila-Lime-Guacamole-645711.jpg	<ol><li>Using a fork or potato masher, mash avocado in a bowl.</li><li>Add yogurt, lime juice, lime zest and tequila; mix well.</li><li>Add jalapeno, onion, salt/pepper and cilantro; stir until all ingredients are incorporated and smooth.</li><li>Adjust seasonings if desired.</li><li>Pour finished guacamole into serving bowl; set aside.</li><li>Preheat a grill pan to med-high heat.</li><li>Drizzle fish on each side with olive oil and season with salt and pepper.</li><li>Grill fish on each side until opaque, about 4 mins.</li><li>Remove fish from grill and flake into large chunks with a fork.</li><li>Heat tortillas on the grill pan until blisters form.</li><li>To assemble tacos, spread a dollop of guacamole onto tortilla, add fish, and top with shredded lettuce and chopped tomatoes (or whatever toppings you prefer).</li><li>Optional: squeeze additional lime juice over the fish.</li><li>Enjoy with a Mexican beer or tasty margarita! :)</li><li>Note: if you have any leftover guacamole, serve it as a dip with tortilla chips!</li></ol>	mexican	45	4	f	f	f	f
276	Grilled Salmon With Cherry, Pineapple, Mango Salsa	https://spoonacular.com/recipeImages/Grilled-Salmon-With-Cherry--Pineapple--Mango-Salsa-645856.jpg	<ol><li>Combine all the above ingredients except the olive oil and salmon into a mixing bowl. Stir gently. Add one splash of olive oil and taste for seasoning. Cover and refrigerate until ready to use.</li><li>Lightly oil and season a salmon fillet with a splash of olive oil and salt and pepper. Place flesh side down on a cleaned and oiled grill or pan. Cook for 2-4 minutes depending on the thickness. Flip and cook for another 2-4 minutes. Salmon will be cooked when the flesh is no longer opaque. I tend to like it pretty rare, but it's your salmon- cook it how you want it!</li><li>Top salmon with salsa and serve!</li></ol>	mexican	45	2	f	f	t	t
277	Grilled Salmon With Mango Salsa	https://spoonacular.com/recipeImages/Grilled-Salmon-With-Mango-Salsa-645863.jpg	<ol><li>To make salsa: In bowl, combine mango, pineapple, onion, cilantro and lime juice. Season to taste with salt. Set aside 20 minute to 1 hour, to blend.</li><li>Heat grill to medium-high. Season salmon with salt and pepper. Place fish on hot grill, skin-side down, and cook 5 minutes. Do not worry if skin is blackened. Turn and grill fish until it is no longer raw in center, about 3 minutes, depending on thickness of the fish.</li><li>To serve, place piece of grilled salmon in center of each of 4 dinner plates. Arrange about 1/4 cup salsa along either side of fish.</li><li>This recipe yields 4 servings.</li></ol>	mexican	45	4	f	f	t	t
278	Homemade Hard Taco Night with Carnitas and Pinto Beans	https://spoonacular.com/recipeImages/Homemade-Hard-Taco-Night-with-Carnitas-and-Pinto-Beans-647015.jpg	<ol><li>Into a hot pan sizzling with a glug or two of vegetable oil I sear my pork, using tongs to turn each piece over until each side of each cube is nicely browned.</li><li>I add 1 cup of red onion and garlic to my sizzling pork pieces, and toss well.  I cook this until the onion softens about 4 minutes.</li><li>Then I add my orange juice and the juice from 1/2 a lime, which I stir in well.   I bring them just to a boil before I add my chicken stock, which covers about 3/4 of my meat.  I set the heat to medium, and bring this to a slow simmer to braise for the next three hours.</li><li>I fried taco shells by adding a few inches of vegetable oil to a deep fry pan and set it to high heat.  When sizzling, using tongs, I floated 1/2 of a 10 corn tortilla on the surface of the blistering oil  about 5 seconds did the trick, or until it set.</li><li>Moving quickly but carefully, I flipped the tortilla over, rolling it in the oil, releasing the tongs from one edge and immediately catching the other edge in their grip.</li><li>Holding the other edge under the hot oil, I fried it until crunchy, then dipped the center fold into the pot to crisp it up last.   Be careful to pour all the oil out when lifting your shells from the fryer.  I sprinkled them with sea salt while hot</li><li>I put my small deep pan, with a few glugs of oil, over the heat for about 10 minutes before adding 1/2 a cup of my diced onion and some minced garlic.  I cook this until just softened and fragrant.  Then I add about a teaspoon of black pepper, a healthy sprinkling of cumin, and a dash of sea salt.  Finally, I add my can of pinto beans, liquid and all.  I cover and bring to a simmer, heating all the beans through.</li><li>I peel and mash the avocados, adding fresh cilantro, a dash of minced garlic, a squeeze of lemon juice, sea salt, cracked black pepper, 1/4 cup diced red onion, and ground cumin to make guacamole.</li><li>In another bowl, Ive mixed my diced tomatoes, 1/4 cup diced red onion, minced garlic, fresh cilantro, the juice of 1/2 a lime, a glug of oil, and a dash of white vinegar together (along with some diced jalapeno, if you want heat), to make a quick fresh delicious pico de gallo.</li><li>Scoop up about 4 tablespoons of the fat from the carnitas and dump it into the beans for flavor.</li><li>After about 15 minutes, and some squishing of beans with my fork, they are thick and syrupy.</li><li>Build tacos as desired using shredded cheese, pork, beans, pico, guacamole, sour cream and cilantro.</li></ol>	mexican	240	2	f	f	t	f
279	Mini Stuffed Mexican Bell Peppers	https://spoonacular.com/recipeImages/Mini-Stuffed-Mexican-Bell-Peppers-651977.jpg	<ol><li>1. Roast the vegetables:  Preheat oven to 400 degrees.Cut the tomatillos in half, slice the onion into 1/2 in slices and remove garlic from covering. Place on baking sheet. Roast till tomatillos are tender and start to brown, about 20 minutes.</li><li>2. Meanwhile,make the sauce: Add tomatillos, onion, garlic, tomatoes, green chilies, chipotles, chili powder, cumin, paprika, and coriander to blender or food processor. Blend until smooth.</li><li>3. In a large bowel, add the turkey, beans, and sauce, Mix together until everything is evenly distributed.</li><li>4. Cut tops off mini bell peppers and remove any seeds. Stuff turkey mixture into peppers until slightly overflowing. Place in 9 by 13 glass dish. Repeat for all bell peppers.</li><li>5. Cook at 400 for 20 minutes. For the last 5 minutes, turn on the broiler and get some color on the peppers.</li><li>6. Serve with your favorite salsa (used my Pico De Gallo from my tortilla soup), sour cream and avocado.</li><li>ENJOY!</li></ol>	mexican	45	4	f	f	t	t
280	Nacho Mama's Cheese Nachos	https://spoonacular.com/recipeImages/Nacho-Mamas-Cheese-Nachos-652926.jpg	<ol><li>To get started, grab a pan and melt up your butter. Add in the flour and create a roux. Then add in your milk, put the heat on medium and let the mixture thicken.</li><li>Turn the heat down to low and add in the cheese.</li><li>Once it's melted add in your green chilies, chili powder, cumin, and cilantro. Now add in the salsa.</li><li>Lay your chips in an oven proof bowl and pour the cheese over the top. Now add on your desired toppings.</li><li>Throw them in the oven for about 10 minutes at 350 degrees.</li></ol>	mexican	45	1	f	f	f	f
281	Poblano, Mango, and Black Bean Quesadilla	https://spoonacular.com/recipeImages/Poblano--Mango--and-Black-Bean-Quesadilla-656519.jpg	<ol><li>Heat olive oil, onions, poblano, oregano, salt and pepper in large pan. Saute for about five minutes.</li><li>Add black beans. Let heat for one minute, stirring occasionally.</li><li>Pull pan off heat. Add mangoes and avocado. Stir.</li><li>In another pan, sprinkle large flour tortilla with cheddar cheese, and fry in butter. *Note: for a lower-fat option, place tortilla on baking sheet, sprinkle tortilla with cheese and place under broiler.</li><li>Place pan under broiler to allow cheese to melt.</li><li>Cover half the tortilla with bean mixture, and fold in half.</li><li>Serve with sour cream, salsa and guacamole.</li></ol>	mexican	45	2	t	f	f	f
282	Pork Shoulder Tacos with Chipotle Greek Yogurt and Coleslaw	https://spoonacular.com/recipeImages/Pork-Shoulder-Tacos-with-Chipotle-Greek-Yogurt-and-Coleslaw-656820.jpg	<ol><li>To Make the pork shoulder:</li><li>Place all ingredients in the crock pot.  Cook for 5 hours on low.  Meat should be tender and easily shred when finished cooking.</li><li>To Make the Chipotle Greek Yogurt:</li><li>In a small bowl, add the Greek yogurt.  Crack open your can of chipotle chilies in adobo sauce and remove the seeds from 3 or 4 of the chilies (about half of the can). Finely chop and add to the Greek yogurt. Add about a teaspoon of the adobo sauce.  Stir. For a spicier sauce, add additional chipotle chilies.</li><li>To Make the no-mayo coleslaw:</li><li>Thinly slice the cabbage and chop the green onion.  Peel and julienne the carrot.  Add all veggies to a large mixing bowl.  Mix the lime juice, apple cider vinegar and olive oil together in a small bowl.  Drizzle the liquid over the veggies.  Add salt and pepper to taste and if youre one of those cilantro people, add a handful of chopped cilantro.  Mix thoroughly and serve on your taco.</li><li>To assemble the tacos, simply heat your favorite tortilla on the stove until warm. Spoon desired amount of meat, chipotle Greek yogurt sauce, and coleslaw on the tortilla and enjoy!</li><li>Nutritional information is per taco.</li></ol>	mexican	45	12	f	f	t	f
283	Pork Tenderloin With Mango-Kiwi Glaze Served With Tomatillo Salsa	https://spoonacular.com/recipeImages/Pork-Tenderloin-With-Mango-Kiwi-Glaze-Served-With-Tomatillo-Salsa-656839.jpg	<ol><li>Dry Rub the Pork:</li><li>Mix together the spices.</li><li>Rub the pork with the spice mix. Cover and refrigerate for 2 hours.</li><li>Make the Glaze*:</li><li>Saute the onion, garlic, ginger, and jalapeno in 2 teaspoons of olive oil.</li><li>Add the mango, kiwi, salt, pepper, and cayenne. Cook over medium heat for 10 minutes or until mixture thickens slightly.</li><li>Cool.</li><li>Puree in blender or food processor. Strain into a clean bowl.</li><li>Add lime juice and set aside.</li><li>This can be made a day ahead.</li><li>Cook and glaze the pork:</li><li>Preheat oven to 425F.</li><li>Heat 2 teaspoons olive oil in an oven-proof pan. Sear the pork on all sides in the hot pan.</li><li>Place the pork in the oven for 5 minutes. Brush with glaze.</li><li>Cook for another 5 minutes and brush with more glaze. Reserve the remaining glaze to serve alongside the pork.</li><li>Allow to finish cooking for 10 minutes or until the internal temperature reaches 145F.</li><li>Remove from oven and allow to rest for at least 10-15 minutes before slicing.</li><li>Make the Tomatillo Salsa**:</li><li>Mix ingredients together.</li><li>Allow to sit until ready to use.</li><li>Serve with the pork tenderloin.</li><li>Can be made a day ahead.</li><li>Serve it up:</li><li>Slice the pork and serve with the salsa and any remaining glaze.</li></ol>	mexican	45	4	f	f	t	t
284	Pressed Bean, Veggie and Cheddar Burrito	https://spoonacular.com/recipeImages/Pressed-Bean--Veggie---Cheddar-Burrito-657126.jpg	<ol><li>Get all the ingredients ready first, diced the veggies, shred the cheese, rinse the beans. I leave the avocado slicing until I'm ready to assemble so it does't brown.</li><li>In a large saute pan, over medium high heat, add a few drizzles of olive oil and the corn, bell peppers and onions. Season with salt, pepper and garlic powder. You are looking just to cook until the veggies are just starting to soften. Add in the black beans and the lime juice. Cook for a couple minutes until the beans are warmed through.</li><li>Thats it! Now time to assemble. Lay the tortilla flat, add a line of cheese, the veggies and a few slices of avocado.</li><li>Fold the end over the filling then fold in the sides. Roll until almost at the end then add a little bit more cheese so it gets sealed a bit better.</li><li>Place the burrito onto a panini press set on high, You are looking just to crunch up the outside a bit. Notice mine opened up in the corner, its because I used whole grain tortilla wraps and found that they were more brittle then a regular wrap.</li></ol>	mexican	45	4	t	f	t	f
285	Restaurant Style Salsa	https://spoonacular.com/recipeImages/Restaurant-Style-Salsa-658180.png	<ol><li>Combine all ingredients in a food processor. Pulse until you get the salsa consistency you like. 10 to 15 pulses. Test seasonings and adjust accordingly.</li><li>Store in a Tupperware container.</li><li>Ready in 5 minutes</li></ol>	mexican	5	4	f	f	t	t
286	Roasted Veggie Burrito	https://spoonacular.com/recipeImages/Roasted-Veggie-Burrito-658705.jpg	<ol><li>Preheat oven to 425 degrees. Slice veggies into  inch bite sizes pieces, and onion into small slices. Place on baking sheet, add 1 tbsp olive oil, pepper to taste, garlic powder, onion powder and chili powder. Toss together until evenly distributed.Bake until veggies begin to caramelize, about 25 minutes.</li><li>Heat 1 tbsp olive oil in a large frying pan over medium high heat. Add beans and spices. Stir and cook until beans are heated through, about 5 minutes. Add veggies and mix together. Let everything heat together for about 2 minutes. Remove from heat.</li><li>Assemble Burrito: On a flour burrito tortilla, place about  cup veggie and black bean mixture per burrito. Add  of the cheese to each burrito. Add 1 TBSP sour cream, salsa on top on each burrito. Add 2 TBSP of guacamole and corn to each burrito. Fold the edges in and roll along the long edge of the tortilla.If desired, place on foil and roll so that foil is wrapped around the burrito.</li></ol>	mexican	45	4	t	f	f	f
287	Vanilla and Lime Flan By Esperanza Platas Alvarez	https://spoonacular.com/recipeImages/Vanilla-and-Lime-Flan-By-Esperanza-Platas-Alvarez-(Planet-Food-Mexico)-664284.jpg	<ol><li>Preheat the oven to 360 degrees Fahrenheit.</li><li>To make the caramel, heat together the water and sugar gently over a medium flame for about 10 minutes, ensuring the mixture does not burn.</li><li>Meanwhile, pour the condensed milk and whole milk into a pan. Add the zest of the limes. Slice the vanilla pod in half and carefully scrape out the vanilla seeds and add these to your milk mixture.</li><li>Simmer the milk slowly for fifteen minutes to let the flavours infuse.</li><li>Once the caramel is ready, pour into a cake pan and swirl it around to evenly coat the bottom of the pan. Set aside.</li><li>In a bowl, crack the eggs and beat together. Slowly pour a little of the warm milk , vanilla and lime mixture into the eggs. This will temper the eggs and prevent them from scrambling from the heat. Once the temperature of the eggs has been raised by the warm milk, pour in the rest of the milk. Pour all of the mixture into the cake pan over the caramel.</li><li>Cook the cake pan in a water bath by placing the pan inside a larger pan which is filled half way with water. Place in the oven and cook for 45 minutes to an hour.</li><li>Once ready, allow to cool and place inside a fridge overnight. The flan is then ready to be flipped over gently and served.</li></ol>	mexican	45	8	t	f	t	f
288	Vegetarian Tamales	https://spoonacular.com/recipeImages/Vegetarian-Tamales---Mommie-Cooks-664720.jpg	<ol><li>Start off by soaking your corn husks in water for at least 30 minutes.</li><li>Grab a bowl and add in the masa, baking powder, 1/2 tsp of the salt, and 1 tsp of both the cumin, and chili powder.</li><li>Now add 2 cups of the veggie broth to your mixture and form a dough.</li><li>Pop your stick of butter into your mixer and whip it up for a minute or so.</li><li>Add the masa dough in and mix it up well again.</li><li>Set your finished dough aside and let's move on to the filling.</li><li>Grab your saute pan and cook up your zucchini, green onions, and garlic on medium heat in the tbsp of oil for 2 to 3 minutes.</li><li>Now add in the rest of your broth (1/4 cup), the cilantro, tomatoes, lime juice, and the remaining cumin, chili powder (1 tsp each) and salt (1/4 tsp).</li><li>Stir it together and add in the shredded cheese.</li><li>Are you ready to assemble cuz it's time! Grab up one of your soaked corn husks and slather a good amount of the masa mixture on top.</li><li>Now, take a spoonful of your veggie filling and place it down the middle third of your tamale. Make sure to leave a bit of space at the ends.</li><li>Wrap it up like you would a burrito and tie it off. I used another corn husk to tie it up.</li><li>Grab a big pot and steam those beautiful rolled up veggie delights for about 90 minutes on medium high heat. I didn't have a steamer that big, so I used my large stock pot and placed my noodle strainer inside of it with the pot cover over the top.</li><li>While the tamales are steaming, periodically check your water level to ensure you don't boil it all away!</li><li>Pull one out after 90 minutes and unwrap it to see if it's cooked through. The masa should be firm.</li></ol>	mexican	45	1	t	f	t	f
289	Mango Salsa	https://spoonacular.com/recipeImages/mango-salsa-716290.jpg	Peel and chop your mango into small cubes. Cube your bell peppers and onions as well and mix in with the mangoes. Add the cherry tomatoes and mix in.sprinkle your sugar and lime juice over it.Chop your scent/mint leaves and mix in and refrigerate.Serve cool as a side dish or if you want something refreshing on a hot day.	mexican	45	1	t	t	t	t
290	Chavrie Tabbouleh	https://spoonacular.com/recipeImages/Chavrie-Tabbouleh-637481.jpg	<ol><li>Place Bulgur wheat in a large bowl and pour the boiling water over and cover with aluminum foil or a large lid.</li><li>Let stand for 30 minutes until the liquid is absorbed</li><li>Mix in the remaining ingredients omitting the Chavrie Goat Log.</li><li>Season with salt and pepper and chill well</li><li>Dice the Chavrie Goat Log and fold into the mixture</li><li>Serving Suggestions:</li><li>Serve well chilled as part of a platter with the Chavrie Hummus Recipe</li><li>For an easy preparation follow directions on a package of instant Tabbouleh and fold in diced 4oz. Chavrie Goat Log</li></ol>	middleEastern	45	10	t	f	f	f
291	Chicken Shawarma Bowl	https://spoonacular.com/recipeImages/Chicken-Shawarma-Bowl-638316.jpg	<ol><li>Preheat oven to 400 degrees. Peel carrots. On a baking sheet toss carrots with olive oil. Add spices and toss. Place in oven and cook for 30 minutes, flipping at 15 minutes.</li><li>Meanwhile slice chicken breasts into 1/2 inch bite sized pieces. On a separate baking sheet, place chicken. Squeeze juice of 1/2 lemon over chicken. Add spices and toss until evenly distributed. Place chicken in oven and bake till chicken is cooked though, about 23 minutes. Once done, set aside and let rest.</li><li>As the chicken and carrots are cooking, prepare rice. Add olive oil to a medium pot on medium high heat. Add onion and garlic, stirring so garlic does not burn, and cook about 2 minutes. Add spices and stir to distribute evenly. Add rice, chicken broth and juice of 1/2 lemon. Bring to a boil and then cover and reduce to a simmer till rice is thoroughly cooked through, about 20 minutes.</li><li>Make Tzatziki: Stir together yogurt with dill, garlic powder and pepper. Place in refrigerator till ready to serve.</li><li>Serve: Place rice on bottom, then chicken. Add dollops of hummus and taziki on top of chicken.Sprinkle parsley and tomatoes on top. Scoop up with pita.</li><li>ENJOY!</li></ol>	middleEastern	45	4	f	f	f	f
292	Colorful Red Quinoa Not So Tabbouleh Salad	https://spoonacular.com/recipeImages/Colorful-Red-Quinoa-Not-So-Tabbouleh-Salad-639950.jpg	<ol><li>Wash the 1 cup of quinoa in a colander for several seconds. Add quinoa, water and salt to a small pot and boil for 15 minutes. You will know it is cooked when it becomes soft and you see little white antennas pop from the grain.</li><li>Meanwhile, wash all your veggies well and chop and dice them accordingly.</li><li>Add all the veggies to a medium glass bowl and toss. In a small bowl mix the red wine vinegar, olive oil and all the spices and blend well. Add the vinagrette to the salad and enjoy.</li></ol>	middleEastern	30	4	t	t	t	t
293	Easy Tabouleh	https://spoonacular.com/recipeImages/Easy-Tabouleh-642121.jpg	<ol><li>Chop the vegetables and parsley finely. The restaurant version has the veggies diced fairly small and I wanted to stay true to that.</li><li>Rinse the cracked wheat in a fine mesh sieve and let drain.</li><li>Combine all ingredients in a large bowl.</li></ol>	middleEastern	45	1	t	t	f	t
294	Falafel Burger	https://spoonacular.com/recipeImages/Falafel-Burger-642539.png	<ol><li>Pat the chickpeas dry with a paper towel and throw them into a food processor along with the garlic.</li><li>Puree until smooth.</li><li>Using your clean hands incorporate tahini, sriracha, parsley and onion into the chickpea mixture.</li><li>Form mixture into four patties and set aside.</li><li>Heat peanut oil in a large skillet over medium heat.</li><li>Once the oil begins to shimmer add the patties and cook for three minutes per side or until golden brown.</li><li>Remove from and place in a hamburger bun.</li><li>Top each burger with 2 slices of tomato, 2 slices of cucumber and a dollop of tzatziki.</li><li>Serve immediately.</li></ol>	middleEastern	45	4	t	f	f	t
295	Falafel Burgers	https://spoonacular.com/recipeImages/Falafel-Burgers-642540.jpg	<ol><li>Combine the chickpeas, onion, garlic, parsley, flour, spices, and salt, and pulse until the mixture is well combined. Form the mixture into 4 large patties.</li><li>Heat the oil in a large, nonstick skillet set over medium-high heat. Cook for about 3 minutes per side.</li><li>Make the tahini sauce: Whisk the tahini paste with the water, lemon juice and zest, salt, and freshly ground black pepper in a mixing bowl.</li><li>Serve the burgers in pita pockets or on a bun. Top them with tahini sauce, lettuce, and tomato.</li></ol>	middleEastern	45	4	t	t	f	t
296	Indian-Inspired Falafel Appetizer	https://spoonacular.com/recipeImages/Falafel-With-An-Indian-Twist-642547.jpg	<ol><li>Clean and wash the garbanzo beans, black eyed peas and green gram. Soak the lentils overnight/ 6-8 hours in excess water. Drain and set them aside.</li><li>Grind them to a coarse paste in a grinder without water. Mix in all the ingredients and let the mixture sit for 1-2 hours in refrigerator. Bring them down to room temperature and roll them into small balls using a falafel scoop or a spoon or a small ice cream scoop and place over a baking sheet covered with a parchment paper.</li><li>Heat 3 inches of oil in a deep cooking vessel (375 degrees) . Once the oil gets heated up, first fry 1 ball and if the balls lose shape, add little more flour for maintaining the shape.</li><li>Fry them in batches of 6 at a time for 2-3 minutes on one side or until they turn golden brown. Drain excess oil and serve with a salad/pita bread/tahini sauce.</li></ol>	middleEastern	45	12	t	t	f	t
297	Grilled Fattoush	https://spoonacular.com/recipeImages/Grilled-Fattoush-645704.jpg	<ol><li>Preheat the grill to high. Halve the zucchinis length-wise and cut the peppers into large chunks and remove seeds.</li><li>Separate the layers of the pitas to make 6 pita circles.</li><li>Drizzle olive oil over the zucchini, peppers, and pitas, and salt and pepper them. Roll them around, to make sure they have a good coat of oil. Grill the veggies for about 2-3 minutes per side, until nice grill marks have formed and the veggies are slightly tender. Then grill the pitas, for 1 minute per side, until toasty.</li><li>In a large serving bowl, add all the other veggies and herbs.</li><li>Once the grilled veggies have cooled, chop them into  inch cubes and add them to the serving bowl.</li><li>Break the pitas into bite-size pieces and add to the mix. Toss the salad and sprinkle the feta over the top.</li><li>Mix  cup of olive oil and the juice of one lemon in a small bowl. Season with cumin, salt and pepper and whisk. Drizzle over the salad when ready to serve!</li></ol>	middleEastern	45	6	t	f	f	f
298	Izmir Kofte	https://spoonacular.com/recipeImages/Izmir-Kofte-648306.jpg	<ol><li>Heat the oven to 175 degrees Celsius or 350 degrees Fahrenheit.</li><li>Make the sauce first. Melt the butter in a small saucepan. Stir in the tomato paste, then add the tomatoes and water or stock. Season with salt and pepper. Bring the mixture to a boil. Let simmer, stirring occasionally, while you make the kfte so that the tomatoes boil down.</li><li>Combine the ground lamb or beef, onion, garlic, eggs, paprika, cumin and parsley in a large bowl. Season with salt and pepper. With moistened hands, mix the ingredients for about 2 minutes. Keep a bowl of warm water nearby to wet your hands while working. Shape the meat mixture into 20-25 oval balls.</li><li>Heat the oil in a large skillet over high heat, add the kfte and lightly brown the meat all over (about 5 minutes). Place the kfte in an ovenproof dish and set them aside.</li><li>Pour the tomato sauce over the kfte. Arrange the green peppers on top. Cover the dish and bake for 40 minutes. To check for doneness, cut one kfte open; it should be brown, not pink.</li><li>Serve with fried potatoes or rice and salad.</li></ol>	middleEastern	45	6	f	f	t	f
299	Jordanian Mansaf	https://spoonacular.com/recipeImages/Jordanian-Mansaf-648615.jpg	<ol><li>IN A LARGE POT BEFORE TURNING ON HEAT MIX IN ALL YOGuRT</li><li>ON HIGH HEAT BRING YOGuRT (Or Jameed) TO A BOIL. (VERY IMPORTANT) MAKE SURE WHILE BRINGING YOGuRT TO BOIL, YOU ARE CONSTANTLY STIRRING YOGART WITH A WOODEN LADLE ONE WAY ONLY. SO IF YOU STARTED STIRRING TO THE LEFT YOU MUST KEEP STIRRING THAT WAY UNTIL YOGurT STARTS TO BOIL.</li><li>ONCE YOGuRT BOILS TURN HEAT OFF.</li><li>IN ANOTHER POT COVER lamb shanks or CUT UP LAMB (WITH BONES) WITH WATER.</li><li>ADD 1/4 OF AN ONION.</li><li>BOIL UNTIL LAMB IS TENDER.</li><li>REMOVE LAMB AND STRAIN WATER (LAMB BROTH) TO REMOVE ANY SMALL PARTICALS.</li><li>ADD ABOUT 2-3 CUPS OF THE WATER (LAMB BROTH ) TO THE POT OF COOKED YOGART.</li><li>Add salt to taste and if not tart enough you may add juice from about 1/2 a lemon.</li><li>Add lamb meat to the yogart and broth mixture (make sure to remove the onion)and let boil one more time.</li><li>Cook rice with 1 cup of butter</li><li>Brown almonds and pine nuts in remaining butter.</li><li>Once rice is cooked remove it from pot and place it in a large round platter, then spread half of the nuts on top of rice, then place lamb meat over rice and nuts, then spread remaining nuts over entire platter</li><li>Place the cooked yogurt in a large serving bowl</li><li>When serving put Arabic bread and wet it with some yogurt, then add rice and meat in individual plates and spread cooked yogurt and slivered nuts over it.</li><li>Enjoy</li></ol>	middleEastern	45	6	f	f	f	f
300	Kick Butt Baklava	https://spoonacular.com/recipeImages/Kick-Butt-Baklava-648865.jpg	<ol><li>Do:</li><li>Preheat the oven to 350 degrees.</li><li>Butter your pan... I used my small Mario Batali loaf pan. Note: this recipe makes a very small baklava so keep that in mind when choosing your pan. That or just double/triple it to make it in a bigger pan.</li><li>In a bowl, combine the walnuts and cinnamon and mix together.</li><li>Unroll phyllo dough and cut it to match your pan length. I say this because the Mario Batali pan that I used was long and quite narrow; it's about 2 inches wide.</li><li>Lay two sheets of phyllo into the bottom of your pan. Sprinkle some of your walnut cinnamon mixture on top; just enough to cover the phyllo. Repeat layers until all ingredients are used, finishing with a phyllo dough layer.</li><li>Using a sharp knife, cut the uncooked baklava into 1 1/2 to 2 inch pieces. Again, adapt this depending on what kind of pan you are using.</li><li>Put your pan into your oven and bake for 30-35 minutes, until golden and crispy.</li><li>While your baklava is cooking, prepare your 'sauce'.</li><li>In a pan on the stove, combine sugar and water and bring to a boil.</li><li>Stir in agave nectar, vanilla and lime zest, reduce heat and simmer for about 15 minutes. Note: keep an eye on it and stir continually so you don't get a sticky gross mess in the bottom of your pan.</li><li>When baklava is done in the oven, remove and immediately pour the 'sauce'on top. It will simmer something crazy against the hot baklava pan. That's ok. Pour it on and then leave it alone. That means let it sit until it's cooled.</li></ol>	middleEastern	45	1	f	f	f	t
301	Lamb Kofta	https://spoonacular.com/recipeImages/Lamb-Kofta-649219.jpg	<ol><li>Combine lamb mince, egg, breadcrumbs and garam masala. Shape into 24 meatballs.</li><li>Heat oil in large pan on high. Fry meatballs 8-10 minutes turning them occasionally. Remove from pan.</li><li>Saute garlic and ginger in pan. Add curry powder and cook 1 minute. Reduce heat to low, then add tomatoes with their liquid. Simmer for 2-3 mins.</li><li>Add meatballs and heat through for about 5 mins.</li><li>Serves 4</li></ol>	middleEastern	45	1	f	f	f	t
302	Lebanese Falafel	https://spoonacular.com/recipeImages/Lebanese-Falafel-649407.jpg	<ol><li>In a food processor combine all ingredients and pulse until smooth. Place in a sealable container and refrigerate for at least one hour.</li><li>Preheat oven to 400. Spray a cookie sheet with cooking oil, set aside.</li><li>Scoop two tablespoons of mixture and roll with your hands to create a ball. Place on prepared cookie sheet. Repeat for all the mixture. Makes about 12 equally sized falafel balls.</li><li>Brush falafel with olive oil and bake in the oven for 20 minutes. You can opt to broil them for an additional 2 minutes to brown the tops.</li><li>In the meantime combine all ingredients for the lemon tahini sauce in a small bowl. Whisk until smooth; set aside.</li><li>To assemble spread tzatziki over four warmed pitas. Top with three falafel ball, diced tomato, red onion, cucumber and lettuce. Drizzle with lemon tahini sauce and sprinkle with feta cheese and tabouleh. Fold the pita and secure with tin foil. Serve warm.</li></ol>	middleEastern	45	4	f	f	f	f
303	Lebanese Tabouleh	https://spoonacular.com/recipeImages/Lebanese-Tabouleh-649411.jpg	<ol><li>Remove stems from parsley and mint. Rinse leaves in a colander. Pat dry with paper towel.</li><li>In a food processor pulse parsley and mint until finely chopped. Transfer to a large mixing bowl.</li><li>Add green onions, tomatoes and bulgur wheat; stir to combine.</li><li>Toss with lemon juice and olive oil. Refrigerate for an hour before serving.</li><li>Serve on its own or with pita bread</li><li>Serves 2</li></ol>	middleEastern	45	2	t	t	f	t
304	Lettuce-Less Fattoush Salad With Grilled Chicken	https://spoonacular.com/recipeImages/Lettuce-Less-Fattoush-Salad-With-Grilled-Chicken-649970.jpg	<ol><li>Season your chicken cutlets (3 per person) or chicken breasts (2 per person) with salt and pepper. Squeeze lemon juice and drizzle olive oil over the chicken and mix until coated. On a hot grill pan, grill the chicken. Let cool and cut into strips. Set aside.</li><li>Stack your 3 whole wheat pitas and chop them into 2-inch pieces. Set aside.</li><li>Prep your vegetables and herbs and mix them in a bowl. Season with salt and pepper. When it's time to serve the salad, squeeze the juice of half a lemon and drizzle 2-3 tablespoons of your olive oil and mix the salad until the vegetables are fully coated in the dressing.</li><li>Preheat your oven's broiler. Spray cooking spray onto a non-stick baking sheet. Spread your pieces of pita over the sheet and spray those pieces with cooking spray. That way you have the pieces lightly coated in oil on both sides. Add to your oven and broil for 3-4 minutes (or less depending on your oven's broiler). Flip the pieces over and broil again for 3-4 more minutes. The pita chips should be nice and crispy.</li><li>Add your salad to a plate and cover with pita chips and chicken. Garnish with a few sprigs of parsley.</li><li>I highly recommend toasting whole-wheat pita chips (the ones I used had flax seed) as a healthy alternative to croutons!</li></ol>	middleEastern	45	2	f	f	f	t
305	Moroccan kofte and sausage stew	https://spoonacular.com/recipeImages/Moroccan-kofte-and-sausage-stew-652427.jpg	<ol><li>Mix the beef, onion, chili, spices and the chopped coriander leaves.</li><li>Add the egg and salt, mix and combine.</li><li>Form small meatballs about the size of a walnut (approximately 26 meatballs).</li><li>Fry the meatballs and the sausage in olive oil in a large frying pan until browned all over (you may need to do this in batches).</li><li>Scoop out, then add the harissa* and cook for a minute.</li><li>Add the tomatoes, chicken stock and cinnamon. Simmer for 15 minutes.</li><li>Return the meatballs and sausage and simmer for another 20 minutes, until cooked.</li><li>Stir through the rest of the coriander to finish.</li><li>*Harissa:</li><li>Soak the dried chilies in hot water for 30 minutes. Drain. Remove stems and seeds.</li><li>In a food processor blend chili peppers, garlic, salt, and olive oil.</li><li>Add remaining spices and blend to form a smooth paste.</li><li>Drizzle a small amount of olive oil on top to keep fresh.</li><li>Store in airtight container and keep for a month in the refrigerator.</li></ol>	middleEastern	45	8	f	f	t	t
306	Quinoa Tabbouleh Salad	https://spoonacular.com/recipeImages/Quinoa-Tabbouleh-Salad-657686.jpg	<ol><li>Bring water to a boil in a medium saucepan. Add quinoa and stir. Cover and reduce heat. Allow quinoa to simmer on medium-low heat until all water is cooked off, about 20 minutes. Stir occasionally. Be careful not to burn your quinoa. Allow to cool.</li><li>Place cooled quinoa into a large bowl (preferably something with an airtight lid).</li><li>Add all remaining ingredients and gently stir until very well-mixed. Cover and refrigerate for at least an hour.</li><li>Stir again before serving.</li><li>Can be stored, covered, in the refrigerator for two or three days. But it's best on the first day, when the veggies are still fresh and crisp!</li></ol>	middleEastern	45	8	t	t	t	t
307	Turkey Kofta Pitas	https://spoonacular.com/recipeImages/Turkey-Kofta-Pitas-664037.jpg	<ol><li>Mix the ground turkey with the yellow onion, garlic, cumin, coriander, turmeric, parsley, egg, 2 tbsp olive oil, salt, and pepper. Make sure they are evenly distributed. Make into 1 inch thick patties. Add olive oil to frying pan over medium high heat. Once hot, place some of the turkey patties and cook 4 minutes per side. Cook in batches until all are finished. Set aside.</li><li>Meanwhile, make tzatziki. In a small bowl, add Greek yogurt, dill, lemon juice, and pepper. Refrigerate until ready to use.</li><li>To make pitas, place 2 turkey patties into each pita pocket half. Add  a tomato, a few slices of red onion, some parsley, tzatziki and hummus. Enjoy!</li></ol>	middleEastern	45	4	f	f	f	f
308	Winter Fattoush Salad	https://spoonacular.com/recipeImages/Winter-Fattoush-Salad-665378.jpg	<ol><li>Toast the pita: Preheat the oven to 350F. Whisk the oil, zaatar and salt in a small bowl.  Lay the pita bread on a baking sheet and brush both sides with the oil. Bake until crisp, 5 to 7 minutes. When cool enough to handle, tear pitas into bite-size pieces. There should be about 2 cups.</li><li>Make the lentils: Saute the onions and oil in a small skillet until onions soften and begin to brown. Add the lentils and stir to blend. Stir in the garlic and parsley and remove from heat. Season with salt and pepper.</li><li>Cut away the thickest part of the kale and cabbage ribs and discard, then roll the leaves into bundles and shred. Trim the cucumber ends, then cut lengthwise into -inch slices. Stack the slices and cut crosswise into shreds. Repeat with the radishes. Tear whole leaves from parsley and/or mint.</li><li>Make the dressing: Whisk the dressing ingredients in a bowl until fully combined. You can also use a handheld blender.</li><li>Compose the salad: Toss the salad ingredients in a large bowl. Add the lentils and pita crisps. Drizzle with the dressing and toss again. Mound the salad on a serving platter. Top with feta cheese and sprinkle with sumac.</li></ol>	middleEastern	45	6	t	f	f	f
309	Baklava From Turkey	https://spoonacular.com/recipeImages/baklava_from_turkey-68401.jpg	None	middleEastern	94	1	f	f	f	f
310	A Southern Belle Visits Provence (Shrimp and Grits Provencal Style)	https://spoonacular.com/recipeImages/A-Southern-Belle-Visits-Provence-(Shrimp---Grits-Provencal-Style)-631916.jpg	<ol><li>Pour the boiling water into a heated sauce pan and stir in the salt, onion powder, grits and Herbs de Provence.</li><li>Bring to a boil and reduce heat to a simmer and cook for 15 minutes</li><li>While grits are cooking prepare the shrimp</li><li>When the shrimp go into the saut pan add the cheese to the grits and stir well; lower heat to just keep warm</li><li>Saut onion until clear in the olive oil</li><li>Add the spinach and mix well</li><li>Cover and continue cooking over medium/low heat until wilted</li><li>Clean and devein the shrimp</li><li>Prepare a pesto using the basil leaves, sun dried tomatoes, garlic, olive oil and salt</li><li>Heat I tablespoon butter in saut pan until bubbling then add the shrimp</li><li>Cook for 2 minutes add the remainder of the butter and cook for 2 minutes</li><li>Add the pesto and lemon; coat the shrimp well</li></ol>	southern	45	4	f	f	t	f
311	Almond Sandies	https://spoonacular.com/recipeImages/Almond-Sandies-632178.jpg	<ol><li>In a mixing bowl, cream butter and sugar. Add extract; mix well. Combine flour, baking soda, baking powder and salt; gradually add to creamed mixture. Fold in almonds. Drop by rounded teaspoonfuls onto ungreased baking sheets. Bake at 300 degrees for 22-24 minutes or until lightly browned. Cool 1-2 minutes before removing to a wire rack.</li><li>Yield: about 4dozen.</li><li>NOTES : "'Buttery, rich and delicious, Almond Sandies are my husband's favorite cookie and very popular where ever I take them,' remarks Joyce Pierce of Caldonia, Michigan."</li></ol>	southern	45	1	f	f	f	t
312	Almond Toffee Bars	https://spoonacular.com/recipeImages/Almond-Toffee-Bars-632197.jpg	<ol><li>1. Preheat oven to 350 degrees (325 if using glass dish)</li><li>2. In a medium bowl, combine flour and icing sugar, cut in margarine until crumbly. Press firmly on the bottom of 13X9 in baking pan. Bake 15 minutes.</li><li>3. Meanwhile, in a large bowl combine condensed milk, egg, and almond extract</li></ol>	southern	45	1	f	f	f	f
313	Auntie Naynay's Spicy Greens	https://spoonacular.com/recipeImages/Auntie-Naynays-Spicy-Greens-633048.jpg	<ol><li>Take the collard greens and separate the leaves (if fresh). Rinse each leaf individually under cold running water. After you rinse the collard greens thoroughly, stack several leaves on top of each other. Roll these leaves together. Then slice the leaves into thin strips using a cutting board and large knife. Rolling them together speeds up the process as you are slicing through several leaves at once.  With Kale and Mustard Greens, just break off the stem and breakup with your hands, after a thorough rinse.  Set aside.</li><li>Combine water, onions, seasoned salt, red pepper flakes and olive oil in a large pot.  Bring it to rolling boil, the lower the heat halfway.  Cook for 5 minutes.  Then add the greens to the pot until full, cover, and let it cook down (2 minutes) then add the rest of the greens.  Cover, turn the heat down just a little and let it cook - stirring every few minutes for about 45 minutes or to the tenderness you prefer.  Add a little water if needed during cooking.</li></ol>	southern	45	6	t	t	t	t
314	Baked Fried Chicken With Cauliflower Mash	https://spoonacular.com/recipeImages/Baked-Fried-Chicken-With-Cauliflower-Mash-633624.jpg	<ol><li>For marinade:</li><li>Fillet chicken breast in half to make thinner pieces, and cut in half again to make smaller pieces.</li><li>Whisk all marinade ingredients (except for the chicken) in large bowl.</li><li>Add chicken and coat in marinade.</li><li>Chill overnight for more intense flavor. But if you are short on time (which I usually am) it is ok to use right away as well.</li><li>For breading:</li><li>Preheat to 450F</li><li>Mix breading ingredients large bowl. Place wire rack on baking sheets. Remove chicken breast from bowl and place in coating mixture. Transfer to rack. Repeat with remaining chicken breasts.- Place chicken breasts on rack and spray with olive oil .</li><li>Bake chicken 20 minutes or until coating is browned and instant-read thermometer registers 155F.</li><li>For Cauliflower:</li><li>Cut up cauliflower in small pieces.</li><li>Place in large saut pan with about 1 cup of water (enough to cover the bottom of pan, plus a little extra to make sure it doesn't all evaporate)</li><li>Cook until tender.</li><li>Combine cauliflower with buttermilk, sour cream, ricotta and salt and pepper.</li><li>In batches, place in blender and puree until smooth. (if it is having a hard time blending, add either some chicken or vegetable stock, or even more buttermilk)</li></ol>	southern	45	6	f	f	f	f
315	Baked Sweet Potato Fries	https://spoonacular.com/recipeImages/Baked-Sweet-Potato-Fries-633837.jpg	<ol><li>Spray a 15 x 10 x 1 inch baking pan with nonstick coating. Scrub potatoes; cut lengthwise into quarters, then cut each quarter into 2 wedges. Arrange potatoes in a single layer in pan.</li><li>Combine margarine or butter, salt, and nutmeg. Brush onto potatoes. Bake in a 450 oven 20 minutes or until brown and tender.</li></ol>	southern	45	1	f	f	t	t
316	Banana Sponge Cake	https://spoonacular.com/recipeImages/Banana-Sponge-Cake-634190.jpg	<ol><li>In mixing bowl, whisk mashed banana, sugar, eggs, milk and SP at high speed till thick.</li><li>Lower speed add in banana essence and vanilla essence, then slowly add in plain flour.</li><li>Stop machine and use hand whisk to mix well.</li><li>Lastly pour in corn oil in 3 batches and mix well again.</li><li>Pour batter into a 9" (lined) square cake tin.</li><li>Bake in preheated oven at 170C for about one hour.</li><li>Place cake tin at the lowest rack of the oven and cover cake with foil if the topping is too brown after 40 mins of baking.</li></ol>	southern	45	1	t	f	f	f
317	BBQ Beef Brisket	https://spoonacular.com/recipeImages/BBQ-Beef-Brisket-634486.jpg	<ol><li>Trim any large, thick pieces of fat from the brisket (dont remove all of the fat because it keeps the meat moist during cooking and adds flavor)</li><li>Sprinkle brisket with salt and pepper.</li><li>Mix the onion powder, garlic powder, smoked paprika, cumin, and cayenne pepper together in a small bowl.</li><li>Dry rub both sides of the brisket with the seasoning mixture.</li><li>Heat oil in a pan over medium-high heat and sear the meat on both sides.</li><li>Remove from the heat and set aside.</li><li>Stir together the honey barbecue sauce and brown sugar.</li><li>Pour half of the sauce into the bottom of your slow cooker.</li><li>Place the brisket, fatty side up, into the slow cooker.</li><li>Cover the top o the brisket with the remaining sauce.</li><li>Cover the slow cooker and set heat to low for 9 hours, or until fork tender.</li><li>When the brisket is cooked, remove it carefully from the slow cooker and place it on a cutting board.</li><li>Pour the sauce from the slow cooker into a saucepan and let it cool.</li><li>Skim the fat that has risen to the top of the sauce in the large bowl.</li><li>It will appear lighter in color than the sauce, like droplets of oil on the surface. Skim as much fat as you can.</li><li>In a small bowl, stir together cornstarch and 1 tbs. of water till completely smooth.</li><li>Pour the cornstarch mixture into the bowl of sauce and stir to combine.</li><li>Reduce the sauce quickly in a saucepan on the stovetop by simmering it to 10 minutes.</li><li>Pour the sauce over the brisket and serve.</li><li>The leftovers make great BBQ sandwiches.</li><li>If you like crockpot food, be sure to check out some of my favorite recipes at www.mealdiva.com</li></ol>	southern	45	8	f	f	t	t
318	Boozy BBQ Chicken	https://spoonacular.com/recipeImages/Boozy-Bbq-Chicken-635675.jpg	<ol><li>DIRECTIONS:</li><li>Open beer start to drink.</li><li>Soak wooden skewers in a shallow dish filled with water. In a large glass or ceramic dish, mix orange juice, olive oil, wine, soy sauce, Sriracha or Tabasco sauce, molasses, garlic, ginger and pepper.</li><li>Cut orange, peppers, onion & broccoli into large bite-sized chunks (at least 1" thick) and place in the dish.</li><li>Add mushrooms and tomatoes.</li><li>Stir veggies in marinade to coat.</li><li>Cover and refrigerate while you prep chicken.</li><li>Warm outdoor grill to medium heat.</li><li>Rinse chicken and pat dry with paper towel (toss that towel!).</li><li>In small bowl mix mustard, salt and pepper. Brush chicken with mustard mixture.</li><li>Wash your hands and go stir those veggies so all sides absorb the marinade.</li><li>When beer is half empty, refill can with salad dressing and squeeze in juice from 1/2 lemon.</li><li>Put can on a disposable baking sheet. Place upright chicken on can like a stand, inserting can into cavity of chicken.</li><li>Place baking sheet with beer and chicken on the preheated grill.</li><li>Cover. Set your time for 1 hour.</li><li>Start on a second beer or that remaining white wine.</li><li>In a medium saucepan, pour rice, water, and 3-4 splashes of your beverage (about 1/4 cup) into medium sauce pan.</li><li>Bring to a boil, stir and reduce heat to low.</li><li>Cover with lid and cook for 25-30 minutes.</li><li>Back to the kebabs.</li><li>Remove veggies from fridge and using the sharp end of the skewer begin threading.</li><li>Distribute veggies evenly onto 6-8 skewers.</li><li>Check rice: It's done when all liquid is absorbed but before it starts sticking to the bottom of the pan.</li><li>Turn off heat under the rice and let it sit.</li><li>Go back to grill.</li><li>You should be at about an hour on the chicken.</li><li>Carefully slice in to see meat has gone from pink to white.</li><li>Remove from grill</li><li>Allow to cool for at least 15 minutes so you don't burn the hell out of yourself cutting it into pieces for your guest(s).</li><li>In the meantime throw those kebabs directly on the grill.</li><li>Flip them over after about 5 minutes to get the other side and allow to cook for another 5-8min.</li><li>Kebabs are done when veggies are al dente (softened but still firm).</li><li>Turn off grill and remove from heat.</li><li>Put rice in a serving dish, and chicken pieces and full skewers on a platter. Squeeze remaining lemon juice over chicken.</li><li>Let people serve themselves.</li><li>Eat, drink and be merry!</li><li>DW | Food and Drink</li></ol>	southern	45	6	f	f	f	t
319	Brandy Bread Pudding	https://spoonacular.com/recipeImages/Brandy-Bread-Pudding-635901.jpg	<ol><li>Preheat oven to 325. Put the raisins in a bowl, pour the brandy over them and let soak for 1/2 hour. Arrange the 8 slices of bread, which you have buttered on both sides, in a buttered baking dish. Bring the milk to a boil, remove from the heat and stir in the sugar until completely dissolved. With an electric mixer, beat the eggs and egg yolks; pour in the milk gradually and add the vanilla. In the baking dish pour the raisins and brandy over the </li></ol>	southern	45	1	t	f	f	f
320	Gluten Free and Flour-Less Bread with Collard Greens	https://spoonacular.com/recipeImages/Gluten-Free---Flour-Less-Bread-w--Collard-Greens-644791.jpg	<ol><li>Preheat your oven to 375 degrees. Begin by roasting the garlic, jalapenos and bell pepper. Leave the skin on the garlic cloves, wrap in tin foil and place wrapped garlic and all peppers on a cookie sheet; roast for 20 - 25 minutes, until veggies look puffy and skin is browned and flaying away from the flesh of the peppers.  A few minutes after putting the garlic and peppers in the oven, open both bags of collard greens, spread the greens over a cookie sheet and place in oven for 12 minutes with the roasting peppers in order to thaw the greens.</li><li>Remove the greens and roasted veggies from the oven; allow to cool. While cooling, crack the eggs into a large mixing bowl. Beat eggs, add the grapeseed oil and stir.  Once the greens are cool enough to handle, take large handfuls of the collard greens and squeeze all the water out of them over the sink. Once the water is squeezed out, put the handfuls in the mixing bowl with the egg.  Do this for all of the collards.</li><li>Using your fingers, remove the skin from the peppers, remove the seeds and chop into small pieces.  Remove the garlic cloves from the foil, remove the skin and coarsely chop the garlic.  Add chopped peppers and garlic to the mixing bowl with the collards and egg.  Add salt and crushed red pepper to the mixing bowl.  Using a fork, mix everything together until everything is coated with egg.</li><li>Line a baking sheet with parchment paper. Turn the collard mixture out on top of the parchment paper.  Using a fork, press mixture firmly into the parchment paper. There is enough in this recipe to cover a 12 x 17 baking sheet, though be prepared to do a lot of pressing in order to evenly disburse the mixture over the full sheet.</li><li>Bake in the oven for 30  35 minutes until the edges are just barely beginning to brown and the collards feel dry and firm to the touch.</li><li>Allow to cool and pulling the edges of the parchment paper, place on a chopping block. Chop the bread into desired sizes. This makes 12 decent sized squares. Use for sandwiches, paninis, personal-sized pizzas or eat plain as a snack.</li></ol>	southern	45	12	t	f	t	t
321	Herb chicken with sweet potato mash and sauteed broccoli	https://spoonacular.com/recipeImages/Herb-chicken-with-sweet-potato-mash-and-sauted-broccoli-646651.jpg	<ol><li> Preheat the oven to 350F (180C) or 320F (160C) for convection oven and cook the chicken according to the pack instructions.</li><li> About 15 minutes before the end of the chicken cooking time, place the diced potato into boiling water for 5 minutes, then add the sweet potato and cook until the potatoes are tender. Roughly mash, adding butter, salt, and pepper to taste, then mash thoroughly.</li><li> Heat the oil in a pan and quickly saut the broccoli until tender. Cover to keep warm.</li><li> Remove the chicken from the oven, leave to cool for a minute then cut the bag open and gently tip the contents into a dish.</li><li> Slice the chicken breasts into chunky pieces on a board, keeping the chicken breast shape together.</li><li> Serve the mash potato topped with the chicken and remaining sauce with a side of broccoli.</li></ol>	southern	45	4	f	f	t	f
322	How Sweet It Is Sweet Potato Lasagne	https://spoonacular.com/recipeImages/How-Sweet-It-Is-Sweet-Potato-Lasagne-647563.jpg	<ol><li>Slice the Sweet Potato into 1/4 inch thick slices. Boil until semi-cooked (about 10 min). Rub the slices with a dry curry powder & olive oil (1cup) mixture. Set aside and let marinate for at least 10 min.</li><li>Slice Eggplants into 1/4 inch thick slices and rub all over with an olive oil (1 cup)/dried basil/salt & pepper mix. Set aside and let marinate for at least 15 min.</li><li>Pour canola or vegetable cooking oil into a pan. Saute spinach and mushrooms for about 3-5 min, add in jalapenos and salt & pepper to taste.</li><li>Turn the heat down and add in some heavy cream and about 1/2 of the mexican cheeses until mixture is creamy, but not watery.</li><li>Start layering the lasagne in this order: Sweet Potatoes, Spinach/Mushroom Mix, Eggplants, Marinara Sauce, Sweet Potatoes, Spinach/Mushrom Mix, Eggplants, Then finally sprinkle the remaining Monterey Jack/Cheddar Cheese Blend on top.</li><li>Bake at 350-375 for about 35-45 min, depending on how your oven works. You'll know it's ready when you can pass through a fork easily through all the layers.</li><li>Devour with Passion</li></ol>	southern	45	6	t	f	t	f
323	Kale and Roasted Sweet Potato Soup with Chicken Sausage	https://spoonacular.com/recipeImages/Kale-and-Roasted-Sweet-Potato-Soup-with-Chicken-Sausage-648721.jpg	<ol><li>Place cubed sweet potatoes in a baking pan or dish. Season with salt and pepper and coat with olive oil.</li><li>Bake for 20  25 minutes, until soft. Remove from oven and set aside.</li><li>In a dutch oven over medium heat, warm some olive oil.</li><li>Cook the chicken sausage until just browned.</li><li>Add in onion and mushrooms and cook for about 3  5 minutes, until softened.</li><li>Add in garlic, thyme, coriander, some sea salt and black pepper. Stir in and cook for about 1 minute.</li><li>Pour in chicken stock and bring to a boil.</li><li>Reduce heat and simmer for about 5  10 minutes.</li><li>Add in roasted sweet potatoes and kale.</li><li>Push the kale down into the soup so its submerged. Cook for about 3  5 minutes, until bright green and tender.</li></ol>	southern	45	4	f	f	t	t
324	Lamb and Sweet Potato Stew	https://spoonacular.com/recipeImages/Lamb-and-Sweet-Potato-Stew-649190.jpg	<ol><li>In a bowl toss lamb with flour and salt and pepper to taste. In a 10-inch skillet heat oil over moderately high heat and saute garlic, stirring, 1 minute. Add lamb and brown, stirring, about 2 minutes. Add wine and boil 1 minute. Add water and cinnamon stick and scatter sweet potato on top.</li><li>Simmer stew, covered, about 30 minutes, or until lamb is tender, and season with salt and pepper.</li><li>Serves 2.</li></ol>	southern	45	1	f	f	f	t
325	Lentil, Sweet Potato and Spinach Soup	https://spoonacular.com/recipeImages/Lentil--Sweet-Potato-and-Spinach-Soup-649946.jpg	<ol><li>Let the dry beans soak for a 2-3 hours before you start the soup. When ready to cook, pour the water in a pot, let boil and add the onions and garlic. Add the lentils, peanut butter, and bay leaves when the water comes to a steady boil. Cover the pot and cut up the potatoes and carrots. Let the lentils cook for an hour or so, checking on it periodically (adding water is common). Then add the potatoes and carrots, along with various seasonings (curry, salt, pepper and cumin) and cover. Make sure to taste as go and let cook for about another 45 minutes to an hour. Turn off the flame and place a bunch of fresh spinach on the bottom of a bowl, pour in the soup and enjoy!</li></ol>	southern	45	6	t	t	t	t
326	Mashed Sweet Potato, Apple and Cotija Quesadillas	https://spoonacular.com/recipeImages/Mashed-Sweet-Potato--Apple-and-Cotija-Quesadillas-651245.jpg	<ol><li>Heat 1 tablespoon of oil in a medium saucepan and add onions and apples. Cook until they turn begin to brown, approximately 15-20 minutes.</li><li>As onions and apples cook, heat tortillas slightly in the oven (300 degrees for 10-15 minutes) or on the stove in a pan sprayed lightly with cooking spray. They should not get crispy, only warm.</li><li>In a small bowl, mash warm sweet potatoes, honey, 1 tablespoon butter, lime juice and zest, cumin, cilantro and red pepper flakes.</li><li>Spread a layer of sweet potatoes, onion-apple mixture and then crumble cheese on one half of the tortilla and fold over. (Resist the urge to overfill.) Using remaining 1 tablespoon of butter and 1 tablespoon oil, toast quesadillas on both sides until golden brown.</li><li>For a little added snazzle, whisk a bit of chili pepper, honey and lime juice together and drizzle on top.</li><li>We used Fujis. A crisp, sweet apple works best.</li></ol>	southern	45	3	f	f	t	f
327	Okra Tomato Side Salad	https://spoonacular.com/recipeImages/Okra-Tomato-Salad-653549.jpg	<ol><li>Remove ends of okra pods, discard. Slice okra.</li><li>Place okra in a basket and steam for five to seven minutes.</li><li>Roughly chop a tomato.</li><li>When okra is cooked, place in a bowl and toss with tomato.</li><li>Season with salt and pepper.</li><li>In a small bowl whisk basil into balsamic vinegar.</li><li>Drizzle over okra and tomato.</li></ol>	southern	45	1	t	t	t	t
328	Smoky Black Bean Soup With Sweet Potato and Kale	https://spoonacular.com/recipeImages/Smoky-Black-Bean-Soup-With-Sweet-Potato---Kale-660405.jpg	<ol><li>Spread the dry beans out on a baking sheet and pick out any pebbles. </li><li>Place the beans in a big soup pot, cover with water by 3 inches and allow them to soak overnight or for 6-8 hours, then discard that water. </li><li>Return the soaked beans to the pot and cover with 3 inches of water again, bring to a boil. Reduce heat to medium low, put the cover on and allow to cook until the beans start to get tender but still firm, about 1 1/2 hours. Drain the beans.</li><li>Heat the oil in a soup pot over med-high heat. </li><li>Add the onion along with a pinch of salt and saute until softened and golden. </li><li>Stir in 1 tbsp of ground cumin, add the beans along with the broth or water and bring to a boil. Reduce heat to medium-low, cover and cook for 30 min. </li><li>Meanwhile peel and chop the sweet potatoes. </li><li>Wash the kale, remove the stems and chop the leaves.</li><li>Remove half of the beans and liquid and set aside to cool a bit. </li><li>Add the sweet potatoes and kale to the pot with some salt and pepper. Cover and cook for 10 minutes. </li><li>Transfer the cooled beans to a blender and puree until smooth, then return them to the pot. </li><li>Stir in the remaining 1 tbsp of ground cumin. </li><li>Now add 1 tbsp of the chipotles in adobo. Taste and continue to add more until it has a spice level that you like. </li><li>Adjust the salt &amp; pepper as needed.</li><li>Serve with a dollop of sour cream.</li></ol>	southern	630	6	t	t	t	t
329	Southern Fried Catfish	https://spoonacular.com/recipeImages/Southern-Fried-Catfish-660697.jpg	<ol><li>Combine flour, cornmeal, garlic powder and salt. Coat catfish with mixture, shaking off excess. Fill deep pot or 12-inch skillet half full with oil. Heat to 350 degrees. Add catfish in a single layer, and fry until golden brown, 5 to 6 minutes, depending on size. Remove and drain on paper towels.</li></ol>	southern	45	6	f	f	f	t
330	Spicy Sweet Barbecue Sauce	https://spoonacular.com/recipeImages/Spicy-Sweet-Barbecue-Sauce-661205.jpg	<ol><li>In a medium saucepan, heat oil over medium heat. Add onion and garlic. Cook, stirring, until onion is soft and translucent, about 5 minutes.</li><li>Stir in tomatoes, chile, Worcestershire, vinegar, molasses, and lemon juice. Simmer over medium-low heat until reduced by a third, stirring occasionally, about 45 minutes.</li><li>Allow to cool slightly, then pure using an immersion blender (if you don't have one, you can pure the sauce in a blender, working with batches. Season with salt and black pepper. Refrigerate in a jar with tight-fitting lid for up to 2 weeks.</li></ol>	southern	45	1	f	f	t	t
331	Splendid Texas Caviar	https://spoonacular.com/recipeImages/Splendid-Texas-Caviar-661386.jpg	<ol><li>Mix together all of the ingredients and allow them to sit in the refrigerator for 5 hours or overnight (if you can).</li><li>It's best if you take the bean salad out of the refrigerator about an hour before serving to bring them to room temperature.</li></ol>	southern	300	3	t	t	t	t
332	Sweet and Sour BBQ Spare Ribs	https://spoonacular.com/recipeImages/Sweet-and-Sour-BBQ-Spare-Ribs-662442.jpg	<ol><li>Preheat oven to 250</li><li>In a bowl, whisk together ketchup, barbecue sauce, vinegar, brown sugar, mustard powder, garlic powder, and Worcestershire sauce. Salt and pepper to taste. Set aside.</li><li>In a large skillet, melt butter over medium high heat. Add ribs and brown on both sides. Place ribs, meat side down, in a 913 inch baking pan. Add diced onions to dish and cover with sauce.</li><li>Cover baking dish with tin foil and bake in the oven for 4  4  hours until meat is tender and easily falls off the bone.</li><li>serves 2-3</li></ol>	southern	45	2	f	f	t	t
333	Sweet Potato, Kale and White Bean Soup	https://spoonacular.com/recipeImages/Sweet-Potato--Kale---White-Bean-Soup-662604.jpg	<ol><li>In a large pot, heat the grapeseed oil over medium high and add the sweet potato. Saut the sweet potato, stirring consistently about 5 minutes before adding the onion. Saut about 8 minutes then add a splash of chicken broth to help steam the sweet potato and onion (the chicken broth should sizzle when it hits the pot). Continue cooking until sweet potato is softened but still al dente, another 5 minutes or so.</li><li>Add all of the chicken broth, white wine, cannellini beans and the oregano and thyme. Stir well and bring to a boil. Reduce heat to medium low and simmer covered about 10 minutes. Add the chopped kale leaves, stir, cover again and cook another 5 minutes until kale leaves are softened. Taste the soup and add salt and ground black pepper to taste.</li></ol>	southern	45	4	t	t	t	t
334	Dutch Oven Paella	https://spoonacular.com/recipeImages/Dutch-Oven-Paella-631747.jpg	<ol><li>Adjust oven rack to lower middle position and heat oven to 350. In a med bowl, toss shrimp with 1 t. minced garlic, 1 T. olive oil, 1/4 t. salt &amp; 1/4 t. pepper. Refrigerate until needed. Season chicken with salt &amp; pepper, set aside.</li><li>Heat 2 t. oil in a large Dutch oven over med-high heat until oil shimmers, add bell pepper and cook, stirring occasionally until skins blister and brown about 3-4 minutes. Remove to a plate and set aside. Add 1 T. more oil to the pot, add chicken thighs and brown well, flipping once, about 3 minutes per side. Remove chicken to a bowl, reduce heat to medium, add sausage and cook 4-5 minutes, stirring frequently, until browned and fat starts to render. Add to bowl with the browned chicken.</li><li>3. At medium heat, add enough oil to the pot to equal 2 T., add onion and cook, stirring frequently, until tender, about 3 minutes, add remaining garlic, cook for 1 minute, add tomatoes, cook and stir until tomatoes thicken and darken slightly about 3 minutes. Add rice, cook and stir for about 2 minutes, making sure everything is evenly mixed. Add broth, wine, saffron, bay leaf and 1/2 t. salt. Add the browned chicken and sausage. Increase heat to med-high, bring to a boil, stirring often. Cover pot and place in the oven. Bake for 15 minutes (liquid should be mostly absorbed). Remove pot from the oven (keep oven door closed to retain heat), remove the lid, nestle the artichoke hearts down in the rice a bit. Sprinkle the shrimp over the top of the rice, then, sprinkle with the peas and bell pepper strips. Replace the led, add back to the oven for another 10 minutes or until the shrimp are opaque.</li><li>Turn stove burner to med-high heat. Remove the pot from the oven, place on the stove cook for 5 minutes to get the browned portion on the bottom of the rice (called Soccarat), rotating the pot 180 degrees halfway through to ensure even browning. Remove pot from heat and let the paella rest, covered, for 5 minutes. Sprinkle with fresh chopped parsley and lemon wedges.</li></ol>	spanish	45	6	f	f	t	t
335	Basque Paella	https://spoonacular.com/recipeImages/Basque-Paella-634454.jpg	<ol><li>Calories per serving: 221. Preparation time: 35 minutes. Cooking time: 45 minutes.</li><li>1. In large, heavy skillet over medium-high heat, combine oils and cook chicken pieces until just opaque. Remove chicken to platter. Reserve skillet.</li><li>2. Soak rice in the boiling water for 10 minutes, then drain.</li><li>3. In reserved skillet saute onion over medium heat until soft (about 5 minutes). Add garlic, bell peppers, and tomato and continue sauteing for 5 more minutes.</li><li>4. Add snapper, soaked rice with water, stock, salt substitute, saffron, and oregano. Bring to a boil, then lower heat to medium. Cover pot and let simmer until rice is tender and has absorbed liquid (about 15 minutes).</li></ol>	spanish	45	1	f	f	t	t
336	Clams With Spanish Sausage	https://spoonacular.com/recipeImages/Clams-With-Spanish-Sausage-639557.jpg	<ol><li>Scrub clams and remove any that are not closed or that have a bad smell.</li><li>Heat olive oil in a pot and sweat the garlic.</li><li>Slice the chorizo and add it to the garlic and olive oil to brown.</li><li>Add fingerling potatoes split lengthwise. Stir in fat from chorizo and cook on medium heat until slightly borwned. Add a small amount of wine to avoid burning and to release drippings from bottom of pot.</li><li>Add remainder of wine, reduce to a simmer and cover for about 10 minutes, until potatoes are cooked and soft.</li><li>Add clams, raise heat to a low boil, and cover for another 10 minutes. Cook until all the clams open up.</li><li>Sprinkle with chopped parsley and serve.</li></ol>	spanish	45	4	f	f	t	t
337	Corn Flan Side Dish	https://spoonacular.com/recipeImages/Corn-Flan-640085.jpg	<ol><li>Preheat the oven to 325 degrees. Grease four 1-cup capacity ramekins and set them aside.</li><li>In a blender or food processor, combine 1 cup of corn kernels with 1/2 cup of milk. Puree until smooth, and repeat with the remaining corn and milk.</li><li>In a large mixing bowl, ideally one with a handy pouring spout if you happen to have one of that type available to you, combine the corn puree, ricotta, Pecorino-Romano, and eggs. Mix them up well, and season with salt and pepper. Now pour the mixture into the greased ramekins, leaving a half-inch of custard-free space leading up to the top edge of the ramekin to allow for expansion.</li><li>The most difficult thing about this recipe may be having to tell your loved ones that you're utilizing a bain-marie, and then explaining what a bain-marie is. Set your ramekins into a lasagna pan or roasting pan. Carefully pour in enough water so that the water level is half the way up the sides of the ramekins. Too much more, and you run the risk of water sneaking into your custards, and we don't want that. This is your bain-marie, or water bath, in which you will cook the custards for 55 minutes to one hour, until a knife inserted into the custard emerges clean. Carefully remove the bain-marie from the oven - we don't want any splashing on the exit from the oven, either - and allow to cool for 5 to 10 minutes. The custards may be served warm or at </li></ol>	spanish	45	4	f	f	t	f
338	Easy Chicken, Kielbasa and Shrimp Paella	https://spoonacular.com/recipeImages/Easy-Chicken--Kielbasa-and-Shrimp-Paella-641911.jpg	<ol><li>Heat the oil in a 12-inch skillet over medium heat. Add the rice and cook for 30 seconds, stirring constantly. Stir the broth, picante sauce and turmeric in the skillet and heat to a boil. Reduce the heat to low. Cover and cook for 15 minutes.</li><li>Stir the kielbasa, shrimp and chicken in the skillet. Cover and cook for 5 minutes or until the rice is tender.</li></ol>	spanish	45	8	f	f	t	t
339	Kiwi Strawberry Flan	https://spoonacular.com/recipeImages/Kiwi-Strawberry-Flan-648967.jpg	<ol><li>To make shell, prepare cake mix according to package directions and pour batter into flan pan that has been sprayed with Pam. Bake in a preheated 350 degree oven for about 25 minutes. Cool 10 minutes; remove from pan. Using milk and cream, prepare pudding according to package directions. Pour into cooled flan shell. Top with kiwi fruit. Chill until firm. Just prior to serving, top kiwi with strawberries. Garnish with small amount of whipped </li></ol>	spanish	45	1	t	f	f	f
340	Leche Flan (Caramel Flan)	https://spoonacular.com/recipeImages/Leche-Flan-(Caramel-Flan)-649419.jpg	<ol><li>Making the Caramel Syrup:Simply put 2 tablespoons of white sugar for each mould, and hold the mould over medium heat, allowing the sugar to dissolve. Swirl the mould gently to evenly distribute the caramel to coat the mould. Make sure not to burn the caramel as this would make it bitter. A pale brown color is what you should achieve. Set each aside to cool down.</li><li>Making the Custard:In a mixing bowl, combine all the ingredients namely the egg yolks, vanilla extract, white sugar, condense and evaporated milk. Make sure you include as little egg white as possible to the mixture. This will make your flan creamier and bubble-free.</li><li>Use a whisk to mix the ingredients thoroughly, making sure the sugar has been completely dissolved.</li><li>Pour the mixture in the moulds. Fill each up at least just half high as the mould, because the mixture is expected to expand once it's steamed.</li><li>Cover each mould with an aluminum foil to avoid the moisture from the steam to come in contact with the flan. This will cause it to become watery.</li><li>Steam cook for around an hour at steady heat. It is essential that you do not change the amount of heat as this might cause uneven cooking.</li><li>Check every now and then whether the flan is already ready or not, with the use of a fork. Just gently poke the flan with the fork and you will know it's ready if nothing sticks to the fork as you pull it out.</li><li>Once you achieve this, remove the moulds from the steamer right away and let it cool at room temperature. Avoid overcooking the flan as this will make it hard and dry.</li><li>Once the flans have cooled down, refrigerate for at least an hour before serving.</li><li>Upon Serving:Unmould the Leche Flan by running a knife around the edge of the mould, carefully inverting it onto a serving dish, allowing the caramelized sugar coat the flan. Serve and enjoy!</li></ol>	spanish	45	3	t	f	t	f
341	Leek Flan	https://spoonacular.com/recipeImages/Leek-Flan-649441.jpg	<ol><li>Butter 6 (4-ounce) ramekins and place in the refrigerator. When the butter hardens, add a second coating of butter to the ramekins. Set aside. Heat the oven to 350 degrees.</li><li>Heat the olive oil in a medium skillet over low heat. Add the leeks, shallots and salt and cook until the leeks are translucent but still retain a bite, about 10 minutes. Drain.</li><li>Place the whipping cream and half-and-half in a medium saucepan and bring to a boil. Turn off the heat and cool.</li><li>Put the leek mixture in the blender along with the cream mixture and the egg whites. Blend until smooth, about 30 seconds.</li><li>Spoon the mixture into the prepared ramekins. Place the ramekins in a large baking pan. Pour boiling water into the pan until it reaches halfway up the sides of the ramekins. Place the pan in the oven. Bake until the flans are set, about 35 to 40 minutes.</li><li>To serve, unmold the flans and garnish with 2 (3-inch) pieces of chives crossed over the top.</li><li>This recipe yields 6 servings.</li></ol>	spanish	45	6	f	f	t	f
342	Mixed Paella	https://spoonacular.com/recipeImages/Mixed-Paella-652134.jpg	<ol><li>I a very large non-stick skillet or paella pan preheated over medium-high heat, add 2 teaspoons of your oil (you will need more oil if you're not using non-stick), garlic, red pepper flakes and rice. Saute for about 3 minutes. Add saffron, thyme, bay leaf and broth and bring to a boil. Cover and reduce heat to a simmer. Leave covered, do not stir.</li><li>In another non-stick skillet, heat to medium-high. Add chorizo and crumble as you saute. When the sausage is cooked through, add red pepper and onion. Salt and pepper to taste if needed. Saute until the onion is tender and remove from heat, set aside.</li><li>When the rice is nearly done (about 15 minutes) add fish and shrimp and press into rice. Add mussels, peas and sprinkle with lemon zest. Cover and continue to simmer until the rice is done and the mussels have opened. Discard any that do not.</li><li>Top with chorizo mixture and parsley. Serve with lemon wedges and a crusty bread.</li></ol>	spanish	45	8	f	f	t	t
343	My Simple Custard Flan (Filipino Leche Flan)	https://spoonacular.com/recipeImages/My-Simple-Custard-Flan-(-Filipino-Leche-Flan)-652885.jpg	<ol><li>In a pan, mix water and sugar until there is no lump.</li><li>Heat and wait until it boils then turn the heat to simmering mode.</li><li>Simmer until the caramel is thick.</li><li>Cool slightly and transfer to aluminum moulds.</li><li>Mix well the egg yolk, condensed milk and evaporated milk by hand.</li><li>Then add vanilla and lemon juice.</li><li>Use wooden spatula and mix gently until well combined.</li><li>Strain the mixture and gently pour on to the prepared moulds with caramel.</li><li>Fill only until  3/4 of the moulder.</li><li>Cover with aluminum foil and place the moulds on a larger baking pan half filled with very hot water.</li><li>Bake at 350 or 180 for 1 hour.</li><li>Cool and then set aside in the fridge.</li><li>To serve: run a thin knife around the edges of the mould to loosen the Leche Flan. Place a platter on top of the mould and quickly turn upside down to position the golden brown caramel on top.</li></ol>	spanish	45	4	t	f	t	f
344	Paella Soup	https://spoonacular.com/recipeImages/Paella-Soup-654326.jpg	<ol><li>Rinse, stem, seed, and chop bell peppers. In a 5- to 6-quart nonstick pan over high heat, stir 1 1/2 cups chopped red peppers with the oil and ham until peppers are limp, about 5 minutes. Add rice, water (as specified on package), and seasoning packets. Bring to a boil, cover, reduce heat, and simmer until rice is tender to bite, 18 to 20 minutes, stirring occasionally.</li><li>About 8 minutes before rice is done, in a 4- to 5-quart pan over high heat, bring broth and saffron to a boil. Stir in shrimp, cover, and return to a boil. Reduce heat and simmer until shrimp is opaque in center of thickest part (cut to test), about 5 minutes. With a slotted spoon, transfer shrimp to a small bowl. Return broth to a boil over high heat.</li><li>Stir peas into rice mixture and cook until they're hot, about 2 minutes.</li><li>Mound hot rice mixture equally in the center of 6 wide soup bowls, spoon shrimp around rice, sprinkle with remaining chopped red peppers, and ladle broth around rice.</li><li>This recipe yields 6 servings.</li><li>Comments: A flavored rice mix gives this company-worthy soup a head start.</li></ol>	spanish	45	6	f	f	t	t
345	Paella for Four - A Wonderful Spanish Mixed Seafood Stew	https://spoonacular.com/recipeImages/Paella-for-Four--A-Wonderful-Spanish-Mixed-Seafood-Stew-654327.jpg	<ol><li>1. Use a 12 inch All-Clad stainless steel pan or equivalent. A paella pan is not necessary.</li><li>2. Mix the Spice Mix and rub on the chicken and refrigerate for 1 hour. Let the chicken warm up for 30 minutes before cooking.</li><li>3. Heat half of the oil in the pan to medium high heat and brown the sausage rounds, then reserve.</li><li>4. Add the remaining oil and chicken and brown on all sides, then reserve.</li><li>5. Reduce the heat to medium and add the onions, garlic and parsley to start the sofrito. Cook for 2 to 3 minutes then add the crushed and drained tomatoes and cook for about 3 minutes while flavors meld. This base sauce is the sofrito.</li><li>6. Add the rice and stir to mix thoroughly to coat all the rice; about 2 more minutes.</li><li>7. Add back the sausage and chicken. Pour in the hot water, bring to a gentle simmer and cook for about 5 minutes, stirring occasionally to mix and place the pieces.</li><li>8. Place the clams where you want them in the finished dish and don't stir anymore. Cook for 5 minutes.</li><li>9. Place the shrimp tails up where you want them to appear in the finished dish.</li><li>10. Cook for about 10 minutes or until the clams are open, the shrimp are pink and the rice is fluffy and moist but not dry.</li><li>11. With a fork, feel the bottom of the dish. If it has formed a slight crust, called socarrat, it's ready to be served. If the socarrat has not formed, turn the heat up for 30 to 45 seconds while the crust forms. Then serve immediately.</li></ol>	spanish	45	4	f	f	t	t
346	Paella Valencian	https://spoonacular.com/recipeImages/Paella-Valencian-654330.jpg	<ol><li>* Note: About 2 inches square; 1 or 2 of each per serving: 8 to 10 pieces of chicken breast and/or thigh, 6 to 8 pieces of rabbit, or 6 to 8 pieces of pork, meatballs, etc. (all optional, depending on appetites).</li><li>In saucepan, brown meats in olive oil; remove meat. In drippings, add onion, green pepper, tomato, minced garlic, bay leaf, and parsley and saute until the onion is soft. Add saffron, browned meats, and 1/4 cup of water and cook over low heat 5 to 10 minutes. Drain the juice from the saucepan and save it.</li><li>Steam mussels until they open. Save the juice; set mussels aside. When they are cool, separate the shells, leaving the mussels on their half shells.</li><li>Transfer saucepan contents to paella pan, distributing evenly. Place full head of garlic at center of the pan. Divide into pie wedges with the thick strips of red pepper standing on edge so that when it is done, you will see the tops of the pepper strips. Distribute rings and heads of calamari. Sprinkle beans or chick peas evenly around. Then sprinkle rice evenly around meats. Add 8 cups of liquid, including saucepan saute juices and mussel juice.</li><li>Cook, uncovered, evenly over low flame. This can be done in the oven, but is much better over an open flame where you can tend it. I prefer to do it over an adjustable grille, starting relatively close to the hot coals to get it steeping and simmering, but then raising the grille from the coals to slow the cooking and let the flavors mingle. Important: rotate the pan over the flame to make sure it cooks evenly, and keep flame from scorching the rice at the bottom of the paella pan. This pot takes considerable watchful attention.</li><li>When the rice has risen to the top and much (but not all) of the water has cooked off, fan shrimp over the top, then stand the mussels in half shells in the rice, points down. I do it in an attractive pattern of circled mussels and fanned shrimp.</li><li>As it cooks, gauge doneness by tasting rice from several parts of the pan to be sure it is the correct texture (cooked - not crunchy, not mushy) and consistent throughout. If more water is needed in certain parts of the pan, add boiling water sparingly, sprinkling from a large spoon. If too much water is in the rice, lay newspaper lightly over the top of it and it will absorb excess water.</li><li>Best served right out of the pan. In Spain, eating with the men out in the fields, the mussel shells served as spoons.</li><li>Serve with crusty bread and a tossed salad. I recommend violating the seafood-white wine rule; this meal goes best with a hardy red of your choice.</li><li>This recipe yields 6 servings.</li><li>Comments: I suggest the first time you do a paella that you stick close to the recipe. After that, feel free to experiment to taste. I also suggest you do not attempt a paella for two. This is a meal that requires a great deal of loving work to prepare, more than you would feel inclined to spend for only two persons. It requires close attention for quite a few hours. It cannot be hurried. I have tried to calculate the quantities required for six adults. There will be leftovers - there almost always are.</li><li>The first thing you need is a proper paella pan. You will find paella pans of many sizes and shapes. The best will be the most shallow and broad you can find, with its rim slanted outward. No lid needed. I have a paella pan that serves 8 persons; it is about 13 inches across at the top, 11 inches across the bottom, and the sides are only about an inch and a half high. It feeds eight persons comfortably. (I also have one that serves 16!)</li><li>The best way to clean and treat the pan: rub its insides vigorously with a wedge of lemon after each use (and before first use), rinse, dry, and wipe its insides with olive oil on a paper towel. It should remain rust free and ready for use.</li></ol>	spanish	45	1	f	f	f	t
347	Paella Catalane With Mussels, Squid and Crevettes	https://spoonacular.com/recipeImages/Paella-Catalane-With-Mussels--Squid---Crevettes-654331.jpg	<ol><li>1. In a paella pan heat the olive oil and butter.</li><li>2. Add the chicken legs or thighs and cook until brown on both sides.</li><li>3. Next add the pork pieces and jambon and continue to cook on medium heat.</li><li>4. Whilst this is cooking, bring a pan of water to boil and cook the mussels for 10 minutes.  Drain and set aside.</li><li>5. Next wash the tomatoes and add them in a pan of boiling water for 2-3 minutes.  Prick each tomato at least once when it is in the water.</li><li>6. Rinse the tomatoes in cold water, then peel the skins.</li><li>7. Cut the tomato into 4 wedges then under cold running water, remove its seeds.  If you prefer you can skip this stage.</li><li>8. Add the tomatoes and garlic to the paella pan.  Stir into the meat pieces.</li><li>9. Whilst this is cooking, cut your squid into small pieces and add to the paella.</li><li>10.  Add the chopped onions and 1.5L of water and simmer.</li><li>11. Next add the rice.  After 15 minutes, add the sliced chorizo and crevettes.  Stir often to ensure that the rice does not stick to the bottom of the pan.</li><li>12.  Finally add the petit pois, freshly cracked black pepper and the parsley.  When it is nearly done, add the mussels and cook for a few minutes.</li><li>This beastly feast will serve at least 10 people.  The paella is ready once all of the liquid has been absorbed.  Serve with white wine or ros.  This meal was delicious underneath a bright yellow sun.</li></ol>	spanish	45	10	f	f	t	f
348	Patti's Paella	https://spoonacular.com/recipeImages/Pattis-Paella-655017.jpg	<ol><li>Mix together paprika, cumin, rosemary, thyme, salt, and pepper and sprinkle on the chicken chunks.  Marinate in the refrigerator for at least 1 hour.</li><li>Heat oil in a large Dutch oven or deep pot on a medium high heat.  Add chorizo,chicken and the remaining spice mixture and cook until browned.  Drain excess oil.</li><li>Add onion, red and green pepper, garlic.  Cook on medium heat, stirring until softened.</li><li>Add rice, saffron, tomato, and bay leaf.  Stir to combine and coat the rice.</li><li>Add chicken stock and white wine, and bring to a boil.  Stir to blend flavors. Cover.  Cook on low for approximately 20 minutes.</li><li>In the remaining 10 minutes, add the peas, shrimp and all other seafood.  Bury the seafood deep into the rice and stir.  Cover.</li><li>When the rice is tender, let the dish sit for a minute in the pot before serving. Garnish on a platter with lemon wedges.</li></ol>	spanish	45	6	f	f	t	t
349	Pumpkin Empanada	https://spoonacular.com/recipeImages/Pumpkin-Empanada-657302.jpg	<ol><li>Melt the butter in a medium saucepan over medium heat. Stir in the brown sugar until it dissolves with the butter. Stir in the pumpkin and the spices. Continue to stir over medium heat for about 10 minutes. Make sure the filling is not too watery; otherwise let it cook for a couple more minutes.</li><li>Remove the saucepan from the heat and let it cool down. After its cooled off for about 15 minutes, put the filling in the refrigerator to help it set for 30 minutes or overnight.</li><li>You can make the Empanada Dough while the filling is cooling off.</li><li>Mix the first 3 dry ingredients. Cut in the shortening with the dry ingredients. Works better if you use your hands. Add the eggs, milk and sugar. Continue to work in with your hands. Split the dough in half, wrap in plastic wrap and put into the refrigerator for about 20-30 minutes. Take out one half of the dough and split it into 12-18 balls of dough. Depending on how small you want your empanadas. I prefer one dozen per half of the dough. They also fit nicely on one large cookie sheet.</li><li>Preheat the oven to 350 degrees. You can fill your empanadas with any preserves made ahead of time.</li><li>Roll out the dough into small round circles. Add a small dollop of filling on one half of the rolled out dough. Wet the bottom edge of the dough with water to help seal the two halves. Fold over the dough to seal. Seal off the edges with a fork by pressing down along the two edges. This also makes for a pretty pattern when baked.</li><li>Brush each empanada with egg whites, sprinkle with sugar and puncture each empanada with a fork to allow steam to escape while baking. Spray a large cookie sheet with cooking spray, place the empanadas on the cookie sheet and bake for 15-20 minutes on medium rack in the oven. If after 15 minutes you notice the bottoms of the empanadas starting to brown, move the cookie sheet to the top rack and continue to bake for the last 5 minutes.</li></ol>	spanish	45	2	f	f	f	f
350	Spanish Gazpacho Soup In The Raw With Broiled Vegan Cheese Toast	https://spoonacular.com/recipeImages/Spanish-Gazpacho-Soup-In-The-Raw-With-Broiled-Cheese-Toast-660861.jpg	<ol><li>Spanish Gazpacho Soup</li><li>Place all ingredients in a blender or Vitamix and blend well until smooth for about 3 minutes.</li><li>Refrigerate for 1 to 2 hours before serving.</li><li>Garnish with organic crunchy onions and chopped parsley (or dried).</li><li>Prepare "cheese" toasts.</li><li>Broiled "Cheese" Toast</li><li>Postition oven rack to second to highest rack from the top. Turn oven to broil.</li><li>On baking sheet , lay out bread and split "cheese" between both slices.</li><li>Sprinkle parsley and salt and place in oven rack.</li><li>Broil until slightly browned and cheese is broiled. Slice in half once toast is somewhat cool.</li></ol>	spanish	45	4	t	t	f	t
351	Spanish Meatballs In Tomato Sauce	https://spoonacular.com/recipeImages/Spanish-Meatballs-In-Tomato-Sauce-660868.jpg	<ol><li>Start by making the tomato sauce.</li><li>Finely chop 1 onion.</li><li>Peel 600g of tomatoes with a serrated peeler. Chop the peeled tomatoes into small pieces.</li><li>Add 2 tablespoons of olive oil in a sauce pan. Add the chopped onions.</li><li>Add a pinch of Pimenton de la Vera (Dulce), which is Spanish smoked sweet paprika. I used 1/4 teaspoon. Add more if you prefer the sauce to be spicy.</li><li>Add the chopped tomatoes to the onions mixture and stir well to combine.</li><li>Add 1 fresh bay leaf. I used 2 dried pieces here because I couldnt find fresh ones.</li><li>Add 1 teaspoon of sugar andd salt and pepper to taste. I added 1/2 teaspoon of salt and 1/4 teaspoon of ground black pepper. Adjust seasoning to taste.</li><li>Cover the sauce pan and reduce the heat to a medium-low and let the tomato mixture simmer gently till it reduces to a sauce like consistency.</li><li></li><li>In the meantime, make the meatballs by adding 1/2 an onion to a food processor.</li><li>Add 2 cloves of garlic. I used 1 tablespoon of minced garlic. Process till the onions and garlic are finely chopped.</li><li>Sweat the onion-garlic mixture in a frying pan with some olive oil. I just realised that I had missed this step. The meatballs still tasted great.</li><li>Add the onion-garlic mixture to 500g ground beef in a mixing bowl.</li><li>Slice off the crust of 4 slices of white bread. Cut the soft white bread into small cubes of 1cm all round.</li><li>Add the chopped bread to the beef mixture.</li><li>Add 2 tablespoons of chopped parsley. Use Italian flat parsley where possible. I couldnt find any, so I used English parsley.</li><li>Add 1 large egg.</li><li>Add salt and pepper to taste. I used approximately 1/4 teaspoon of salt and a pinch of black pepper.</li><li>Mix well to combine.</li><li>Shape the meat mixture into balls that are slightly bigger than the size of a golf ball size. Roll the meat tightly to form meatballs.</li><li>Add 3/4 cup of olive oil to frying pan. The layer of oil should be approximately 3/4cm in the pan.</li><li>Put the pan on medium-high heat and add the meatballs to the oil. Gently roll them around in the oil to brown all surfaces and ensure even cooking.</li><li>When the meatballs are a deep golden brown, remove them from the frying pan and set aside.</li><li>The tomatoes-onion mixture should have reduced to a sauce consistency now. You can use a hand blender to puree the mixture. Or leave the small bits of tomatoes and onions as they are.</li><li>Add the meatballs to the tomato sauce and let the meatballs warm through.</li><li>Garnish with more chopped parsley.</li></ol>	spanish	45	20	f	f	f	t
352	Spanish Ketchup - Romesco Sauce	https://spoonacular.com/recipeImages/Spanish-Ketchup--Romesco-Sauce-660883.jpg	<ol><li>Fire up your grill to roast the red bell peppers.  Lightly coat the red peppers with olive oil & place on a pre-heated grill over high heat.  Turn the peppers occasionally to char the skin black  10 to 15 minutes.</li><li>Remove the peppers from the grill & place in a bowl.  Cover with plastic wrap  10 minutes.  Peel & discard the skin, seeds & veins;  Rough chop the peppers & place in a food processor.  Add all the other ingredients & pulse until blended.  Slowly add the olive oil & blend until smooth.  Season with salt & pepper.</li><li>You can serve the romesco sauce at room temperature or chilled.  If needed, gently warm the sauce over low heat.  Over heating the sauce will could cause it to separate.  If so, pour separated sauce in a blender & process for 1 minute.</li></ol>	spanish	45	8	t	t	t	t
353	Sun-Dried Tomato Romesco	https://spoonacular.com/recipeImages/Sun-Dried-Tomato-Romesco-662294.jpg	<ol><li>Combine hazelnuts, almonds, Parmesan, and garlic in a food processor. Pulse until finely ground.</li><li>Add roasted red peppers, sun-dried tomatoes, vinegar, salt, and red pepper.</li><li>Process until smooth, or desired consistency.</li></ol>	spanish	45	1	f	f	t	f
354	Asparagus Thai Style With Squids	https://spoonacular.com/recipeImages/Asparagus-Thai-Style-With-Squids-632955.jpg	<ol><li>Heat 2 tbsp oil and saut chopped garlic until fragrant.</li><li>Add in asparagus, stir fry a while then add in carrot and stir well.</li><li>Add in fish sauce, sugar and a little water if it becomes too dry.</li><li>Now add in squid, stir-fry for about 1-2 minutes, or until squid curls up. Don't overcook squid, as it will become rubbery.</li><li>Test for taste, adding more fish sauce if not salty enough. But if too salty for your taste, add a little more sugar. Dish up and serve immediately.</li></ol>	thai	45	2	f	f	t	t
355	Thai Style Chicken Satay	https://spoonacular.com/recipeImages/Chelleys-Thai-Style-Chicken-Satay-637697.jpg	<ol><li>For satay: Marinate chicken with marinade for at least 2 hours or preferably overnight in the fridge.</li><li>Make sure to soak bamboo sticks in water for 30 minutes before skewering the meat.</li><li>Cook satays on greased grill griddle and brush on oil and leftover marinade as needed. Cook about 3 minutes on each side.</li><li>Serve satays with peanut sauce, cucumber and onions.</li><li>For Peanut Sauce: Bring coconut milk to a boil and add the rest of the ingredients and adjust to taste accordingly.</li></ol>	thai	140	30	f	f	t	t
356	Drunken Noodles (Pad Kee Mao)	https://spoonacular.com/recipeImages/Drunken-Noodles-(Pad-Kee-Mao)-641671.png	<ol><li>Separate the noodles by peeling them apart one at a time. If also using Yam-cake noodles, rinse well. Set aside.</li><li>Prepare your ingredients: Slice the vegetables. Crush the garlic and chilies, and set aside. Pick off the leaves & flowers of the basil, and set aside. Chop the large chili into rings.</li><li>Combine the oyster sauce, Braggs, fish sauce, and Stevia in a small bowl and set aside.</li><li>If using tofu, pre-fry in a dry, non-stick skillet until browned. Set aside.</li><li>Add the oil to a Wok (this pan is preferred but not a necessity), and heat on medium until its dancing around.  (Heating oil on too high of heat will cause it to turn into Trans-fat which is not a good thing.)  Then add the garlic, chilies and green peppercorns. Keep stirring so it doesnt burn.</li><li>When the garlic turns light brown, add the veggies & meat/seafood if adding. Keep stirring and cook until finished, about 3-5 minutes depending on the ingredients used.</li><li>Add the tofu (if adding), then the noodles. You may need to add a bit more water if the pan gets too dry. Dont add a lot, or the noodles will get mushy.</li><li>After frying for a minute or two, add the sauce mixture.  Stir well to combine.</li><li>Add the basil & vinegar. Stir to mix. When the basil is wilted its done.</li></ol>	thai	45	2	t	t	t	t
357	Green Mango Salad - Thai Side Dish	https://spoonacular.com/recipeImages/Green-Mango-Salad-645474.jpg	<ol><li>Julianne the green mango and diced the tomato </li><li>Mix and place in the bowl </li><li>Roughly pound chili and garlic and add the fish sauce </li><li>Season with sugar to balance the taste </li><li>Add lime juice for the final touch </li><li>Pour the dressing in bowl of mix green mango and tomato, fold gently </li><li>Place on the bed of your favourite lettuce and serve</li></ol>	thai	15	2	f	f	t	t
358	Sweet and Spicy Thai Relish	https://spoonacular.com/recipeImages/Sweet---Spicy-Thai-Relish-662427.jpg	<ol><li>Heat a large cast iron skillet over medium heat. Once hot, dry-fry (meaning, dont add any fat or oil to the pan) the whole chilies for one minute, then set aside in a small bowl. They should be fragrant and slightly darker in color, but not burnt. In the same pan, dry-fry the chopped onion, bell pepper, and garlic for 2 minutes until brown but not burnt, then set aside on a large plate.</li><li>Toss in the tomatoes and dry-fry for 1-2 minutes until charred on the outside, stirring frequently. Set on the plate with the onions, pepper, and garlic. Turn the stove off, then use your hands to break apart the chilies into smaller pieces. Dont try to use a knife, because they will fly all over the kitchen. Place the chilies in the bowl of a blender or large food processor, then wash your hands thoroughly with soap and warm water to remove any oils left from the chilies.</li><li>Add the third cup fish sauce, quarter cup lime juice, and sugar to the blender, along with the reserved onion, bell pepper, garlic, and tomatoes. Pulse on chop mode or equivalent until the mixture forms a chunky sauce. Serve either warm or chilled.</li></ol>	thai	45	3	f	f	t	t
359	Thai Chicken Wraps	https://spoonacular.com/recipeImages/Thai-Chicken-Wraps-663078.jpg	<ol><li>Toss chicken strips with shoyu and oil until well coated. Heat in saute pan over medium-low heat until heated through.</li><li>In medium bowl, add sesame seeds, sprouts, slaw mix, basil, sugar, vinegar and salt & pepper. Toss until thoroughly coated. Set aside.</li><li>To make the SAUCE: in small bowl, whisk Earth Balance natural peanut butter with shoyu and vinegar. Add in oil while whisking until consistency is slightly runny.</li><li>Chop off the rough end of romaine leaves; smooth out flat and pile on the chicken, slaw mixture and drizzle with peanut sauce.</li><li>Top with crushed peanuts (optional) and carefully wrap and roll, starting from one end. Leave seam side down.</li></ol>	thai	45	6	f	f	t	t
360	Thai Coconut Curry Lentil Soup	https://spoonacular.com/recipeImages/Thai-Coconut-Curry-Lentil-Soup-663090.jpg	<ol><li>Heat olive oil in a medium saucepan. Add the onions, ginger and garlic. Cook over medium heat until softened, about 3-4 minutes. Stir in Thai red curry paste, and cook several minutes or until fragrant. Add water, lentils, sweet potatoes and turmeric. Bring to a boil, then reduce heat to medium-low, cover and cook about 20-25 minutes or until lentils and sweet potatoes are soft. Add salt and stir in coconut milk. Cook five more minutes. Garnish with fresh cilantro.</li></ol>	thai	45	5	t	t	t	t
361	Thai Fried Rice	https://spoonacular.com/recipeImages/Thai-Fried-Rice-663104.jpg	<ol><li>Saute garlic in oil. Add sliced pork; cook until brown. Add onion, tomato, and green pepper; fry slightly. Cook rice in water; add to fried mixture. Add eggs and fry. Continue stirring until eggs are cooked. Add soy sauce, salt, sugar, and pepper. Yields 6-8 servings.</li></ol>	thai	45	1	f	f	t	t
362	Thai Fish Cakes	https://spoonacular.com/recipeImages/Thai-Fish-Cakes-663108.jpg	<ol><li>Step 1: Add fish fillets, egg, fish sauce, corn flour, red curry paste, red chilies and coriander leaves in blender. Blend it until combined and turns in to the thick paste. Transfer the paste in to a bowl</li><li>Step 2: Now add spring onion and green beans in to the paste .Mix well. Form the paste in to round patties using wet palms. Keep them aside</li><li>Continue Reading Thai Fish Cakes Recipes: http://recipes.sandhira.com/thai-fish-cakes.html</li></ol>	thai	45	2	f	f	t	t
363	Thai Green Mango Salad	https://spoonacular.com/recipeImages/Thai-Green-Mango-Salad-663113.jpg	<ol><li>Pound all the ingredients in a clay mortar using a wooden pestle, then add carrot and mangoes. Serve chilled with roasted coarse peanuts.</li></ol>	thai	45	6	f	f	t	t
364	Thai Massaman Curry	https://spoonacular.com/recipeImages/Thai-Massaman-Curry-663121.jpg	<ol><li>In the heated oil, fry curry paste till aromatic and oil splits.</li><li>Add bay leaves and lamb.</li><li>Pour 1/2 liter of water (more if you like)</li><li>Stir and simmer till lamb is half cooked.</li><li>Add potatoes and season with salt.</li><li>Continue to simmer till potatoes and lamb are tender and soft.</li><li>Pour in fish sauce, lime juice and coconut milk.</li><li>Gently stir and remove from heat.</li></ol>	thai	45	5	f	f	t	t
365	Thai Pasta Salad	https://spoonacular.com/recipeImages/Thai-Pasta-Salad-663126.jpg	<ol><li>Cook pasta according to package instructions. During the last minute, add in the broccoli.</li><li>In the meantime, you can cook the vegetables and prepare the dressing.</li><li>Heat olive oil in small non-stick skillet, saut onions until slightly soften. Add in garlic and continue to saut until fragrant. add in sweet peppers and cook until slightly softened. Remove from heat, add in remaining ingredients to finish making the sauce. Add salt and pepper to taste.</li><li>When the pasta and broccoli is ready, add them to the skillet and stir well. Stir in cilantro leaves.</li><li>Served at room temperature or chilled.</li></ol>	thai	45	2	f	f	f	t
366	Thai Red Curry	https://spoonacular.com/recipeImages/Thai-Red-Curry-663144.jpg	<ol><li>Pour coconut milk into saucepan. Over high heat, whisk in curry paste. If you prefer spicy cuisine, then add more red curry paste than suggested.</li><li>Add fish sauce and brown sugar. Add basil, bamboo shoots, pineapple, onion, bell pepper, and snow peas. Bring to a boil stirring frequently.</li><li>Reduce heat and cook 3 minutes until thickened.</li><li>Optional:  If adding meat, boneless/skinless chicken, beef, or shrimp is recommended. Cut one pound of meat into bite sized pieces. Add raw meat to finished curry sauce and allow to cook over medium heat an additional 10 minutes or until done.</li></ol>	thai	45	6	f	f	t	t
367	Thai Sausage Salad	https://spoonacular.com/recipeImages/Thai-Sausage-Salad-663149.jpg	<ol><li>In a small bowl, combine the dressing ingredients and stir until the sugar has dissolved. Taste and adjust with more sugar or fish sauce if needed (some limes are more tart than others). Set aside.</li><li>Slice the sausage thinly on the diagonal. Place in a non stick skillet over medium heat and saut until the edges are slightly browned and sausage is cooked thru, about 5 minutes. Dont over cook. Set aside to cool</li><li>Peel the cucumbers, slice thinly and place in a large bowl. Thinly slice the green onions on the diagonal and add to the bowl. Add the bean sprouts, cooked sausage and the dressing. Lightly toss and serve on plates with jasmine rice on the same plate. Garnish with a few slivers of sliced hot chili pepper, if desired, and a few leaves of fresh parsley or cilantro.</li><li>Serves 2 as a main course salad.</li></ol>	thai	45	2	f	f	t	t
368	Thai Savory Brown Fried Rice	https://spoonacular.com/recipeImages/Thai-Savory-Brown-Fried-Rice-663150.jpg	<ol><li>Make my Perfect Brown Rice recipe below.  While brown rice is cooking prepare rest of meal.PERFECT BROWN RICE1 cup uncooked brown rice1 tsp. olive oil2 cups filtered water2 basil leaves (optional)Fix brown rice by cooking in 1 tsp. olive oil until lightly browned. Place 2 basil leaves on top of rice and add 2 cups water all at once. Quickly put on lid and bring to boil. Turn down heat to simmer until all water has evaporated (around 40 minutes).</li><li>Heat oil in a wok or large frying pan.  Add the garlic and cook on medium until lightly golden.  Watch carefully so you do not burn garlic.</li><li>Add the red chili peppers, cashew nuts and toasted coconut.  Mix together stevia, Nama Shoyu and apple cider vinegar together.  Cook over medium heat for 1 minutes.</li><li>Push stir-fry to one side of pan and add flax on opposite end.  Cook and stir the flax egg for about a minute and then incorporate into stir-fry mixture.</li><li>Add the green beans, bok choy and brown rice to stir-fry.  Cook and stir on medium for another minute.  Bok Choy will be wilted, but green beans will still be a bit crunchy.</li><li>Spoon into serving dish and add lime wedge on side for squeezing over rice.</li></ol>	thai	45	4	t	f	t	t
369	Thai Shrimp	https://spoonacular.com/recipeImages/Thai-Shrimp-663151.jpg	<ol><li>Peel and devein shrimp. Wash, dry and steam basil, mince garlic, thinly slice seeded chilies, mince white part of onion and cut green part into 1 inch pieces. Recipe can be prepared ahead to this stage.</li><li>Heat wok over high heat. Swirl oil into wok and heat almost to smoking. Add garlic, chilies, onions (white part), and cook 10-15 seconds; add shrimp and stir fry 20 seconds or until they change color. Add fish sauce, soy sauce, sugar, chicken, stock and green part of onions and bring mixture to a boil. Stir in basil and cook 20 seconds or until leaves wilt and shrimp are firm and pink. Dish is supposed to be soupy. Serve over hot cooked rice.</li></ol>	thai	45	4	f	f	t	t
370	Thai Stir-Fry Chicken With Cashew Nuts	https://spoonacular.com/recipeImages/Thai-Stir-Fry-Chicken-With-Cashew-Nuts-663156.jpg	<ol><li>On medium flame, fry the garlic until fragrant and not brown.</li><li>Add in the chicken and cook until nearly done. Then, add in Thai chili paste and stir well. Add a bit less than recommended if you cant take spiciness.</li><li>Add in the onion, cashew nuts, dry chilies and spring onion. Give it a good mix and cook for  about 2 minutes.</li><li>Then, season with soya sauce. Add in dark soya sauce to sweeten the dish and give it a little bit of colour. Serve warm.</li></ol>	thai	45	3	f	f	t	t
371	Thai Street Vendor Salmon Skewers	https://spoonacular.com/recipeImages/Thai-Street-Vendor-Salmon-Skewers-663157.jpg	<ol><li>Remove skin from salmon fillet and trim away any brown fatty areas.</li><li>Place 8 bamboo skewers into the fillet running from the thick side to the thin about 1.5 inches apart. Then slice the fillet so that you have individual pieces of salmon on the skewers.</li><li>Make a sauce combining the remaining ingredients, including the juice from the lime and the zest. It's also easiest to mince the ginger by putting it through a garlic press. You can adjust the mix of ingredients to match your personal tastes.</li><li>Place the salmon in a deep bowl or ziploc bag and marinate in about half of the sauce, reserving the rest for serving. Refrigerate for 30 minutes to an hour, more will break down the fish and cause it to "cook" a bit in the lime juice.</li><li>Grill skewers on a high heat and serve. Eat with chilled raw Yu Choy, which you use to wrap bits of the fish and drizzle with remaining sauce.</li></ol>	thai	45	4	f	f	t	t
372	Thai Tofu With Bok Choy	https://spoonacular.com/recipeImages/Thai-Tofu-With-Bok-Choy-663166.jpg	<ol><li>Cut the tofu into 1" cubes. Whisk together sauce ingredients (soy sauce, oyster sauce, fish sauce, brown sugar, and chili paste). Set aside.</li><li>Heat 2 tsp sesame oil over medium-high heat in a large wok or pan. When the pan is hot, add the tofu and let cook for 2 minutes on one side, undisturbed, until they develop a crisp crust. Flip and cook 2 minutes more.</li><li>Remove the tofu to a plate. Return pan to the heat.</li><li>Add remaining 1 tsp sesame oil to the pan along with the carrots. Saute for 3 minutes, until the carrots begin to soften.</li><li>Add the bok choy and saute for 2 minutes, until it begins to soften and wilt.</li><li>Stir in the sauce.</li><li>Return the tofu to the pan and stir in the corn starch mixture. Allow the sauce to come to a boil for it to thicken. Stir.</li><li>Serve with rice.</li></ol>	thai	45	4	f	f	t	t
373	Thai Veggie Slaw with Peanut Dressing and Crispy Wontons	https://spoonacular.com/recipeImages/Thai-Veggie-Slaw-with-Peanut-Dressing-and-Crispy-Wontons-663169.jpg	<ol><li>1. Make the crispy wontons: Preheat oven to 375 degrees f. Lay the wontons out on a large baking sheet. Spray lightly with cooking spray and sprinkle with the Chinese five spice and cayenne. Flip the wontons over and repeat. Stack all the wonton skins on top of each other and slice into 1/2-3/4-inch strips. Spread the strips in an even layer back onto the baking sheet. Bake 10-12 minutes, until crisp and golden brown, flipping the strips halfway through and rotating the baking sheet. (Watch carefully that they don't burn) Remove from the oven and let cool before using.</li><li>2. Prepare the dressing: In the jar of a blender, add 1/2 c. peanuts and 2 T. canola oil. Blend until completely smooth, about a minute, scraping down the sides of the blender jar as necessary. Add in the remaining canola oil, lime juice, fish sauce, brown sugar, sriracha, ginger and garlic. Blend until smooth.</li><li>3. In a large bowl combine all the vegetables. Add the dressing and the remaining 1/2 c. peanuts. Toss well to combine. You can either mix the wontons into the salad, or reserve them for crumbling onto individual portions.</li></ol>	thai	45	6	f	f	t	t
374	Vegetarian Thai Red Curry	https://spoonacular.com/recipeImages/Vegetarian-Thai-Red-Curry-664716.jpg	<ol><li>Whizz the paste ingredients in a food processor. Marinate the tofu in 2 tbsp soy sauce, juice 1 lime and the chopped chili.</li><li>Heat half the oil in a large pan. Add 3-4 tbsp paste and fry for 2 mins. Stir in the coconut milk with 100ml water, the courgette, aubergine and pepper and cook for 10 mins until almost tender.</li><li>Drain the tofu, pat dry, then fry in the remaining oil in a small pan until golden.</li><li>Add the mushrooms, sugar snaps and most of the basil to the curry, then season with the sugar, remaining lime juice and soy sauce. Cook for 4 mins until the mushrooms are tender, then add the tofu and heat through. Scatter with sliced chili and basil and serve with jasmine rice.</li></ol>	thai	45	4	t	t	t	t
375	Easy To Make Spring Rolls	https://spoonacular.com/recipeImages/Easy-To-Make-Spring-Rolls-642129.jpg	<ol><li>Have all the ingredients ready for assembly. In a large bowl filled with water, dip a wrapper in the water. The rice wrapper will begin to soften and this is your cue to remove it from the water and lay it flat. Place 2 shrimp halves in a row across the center and top with basil, mint, cilantro and lettuce. Leave about 1 to 2 inches uncovered on each side.  Fold uncovered sides inward, then tightly roll the wrapper, beginning at the end with the lettuce.  Repeat with remaining wrappers and ingredients. Cut and serve at room temperature with dipping sauce.</li><li>The Culinary Chases Note: The rice wrapper can be fussy to handle if you let it soak too long. I usually give it a couple of swishes in the water and then remove. It may feel slightly stiff but by the time you are ready to roll up, the wrapper will become very pliable.  A typical spring roll contains cooked rice vermicelli, slivers of cooked pork and julienned carrots but you can use whatever suits your fancy.  Enjoy!</li></ol>	vietnamese	45	4	f	f	t	t
376	Gluten Free Vegetarian Spring Rolls With Thai-Style Peanut Sauce	https://spoonacular.com/recipeImages/Gluten-Free-Vegetarian-Spring-Rolls-With-Thai-Style-Peanut-Sauce-644859.jpg	<ol><li>Bring a large pot of water to boil over high heat. Remove from heat and stir in the rice noodles. Let stand 10 minutes, stirring occasionally, or until soft and opaque. Drain and rinse under cold water for 30 seconds; drain again. Cut into 1-inch lengths and transfer to a large bowl.</li><li>Add all of the remaining ingredients, except the rice papers and sauce, to the noodles and mix well.</li><li>Prepare a bowl of warm water large enough to dip the rice papers. Working with one at a time, dip the rice paper in the warm water until it begins to soften, 8-10 seconds. Transfer to a flat work surface. Working quickly, put about 1/4 cup filling on each wrapper. Fold the bottom of the wrapper up over the filling, and then fold each side toward the center. Roll from the bottom to the top of each roll, as tightly as you can without ripping the wrapper. Wrap in plastic to keep from drying out. Repeat with remaining wrappers and filling. Serve at room temperature, with Peanut Dipping sauce. Alternatively, refrigerate for a minimum of 2 hours, or overnight, and serve 4To prepare Peanut Dipping Sauce:</li><li>To prepare Peanut Dipping Sauce:</li><li>In a small bowl, combine the warm water and sugar, stirring until the sugar is dissolved. Add the remaining ingredients, whisking until smooth and well blended. Serve at room temperature.</li></ol>	vietnamese	45	15	t	f	f	t
377	Grilled Chicken Banh Mi	https://spoonacular.com/recipeImages/Grilled-Chicken-Banh-Mi-645634.jpg	<ol><li>Mix the first six ingredients in a baking dish. Add the chicken breasts to the dish, cover, and refrigerate at least 1 hour. </li><li>Stir the hot tap water and sugar in a medium bowl, until the sugar dissolves. Add the vinegar, salt, red pepper, sliced carrots and radishes. Cover and refrigerate for at least 30 minutes.</li><li>Heat the grill to medium. Grill the chicken breasts for 5 minutes per side. Remove from heat and cover them with foil to rest for 5 minutes.</li><li>Open the sub rolls and grill the insides for about 1-3 minute until toasted.</li><li>Drain the pickled veggies. Slice the chicken into thin pieces.</li><li>Spread mayo over in the sub rolls. Layer the cucumbers, chicken, pickled veggies, cilantro leaves and jalapenos in the rolls.</li><li>Serve immediately! </li></ol>	vietnamese	110	6	f	f	f	t
378	Phyllo Dough Baked Spring Rolls	https://spoonacular.com/recipeImages/Phyllo-Dough-Baked-Spring-Rolls-655903.jpg	<ol><li>Place 2 Tbsp. oil in a wok or large frying pan over medium to high heat.</li><li>Add garlic, galangal (or ginger), shallots, and chili. Stir-fry until fragrant (about 1 minute). Stir-frying Tip: Add a little water to the wok/pan when it gets too dry instead of more oil.</li><li>Add cabbage, mushrooms, and tofu and shrimp. As you stir-fry, add the sauce.</li><li>Stir-fry 1-2 minutes, add the rest of the vegetables, except for the bean sprouts, coriander and basil.</li><li>Stir-fry until vegetables have softened.</li><li>Remove from heat and add bean sprouts, tossing to mix in.</li><li>Do a taste test for salt, adding 1 Tbsp. more fish or soy sauce if not salty enough.</li><li>ASSEMBLING THE ROLLS</li><li>Paint half of 1 sheet of phyllo dough with melted butter, margarine, or olive oil.</li><li>Using the butter as glue, fold the sheet in half to form a rectangle.</li><li>Pile about 1/3 cup of filling at the bottom of a narrow side, leaving a 2-inch border on 3 sides.</li><li>To form the log, fold the bottom flap up and over the filling, fold in the sides and roll up to seal.</li><li>Paint the roll with melted butter and place, seam side down, onto a baking sheet.</li><li>Repeat with the remaining sheets of phyllo dough.</li><li>Tips: Spread the filling lengthwise along the phyllo dough nearer the end closest to you. Also, try not to include too much of the liquid left in the bottom of your wok/pan (a slotted spoon works well for this  drier filling is better. Now sprinkle some of the fresh coriander and basil over the filling.</li><li>BAKING THE ROLLS</li><li>Preheat the oven to 400.</li><li>Bake in the center of the oven for 15 to 20 minutes, until lightly golden all over.</li></ol>	vietnamese	45	20	f	f	f	t
379	Vegetarian Spring Rolls With Garlic Lime Sauce	https://spoonacular.com/recipeImages/Vegetarian-Spring-Rolls-With-Garlic-Lime-Sauce-664708.jpg	<ol><li>Julienne red and yellow bell pepper, carrots, jicama and Thai basil into 1/8in thin and 2 inch long strips.</li><li>Fill a round pie pan or shallow plate with warm water. Dip one rice paper, making sure both sides are soaked. Lay on a flat flour towel cloth. Wait ten seconds for the paper to soft before using.</li><li>Peel rice paper off of cloth.</li><li>Place half of one butter leaf lettuce on top. Make sure to discard the ribbing.</li><li>Add a thin layer of each vegetable and finish with a few pieces of Thai Basil.</li><li>Starting at one end, fold the edge towards the middle. Repeat with parallel side. Rotate the spring roll by 90 degrees and roll form one end to the next.</li><li>Cut each roll diagonally and place facing up on a serving platter.</li><li>Garlic Lime Hoisin Sauce: Using a mortar and pestle crush garlic and ginger. Whisk in lime and Sriracha. Add hoisin sauce and whisk to combine.</li></ol>	vietnamese	45	10	t	f	t	t
380	Vietnamese Banh Mi	https://spoonacular.com/recipeImages/Vietnamese-Banh-Mi-664828.jpg	<ol><li>Mix all marinade ingredients (except for pork) in a plastic bag. Let all ingredients dissolve in oil, then add slices of pork.</li><li>Allow pork to marinade for at least 1 hour.</li><li>Heat pan on medium heat, lay slices of pork, one layer at a time. When one side is cooked, flip to other side to finish cooking.</li><li>Let the meat rest for 10 minutes and then slice into strips</li><li>Assemble pork in your sandwich</li></ol>	vietnamese	45	6	f	f	f	t
381	Vietnamese Beef-Noodle Soup with Asian Greens	https://spoonacular.com/recipeImages/Vietnamese-Beef-Noodle-Soup-With-Asian-Greens--Okay-Vietnamese-japanese-664830.jpg	<ol><li>Freeze beef for 10 minutes; cut across grain into 1/8-inch-thick slices.</li><li>Cook noodles according to package directions.</li><li>Drain and rinse with cold water; drain.</li><li>Place onion and next 5 ingredients (through star anise) in a large saucepan; cook over medium-high heat 5 minutes, stirring frequently.</li><li>Add broth and 2 cups water (dashi); bring to a boil.</li><li>Strain broth mixture though a fine sieve over a bowl; discard solids. Return broth to pan.</li><li>Add soy sauce, sugar, fish sauce, and sesame oil; bring to a boil.</li><li>Add bok choy and snow peas; simmer 4 minutes or until peas are crisp-tender and bok choy wilts.</li><li>Add miso at the last minute.</li><li>Arrange 1/2 cup noodles into each of 4 large bowls.</li><li>Divide raw beef and chile slices sambal oelek evenly among bowls.</li><li>Ladle about 1 2/3 cups hot soup over each serving (broth will cook beef). Top each serving with 1/4 cup bean sprouts, 1 tablespoon basil, and 1 tablespoon mint.</li><li>Serve with lime wedges.</li><li>Makes 4 servings.</li></ol>	vietnamese	45	4	f	f	f	t
382	Vietnamese Pho	https://spoonacular.com/recipeImages/Vietnamese-Pho-664836.jpg	<ol><li>Soak bone overnight in cold water. Place bones, oxtails and flank steak in a large stock pot. Add water to cover and bring to a boil. Cook 10 minutes, drain and rinse pot and bones. Return bones to pot, add 6 quarts water and bring to a boil. Skim surface of scum and fat. Stir bones at bottom from time to time. Add 3 more quarts water, bring to a boil again and skim scum. Lower heat and let simmer. Char clove-studded onions, shallots, and ginger under a broiler until they release their fragrant odors. Tie charred vegetables, star anise, and cinnamon stick in a thick, dampened cheesecloth. Put it in stock with daikon. Simmer for 1 hour. Remove flank steak and continue simmering broth, uncovered pot, for 4-5 hours. Add more water if level goes below bones.</li><li>Meanwhile, slice beef sirloin against grain into paper-thin slices, about 2-by-2 inches. Slice flank steak the same way. Set aside. In a small bowl, combine scallions, cilantro, and half the sliced onions. Place remaining onions in another bowl and mix in hot chili sauce. Soak rice noodles in warm water for 30 minutes. Drain and set aside.</li><li>When broth is ready, discard bones. Strain broth through a colander lined with a double layer of damp cheesecloth into a clean pot. Add fish sauce and bring to a boil. Reduce heat to simmer. In another pot, bring 4 quarts of water to a boil. Add noodles and drain immediately. Do not overcook noodles. Divide among 4 large soup bowls. Top noodles with sliced meats.</li><li>Bring broth to a rolling boil, then ladle into soup bowls. Garnish with scallions mixture and black pepper. Serve the onions in hot chili sauce and remaining ingredients on the side to add as desired. Also, you can add Hoisin sauce as a dip.</li></ol>	vietnamese	45	42	f	f	f	t
383	Vietnamese Spring Rolls With Hoisin Peanut Dipping Sauce	https://spoonacular.com/recipeImages/Vietnamese-Spring-Rolls-With-Hoisin-Peanut-Dipping-Sauce-664845.jpg	<ol><li>Bring a saucepan to a boil on medium heat.  Add shrimp and poach for 3-4 minutes until bright pink.  Allow to cool to room temperature.  Remove skins, devein and slice in half crosswise.  Set aside.  Bring a medium saucepan filled halfway with water to a boil.  Once a rapid boil is reached, add rice vermicelli noodles, cover and immediately remove from heat.  Set timer for 5 minutes.  After 5 minutes, drain noodles in a colander and rinse with cold water to stop cooking.  Allow to dry at room temperature or in the refrigerator.</li><li>Meanwhile, begin to prepare the dipping sauce.  Heat a small small saucepan with olive oil on medium-low heat.  Add garlic and saute quickly, about 20 seconds.  Do not let garlic burn.  Add peanut butter and hoisin sauce and continue to stir.  When sauce begins to incorporate and thickens up, add water.  Adjust to taste and continue to add water, 1 tbsp. at a time, if it becomes too thick.  Remove from heat and set aside.</li><li>To assemble rolls, dip single sheets of rice paper into hot water.  Allow excess water to drain and quickly place on a plate.  Once rice paper becomes pliable and soft, add shrimp, softened noodles, cucumbers, red peppers, cilantro and mint.  Carefully roll closed and slice in half.  Serve with hoisin peanut dipping sauce.</li></ol>	vietnamese	45	1	f	f	f	t
384	Vietnamese Spring Rolls	https://spoonacular.com/recipeImages/Vietnamese-Spring-Rolls-664847.jpg	<ol><li>Soak the rice vermicelli in warm water until they turn soft, then drain them.</li><li>Fill a bowl with warm water. Dip one wrapper at a time into the water for about 1-2 second to soften.</li><li>Lay the wrapper on a dry chopping board or dinner plate. The rice paper should become pliable within seconds.</li><li>In a row across the centre, put 3 prawns, some vermicelli, carrots, bean sprouts, and a few leaves of basil. Leaving about 4-5cm on each side.</li><li>Fold the sides inward, then start to roll tightly and firmly from the end that is near to you into a cylinder, enclosing the filling completely.</li><li>Repeat with the remaining ingredients.</li><li>For the dipping sauce, mix all the ingredients and stir well until the sugar dissolves. Then, put in chopped coriander.</li><li>Serve spring rolls with dipping sauce.</li></ol>	vietnamese	45	4	f	f	f	t
385	Wholemeal Steam Bun	https://spoonacular.com/recipeImages/Wholemeal-Steam-Bun-665306.jpg	<ol><li>METHOD:</li><li>1.Mix all the ingredients A together and knead into smooth and elastic dough.</li><li>2.Cover with a piece of wet cloth and leave to prove until double its size.</li><li>3.Sift B top of the dough and knead well to distribute the baking powder until the dough is smooth again.</li><li>4.Cover and allow dough to rest for 15 minutes before shaping.</li><li>Meat Fillings :</li><li>boiled eggs (shelled and cut into )</li><li>Marinade for meat : 30 minutes</li><li>Shredded chicken/pork</li><li>2 tbsp. BBQ sauce</li><li>water</li><li>Filling:</li><li>1.Heat oil in a pan adds in marinated meat and stirs fry till aromatic, adds in some water and cooks for 5 minutes until soft. Taste and dish up and leave to cool and chill in the fridge for 3 hours.</li><li>2.Divide dough 12 portions and shape balls.</li><li>3.Flatten, roll into a round shape and add 1 tbsp of filling and pleat the top into a Pau/Bun.</li><li>4.Line Pau/Bun with a piece of white paper and let it prove again for another 15 minutes.</li><li>5.Steam Pau/Bun with high heat for about 15 minutes or until the Pau/Bun is cooked.</li><li>6.Serve hot.</li></ol>	vietnamese	45	16	f	f	f	t
\.


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 174
-- Name: Recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Recipe_id_seq"', 386, TRUE);

--
-- TOC entry 1924 (class 2606 OID 16679)
-- Name: Ingredient_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY "Ingredient"
  ADD CONSTRAINT "Ingredient_name_key" UNIQUE (name);

--
-- TOC entry 1926 (class 2606 OID 16677)
-- Name: Ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY "Ingredient"
  ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY (id);

--
-- TOC entry 1932 (class 2606 OID 16724)
-- Name: IngredientsInRecipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY "IngredientsInRecipes"
  ADD CONSTRAINT "IngredientsInRecipes_pkey" PRIMARY KEY (recipe_id, ingredient_id, ingredient_index);

--
-- TOC entry 1930 (class 2606 OID 16711)
-- Name: Nutritional Content_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY "Nutritional Content"
  ADD CONSTRAINT "Nutritional Content_pkey" PRIMARY KEY (id);

--
-- TOC entry 1928 (class 2606 OID 16690)
-- Name: Recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY "Recipe"
  ADD CONSTRAINT "Recipe_pkey" PRIMARY KEY (id);

--
-- TOC entry 1935 (class 2606 OID 16730)
-- Name: IngredientsInRecipes_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "IngredientsInRecipes"
  ADD CONSTRAINT "IngredientsInRecipes_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES "Ingredient" (id);

--
-- TOC entry 1934 (class 2606 OID 16725)
-- Name: IngredientsInRecipes_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "IngredientsInRecipes"
  ADD CONSTRAINT "IngredientsInRecipes_recipe_id_fkey" FOREIGN KEY (recipe_id) REFERENCES "Recipe" (id);

--
-- TOC entry 1933 (class 2606 OID 16712)
-- Name: Nutritional Content_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Nutritional Content"
  ADD CONSTRAINT "Nutritional Content_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES "Ingredient" (id);

-- Completed on 2016-03-31 00:59:09

--
-- PostgreSQL database dump complete
--
