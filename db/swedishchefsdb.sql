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

CREATE TYPE "<enum 'Origin'>" AS ENUM (
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
  origin          "<enum 'Origin'>"
);

--
-- TOC entry 172 (class 1259 OID 16667)
-- Name: Ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Ingredient_id_seq"
START WITH 1
INCREMENT BY 1
NO MINVALUE
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
  calories              INTEGER          NOT NULL,
  total_fat_g           DOUBLE PRECISION NOT NULL,
  saturated_fat_g       DOUBLE PRECISION NOT NULL,
  cholesterol_mg        INTEGER          NOT NULL,
  sodium_mg             INTEGER          NOT NULL,
  total_carbohydrates_g DOUBLE PRECISION NOT NULL,
  dietary_fiber_g       DOUBLE PRECISION NOT NULL,
  sugar_g               DOUBLE PRECISION NOT NULL,
  protein_g             DOUBLE PRECISION NOT NULL,
  vitamin_a_iu          INTEGER          NOT NULL,
  vitamin_c_mg          DOUBLE PRECISION NOT NULL,
  calcium_mg            INTEGER          NOT NULL,
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
START WITH 1
INCREMENT BY 1
NO MINVALUE
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
1	black-eyed pea	https://upload.wikimedia.org/wikipedia/commons/d/d0/BlackEyedPeas.JPG	Vigna unguiculata subsp. unguiculata	Africa
2	carrot	https://upload.wikimedia.org/wikipedia/commons/b/bd/13-08-31-wien-redaktionstreffen-EuT-by-Bi-frie-037.jpg	Daucus carota	Asia
3	green bell pepper	https://upload.wikimedia.org/wikipedia/commons/5/59/Capsicum3.JPG	Capsicum annuum	NorthAmerica
4	onion	https://upload.wikimedia.org/wikipedia/commons/a/a2/Mixed_onions.jpg	Allium cepa	Africa
5	peanut butter	https://commons.wikimedia.org/wiki/File:96_-_IMG_20150804_111725.jpg	\N	NorthAmerica
6	salt	https://upload.wikimedia.org/wikipedia/commons/7/78/Salt_shaker_on_white_background.jpg	Sodium chloride	Worldwide
7	water	https://upload.wikimedia.org/wikipedia/commons/1/18/Water_drop_impact_on_a_water-surface_-_%285%29.jpg	Dihydrogen oxide	Worldwide
8	baking powder	https://upload.wikimedia.org/wikipedia/commons/2/2d/BakingPowder.jpg	Sodium aluminum sulfate	Europe
9	banana	https://upload.wikimedia.org/wikipedia/commons/4/44/Bananas_white_background_DS.jpg	Musa acuminata Colla	Oceania
10	butter	https://upload.wikimedia.org/wikipedia/commons/f/fd/Western-pack-butter.jpg	\N	Worldwide
11	canola oil	https://upload.wikimedia.org/wikipedia/commons/e/eb/CanolaOil_bottle.jpg	Brassicaceae family	Asia
12	cinnamon	https://upload.wikimedia.org/wikipedia/commons/d/de/Cinnamomum_verum_spices.jpg	Cinnamomum aromaticum	Asia
13	cream cheese	https://upload.wikimedia.org/wikipedia/commons/f/f7/Philly_cream_cheese.jpg	\N	Europe
14	egg	https://upload.wikimedia.org/wikipedia/commons/e/ee/Egg_colours.jpg	\N	Worldwide
15	flour	https://upload.wikimedia.org/wikipedia/commons/6/64/All-Purpose_Flour_%284107895947%29.jpg	\N	Asia
16	nutmeg	https://upload.wikimedia.org/wikipedia/commons/3/3b/Muscade.jpg	Myristica fragrans	Asia
17	honey	https://static.pexels.com/photos/8257/spoon-honey-jar.jpg	Fructose, glocuse	Worldwide
18	lemon juice	https://upload.wikimedia.org/wikipedia/commons/b/b0/Jif_Lemon.jpg	Citrus limon	Asia
19	maple syrup	https://upload.wikimedia.org/wikipedia/commons/1/18/Maple_syrup.jpg	\N	NorthAmerica
20	milk	https://upload.wikimedia.org/wikipedia/commons/0/0e/Milk_glass.jpg	\N	Worldwide
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
33	black turtle bean	\N	Phaseolus vulgaris	\N
34	allspice	\N	Pimenta dioica	\N
35	canned black turtle beans	\N	\N	\N
36	chickpea	\N	Cicer arietinum	\N
37	canned chickpeas	\N	\N	\N
38	frozen peas	https://upload.wikimedia.org/wikipedia/commons/e/e3/Frozen_peas.JPG	\N	Europe
39	yogurt	\N	\N	Europe
40	corn starch	\N	\N	\N
41	paprika	https://upload.wikimedia.org/wikipedia/commons/9/97/Spanishsmokedpaprika.jpg	Capsicum annuum	NorthAmerica
42	ground beef	https://upload.wikimedia.org/wikipedia/commons/d/d1/Hackfleisch-1.jpg	Bos taurus	Asia
43	parsley	https://upload.wikimedia.org/wikipedia/commons/9/97/Parsley.jpg	Petroselinum crispum	Europe
44	dried parsley	https://upload.wikimedia.org/wikipedia/commons/8/8c/Parsley_Dried.JPG	Petroselinum crispum	Europe
45	oregano	https://pixabay.com/static/uploads/photo/2014/04/10/15/39/oregano-321037_960_720.jpg	Origanum vulgare	Europe
46	sesame seed	https://upload.wikimedia.org/wikipedia/commons/3/38/Sesame_seeds.JPG	Sesamum indicum	Africa
47	tomato	https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg	Solanum lycopersicum	SouthAmerica
48	cumin	https://upload.wikimedia.org/wikipedia/commons/9/9d/4622_-_Cumino_al_mercato_di_Ortigia%2C_Siracusa_-_Foto_Giovanni_Dall'Orto%2C_20_marzo_2014.jpg	Cuminum cyminum	Africa
49	cumin seed	https://upload.wikimedia.org/wikipedia/commons/6/64/Cumin_seed_whole.JPG	Cuminum cyminum	Africa
50	brown sugar	\N	\N	\N
51	bean sprout	https://upload.wikimedia.org/wikipedia/commons/7/73/Moyashi.jpg	Vigna radiata	Asia
52	shrimp	https://upload.wikimedia.org/wikipedia/commons/1/11/Shrimp_Shell_%2811833859924%29.jpg	Penaeidae and Pandalidae	Worldwide
53	daikon	https://upload.wikimedia.org/wikipedia/commons/c/cb/Daikon.Japan.jpg	Raphanus sativus (Longipinratus Group)	Asia
54	shiitake mushroom	\N	Lentinus edodes	\N
55	mushroom	\N	Agaricus bisporus	\N
56	portabello mushroom	\N	Agaricus bisporus	\N
57	cooked shrimp	\N	\N	\N
58	black pepper	\N	Piper nigrum	\N
59	red pepper	https://upload.wikimedia.org/wikipedia/commons/9/91/Capsicum_frutescens.jpg	Capsicum frutescens or Capsicum annuum	NorthAmerica
60	white pepper	\N	Piper nigrum	\N
61	crushed red pepper	https://upload.wikimedia.org/wikipedia/commons/5/5b/Red_pepper_flakes.jpg	Capsicum annuum	NorthAmerica
62	pea	https://upload.wikimedia.org/wikipedia/commons/b/b2/1-Green_peas.jpg	Pisum sativum	Europe
63	chickpea flour	https://upload.wikimedia.org/wikipedia/commons/5/5e/Gram_flour_AvL.jpg	\N	\N
64	reduced fat milk	\N	\N	\N
65	lentil	https://upload.wikimedia.org/wikipedia/commons/8/81/Green_lentils.jpg	Lens culinaris	Asia
66	red lentil	https://upload.wikimedia.org/wikipedia/commons/a/a5/Red_lentils_-_jules.jpg	Lens culinaris	Asia
67	canned tomatoes	\N	\N	\N
68	canned crushed tomatoes	\N	\N	\N
69	cauliflower	\N	Brassica oleracea (Botrytis Group)	\N
70	tomato paste	https://upload.wikimedia.org/wikipedia/commons/e/e8/Tomato_paste_on_spoon.jpg	\N	\N
71	vegetable oil	https://c2.staticflickr.com/6/5589/14937958628_8f6fedc5a3_b.jpg	\N	\N
72	olive oil	https://pixabay.com/static/uploads/photo/2015/10/02/15/59/olive-oil-968657_960_720.jpg	\N	\N
73	cashew	https://upload.wikimedia.org/wikipedia/commons/f/fd/Cashews_1314.jpg	Anacardium occidentale	\N
74	soy sauce	https://upload.wikimedia.org/wikipedia/commons/a/a1/Kikkoman_Soy_Sauce%2C_Perspective-view%2C_jp-type%2C.jpg	\N	Asia
75	green chili pepper	\N	Capsicum frutescens	\N
76	red bell pepper	https://upload.wikimedia.org/wikipedia/commons/5/5c/Red_bell_pepper.jpg	Capsicum annuum	NorthAmerica
77	dried chili peppers	https://upload.wikimedia.org/wikipedia/commons/c/c4/Dry_Chili_pepper.jpg	Capsicum frutescens	Asia
78	chili paste	https://c2.staticflickr.com/6/5062/5662993808_68c2d841fa_b.jpg	Capsicum frutescens	Asia
79	canned tomato sauce	https://upload.wikimedia.org/wikipedia/commons/0/0f/Tomate_natural_triturado.jpg	\N	\N
80	curry	\N	\N	\N
81	orange bell pepper	https://upload.wikimedia.org/wikipedia/commons/0/08/Orange_bell-peppers_Rouffignac.jpg	Capsicum annuum	NorthAmerica
82	yellow bell pepper	https://upload.wikimedia.org/wikipedia/commons/f/f6/Yellow_Bell_Pepper_group_store.jpg	Capsicum annuum	NorthAmerica
83	rosemary	\N	Rosmarinus officinalis	\N
84	dried rosemary	\N	Rosmarinus officinalis	\N
85	thyme	\N	Thymus vulgaris	\N
86	dried thyme	\N	Thymus vulgaris	\N
87	basil	https://upload.wikimedia.org/wikipedia/commons/9/90/Basil-Basilico-Ocimum_basilicum-albahaca.jpg	Ocimum basilicum	Asia
88	dried basil	https://upload.wikimedia.org/wikipedia/commons/7/72/Basilic-spice.jpg	Ocimum basilicum	Asia
89	jam	\N	\N	\N
90	dried shrimp	https://upload.wikimedia.org/wikipedia/commons/a/a3/Dried_shrimp_Indonesia_udang_kering.JPG	\N	\N
91	chives	https://upload.wikimedia.org/wikipedia/commons/6/64/Chives_144211774.jpg	Allium schoenoprasum	\N
92	cilantro	\N	Coriandrum sativum	\N
93	dried coriander	\N	Coriandrum sativum	\N
94	green onion	\N	Allium cepa or Allium fistulosum	\N
95	chili powder	\N	\N	\N
96	sea salt	https://upload.wikimedia.org/wikipedia/commons/d/d8/Saltmill.jpg	Sodium chloride	\N
97	kosher salt	https://upload.wikimedia.org/wikipedia/commons/7/78/Kosher_Salt.JPG	Sodium chloride	\N
98	vinegar	\N	\N	\N
99	cider vinegar	\N	\N	\N
100	red wine vinegar	\N	\N	\N
101	balsamic vinegar	\N	\N	\N
102	canned tuna	\N	\N	\N
103	tuna	\N	Thunnus thynnus (L.)	\N
104	vegetable bouillon	\N	\N	\N
105	vegetable broth	\N	\N	\N
106	cooking spray	\N	\N	\N
107	scotch bonnet pepper	https://upload.wikimedia.org/wikipedia/commons/9/96/HotPeppersinMarket.jpg	Capsicum chinense	SouthAmerica
108	habanero	https://upload.wikimedia.org/wikipedia/commons/8/86/Habanero_closeup_edit2.jpg	Capsicum chinense	SouthAmerica
109	egg yolk	\N	\N	\N
110	whole-wheat flour	https://upload.wikimedia.org/wikipedia/commons/6/66/Whole_wheat_grain_flour_being_scooped.jpg	\N	\N
111	mixed vegetables	\N	\N	\N
112	canned pineapple	\N	\N	\N
113	pineapple	\N	\N	\N
114	sugar	https://upload.wikimedia.org/wikipedia/commons/a/a1/Raw_cane_sugar_light.JPG	Sucrose	Worldwide
115	half and half	\N	\N	\N
116	egg white	\N	\N	\N
117	almond	https://upload.wikimedia.org/wikipedia/commons/4/46/Almonds_macro_3.jpg	Prunus dulcis	Asia
118	chipotle peppers in adobo sauce	http://www.finecooking.com/CMS/uploadedImages/Images/Cooking/Articles/Issues_81-90/fc82kt080-03_xlg.jpg	\N	NorthAmerica
119	canned green chili peppers	\N	\N	NorthAmerica
120	bird's eye chili	https://upload.wikimedia.org/wikipedia/commons/3/35/Phrik_khi_nu.jpg	Capsicum annuum	Asia
121	curry paste	https://upload.wikimedia.org/wikipedia/commons/f/fe/Curry_pastes_Thailand.JPG	\N	Asia
122	cayenne pepper	http://www.dekookbijbel.be/images/ingredienten/Pepers/cayenne.jpg	Capsicum frutescens or Capsicum annuum	NorthAmerica
123	sweet onion	https://upload.wikimedia.org/wikipedia/commons/2/25/Sweet_onions_1.jpg	Allium cepa	NorthAmerica
124	barbecue sauce	\N	\N	\N
125	tamari	\N	\N	\N
126	sour cream	\N	\N	\N
127	low-fat sour cream	\N	\N	\N
128	red potato	\N	Solanum tuberosum	\N
129	Russet potato	\N	\N	\N
130	apple	https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg	Malus domestica	Europe
131	Granny Smith apple	https://upload.wikimedia.org/wikipedia/commons/d/d7/Granny_smith_and_cross_section.jpg	Malus domestica	Oceania
132	hot sauce	\N	\N	\N
133	Tabasco sauce	\N	\N	\N
134	vanilla extract	\N	\N	\N
135	jalapeno	https://upload.wikimedia.org/wikipedia/commons/d/d6/Immature_jalapeno_capsicum_annuum_var_annuum.jpeg	Capsicum anuum	NorthAmerica
136	cremini mushroom	\N	Agaricus bisporus	\N
137	Worcestershire sauce	https://upload.wikimedia.org/wikipedia/commons/d/d9/Lea_%26_Perrins_worcestershire_sauce_150ml.jpg	\N	Europe
138	lime	https://upload.wikimedia.org/wikipedia/commons/6/68/Lime-Whole-Split.jpg	Citrus latifolia	Asia
139	lime juice	https://upload.wikimedia.org/wikipedia/commons/6/68/Lime-Whole-Split.jpg	Citrus latifolia	Asia
140	grapeseed oil	https://upload.wikimedia.org/wikipedia/commons/2/2a/Grapeseed-oil.jpg	\N	\N
141	ginger	https://pixabay.com/static/uploads/photo/2014/07/11/14/41/ginger-389906_960_720.jpg	Zingiber officinale	\N
142	ground ginger	https://upload.wikimedia.org/wikipedia/commons/c/c4/Ginger_powder.JPG	Zingiber officinale	\N
143	garlic powder	https://upload.wikimedia.org/wikipedia/commons/e/ef/Garlic_Powder%2C_Penzeys_Spices%2C_Arlington_Heights_MA.jpg	Allium sativum	\N
144	sage	https://pixabay.com/static/uploads/photo/2013/01/08/01/23/sage-74325_960_720.jpg	Salvia officinalis	\N
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
156	lettuce	\N	Lactuca sativa var. capitata	\N
157	romaine lettuce	\N	Lactuca sativa var. logifolia	\N
158	iceberg lettuce	\N	Lactuca sativa var. capitata	\N
159	harissa	https://upload.wikimedia.org/wikipedia/commons/8/86/Harissa-1.jpg	\N	Africa
160	serrano peppers	https://upload.wikimedia.org/wikipedia/commons/1/15/Serranochilis.jpg	Capsicum anuum	NorthAmerica
161	Greek yogurt	\N	\N	\N
162	turmeric	\N	Curcuma longa L.	\N
163	fish sauce	\N	\N	\N
164	spinach	\N	Spinacia oleracea	\N
165	frozen spinach	\N	\N	\N
166	onion powder	\N	Allium cepa	\N
167	pasilla	https://upload.wikimedia.org/wikipedia/commons/d/d5/Pasillachiles.jpg	Capsicum anuum	NorthAmerica
168	cheddar cheese	\N	\N	\N
\.


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 172
-- Name: Ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Ingredient_id_seq"', 169, TRUE);

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
2	66	1 cup brown lentils	1.0	cup	c	1
2	69	1 can crushed tomatoes	1.0	can	can	2
2	70	1 cauliflower head, cut into bite size pieces	1.0	\N	\N	3
2	23	2 garlic cloves, minced	2.0	cloves	cloves	5
2	4	1 onion, diced	1.0	\N	\N	6
2	38	2 cups frozen peas	2.0	cups	c	7
2	71	1 can tomato paste	1.0	can	can	9
2	72	2 tablespoons vegetable oil	2.0	tablespoons	T	10
3	37	14 ounces can chickpeas (garbanzo beans), drained and rinsed	14.0	ounces	oz	0
3	143	1 tablespoon grapeseed or canola oil	1.0	tablespoon	T	1
3	23	10 Cloves garlic, (3 tbsp.) minced	3.0	tbsp	T	2
3	25	1 leek, finely chopped	1.0	\N	\N	4
3	18	A tablespoon of lemon juice	1.0	tablespoon	T	5
3	4	1 small Onion, minced	1.0	\N	\N	6
3	71	3 tablespoons tomato paste or ketchup (yep, ketchup works great!)	3.0	tablespoons	T	9
3	7	1 liter (4 cups) water, chicken broth, vegetable broth	4.0	cups	c	10
4	3	Bell Peppers for garnishing	1.0	serving	serving	0
4	81	1 teaspoon of Curry	1.0	teaspoon	t	3
4	23	2 garlic cloves	2.0	cloves	cloves	4
4	4	2 handfuls of Chopped onions	2.0	handfuls	handfuls	6
4	59	Pepper	1.0	serving	serving	7
4	6	Salt	1.0	serving	serving	8
4	86	Pinch of thyme	1.0	pinch	pinch	10
4	48	1 Chopped small tomato	1.0	\N	\N	11
4	80	1.5 cups of Blended tomato	1.5	cups	c	12
4	5	1 cup of groundnut (Blended) or peanut Butter	1.0	cup	c	13
5	81	1 Teaspoon of curry powder	1.0	Teaspoon	Teaspoon	1
5	23	1 Clove of garlic	1.0	Clove	Clove	2
5	106	3 Cubes of Maggi	3.0	\N	\N	3
5	4	1 Small bulb of Onion	1.0	\N	\N	4
5	59	1 Teaspoon of dry pepper	1.0	Teaspoon	Teaspoon	5
5	48	7 Medium sized Roma Tomatoes	7.0	\N	\N	7
5	6	2 Teaspoons of Salt	2.0	Teaspoons	Teaspoons	8
5	109	3 Scotch Bonnet Peppers	3.0	\N	\N	9
5	86	A pinch of Thyme	1.0	pinch	pinch	10
5	72	2 Cooking spoons of Vegetable Oil	2.0	tablespoons	T	12
5	7	3 Cups of water	3.0	Cups	Cups	13
6	81	1 teaspoon of curry	1.0	teaspoon	t	0
6	23	2 garlic cloves	2.0	cloves	cloves	1
6	106	Seasoning cubes	2.0	cubes	cubes	3
6	113	1/2 cup of chopped vegetables (optional)	0.5	cup	c	4
6	4	1 small onion (chopped)	1.0	\N	\N	5
6	114	1/2 cup of chopped pineapples	0.5	cup	c	6
6	86	1/4 teaspoon of thyme	0.25	teaspoon	t	9
6	71	2 tablespoons of tomato paste	2.0	tablespoons	T	10
6	3	bell pepper	1.0	\N	\N	12
6	109	scotch bonnet pepper	1.0	\N	\N	13
6	72	1.5 cooking spoons of vegetable oil	1.5	tablespoons	T	14
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
8	9	2 medium bananas	2.0	\N	\N	1
8	5	1 3/4 cups organic creamy peanut butter	1.75	cups	c	5
8	14	3 Eggs	3.0	\N	\N	6
8	98	1 1/2 teaspoons Kosher Salt	1.5	teaspoons	t	9
8	51	1/2 cup organic light brown sugar, packed	0.5	cup	c	10
8	136	1 teaspoon vanilla extract	1.0	teaspoon	t	15
9	126	1/2 cup barbecue sauce	0.5	cup	c	0
9	4	6 Sliced rings of red onion (up to 8)	6.0	\N	\N	2
10	4	chopped onions, to taste	6.0	servings	servings	2
10	77	chopped red peppers, to taste	6.0	servings	servings	3
10	15	1 1/4 cups all-purpose flour	1.25	cups	c	5
10	116	1 tablespoon granulated sugar or honey	1.0	tablespoon	T	6
10	73	1/4 cup olive oil	0.25	cup	c	7
10	6	1 teaspoon of salt	1.0	teaspoon	t	8
10	7	1 1/4 cups warm water	1.25	cups	c	9
10	15	1 1/4 cups all-purpose flour	1.25	cups	c	10
11	10	3 tablespoons butter, divided	3.0	tablespoons	T	0
11	4	1/2 onion, finely chopped	0.5	\N	\N	5
11	139	1 teaspoon Worcestershire	1.0	teaspoon	t	7
12	120	1 tbs Chilis in Adobo sauce	1.0	tbs	tbs	0
12	101	2 tablespoons apple cider vinegar	2.0	tablespoons	T	1
12	51	1/3 cup brown sugar	0.3333333333333333	cup	c	4
12	124	1 cayenne pepper	1.0	\N	\N	5
12	59	1 Tbs fresh cracked black pepper	1.0	Tb	Tb	6
12	23	1 clove clove garlic, minced	1.0	clove	clove	8
12	49	1 Tbs ground cumin	1.0	Tb	Tb	9
12	17	1/4 cup honey	0.25	cup	c	10
12	98	2 Tbs kosher salt – plus any additional to taste at end	2.0	Tb	Tb	12
12	4	1 cup chopped onions	1.0	cup	c	14
12	59	1/2 tsp fresh cracked black peppers	0.5	tsp	t	15
12	62	1/4 tsp red pepper flakes	0.25	tsp	t	16
12	6	2 teaspoons salt	2.0	teaspoons	t	17
12	41	1 tbsp smoked paprika	1.0	tbsp	T	18
12	125	2 large sweet onions – slice very thin	2.0	\N	\N	19
13	35	2 cans (15 ounce) black beans, rinsed and drained	15.0	ounce	oz	1
13	93	1 bunch of fresh cilantro, stems removed, leaves finely chopped	1.0	bunch	bunch	3
13	23	4 tablespoons minced garlic	4.0	tablespoons	T	4
13	3	1 green bell pepper, cored, seeded, and diced	1.0	\N	\N	5
13	95	1 bunch green onions, sliced	1.0	bunch	bunch	6
13	134	1/4 teaspoon hot sauce, or to taste	0.25	teaspoon	t	7
13	142	1/4 juice of lime	0.25	\N	\N	8
13	82	1 orange bell pepper, cored, seeded, and diced	1.0	\N	\N	9
13	4	1/2 of a medium red onion, finely chopped	0.5	\N	\N	10
13	48	2 cans Rotel tomatoes	2.0	cans	cans	12
13	83	1 yellow bell pepper, cored, seeded, and diced	1.0	\N	\N	13
14	103	1 ounce quality balsamic vinegar	1.0	ounce	oz	0
14	35	1 can (15 oz) black beans, drained	15.0	oz	oz	1
14	45	1 teaspoon dried oregano	1.0	teaspoon	t	4
14	93	1/2 bunch fresh cilantro, leaves only	0.5	bunch	bunch	5
14	23	2 cloves garlic	2.0	cloves	cloves	6
14	3	1 green bell pepper, fine-chopped	1.0	\N	\N	8
14	49	1 teaspoon ground cumin	1.0	teaspoon	t	9
14	73	1 ounce extra-virgin olive oil	1.0	ounce	oz	12
14	102	2 oz red wine vinegar	2.0	oz	oz	13
14	6	1/2 teaspoon each salt, ground black pepper, and garlic powder	0.5	teaspoon	t	14
14	95	1 bunch scallions, including light green tops, sliced across into angled rings	1.0	bunch	bunch	15
14	4	1/2 large yellow onion, nicely chopped	0.5	\N	\N	16
15	8	1 tablespoon Baking Powder	1.0	tablespoon	T	0
15	10	3 tablespoons Butter, melted	3.0	tablespoons	T	1
15	12	Pinch of Cinnamon	1.0	pinch	pinch	5
15	49	1/2 teaspoon Cumin	0.5	teaspoon	t	7
15	14	2 Eggs	2.0	\N	\N	8
15	15	1 cup all-purpose Flour	1.0	cup	c	10
15	23	5 cloves Garlic, minced	5.0	cloves	cloves	12
15	98	Sea or Kosher salt and Fresh Black Pepper	8.0	servings	servings	15
15	20	1 cup Milk	1.0	cup	c	16
15	16	Pinch of Nutmeg	1.0	pinch	pinch	17
15	73	Olive oil for sauteing	8.0	servings	servings	18
15	45	1 teaspoon Oregano	1.0	teaspoon	t	19
15	62	Red Pepper, optional	8.0	servings	servings	20
15	41	1/2 teaspoon Paprika, smoked or regular	0.5	teaspoon	t	21
15	128	1/2 cup Sour Cream, plus more for serving	0.5	cup	c	22
15	7	1/2 cup water	0.5	cup	c	24
15	139	2 teaspoons Worcestershire Sauce	2.0	teaspoons	t	25
15	4	2 large yellow onions, diced	2.0	\N	\N	26
16	51	� cup brown sugar	0.5	cup	c	1
16	101	3/4 cup cider vinegar	0.75	cup	c	4
16	49	2 teaspoons cumin	2.0	teaspoons	t	5
16	87	2 teaspoons dried thyme	2.0	teaspoons	t	7
16	23	1 Clove Garlic, Minced	1.0	Clove	Clove	8
16	49	2 teaspoons ground cumin	2.0	teaspoons	t	10
16	41	2 teaspoons paprika	2.0	teaspoons	t	15
16	6	� tsp. salt	0.5	tsp	t	17
16	75	1/2 cup soy sauce	0.5	cup	c	18
17	10	1/2 cup butter, cut into cubes	0.5	cup	c	1
17	14	3 eggs	3.0	\N	\N	3
17	15	1 1/4 cups flour	1.25	cups	c	4
17	116	1/2 cup sugar	0.5	cup	c	7
17	136	1 tablespoon vanilla extract	1.0	tablespoon	T	8
18	59	to taste Freshly-ground black pepper	4.0	servings	servings	1
18	73	extra-virgin olive oil	4.0	servings	servings	7
18	88	handful fresh basil, torn	1.0	handful	handful	8
18	23	pickled garlic (from your favorite olive bar)	4.0	servings	servings	9
18	23	6 cloves garlic chopped	6.0	cloves	cloves	10
18	17	1 tbsp wild honey	1.0	tbsp	T	11
18	17	2 tablespoons Honey	2.0	tablespoons	T	12
18	62	dried red pepper flakes	4.0	servings	servings	14
18	97	pinch sea salt	1.0	pinch	pinch	15
18	7	1 cup warm water	1.0	cup	c	16
19	18	2 tablespoons freshly squeezed lemon juice	2.0	tablespoons	T	1
19	73	1 tablespoon Olive oil	1.0	tablespoon	T	2
19	41	1/4 teaspoon paprika	0.25	teaspoon	t	3
19	6	1/4 teaspoon salt	0.25	teaspoon	t	8
20	37	29 oz. can chick peas – drained	29.0	oz	oz	0
20	23	3 cloves Garlic Crushed	3.0	cloves	cloves	2
20	49	1/2 teaspoon ground cumin	0.5	teaspoon	t	3
20	137	1 marinated jalapeño – with seeds	1.0	\N	\N	4
20	142	1 Zest of lime – plus juice of lime	1.0	\N	\N	5
20	73	3 tablespoons of olive oil	3.0	tablespoons	T	6
20	4	Red onion- grilled	1.0	serving	serving	7
21	15	4 cups of all purpose flour	4.0	cups	c	0
21	68	2 large cans of peeled tomatoes	2.0	cans	cans	1
21	23	4 cloves large of garlic, chopped	4.0	cloves	cloves	3
21	73	2 tablespoons Olive oil	2.0	tablespoons	T	4
21	4	2 large onions, chopped	2.0	\N	\N	5
21	85	1 teaspoon rosemary	1.0	teaspoon	t	7
21	87	1 teaspoon thyme	1.0	teaspoon	t	8
21	89	1 teaspoon basil	1.0	teaspoon	t	9
21	45	1 teaspoon oregano	1.0	teaspoon	t	10
21	116	6 cups Sugar	6.0	cups	c	11
21	7	cups of warm water	1.0	cups	c	12
21	6	salt	1.0	serving	serving	13
21	61	white pepper	1.0	serving	serving	14
22	3	1 medium bell pepper, chopped	1.0	\N	\N	0
22	92	chopped chives or green onions, to taste	8.0	servings	servings	2
22	93	finely chopped cilantro, to taste***	8.0	servings	servings	3
22	23	2 garlic cloves, minced	2.0	cloves	cloves	4
22	4	1/2 cup (1 small to medium) yellow or purple onion, chopped (the purple is sweeter)	0.5	cup	c	6
22	48	2 mediums tomatoes, chopped	2.0	\N	\N	8
23	138	10 ounces baby bella mushrooms, thickly sliced	10.0	ounces	oz	0
23	87	1 teaspoon dried thyme	1.0	teaspoon	t	3
23	14	1 large egg and 1 egg white, lightly beaten	1.0	\N	\N	4
23	73	1/4 cup olive oil	0.25	cup	c	6
23	59	teaspoon salt and fresh ground pepper to taste (I used about 1/2 each)	1.0	teaspoon	t	7
23	125	1 medium sweet onion, diced	1.0	\N	\N	9
24	5	1 cup Creamy peanut butter, (up to 1-1/2)	1.0	cup	c	1
24	116	3/4 cup sugar	0.75	cup	c	6
24	136	1/4 teaspoon vanilla extract	0.25	teaspoon	t	7
26	9	2 bananas, smashed (I used frozen)	2.0	\N	\N	1
26	5	1/2 cup peanut butter	0.5	cup	c	2
27	8	1 tablespoon Baking powder	1.0	tablespoon	T	0
27	9	2 Bananas,ripe, mashed	2.0	\N	\N	1
27	51	1/2 cup packed brown sugar	0.5	cup	c	2
27	14	2 Eggs	2.0	\N	\N	3
27	15	1 3/4 cups flour	1.75	cups	c	4
27	20	1/4 cup Milk	0.25	cup	c	5
27	5	1/2 cup peanut butter	0.5	cup	c	6
27	6	1/2 teaspoon salt	0.5	teaspoon	t	7
27	72	2 tablespoons Vegetable oil	2.0	tablespoons	T	8
28	10	3/4 cup butter or margarine melted	0.75	cup	c	0
28	13	1/2 cup cream cheese	0.5	cup	c	3
28	5	1 cup natural peanut butter	1.0	cup	c	6
28	6	1/4 teaspoon salt	0.25	teaspoon	t	7
30	8	1 tablespoon baking powder	1.0	tablespoon	T	0
30	10	2 tablespoons Butter or margarine	2.0	tablespoons	T	1
30	14	4 large eggs, room temperature	4.0	\N	\N	2
30	15	2 1/2 cups sifted all-purpose flour	2.5	cups	c	3
30	20	1 cup milk	1.0	cup	c	7
30	6	Pinch of salt	1.0	pinch	pinch	9
30	116	1 1/4 cups sugar	1.25	cups	c	10
30	136	1 tablespoon vanilla extract	1.0	tablespoon	T	11
31	101	1/4 cup apple cider vinegar	0.25	cup	c	0
31	50	1/2 teaspoon cumin seeds	0.5	teaspoon	t	1
31	51	2 tablespoons dark brown sugar	2.0	tablespoons	T	2
31	98	Kosher salt	4.0	servings	servings	5
31	142	1/2 cup fresh lime juice	0.5	cup	c	6
31	4	1 onion, finely minced	1.0	\N	\N	9
31	41	1 tablespoon paprika	1.0	tablespoon	T	10
31	72	1/4 cup vegetable oil	0.25	cup	c	14
31	139	1/4 cup Worcestershire sauce	0.25	cup	c	15
32	126	2 teaspoons barbecue sauce	2.0	teaspoons	t	0
32	30	1 teaspoon hoisin sauce	1.0	teaspoon	t	2
32	17	2 teaspoons honey	2.0	teaspoons	t	3
32	97	Kosher salt or sea salt	2.0	servings	servings	6
33	8	1 tablespoon baking powder	1.0	tablespoon	T	0
33	23	Bulb of garlic	1.0	lb	lb	1
33	73	1 Tablespoon olive oil	1.0	Tablespoon	Tablespoon	2
33	4	1 red onion, cubed	1.0	\N	\N	3
33	84	1 tsp rosemary	1.0	tsp	t	5
33	6	1/2 teaspoon salt	0.5	teaspoon	t	6
33	86	1 tsp thyme	1.0	tsp	t	10
33	7	4 cups of water	4.0	cups	c	11
33	112	1 cup whole wheat flour	1.0	cup	c	12
34	15	1 cup of all purpose flour	1.0	cup	c	0
34	59	1 teaspoon of black pepper	1.0	teaspoon	t	1
34	96	1 teaspoon of chili powder	1.0	teaspoon	t	4
34	14	2 eggs	2.0	\N	\N	5
34	23	1 garlic clove	1.0	clove	clove	6
34	6	Pinch of Salt	1.0	pinch	pinch	10
35	132	1 Sweet apple, peeled, cored, and sliced	1.0	\N	\N	0
35	132	4 Sweet apples, whole, cored, peel intact	4.0	\N	\N	1
35	43	2 Tbsps Chopped fresh parsley	2.0	Tbsps	Tbsps	6
35	16	1/8 tsp Grated nutmeg	0.125	tsp	t	10
35	4	2 medium Onions, peeled and sliced thin	2.0	\N	\N	11
35	97	1/2 tsp Finely ground sea salt	0.5	tsp	t	14
35	61	1/8 tsp Freshly ground white pepper	0.125	tsp	t	15
36	10	75 grams butter	75.0	grams	g	0
36	111	1 free-range egg yolk	1.0	\N	\N	1
36	20	55 milliliters milk	55.0	milliliters	ml	4
36	73	2 tablespoons olive oil	2.0	tablespoons	T	5
36	4	2 onions, finely chopped	2.0	\N	\N	6
36	15	2 tablespoons plain flour	2.0	tablespoons	T	7
36	27	700 grams potatoes	700.0	grams	g	8
36	84	rosemary	4.0	servings	servings	9
36	86	thyme	4.0	servings	servings	11
36	68	1 small tin chopped tomatoes	1.0	\N	\N	12
37	10	1 cup butter	1.0	cup	c	0
37	14	1 large egg, lightly beaten	1.0	\N	\N	2
37	14	4 medium eggs	4.0	\N	\N	3
37	15	1 3/4 cups all-purpose flour	1.75	cups	c	4
37	18	1 Zest and juice of lemon	1.0	\N	\N	6
37	6	1/2 teaspoon salt	0.5	teaspoon	t	8
37	116	1/4 cup confectioner's sugar	0.25	cup	c	9
38	20	3 cups milk	3.0	cups	c	4
39	8	4 teaspoons baking powder	4.0	teaspoons	t	0
39	10	1 stick butter, melted	1.0	stick	stick	1
39	15	1 1/4 cups all-purpose flour	1.25	cups	c	3
39	20	1/2 cup milk	0.5	cup	c	4
39	6	1/2 teaspoon salt	0.5	teaspoon	t	7
39	7	2/3 cup water	0.6666666666666666	cup	c	8
40	10	4 tablespoons (1/2 stick) butter, softened	4.0	tablespoons	T	0
40	2	1 pound carrots, peeled and sliced	1.0	pound	lb	1
40	15	1/2 cup flour	0.5	cup	c	4
40	134	A few dashes of hot sauce	3.0	dashes	dashes	6
40	98	Kosher salt and freshly ground black pepper	6.0	servings	servings	7
40	73	2 tablespoons olive oil)	2.0	tablespoons	T	8
40	38	1 (10-ounce) package frozen peas	10.0	ounce	oz	9
40	131	2 1/2 pounds russet potatoes, peeled and cubed	2.5	pounds	lb	11
40	125	1 sweet yellow onion, peeled and diced	1.0	\N	\N	13
41	20	3/4 cup milk	0.75	cup	c	0
41	10	50g unsalted butter, softened	50.0	g	g	3
42	111	2 Egg yolks	2.0	\N	\N	2
42	56	400 grams mushrooms	400.0	grams	g	3
42	73	Olive oil	2.0	servings	servings	4
43	10	2 tablespoons butter	2.0	tablespoons	T	1
43	2	1 carrot, peeled and finely chopped	1.0	\N	\N	2
43	13	2 tablespoons cream cheese (or sour cream)	2.0	tablespoons	T	3
43	111	1 large egg yolk	1.0	\N	\N	4
43	15	2 tablespoons all-purpose flour	2.0	tablespoons	T	5
43	43	2 tablespoons chopped fresh parsley leaves, for garnish	2.0	tablespoons	T	6
43	86	2 teaspoons thyme (fresh or dried)	2.0	teaspoons	t	7
43	20	1/2 cup 1% milk (or heavy cream for richer flavor)	0.5	cup	c	9
43	73	1 tablespoon extra-virgin olive oil, 1 turn of the pan	1.0	tablespoon	T	10
43	4	1 onion, chopped	1.0	\N	\N	11
43	38	1/2 cup to 1 frozen peas, a couple of handfuls	0.5	cup	c	12
43	131	2 pounds potatoes, such as russet, peeled and cubed	2.0	pounds	lb	13
43	41	1 teaspoon sweet paprika	1.0	teaspoon	t	15
43	71	2 tablespoons tomato paste	2.0	tablespoons	T	16
43	139	2 teaspoons Worcestershire, eyeball it	2.0	teaspoons	t	17
44	8	2 teaspoons baking powder	2.0	teaspoons	t	2
44	16	1 teaspoon ground nutmeg	1.0	teaspoon	t	7
44	6	1/2 teaspoon salt	0.5	teaspoon	t	10
44	136	2 teaspoons vanilla extract	2.0	teaspoons	t	11
45	10	1 teaspoon butter	1.0	teaspoon	t	0
45	70	1 head cauliflower	1.0	head	head	1
45	13	1 tablespoon fat-free cream cheese	1.0	tablespoon	T	3
45	15	1 teaspoon flour	1.0	teaspoon	t	4
45	20	1/4 cup milk	0.25	cup	c	5
45	56	1 cup mushrooms, sliced	1.0	cup	c	6
45	4	1/2 yellow onion	0.5	\N	\N	10
46	8	1 1/2 teaspoons baking powder	1.5	teaspoons	t	0
46	14	1 egg, slightly beaten	1.0	\N	\N	2
46	18	tablespoon of lemon juice	1.0	tablespoon	T	3
46	20	175 milliliters milk	175.0	milliliters	ml	4
46	6	1/4 teaspoon salt	0.25	teaspoon	t	5
46	10	1 stick unsalted butter, softened at room temperature	1.0	stick	stick	7
46	136	1/2 teaspoon vanilla extract	0.5	teaspoon	t	8
47	4	2 tablespoons chopped onion	2.0	tablespoons	T	3
47	27	4 mediums potatoes, peeled and quartered	4.0	\N	\N	4
47	6	Salt to taste	4.0	servings	servings	6
48	15	2 cups all purpose flour	2.0	cups	c	0
48	8	2 teaspoons baking powder	2.0	teaspoons	t	1
48	10	1 tablespoon Butter	1.0	tablespoon	T	3
48	14	1 large egg, beaten well	1.0	\N	\N	4
48	14	Egg mixture to brush on the top of the scones	4.0	servings	servings	5
48	14	2 eggs	2.0	\N	\N	6
48	90	Thick jam or fruit preserves	4.0	servings	servings	7
48	116	1/4 cup granulated white sugar	0.25	cup	c	8
48	20	cup milk	1.0	cup	c	9
48	20	1 tablespoon milk	1.0	tablespoon	T	10
48	6	Salt , to taste	4.0	servings	servings	11
48	136	1 1/2 teaspoons pure vanilla extract	1.5	teaspoons	t	12
49	8	1 teaspoon baking powder	1.0	teaspoon	t	0
49	51	milk to brush and brown sugar to top	4.0	servings	servings	2
49	10	1 pound Butter or margarine	1.0	pound	lb	3
49	15	4 cups Flour	4.0	cups	c	6
49	6	1 pinch salt	1.0	pinch	pinch	7
49	116	1 cup sugar	1.0	cup	c	9
49	136	2 milliliters (�) tsp vanilla extract	2.0	milliliters	ml	10
50	8	2 1/4 teaspoon baking powder	2.25	teaspoon	t	0
50	10	2 tablespoons Butter	2.0	tablespoons	T	1
50	12	1/4 teaspoon cinnamon	0.25	teaspoon	t	2
50	14	1 egg lightly beaten mixed with a tablespoon of water for egg wash	1.0	\N	\N	3
50	15	2 cup flour	2.0	cup	c	4
50	116	1/3 cup granulated white sugar	0.3333333333333333	cup	c	5
50	20	2-3 tablespoon milk	2.0	tablespoon	T	8
50	6	3/4 teaspoon salt	0.75	teaspoon	t	10
51	20	500 milliliters milk	500.0	milliliters	ml	4
51	116	2 tablespoons of sugar (add more if you want to have the sweet custard)	2.0	tablespoons	T	6
52	2	1 carrot	1.0	\N	\N	0
52	14	2 eggs ( or egg substitutes for vegans, you can also add 3-4 tbsp dry yeast flakes)	2.0	\N	\N	2
52	59	1/2 tsp ground pepper	0.5	tsp	t	3
52	56	1 kg mushrooms	1.0	kg	kg	4
52	4	2 onions, diced	2.0	\N	\N	5
52	43	1 bunch of parsley, chopped	1.0	bunch	bunch	6
52	77	1 red bell pepper	1.0	\N	\N	7
52	97	sea salt, to taste	12.0	servings	servings	9
52	86	1 tbsp dry thyme	1.0	tbsp	T	13
53	14	1 egg, separated	1.0	\N	\N	2
53	20	2 tsps milk	2.0	tsps	t	3
53	56	1 8 oz. pkg. mushrooms, finely chopped	8.0	oz	oz	4
53	4	1 med. sized onion, minced	1.0	\N	\N	5
53	6	1/2 tsp salt	0.5	tsp	t	10
54	10	3 Tbsps butter	3.0	Tbsps	Tbsps	2
54	14	1 beaten egg	1.0	\N	\N	3
54	23	1 clove garlic, cut before using	1.0	clove	clove	4
54	56	1 cup finely chopped mushrooms	1.0	cup	c	7
55	93	1 teaspoon freshly chopped cilantro- optional	1.0	teaspoon	t	1
55	73	1 teaspoon extra-virgin olive oil	1.0	teaspoon	t	3
55	6	salt, to taste	4.0	servings	servings	4
55	48	1 tomato	1.0	\N	\N	6
56	9	8 bananas	8.0	\N	\N	0
56	51	1/2 cup Brown sugar	0.5	cup	c	1
56	10	1/2 cup butter	0.5	cup	c	2
56	12	1 teaspoon cinnamon	1.0	teaspoon	t	3
56	14	10 Eggs	10.0	\N	\N	4
56	117	1/4 cup Half& Half	0.25	cup	c	5
56	19	1/4 cup Maple Syrup	0.25	cup	c	8
56	6	1/2 teaspoon Salt	0.5	teaspoon	t	9
56	116	1/4 cup Sugar	0.25	cup	c	10
57	9	1 cup Bananas (mashed)	1.0	cup	c	0
57	10	1/2 cup butter	0.5	cup	c	1
57	111	4 egg yolks	4.0	\N	\N	2
57	116	1/2 cup granulated sugar, divided	0.5	cup	c	3
57	98	1/8 teaspoon kosher salt	0.125	teaspoon	t	5
57	51	1/4 cup light brown sugar	0.25	cup	c	6
57	20	1 1/4 cups whole milk	1.25	cups	c	9
58	95	2 bunches green onions, chopped	2.0	bunches	bunches	1
58	4	1 large onion, chopped	1.0	\N	\N	2
58	43	1 bunch parsley, chopped	1.0	bunch	bunch	3
58	6	5 teaspoons salt	5.0	teaspoons	t	7
59	59	1 1/2 teaspoons freshly-ground black pepper	1.5	teaspoons	t	0
59	23	4 cloves garlic finely chopped	4.0	cloves	cloves	4
59	3	1/2 cup chopped green bell peppers	0.5	cup	c	5
59	4	1 cup chopped onions	1.0	cup	c	6
59	4	1 cup chopped green onions tops (green part only)	1.0	cup	c	7
59	43	1 cup finely-chopped parsley	1.0	cup	c	8
59	6	2 teaspoons salt	2.0	teaspoons	t	11
59	7	2 quarts water	2.0	quarts	quarts	13
60	59	1 tsp black pepper	1.0	tsp	t	0
60	68	1 14.5 oz can petite diced tomatoes	14.5	oz	oz	3
60	2	2 carrots, diced	2.0	\N	\N	4
60	23	3 garlic cloves, minced	3.0	cloves	cloves	7
60	95	1/2 cup green onions, chopped	0.5	cup	c	8
60	4	1 onion, diced	1.0	\N	\N	11
60	43	1/3 cup parsley, chopped	0.3333333333333333	cup	c	12
60	6	1 tsp salt	1.0	tsp	t	13
60	71	2 Tbsp tomato paste	2.0	Tbsp	Tbsp	14
60	7	3/4 cup water	0.75	cup	c	16
60	7	3 1/2 cups water	3.5	cups	c	17
61	22	3 strips of Bacon	3.0	strips	strips	0
61	3	1 Bell Pepper, any Color, Chopped	1.0	\N	\N	1
61	23	3 cloves of Garlic, Minced	3.0	cloves	cloves	4
61	95	3 Green Onions, Chopped	3.0	\N	\N	6
61	45	1/2 teaspoon of Oregano	0.5	teaspoon	t	12
61	59	Pepper to taste	1.0	serving	serving	13
61	6	1/4 tsp salt	0.25	tsp	t	14
62	124	1 tsp cayenne pepper	1.0	tsp	t	0
62	73	3 tbsp olive oil	3.0	tbsp	T	3
62	41	2 tsp paprika	2.0	tsp	t	5
62	59	1/2 tsp pepper	0.5	tsp	t	6
62	131	2 large russet potatoes	2.0	\N	\N	7
62	6	¾ tsp salt	0.75	tsp	t	8
63	61	1/2 t white pepper	0.5	t	t	2
63	59	1 Tablespoon Black Pepper	1.0	Tablespoon	Tablespoon	3
63	124	1 Tablespoon Cayenne Pepper	1.0	Tablespoon	Tablespoon	4
63	45	1 Tablespoon Dried Oregano	1.0	Tablespoon	Tablespoon	9
63	87	1 Tablespoon Dried Thyme	1.0	Tablespoon	Tablespoon	10
63	23	3 large cloves of garlic, chopped	3.0	cloves	cloves	11
63	137	1 jalapeno pepper, seeded	1.0	\N	\N	12
63	77	1 red or orange Bell pepper, chopped coarse	1.0	\N	\N	13
63	53	1 pound shrimp	1.0	pound	lb	16
63	15	1/2 C white flour	0.5	C	C	17
64	22	3 slices of Bacon	3.0	slices	slices	1
64	23	3 cloves of garlic, crushed	3.0	cloves	cloves	5
64	4	1 Small Onion, Chopped	1.0	\N	\N	9
64	53	1 pound Peeled and Cooked Shrimp	1.0	pound	lb	11
64	48	14 1/2 Oz. Can of Diced Tomatoes	14.0	\N	\N	12
65	102	2 tablespoons white wine vinegar (red wine vinegar also works well)	2.0	tablespoons	T	3
65	53	8 ounces large uncooked shrimp, peeled with tails on (about 20), thawed	8.0	ounces	oz	5
66	10	2 tablespoons butter, divided	2.0	tablespoons	T	0
66	68	1 cup canned chopped tomatoes	1.0	cup	c	1
66	15	cup all-purpose flour	1.0	cup	c	6
66	43	1 tablespoon chopped fresh parsley	1.0	tablespoon	T	7
66	23	2 garlic cloves minced	2.0	cloves	cloves	8
66	3	1/2 green bell pepper, minced	0.5	\N	\N	9
66	95	1 bunch green onions, finely chopped	1.0	bunch	bunch	10
66	4	2 tablespoons onion, finely chopped	2.0	tablespoons	T	12
66	43	Garnish: chopped fresh parsley	8.0	servings	servings	14
66	6	salt	8.0	servings	servings	16
67	88	1 teaspoon basil	1.0	teaspoon	t	0
67	80	8 ounces can tomato sauce	8.0	ounces	oz	2
67	68	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	3
67	23	20 grams garlic finely chopped	20.0	grams	g	7
67	3	1 green pepper	1.0	\N	\N	8
67	4	3/4 cup onion, chopped	0.75	cup	c	10
67	41	paprika, to taste	10.0	servings	servings	11
67	86	1/2 teaspoon thyme	0.5	teaspoon	t	14
68	68	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	1
68	124	1/2 teaspoon cayenne pepper	0.5	teaspoon	t	2
68	87	1/4 tsp. dried thyme	0.25	tsp	t	8
68	23	4 garlic cloves crushed	4.0	cloves	cloves	9
68	4	3/4 cup onion, chopped	0.75	cup	c	12
68	77	1 red bell pepper diced	1.0	\N	\N	13
68	53	1/2 pound medium shrimp peeled, deveined	0.5	pound	lb	14
69	68	1 14.5-oz. can fire-roasted diced tomatoes, no salt added	14.5	oz	oz	2
69	45	1/4 tsp. dried oregano	0.25	tsp	t	5
69	87	1/4 tsp. dried thyme	0.25	tsp	t	6
69	23	16 Garlic , peeled	16.0	\N	\N	7
69	134	1/2 tsp. hot sauce, or more to taste	0.5	tsp	t	8
69	4	3/4 cup onion, chopped	0.75	cup	c	10
69	83	1 large green bell pepper, seeded, chopped � I used yellow	1.0	\N	\N	12
70	68	1 can whole peeled tomatoes, chopped	1.0	can	can	3
70	87	1/2 teaspoon dried thyme	0.5	teaspoon	t	6
70	15	1/2 cup flour	0.5	cup	c	8
70	23	3 cloves of garlic, minced	3.0	cloves	cloves	9
70	95	1 cup chopped green onions	1.0	cup	c	10
70	3	2 green peppers, chopped	2.0	\N	\N	11
70	59	2 teaspoons ground black pepper	2.0	teaspoons	t	12
70	4	1 large onion, chopped	1.0	\N	\N	14
70	43	1/2 cup chopped parsley	0.5	cup	c	15
70	6	salt, to taste	9.0	servings	servings	17
70	53	2 pounds fresh or frozen medium-size shrimp, in shells if possible, for stock	2.0	pounds	lb	18
70	71	1 ounce tomato paste	1.0	ounce	oz	20
70	72	4 teaspoons vegetable oil or shortening	4.0	teaspoons	t	21
70	139	1 teaspoon Worcestershire sauce	1.0	teaspoon	t	22
71	10	2 1/2 tablespoons Butter	2.5	tablespoons	T	1
71	12	2 tablespoons powdered cinnamon	2.0	tablespoons	T	2
71	14	2 eggs, beaten	2.0	\N	\N	3
71	15	5 cups all-purpose flour	5.0	cups	c	4
71	20	3/4 cup milk	0.75	cup	c	5
71	6	salt	1.0	serving	serving	8
71	116	1/2 cup sugar	0.5	cup	c	10
71	116	cup sugar	1.0	cup	c	11
71	136	1/2 teaspoon almond or vanilla extract (optional)	0.5	teaspoon	t	12
71	7	1 1/2 teaspoons warm water (powdered sugar and 1 pkg. colored decorating sugar	1.5	teaspoons	t	13
72	3	1 bell pepper, chopped	1.0	\N	\N	2
72	11	1 tablespoon Canola oil	1.0	tablespoon	T	3
72	87	1 teaspoon dried thyme leaves	1.0	teaspoon	t	6
72	23	1 clove garlic chopped	1.0	clove	clove	7
72	4	1 large onion, chopped	1.0	\N	\N	9
72	135	Tabasco sauce to taste	6.0	servings	servings	13
72	139	Few dashes of Worcestershire sauce to taste	3.0	dashes	dashes	14
73	15	1/2 cup flour	0.5	cup	c	5
73	23	6 cloves garlic, minced	6.0	cloves	cloves	6
73	3	2 green bell peppers, diced	2.0	\N	\N	7
73	4	2 medium onions, diced	2.0	\N	\N	12
73	53	2 pounds medium shrimp, peeled and deveined	2.0	pounds	lb	16
73	48	4 tomatoes, seeded and diced	4.0	\N	\N	18
74	34	1tsp. allspice	1.0	tsp	t	0
74	81	6 tbsp. curry powder	6.0	tbsp	T	2
74	23	1 tablespoon Garlic, granulated	1.0	tablespoon	T	3
74	3	1 large green pepper (chopped)	1.0	\N	\N	4
74	4	1/2 medium Onion, chopped	0.5	\N	\N	5
74	6	1 1/2 teaspoons salt	1.5	teaspoons	t	7
74	95	3 scallions (chopped)	3.0	\N	\N	8
74	109	1 scotch bonnet pepper or habanero (seeded and minced)	1.0	\N	\N	9
74	86	1tbsp. thyme	1.0	tbsp	T	12
74	7	2 cups water	2.0	cups	c	13
75	33	1 pound dry organic black turtle beans	1.0	pound	lb	0
75	51	1 tablespoon Brown sugar	1.0	tablespoon	T	1
75	93	1/2 cup fresh cilantro, chopped	0.5	cup	c	3
75	95	2 green onions, roughly chopped	2.0	\N	\N	4
75	34	1 tablespoon Ground Allspice	1.0	tablespoon	T	5
75	4	1/2 onion, roughly chopped	0.5	\N	\N	8
75	97	2 tsp course sea salt	2.0	tsp	t	9
75	86	1/2 tsp thyme	0.5	tsp	t	11
75	107	8 cups of vegetable broth or water	8.0	cups	c	12
76	34	1 tsp allspice	1.0	tsp	t	0
76	51	2 tbsp brown sugar	2.0	tbsp	T	2
76	12	1 tsp cinnamon	1.0	tsp	t	3
76	23	3 cloves garlic, roughly chopped	3.0	cloves	cloves	4
76	95	2 green onions, roughly chopped	2.0	\N	\N	5
76	137	1 jalapeno, roughly chopped	1.0	\N	\N	8
76	142	3 limes, juiced	3.0	\N	\N	9
76	4	� onion, roughly chopped	0.5	\N	\N	10
76	6	1 tbsp salt	1.0	tbsp	T	13
77	13	1 package (8 ounce) cream cheese, softened	8.0	ounce	oz	2
77	111	2 egg yolks	2.0	\N	\N	3
77	15	1/4 cup all-purpose flour	0.25	cup	c	4
77	141	lime slices	1.0	slicesslices	slicesslices	7
77	142	3 tablespoons lime juice	3.0	tablespoons	T	8
77	128	6 tablespoons sour cream	6.0	tablespoons	T	11
77	116	1/4 cup sugar	0.25	cup	c	12
77	116	1/2 cup sugar	0.5	cup	c	13
77	10	4 teaspoons unsalted butter	4.0	teaspoons	t	14
77	7	2 cups water	2.0	cups	c	15
78	86	1 tsp. fresh thyme	1.0	tsp	t	6
78	23	2 Cloves garlic, chopped	2.0	Cloves	Cloves	7
78	110	1 fresh habanero chile, seeds removed and chopped	1.0	\N	\N	8
78	4	1/2 cup chopped onion	0.5	cup	c	10
78	95	1 cup chopped scallions	1.0	cup	c	13
79	40	1 tablespoon of corn starch	1.0	tablespoon	T	1
79	81	2 tablespoons of curry powder	2.0	tablespoons	T	2
79	23	1 clove of garlic (chopped)	1.0	clove	clove	3
79	4	1/2 bulb of onion	0.5	\N	\N	6
80	30	Hoisin sauce	12.0	servings	servings	2
80	17	1 teaspoon honey	1.0	teaspoon	t	3
80	6	2 teaspoons salt	2.0	teaspoons	t	6
80	95	Scallions	12.0	servings	servings	7
80	7	1 gallon boiling water	1.0	gallon	gallon	8
80	61	1/4 teaspoon white pepper	0.25	teaspoon	t	9
81	11	1/2 cup canola oil	0.5	cup	c	1
81	2	2 carrots, shredded	2.0	\N	\N	2
81	120	1 teaspoon adobo chipotle pepper puree	1.0	teaspoon	t	4
81	93	1/4 cup coarsely chopped fresh cilantro leaves	0.25	cup	c	5
81	95	1/4 cup thinly sliced green onion	0.25	cup	c	8
81	17	2 tablespoons honey	2.0	tablespoons	T	9
81	141	lime halves, for garnish	1.0	halves	halves	10
81	28	2 teaspoons toasted sesame oil	2.0	teaspoons	t	17
81	5	1 tablespoon smooth peanut butter	1.0	tablespoon	T	18
81	31	1/2 cup snow peas, cut in half lengthwise on a diagonal	0.5	cup	c	19
81	75	1 tablespoon soy sauce	1.0	tablespoon	T	20
82	3	1/4 cup bell pepper, diced	0.25	cup	c	0
82	2	1/4 cup carrot, slivered	0.25	cup	c	1
82	95	2 green onions, sliced	2.0	\N	\N	4
82	31	1/2 cup snow peas, cut in half lengthwise on a diagonal	0.5	cup	c	7
83	11	2 tablespoons canola oil	2.0	tablespoons	T	0
83	12	2 cinnamon sticks	2.0	\N	\N	1
83	75	1/2 cup dark soy sauce	0.5	cup	c	2
83	23	4 cloves garlic	4.0	cloves	cloves	3
83	12	1 teaspoon ground cinnamon	1.0	teaspoon	t	5
83	137	1 jalapeno, chopped	1.0	\N	\N	8
83	75	1/4 cup light soy sauce	0.25	cup	c	9
83	6	salt to taste	2.0	servings	servings	13
83	28	1 teaspoon sesame oil	1.0	teaspoon	t	14
83	116	1/2 cup rock sugar (yellow or white)	0.5	cup	c	17
83	7	4 cups water	4.0	cups	c	18
84	79	Chile-garlic paste	6.0	servings	servings	3
84	23	5 garlic cloves, cracked	5.0	cloves	cloves	5
84	95	3/4 cup green onions, diced	0.75	cup	c	6
84	52	1 cup mung bean sprouts	1.0	cup	c	7
84	56	8 ounces mushrooms, any variety	8.0	ounces	oz	8
84	28	1 tablespoon of sesame oil	1.0	tablespoon	T	11
84	75	1/3 cup soy sauce	0.3333333333333333	cup	c	12
84	7	6 cups water	6.0	cups	c	13
85	101	2 tbsp apple cider vinegar	2.0	tbsp	T	1
85	23	1 head of garlic, minced	1.0	head	head	7
85	17	1 tbsp honey	1.0	tbsp	T	9
85	75	3/4 cup light soy sauce	0.75	cup	c	11
85	56	1 can whole mushrooms, sliced in half (it's chunkier that way)	1.0	can	can	12
85	72	2 tbsp vegetable oil	2.0	tbsp	T	15
85	7	3 cups water	3.0	cups	c	16
85	4	1 large white onion, sliced	1.0	\N	\N	17
86	24	2 cups cabbage, chopped	2.0	cups	c	0
86	6	1 pinch of salt	1.0	pinch	pinch	2
86	72	Vegetable oil enough to cover the wonton in the pan	1.0	serving	serving	3
87	101	1 tsp. (5ml) of organic apple cider vinegar	5.0	ml	ml	0
87	59	1 teaspoon crushed black pepper	1.0	teaspoon	t	1
87	2	3 carrots	3.0	\N	\N	3
87	73	1/4 C extra-virgin olive oil + 7-8 Tbsp for frying	0.25	C	C	4
87	24	1/2 green cabbage	0.5	\N	\N	5
87	98	1/2 teaspoon kosher salt	0.5	teaspoon	t	6
87	95	6 scallions	6.0	\N	\N	10
87	28	3 tablespoons sesame oil	3.0	tablespoons	T	11
88	14	3 eggs, beaten	3.0	\N	\N	0
88	23	4 Garlic Cloves, minced	4.0	cloves	cloves	2
88	95	6 Green Onion, thinly sliced	6.0	\N	\N	5
88	59	1 TBSP Ground Pepper	1.0	TBSP	TBSP	7
88	30	3 TBSP Hoisin	3.0	TBSP	TBSP	8
88	73	1 TBSP Olive Oil	1.0	TBSP	TBSP	11
88	6	1 TBSP Salt	1.0	TBSP	TBSP	15
89	23	4 garlic cloves, finely chopped	4.0	cloves	cloves	0
89	55	8 fresh shitake mushrooms, sliced	8.0	\N	\N	2
90	15	3 cups of all purpose flour	3.0	cups	c	0
90	92	1 bunch of chinese chives, chopped	1.0	bunch	bunch	1
90	40	corn starch (if needed)	1.0	serving	serving	2
90	6	4 teaspoons of salt (or 3 1/2 tsp. if you use the dried shrimp)	4.0	teaspoons	t	4
90	28	3 tablespoons of sesame oil	3.0	tablespoons	T	5
90	7	1 cup of cold water	1.0	cup	c	6
90	91	1 teaspoon tsp. of dried shrimp (optional) soaked in 2 of water or shao	1.0	teaspoon	t	7
91	14	4 large eggs, lightly beaten	4.0	\N	\N	1
91	95	2/3 cup green onions, finely sliced at an angle	0.6666666666666666	cup	c	3
91	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	4
91	75	4 tablespoons Light soy sauce	4.0	tablespoons	T	5
91	4	1 small red onion, finely diced	1.0	\N	\N	7
91	28	2 teaspoons Sesame oil	2.0	teaspoons	t	8
91	72	1/4 cup vegetable oil	0.25	cup	c	9
91	116	2 teaspoons white sugar	2.0	teaspoons	t	10
91	100	1 tablespoon white vinegar	1.0	tablespoon	T	11
92	3	1 small size bell pepper, chopped in small pieces	1.0	\N	\N	1
92	59	Black pepper to taste	2.0	servings	servings	2
92	2	1 med size carrot, chopped in small pieces	1.0	\N	\N	3
92	23	3 cloves of garlic, minced	3.0	cloves	cloves	4
92	56	1 cup mushrooms, chopped	1.0	cup	c	7
92	95	1/4 cup green onions white part, chopped (Keep the chopped green part of green onions for garnishing)	0.25	cup	c	8
92	6	Salt to taste	2.0	servings	servings	9
92	28	2 teaspoons toasted sesame oil	2.0	teaspoons	t	10
92	46	1 tsp sesame seeds	1.0	tsp	t	11
93	59	Black pepper	2.0	servings	servings	0
93	10	� tbs butter	0.5	tbs	tbs	3
93	23	2 cloves garlic, minced	2.0	cloves	cloves	5
93	56	4 large mushrooms (about 400g), stems separated from caps	400.0	g	g	6
93	73	1 tablespoon olive oil	1.0	tablespoon	T	7
93	4	1 small Onion, halved lengthwise & cut crosswise into fine half rings	1.0	\N	\N	8
93	43	3 tablespoons chopped parsley	3.0	tablespoons	T	10
93	97	� tsp sea salt	0.25	tsp	t	13
93	128	2 tbs sour cream	2.0	tbs	tbs	14
94	77	Bell peppers - I used half of red and yellow colour	1.0	servings	servings	2
94	24	1/4 cup Cabbage - finely grated	0.25	cup	c	3
94	2	1/4 cup minced carrot	0.25	cup	c	4
94	4	1 small Onion - finely sliced	1.0	\N	\N	9
94	63	1/4 cup Green peas	0.25	cup	c	10
94	75	Soya sauce - 1 tbspn	1.0	tbsp	T	12
95	51	1 teaspoon brown sugar	1.0	teaspoon	t	0
95	93	Cilantro (or parsley) for garnish	4.0	servings	servings	1
95	14	3 eggs, well beaten	3.0	\N	\N	2
95	23	2 cloves garlic, minced	2.0	cloves	cloves	3
95	95	2 green onions, thinly sliced, including the greens	2.0	\N	\N	5
95	73	1 Tbsp olive oil	1.0	Tbsp	Tbsp	6
95	77	2/3 cup diced red bell pepper	0.6666666666666666	cup	c	8
95	4	2/3 cup diced red onion	0.6666666666666666	cup	c	9
95	75	3 Tbsp soy sauce	3.0	Tbsp	Tbsp	12
96	113	1 cup of chopped vegetables	1.0	cup	c	3
96	109	1 scotch bonnet pepper	1.0	\N	\N	5
97	70	head of cauliflower, raw	1.0	head	head	1
97	23	5 cloves of garlic, chopped	5.0	cloves	cloves	4
97	143	1 + 1 T grapeseed oil	1.0	\N	\N	5
97	6	salt, to taste	2.0	servings	servings	8
97	95	additional chopped scallion tops for garnish	2.0	servings	servings	9
97	95	7 scallions, chopped (keep white/light green ends separate from dark green tops)	7.0	\N	\N	10
97	28	2t toasted sesame oil	2.0	t	t	11
97	46	toasted sesame seeds, optional	2.0	servings	servings	12
98	80	1 large can tomato sauce (approx 4 cups)	1.0	can	can	1
98	15	flour for searing meat	12.0	servings	servings	4
98	23	2 garlic cloves, sliced thin	2.0	cloves	cloves	5
98	98	kosher salt & pepper to taste	12.0	servings	servings	7
98	73	olive oil for searing	12.0	servings	servings	9
98	4	2 large onions, sliced thin	2.0	\N	\N	10
98	41	1 Tbsp. mild paprika	1.0	Tbsp	T	11
98	15	flour seasoned with Kosher salt & cracked pepper-- about 1 cup flour, 1 Tbsp salt & pepper	1.0	cup	c	12
98	98	1/2 Tbsp salt	0.5	Tbsp	T	13
98	59	1/2 Tbsp pepper	0.5	Tbsp	T	14
98	71	2 Tbsp. tomato paste	2.0	Tbsp	T	15
99	138	8 oz fresh Bella mushrooms (crimini or regular okay)	8.0	oz	oz	0
99	23	1 small garlic clove, finely chopped	1.0	clove	clove	2
99	4	2 onions peeled, sliced	2.0	\N	\N	3
99	44	parsley flakes (garnish)	4.0	servings	servings	4
99	128	1 cup sour cream	1.0	cup	c	6
99	10	unsalted butter for rubbing squash, plus 1 tbsp	4.0	servings	servings	7
99	139	2 tablespoons Worcestershire sauce	2.0	tablespoons	T	9
100	10	Melted butter	1.0	serving	serving	2
100	14	6 lrgs eggs separated	6.0	\N	\N	5
100	15	2 cups All-purpose flour	2.0	cups	c	6
100	20	1 cup warm milk (105 to 115 degrees)	1.0	cup	c	7
100	116	1 pch sugar	1.0	\N	\N	8
100	116	1 tablespoon sugar plus	1.0	tablespoon	T	9
100	72	Vegetable oil for cooking	1.0	serving	serving	10
101	10	large knob of butter	2.0	servings	servings	1
101	128	2 tblsp sour cream	2.0	tb	tb	2
101	7	2 tblsp water	2.0	tb	tb	5
102	20	� cup milk	0.5	cup	c	4
102	4	1 medium onion	1.0	\N	\N	5
102	6	1/2 teaspoon salt	0.5	teaspoon	t	7
102	7	1 cup water	1.0	cup	c	10
103	15	2 tbsp.s flour	2.0	tbsp	T	2
103	59	1/2 tsp. ground pepper	0.5	tsp	t	3
103	4	1 lg. onion, sliced	1.0	\N	\N	5
103	41	3 tbsp.s paprika	3.0	tbsp	T	6
103	7	4 c.s water, to cover meat	4.0	c	c	8
104	68	1 x 14 ounce can chunky tomatoes with garlic	14.0	oz	oz	3
104	71	1 x 6 ounce can tomato paste	6.0	oz	oz	4
104	23	1 Clove garlic, minced	1.0	Clove	Clove	8
104	4	2 mediums onions, chopped	2.0	\N	\N	9
104	27	3 mediums potatoes cut into 1 inch cubes	3.0	\N	\N	10
104	6	1 teaspoon Salt	1.0	teaspoon	t	11
105	10	1 ounce butter	1.0	ounce	oz	0
105	68	16 ozs canned tomatoes	16.0	ozs	oz	1
105	2	1 piece sm. carrot, sliced	1.0	piece	\N	2
105	4	2 onions, peeled and chopped	2.0	\N	\N	6
105	41	1 1/2 teaspoons Paprika	1.5	teaspoons	t	7
105	6	1 teaspoon Salt (celery and the vinegar are naturally salty)	1.0	teaspoon	t	10
105	128	1/2 pint of sour cream	0.5	pint	pt	11
106	12	1 tsp cinnamon	1.0	tsp	t	0
106	14	2 eggs (or egg substitutes for vegans; you can also add 1-2 tbsp of dry yeast flakes)	2.0	\N	\N	1
106	136	1 tsp vanilla extract	1.0	tsp	t	8
106	112	250 g whole wheat flour ( you can also use different flours like soy/almonds/rye flour)	250.0	g	g	9
107	14	6 raw eggs	6.0	\N	\N	2
107	4	2 onions, peeled and chopped	2.0	\N	\N	4
107	43	2 tablespoons chopped parsley leaves	2.0	tablespoons	T	5
107	59	1/4 teaspoon black pepper corns	0.25	teaspoon	t	6
107	27	5 mediums potatoes, peeled and cut in small cubes	5.0	\N	\N	8
107	6	2 tablespoons salt	2.0	tablespoons	T	9
107	128	8 ounces sour cream	8.0	ounces	oz	10
107	7	3 quarts ,Water	3.0	quarts	quarts	11
107	100	3 tablespoons of good white vinegar	3.0	tablespoons	T	12
108	2	4 Carrots	4.0	\N	\N	1
108	23	2 Cloves garlic, crushed.	2.0	Cloves	Cloves	2
108	4	1 medium onion sliced	1.0	\N	\N	3
108	41	3 teaspoons paprika	3.0	teaspoons	t	5
108	6	salt to taste	1.0	serving	serving	8
108	128	8 ounces sour cream	8.0	ounces	oz	9
108	72	2 tablespoons Vegetable oil	2.0	tablespoons	T	11
108	7	3 quarts ,Water	3.0	quarts	quarts	12
109	73	extra-virgin olive oil, kosher salt, and freshly-ground blac	4.0	servings	servings	3
109	23	4 large cloves garlic	4.0	cloves	cloves	4
110	59	freshly ground black pepper	4.0	servings	servings	2
110	73	6 tbsp extra-virgin olive oil	6.0	tbsp	T	4
110	18	2 tbsp lemon juice	2.0	tbsp	T	6
111	10	2 tablespoons butter	2.0	tablespoons	T	0
111	15	1 cup All-purpose Flour	1.0	cup	c	3
111	23	1 large garlic clove, miced	1.0	clove	clove	4
111	4	1 cup onion, finely chopped	1.0	cup	c	7
111	6	1/4 teaspoon • Salt	0.25	teaspoon	t	9
111	128	1/2 cup sour cream	0.5	cup	c	11
112	3	1 Pepper, Chopped	1.0	\N	\N	0
112	49	1 teaspoon of Cumin	1.0	teaspoon	t	4
112	81	1/2 teaspoon of Curry	0.5	teaspoon	t	5
112	23	3 cloves of Garlic	3.0	cloves	cloves	7
112	4	1 Onion, Chopped	1.0	\N	\N	10
112	41	1 teaspoon of Paprika	1.0	teaspoon	t	11
112	128	1 cup of Sour Cream	1.0	cup	c	12
113	10	40g Butter	40.0	g	g	0
113	111	2 Egg yolks	2.0	\N	\N	2
113	14	1 Eggs	1.0	\N	\N	3
113	116	20g Granulated sugar	20.0	g	g	4
113	6	1 pinch Salt	1.0	pinch	pinch	6
113	15	250g Wheat flour	250.0	g	g	8
114	88	1/2 cup chopped fresh basil	0.5	cup	c	2
114	23	5 garlic cloves chopped	5.0	cloves	cloves	3
114	3	2 green bell peppers diced	2.0	\N	\N	4
114	73	3 tablespoons Olive Oil	3.0	tablespoons	T	5
114	4	1 onion cut 1" pieces	1.0	\N	\N	6
114	102	2 tablespoons red wine vinegar	2.0	tablespoons	T	7
114	48	2 lrg tomatoes chopped	2.0	\N	\N	8
115	15	1 cup all purpose flour (sifted)	1.0	cup	c	0
115	9	4 ripe bananas (works great with freckled ones) peeled, sliced lengthwise and quartered.	4.0	\N	\N	1
115	51	1/2 cup brown sugar	0.5	cup	c	2
115	12	1 pinch cinnamon	1.0	pinch	pinch	3
115	14	1 egg	1.0	\N	\N	5
115	20	1 cup milk	1.0	cup	c	6
115	16	1 pinch nutmeg	1.0	pinch	pinch	7
115	6	1 pinch salt	1.0	pinch	pinch	8
115	116	2 teaspoons sugar	2.0	teaspoons	t	9
115	10	1 teaspoon melted butter, plus 1/2 c. butter for greasing 1 stick of butter, cubed- (use unsalted butter to cont	1.0	teaspoon	t	10
116	22	2 smalls bacon rasher, sliced to strips	2.0	\N	\N	0
116	56	200 grams of button mushrooms	200.0	grams	g	3
116	43	1/4 cup of finely chopped fresh flat leaf parsley	0.25	cup	c	6
116	86	1 teaspoon of fresh thyme leaves	1.0	teaspoon	t	7
116	63	2 cups of green peas thawed	2.0	cups	c	8
116	4	1 teaspoon of olive oil 2 tablespoons of finely chopped brown onion	2.0	tablespoons	T	9
116	73	2 teaspoons of olive oil	2.0	teaspoons	t	10
116	4	4 pickling onions, peeled and halved	4.0	\N	\N	11
116	71	2 teaspoons of tomato paste	2.0	teaspoons	t	14
117	10	1 stick of butter	1.0	stick	stick	1
117	111	2 lrg egg yolks	2.0	\N	\N	2
117	14	3 lrg eggs	3.0	\N	\N	3
117	15	cups all-purpose flour	1.0	cups	c	4
117	15	5 1/2 cups flour	5.5	cups	c	5
117	6	1/2 teaspoon salt	0.5	teaspoon	t	6
117	116	1/2 cup sugar	0.5	cup	c	7
117	7	cup water	1.0	cup	c	8
118	43	3 sprigs fresh parsley	3.0	sprigs	sprigs	1
118	23	4 garlic cloves, finely chopped	4.0	cloves	cloves	2
118	98	Kosher salt	2.0	servings	servings	3
118	73	1 tbs olive oil	1.0	tbs	tbs	6
118	10	4 tablespoons unsalted light butter, cut into pieces	4.0	tablespoons	T	8
119	59	1/2 teaspoon black pepper	0.5	teaspoon	t	0
119	89	1 teaspoon dried basil	1.0	teaspoon	t	2
119	45	1 teaspoon dried oregano	1.0	teaspoon	t	3
119	23	2 cloves garlic, minced	2.0	cloves	cloves	5
119	73	1 tablespoon olive oil	1.0	tablespoon	T	7
119	4	1/4 cup diced onion	0.25	cup	c	8
119	77	1 cup diced red bell pepper	1.0	cup	c	9
119	6	Pinch salt	1.0	pinch	pinch	10
119	7	1/4 cup water	0.25	cup	c	11
119	80	1 cup tomato sauce, or ground peeled tomatoes	1.0	cup	c	13
120	23	7 cloves garlic,peeled	7.0	cloves	cloves	1
120	4	1 onion, cut into quarters	1.0	\N	\N	5
121	111	5 large egg yolks	5.0	\N	\N	2
121	116	1/2 cup sugar	0.5	cup	c	3
122	10	8 Tbs. - Butter	8.0	Tb	Tb	1
122	40	Corn Starch to thicken soup	1.0	serving	serving	4
122	23	2 Tbs. - Johnny's Garlic Seasoning	2.0	Tb	Tb	6
122	4	1 Large Onion (diced)	1.0	\N	\N	8
123	15	1 1/2 tablespoons all purpose flour	1.5	tablespoons	T	0
123	56	2 pints button mushrooms (about 20 mushrooms), rinsed, stems removed, cut in half	2.0	pints	pt	3
123	2	Carrots	4.0	servings	servings	4
123	124	1/4 teaspoon cayenne pepper	0.25	teaspoon	t	5
123	85	1/2 teaspoon dried rosemary	0.5	teaspoon	t	6
123	87	1/2 teaspoon dried thyme	0.5	teaspoon	t	7
123	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	8
123	4	1/2 cup chopped onion	0.5	cup	c	9
124	10	1 tablespoon butter	1.0	tablespoon	T	0
124	14	4 lrg eggs	4.0	\N	\N	1
124	7	3 tablespoons ice water	3.0	tablespoons	T	4
124	25	2 leeks	2.0	\N	\N	5
124	15	1 cup flour, plain	1.0	cup	c	6
124	6	salt	1.0	serving	serving	7
124	128	1 tablespoon sour cream	1.0	tablespoon	T	9
124	20	3 cups whole milk	3.0	cups	c	10
125	15	1 1/4 cups all-purpose flour	1.25	cups	c	0
125	22	6 slices bacon	6.0	slices	slices	1
125	10	3 tablespoons Butter	3.0	tablespoons	T	2
125	14	4 eggs	4.0	\N	\N	3
125	59	1/4 teaspoon ground pepper	0.25	teaspoon	t	4
125	25	2 Leek, chopped	2.0	\N	\N	5
125	20	2/3 cup milk	0.6666666666666666	cup	c	6
125	138	1 pound white or baby portobello mushrooms, sliced	1.0	pound	lb	7
125	130	3 red potatoes, boiled and sliced	3.0	\N	\N	8
125	6	pinch of salt	1.0	pinch	pinch	9
125	116	1/4 cup sugar	0.25	cup	c	10
125	7	4 cups of water	4.0	cups	c	11
126	14	2 eggs, beaten	2.0	\N	\N	4
126	25	1 Leek cleaned and thinly sliced	1.0	\N	\N	6
126	20	Milk	4.0	servings	servings	7
126	4	2 tablespoons Minced onion	2.0	tablespoons	T	9
126	95	4 Spring onions, chopped	4.0	\N	\N	16
126	48	4 Fresh tomatoes, skinned, de-seeded, chopped	4.0	\N	\N	18
127	73	extra-virgin olive oil, for serving	4.0	servings	servings	3
127	23	4 cloves Garlic, minced	4.0	cloves	cloves	4
127	73	4 oz. olive oil (for saut�ing and garnishing)	4.0	oz	oz	6
127	97	Sea salt and fresh pepper	4.0	servings	servings	8
127	4	1 large Yellow Onion, diced	1.0	\N	\N	10
128	73	1/2 cup extra-virgin olive oil	0.5	cup	c	2
128	48	2 ripe plum tomatoes	2.0	\N	\N	3
128	86	1 tsp. thyme (chopped)	1.0	tsp	t	4
129	68	1 cup (28-ounce) can good-quality plum tomatoes, chopped, with their juices to make 2	28.0	ounce	oz	0
129	138	1 cup sliced cremini mushrooms (about 5 medium)	1.0	cup	c	1
129	88	1/2 cup chopped fresh basil for garnish	0.5	cup	c	5
129	84	1 tablespoon chopped fresh rosemary	1.0	tablespoon	T	6
129	86	1 tablespoon chopped fresh thyme	1.0	tablespoon	T	7
129	25	1 leek, white part only, thinly sliced	1.0	\N	\N	8
129	73	Olive oil	4.0	servings	servings	9
129	77	1/2 red pepper	0.5	\N	\N	12
129	97	1 teaspoon sea salt	1.0	teaspoon	t	13
130	10	1 tablespoon butter	1.0	tablespoon	T	1
130	14	1 large egg white	1.0	\N	\N	3
130	18	2 tablespoons lemon juice	2.0	tablespoons	T	4
130	129	4 tablespoons reduced fat sour cream	4.0	tablespoons	T	8
130	6	1 pinch salt	1.0	pinch	pinch	10
130	7	1/4 cup water	0.25	cup	c	12
131	45	� tsp dried oregano	0.25	tsp	t	0
131	73	2 Tbsp extra-virgin olive oil	2.0	Tbsp	Tbsp	2
131	88	2 Tbsp chopped fresh basil	2.0	Tbsp	Tbsp	3
131	23	1 tablespoon minced garlic	1.0	tablespoon	T	4
131	4	1 large onion, peeled & finely cut up	1.0	\N	\N	5
131	82	� orange bell pepper chopped	0.5	\N	\N	6
131	77	1 medium red bell ( sweet ) pepper, washed, cleaned, pits & white bits removed, cut into little pieces	1.0	\N	\N	7
131	97	1 tsp sea salt	1.0	tsp	t	8
131	86	2 sprigs of thyme	2.0	sprigs	sprigs	9
131	48	2 tomato peeled and chopped	2.0	\N	\N	10
132	88	1/2 teaspoon basil	0.5	teaspoon	t	0
132	11	1/2 cup vegetable or canola oil	0.5	cup	c	2
132	14	3 Eggs	3.0	\N	\N	3
132	23	1 garlic clove, minced	1.0	clove	clove	4
132	4	1/2 cup finely chopped onion	0.5	cup	c	5
132	45	1/2 teaspoon oregano	0.5	teaspoon	t	6
132	43	2 tablespoons fresh Italian Parsley	2.0	tablespoons	T	8
132	6	1/8 teaspoon salt	0.125	teaspoon	t	10
134	12	cinnamon, optional	2.0	servings	servings	0
134	14	4 eggs	4.0	\N	\N	1
134	19	Maple syrup	2.0	servings	servings	2
134	16	nutmeg, optional	2.0	servings	servings	4
134	73	olive oil or butter for frying	2.0	servings	servings	5
135	9	1 banana	1.0	\N	\N	0
135	14	4 eggs	4.0	\N	\N	2
135	20	400ml milk	400.0	ml	ml	3
135	15	400g white flour	400.0	g	g	6
136	10	cup butter	1.0	cup	c	1
136	14	3 hard cooked eggs, diced	3.0	\N	\N	2
136	15	cups all-purpose flour	1.0	cups	c	3
136	23	1/2 clove garlic, minced	0.5	clove	clove	4
136	20	cup whole milk	1.0	cup	c	5
136	4	1 large onion quartered	1.0	\N	\N	6
136	43	1/4 cup parsley, minced	0.25	cup	c	8
136	6	1/2 teaspoon salt	0.5	teaspoon	t	12
137	88	1 teaspoon Basil, dried(or marjoram)	1.0	teaspoon	t	0
137	14	1 extra large egg	1.0	\N	\N	2
137	20	30 60ml milk	1800.0	ml	ml	4
137	4	70 grams Onions	70.0	grams	g	6
137	6	1 teaspoon salt	1.0	teaspoon	t	7
137	61	1 teaspoon White pepper	1.0	teaspoon	t	8
138	8	2 teaspoons baking powder	2.0	teaspoons	t	0
138	10	1/2 pound butter	0.5	pound	lb	1
138	14	6 eggs	6.0	\N	\N	3
138	15	375 grams German#405 flour, sifted	375.0	grams	g	4
138	6	1/2 teaspoon Salt, optional	0.5	teaspoon	t	7
138	116	1/2 pound sugar	0.5	pound	lb	8
139	14	2 eggs, well-beaten	2.0	\N	\N	3
139	4	1 small onion, grated	1.0	\N	\N	6
139	41	2 teaspoons paprika	2.0	teaspoons	t	7
139	43	2 tablespoons Parsley, chopped	2.0	tablespoons	T	8
139	6	to taste salt	4.0	servings	servings	9
139	7	3 tablespoons Cold water	3.0	tablespoons	T	10
140	8	2 teaspoons baking powder	2.0	teaspoons	t	1
140	10	1/3 cup 1 1/2 Tablespoon (100 g) butter, unsalted and at room temp.	100.0	g	g	2
140	118	3 egg whites	3.0	\N	\N	3
140	14	2 large eggs	2.0	\N	\N	4
140	15	1 1/4 cup (150 g) flour	150.0	g	g	5
140	6	1 3/4 cups Salt (sack salt, not Iodized)	1.75	cups	c	8
140	116	1 cup SUGAR, BROWN, 2 LB	1.0	cup	c	9
140	136	1 teaspoon (5 ml) vanilla extract	5.0	ml	ml	10
141	10	1/4 cup Butter	0.25	cup	c	1
141	111	3 lrg Egg yolks	3.0	\N	\N	3
141	14	4 lrg Eggs, separated	4.0	\N	\N	4
141	116	1/4 cup Sugar	0.25	cup	c	9
141	136	1 teaspoon Vanilla extract	1.0	teaspoon	t	11
142	132	2 medium cooking apples, cored and cut into 8 wedges each	2.0	\N	\N	0
142	40	1 tablespoon cornstarch	1.0	tablespoon	T	4
142	34	1/2 teaspoon ground allspice	0.5	teaspoon	t	5
142	4	1/3 cup chopped onion	0.3333333333333333	cup	c	8
142	7	4 cups Water, boiling	4.0	cups	c	12
143	40	50g cornflour, seasoned with salt and black pepper	50.0	g	g	1
143	14	1 Egg, lightly beaten	1.0	\N	\N	2
143	73	3 tablespoons olive oil	3.0	tablespoons	T	5
144	59	1/2 tsp black pepper	0.5	tsp	t	0
144	40	50g cornflour, seasoned with salt and black pepper	50.0	g	g	2
144	14	2 eggs, lightly beaten	2.0	\N	\N	4
145	59	1/8 teaspoon Black Pepper	0.125	teaspoon	t	0
145	23	1 garlic clove, finely chopped	1.0	clove	clove	1
145	73	Olive oil	2.0	servings	servings	2
145	27	2 Large Potatoes, Diced	2.0	\N	\N	3
145	6	1/2 teaspoon Salt	0.5	teaspoon	t	4
145	7	water, enough to cover the potatoes in the pot	2.0	servings	servings	7
146	22	4 slices bacon	4.0	slices	slices	0
146	13	8 ounces cream cheese at room temperature	8.0	ounces	oz	1
147	10	50 g butter	50.0	g	g	1
147	68	480g chopped tomatoes from a can	480.0	g	g	2
147	111	3 egg yolks	3.0	\N	\N	3
147	15	50 g flour	50.0	g	g	6
147	23	4 cloves garlic, finely chopped	4.0	cloves	cloves	7
147	34	1/4 tsp ground allspice	0.25	tsp	t	8
147	12	1/4 tsp ground cinnamon	0.25	tsp	t	9
147	16	1/2 tsp ground nutmeg	0.5	tsp	t	10
147	20	250 ml warm milk	250.0	ml	ml	12
147	73	1 tbs olive oil	1.0	tbs	tbs	13
147	73	Olive oil	4.0	servings	servings	14
147	4	2 onions, finely chopped	2.0	\N	\N	15
147	59	Salt and ground white pepper	4.0	servings	servings	16
147	97	Sea salt	4.0	servings	servings	17
147	71	2 tbs tomato paste	2.0	tbs	tbs	18
148	14	1 egg, lightly beaten	1.0	\N	\N	1
148	41	paprika	2.0	servings	servings	6
148	6	salt	2.0	servings	servings	7
149	37	1 can chickpeas (15 ounces), drained except for about 1 tablespoon of the liquid	15.0	ounces	oz	0
149	23	2 cloves garlic, roasted	2.0	cloves	cloves	1
149	137	1 jalape�o, roasted	1.0	\N	\N	4
149	18	1 tablespoon lemon juice	1.0	tablespoon	T	5
149	73	� cup olive oil	0.25	cup	c	6
149	6	Salt to taste	4.0	servings	servings	7
150	4	1/2 red onion, sliced	0.5	\N	\N	5
150	48	3 cups diced roma tomatoes	3.0	cups	c	7
151	73	high-quality extra-virgin olive oil	4.0	servings	servings	1
151	4	1 large red onion, sliced thinly	1.0	\N	\N	4
151	48	5 large ripe tomatoes	5.0	\N	\N	5
152	88	5 large leaves of basil, chiffonaded	5.0	leaves	leaves	0
152	95	1 cup chopped green onions (green and white parts)	1.0	cup	c	2
152	18	1/2 cup freshly-squeezed lemon juice	0.5	cup	c	3
152	73	1/2 cup + 1 tbsp extra-virgin olive oil, divided	0.5	cup	c	4
152	43	1 cup chopped Italian parsley	1.0	cup	c	6
152	53	1 pound raw large shrimp, peeled and deveined	1.0	pound	lb	7
153	45	1 tablespoon Dried Oregano	1.0	tablespoon	T	1
153	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
153	23	2 cloves Garlic, smashed	2.0	cloves	cloves	3
153	23	3 cloves garlic, minced	3.0	cloves	cloves	4
153	18	1 Juice of Lemon	1.0	\N	\N	5
153	18	tablespoon of fresh lemon juice	1.0	tablespoon	T	6
153	59	pepper	2.0	servings	servings	7
153	4	sliced red onions	2.0	servings	servings	11
153	102	2 teaspoons Red Wine Vinegar	2.0	teaspoons	t	12
153	6	Salt	2.0	servings	servings	13
153	48	sliced tomatoes	2.0	servings	servings	15
154	36	200 g boiled chickpeas. Can also use canned chickpeas	200.0	g	g	0
154	41	1 tsp red paprika / red chili powder	1.0	tsp	t	1
154	23	2 cloves garlic (optional) – roughly chopped	2.0	cloves	cloves	2
154	18	1 tablespoon lemon juice	1.0	tablespoon	T	3
154	73	2 tsp cooking oil / olive oil – for tempering bell peppers	2.0	tsp	t	4
154	82	1 cup orange bell peppers – roughly chopped	1.0	cup	c	5
154	59	Pepper to taste	2.0	servings	servings	6
154	6	1/2 teaspoon salt	0.5	teaspoon	t	7
154	46	2 tsp roasted sesame seeds or 1 tablespoon tahini paste	2.0	tsp	t	8
154	116	1/2 tsp sugar	0.5	tsp	t	9
154	100	1 tsp white vinegar	1.0	tsp	t	10
155	49	1 teaspoon Cumin	1.0	teaspoon	t	1
155	23	Couple of crushed garlic cloves	2.0	cloves	cloves	2
155	18	1 tablespoon lemon juice	1.0	tablespoon	T	3
155	6	1/2 teaspoon salt	0.5	teaspoon	t	5
156	37	1 15-oz can garbanzo beans	15.0	oz	oz	1
156	2	1/2 cup shredded carrots	0.5	cup	c	2
156	23	1 garlic clove	1.0	clove	clove	4
156	18	1 tablespoon lemon juice	1.0	tablespoon	T	6
156	6	1/2 teaspoon salt	0.5	teaspoon	t	8
157	23	1 tablespoon garlic (chopped)	1.0	tablespoon	T	2
157	73	2 tablespoons olive oil	2.0	tablespoons	T	5
158	14	1 egg	1.0	\N	\N	1
158	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
158	43	1/4 cup chopped flat leaf parsley	0.25	cup	c	3
158	23	12 Cloves garlic, peeled and cut in ha	12.0	Cloves	Cloves	5
158	18	juice of 2 lemons	2.0	\N	\N	9
158	98	Kosher salt & pepper to taste	4.0	servings	servings	10
159	15	1/2 cup all purpose flour	0.5	cup	c	0
159	126	White Sauce	12.0	servings	servings	1
159	68	1 can diced tomatoes, undrained	1.0	can	can	2
159	14	4 egg, beaten	4.0	\N	\N	5
159	43	1/2 cup chopped fresh parsley	0.5	cup	c	9
159	23	2 clv garlic, chopped	2.0	\N	\N	10
159	73	5 tablespoons extra-virgin olive oil	5.0	tablespoons	T	12
159	4	2 mediums Onion, chopped	2.0	\N	\N	13
159	45	1 tablespoon dried oregano leaves	1.0	tablespoon	T	14
159	6	1 teaspoon salt	1.0	teaspoon	t	15
159	71	1 can Tomato paste	1.0	can	can	17
160	59	1/8 teaspoon black pepper	0.125	teaspoon	t	0
160	66	1 pound brown lentils	1.0	pound	lb	1
160	68	28 ounces can whole tomatoes	28.0	ounces	oz	2
160	2	12 ounces scrubbed and chopped carrots	12.0	ounces	oz	3
160	89	2 teaspoons dried basil	2.0	teaspoons	t	4
160	45	1 teaspoon dried oregano	1.0	teaspoon	t	5
160	87	1 teaspoon dried thyme	1.0	teaspoon	t	6
160	86	2 teaspoons fresh thyme (if none available, use 1 more tsp dried)	2.0	teaspoons	t	7
160	23	2 cloves garlic, chopped	2.0	cloves	cloves	8
160	18	2 tablespoons lemon juice, from 1 lemon	2.0	tablespoons	T	9
160	73	1 tablespoon olive oil	1.0	tablespoon	T	10
160	4	1/2 medium onion, chopped (about ¾ cup)	0.75	cup	c	11
160	6	1/4 teaspoon salt	0.25	teaspoon	t	12
160	7	3 quarts cold water	3.0	quarts	quarts	13
161	80	1 large can tomato sauce	1.0	can	can	1
161	68	1 can diced tomatoes	1.0	can	can	2
161	88	Fresh basil	8.0	servings	servings	3
161	23	teaspoon � minced garlic	1.0	teaspoon	t	4
161	18	1 tablespoon lemon juice	1.0	tablespoon	T	8
161	113	1 pound of vegetables (seasoned, roasted with olive oil)	1.0	pound	lb	9
161	56	1 cup sliced mushrooms (seasoned & roasted)	1.0	cup	c	10
161	4	2 teaspoons Onion, minced	2.0	teaspoons	t	11
161	45	teaspoon � oregano	1.0	teaspoon	t	12
162	37	1 15.5oz can chickpeas (garbanzo beans), drained and rinsed	15.5	oz	oz	0
162	73	1/4 cup extra-virgin olive oil, divided	0.25	cup	c	2
162	23	1 garlic clove	1.0	clove	clove	3
162	18	2 tablespoons fresh lemon juice	2.0	tablespoons	T	4
162	59	Freshly ground pepper to taste	6.0	servings	servings	5
162	6	1/2 teaspoon salt	0.5	teaspoon	t	6
163	14	3 extra-large eggs, lightly beaten	3.0	\N	\N	0
163	15	2 tablespoons all-purpose flour	2.0	tablespoons	T	2
163	73	1/2 cup (120 ml) olive oil	120.0	ml	ml	5
163	4	2 large onions, chopped	2.0	\N	\N	6
163	72	1/2 cup vegetable oil	0.5	cup	c	9
164	73	extra-virgin olive oil, for serving	1.0	serving	serving	0
164	23	1 garlic clove	1.0	clove	clove	2
164	18	2 Tablespoons lemon juice	2.0	Tablespoons	Tablespoons	3
164	62	pinch of red pepper flakes	1.0	pinch	pinch	6
165	62	chili flakes, to taste	2.0	servings	servings	3
165	81	2 teaspoons curry powder	2.0	teaspoons	t	5
165	23	2 cloves garlic	2.0	cloves	cloves	7
165	31	200 g snow peas, frozen	200.0	g	g	10
165	71	1 tablespoon tomato paste	1.0	tablespoon	T	11
166	68	1 Cup canned crushed tomatoes	1.0	Cup	Cup	0
166	50	1 Teaspoon Cumin Seeds	1.0	Teaspoon	Teaspoon	2
166	7	12 Cups Filtered Water	12.0	Cups	Cups	3
166	23	2-3 organic Garlic Cloves	2.0	cloves	cloves	6
166	143	1/4 Cup Expeller Pressed Grapeseed Oil	0.25	Cup	Cup	7
166	67	3 Cups organic Red Lentils	3.0	Cups	Cups	8
166	97	1 Tablespoon + 1 Teaspoon Sea Salt or to taste	1.0	Tablespoon	Tablespoon	9
166	4	1/2 organic White Onion	0.5	\N	\N	13
167	81	2 teaspoons Curry powder	2.0	teaspoons	t	2
167	133	2 inches Granny Smith apples (cut wedges)	2.0	inches	inches	4
167	25	2 Leeks (chopped and washed)	2.0	\N	\N	5
167	72	2 ounces Vegetable oil	2.0	ounces	oz	7
167	56	1 cup Sliced white mushrooms	1.0	cup	c	8
168	64	2 tbsp Gram (chickpea) flour	2.0	tbsp	T	0
168	37	2 cans chickpeas drained and rinsed	2.0	cans	cans	1
168	96	8 tablespoons chili powder (or to taste)	8.0	tablespoons	T	2
168	93	Handful of fresh coriander (cilantro) chopped	1.0	Handful	Handful	3
168	49	2 tsp cumin powder	2.0	tsp	t	4
168	50	1.5 tsp black cumin seeds	1.5	tsp	t	5
168	93	Small handful of fresh coriander (cilantro)	1.0	handful	handful	6
168	23	3 cloves garlic finely chopped	3.0	cloves	cloves	8
168	18	1 tbsp lemon juice	1.0	tbsp	T	11
168	4	1 small onion, chopped	1.0	\N	\N	13
168	3	3 green peppers (capsicum) roughly chopped into big chunks	3.0	\N	\N	16
169	10	Butter as needed( I used oil+butter)	2.0	servings	servings	2
169	96	1 tablespoon chili powder	1.0	tablespoon	T	3
169	142	1 tablespoon Lime juice	1.0	tablespoon	T	10
169	4	1 Big Onion Chopped	1.0	\N	\N	12
169	6	1/4 teaspoon salt	0.25	teaspoon	t	14
169	116	Sugar	2.0	servings	servings	15
169	48	1 medium sized tomato blanched n Pureed	1.0	\N	\N	16
170	68	1 16 oz. can tomatoes, cut up	16.0	oz	oz	2
170	81	1 t curry powder	1.0	t	t	3
170	81	2 t mild curry powder	2.0	t	t	4
170	23	3 cloves garlic, minced	3.0	cloves	cloves	5
170	73	Olive oil	4.0	servings	servings	7
170	125	1/2 large sweet onion	0.5	\N	\N	11
170	71	1 T tomato paste	1.0	T	T	12
171	59	Freshly-ground black pepper to taste	1.0	serving	serving	1
171	50	teaspoon cumin seeds	1.0	teaspoon	t	6
171	23	14 garlic cloves	14.0	cloves	cloves	7
171	116	cup granulated sugar	1.0	cup	c	8
171	4	1 small onion finely sliced	1.0	\N	\N	11
171	6	salt (taste),	1.0	serving	serving	14
171	6	teaspoon salt	1.0	teaspoon	t	15
171	71	cup tomato paste	1.0	cup	c	16
171	102	cup red wine vinegar	1.0	cup	c	18
172	101	2 teaspoons apple cider vinegar	2.0	teaspoons	t	0
172	70	1 head of cauliflower-cut into florets	1.0	head	head	2
172	37	1 15 oz can of chickpeas-drained and rinsed	15.0	oz	oz	3
172	50	1 teaspoon cumin seeds- toasted and crushed	1.0	teaspoon	t	4
172	81	1 tablespoon curry powder	1.0	tablespoon	T	5
172	49	1 tablespoon ground cumin	1.0	tablespoon	T	8
172	23	3 cloves garlic-minced	3.0	cloves	cloves	9
172	4	1 onion-sliced thinly	1.0	\N	\N	10
172	41	2 teaspoons paprika	2.0	teaspoons	t	11
172	27	2 potatoes-peeled and chopped	2.0	\N	\N	12
172	97	sea salt	8.0	servings	servings	13
172	116	1 pinch sugar	1.0	pinch	pinch	14
172	7	water-to cover	8.0	servings	servings	17
173	81	2 teaspoons Curry Powder	2.0	teaspoons	t	0
173	23	2 cloves of garlic	2.0	cloves	cloves	2
173	142	2 teaspoons Lime juice	2.0	teaspoons	t	3
173	4	1/4 cup red onions	0.25	cup	c	4
173	75	2 tablespoons Soy sauce	2.0	tablespoons	T	9
174	81	tablespoon Curry powder, 1	1.0	tablespoon	T	1
174	73	tablespoon Olive oil, 1	1.0	tablespoon	T	4
174	4	Onion (chopped), 1	1.0	\N	\N	5
174	43	tablespoon Parsley (chopped), 1	1.0	tablespoon	T	6
175	96	2 teaspoons red chili powder [optional]	2.0	teaspoons	t	4
175	50	1 tablespoon Cumin seeds,	1.0	tablespoon	T	8
175	26	2 blades mace [javitri]	2.0	\N	\N	11
175	16	1/2 teaspoon nutmeg, grated	0.5	teaspoon	t	13
175	4	1 large onion, thinly sliced	1.0	\N	\N	14
175	6	1/2 teaspoon salt	0.5	teaspoon	t	16
175	7	4 pints Water	4.0	pints	pt	18
176	8	1 small pinch baking powder	1.0	pinch	pinch	0
176	50	2 teaspoons cumin seeds	2.0	teaspoons	t	4
176	23	1 tablespoon garlic, minced	1.0	tablespoon	T	6
176	18	1 tablespoon lemon juice or to taste	1.0	tablespoon	T	7
176	6	Salt to taste	4.0	servings	servings	10
176	116	Sugar to taste	4.0	servings	servings	11
176	48	1 medium tomato, chopped	1.0	\N	\N	13
177	81	3 tablespoons curry powder	3.0	tablespoons	T	0
177	93	2 tablespoons chopped fresh coriander (or parsley)	2.0	tablespoons	T	1
177	23	2 cloves garlic, crushed	2.0	cloves	cloves	2
177	4	1 chopped med. onion	1.0	\N	\N	4
177	38	10 ounces frozen peas	10.0	ounces	oz	6
177	48	8 ripe plum tomatoes (or canned)	8.0	\N	\N	7
177	6	1/2 teaspoon salt	0.5	teaspoon	t	8
178	8	1 tiny pinch of baking powder	1.0	\N	\N	0
178	49	1 teaspoon cumin powder	1.0	teaspoon	t	5
178	23	4 mediums cloves garlic, minced	4.0	cloves	cloves	7
178	4	1 Large Onion, Chopped	1.0	\N	\N	9
178	6	1/2 teaspoon Salt	0.5	teaspoon	t	11
178	48	1 kilogram tomatoes, Sliced into Quarters	1.0	kilogram	kilogram	15
178	7	1 cup water	1.0	cup	c	17
179	96	1/2 teaspoon Red chili powder	0.5	teaspoon	t	1
179	40	1/4 cup corn starch	0.25	cup	c	3
179	49	1 teaspoon cumin powder	1.0	teaspoon	t	4
179	50	1 teaspoon cumin seeds	1.0	teaspoon	t	5
179	93	1/4 cup Fresh Cilantro, finely chopped	0.25	cup	c	6
179	65	2% Milk, as needed	4.0	servings	servings	13
179	4	3 mediums Onions,	3.0	\N	\N	14
179	27	5 mediums Potatoes, boiled-peeled-grated	5.0	\N	\N	17
179	6	Salt to taste	4.0	servings	servings	18
180	48	1 beefsteak tomato- diced	1.0	\N	\N	2
180	74	handful cashew nuts- chopped a bit	1.0	handful	handful	3
180	123	5 tablespoons hefty Biryani paste (I use Patak's Brand)	5.0	tablespoons	T	4
180	96	1 tablespoon chili powder (it should be spicy!)	1.0	tablespoon	T	5
180	93	handful chopped cilantro	1.0	handful	handful	6
180	59	coarse black pepper	4.0	servings	servings	7
180	108	PAM original flavor	4.0	servings	servings	8
180	23	4 cloves garlic- crushed and minced	4.0	cloves	cloves	10
180	4	1 medium onion- cut into thick slices (garnishing)	1.0	\N	\N	12
180	4	1 medium red onion- diced	1.0	\N	\N	13
180	6	salt to taste	4.0	servings	servings	15
180	77	4 small sweet peppers- diced	4.0	\N	\N	16
180	72	1/2 tablespoon vegetable oil	0.5	tablespoon	T	17
180	7	1 cup water	1.0	cup	c	18
180	4	1 medium white onion- diced	1.0	\N	\N	19
181	10	2 tablespoons of Butter	2.0	tablespoons	T	2
181	93	1 bunch of Cilantro, Chopped	1.0	bunch	bunch	3
181	81	2 tablespoons of Curry	2.0	tablespoons	T	4
181	23	3 cloves of Garlic, Minced	3.0	cloves	cloves	7
181	56	6 ounces of Mushrooms, Chopped	6.0	ounces	oz	10
181	73	2 tablespoons of Olive Oil	2.0	tablespoons	T	11
181	4	1 Onion, Diced	1.0	\N	\N	12
181	45	1 tablespoon of Oregano	1.0	tablespoon	T	13
181	84	1 tablespoon of Rosemary	1.0	tablespoon	T	15
181	6	1/2 teaspoon of Salt	0.5	teaspoon	t	16
181	71	1 can of Tomato Paste	1.0	can	can	17
182	10	1/2 cup butter	0.5	cup	c	1
182	2	2 med carrots, peeled and chopped small	2.0	\N	\N	3
182	124	dash of cayenne pepper	1.0	dash	dash	4
182	14	1 Egg	1.0	\N	\N	7
182	15	3 T. flour	3.0	T	T	8
182	43	2 T. chopped fresh parsley	2.0	T	T	10
182	86	1 t. minced fresh thyme	1.0	t	t	11
182	23	1 clove minced garlic	1.0	clove	clove	12
182	7	1/3 c. ice water, plus more if needed	0.3333333333333333	c	c	13
182	4	1 med. onion	1.0	\N	\N	14
182	6	1 teaspoon salt	1.0	teaspoon	t	15
182	116	1 teaspoon sugar	1.0	teaspoon	t	18
182	72	1/4 cup vegetable oil	0.25	cup	c	19
182	7	2 cups hot water	2.0	cups	c	20
183	22	Optional: 2 rashers bacon, cooked until crisp and broken into pieces	1.0	rashers	rashers	0
183	10	Butter	8.0	servings	servings	1
183	24	1 med. cabbage	1.0	\N	\N	2
183	20	1 cup milk	1.0	cup	c	3
183	95	6 stems green onions, green and white parts, chopped	6.0	\N	\N	4
183	43	1 tablespoon parsley, chopped	1.0	tablespoon	T	5
183	27	1 1/2 pounds potatoes, peeled	1.5	pounds	lb	7
183	6	1 tablespoon Salt	1.0	tablespoon	T	8
184	10	1 tbsp. butter, melted	1.0	tbsp	T	1
184	24	1 (2 lb.) cabbage, cut into wedges	2.0	lb	lb	2
184	2	8 mediums Carrots, Pared	8.0	\N	\N	3
184	23	1 Clove Garlic	1.0	Clove	Clove	5
184	4	8 mediums yellow onions, peeled	8.0	\N	\N	6
184	43	Chopped parsley	6.0	servings	servings	7
184	27	8 mediums Potatoes, pared	8.0	\N	\N	9
185	10	1 tbsp. butter, melted	1.0	tbsp	T	1
185	24	1 (2 lb.) cabbage, cut into wedges	2.0	lb	lb	2
185	2	1 lg. carrot, scraped and sliced	1.0	\N	\N	3
185	101	1/4 c. cider vinegar (good quality)	0.25	c	c	4
185	40	1 tbsp. cornstarch	1.0	tbsp	T	6
185	111	2 egg yolks, beaten	2.0	\N	\N	8
185	43	1 bunch fresh parsley	1.0	bunch	bunch	9
185	4	3 medium onions	3.0	\N	\N	12
185	6	1/2 tsp. salt	0.5	tsp	t	14
185	116	2 tsp. sugar	2.0	tsp	t	15
185	7	1 c. water	1.0	c	c	16
186	51	1 tablespoon brown sugar	1.0	tablespoon	T	2
186	2	1/4 cup carrots, finely grated	0.25	cup	c	3
186	23	2 cloves garlic, minced	2.0	cloves	cloves	5
186	27	2 cups potatoes, boiled and mashed roughly (try to use the floury kind of potato)	2.0	cups	c	9
187	22	2-3 rashers bacon (optional)	2.0	slices	slices	0
187	23	2 To 3 cloves garlic, minced	2.0	cloves	cloves	1
187	24	1 pound green cabbage (kale can also be used)	1.0	pound	lb	2
187	25	2 medium leeks, split lengthwise and rinsed well	2.0	\N	\N	3
187	26	1/4 teaspoon mace	0.25	teaspoon	t	4
187	27	2 pounds yellow or red potatoes, scrubbed and cubed but not peeled	2.0	pounds	lb	5
187	6	Salt to taste	1.0	\N	\N	6
187	20	1 cup whole milk	1.0	cup	c	7
188	15	1/4 cup all purpose flour	0.25	cup	c	0
188	8	1 1/2 teaspoons baking powder	1.5	teaspoons	t	1
188	10	1/4 cup Butter	0.25	cup	c	3
188	6	1/2 teaspoon Salt	0.5	teaspoon	t	6
188	116	5 tablespoons sugar, divided	5.0	tablespoons	T	7
189	14	1 Egg	1.0	\N	\N	3
189	15	4 3/4 cups Flour	4.75	cups	c	4
189	17	3 tablespoons Honey	3.0	tablespoons	T	5
189	6	� tsp salt	0.5	tsp	t	6
189	10	6 tbsp unsalted butter	6.0	tbsp	T	7
190	40	� cup cornstarch	0.25	cup	c	1
190	111	5 egg yolks	5.0	\N	\N	2
190	51	1 cup light brown sugar	1.0	cup	c	4
190	20	2 cups homogenized milk	2.0	cups	c	5
190	6	salt	10.0	servings	servings	7
190	10	6 tbsp unsalted butter	6.0	tbsp	T	8
190	7	� cup cold water	0.25	cup	c	10
191	10	1/4 cup butter	0.25	cup	c	0
191	20	3 tablespoons milk	3.0	tablespoons	T	2
191	4	1/4 cup chopped onions	0.25	cup	c	3
191	27	4 mediums potatoes, peeled and quartered	4.0	\N	\N	5
191	6	1 teaspoon salt	1.0	teaspoon	t	6
192	10	60 grams butter	60.0	grams	g	1
192	4	1 medium onion, finely chopped	1.0	\N	\N	4
192	23	3 whole cloves garlic (chopped)	3.0	cloves	cloves	7
192	43	1/4 cup freshly chopped parsley	0.25	cup	c	8
193	10	75g butter	75.0	g	g	1
193	51	1/2 cup dark brown sugar	0.5	cup	c	5
193	6	1/4 teaspoon salt	0.25	teaspoon	t	8
193	14	1 whole egg	1.0	\N	\N	11
193	112	1 c. (5 1/2 oz.) whole-wheat flour	5.5	oz	oz	12
194	8	1 tsp Baking powder	1.0	tsp	t	0
194	14	3 eggs	3.0	\N	\N	2
194	117	3 tablespoons of milk or half in half if the batter is too think	3.0	tablespoons	T	3
194	15	120g Plain flour	120.0	g	g	4
194	6	1/8 tsp pinch of salt	0.125	tsp	t	6
194	128	1 pint sour cream	1.0	pint	pt	7
194	116	1 cup white sugar	1.0	cup	c	8
195	84	1 1/2 tablespoons chopped fresh rosemary	1.5	tablespoons	T	3
195	17	1 tablespoon honey	1.0	tablespoon	T	4
195	20	1 tablespoon milk	1.0	tablespoon	T	5
195	6	2 teaspoons salt, divided	2.0	teaspoons	t	9
195	112	2 cups whole wheat flour	2.0	cups	c	10
196	2	Diced carrots	10.0	servings	servings	3
196	101	1/4 cup cider vinegar	0.25	cup	c	4
196	24	1 head green cabbage, trimmed and cut into 6 wedges (about 2 pounds)	1.0	head	head	5
196	4	2 medium onions, cut into quarters	2.0	\N	\N	6
196	27	5 diced potatoes	5.0	\N	\N	7
197	59	1 teaspoon freshly ground black pepper	1.0	teaspoon	t	0
197	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	2
197	23	5 cloves garlic, minced	5.0	cloves	cloves	3
197	18	Juice of 1 lemon	1.0	\N	\N	4
197	98	2 teaspoons kosher salt	2.0	teaspoons	t	6
197	25	2 medium leeks, tough green outer leaves removed, washed well (see Kitchen Tip), and thinly sliced	2.0	\N	\N	7
197	131	3 large russet potatoes, peeled and cut into cubes (about 2 cups)	3.0	\N	\N	8
197	107	8 cups Roasted Vegetable Stock or store-bought low-sodium vegetable broth	8.0	cups	c	10
199	43	1/4 cup chopped fresh parsley	0.25	cup	c	3
199	23	2 cloves minced garlic	2.0	cloves	cloves	4
199	18	1 tablespoon fresh lemon juice	1.0	tablespoon	T	5
199	73	1 tablespoon olive oil	1.0	tablespoon	T	7
199	4	1/2 cup onion, chopped	0.5	cup	c	8
199	107	2 14.5 oz cans vegetable broth	29.0	oz	oz	13
199	7	Water	4.0	servings	servings	14
200	68	14.5 oz. can diced tomatoes	14.5	oz	oz	0
200	70	1 head of cauliflower, cut into bite-sized pieces (no larger that 1-inch)	1.0	head	head	1
200	14	2 eggs, well beaten	2.0	\N	\N	2
200	15	1 cup All-purpose flour	1.0	cup	c	3
200	88	3-4 T. chopped fresh basil	3.0	T	T	4
200	23	1 teaspoon minced garlic	1.0	teaspoon	t	5
200	59	1/8 t. fresh ground black pepper	0.125	t	t	7
200	73	2 tablespoons Olive oil	2.0	tablespoons	T	8
200	62	pinch of crushed red pepper flakes	1.0	pinch	pinch	11
200	6	Salt to taste	4.0	servings	servings	12
200	7	1 T. water	1.0	T	T	13
201	88	pinch of basil	1.0	pinch	pinch	1
201	42	1 lb ground beef or equivalent amount of a ground beef/bulk Italian sausage mix	1.0	lb	lb	3
201	20	1 cup milk	1.0	cup	c	5
201	45	pinch of oregano	1.0	pinch	pinch	6
201	62	1/8 - 1/2 tsp crushed red pepper flakes	0.125	tsp	t	12
202	23	2-4 garlic cloves, minced	2.0	cloves	cloves	1
202	56	4-6 oz mushrooms, sliced	4.0	oz	oz	2
202	73	1 tablespoon olive oil	1.0	tablespoon	T	3
202	125	1 sweet onion, diced	1.0	\N	\N	9
203	80	1 ounce of 15 can of tomato sauce	1.0	ounce	oz	1
203	68	1 can of diced tomatoes (no salt added)	1.0	can	can	2
203	2	2 carrots thinly sliced	2.0	\N	\N	3
203	59	Fresh cracked black pepper	1.0	serving	serving	5
203	23	6 cloves garlic, chopped	6.0	cloves	cloves	7
203	98	Kosher salt	1.0	serving	serving	8
203	81	Madras curry powder	1.0	serving	serving	9
203	41	Paprika	1.0	serving	serving	10
203	62	Red pepper flakes	1.0	serving	serving	12
203	130	3 cups red potatoes, cubed	3.0	cups	c	13
203	125	1 sweet onion	1.0	\N	\N	15
203	48	4 vine ripe tomatoes	4.0	\N	\N	16
204	103	2 tablespoons balsamic vinegar	2.0	tablespoons	T	0
204	88	1/4 cup Shredded fresh basil leaves	0.25	cup	c	1
204	73	6 tablespoons extra-virgin olive oil	6.0	tablespoons	T	2
204	48	4 ripe tomatoes sliced 1/4" inch thick	4.0	\N	\N	6
205	68	14 ounces can diced tomatoes	14.0	ounces	oz	2
205	2	3 carrots	3.0	\N	\N	3
205	73	1 tablespoon olive oil	1.0	tablespoon	T	7
205	4	1 onion	1.0	\N	\N	8
205	62	1/4 teaspoon red pepper flakes	0.25	teaspoon	t	9
206	68	28 ounces can of whole tomatoes	28.0	ounces	oz	1
206	43	Fresh parsley, chopped	3.0	servings	servings	4
206	23	4 cloves garlic	4.0	cloves	cloves	5
206	4	1 onion, chopped	1.0	\N	\N	7
206	138	20 Baby Portobello mushrooms, sliced in half	20.0	\N	\N	8
206	6	2 teaspoons of salt	2.0	teaspoons	t	9
206	53	1 Shrimps, peeled and devined	1.0	\N	\N	11
206	48	1 fresh tomato (optional)	1.0	\N	\N	13
206	71	4 ounces can of tomato paste	4.0	ounces	oz	14
207	89	1/2 tsp dried basil	0.5	tsp	t	3
207	45	1/2 tsp dried oregano	0.5	tsp	t	4
207	23	1 Garlic Clove, sliced thin	1.0	clove	clove	5
208	23	1 tablespoon minced garlic	1.0	tablespoon	T	1
208	59	Ground black pepper	3.0	servings	servings	2
208	18	2 lemons, juiced	2.0	\N	\N	3
208	43	1/2 cup of chopped parsley leaves	0.5	cup	c	4
208	77	1 red pepper	1.0	\N	\N	6
208	104	400 grams of tuna, drained and flaked	400.0	grams	g	7
209	88	Generous handful basil leaves, torn	1.0	handful	handful	0
209	73	extra-virgin olive oil to drizzle	4.0	servings	servings	2
209	23	4 garlic cloves minced	4.0	cloves	cloves	3
209	25	3 leeks, finely chopped	3.0	\N	\N	4
209	73	1/4 cup olive oil	0.25	cup	c	6
209	97	Sea salt and freshly ground black pepper	4.0	servings	servings	7
209	68	2 liters puréed canned Italian tomatoes	2.0	liters	l	8
210	103	1 tablespoon balsamic vinegar	1.0	tablespoon	T	0
210	73	5 tablespoons extra-virgin olive oil	5.0	tablespoons	T	2
210	23	1 clove of garlic chopped	1.0	clove	clove	3
210	98	Kosher salt and freshly ground black pepper to taste	4.0	servings	servings	4
211	23	5 Garlic Cloves (finely chopped)	5.0	cloves	cloves	0
211	73	1/4 teaspoon olive oil	0.25	teaspoon	t	2
211	4	1 onion, chopped	1.0	\N	\N	3
211	6	salt, dry mustard and Worcestershire sauce to taste	4.0	servings	servings	7
212	2	4 carrots	4.0	\N	\N	2
212	89	1 1/2 tsp Dried Basil	1.5	tsp	t	3
212	59	1 tsp Ground Pepper	1.0	tsp	t	5
212	73	2 tsps olive oil	2.0	tsps	t	6
212	4	1 onion	1.0	\N	\N	7
212	6	1 1/2 tsp salt	1.5	tsp	t	9
212	48	2 14 oz cans diced tomato	28.0	oz	oz	10
213	89	1 teaspoon DRIED BASIL	1.0	teaspoon	t	0
213	45	1 teaspoon OREGANO	1.0	teaspoon	t	1
213	88	12 LARGE BASIL LEAVES	12.0	\N	\N	2
213	59	3/4 teaspoon CRACKED BLACK PEPPER	0.75	teaspoon	t	3
213	45	1 teaspoon FRESH MINCED OREGANO	1.0	teaspoon	t	5
213	43	2 tablespoons FRESH MINCED PARSLEY	2.0	tablespoons	T	6
213	23	4 MINCED GARLIC CLOVES	4.0	cloves	cloves	8
213	16	1/2 teaspoon GROUND NUTMEG	0.5	teaspoon	t	10
213	56	4 MUSHROOMS DICED	4.0	\N	\N	13
213	73	4 tablespoons OLIVE OIL	4.0	tablespoons	T	14
213	62	1/2 teaspoon RED PEPPER FLAKES	0.5	teaspoon	t	17
213	48	28 OZ CAN WHOLE SAN MARZANO TOMATOES	28.0	\N	\N	20
214	2	2 lg. carrots, cut into pieces	2.0	\N	\N	1
214	54	3/4 cup sliced daikon radish	0.75	cup	c	2
214	95	1/2 cup chopped green onion	0.5	cup	c	3
214	55	3/4 sliced shiitake mushrooms	0.75	\N	\N	4
214	28	2 Tbsps toasted sesame oil	2.0	Tbsps	Tbsps	6
214	31	1/2 cup snow peas	0.5	cup	c	7
214	7	8 cups water	8.0	cups	c	8
215	2	1 Carrot thinly sliced	1.0	\N	\N	0
215	75	2 tsps Light soy sauce	2.0	tsps	t	2
215	28	1/4 tsp Sesame oil	0.25	tsp	t	5
215	46	1 Tbsp Toasted sesame seeds	1.0	Tbsp	Tbsp	6
215	116	3 Tbsps Sugar	3.0	Tbsps	Tbsps	7
215	7	2 Tbsps Hot water	2.0	Tbsps	Tbsps	8
216	23	2 cloves of garlic diced	2.0	cloves	cloves	1
216	17	1 teaspoon of honey	1.0	teaspoon	t	3
216	4	1 onion, sliced	1.0	\N	\N	4
216	6	Salt, pepper, garlic,	1.0	serving	serving	5
216	72	1 teaspoon of vegetable oil	1.0	teaspoon	t	7
217	51	1 tablespoon brown sugar	1.0	tablespoon	T	1
217	40	1 tablespoon cornstarch	1.0	tablespoon	T	2
217	28	1 teaspoon dark sesame oil	1.0	teaspoon	t	3
217	23	1 teaspoon garlic, minced	1.0	teaspoon	t	5
217	56	1 cup chopped mushrooms	1.0	cup	c	7
217	77	1 cup sliced red bell pepper	1.0	cup	c	9
217	95	2 tablespoons chopped scallions	2.0	tablespoons	T	10
217	46	2 teaspoons sesame seeds, toasted	2.0	teaspoons	t	11
217	75	1/4 cup soy sauce	0.25	cup	c	12
218	51	2 TBSP Brown Sugar	2.0	TBSP	TBSP	0
218	40	1/2 TBSP cornstarch	0.5	TBSP	TBSP	1
218	23	2 TBSP Garlic, minced	2.0	TBSP	TBSP	2
218	95	1 Green onion, sliced	1.0	\N	\N	4
218	18	2 TBSP Lemon Juice	2.0	TBSP	TBSP	5
218	28	1 TBSP sesame oil	1.0	TBSP	TBSP	8
218	46	2 TBSP sesame seeds	2.0	TBSP	TBSP	9
218	55	6 oz shiitake mushrooms	6.0	oz	oz	10
218	32	2 TBSP Sriracha	2.0	TBSP	TBSP	13
219	92	1/4 cup chives, finely chopped+ to garnish	0.25	cup	c	1
219	23	3 cloves of garlic, finely chopped	3.0	cloves	cloves	2
219	73	3 tablespoons olive oil	3.0	tablespoons	T	4
219	4	1 onion, medium size, finely chopped	1.0	\N	\N	5
219	7	400 milliliters water (more or less)	400.0	milliliters	ml	10
220	14	5 large eggs (yolks and whites separated)	5.0	\N	\N	3
220	4	1 onion - (6 oz) peeled, and	6.0	oz	oz	6
220	48	1/4 cup diced Roma tomato	0.25	cup	c	7
220	75	2 tablespoons Soy sauce	2.0	tablespoons	T	8
220	116	4 tablespoons sugar	4.0	tablespoons	T	9
220	72	1 cup salad oil	1.0	cup	c	10
221	2	1/2 Carrot -- shredded	0.5	\N	\N	0
221	95	1 Green onion -- finely	1.0	\N	\N	3
221	56	4 Mushrooms -- thinly sliced	4.0	\N	\N	5
221	75	2 tablespoons Soy sauce	2.0	tablespoons	T	6
222	24	1 lg. head cabbage (slawed)	1.0	head	head	0
222	95	3 green onions thinly sliced	3.0	\N	\N	1
222	6	2 teaspoons salt	2.0	teaspoons	t	5
222	46	2 tablespoons sesame seeds	2.0	tablespoons	T	6
222	116	4 tablespoons sugar	4.0	tablespoons	T	8
222	72	1 cup salad oil	1.0	cup	c	9
223	2	3 small carrots, chop bite size	3.0	\N	\N	0
223	81	1/2 package Japanese curry, such as S&B Golden Curry (look for this in the Asian section of supermarkets or on Amazon.com)	0.5	package	pkg	1
223	4	1 medium size onion, finely chopped	1.0	\N	\N	3
223	27	2 potatoes, chopped bite size	2.0	\N	\N	4
223	7	2 tablespoons Water	2.0	tablespoons	T	6
224	126	1 tablespoon tonkatsu sauce (vegetable and fruit sauce. I use Bull-Dog)	1.0	tablespoon	T	0
224	59	1/4 teaspoon Black pepper	0.25	teaspoon	t	1
224	2	1 small carrot, finely chopped	1.0	\N	\N	3
224	14	2 eggs	2.0	\N	\N	4
224	23	2 garlic cloves, finely chopped	2.0	cloves	cloves	5
224	98	1/4 teaspoon kosher salt	0.25	teaspoon	t	6
224	75	2 tablespoons soy sauce	2.0	tablespoons	T	10
225	2	2 carrots, thinly sliced	2.0	\N	\N	0
225	95	2 scallions, minced	2.0	\N	\N	7
225	75	1/2 cup soy sauce	0.5	cup	c	8
225	116	1 tablespoon sugar	1.0	tablespoon	T	10
225	7	130 ml water	130.0	ml	ml	12
226	23	1/2 teaspoon Minced Garlic	0.5	teaspoon	t	0
226	95	1/2 cup green onion thinly sliced	0.5	cup	c	4
226	28	1 tablespoon Oriental sesame oil	1.0	tablespoon	T	6
226	55	8 ounces shiitake mushrooms dried or fresh if dried, rehydrate before using stems disca	8.0	ounces	oz	8
227	17	1 teaspoon honey	1.0	teaspoon	t	1
227	95	2 scallions, green part only, thinly sliced	2.0	\N	\N	3
227	28	2 teaspoons sesame oil divided	2.0	teaspoons	t	4
227	46	1 tablespoon sesame seeds	1.0	tablespoon	T	5
227	75	1/2 cup to mari soy sauce	0.5	cup	c	6
227	100	1 teaspoon vinegar	1.0	teaspoon	t	7
228	2	1/2 cup thin diagonally sliced carrots	0.5	cup	c	1
228	31	24 pea pods, blanched	24.0	\N	\N	3
228	95	1 green onion, sliced diagonally (not to be cooked)	1.0	\N	\N	7
228	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	8
228	75	3 tablespoons light soy sauce	3.0	tablespoons	T	9
228	28	1 tablespoon Oriental dark roasted sesame oil	1.0	tablespoon	T	10
228	29	1/2 cup thin sliced radishes	0.5	cup	c	11
228	116	1 tablespoon sugar	1.0	tablespoon	T	14
228	7	3 tablespoons water	3.0	tablespoons	T	15
229	10	1 cup butter	1.0	cup	c	0
229	13	125 grams cream cheese at room temperature	125.0	grams	g	2
229	20	40 mls milk	40.0	mls	mls	4
229	6	1 teaspoon salt	1.0	teaspoon	t	7
230	11	3 tablespoons canola or corn oil	3.0	tablespoons	T	0
230	81	2 1/2 tablespoons curry powder, plus more to taste	2.5	tablespoons	T	1
230	4	2 mediums onions, halved vertically and thinly sliced	2.0	\N	\N	2
230	38	1 cup frozen peas	1.0	cup	c	3
230	27	1 1/2 pounds potatoes, cut into 1- to 1 1/2 inch cubes	1.5	pounds	lb	6
230	97	1 teaspoon sea salt, plus more to taste	1.0	teaspoon	t	7
230	127	2 1/2 tablespoons tamari, plus more to taste	2.5	tablespoons	T	8
230	56	white mushrooms, halved or quartered (depending on size)	1.0	serving	serving	10
231	53	Cooked prawns	1.0	serving	serving	2
231	55	Shiitake mushrooms	1.0	serving	serving	6
231	105	Raw tuna	1.0	serving	serving	8
232	78	Dried red chili peppers, optional	4.0	servings	servings	0
232	28	1 teaspoon sesame oil	1.0	teaspoon	t	3
232	75	2 tablespoons soy sauce	2.0	tablespoons	T	4
233	92	2 smalls chives, cut into squares	2.0	\N	\N	1
233	56	8 shitaki mushrooms, cut up lengthwise	8.0	\N	\N	4
233	62	pinch of red pepper flakes-taste as you go to adjust flavors	1.0	pinch	pinch	6
233	7	2 cups of water	2.0	cups	c	10
233	4	1 yellow onion, chopped up	1.0	\N	\N	11
234	40	2-3 tbsp. corn starch	2.0	tbsp	T	0
234	118	2 egg whites, whisked	2.0	\N	\N	3
234	23	1 Clove garlic, finely chopped	1.0	Clove	Clove	6
234	62	1 tsp. hot pepper flakes (optional)	1.0	tsp	t	9
234	75	2 tbsp. each: Light soy sauce, Raw Honey, Hoisin Sauce	2.0	tbsp	T	11
234	7	4 sweet water shrimp with tails on (available at most Asian markets)	4.0	\N	\N	12
235	46	teaspoon Sesame seeds, 1-2	1.0	teaspoon	t	5
235	75	tablespoon Soya sauce, 4	1.0	tablespoon	T	7
235	116	tablespoon Sugar, 2	1.0	tablespoon	T	8
235	72	tablespoon Vegetable oil, 1	1.0	tablespoon	T	9
235	7	5 cups Water	5.0	cups	c	10
236	59	Freshly-ground black pepper to taste	6.0	servings	servings	0
236	2	2 large carrots, sliced	2.0	\N	\N	1
236	14	3 Eggs	3.0	\N	\N	5
236	4	1 onion, quartered	1.0	\N	\N	8
236	43	3 sprigs parsley	3.0	sprigs	sprigs	9
236	6	1/4 teaspoon Salt	0.25	teaspoon	t	10
236	72	4 tablespoons chicken fat or vegetable oil	4.0	tablespoons	T	13
237	8	4 tsp.s baking powder	4.0	tsp	t	0
237	12	2 tsp.s cinnamon	2.0	tsp	t	1
237	14	6 eggs	6.0	\N	\N	2
237	15	6 c.s unsifted all-purpose flour	6.0	c	c	3
237	116	c. sugar	1.0	c	c	7
237	72	1 c. salad oil	1.0	cup	c	8
238	14	2 large eggs	2.0	\N	\N	1
238	4	2 onions grated	2.0	\N	\N	4
238	27	3 large potatoes peeled and grated	3.0	\N	\N	5
239	129	applesauce and low-fat sour cream for serving	2.0	servings	servings	0
239	14	1 Egg, beaten	1.0	\N	\N	1
239	23	3 cloves of garlic, skinned and coarse grated	3.0	cloves	cloves	2
239	131	1 C of Yukon Gold or russet potatoes, skinned and coarse grated	1.0	cup	c	6
239	15	1 oz white flour	1.0	oz	oz	8
239	4	1/2 C of red or other onion, skinned and coarse grated	0.5	cup	c	10
240	51	� cup brown sugar	0.25	cup	c	1
240	14	2 eggs	2.0	\N	\N	2
240	6	1/4 teaspoon salt	0.25	teaspoon	t	3
240	72	1/2 cup vegetable oil	0.5	cup	c	4
240	7	3 tbsp. water	3.0	tbsp	T	5
241	12	1 teaspoon Cinnamon	1.0	teaspoon	t	2
241	111	10 egg yolks, beaten	10.0	\N	\N	5
241	12	1 1/2 teaspoons ground cinnamon	1.5	teaspoons	t	6
241	16	1/2 teaspoon ground nutmeg	0.5	teaspoon	t	7
241	98	2 tablespoons kosher salt, boiling pasta	2.0	tablespoons	T	8
242	59	Freshly ground black pepper	10.0	servings	servings	2
242	68	1 16 oz. can of chopped tomatoes	16.0	oz	oz	3
242	2	2 carrots, coarsely chopped	2.0	\N	\N	4
242	43	1 handful fresh flat-leaf parsley leaves	1.0	handful	handful	7
242	84	4 sprigs fresh rosemary, needles striped from the stem and chopped	4.0	sprigs	sprigs	8
242	23	6 garlic cloves, pressed	6.0	cloves	cloves	9
242	98	1/2 teaspoon kosher salt	0.5	teaspoon	t	10
242	73	Olive oil	10.0	servings	servings	11
242	15	2 teaspoons plain flour	2.0	teaspoons	t	12
242	4	4 large red onions, halved	4.0	\N	\N	13
243	2	2 carrots, julienned	2.0	\N	\N	1
243	23	2 cloves garlic, finely chopped	2.0	cloves	cloves	2
243	56	5 mushrooms, sliced (I like to use criminis)	5.0	\N	\N	3
243	73	2 tablespoons olive oil	2.0	tablespoons	T	4
243	6	Salt to taste	4.0	servings	servings	5
243	95	3 scallions, chopped	3.0	\N	\N	6
243	28	2 tablespoons sesame oil	2.0	tablespoons	T	7
243	46	Sesame seeds	4.0	servings	servings	8
243	75	3 tablespoons soy sauce	3.0	tablespoons	T	9
243	116	1 teaspoon sugar	1.0	teaspoon	t	10
243	125	1 sweet onion, sliced into thin strips	1.0	\N	\N	11
244	132	1/2 apple or pear	0.5	\N	\N	0
244	51	1 tbsp brown sugar	1.0	tbsp	T	2
244	23	3 garlic cloves	3.0	cloves	cloves	4
244	62	1 tsp red pepper flakes	1.0	tsp	t	6
244	95	scallions	4.0	servings	servings	7
244	28	1 tsp sesame oil	1.0	tsp	t	8
244	46	1 tsp sesame seeds (garnish)	1.0	tsp	t	9
244	75	1/2 cup soy sauce	0.5	cup	c	10
245	52	1 1/2 cups bean sprouts	1.5	cups	c	1
245	2	1 cup carrots, julienned	1.0	cup	c	3
245	111	4 egg yolks	4.0	\N	\N	4
245	23	1 garlic clove, minced	1.0	clove	clove	6
245	95	1 cup green onions, chopped	1.0	cup	c	8
245	6	Pinch of salt	1.0	pinch	pinch	11
245	28	1/4 cup sesame oil	0.25	cup	c	12
245	46	2 teaspoons toasted sesame seeds	2.0	teaspoons	t	13
245	116	Pinch of sugar	1.0	pinch	pinch	15
246	14	2 egg strips (optional; garnish)	2.0	\N	\N	1
246	23	4 cloves garlic minced	4.0	cloves	cloves	2
246	59	1 tsp ground pepper	1.0	tsp	t	4
246	29	1/2 large Korea radish, cut into 1 inch slices	0.5	\N	\N	5
246	95	2 scallions, sliced into 1 inch pieces	2.0	\N	\N	6
246	97	2 tsp sea salt (Kosher okay too)	2.0	tsp	t	7
246	28	2 tsp sesame oil	2.0	tsp	t	8
246	46	1/2 tsp toasted sesame seeds (optional; garnish)	0.5	tsp	t	9
246	75	3 tbsp soy sauce	3.0	tbsp	T	10
247	23	5 garlic cloves (minced)	5.0	cloves	cloves	0
247	96	4 tablespoons dried ground chili pepper	4.0	tablespoons	T	2
247	6	Salt (if needed)	6.0	servings	servings	4
247	95	2 cups sliced scallions	2.0	cups	c	5
247	116	1 tablespoon sugar;	1.0	tablespoon	T	6
248	51	1 cup brown sugar, packed	1.0	cup	c	0
248	97	4 cups coarse sea salt	4.0	cups	c	1
248	23	12 garlic cloves	12.0	cloves	cloves	3
248	95	3 green onions, cut into 2-inch pieces	3.0	\N	\N	6
248	29	2 cups radish (1/2 Korean radish), cut into matchstick pieces	2.0	cups	c	8
248	4	1 yellow onion	1.0	\N	\N	10
249	10	1 tablespoon Butter or margarine	1.0	tablespoon	T	1
249	95	2 green onions, thinly sliced diagonally	2.0	\N	\N	4
249	73	1 tablespoon Olive oil	1.0	tablespoon	T	6
249	46	2 tbsp sesame seeds, toasted	2.0	tbsp	T	8
250	23	1 Clove minced garlic, or crushed	1.0	Clove	Clove	1
250	95	10 green onions, minced	10.0	\N	\N	2
250	28	3 tablespoons sesame oil	3.0	tablespoons	T	3
250	46	3 tablespoons toasted sesame seeds	3.0	tablespoons	T	4
250	75	1/4 cup soy sauce	0.25	cup	c	5
250	116	2 tablespoons sugar	2.0	tablespoons	T	6
251	59	Freshly ground black pepper	1.0	serving	serving	1
251	92	1 tablespoon Snipped chives	1.0	tablespoon	T	2
251	62	Crushed red pepper, to taste	1.0	serving	serving	3
251	23	2 cloves garlic (finely chopped)	2.0	cloves	cloves	5
251	6	Salt	1.0	serving	serving	7
251	28	1/4 cup sesame oil	0.25	cup	c	8
251	75	1 tablespoon soy sauce	1.0	tablespoon	T	9
252	52	1 1/2 cups bean sprouts	1.5	cups	c	1
252	24	10 ounces cabbage kimchi	10.0	ounces	oz	2
252	2	1 cup carrots, julienned	1.0	cup	c	3
252	55	1 cup fresh shiitake mushrooms, thinly sliced	1.0	cup	c	4
252	23	2 garlic cloves, minced	2.0	cloves	cloves	5
252	95	1 cup green onions, chopped	1.0	cup	c	7
252	6	1 teaspoon Salt	1.0	teaspoon	t	9
252	28	1/4 cup sesame oil	0.25	cup	c	10
252	46	2 teaspoons toasted sesame seeds	2.0	teaspoons	t	11
252	116	Pinch of sugar	1.0	pinch	pinch	13
253	79	3 tablespoons chilly paste (reduce for less spicy)/ korean gochujang paste	3.0	tablespoons	T	1
253	23	1 whole garlic bulb, skinned	1.0	\N	\N	3
253	62	15 grams chilly flakes	15.0	grams	g	5
253	29	150 grams radish, julienned	150.0	grams	g	6
253	53	2 tablespoons fermented baby shrimps/ cincalok (you can even use brined fish/anchovies)	2.0	tablespoons	T	8
253	95	40 grams spring onions, cut into abt 2" lengths	40.0	grams	g	9
253	116	1/2 teaspoon sugar	0.5	teaspoon	t	10
254	2	1 medium organic carrot, thinly sliced	1.0	\N	\N	0
254	23	2 cloves organic garlic, minced	2.0	cloves	cloves	3
254	17	1 tablespoon of honey	1.0	tablespoon	T	5
254	18	1/2 Juice of a lemon	0.5	\N	\N	6
254	6	3 tablespoons of salt	3.0	tablespoons	T	8
254	95	3 organic scallions, sliced, include green and white parts	3.0	\N	\N	9
254	28	1 teaspoon of toasted sesame oil	1.0	teaspoon	t	10
255	142	1/2 tablespoon rice vinegar (recommended: O Yuzu Rice Vinegar by O 1/2 of a Serrano pepper, very thinly sliced1 Juice of lime5 small leaves of fresh mintsprinkle of black sesame seeds (optional)	0.5	\N	\N	2
255	142	1 Juice of lime	1.0	\N	\N	3
255	28	1 tsp. sesame oil	1.0	tsp	t	5
255	75	1In medium bowl mix soy sauce, toasted sesame oil, rice vinegar, Serrano pepper, lime juice, mint, and sesame seeds. Then add diced tuna and toss to coat.	3.0	servings	servings	6
255	75	5 tbsp. soy sauce	5.0	tbsp	T	7
256	59	1 tsp black pepper	1.0	tsp	t	2
256	93	1/2 cup fresh cilantro, chopped	0.5	cup	c	4
256	23	2 garlic cloves, pressed	2.0	cloves	cloves	5
256	49	1 tsp ground cumin	1.0	tsp	t	6
256	137	1 jalapeño, seeded and diced	1.0	\N	\N	7
256	141	1 fresh lime, juiced	1.0	\N	\N	8
256	98	1/2 tsp kosher salt	0.5	tsp	t	9
256	141	1 fresh lime, cut into wedges	1.0	\N	\N	10
256	142	1/2 cup fresh lime juice	0.5	cup	c	11
256	73	1 Tbsp Olive oil	1.0	Tbsp	Tbsp	12
256	4	1/2 cup onion, diced	0.5	cup	c	13
256	4	1 small onion, diced	1.0	\N	\N	14
256	41	1/2 tsp paprika	0.5	tsp	t	15
256	48	2 Roma tomatoes, diced	2.0	\N	\N	16
257	93	1 Bunch Cilantro Chopped	1.0	\N	\N	1
257	23	2 garlic cloves, finely minced	2.0	cloves	cloves	2
257	59	1/2 Tsp. - Fresh Ground Black Pepper	0.5	Tsp	Tsp	3
257	73	2 tablespoons olive oil	2.0	tablespoons	T	4
257	43	1 Bunch Parsley Chopped	1.0	\N	\N	5
257	62	1/2 Tsp. - Red Pepper Flakes	0.5	Tsp	Tsp	6
257	102	3 tablespoons red wine vinegar	3.0	tablespoons	T	7
257	6	1 1/2 Tsp. - Salt	1.5	Tsp	Tsp	8
258	62	1/2 teaspoon chili pepper flakes	0.5	teaspoon	t	1
258	43	1 cup flat leaf parsley, lightly packed & rough chopped	1.0	cup	c	3
258	23	3 to 5 garlic cloves, rough chopped	3.0	cloves	cloves	6
258	23	4 garlic cloves, peeled	4.0	cloves	cloves	7
258	98	Kosher salt	4.0	servings	servings	8
258	18	3 tablespoons lemon juice	3.0	tablespoons	T	9
258	73	1/4 cup of extra-virgin olive oil	0.25	cup	c	10
258	102	2 tablespoons Red wine vinegar	2.0	tablespoons	T	12
259	6	1/4 teaspoon salt	0.25	teaspoon	t	1
259	116	1 cup sugar	1.0	cup	c	2
259	20	1 quart whole milk	1.0	quart	quart	4
260	119	150 grams Almond cookies, crumbed	150.0	grams	g	0
260	40	1 tablespoon Cornstarch	1.0	tablespoon	T	1
260	13	450 grams Philiadelphia 13% balance cream cheese	450.0	grams	g	2
260	14	2 Eggs	2.0	\N	\N	4
260	18	Juice and zest of 1 lemon	1.0	\N	\N	5
260	6	Pinch of salt	1.0	pinch	pinch	6
260	116	1/2 cup organic sugar	0.5	cup	c	7
260	10	1 1/2 sticks cold butter cut into small pieces (if you use unsalted butter add a little 2 cups organic flour1/2 cup organic sugar1 teaspoon vanilla	1.5	sticks	sticks	8
261	15	2 cups organic flour	2.0	cups	c	0
261	116	1/2 cup organic sugar	0.5	cup	c	1
263	73	1/2 cup extra-virgin olive oil	0.5	cup	c	0
263	23	3 cloves garlic, peeled	3.0	cloves	cloves	2
263	45	2 tablespoons oregano	2.0	tablespoons	T	3
263	43	1 bunch parsley	1.0	bunch	bunch	4
263	102	1/4 cup red wine vinegar	0.25	cup	c	5
264	79	1/4 teaspoon chile-garlic paste	0.25	teaspoon	t	1
264	93	1 Tb. chopped cilantro	1.0	Tb	Tb	2
264	142	2 limes, juiced	2.0	\N	\N	4
264	73	Olive oil	4.0	servings	servings	5
264	48	1 medium tomato, seeded and finely chopped	1.0	\N	\N	8
265	8	2 teaspoons baking powder	2.0	teaspoons	t	0
265	10	3 teaspoons butter	3.0	teaspoons	t	1
265	12	1 tablespoon Cinnamon	1.0	tablespoon	T	2
265	14	3 Eggs	3.0	\N	\N	4
265	117	1/2 cup half-and-half	0.5	cup	c	6
265	20	1/4 cup milk	0.25	cup	c	8
265	6	1 teaspoon salt	1.0	teaspoon	t	12
265	116	1 teaspoon sugar	1.0	teaspoon	t	14
265	136	1 teaspoon vanilla	1.0	teaspoon	t	16
265	136	1 teaspoon vanilla extract	1.0	teaspoon	t	17
266	93	1/4 cup cilantro, freshly chopped for garnishment	0.25	cup	c	1
266	49	1 teaspoon Cumin	1.0	teaspoon	t	3
266	23	3 garlic cloves, minced	3.0	cloves	cloves	5
266	3	1 green bell pepper, julienned	1.0	\N	\N	6
266	137	1 jalapeno pepper, seeded and chopped finely	1.0	\N	\N	7
266	48	8 inches plum tomatoes, halved and cut into 1 chunks	8.0	inches	inches	8
266	77	1 red bell pepper, julienned	1.0	\N	\N	9
266	102	1 teaspoon red wine vinegar	1.0	teaspoon	t	10
266	75	Soy sauce	4.0	servings	servings	11
266	4	1 yellow onion, chopped finely	1.0	\N	\N	12
267	3	2 bell peppers	2.0	\N	\N	1
267	93	2 sprigs of cilantro	2.0	sprigs	sprigs	3
267	23	2 cloves garlic	2.0	cloves	cloves	5
267	4	1/2 onion	0.5	\N	\N	6
267	59	pepper	2.0	servings	servings	7
267	6	salt	2.0	servings	servings	8
267	135	tabasco sauce	2.0	servings	servings	9
268	3	1 large bell pepper, diced	1.0	\N	\N	0
268	35	1 (14 ounce) can black beans, rinsed and drained	14.0	ounce	oz	1
268	68	1 28-ounce can crushed or puréed tomatoes	28.0	ounce	oz	2
268	96	2 teaspoons chili powder	2.0	teaspoons	t	3
268	45	1 teaspoon dried oregano	1.0	teaspoon	t	4
268	49	1/2 teaspoon ground cumin	0.5	teaspoon	t	6
268	4	1 cup chopped onion	1.0	cup	c	8
268	41	1 teaspoon paprika	1.0	teaspoon	t	9
269	35	1 can black beans, rinsed, drained and mashed	1.0	can	can	0
269	2	1 carrot, peeled and diced	1.0	\N	\N	2
269	15	1/2 cup all-purpose flour	0.5	cup	c	5
269	43	1 teaspoon fresh parsley, chopped	1.0	teaspoon	t	6
269	23	1-2 cloves garlic, minced	1.0	cloves	cloves	7
269	23	2 garlic cloves, minced	2.0	cloves	cloves	8
269	95	2 green onions, diced	2.0	\N	\N	9
269	60	1 teaspoon ground red pepper (more or less to taste)	1.0	teaspoon	t	10
269	59	1 teaspoon ground black pepper (more or less to taste)	1.0	teaspoon	t	11
269	137	1/2-1 jalapeño pepper, seeded and diced	0.5	\N	\N	12
269	142	Juice of 1 lime	1.0	\N	\N	13
269	4	1 cup chopped onion	1.0	cup	c	15
269	77	1/2 cup red pepper, seeded and diced	0.5	cup	c	17
269	6	1/2 teaspoon salt	0.5	teaspoon	t	19
269	48	3 medium-sized tomatoes, diced	3.0	\N	\N	20
270	62	1/2 teaspoon red chili pepper flakes	0.5	teaspoon	t	2
270	59	fresh cracked black pepper, to taste	4.0	servings	servings	3
270	94	1/4 cup coriander leaves, chopped	0.25	cup	c	5
270	143	1/4 cup grape seed, rice bran or extra light	0.25	cup	c	6
270	95	4 green onions, cut into 1-inch pieces	4.0	\N	\N	7
270	141	1/2 lime	0.5	\N	\N	8
270	53	8 prawns (about 1/2 lb), peeled	0.5	lb	lb	12
270	73	1 1/2 tablespoons extra light olive oil or rice bran oil (for cooking prawns)	1.5	tablespoons	T	13
270	97	unrefined sea salt, taste	4.0	servings	servings	16
270	7	1 cup water	1.0	cup	c	17
271	103	1 teaspoon Balsamic vinegar	1.0	teaspoon	t	1
271	49	1 teaspoon Cumin	1.0	teaspoon	t	2
271	23	1 clove garlic	1.0	clove	clove	4
271	77	1/2 medium Red Pepper	0.5	\N	\N	5
272	93	1 cup cilantro, finely chopped	1.0	cup	c	0
272	73	extra-virgin olive oil	4.0	servings	servings	1
272	23	3 garlic clove, minced	3.0	clove	clove	3
272	137	1/2 large jalapeno, seeded and minced ( whole 1 if brave)	0.5	\N	\N	4
272	18	1/2 Lemon, juice of	0.5	\N	\N	5
272	142	Juice of large 1/2 lime	0.5	\N	\N	6
272	95	4 scallions, white only finely chopped	4.0	\N	\N	8
272	48	2 medium tomatoes, finely chopped	2.0	\N	\N	9
273	23	3 clv garlic, chopped	3.0	\N	\N	1
273	95	3 green onions, sliced	3.0	\N	\N	2
273	17	1 tablespoon (15 ml) honey	15.0	ml	ml	3
273	137	1 jalapeno pepper (seeded), 1/4 inch chunks	1.0	\N	\N	4
273	142	2 tablespoons (30 ml) lime juice	30.0	ml	ml	5
273	115	1 fresh pineapple, 1/2 inch chunks	1.0	\N	\N	7
273	77	1 sweet red pepper, 1/4 inch chunks	1.0	\N	\N	8
274	93	2 tablespoons fresh cilantro, minced	2.0	tablespoons	T	3
274	137	1 small jalapeno, seeded and finely minced (use more or less based on personal preference)	1.0	\N	\N	5
274	142	1 tablespoon fresh lime juice	1.0	tablespoon	T	7
274	73	2 tablespoons olive oil	2.0	tablespoons	T	9
274	4	2 tablespoons onion, finely diced	2.0	tablespoons	T	10
274	48	3 tomatoes seeded, diced fine	3.0	\N	\N	13
275	88	2 tablespoons chopped fresh basil	2.0	tablespoons	T	2
275	23	1 clove garlic, minced	1.0	clove	clove	4
275	73	2 small 1 tablespoones olive oil	2.0	tablespoon	T	7
275	115	1 cup fresh pineapple, diced	1.0	cup	c	9
276	93	1/4 cup chopped cilantro	0.25	cup	c	0
276	142	juice of half a lime	4.0	\N	\N	3
276	115	1 cup finely-chopped fresh pineapple	1.0	cup	c	4
276	6	Salt	4.0	servings	servings	6
277	59	black pepper	2.0	servings	servings	1
277	93	1 bunch cilantro	1.0	bunch	bunch	4
277	23	4 cloves garlic	4.0	cloves	cloves	6
277	49	ground cumin	2.0	servings	servings	7
277	137	1 small jalapeno	1.0	\N	\N	8
277	141	1 lime	1.0	\N	\N	9
277	4	2 cups red onion	2.0	cups	c	14
277	97	sea salt	2.0	servings	servings	15
277	128	sour cream	2.0	servings	servings	16
277	48	some fresh tomatoes	2.0	servings	servings	17
277	100	1 dash white vinegar	1.0	dash	dash	18
278	3	20 mini bell peppers (you can buy in a large bag)	20.0	\N	\N	0
278	35	7 oz canned black beans ( about 1/2 a can)	7.0	oz	oz	1
278	96	1 TBSP Chili Powder	1.0	TBSP	TBSP	2
278	120	3 oz chipotles in adobo ( about 1/2 a can)	3.0	oz	oz	3
278	23	1 tablespoon minced garlic	1.0	tablespoon	T	5
278	121	4 oz can green chilies	4.0	oz	oz	6
278	94	1 TSP Ground Coriander	1.0	\N	\N	7
278	49	1 TBSP Ground Cumin	1.0	TBSP	TBSP	8
278	41	1 TBSP Paprika	1.0	TBSP	TBSP	10
278	4	1/2 yellow onion	0.5	\N	\N	12
279	10	2 tablespoons of Butter	2.0	tablespoons	T	0
279	96	1/2 teaspoon Chili Powder	0.5	teaspoon	t	3
279	93	1 bunch Small of Cilantro	1.0	bunch	bunch	4
279	49	1/2 teaspoon of Cumin	0.5	teaspoon	t	5
279	15	3 tablespoons of Flour	3.0	tablespoons	T	6
279	20	1 cup of Milk	1.0	cup	c	7
280	35	15 oz can of black beans, rinsed and drained	15.0	oz	oz	1
280	73	1 teaspoon olive oil	1.0	teaspoon	t	4
280	4	1 1/2 cups of onion, diced	1.5	cups	c	5
280	45	1 teaspoon oregano	1.0	teaspoon	t	6
281	101	1/4 cup apple cider vinegar	0.25	cup	c	0
281	2	1 carrot, grated	1.0	\N	\N	1
281	120	1/2 can chipotle chilies in adobo sauce (3-4 peppers chopped)	0.5	can	can	2
281	23	2 Cloves garlic, minced	2.0	Cloves	Cloves	3
281	142	Juice of 1 lime	1.0	\N	\N	5
281	56	2 cups chopped mushrooms	2.0	cups	c	6
281	73	3 tablespoons olive oil	3.0	tablespoons	T	7
281	4	1 green onion stalk	1.0	\N	\N	8
281	6	2 tablespoons salt	2.0	tablespoons	T	12
281	107	1 cup vegetable broth	1.0	cup	c	14
281	4	1 yellow onion	1.0	\N	\N	15
282	59	Freshly-ground black pepper to taste	4.0	servings	servings	1
282	124	Pinch of Cayenne pepper	1.0	pinch	pinch	2
282	93	1 tablespoon cilantro, chopped fine	1.0	tablespoon	T	3
282	23	1 clove garlic, minced	1.0	clove	clove	5
282	49	1 teaspoon ground cumin	1.0	teaspoon	t	7
282	137	1/2 jalapeno, minced	0.5	\N	\N	8
282	142	Juice of 1 lime	1.0	\N	\N	9
282	98	1/2 teaspoon Kosher salt	0.5	teaspoon	t	11
282	73	2 tablespoons olive oil	2.0	tablespoons	T	13
282	4	1 red onion – sliced	1.0	\N	\N	15
282	6	Salt to taste	4.0	servings	servings	16
283	35	1 can black beans, rinsed and drained	1.0	can	can	1
283	142	juice of 1 lime	1.0	\N	\N	4
283	73	1 tbsp olive oil	1.0	tbsp	T	5
283	4	1 small onion, diced	1.0	\N	\N	6
283	77	2 red bell peppers, diced	2.0	\N	\N	7
284	68	1 can (28oz) whole tomatoes with juice	28.0	oz	oz	0
284	93	1/2 cup fresh cilantro (large stems removed)	0.5	cup	c	1
284	23	1 clove garlic, minced	1.0	clove	clove	2
284	49	1/4 - 1/2 t. ground cumin	0.25	t	t	3
284	137	1 whole jalapeno, quartered, seeds removed, sliced thin.	1.0	\N	\N	4
284	142	juice from 1/2 a lime	2.0	\N	\N	5
284	4	1/4 of an onion chopped (approximately 1/4 cup)	0.25	\N	\N	6
284	6	Salt to taste	4.0	servings	servings	7
284	116	1/4 t. sugar	0.25	t	t	9
284	48	2 cans (10oz) Rotel tomatoes (or the store brand of diced tomatoes and green chilies)	10.0	oz	oz	10
285	3	1 whole Bell Pepper	1.0	\N	\N	0
285	59	black pepper	4.0	servings	servings	1
285	35	1 can 14.5-oz. Black Beans	1.0	can	can	2
285	2	1 whole Carrot	1.0	\N	\N	3
285	96	1 Tablespoon Chili Powder	1.0	Tablespoon	Tablespoon	4
285	96	1 teaspoon Chili Powder	1.0	teaspoon	t	5
285	73	2 Tablespoons Olive Oil	2.0	Tablespoons	Tablespoons	10
285	4	1/2 whole Onion	0.5	\N	\N	11
285	128	4 Tablespoons Light Sour Cream	4.0	Tablespoons	Tablespoons	17
286	14	6 eggs	6.0	\N	\N	1
286	141	3 limes	3.0	\N	\N	2
286	116	3/4 cup sugar	0.75	cup	c	3
286	7	3 tablespoons water	3.0	tablespoons	T	5
286	20	2 cups whole milk	2.0	cups	c	6
287	8	1 teaspoon of Baking Powder	1.0	teaspoon	t	0
287	10	1 stick of Butter	1.0	stick	stick	2
287	96	2 teaspoons of Chili Powder	2.0	teaspoons	t	3
287	93	1 bunch Large of Chopped Cilantro	1.0	bunch	bunch	4
287	49	2 teaspoons of Cumin	2.0	teaspoons	t	6
287	23	1 clove Garlic minced	1.0	clove	clove	7
287	95	3 Green Onions, Chopped	3.0	\N	\N	8
287	142	1/2 of a Lime, Juiced	0.5	\N	\N	9
287	48	2 Roma Tomatoes, Chopped	2.0	\N	\N	12
287	6	Salt	1.0	serving	serving	13
288	3	1/2 green bell pepper	0.5	\N	\N	1
288	142	1 tablespoon of lime juice	1.0	tablespoon	T	2
288	77	1/2 red bell pepper	0.5	\N	\N	5
288	4	2 handfuls of chopped red onions	2.0	handfuls	handfuls	6
288	116	A pinch of sugar	1.0	pinch	pinch	7
289	18	1 ounce Lemon juice	1.0	ounce	oz	2
289	73	Olive oil	10.0	servings	servings	4
289	43	1/2 cup parsley, chopped	0.5	cup	c	5
289	4	1 cup Red onion (minced)	1.0	cup	c	6
289	48	1 ea. Tomato diced	1.0	\N	\N	8
289	7	8 ounces water	8.0	ounces	oz	9
290	2	8 small carrots	8.0	\N	\N	0
290	49	1 tbsp cumin	1.0	tbsp	T	2
290	23	4 cloves garlic, minced	4.0	cloves	cloves	4
290	59	1 tbsp ground pepper	1.0	tbsp	T	7
290	18	juice of 1 lemon	1.0	\N	\N	9
290	73	1/2 tbsp olive oil	0.5	tbsp	T	12
290	73	1 tbsp olive oil	1.0	tbsp	T	13
290	4	1/2 onion, minced	0.5	\N	\N	14
290	43	1/2 cup parsley, roughly chopped	0.5	cup	c	16
290	6	1 tbsp salt	1.0	tbsp	T	19
291	124	1 teaspoon cayenne pepper	1.0	teaspoon	t	1
291	49	1/2 teaspoon cumin	0.5	teaspoon	t	2
291	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	4
291	95	5 green onions, chopped	5.0	\N	\N	5
291	43	1/2 cup parsley, chopped	0.5	cup	c	6
291	29	5 red radishes, diced	5.0	\N	\N	8
291	102	3 1/2 tablespoons red wine vinegar	3.5	tablespoons	T	9
291	6	2 teaspoons salt	2.0	teaspoons	t	10
291	48	1/2 tomato	0.5	\N	\N	11
291	7	1 cup water	1.0	cup	c	13
291	83	1/2 cup yellow pepper,diced	0.5	cup	c	14
292	43	1 bunch of flat leaf parsley	1.0	bunch	bunch	2
292	18	1/2 lemon juice from a lemon	0.5	\N	\N	3
292	73	3 tablespoons of olive oil	3.0	tablespoons	T	4
292	6	Salt	1.0	serving	serving	5
292	48	2 medium sized tomatoes	2.0	\N	\N	6
293	37	540 ml can of chickpeas, drained and rinsed	540.0	ml	ml	0
293	43	1 large handful parsley, chopped	1.0	handful	handful	2
293	23	2 cloves garlic, grated or finely chopped	2.0	cloves	cloves	3
293	4	1 small red onion, chopped	1.0	\N	\N	6
293	32	� tsp sriracha sauce	0.5	tsp	t	7
293	48	8 slices of tomato	8.0	slices	slices	9
294	37	2 cans garbanzo beans (chickpeas), drained and rinsed	2.0	cans	cans	0
294	96	1 tablespoon chili powder	1.0	tablespoon	T	1
294	49	1 tablespoon cumin	1.0	tablespoon	T	3
294	15	4 tablespoons flour	4.0	tablespoons	T	4
294	43	1 large handful parsley, chopped	1.0	handful	handful	5
294	23	2 cloves garlic, grated or finely chopped	2.0	cloves	cloves	6
294	18	juice of 2 lemons	2.0	\N	\N	8
294	4	1 small red onion, chopped	1.0	\N	\N	10
294	72	1/4 cup vegetable oil	0.25	cup	c	14
294	7	3 tablespoons water	3.0	tablespoons	T	15
295	8	1 teaspoon baking powder	1.0	teaspoon	t	1
295	1	1 cup raw black eyed beans	1.0	cup	c	2
295	50	2 teaspoons cumin seeds	2.0	teaspoons	t	5
295	36	1 cup raw garbanzo beans/ chickpeas	1.0	cup	c	6
295	23	4 garlic cloves - chopped	4.0	cloves	cloves	7
295	4	1/2 cup onions - finely chopped	0.5	cup	c	8
295	43	1 tablespoon parsley - chopped	1.0	tablespoon	T	9
295	6	Salt	12.0	servings	servings	11
295	72	1 cup vegetable oil, for frying	1.0	cup	c	12
296	49	1 teaspoon cumin	1.0	teaspoon	t	1
296	95	3/4 cup green onions, chopped	0.75	cup	c	4
296	73	1/4 cup olive oil	0.25	cup	c	7
296	43	1/4 cup chopped parsley	0.25	cup	c	8
296	77	2 red bell peppers	2.0	\N	\N	10
296	48	1 large tomato, chopped	1.0	\N	\N	12
297	14	2 Eggs	2.0	\N	\N	1
297	43	3 tablespoons minced fresh parsley	3.0	tablespoons	T	2
297	23	2 garlic cloves, minced	2.0	cloves	cloves	3
297	42	1 kilo lean ground beef or lamb	1.0	\N	\N	4
297	49	1 tablespoon ground cumin	1.0	tablespoon	T	5
297	4	1 small Onion, chopped finely	1.0	\N	\N	6
297	41	1 teaspoon paprika	1.0	teaspoon	t	7
297	76	2 medium green peppers, seeded and cut diagonally into slices	2.0	\N	\N	8
297	71	1 tablespoon tomato paste	1.0	tablespoon	T	10
297	48	3 large tomatoes, diced	3.0	\N	\N	11
297	10	2 tablespoons unsalted butter	2.0	tablespoons	T	12
297	73	1/4 cup virgin olive oil	0.25	cup	c	13
298	7	2 Liters WATER TO BOIL MEAT	2.0	liters	l	2
298	4	2 Larges ONION	2.0	\N	\N	3
298	10	1 1/2 cups BUTTER	1.5	cups	c	6
298	6	Salt	6.0	serving	serving	8
298	49	1 teaspoon Cumin, Turmeric, and any other spices if desired for	1.0	teaspoon	tsp	9
299	12	1/2 teaspoon cinnamon	0.5	teaspoon	t	1
299	116	cup sugar	1.0	cup	c	5
299	136	1/2 teaspoon vanilla extract	0.5	teaspoon	t	6
299	7	cup water	1.0	cup	c	8
300	68	1 400 gram can peeled tomatoes, (chopped)	400.0	gram	g	0
300	81	1 tablespoon curry powder, (1 to 2)	1.0	tablespoon	T	1
300	14	1 egg, lightly beaten	1.0	\N	\N	2
300	23	5 cloves garlic	5.0	cloves	cloves	5
301	37	16 oz can chickpeas, drained and rinsed	16.0	oz	oz	0
301	43	2 tablespoons fresh parsley	2.0	tablespoons	T	3
301	23	1 garlic clove, minced	1.0	clove	clove	4
301	23	4 garlic cloves, minced	4.0	cloves	cloves	5
301	94	1 teaspoon ground coriander	1.0	teaspoon	t	6
301	49	1 tablespoon ground cumin	1.0	tablespoon	T	7
301	41	1/2 teaspoon paprika	0.5	teaspoon	t	9
301	4	1/2 red onion, finely sliced	0.5	\N	\N	11
301	48	1 tomato, diced	1.0	\N	\N	14
301	112	2 tablespoons whole wheat flour	2.0	tablespoons	T	17
301	4	1/2 yellow onion, chopped	0.5	\N	\N	18
302	43	3 cups flat leaf parsley, about one bushel	3.0	cups	c	1
302	95	3 tablespoons green onions, finely chopped	3.0	tablespoons	T	3
302	18	1 Juice from lemon	1.0	\N	\N	4
302	73	2 tablespoons olive oil	2.0	tablespoons	T	5
302	48	1/4 cup roma tomatoes, finely chopped	0.25	cup	c	6
303	73	extra light olive oil	2.0	servings	servings	2
303	3	1 green pepper cut into strips	1.0	\N	\N	3
303	4	1/2 small onion thinly sliced	0.5	\N	\N	6
303	43	chopped parsley	2.0	servings	servings	7
303	48	2 plum tomatoes cut into strips	2.0	\N	\N	9
303	29	1 bunch of radishes sliced	1.0	bunch	bunch	10
304	78	10-12 dried red chili peppers	10.0	\N	\N	3
304	12	1/2 teaspoon Cinnamon	0.5	teaspoon	t	4
304	49	1/2 tsp cumin	0.5	tsp	t	5
304	93	Coriander leaves, half chopped, half whole or	8.0	servings	servings	6
304	14	1 egg	1.0	\N	\N	7
304	23	1 teaspoon Minced garlic	1.0	teaspoon	t	8
304	94	1 tsp ground coriander	1.0	tsp	t	10
304	49	1 tsp ground cumin	1.0	tsp	t	11
304	73	1/4 cup olive oil (or vegetable oil)	0.25	cup	c	13
304	4	1 onion, finely chopped	1.0	\N	\N	14
304	60	1 red chili, finely chopped	1.0	\N	\N	15
304	6	1 teaspoon Salt	1.0	teaspoon	t	16
304	97	1/2 tsp sea salt	0.5	tsp	t	18
304	48	480g chopped tomato	480.0	g	g	19
305	43	1/2 cup chopped fresh parsley	0.5	cup	c	3
305	95	2 green onions	2.0	\N	\N	5
305	18	1/2 cup lemon juice	0.5	cup	c	6
305	73	3 tablespoons olive oil	3.0	tablespoons	T	7
305	48	1 tomato, diced	1.0	\N	\N	9
305	7	2 cups water	2.0	cups	c	10
306	49	1 tsp Cumin	1.0	tsp	t	1
306	14	1 egg	1.0	\N	\N	3
306	23	3 cloves garlic, minced	3.0	cloves	cloves	4
306	18	1/2 lemon, juiced	0.5	\N	\N	8
306	73	2 tbsp Olive OIl	2.0	tbsp	T	9
306	43	1/4 cup parsley, chopped	0.25	cup	c	10
306	4	1/4 Red Onion, thinly sliced	0.25	\N	\N	13
306	6	1 tsp Salt	1.0	tsp	t	14
306	48	1 tomato, cut into 1/4 inch slices, then halved	1.0	\N	\N	15
306	4	1/2 yellow onion, finely chopped	0.5	\N	\N	17
307	43	1/2 cup flat leaf parsley leaves (or a mix of parsley and mint)	0.5	cup	c	2
307	23	2 cloves garlic, minced	2.0	cloves	cloves	3
307	98	1 teaspoon kosher salt	1.0	teaspoon	t	4
307	18	2 tablespoons lemon juice	2.0	tablespoons	T	6
307	66	11/2 cups cooked lentils (many markets carry vacuum-packed, precooked lentils, or boil 1 cup dried brown lentils in 2 cups salted water until tender, then drain)	1.5	cups	c	7
307	73	3 tablespoons olive oil	3.0	tablespoons	T	8
307	4	1 small onion, coarsely chopped	1.0	\N	\N	9
307	43	1 tablespoon minced parsley	1.0	tablespoon	T	10
307	29	1 small bunch red radishes or other varietals such as watermelon or daikon (about 1/2 cup, shredded)	1.0	bunch	bunch	13
308	10	1 1/2 cups melted butter	1.5	cups	c	0
308	18	1 tsp lemon juice	1.0	tsp	t	2
308	116	1 Tbsp sugar	1.0	Tbsp	Tbsp	5
308	7	2 cups water	2.0	cups	c	6
309	10	4 tablespoons butter	4.0	tablespoons	T	1
309	88	12 large fresh basil leaves	12.0	\N	\N	2
309	23	1 clove garlic	1.0	clove	clove	3
309	18	1/2 Juice of lemon	0.5	\N	\N	5
309	73	1 tablespoon olive oil	1.0	tablespoon	T	7
309	6	Salt	4.0	servings	servings	10
309	53	1 pound shrimp	1.0	pound	lb	11
309	125	1 sweet onion finely chopped	1.0	\N	\N	13
309	7	cups boiling water	1.0	cups	c	14
310	8	1/4 teaspoon Baking powder	0.25	teaspoon	t	1
310	10	1 cup Butter or margarine, softened	1.0	cup	c	3
310	15	1 3/4 cups All-purpose flour	1.75	cups	c	4
310	6	1/4 teaspoon Salt	0.25	teaspoon	t	5
310	116	1 cup Sugar	1.0	cup	c	7
311	14	1 Egg, beaten	1.0	\N	\N	2
311	15	1 1/2 cups Unsifted flour	1.5	cups	c	3
312	73	2 tablespoons of olive oil	2.0	tablespoons	T	4
312	4	1 finely diced onion	1.0	\N	\N	5
312	62	1 teaspoon of red pepper flakes (or to your taste)	1.0	teaspoon	t	6
312	7	1 cup of water	1.0	cup	c	8
313	70	2 heads of cauliflower	2.0	heads	heads	1
313	124	1/2 teaspoon cayenne pepper	0.5	teaspoon	t	2
313	15	3 tablespoons Flour	3.0	tablespoons	T	5
313	23	2 garlic cloves, pressed	2.0	cloves	cloves	6
313	18	2 tablespoons fresh lemon juice	2.0	tablespoons	T	7
313	129	1/4 cup low-fat sour cream	0.25	cup	c	9
313	41	1 teaspoon paprika	1.0	teaspoon	t	11
313	86	1 tablespoon minced thyme	1.0	tablespoon	T	16
314	16	dash nutmeg	1.0	dash	dash	1
315	8	1/2 teaspoon Baking powder	0.5	teaspoon	t	0
315	9	200 grams Riped Banana~ mash banana with a fork	200.0	grams	g	3
315	14	2 eggs	2.0	\N	\N	5
315	15	160 grams Plain Flour- sift together with baking powder and baking sod	160.0	grams	g	6
315	20	1/4 cup milk	0.25	cup	c	7
315	116	2/3 cup sugar	0.6666666666666666	cup	c	8
315	136	1/2 teaspoon Vanilla extract	0.5	teaspoon	t	9
316	126	1 1/2 cups smokey barbecue sauce	1.5	cups	c	0
316	51	3 tablespoons brown sugar	3.0	tablespoons	T	2
316	124	1/4 tsp cayenne pepper (use 1/2 tsp for more heat)	0.25	tsp	t	3
316	40	1/2 tbsp cornstarch	0.5	tbsp	T	4
316	49	1/2 tsp cumin	0.5	tsp	t	5
316	41	1/2 tsp smoked paprika (optional)	0.5	tsp	t	10
317	23	1 tablespoon clove fresh garlic (minced) or 1 wet garlic from a jar (no powder!)	1.0	tablespoon	T	7
317	3	1 green pepper	1.0	\N	\N	8
317	59	2 tablespoons fresh ground pepper	2.0	tablespoons	T	9
317	56	12 bite sized mushrooms	12.0	\N	\N	13
317	73	1/4 cup olive oil	0.25	cup	c	14
317	59	1/2 teaspoon pepper	0.5	teaspoon	t	16
317	77	1 red pepper	1.0	\N	\N	17
317	4	1 red onion	1.0	\N	\N	18
317	6	1 tablespoon salt	1.0	tablespoon	T	20
317	32	2 tablespoons Sriracha or Tabasco sauce	2.0	tablespoons	T	21
317	7	3 1/2 cups water	3.5	cups	c	22
318	111	4 Egg yolks	4.0	\N	\N	1
318	14	4 eggs	4.0	\N	\N	2
318	20	4 cups milk	4.0	cups	c	4
318	116	cup Sugar	1.0	cup	c	6
318	10	125 grams Unsalted Butter	125.0	grams	g	7
318	136	1 teaspoon Vanilla extract	1.0	teaspoon	t	8
319	62	� teaspoon crushed red pepper	0.25	teaspoon	t	1
319	14	2 eggs	2.0	\N	\N	2
319	23	6 cloves garlic, roasted and finely chopped	6.0	cloves	cloves	3
319	143	3 tablespoons grapeseed oil	3.0	tablespoons	T	4
319	77	� red bell pepper, roasted and chopped	0.5	\N	\N	6
319	6	1/4 teaspoon salt	0.25	teaspoon	t	7
320	73	1/4 cup olive oil (60 mL)	60.0	mL	mL	2
320	10	2 tablespoons Chilled unsalted butter	2.0	tablespoons	T	7
321	81	3 tablespoons Dry Curry Powder	3.0	tablespoons	T	0
321	89	2 tablespoons Dried Basil Leaves	2.0	tablespoons	T	1
321	137	2 Jalapenos, finely chopped	2.0	\N	\N	6
321	138	12 Baby Portabella Mushrooms, sliced	12.0	\N	\N	8
321	11	1 tablespoon Canola or Vegetable Cooking Oil	1.0	tablespoon	T	11
322	59	black pepper	4.0	servings	servings	0
322	62	1/4 teaspoon chili flakes	0.25	teaspoon	t	3
322	87	1/2 teaspoon dried thyme	0.5	teaspoon	t	4
322	23	1 clove garlic, thinly sliced	1.0	clove	clove	5
322	94	1/2 teaspoon ground coriander	0.5	teaspoon	t	6
322	56	1/3 cup mushrooms, sliced	0.3333333333333333	cup	c	8
322	73	olive oil	4.0	servings	servings	9
322	97	sea salt	4.0	servings	servings	10
322	4	1 medium yellow onion, thinly sliced	1.0	\N	\N	12
323	12	1/2 Cinnamon stick	0.5	\N	\N	0
323	15	1 1/2 tablespoons All-purpose flour	1.5	tablespoons	T	1
323	23	1 Garlic clove, minced	1.0	clove	clove	2
323	73	2 tablespoons extra-virgin olive oil	2.0	tablespoons	T	4
323	7	1 cup Water	1.0	cup	c	6
324	2	bunch of carrots, cut up	1.0	bunch	bunch	1
324	49	pinch of cumin	1.0	pinch	pinch	2
324	81	pinch of curry	1.0	pinch	pinch	3
324	23	1 clove garlic	1.0	clove	clove	4
324	66	2 cups of dry lentils	2.0	cups	c	5
324	59	pinch of pepper	1.0	pinch	pinch	6
324	97	pinch of sea salt	1.0	pinch	pinch	7
324	5	1 tablespoon of smooth organic peanut butter (optional)	1.0	tablespoon	T	8
324	7	2 cups water	2.0	cups	c	11
324	4	1 yellow onion, chopped up	1.0	\N	\N	12
325	132	2 apples, cored, peeled and sliced*	2.0	slices	slices	0
325	10	2 tablespoons butter or margarine	2.0	tablespoons	T	1
325	93	1/4 cup cilantro, chopped	0.25	cup	c	2
325	49	1 teaspoon cumin	1.0	teaspoon	t	4
325	143	2 tablespoons grapeseed oil, divided	2.0	tablespoons	T	5
325	17	2 tablespoons honey	2.0	tablespoons	T	6
325	142	Juice and zest of 1 lime	1.0	\N	\N	7
325	4	1 red onion, sliced	1.0	\N	\N	8
325	62	1/2 teaspoon red pepper flakes	0.5	teaspoon	t	9
326	103	2 tablespoons balsamic vinegar	2.0	tablespoons	T	0
326	88	3 leaves of basil, finely diced	3.0	leaves	leaves	1
326	48	1 large tomato, chopped	1.0	\N	\N	4
327	33	1 pound Dried Black Beans	1.0	pound	lb	0
327	120	3 tablespoons Chipotle chilies	3.0	tablespoons	T	2
327	49	2 tablespoons Ground Cumin	2.0	tablespoons	T	3
327	73	2 tablespoons olive oil	2.0	tablespoons	T	5
327	4	1 Onion – Chopped	1.0	\N	\N	6
328	15	1/4 cup flour	0.25	cup	c	1
328	6	2 1/2 teaspoons Salt	2.5	teaspoons	t	3
328	72	Vegetable oil	6.0	servings	servings	4
329	68	1 can (28- ounces) crushed tomatoes	28.0	ounces	oz	0
329	101	1 1/2 tablespoons cider vinegar	1.5	tablespoons	T	1
329	120	1 can chipotle chile, packed in adobo sauce, minced	7.0	oz	oz	3
329	23	3 garlic cloves, minced	3.0	cloves	cloves	4
329	18	1/2 Juice of lemon	0.5	\N	\N	5
329	73	1 1/2 tablespoons extra-virgin olive oil	1.5	tablespoons	T	6
329	4	1 medium onion diced	1.0	\N	\N	7
329	139	1 1/2 tablespoons Worcestershire sauce	1.5	tablespoons	T	9
330	1	15 ounces black eyed peas, drained and rinsed	15.0	ounces	oz	0
330	93	1/2 cup chopped cilantro	0.5	cup	c	1
330	23	1/2 teaspoon minced garlic	0.5	teaspoon	t	2
330	134	3 drops hot sauce	3.0	drops	drops	3
330	142	1 The juice of lime	1.0	\N	\N	4
330	48	1 ripe roma tomato, chopped	1.0	\N	\N	5
331	126	1/4 cup barbecue sauce	0.25	cup	c	0
331	10	1 Tbsp. butter	1.0	Tbsp	Tbsp	1
331	51	2 Tbsp. dark brown sugar	2.0	Tbsp	Tbsp	2
331	4	2 onions, diced	2.0	\N	\N	6
331	100	1/2 cup white vinegar	0.5	cup	c	9
331	139	2 Tbsp. Worcestershire sauce	2.0	Tbsp	Tbsp	10
332	45	1 teaspoon dried Oregano	1.0	teaspoon	t	2
332	143	1 tablespoon grapeseed oil	1.0	tablespoon	T	3
332	59	Salt & ground black pepper	4.0	servings	servings	5
332	86	� teaspoon Thyme	0.25	teaspoon	t	7
332	4	1/2 yellow onion, chopped up	0.5	\N	\N	9
333	68	1 can (14 1/2 oz.) diced tomatoes	14.5	oz	oz	2
333	73	extra-virgin olive oil	6.0	servings	servings	5
333	43	chopped fresh flat-leaf parsely	1.0	leaf	leaf	6
333	23	8-9 med garlic cloves, minced	8.0	cloves	cloves	7
333	4	1 onion	1.0	\N	\N	10
333	38	1/2 c. frozen peas	0.5	c	c	11
333	77	1 red bell pepper	1.0	\N	\N	12
333	53	1 lb. large shrimp	1.0	lb	lb	15
334	23	2 cloves garlic, minced	2.0	cloves	cloves	6
334	73	1 teaspoon olive oil	1.0	teaspoon	t	7
334	4	1/2 cup chopped onion	0.5	cup	c	8
334	45	3/4 teaspoon oregano	0.75	teaspoon	t	9
334	53	6 lg. prawns, shelled and deveined	6.0	\N	\N	10
334	77	1/2 cup each sliced red bell pepper and sliced	0.5	cup	c	11
334	6	1 tablespoon herbal salt substitute	1.0	tablespoon	T	15
334	48	1/2 cup diced tomato	0.5	cup	c	16
334	7	2 cups boiling water	2.0	cups	c	17
335	23	2 cloves garlic	2.0	cloves	cloves	3
335	73	1 tablespoon Olive Oil	1.0	tablespoon	T	5
335	43	1 tablespoon Chopped Parsley	1.0	tablespoon	T	6
336	59	freshly ground black pepper	4.0	servings	servings	0
336	14	4 eggs, well beaten	4.0	\N	\N	2
336	98	kosher salt	4.0	servings	servings	4
336	20	1 cup whole milk	1.0	cup	c	6
337	53	3/4 pound small frozen peeled, deveined, cooked shrimp, thawed	0.75	pound	lb	5
337	72	1 tablespoon vegetable oil	1.0	tablespoon	T	7
338	14	1 Large Egg	1.0	\N	\N	0
338	20	60ml Milk	60.0	ml	ml	4
339	111	8 larges egg yolks	8.0	\N	\N	0
339	136	1 teaspoon vanilla extract	1.0	teaspoon	t	3
339	116	1 tablespoon white sugar for each mould	1.0	tablespoon	T	4
340	10	1 ounce Butter	1.0	ounce	oz	0
340	92	Chives for garnish	6.0	servings	servings	1
340	118	3 egg whites	3.0	\N	\N	2
340	117	1/2 cup half-and-half plus	0.5	cup	c	3
340	117	2 tablespoons half-and-half	2.0	tablespoons	T	4
340	25	1 pound Leeks	1.0	pound	lb	5
340	73	1 1/2 tablespoons olive oil	1.5	tablespoons	T	6
340	6	1/2 teaspoon salt	0.5	teaspoon	t	7
341	73	2 teaspoons extra-virgin olive oil	2.0	teaspoons	t	3
341	23	6 cloves garlic, minced	6.0	cloves	cloves	4
341	43	1/4 cup parsley, chopped	0.25	cup	c	8
341	77	1 red bell pepper, chopped	1.0	\N	\N	10
341	62	1/2 teaspoon crushed red pepper flakes	0.5	teaspoon	t	11
341	53	3/4 pound peeled and deveined shrimp	0.75	pound	lb	14
341	86	6 sprigs thyme	6.0	sprigs	sprigs	16
342	51	1 cup brown sugar	1.0	cup	c	0
342	111	10 egg yolk	10.0	\N	\N	1
342	18	1/4 teaspoon lemon juice	0.25	teaspoon	t	3
342	7	1 cup water	1.0	cup	c	6
343	73	1 teaspoon olive oil	1.0	teaspoon	t	2
343	77	2 pounds x red bell peppers - (1 � total)	2.0	pounds	lb	4
343	53	1 1/2 pounds Shrimp, shelled and Deveined	1.5	pounds	lb	7
344	59	a pinch of freshly ground black pepper	1.0	pinch	pinch	0
344	45	2 t dried oregano	2.0	t	t	3
344	73	1/4 C extra-virgin olive oil	0.25	C	C	4
344	23	1 Clove Garlic, mashed	1.0	Clove	Clove	5
344	98	a pinch of Kosher salt	1.0	pinch	pinch	7
344	41	1 T smoky paprika	1.0	T	T	10
344	43	1/4 C Italian parsley leaves, chopped	0.25	C	C	11
344	53	1 1/2 pounds Shrimp, shelled and Deveined	1.5	pounds	lb	15
344	48	1 can of 14.5 oz whole tomatoes, drained, crushed and chopped coarse	1.0	\N	\N	16
344	7	2 C hot water	2.0	C	C	17
344	4	1 white onion, skinned and diced	1.0	\N	\N	18
345	77	1 lrg red bell pepper cut wide strips	1.0	\N	\N	2
345	43	Chopped parsley (fresh is best)	1.0	serving	serving	5
345	23	1 full head of garlic	1.0	\N	\N	6
345	23	Minced garlic as much as you like	1.0	serving	serving	7
345	3	1 green pepper diced	1.0	\N	\N	8
345	73	Olive oil as needed	1.0	serving	serving	11
345	4	1 medium onion	1.0	\N	\N	12
345	48	3 Roma plum tomatoes - (to 4) minced	3.0	\N	\N	13
346	43	Chopped parsley (fresh is best)	10.0	servings	servings	3
346	23	2 garlic cloves minced	2.0	cloves	cloves	4
346	73	15 milliliters olive oil	15.0	milliliters	ml	7
346	4	1 medium onion	1.0	\N	\N	8
346	48	200g deep red tomatoes	200.0	g	g	10
346	10	1/4 cup Unsalted butter	0.25	cup	c	11
346	7	1.5L water	1.0	liter	l	12
346	53	8 large crevettes	8.0	\N	\N	13
347	49	1 teaspoon cumin	1.0	teaspoon	t	5
347	23	2 cloves garlic, chopped	2.0	cloves	cloves	6
347	3	1 green pepper, chopped	1.0	\N	\N	7
347	73	1/2 cup olive oil	0.5	cup	c	10
347	4	1 medium onion, chopped	1.0	\N	\N	11
347	41	1 teaspoon paprika or pimenton	1.0	teaspoon	t	12
347	77	1 red pepper, chopped	1.0	\N	\N	14
347	84	1 teaspoon rosemary	1.0	teaspoon	t	15
347	53	1 pound shrimp with tails on	1.0	pound	lb	17
347	86	1 teaspoon thyme	1.0	teaspoon	t	18
347	48	1 tomato, chopped	1.0	\N	\N	19
348	8	2 teaspoons baking powder	2.0	teaspoons	t	0
348	10	2 tablespoons butter	2.0	tablespoons	T	1
348	51	3/4 cup dark brown sugar, packed firmly	0.75	cup	c	3
348	14	2 eggs	2.0	\N	\N	4
348	15	3 cups flour	3.0	cups	c	5
348	12	1 teaspoon ground cinnamon	1.0	teaspoon	t	6
348	16	1/8 teaspoon ground nutmeg	0.125	teaspoon	t	8
348	20	1/2 cup milk	0.5	cup	c	9
348	6	1/2 teaspoon salt	0.5	teaspoon	t	10
348	116	2 tablespoons sugar	2.0	tablespoons	T	12
349	101	3 tablespoons apple cider vinegar	3.0	tablespoons	T	0
349	44	2 teaspoons dried parsley	2.0	teaspoons	t	2
349	73	4 tablespoons extra-virgin olive oil	4.0	tablespoons	T	3
349	23	3 garlic cloves	3.0	cloves	cloves	4
349	82	1/4 orange bell pepper, diced	0.25	\N	\N	6
349	4	1/2 red onion, diced	0.5	\N	\N	8
349	6	1/8 teaspoon salt	0.125	teaspoon	t	10
349	97	2 teaspoons fine sea salt	2.0	teaspoons	t	11
349	48	3 ripe on the vine tomatoes, cored	3.0	\N	\N	13
349	7	1/4 cup water	0.25	cup	c	14
350	23	2 cloves of garlic, finely chopped	2.0	cloves	cloves	1
350	42	1 pound Ground beef	1.0	pound	lb	2
350	73	1 cup olive oil	1.0	cup	c	3
350	73	2 tablespoons of olive oil	2.0	tablespoons	T	4
350	4	1/2 cup onion, chopped	0.5	cup	c	5
350	4	Half an onion, finely chopped	20.0	servings	servings	6
350	43	2 tablespoons of chopped parsley	2.0	tablespoons	T	7
350	116	1 teaspoon of sugar	1.0	teaspoon	t	9
350	41	pinch of Pimenton de la Vera (Dulce) or Spanish sweet paprika	1.0	pinch	pinch	10
350	48	600g tomatoes	600.0	g	g	11
350	21	4 slices of sandwich bread, only the white part, diced	4.0	slices	slices	12
350	14	1 large egg, whole	1.0	\N	\N	13
351	96	1/2 teaspoon chili powder	0.5	teaspoon	t	1
351	43	2 tablespoons fresh flat-leaf parsley	2.0	tablespoons	T	3
351	45	2 tablespoons fresh oregano	2.0	tablespoons	T	4
351	84	1 teaspoon fresh rosemary	1.0	teaspoon	t	5
351	23	3 cloves of garlic, peeled & rough chopped	3.0	cloves	cloves	6
351	98	Kosher salt & freshly cracked black pepper	8.0	servings	servings	7
351	73	2 tablespoons olive oil	2.0	tablespoons	T	8
351	77	2 red bell peppers	2.0	\N	\N	9
351	102	2 tablespoons red wine vinegar	2.0	tablespoons	T	10
351	41	1 teaspoon smoked paprika	1.0	teaspoon	t	11
351	116	1 tablespoon sugar	1.0	tablespoon	T	12
352	62	1/4 teaspoon crushed red pepper (or more, to taste)	0.25	teaspoon	t	0
352	23	2 cloves garlic, minced	2.0	cloves	cloves	1
352	102	2 tablespoons red wine vinegar, according to desired consistency	2.0	tablespoons	T	4
352	119	1/4 cup roasted almonds	0.25	cup	c	5
352	77	1 whole 12 oz. jar roasted red peppers (or about 2- 3 fresh red bell peppers, roasted)	12.0	oz	oz	6
352	6	1 teaspoon salt - (about)	1.0	teaspoon	t	7
353	2	1/4 carrot, sliced thinly	0.25	\N	\N	1
353	23	3 cloves garlic, chopped coarsely	3.0	cloves	cloves	4
353	116	1 teaspoon sugar	1.0	teaspoon	t	5
353	7	3 tablespoons of water	3.0	tablespoons	T	6
354	59	1 teaspoon black pepper	1.0	teaspoon	t	0
354	51	3 tablespoons brown sugar	3.0	tablespoons	T	1
354	51	3 tablespoons dark brown sugar	3.0	tablespoons	T	4
354	73	Extra oil for cooking	30.0	servings	servings	5
354	23	1 clove garlic, chopped	1.0	clove	clove	8
354	94	1 teaspoon ground coriander	1.0	teaspoon	t	9
354	49	1 teaspoon ground cumin	1.0	teaspoon	t	10
354	18	1 tablespoon lemon juice	1.0	tablespoon	T	11
354	18	3 tablespoons lemon juice	3.0	tablespoons	T	12
354	75	1 tablespoon light soya sauce	1.0	tablespoon	T	13
354	5	Peanut butter, to taste	30.0	servings	servings	14
354	123	2 tablespoons red curry paste	2.0	tablespoons	T	15
354	72	1 tablespoon vegetable oil	1.0	tablespoon	T	20
355	88	1/2 cup packed holy basil leaves & flowers	0.5	cup	c	0
355	11	2 tablespoons canola oil	2.0	tablespoons	T	4
355	2	1 carrot, sliced	1.0	\N	\N	5
355	122	1 sliced orange chili (about 1 tablespoon)	1.0	tablespoon	T	6
355	122	1 tablespoon smashed small Thai chilies	1.0	tablespoon	T	7
355	23	3 garlic, minced	3.0	\N	\N	8
355	59	2 tablespoons fresh peppercorns	2.0	tablespoons	T	10
355	75	1 tablespoon fish sauce or white soy sauce (or more to taste)	1.0	tablespoon	T	12
355	127	1 1/2 teaspoon Tamari	1.5	teaspoon	t	14
355	100	1/4 teaspoon vinegar	0.25	teaspoon	t	16
355	7	3/4 cup of water	0.75	cup	c	17
356	142	1 whole lime, juiced	1.0	\N	\N	2
356	116	1 tablespoon sugar	1.0	tablespoon	T	5
356	48	2 whole tomatoes, diced	2.0	\N	\N	6
357	23	3 large cloves garlic, coarsely chopped	3.0	cloves	cloves	2
357	142	1/4 c. lime juice	0.25	c	c	4
357	4	1/2 c. very coarsely chopped onion	0.5	c	c	5
357	77	1 red bell pepper, coarsely chopped	1.0	\N	\N	6
357	116	1 pinch of sugar	1.0	pinch	pinch	7
358	88	1/2 cup (s) of fresh basil, chopped	0.5	cup	c	0
358	59	1 pinch of ground black pepper	1.0	pinch	pinch	3
358	52	3/4 cup (s) of mung bean sprouts	0.75	cup	c	4
358	5	1/4 cup (s) of natural peanut butter, creamy (no sugar!)	0.25	cup	c	5
358	97	1 teaspoon of sea salt	1.0	teaspoon	t	10
358	28	1 tablespoon of sesame oil	1.0	tablespoon	T	11
358	28	2 tablespoons of sesame oil	2.0	tablespoons	T	12
358	46	1 tablespoon of sesame seeds	1.0	tablespoon	T	13
358	75	2 tablespoons of shoyu or soy sauce	2.0	tablespoons	T	14
358	116	1 1/2 tablespoons of sugar	1.5	tablespoons	T	15
359	93	1/4 cup fresh cilantro, chopped	0.25	cup	c	0
359	23	1 teaspoon minced garlic	1.0	teaspoon	t	1
359	73	1 tablespoon olive oil	1.0	tablespoon	T	4
359	4	1 cup finely chopped onion	1.0	cup	c	5
359	67	1 cup red lentils, picked through for stones, and rinsed well	1.0	cup	c	6
359	6	1/2 teaspoon salt, or more to taste	0.5	teaspoon	t	7
359	7	6 cups water	6.0	cups	c	11
360	14	2 eggs	2.0	\N	\N	0
360	23	clove garlic, minced fine	1.0	clove	clove	1
360	3	1/2 green pepper, chopped	0.5	\N	\N	2
360	4	1 big onion, sliced	1.0	\N	\N	4
360	6	• Salt to taste	1.0	serving	serving	8
360	75	2 1/2 tablespoons soy sauce	2.5	tablespoons	T	9
360	116	2 teaspoons sugar	2.0	teaspoons	t	10
360	48	1 tomato, diced	1.0	\N	\N	11
360	7	4 cups water	4.0	cups	c	12
361	93	1/4 cup of coriander leaves- chopped	0.25	cup	c	1
361	14	1 Egg, Lightly Beaten	1.0	\N	\N	2
361	60	1 -2 Red chili	1.0	\N	\N	6
361	123	2 tbsp Red Curry Paste	2.0	tbsp	T	7
361	6	salt	2.0	servings	servings	8
361	95	2 Spring Onion, Chopped	2.0	\N	\N	9
362	2	1 cup carrot, shredded	1.0	cup	c	0
362	122	2 to 3 chili padis	2.0	\N	\N	1
362	23	1 clove of garlic, mashed	1.0	clove	clove	3
362	141	4 limes	4.0	\N	\N	4
362	53	1 tablespoon of dried shrimps, washed	1.0	tablespoon	T	9
362	48	1 tomato, cut into wedges	1.0	\N	\N	10
363	59	1 tsp black peppercorns	1.0	tsp	t	2
363	50	1 tsp cumin seeds	1.0	tsp	t	4
363	94	2-3 sprigs coriander leaves (cut off roots and include the stems)	2.0	sprigs	sprigs	5
363	23	2 teaspoons minced garlic	2.0	teaspoons	t	8
363	142	2 tablespoons lemon or lime juice	2.0	tablespoons	T	12
363	78	5-6 dried red chilies	5.0	\N	\N	15
363	6	Salt for taste (only if need or use sparingly as fish sauce is salty)	5.0	servings	servings	17
364	93	1/2 cup – 1 cilantro leaves, chopped	0.5	cup	c	2
364	23	2 cloves garlic, minced	2.0	cloves	cloves	4
364	30	2 tablespoons hoisin sauce	2.0	tablespoons	T	5
364	18	2 tablespoons lemon juice	2.0	tablespoons	T	6
364	73	2 tablespoons olive oil	2.0	tablespoons	T	7
364	4	1 cup onions, diced	1.0	cup	c	8
364	75	2 tablespoons soy sauce	2.0	tablespoons	T	10
364	77	1 cup sweet peppers, diced	1.0	cup	c	11
365	51	� cup brown sugar	0.25	cup	c	1
365	4	2 onions, slice	2.0	\N	\N	5
365	77	1/2 cup red bell pepper (julienne)	0.5	cup	c	7
365	31	250 grams snow peas, trimmed	250.0	grams	g	9
366	52	1 cup fresh bean sprouts	1.0	cup	c	3
366	93	Fresh flat leaf parsley or cilantro leaves for garnish	1.0	leaves	leaves	4
366	116	3 teaspoons granulated sugar	3.0	teaspoons	t	5
366	95	4 green onions	4.0	\N	\N	6
366	142	1/2 cup fresh lime juice	0.5	cup	c	7
366	75	2 teaspoons soy sauce	2.0	teaspoons	t	9
367	75	4 tablespoons Nama Shoyu (soy sauce) or Bragg liquid Aminos	4.0	tablespoons	T	2
367	23	4 garlic cloves, minced	4.0	cloves	cloves	8
368	88	1 bunch basil leaves, 2 c. leaves	1.0	bunch	bunch	0
368	95	4 green onions	4.0	\N	\N	4
368	60	3 hot red or green chilies	3.0	\N	\N	6
368	53	8 ounces shrimp, cooked, peeled, and deveined, 51 – 60 per pound	8.0	ounces	oz	7
368	75	2 teaspoons soy sauce	2.0	teaspoons	t	8
368	116	1 teaspoon sugar	1.0	teaspoon	t	9
369	74	A handful of cashew nuts	1.0	handful	handful	0
369	79	1 tablespoon chili paste	1.0	tablespoon	T	2
369	75	1/2 tablespoon Dark soy sauce	0.5	tablespoon	T	3
369	78	Dried chilies	3.0	servings	servings	4
369	23	2 cloves garlic, minced	2.0	cloves	cloves	5
369	95	1 stalk green onion	1.0	stalk	stalk	6
369	4	1 onion (cut into wedges)	1.0	\N	\N	7
369	75	1 tablespoon soy sauce	1.0	tablespoon	T	8
370	51	1/4 cup Brown Sugar	0.25	cup	c	0
370	141	1 Lime	1.0	\N	\N	5
371	51	2 teaspoons brown sugar	2.0	teaspoons	t	1
371	2	1 c. julienned carrots	1.0	c	c	2
371	79	2 teaspoons hot chili paste (depending on how spicy you prefer your dish- start with 1 tsp and taste test it)	2.0	teaspoons	t	3
371	40	1 teaspoon corn starch dissolved in 1 tablespoon cold water	1.0	teaspoon	t	4
371	28	2 tablespoons Sesame oil	2.0	tablespoons	T	8
371	75	2 tablespoons soy sauce	2.0	tablespoons	T	9
372	11	1/2 c. canola oil, divided	0.5	c	c	0
372	2	1 c. julienned carrots	1.0	c	c	1
372	93	1/2 c. cilantro leaves	0.5	c	c	3
372	23	1 garlic clove, finely minced	1.0	clove	clove	5
372	51	2 t. light brown sugar	2.0	t	t	7
372	142	3 T. fresh lime juice	3.0	T	T	8
372	95	1 c. thinly sliced scallion	1.0	c	c	11
372	31	6 oz. snow peas, trimmed, sliced on the diagonal about 1/2-inch thick	6.0	oz	oz	12
372	32	1 t. sriracha	1.0	t	t	14
372	83	1 yellow bell pepper, thinly sliced	1.0	\N	\N	17
373	88	20 grams pack basil, leaves picked	20.0	grams	g	1
373	51	1 teaspoon brown sugar	1.0	teaspoon	t	2
373	93	20 grams stalks from pack coriander	20.0	grams	g	5
373	23	2 garlic cloves	2.0	cloves	cloves	7
373	94	1 teaspoon ground coriander	1.0	teaspoon	t	9
373	142	3 juice limes	3.0	\N	\N	13
373	56	140 grams mushrooms, halved	140.0	grams	g	14
373	59	1 teaspoon freshly ground pepper	1.0	teaspoon	t	15
373	77	1/2 red pepper, deseeded and roughly chopped	0.5	\N	\N	16
373	75	5 tablespoons soy sauce	5.0	tablespoons	T	18
373	72	2 tablespoons vegetable oil	2.0	tablespoons	T	21
374	88	1/2 cup Thai basil or you can use regular basil	0.5	cup	c	0
374	94	1/2 cup coriander (cilantro) leaves	0.5	cup	c	3
374	23	1 clove garlic	1.0	clove	clove	5
374	142	2 tablespoons fresh lime juice	2.0	tablespoons	T	6
374	77	red bell pepper, thinly sliced	4.0	servings	servings	8
374	53	8 large cooked shrimp, slice in half lengthways	8.0	\N	\N	10
374	116	1 tablespoon sugar	1.0	tablespoon	T	12
374	7	1/4 cup water	0.25	cup	c	13
375	24	1 1/4 cups shredded cabbage	1.25	cups	c	0
375	2	1 1/4 cups shredded carrots	1.25	cups	c	1
375	79	1 teaspoon chili paste	1.0	teaspoon	t	2
375	5	1/2 cup Creamy Peanut Butter	0.5	cup	c	4
375	88	15 fresh basil leaves, chopped	15.0	\N	\N	5
375	93	2 tablespoons fresh cilantro, chopped	2.0	tablespoons	T	6
375	23	1 Tbs.minced garlic	1.0	Tb	Tb	9
375	142	1 tablespoon fresh lime juice	1.0	tablespoon	T	10
375	95	2 scallions	2.0	\N	\N	13
375	28	1 teaspoon toasted (dark) sesame seed oil	1.0	teaspoon	t	14
375	75	1 1/2 tablespoons gluten free soy sauce (Tamari)	1.5	tablespoons	T	15
375	116	1/2 tablespoon sugar	0.5	tablespoon	T	17
375	7	1/2 cup warm water	0.5	cup	c	18
376	2	2 carrots, sliced thin on the bias	2.0	\N	\N	0
376	62	1/4 teaspoon crushed red pepper	0.25	teaspoon	t	3
376	54	2 daikon radishes, sliced thin on the bias	2.0	\N	\N	5
376	23	1 clove garlic, minced	1.0	clove	clove	7
376	137	1 sliced jalapeno for extra heat	1.0	\N	\N	8
376	142	1/2 cup lime juice	0.5	cup	c	9
376	6	1/4 teaspoon salt	0.25	teaspoon	t	12
376	116	1/4 cup sugar	0.25	cup	c	14
376	7	1/4 cup hot tap water	0.25	cup	c	15
377	58	1/2 cup If non-vegetarian: add cooked baby shrimp	0.5	cup	c	0
377	52	2 cups approx. bean sprouts	2.0	cups	c	1
377	24	1/2 cup shredded or finely chopped cabbage	0.5	cup	c	2
377	2	1 cup shredded carrots	1.0	cup	c	3
377	124	1 teaspoon 1 red chili, minced, OR 1/2 to cayenne pepper (omit if you prefer very mild	1.0	teaspoon	t	4
377	92	1/2 cup chives	0.5	cup	c	5
377	88	1/2 cup fresh basil, roughly chopped	0.5	cup	c	7
377	93	1/2 cup fresh coriander, roughly chopped	0.5	cup	c	8
377	23	3 cloves garlic, minced	3.0	cloves	cloves	10
377	95	2 green onions, sliced into matchstick pieces	2.0	\N	\N	11
377	142	2 tablespoons lime juice	2.0	tablespoons	T	12
377	55	6 shiitake mushrooms, cut into matchstick pieces	6.0	\N	\N	14
377	75	2 tablespoons regular soy sauce	2.0	tablespoons	T	15
377	116	1/4 teaspoon sugar	0.25	teaspoon	t	16
378	2	2 carrots, julienned	2.0	\N	\N	0
378	23	1 1/2 garlic clove	1.5	cloves	cloves	1
378	30	3/4 cup hoisin sauce	0.75	cup	c	3
378	30	Garlic Lime Hoisin Sauce	10.0	servings	servings	4
378	142	2 tablespoons lime	2.0	tablespoons	T	7
378	77	1 red bell pepper	1.0	\N	\N	8
378	88	12 leaves of Thai basil	12.0	leaves	leaves	11
378	83	1 yellow bell pepper	1.0	\N	\N	12
378	32	1 teaspoon Sriracha (or to taste)	1.0	teaspoon	t	13
379	93	cilantro sprigs	1.0	sprigs	sprigs	0
379	23	1 tablespoon minced garlic	1.0	tablespoon	T	3
379	59	2 tablespoons fresh ground black pepper	2.0	tablespoons	T	4
379	137	jalapeno	6.0	servings	servings	5
379	4	2 tablespoons of finely chopped onion	2.0	tablespoons	T	8
379	28	1 teaspoon of sesame seed oil	1.0	teaspoon	t	11
379	116	2 1/2 tablespoons sugar	2.5	tablespoons	T	13
379	72	1/4 cup vegetable oil	0.25	cup	c	14
380	88	2 tablespoons shredded fresh basil leaves	2.0	tablespoons	T	1
380	51	1 teaspoon brown sugar	1.0	teaspoon	t	2
380	52	1 cup fresh bean sprouts	1.0	cup	c	5
380	23	2 garlic cloves, halved	2.0	cloves	cloves	7
380	141	4 lime wedges	4.0	wedges	wedges	9
380	28	1 teaspoon sesame oil	1.0	teaspoon	t	14
380	31	1 cup snow peas, trimmed	1.0	cup	c	16
380	122	1 inch small fresh Thai chile, thinly sliced into rings (no thai chilies town anywhere!	1.0	inch	inch	18
380	7	1 cup water	1.0	cup	c	19
380	4	1 1/2 cups thinly sliced yellow onion	1.5	cups	c	20
381	88	1 bunch Thai basil or regular basil	1.0	bunch	bunch	0
381	60	2 tablespoons hot chili peppers (optional)	2.0	tablespoons	T	3
381	134	1 teaspoon Hot chili sauce	1.0	teaspoon	t	4
381	93	1 tablespoon Cilantro, chopped	1.0	tablespoon	T	5
381	12	1 Cinnamon stick	1.0	\N	\N	6
381	54	4 mediums daikon cut in 2-inch chunks	4.0	\N	\N	7
381	52	2 cups Fresh bean sprouts	2.0	cups	c	9
381	141	2 Limes cut in wedges	2.0	\N	\N	12
381	4	2 large Onions, unpeeled, halved, and studded with 8 cloves	2.0	\N	\N	13
381	4	2 mediums Onions, thinly sliced	2.0	\N	\N	14
381	95	2 Scallions, thinly sliced	2.0	\N	\N	18
381	116	3 tablespoons sugar	3.0	tablespoons	T	21
382	30	2 teaspoons hoison sauce	2.0	teaspoons	t	0
382	93	Cilantro for garnish	1.0	serving	serving	1
382	23	2 cloves garlic, minced	2.0	cloves	cloves	3
382	73	1 teaspoon olive oil	1.0	teaspoon	t	6
382	5	1/4 cup organic peanut butter	0.25	cup	c	7
382	77	1 red pepper, cut into thin long strips	1.0	\N	\N	8
382	53	1 pound fresh shrimp	1.0	pound	lb	11
382	7	1/4 cup water (more if needed)	0.25	cup	c	12
383	52	some bean sprouts	4.0	servings	servings	0
383	2	carrots (finely julienned)	4.0	servings	servings	1
383	122	2 red birdeye chilies, sliced	2.0	\N	\N	3
383	23	2 cloves garlic, minced	2.0	cloves	cloves	5
383	142	2 tablespoons lime juice	2.0	tablespoons	T	6
383	88	some Thai basil	4.0	servings	servings	10
383	53	12 tiger prawns (peeled, deveined)	12.0	\N	\N	11
384	8	1 tbsp double action baking powder	1.0	tbsp	T	0
384	15	400g Pau flour, sifted (Note*)	400.0	g	g	3
384	6	1/2 teaspoon salt	0.5	teaspoon	t	4
384	116	1 tablespoon sugar	1.0	tablespoon	T	6
384	7	250g water	250.0	g	g	7
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
104	104	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A
105	105	5	0.07	0.028	0	296	0.93	0	0.55	0.24	238	0.4	3	0.06
106	106	300	20	10	0	16800	20	0	0	0	200	0	0	0
107	107	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A
108	108	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A	#N/A
109	109	30	1.1	0	0	1.1	5.6	3.3	3.3	1.1	800	66	11	0.4
110	110	30	1.1	0	0	1.1	5.6	3.3	3.3	1.1	800	66	11	0.4
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
\.


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 176
-- Name: Nutritional Content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Nutritional Content_id_seq"', 169, FALSE);

--
-- TOC entry 2048 (class 0 OID 16682)
-- Dependencies: 175
-- Data for Name: Recipe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Recipe" (id, title, image_uri, instructions, cuisine, ready_in_minutes, servings, vegetarian, vegan, gluten_free, dairy_free) FROM STDIN;
1  African Bean Soup  https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg  <ol><li>Saute onions IN LARGE pot UNTIL soft.ADD ALL ingredients EXCEPT FOR peanut butter AND simmer FOR 1 1/2 hours.</li><li>Stir a spoonful OF peanut butter INTO EACH serving.</li></ol>  african  45  4  t  t  t  t
2  Ethiopian Lentil Curry  https://spoonacular.com/recipeImages/Ethiopian-Lentil-Curry-642468.jpg  <ol><li> IN a LARGE pot heat oil OVER medium heat.ADD onions AND saut UNTIL translucent.ADD minced garlic AND CONTINUE TO saut FOR another MINUTE.</li><li>Combine cauliflower, peas AND lentils IN the pot, sprinkle WITH amchar massala AND massala molida AND saut FOR 5 minutes.</li><li>Pour crushed tomatoes AND tomato paste INTO the pot AND stir TO combine.ADD about two cups OF water AND bring curry TO a boil.</li><li>Reduce heat, cover, AND simmer ON low UNTIL lentils are tender;
about an HOUR.</li><li>Mix IN PLAIN yogurt AND serve immediately.</li></ol>  african  75  6  t  f  t  f
3  North African Chickpea Soup  https://spoonacular.com/recipeImages/North-African-Chickpea-Soup-653275.jpg  <ol><li> IN a LARGE soup pot ADD the oil, onions AND celery.Cook OVER medium low heat UNTIL translucent.ADD the garlic AND saute UNTIL fragrant.ADD the tomato paste AND harissa.Cook a MINUTE THEN ADD the water OR stock slowly WHILE stirring TO combine the flavor paste IN the pot WITH the liquids.Throw IN the chickpeas AND bring TO a boil. AS soon AS it reaches a boil, reduce heat TO a simmer.</li><li> ADD the pasta AND cook according TO the package directions.My suggestion IS that IF you are USING fresh pasta, give it a rinse under tap water TO remove the starch BEFORE adding it TO the soup.It might make the broth cloudy.IF USING rice noodles ADD them RIGHT BEFORE serving TO prevent overcooked mushy noodles.TO cook rice noodles place them IN a shallow dish AND cover WITH hot water FOR 10-15 minutes TO soften.</li><li>Just BEFORE serving taste FOR seasoning, adjust TO your taste.Adding too much salt earlier ON could make things too salty because SOME OF the ingredients can bring a lot OF salt TO the pot.THEN ADD the spinach, it will ONLY take a MINUTE TO shrink INTO nearly NOTHING, but it IS sure a powerhouse vegetable that amps up the nutrition IN this meal quickly AND WITHOUT fuss.A squeeze OF fresh lemon juice AFTER it has been taken OFF the heat will ADD a nice bright flavor TO perk up those dreary dark days OF winter.Enjoy WITH SOME crusty bread.A meal you can feel good about, filling yet light.</li></ol>  african  45  4  t  t  f  t
4  African Chicken Peanut Stew  https://spoonacular.com/recipeImages/african-chicken-peanut-stew-716268.jpg  Season AND Boil the Chicken FOR 10 minutes WITH salt, pepper, seasoning, a handful OF onions.Once the chicken IS ready, IN the same stock, Boil the chopped sweet potatoes till its almost cooked.Save the stock IN a separate Bowl AND the chicken AND potatoes IN a separate Bowl AS well.In a pot, heat up one cooking spoon OF oil AND fry the chicken till it Browns.Take it OUT AND heat up the other 1.5 cooking spoons OF oil AND fry the onions, tomatoes BOTH chopped AND Blended, ginger AND garlic.Add your seasoning, curry, thyme, parsley, salt AND pepper TO the pot.Pour IN your stock, chicken AND potatoes TO cook further.Stir IN your peanut Butter AND allow TO cook FOR 10 minutes ON low heat.If your sauce gets too thick, ADD a little water TO it.Serve WITH white rice OR more sweet potatoes.You could ALSO garnish the dish WITH Bell peppers.african  45  1  f  f  t  t
5  Party Jollof Rice  https://spoonacular.com/recipeImages/how- TO -make-party-jollof-rice-716298.jpg  Wash rice BY rubbing the rice BETWEEN your palms IN a bowl OF water AND draining the water till clear.Blend tomatoes, pepper AND garlic AND bring TO boil till the excess water dries up.Chop Onions.Heat up vegetable oil AND pour IN chopped onions AND fry.Pour IN the can OF tomato puree AND fry.Pour IN blended tomato AND pepper mix INTO the pot AND stir IN.Pour IN salt, dry pepper, curry, thyme, bay leaves AND maggi cubes.Allow it TO simmer ON low heat FOR 3 minutes.Reduce the heat TO the lowest LEVEL AND pour IN the washed rice.Pour IN the water AND stir AND leave ON low heat FOR 20 minutes OR till the rice IS soft.Tip:TO GET the party rice flavor, increase the heat ON the rice AND burn the bottom OF the pot WITH the pot covered AND stir the rice AFTER 3 minutes OF burning.Stir the rice AND serve WITH ANY protein OF your choice.african  45  3  t  t  t  t
6  Pineapple Jollof Rice  https://spoonacular.com/recipeImages/pineapple-jollof-rice-716374.jpg  Heat up your oil, stir fry your pineapples AND chopped vegetables FOR 30 seconds AND take OUT OF the oil.In the same oil, toss IN your chopped onions, garlic AND ginger AND fry about a MINUTE OR two ON medium heat.Stir IN your tomato paste AND fry FOR 2-3 minutes ON medium heat.Pour IN your blended tomato, pepper mix AND stir.Season WITH seasoning cubes, curry, thyme AND ANY other seasoning OF your choice.Stir IN your rice AND reduce the heat TO the lowest AND allow TO steam.Pour IN your stock juice so it would cook the rice FOR the NEXT 20-25 minutes ON low heat.Constantly CHECK TO make sure the rice IS soft AND WHEN it IS, increase the heat AND stir.Toss IN the already sautéed pineapple AND chopped vegetables AND stir IN.Serve WITH ANY protein OF your choice.african  45  2  t  t  t  t
7  Banana & Cream Cheese Stuffed French TOAST https://spoonacular.com/recipeImages/Banana---Cream-Cheese-Stuffed-French-Toast-633971.jpg	<ol><li>In a small bowl combine the softened cream cheese, honey, cinnamon, nutmeg and lemon juice, set aside while preparing the batter.</li><li>Whisk together all of the batter ingredients until thoroughly mixed. (This is a breeze if you use a blender.) Pour the batter into a wide, shallow dish (like a pie plate).</li><li>Spread the filling mixture equally over 1 side of each slice of bread, divide the sliced bananas between 4 slices of the bread, top with the remaining 4 slices, press lightly.</li><li>Melt 2 t. butter and 2 t. oil in a 12 inch nonstick skillet over medium heat until the butter foams and then subsides. Working with one sandwich at a time dip both sides in the batter and let the excess drip away, add to the hot pan, repeat with a second sandwich. Cook until golden brown on the first side, around 3-5 minutes, flip and repeat on the second side. Repeat this process with the remaining, oil, butter and sandwiches. To serve, cut into triangles and serve with maple syrup.</li></ol>	american	45	4	t	f	f	f
8  Banana Chocolate Chip Cake WITH Peanut Butter Frosting  https://spoonacular.com/recipeImages/Banana-Chocolate-Chip-Cake- WITH -Peanut-Butter-Frosting---gluten-free--dairy-free--soy-free-634040.jpg	<ol><li>Preheat Oven Temperature to 350 degrees F</li><li>For the Cake:</li><li>Line the bottom of the round cake pans with parchment paper (I use precut ones sold at baking stores), grease cake pans, also under parchment paper. Set aside.</li><li>In a medium bowl, whisk flours, baking soda, and salt. Set aside.</li><li>Using an electric mixer or a stand mixer with a paddle attachment on medium high speed, beat sugar, Earth balance, and brown sugar until light and fluffy, about 3 minutes.</li><li>Add eggs one at a time, beating to blend after each egg, then add vanilla.</li><li>Add dry ingredients.</li><li>Mix on low speed, just to blend.</li><li>Add mashed bananas and sour cream; mix until just blended.</li><li>Fold in chocolate chips.</li><li>Divide the batter evenly among the two cake pans. Smooth tops.</li><li>Bake cakes for 35-45 minutes, until toothpick inserted in the center comes out clean.</li><li>Transfer to wire racks.</li><li>Let it cool in the pans for 15-30 minutes.</li><li>Invert cakes onto the wire racks; peel off parchment paper and let it cool completely, about an hour, before frosting.</li><li>For the Frosting:</li><li>Using an electric mixer, or a stand mixer with a paddle attachment, beat peanut butter, powdered sugar, Earth balance, and vanilla extract until light and fluffy, about 4 minutes.</li><li>Place 1 cake on a platter.</li><li>Spread 1 1/4 cups of frosting for the inner layer.</li><li>Place the other cake on top.</li><li>Frost the top and sides with remaining frosting.</li><li>Pipe along the bottom edge with a star tip.</li><li>Chill frosted cake for 2-3 hours to set.</li><li>Garnish with chocolate chips.</li><li>Serve chilled or room temperature. Chilled will result in a firm peanut butter frosting.</li><li>Note: For mess free decorating, put two halved sheets of parchment paper (cut apart) next to each other on the cake platter before putting the cake on it.</li><li>Slowly pull out from opposite ends of the cake when done piping.</li></ol>	american	45	8	f	f	t	f
9  Barbecue Pizza  https://spoonacular.com/recipeImages/Barbecue-Pizza-634274.jpg  <ol><li>Preheat oven TO 400 degrees.Place pizza crust ON a baking sheet.Evenly spread pizza sauce ON crust.Top WITH cheese.IN a separate bowl mix barbecue meat AND sauce.Spread barbecue mixture ON toip OF cheese.Top WITH onion rings, AS desired.Bake IN oven FOR 10-12 minutes UNTIL cheese bubbles.</li></ol>  american  45  1  f  f  f  f
10  BBQ Chicken Pizza  https://spoonacular.com/recipeImages/Bbq-Chicken-Pizza-634485.jpg  <ol><li>Dissolve sugar IN water;
ADD yeast AND oil.</li><li> IN a separate bowl, combine flours.</li><li>Allow TO sit UNTIL the yeast foams slightly (about 3 minutes).</li><li>Combine 2  cups OF the flour AND salt IN a food processor.Pulse once OR twice.Pour the yeast mixture.</li><li>Process the mixture, gradually adding enough OF the remaining flour mixture so that the dough IS NO longer sticky.Remove FROM the processor;
CONTINUE kneading UNTIL the dough IS smooth AND elastic (another 1015 minutes BY hand).</li><li>Shape dough INTO a ball AND put IN an LARGE oiled bowl, turning the dough TO coat it WITH the oil.</li><li>Allow TO rise UNTIL doubled IN size (45 minutes TO 1 hours).</li><li>Punch down the dough AND divide INTO 2 pieces.This will make two 12 inch pizzas.</li><li>Shape EACH portion INTO a 12" circle either by hand or with a rolling pin, stretching out as necessary to achieve a thin dough. For a lighter crust, let the dough sit for a half hour after shaping before constructing pizza and baking.</li><li>Spread BBQ sauce over crust and top with chicken, cheese and desired toppings. (I used caramelized onions, roasted red peppers and chopped parsley)</li><li>Allow to rest in a warm location for 15 minutes.</li><li>Bake in a 475 degree oven until crust is golden, about 20 minutes.</li></ol>	american	45	6	f	f	f	f
11  BBQ Pork Steak  https://spoonacular.com/recipeImages/Bbq-Pork-Steak-634509.jpg  <ol><li>Marinate pork steak FOR 24 hours IN meat marinate mix AND Italian dressing.Remove FROM marinate AND brown ON grill FOR about 20 minutes.AFTER preparing barbeque sauce, use liberally ON grilling pork steak.</li><li>Sauce preparation:Mix sauce IN small saucepan AND cook TO blend.ADD corn syrup TO taste.</li></ol>  american  45  2  f  f  t  t
12  Beer Braised Brisket WITH Ding Dang Good Sauce  https://spoonacular.com/recipeImages/Beer-Braised-Brisket- WITH -Ding-Dang-Good-Sauce-634751.jpg  <ol><li> IN a food processor OR blender, finely chop garlic.ADD brown sugar, honey, mustard, ancho chili IN adobo, mustard, oil, black pepper, cumin, paprika, cayenne AND 2 tbs salt AND process UNTIL smooth.Rub ALL OVER the brisket making sure TO GET INTO the nooks AND crannies.Place brisket IN a gallon size freezer bag OR IF unable TO fit INTO bag  wrap well WITH plastic wrap AND put IN the refrigerator x 1-2 days.</li><li>Allow brisket TO come TO room TEMP ( about an HOUR ) BEFORE preparing.Preheat oven TO 325. Separate AND scatter onions IN a LARGE baking dish OR roasting pan.SET brisket (fat side up) ON top OF the onions.ADD beer TO pan AND ANY marinade the clings TO the plastic wrap.Cover AND seal WITH foil tightly.Braise IN the oven UNTIL the meat IS fall apart tender  about 5 hours.BEGIN TO CHECK AFTER 4 hours.Meat should literally be falling apart WHEN you stick it WITH a fork.WHEN done, SET oven TO broil AND broil FOR 5-10 minutes UNTIL top develops a crispy crust.</li><li>Allow brisket TO cool FOR AT least 10 minutes, remove FROM the pan AND shred OR SLICE.Remove the onions WITH a slotted spoon AND mix INTO the brisket.Moisten WITH pan drippings AND season WITH salt IF needed.</li><li> FOR the Sauce</li><li> IN a medium sauce pan OVER medium heat, ADD the pan drippings OR olive oil AND saut the onions UNTIL soft  5-7 minutes.ADD the garlic AND cook one MINUTE longer, .ADD the beer, bring TO a boil AND cook UNTIL reduced BY half  about 10 minutes OR so.</li><li> ADD IN the remaining ingredients AND heat through.</li><li>Place sauce IN a food processor OR blender AND puree UNTIL smooth.Can use immediately OR can be refrigerated UNTIL ready TO use.</li></ol>  american  45  8  f  f  t  t
13  Carolina Caviar - Black Bean Salsa  https://spoonacular.com/recipeImages/Carolina-Caviar---Black-Bean-Salsa-637157.jpg	<ol><li>Add all ingredients together in a large bowl; tasting and adjusting as you go!</li><li>Chill in the refrigerator overnight.</li><li>Adjust seasoning to preference levels after the salsa sets overnight and the flavors blend/marry.</li><li>Serve with tortilla chips.</li></ol>	american	45	4	t	t	t	t
14  Chile Underground''s Texas Caviar  https://spoonacular.com/recipeImages/Chile-Undergrounds-Texas-Caviar-638533.jpg  <ol><li>Heat the oil IN a LARGE skillet OVER medium-high heat</li><li> ADD onion AND cook FOR just a MINUTE OR two WITH stirring</li><li> ADD bell pepper AND stir FOR another MINUTE </li><li> ADD minced chilies AND tomatoes AND stir FOR ONLY a couple OF minutes, TO slightly soften the tomatoes</li><li> ADD the garlic AND stir FOR 30 seconds OR so</li><li>Transfer skillet contents TO a LARGE mixing bowl</li><li>Combine IN the peas, beans AND corn</li><li>Stir IN the sliced scallions;
SET aside</li><li> IN a small mixing bowl, combine remaining ingredients AND whisk UNTIL smooth</li><li>Pour sauce OVER the Caviar</li><li>Take most OF the cilantro leaves AND mince them</li><li> ADD minced cilantro TO the Caviar</li><li>Refrigerate FOR AT least 2 hours.</li><li>Garnish WITH remaining cilantro leaves</li><li>Serve WITH hearty corn chips ( NO wimpy chips allowed!)</li></ol>  american  180  8  t  t  t  t
15  Chili Pie WITH Green Chile AND Cheddar Cornbread Crust  https://spoonacular.com/recipeImages/Chili-Pie- WITH -Green-Chile- AND -Cheddar-Cornbread-Crust-638568.jpg  <ol><li> IN a LARGE skillet saute onion IN oil UNTIL soft AND translucent, seasoning WITH salt AND pepper.ADD garlic AND saute UNTIL fragrant.Remove 2/3 OF the mixture FROM pan AND SET aside.ADD green chilies WITH their juices AND saute FOR 2-3 minutes.Remove AND SET aside IN a separate bowl.</li><li> IN the same skillet brown ground beef, crumbling it AS it cooks.WHEN cooked through carefully drain grease.ADD the onion mixture, Chile powder, Worcestershire, oregano, paprika, cinnamon, nutmeg, red pepper AND water.Mix thoroughly AND CONTINUE cooking OVER medium-low heat AS you ADD the tomatoes WITH juices, the beans AND corn.Mix well AND cook FOR 3-4 minutes.</li><li>Preheat oven TO 400 degrees AND grease a 9x13 inch casserole dish.Pour the meat mixture IN AND spread evenly OVER bottom.Sprinkle two cups OF the cheese OVER top.</li><li> IN a LARGE bowl combine the flour, cornmeal, baking powder AND salt.</li><li> IN a separate medium bowl whisk the eggs, milk, butter AND sour cream.ADD this mixture TO the dry mix AND stir together.</li><li> ADD the onion/green chile mixture AND the remaining cup OF cheese.Stir IN.Pour OVER top OF the meat mixture.Spread evenly.Sprinkle Chile powder OVER top.</li><li>Bake 25-30 minutes OR UNTIL a toothpick comes clean FROM center OF cornbread.Let SET FOR 10 minutes BEFORE serving.</li></ol>  american  45  8  f  f  f  f
16  Coffee-Infused BBQ Baby Back Ribs  https://spoonacular.com/recipeImages/Coffee-Infused-Bbq-Baby-Back-Ribs-639893.jpg  <ol><li>Preheat the oven TO 350 degrees.Mix the FIRST seven ingredients IN a small bowl.</li><li>Cut EACH rack IN several pieces AND rub the spices OVER ALL the rib sections.You can leave the ribs whole IF you LIKE the way they look better--I just think they are easier to handle on the grill in smaller pieces! Pour 4 cups of water and 1 tsp. of liquid smoke in a roasting pan.</li><li>Place the ribs in the pan, top up. Tightly cover the pan with foil and bake for 2 hours. Remove from the oven and rest until ready to grill. Meanwhile, add 1 Tb. oil to a sauce pan over medium heat. Add the garlic and saut for 1-2 minutes. Then add the rest of the ingredients for the BBQ sauce to the sauce pan. Simmer for at least 30 minutes, stirring occasionally.</li><li>Heat a grill over medium-low heat. Brush the ribs completely with BBQ sauce. Place them on the grill and cook for 20 minutes, turning and brushing every 5 minutes until the desired bark has developed.</li><li>It''s fun to make your own BBQ sauce. But in a pinch, buy a bottled variety you like and simmer for a few minutes with the coffee granules!</li></ol>	american	45	6	f	f	t	t
17  Dulce De Leche Brownies  https://spoonacular.com/recipeImages/Dulce-De-Leche-Brownies-641726.jpg  <ol><li>Preheat the oven TO 350 degrees.</li><li>Grease a 13x9 baking dish.</li><li> IN a saucepan melt butter AND 1 cup semi-sweet chocolate, stirring constantly OVER very low heat UNTIL the chocolate IS melted.Stir IN eggs one AT a TIME, THEN stir IN the sugar, vanilla, espresso powder, baking soda, AND flour.</li><li>Stir IN remaining chocolate chips.</li><li>Pour the batter INTO baking dish.</li><li>Use a knife OR spatula TO swirl the Dulce de Leche creating a marbled effect.</li><li>Bake FOR 35 TO 45 minutes.The brownies center will be slightly firm WHEN they are done.Remove FROM the oven AND allow cool completely.</li></ol>  american  45  24  f  f  f  f
18  Fresh corn, roasted tomato & pickled garlic pizza WITH cornmeal crust  https://spoonacular.com/recipeImages/fresh-corn--roasted-tomato---pickled-garlic-pizza-with-cornmeal-crust-643471.jpg	<ol><li>roasted tomatoes recipe</li><li>preheat oven to 275 degrees.</li><li>line a rimmed baking sheet with parchment paper.</li><li>place tomatoes, cut side up, on top of paper.</li><li>drizzle honey over tomatoes.</li><li>sprinkle garlic and a pinch each salt and pepper over honey.  drizzle olive oil over tomatoes (2 passes of bottle).</li><li>place in preheated oven and roast for 3 hours.</li><li>remove from oven, scrape tomatoes and all juices into small bowl.</li><li>drizzle additional olive oil over tomatoes.</li><li>cover with saran wrap. store in refrigerator for up to 1 week.</li><li>cornmeal crust recipe</li><li>add water to bowl of upright mixer and sprinkle yeast over top.</li><li>using the paddle attachment, mix until yeast has dissolved.</li><li>add salt, olive oil and honey and mix to combine.</li><li>add  flour and process just until incorporated.</li><li>add the cornmeal and process until incorporated.</li><li>process an additional minute until the dough has formed into a ball. do not over mix.</li><li>remove dough from bowl, form into 4 smooth balls of equal size and place in an oiled bowl.</li><li>turn balls a few times to ensure they are totally covered in oil, cover bowl with saran wrap and place in a warm area. allow to rise until doubled in size  45 minutes to 1 hour.</li><li>remove from bowl and place on a lightly floured counter.</li><li>use a rolling pin to roll out dough into free form circles. each pizza crust should be about 1/2 inch thick.</li><li>place on pizza stone or baking sheet which has been lightly oiled with extra-virgin olive oil and sprinkled with coarse cornmeal. (the cornmeal adds a delicious flavor and helps ensure the pizza dough will not stick to pan.)</li><li>pizza assembly and recipe</li><li>preheat oven to 500 degrees.</li><li>drizzle pizza rounds with olive oil and lightly sprinkle with coarse grey salt.</li><li>sprinkle corn kernels, pickled garlic, marinated tomatoes and mozzarella over pizza....customize the amount of each topping to your liking.</li><li>drizzle oil over pizza, including the "naked" crust edges. use a pastry brush to cover the naked crust with oil.</li><li>place in preheated oven.</li><li>bake for 10-12 minutes or until crust is golden brown and cheese is bubbling.</li><li>remove from oven and sprinkle red pepper flakes and basil over top. slice and serve immediately</li></ol>	american	45	4	t	f	f	f
19  Salmon Caesar Salad  https://spoonacular.com/recipeImages/Healthy-Salmon-Caesar-Salad-646512.jpg  <ol><li>Directions:Heat up a skillet/frying pan AND sir the Salmon IN the coconut oil/olive oil (don''t forget TO ADD the salt AND paprika TO it) UNTIL very lightly browned ON EACH side (i LIKE my salmon slightly undercooked-its up TO you IF you want it more done).Top WITH freshly squeezed lemon juice AND let it sit IN the frying pan FOR about 1 MINUTE.IN a LARGE bowl, mix the romaine lettuce WITH the Caesar salad dressing AND dump it OUT INTO a LARGE plate, top OFF WITH Asiago/Parmesan cheese AND you can ALSO sprinkle the toasted almonds ON now.Place the Salmon (sliced) ON top.You can sprinkle it WITH SOME more fresh lemon juice:) AND black pepper!</li></ol>  american  45  2  f  f  t  f
20  Hummus & Ham Tortilla  https://spoonacular.com/recipeImages/Hummus---Ham-Tortilla-647623.jpg	<ol><li>Combine all of the ingredients for the hummus in the food processor. Process the chick peas until smooth.</li><li>Grill the sliced onion on a heated griddle and set aside for the tortilla.</li><li>Heat a griddle and place the tortilla on the heated griddle. Top the heated tortilla with the shredded cheese first, then the ham, followed by the hummus and finally the grilled onions.</li></ol>	american	45	1	f	f	t	f
21  Jade''s New York Style Pizza  https://spoonacular.com/recipeImages/Jades-New-York-Style-Pizza-648321.jpg  <ol><li> PREPARE your toppings TO taste.</li><li>The sauce:</li><li>Saute the onions AND garlic IN olive oil UNTIL soft.ADD the tomatoes, wine, herbs, salt AND sugar.Bring TO a boil, lower heat AND simmer FOR 2 hours, stirring occasionally, OR UNTIL sauce IS very thick.</li><li>The crust:</li><li>Mix together the flour AND salt.Dissolve the yeast IN the water AND ADD the pinch OF sugar.WHEN the yeast starts TO clump AND rise TO the surface OF the water, stir AND ADD TO the flour.Blend well.</li><li>Knead the dough WITH the kitchen aid dough hook FOR 5 minutes OR BY hand FOR an agonizing 10 minutes.Divide the dough IN half AND form two balls.Oil two bowls WITH the olive oil AND put the dough balls inside, turning TO coat WITH oil.Cover AND let rise FOR 1 1/2 HOUR.Punch the balls flat, THEN form INTO balls again AND wrap WITH saran wrap.Allow TO rise again FOR 1 HOUR.Spray Pam OR spread olive oil onto (2)  12 inch pizza pans.Flatten EACH dough ball onto the center OF the pan AND press the dough outward UNTIL it covers the pan.</li><li>Preheat oven TO 400 degrees.Cover the pizza crusts FIRST WITH sauce, THEN cheese, THEN ANY vegetable toppings, THEN cheese again AND lastly ANY meat toppings.Bake FOR 15 TO 20 minutes.</li></ol>  american  45  1  t  t  f  t
22  Kat''s Texas Caviar  https://spoonacular.com/recipeImages/Kats-Texas-Caviar-648791.jpg  <ol><li>Combine ALL IN a LARGE bowl AND mix lightly.</li><li>Cover AND chill FOR AT least 2 hours, stirring occasionally.</li></ol>  american  45  8  t  t  t  t
23  Mushroom-Swiss Hamburger Pie  https://spoonacular.com/recipeImages/Mushroom-Swiss-Hamburger-Pie-652728.jpg  <ol><li>Preheat oven TO 375F</li><li>Heat 1 teaspoon oil IN a LARGE skillet OVER medium heat AND saute onions UNTIL translucent AND just turning brown.OPEN the beer, take a sip AND pour the rest IN WITH the onions.Increase heat TO medium-high AND cook down UNTIL thick AND syrupy.</li><li>Pour onion mixture INTO a LARGE bowl, stir IN thyme, mustard, salt AND pepper AND let cool.ADD ground beef, breadcrumbs, parsley AND eggs AND mix thoroughly WITH clean hands.</li><li>Spray 9-inch pie plate WITH non stick AND spread hamburger mixture evenly across the bottom AND up the sides.Bake UNTIL meat reaches a temperature OF 160F.Remove FROM oven AND let stand 5 minutes.</li><li>Meanwhile, heat remaining oil OVER medium heat AND lightly saute mushrooms.</li><li>Drain ANY fat FROM meat AND top WITH mushrooms AND shredded cheese.Turn oven TO broil AND cook UNTIL cheese IS melted.</li><li>Makes 6 servings.</li></ol>  american  45  1  f  f  f  f
24 NO -Bake Bars  https://spoonacular.com/recipeImages/ NO -Bake-Bars-653177.jpg  <ol><li>Happy Mother''s DAY ! My husband made these bars LAST night.They are so good AND unfortunately we have been eating them ALL DAY.He got the recipe FROM Wingert FROM Panama, Iowa.</li><li> IN a LARGE bowl, combine the FIRST four ingredients;
SET aside.IN a saucepan, bring corn syrup AND sugar TO a boil, stirring frequently.Remove FROM the heat;
stir IN peanut butter AND vanilla.Pour OVER cereal mixture AND toss TO coat evenly.Spread INTO a greased 15X10X1 baking pan.Cool.</li><li>Cut INTO bars.</li><li>Yield:15 bars</li></ol>  american  45  1  f  f  t  f
25  Peanut Butter AND Chocolate Oatmeal  https://spoonacular.com/recipeImages/Peanut-Butter- AND -Chocolate-Oatmeal-655219.jpg  <ol><li>Microwave ALL ingredients IN a small bowl OR mug FOR 1 MINUTE, stir AND enjoy!  Serve WITH crushed peanuts OR almonds FOR SOME extra crunch!</li></ol>  american  45  1  t  f  t  f
26  Peanut Butter AND Jelly Smoothie  https://spoonacular.com/recipeImages/Peanut-Butter- AND -Jelly-Smoothie-655235.jpg  <ol><li>Place ingredients IN a high speed blender LIKE Blendtec FOR super smooth texture, blend ON high.</li><li> IF USING a regular blender put milk AND strawberries IN THEN blend.</li><li> NEXT, ADD banana pieces AND peanut butter, process UNTIL smooth.</li><li>Garnish WITH crushed peanuts AND serve.</li></ol>  american  45  2  f  f  t  t
27  Peanut Butter Banana Muffins  https://spoonacular.com/recipeImages/Peanut-Butter-Banana-Muffins-655241.jpg  <ol><li>A REAL kid pleaser AND a healthy snack, this moist muffin IS prefect FOR peanut butter fans.Preheat the oven TO 375F.IN a LARGE bowl, mix together the flour, brown sugar, baking powder, AND salt.IN a separate bowl, beat together the peanut butter, oil, eggs, milk AND bananas.Stir the wet ingredients INTO the dry ingredients just UNTIL moistened.</li><li>Spoon the batter INTO 12 well-greased muffin cups.Bake FOR 20 TO 25 minutes, OR UNTIL a toothpick inserted IN the centre OF a muffin comes OUT clean.</li><li>MAKES:12 MUFFINS</li></ol>  american  45  1  t  f  f  f
28  Peanut Butter Chocolate Chip Pie  https://spoonacular.com/recipeImages/Peanut-Butter-Chocolate-Chip-Pie-655270.jpg  <ol><li>Give the graham crackers a whirl IN a food processor UNTIL fine crumbs, </li><li> ADD the melted butter AND a pinch OF salt AND mix thoroughly, </li><li>Pour the graham cracker AND butter mixture INTO a 9-inch tart shell WITH a removable bottom.Press the mixture along the sides OF the tart pan AND along the bottom UNTIL evenly coated.Carefully place the tart pan IN the freezer WHILE you PREPARE the filling.</li><li> TO make the filling combine the peanut butter, softened cream cheese AND sweetened condensed milk IN the bowl OF an electric mixer fit WITH a paddle attachment.Blend the three ingredients UNTIL thoroughly incorporated, but dont OVER blend.</li><li> IN a separate bowl, whip 3/4 cup OF heavy cream TO soft peaks.</li><li> ADD the whipped cream TO the peanut butter mixture AND fold together UNTIL well incorporated.</li><li>Fold IN chocolate chips.</li><li>Remove the tart pan FROM the freezer AND spoon IN the peanut butter filling.Spread evenly.</li><li>Whip up the remaining cup OF heavy cream TO stiff peaks</li><li>Spread ON top OF the peanut butter filling.</li><li>Refrigerate FOR AT least two hours, OR overnight.</li><li>Top WITH mini chocolate chips, OR chocolate shavings</li><li>Enjoy!</li></ol>  american  45  1  f  f  t  f
29  Peppermint White Chocolate Fudge  https://spoonacular.com/recipeImages/Peppermint-White-Chocolate-Fudge-655687.jpg  <ol><li> LINE an 8x8 pan WITH plastic wrap OR wax paper</li><li> IN a LARGE bowl, melt white chocolate chips BY microwaving 30 seconds AT a TIME, stirring BETWEEN sessions.</li><li> ADD the container OF vanilla frosting</li><li>Stir well</li><li> ADD Peppermint flavoring AND stir well</li><li>Reheat FOR 10 seconds IF needed, so the mixture IS still soft enough TO pour</li><li>Pour mixture INTO lined pan</li><li>Place 6-8 drops OF red food coloring ON the top OF the warm fudge</li><li> WITH a toothpick OR knife, swirl the color INTO the top OF the fudge</li><li>Sprinkle crushed candies OVER the top OF the fudge</li><li>Cool IN fridge UNTIL hard</li><li>Cut AND enjoy!</li></ol>  american  45  8  f  f  t  f
30  Poppy Seed Cupcakes  https://spoonacular.com/recipeImages/Poppy-Seed-Cupcakes-656683.jpg  <ol><li>Preheat oven TO 350 degree F.LINE cupcake pan WITH liners.</li><li>Sift together flour, baking powder, AND salt two times INTO a bowl;
SET aside.Grate zest OF lemon INTO a small saucepan AND ADD milk AND poppy seeds.Heat OVER high heat UNTIL steaming;
let cool TO room temperature.ADD vanilla EXTRACT.</li><li> IN the bowl OF an electric mixer fitted WITH the paddle attachment, cream butter UNTIL soft.Gradually ADD sugar;
beat ON medium speed UNTIL very fluffy, about 5 MINUTE, scarping down sides OF bowl several times.ADD eggs one AT a TIME, beating well AFTER EACH addition;
CONTINUE beating ON medium-high speed UNTIL smooth, about 1 MINUTE.</li><li> ADD flour mixture IN three additions, alternating WITH milk mixture AND beginning AND ending WITH flour.Beat ON low speed UNTIL just combined.Divide batter evenly FOR the cupcakes, about 2/3 FULL EACH.Bake UNTIL tops are golden brown OR UNTIL a cake tester inserted IN center OF cakes comes OUT clean, 20 TO 25 minutes, rotating pans once IF needed.Let cupcakes cool completely ON wire racks.Cakes can be made a DAY ahead BEFORE serving IF desired.</li><li>Cut OUT a cone FROM EACH cupcake AND TRIM the ends OF the cones.Fill the hollowed cupcakes WITH lemon curd-whipped cream.REPLACE EACH top.Frost cupcake tops WITH more lemon curd-whipped cream AND sprinkle SOME poppy seeds.</li></ol>  american  45  1  f  f  f  f
31  Pulled Pork Sandwich WITH Mango BBQ sauce  https://spoonacular.com/recipeImages/Pulled-Pork-Sandwich- WITH -Mango-BBQ-sauce-657226.jpg  <ol><li>Directions</li><li>Rub:Combine the rub ingredients, IN a small bowl AND massage it INTO the pork shoulder UNTIL well coated.SET aside WHILE you make BBQ sauce.You could DO this a DAY ahead AND keep refrigerated UNTIL ready TO use.</li><li>BBQ sauce:IN a LARGE saucepan, warm the oil, OVER low heat, UNTIL hot AND shimmering.ADD the cumin AND fennel;
they should splutter upon contact - be careful! Once the spluttering subsides, ADD the onions, ginger AND serrano AND a little salt, TO taste.Saute UNTIL they soften but don''t let them GET ANY color.ADD the rest OF the sauce ingredients.Simmer about 5 minutes.Taste AND season.</li><li> ADD the pork shoulder TO the saucepan, coating it WITH the sauce.Cover, AND gently simmer UNTIL the pork falls apart easily, stirring AND turning often, about 3 hours.</li><li>Remove the pork FROM the saucepan AND shred it USING 2 forks.RETURN it TO the sauce AND stir TO coat WITH the sauce.Put a generous spoonful OF the pork inside a brioche bun, top WITH a few slices OF pickle AND serve.Aarti''s Note:PREPARE TO have your loved one swoon OVER you!</li></ol>  american  45  4  f  f  f  t
32  Spice-Rubbed Lemon Barbecue Salmon  https://spoonacular.com/recipeImages/Spice-Rubbed-Lemon-Barbecue-Salmon-660926.jpg  <ol><li>Place the salmon fillets ON a greased, foil-lined baking sheet.</li><li>Rub the top OF the salmon WITH the barbecue seasoning.Let sit FOR 10 minutes WHILE you preheat the broiler.</li><li>Place the baking sheet 4" - 6" FROM the heating ELEMENT AND broil FOR 6 - 8 minutes, UNTIL cooked through.</li><li>Remove FROM the broiler AND let sit 5 minutes.</li><li>Combine the sauce ingredients (barbecue sauce, hoisin sauce, honey AND zest OF 1/2 lemon) IN a small bowl.</li><li>Spoon the sauce INTO a small ziplock bag AND squeeze down TO the corner OF the bag.Cut OFF a very small portion OF the corner OF the bag AND squeeze the sauce generously OVER the salmon.</li><li>Serve WITH a lemon wedge FROM the other half OF the lemon.</li></ol>  american  45  2  f  f  t  t
33  Whole Wheat NO -Yeast Pizza WITH Roasted Garlic, Sweet Potatoes, AND Onions  https://spoonacular.com/recipeImages/Whole-Wheat- NO -Yeast-Pizza- WITH -Roasted-Garlic--Sweet-Potatoes--and-Onions-665294.jpg	<ol><li>Roasted Garlic Instructions:</li><li>Preheat oven to 400 degrees F.</li><li>Cut the top off the bulb of garlic, exposing the cloves.</li><li>Place the garlic on a sheet of foil large enough to wrap it up.</li><li>Drizzle olive oil over top of garlic bulb and sprinkle with salt.</li><li>Tightly wrap the garlic in the foil.</li><li>Place foil in the oven and cook for 45 minutes.</li><li>Remove and unwrap garlic. Turn upside down and squeeze the cloves out of the garlic skin</li><li>Whole Wheat Pizza Dough Instructions:</li><li>Place all ingredients (except 2 tbsp olive oil) in a food processor or a stand mixer with dough hook. If using a food processor, process until dough forms into a ball. Add extra water, 1 tbsp at a time if dough is too dry. If using a stand mixer, mix with dough hook until all of the flour is mixed together.</li><li>If you have time, place dough in plastic wrap and refrigerate for 20-30 minutes.</li><li>Lightly flour surface and roll dough out until it is 1/2 inch thick. I chose to use a large bowl and cut out circular pizzas. This required me to roll the dough out three times, making 2 larger pizzas and one smaller one. You could also opt to roll it out until it is a rectangle.</li><li>Place pizza on pizza stone or on greased cookie sheet. Set aside.</li><li>Brush pizza dough lightly with olive oil (no more than 2 tbsp total).</li><li>Pizza Topping Instructions:</li><li>Preheat oven to 400 degrees F.</li><li>Line a baking sheet with foil and spray with non-stick cooking spray.</li><li>Place cubed red onion and sweet potato on the sheet.</li><li>Drizzle with 1-2 tbsp olive oil, and sprinkle with thyme, rosemary, salt and pepper.</li><li>Roast for 25-30 minutes, mixing the vegetables around occasionally. (I roasted my garlic at the same time).</li><li>Remove and set aside.</li><li>Take your freshly roasted bulb of garlic and squeeze the garlic out into a mortar bowl (if you don''t have one, use a bowl). Crush the garlic with either a pestle or the bottom of a spoon until it is a paste.</li><li>Spread the roasted garlic paste over the pizza dough.</li><li>Sprinkle/crumble your cheese of choice over the pizza dough.</li><li>Place the vegetables on top of the cheese.</li><li>Cook pizza for approximately 20 minutes (plus or minus a few minutes depending on your oven), waiting for the crust to become golden brown.</li><li>Enjoy!</li></ol>	american	45	3	t	f	f	f
34  Popcorn Chicken  https://spoonacular.com/recipeImages/popcorn-chicken-716358.jpg IN a bowl, season the chopped chicken breast WITH one seasoning CUBE, ginger powder, black pepper, chili powder, AND garlic AND SET aside.Whisk your eggs AND SET aside.Season your breadcrumbs WITH the seasoning cubes AND divide INTO 2 equal portions AND SET aside.In a blender OR food processor, pour IN your chicken breast, flour, 1 portion OF breadcrumbs, AND egg AND blend till smooth.Scrape INTO a bowl AND mold INTO little balls USING the extra breadcrumbs TO properly coat it.The smaller the balls the better AS the chicken would cook through better.In a deep fryer OR a huge pot OF oil ON medium heat, allow TO heat but NOT be extra hot AND dunk your popcorn chicken TO fry till brown.Serve hot.american  45  2  f  f  f  t
35  Bangers AND Mash  https://spoonacular.com/recipeImages/bangers_and_mash-44789.jpg NONE british  134  1  f  f  t  t
36  Bridget Jones''s Shepherd''s Pie  https://spoonacular.com/recipeImages/Bridget-Joness-Shepherds-Pie-636096.jpg  <ol><li>Preheat the oven TO 180 C.</li><li> IN a LARGE frying pan, heat a little olive oil AND fry the chopped onion AND garlic.</li><li> ADD the mince, stirring, UNTIL browned ALL OVER.</li><li> WHILE the meat IS frying, break up ANY lumps WITH the back OF the spoon.</li><li> ADD the flour (this helps TO thicken the juices) AND stir.</li><li>Mix well AND ADD the thyme AND the rosemary AND stir.</li><li> ADD the chopped tomatoes AND pour the stock mixture.</li><li> ADD a pinch OF salt AND freshly ground black pepper AND let it simmer FOR about 5 minutes.</li><li> FOR the mash, boil the potatoes, THEN drain them IN a sieve AND place INTO a clean bowl.</li><li> ADD the milk, butter AND egg yolk, AND mash together.</li><li>Season WITH salt AND freshly ground black pepper.</li><li>Pour the meat INTO an ovenproof dish AND spread the mash ON top, smooth OVER AND mark WITH a spatula.</li><li>Put the dish INTO the oven AND cook UNTIL the surface IS bubbling AND golden-brown.</li></ol>  british  45  4  f  f  f  f
37  British Treacle Tart  https://spoonacular.com/recipeImages/British-Treacle-Tart-636136.jpg  <ol><li>Combine flour, salt AND confectioners sugar IN a LARGE bowl.USING tips OF fingers, rub butter INTO flour UNTIL it looks mostly LIKE wet sand.Make a well IN the middle, AND pour IN the egg.Gradually WORK the egg INTO the flour UNTIL a moist dough forms, USING the heel OF your hand TO distribute ANY remaining LARGE pieces OF butter.Shape INTO a 5-inch disk AND cover WITH plastic wrap.Refrigerate FOR 1 HOUR.This can be done IN a food processor.</li><li>Roll OUT dough INTO a 13-inch CIRCLE.Lay dough INTO an 11-inch tart pan WITH a removable bottom, AND press against the sides TO secure dough.Refrigerate FOR one HOUR.</li><li>Preheat oven TO 325 F.Dock the bottom OF the crust WITH a fork, lay a LARGE, crumpled piece OF parchment ON top, AND pour IN pie weights ( OR a pound OF dried beans).Bake FOR 25 minutes, UNTIL crust IS a light golden brown.SET aside.</li><li>Increase the temperature TO 350 F</li><li>Mix together the golden syrup AND molasses WITH the lemon juice.Beat the eggs IN a bowl AND ADD TO the treacle mixture.Finally stir IN the bread crumbs.</li><li>Pour the mixture INTO the PREPARED tart CASE.</li><li>Bake FOR 20  25 minutes UNTIL the crust AND filling are golden brown AND firm TO the touch.You may have TO cover the crust WITH aluminum foil TO keep it FROM getting too brown OR burning.</li><li>Serve warm WITH crme fraiche which balances really well WITH the sweetness OF the tart OR a good vanilla ice cream.</li></ol>  british  45  1  f  f  f  t
38  Caramel Almond Berry Trifle  https://spoonacular.com/recipeImages/Caramel-Almond-Berry-Trifle-636970.jpg  <ol><li>Mix LARGE BOX OF pudding AND milk (according TO directions)</li><li> ADD one cap FULL OF almond EXTRACT, mix well, AND SET aside TO SET.</li><li> AFTER pudding has SET, let''s START the layers.FIRST a thick layer OF pudding, a layer OF the pound cake, ADD berries, drizzle caramel sauce OVER berries, ADD Cool Whip layer, THEN repeat layers.</li><li>Top WITH additional berries AND caramel.</li></ol>  british  30  10  f  f  t  f
39  Cheesy Potato Corn Scones  https://spoonacular.com/recipeImages/Cheesy-Potato-Corn-Scones-637675.jpg  <ol><li>Lightly greased a baking sheet;
SET aside.IN a small saucepan, bring the water just TO a simmer;
remove FROM heat.Stir IN potato flakes UNTIL moistened.Stir IN butter UNTIL it''s incorporated TO potato flakes.</li><li> IN a LARGE bowl, combine flour, cornmeal, 3/4 cup OF the cheese, baking powder, salt, AND poppy seeds;
stir IN potato mixture AND milk.WITH floured hand, gently knead AND fold the dough FOR five TO six strokes, OR UNTIL the dough comes together IN one mass.Pat the dough lightly TO flatten it INTO a 9-inch CIRCLE ON PREPARED baking sheet.Cut dough INTO eight wedges USING a pizza cutter OR floured knife ( DO NOT separate).Sprinkle edges WITH remaining cheese.</li><li>Bake IN a preheated 400 degree F oven FOR about 25 minutes OR UNTIL lightly browned.Gently pull OR cut scones TO separate.Serve warm.</li></ol>  british  45  8  f  f  f  f
40  Chicken Shepherd''s Pie  https://spoonacular.com/recipeImages/Chicken-Shepherds-Pie-638329.jpg  <ol><li>Preheat the oven TO 425F.</li><li>Heat olive oil IN a Dutch oven ( OR a deep ovenproof dish) OVER high heat.ADD chicken AND break up WITH a wooden spoon;
season WITH salt, pepper, AND poultry seasoning.</li><li>Place potatoes IN a pot WITH water TO cover.Cover AND bring TO a boil, THEN salt the water AND cook potatoes FOR 15 minutes, OR UNTIL tender.</li><li> ADD onion, carrots, AND celery TO the Dutch oven AND cook FOR 5 minutes.</li><li> WHILE the vegetables are cooking, heat 2 tablespoons OF the butter IN a small pot OVER medium heat.ADD flour AND whisk FOR 1 MINUTE, THEN whisk IN the stock AND season WITH salt, pepper, AND Worcestershire.Cook FOR a few minutes, UNTIL thickened, THEN ADD TO the chicken mixture.</li><li>Stir IN the peas INTO the chicken mixture AND turn OFF the heat.</li><li>Drain the potatoes AND RETURN the pot TO the heat.ADD the remaining 2 tablespoons OF butter AND melt OVER medium heat.Season WITH salt AND pepper.Mash the potatoes AND adjust the seasoning.</li><li>Spoon the potatoes onto the meat, AND cover the potatoes WITH the cheese.Bake uncovered FOR 5-10 minutes UNTIL the top IS golden.</li></ol>  british  45  6  f  f  f  f
41  Classic scones  https://spoonacular.com/recipeImages/Classic-scones-639637.jpg  <ol><li> USING fingertips, rub butter INTO flour UNTIL mixture resembles fine breadcrumbs.</li><li>Make a well IN the centre OF the dry ingredients AND ADD milk, stirring WITH a metal spatula OR butter knife UNTIL mixture comes away FROM the sides OF the bowl.IF mixture IS dry, ADD a little extra milk.</li><li>Turn mixture onto a lightly floured bench AND bring the dough together UNTIL a rough ball OF dough IS formed.DO NOT OVER -knead.Pat dough TO 2 cm thickness.WITH a clean knife, QUARTER the dough OR use a round cutter TO cut rounds.</li><li>Arrange scones onto a baking paper lined tray AND bake AT 220 C FOR 12-15 minutes UNTIL golden AND they sound hollow WHEN lightly tapped ON the base.</li><li>Serve scones straight FROM the oven WITH jam AND cream.</li></ol>  british  45  4  t  f  f  f
42  Easy Beef Wellington  https://spoonacular.com/recipeImages/Easy-Beef-Wellington-641848.jpg  <ol><li>Pre-heat the oven TO 200 C.</li><li>Heat SOME oil IN a LARGE pan AND quickly fry the seasoned beef ALL OVER UNTIL its brown.Remove AND allow TO cool.The POINT OF this IS simply TO sear the beef AND seal ALL those juices IN, you dont want TO cook the meat AT this stage.Allow TO cool AND brush generously WITH the mustard.</li><li>Roughly chop the mushrooms AND blend IN a food processor TO form a puree.Scrape the mixture INTO a hot, dry pan AND allow the water TO evaporate.WHEN sufficiently dry (the mixture should be sticking together easily), SET aside AND cool.</li><li>Roll OUT a generous length OF cling wrap, lay OUT the four slices OF proscuitto, EACH one slightly overlapping the LAST.Spread the mushroom mixture evenly OVER the ham.</li><li>Place the beef fillet IN the middle AND keeping a tight HOLD OF the cling film FROM the outside edge, neatly roll the parma ham AND mushrooms OVER the beef INTO a tight barrel shape.Twist the ends TO secure the clingfilm.Refrigerate FOR 10 -15 minutes, this allows the Wellington TO SET AND helps keep the shape.</li><li>Roll OUT the pastry quite thinly TO a size which will cover your beef.Unwrap the meat FROM the cling film.Egg wash the edge OF the pastry AND place the beef IN the middle.</li><li>Roll up the pastry, cut ANY excess OFF the ends AND fold neatly TO the underside.Turnover AND egg wash OVER the top.Chill again TO let the pastry cool, approximately 5 minutes.Egg wash again BEFORE baking AT 200 C FOR 35  40 minutes.Rest 8 -10 minutes BEFORE slicing.</li></ol>  british  45  2  f  f  f  t
43  Easy Shepherd''s Pie (Beef OR Lamb Combo)  https://spoonacular.com/recipeImages/Easy-Shepherds-Pie-(Beef- AND - OR -Lamb-Combo)-642091.jpg  <ol><li>Boil potatoes IN salted water UNTIL tender, about 12 minutes.Drain potatoes AND pour them INTO a bowl.</li><li>Combine cream cheese ( OR sour cream), egg yolk AND milk ( OR heavy cream).ADD the cream mixture INTO potatoes AND mash UNTIL potatoes are almost smooth.</li><li> WHILE potatoes boil, preheat a LARGE skillet OVER medium high heat.ADD oil TO hot pan WITH beef AND / OR lamb.</li><li>Season meat WITH salt AND pepper.Brown AND crumble meat FOR 3 OR 4 minutes.IF you are USING lamb AND the pan IS fatty, spoon away SOME OF the drippings.</li><li> ADD chopped carrot* AND onion TO the meat.Cook veggies WITH meat 5 minutes, stirring frequently.</li><li>NOTE:* BY finely chopping the carrots, they will cook a little faster.</li><li> ADD the thyme.</li><li>OPTIONAL ADD the tomato paste, which gives the meat filling a richer flavor.</li><li> IN a SECOND small skillet OVER medium heat cook butter AND flour together 2 minutes.Whisk IN broth AND Worcestershire sauce.Thicken gravy 1 MINUTE.ADD gravy TO meat AND vegetables.Stir IN peas.</li><li>Preheat broiler TO high.</li><li>Fill a small rectangular casserole WITH meat AND vegetable mixture.Spoon potatoes OVER meat evenly.</li><li>Top potatoes WITH paprika AND broil 6 TO 8 inches FROM the heat UNTIL potatoes are evenly browned.Top casserole dish WITH chopped parsley AND serve</li></ol>  british  45  6  f  f  f  f
44  Fresh Cherry Scones  https://spoonacular.com/recipeImages/Fresh-Cherry-Scones-643450.jpg  <ol><li>Cut cherries IN half AND pit them ( OR use a cherry pitter).Place the cherries IN a freezer-safe container AND FREEZE FOR AT least 3 hours PRIOR TO baking the scones.This ensures the cherries dont pop IN the dough WHILE theyre baking.</li><li> IN a KitchenAid ( WITH the wire whisk attachment) OR food processor, ADD the oat flour, cornmeal, baking powder, baking soda, nutmeg, ginger AND salt.Mix OR pulse TO combine dry ingredients.IN a bowl, combine the applesauce, yogurt, vanilla EXTRACT AND agave nectar.Stir TO combine Very slowly pour the wet ingredients INTO the mixer WITH the dry ingredients about a QUARTER OF a cup AT a TIME ( SIMILAR idea TO making pie crust), mixing ON medium speed.Once ALL the wet ingredients are combined WITH the dry, ADD chopped walnuts AND mix UNTIL integrated INTO the dough.Taking the dough IN your hands, form it INTO a disc shape.Refrigerate IN a sealable container OR plastic wrap FOR 1 HOUR.</li><li>Preheat the oven TO 375 degrees.USING a bread knife, cut the dough IN half horizontally LIKE you would a bun.Place half OF the frozen cherries ON one OF the dough halves THEN place the other half OF the dough ON top.Press the dough halves together TO seal the cherries IN.Press the remaining frozen cherries INTO the top OF the dough.USING a serrated knife, cut diagonals INTO the dough IN ORDER TO CREATE eight triangles.Arrange ON a parchment paper-lined baking sheet (be sure TO give the triangles enough space TO bake evenly).Bake FOR 23 minutes OR UNTIL the tops OF the scones are golden brown.Serve WITH butter, jam, honey, OR nutella.</li></ol>  british  45  8  t  f  t  f
45  Healthier Bangers AND Mash  https://spoonacular.com/recipeImages/Healthier-Bangers- AND -Mash-646417.jpg  <ol><li>Spray a CAST iron skillet WITH cooking spray AND place OVER medium heat.Saut onions FOR ten minutes.ADD mushrooms AND CONTINUE TO saut FOR an additional ten minutes UNTIL they BEGIN TO caramelize.</li><li> IN the meantime fill a saucepan halfway WITH warm water AND bring TO a simmer OVER medium heat.ADD chicken sausages AND cover FOR 20 minutes.</li><li>Fill a LARGE pot WITH water AND bring TO a boil.ADD cauliflower AND cook uncovered FOR 20 minutes.</li><li> WHEN the onions AND mushrooms have caramelized sprinkle WITH flour AND stir TO combine.Pour IN chicken broth AND red wine, season WITH salt AND pepper.Bring TO a simmer AND cook FOR 10-15 minutes stirring occasionally UNTIL thickened.</li><li>Remove sausages FROM pan AND DISCARD water.Spray pan WITH cooking spray AND saut sausages UNTIL golden brown ON ALL sides.</li><li>Meanwhile, strain cauliflower AND place IN a food processor WITH milk, butter, AND cream cheese.Pulse UNTIL smooth, season WITH salt AND pepper.</li><li> TO serve place mashed cauliflower AND sausages ON a plate AND cover WITH gravy.</li></ol>  british  45  2  f  f  f  f
46  Lavender Scones  https://spoonacular.com/recipeImages/Lavendar-Scones-649315.jpg  <ol><li>Tip flour INTO a bowl WITH salt AND baking powder.ADD butter AND rub WITH your fingers UNTIL the mixture resembles breadcrumbs.ADD lavender AND sugar AND mix well.</li><li>Put the milk INTO a jug AND heat FOR 30 seconds, ADD the vanilla AND lemon juice.SET aside.Put a baking sheet IN the oven.</li><li>Make a well IN the dry mixture AND ADD the liquid.Combine quickly WITH a knife.</li><li>Scatter flour ON a board AND pat the dough INTO a round about 4cm deep.DO NOT OVER WORK.</li><li>Cut OUT rounds AND place ON the tray.Re-round the dough AND cut OUT more rounds UNTIL ALL dough IS used.</li><li>Brush WITH beaten egg AND bake FOR 10 mins, UNTIL risen AND golden.</li></ol>  british  45  1  t  f  f  f
47  Lean Shepherd''s Pie  https://spoonacular.com/recipeImages/Lean-Shepherds-Pie-649395.jpg  <ol><li>Brown ground beef WITH onion</li><li>Cook potatoes IN water till soft, drain</li><li>Mash potatoes, ADD chicken broth AS needed TO make smooth mashed potatoes</li><li>Spread browned ground beef IN bottom OF 8x11 Pyrex dish</li><li>Spread mashed potatoes OVER beef layer</li><li>Spead corn kernels OVER mashed potato layer</li><li>Sprinkle grated cheese OVER corn layer</li><li>Bake AT 350 FOR 25-30 minutes OR UNTIL heated through AND cheese IS melted</li><li> WHEN the pie comes OUT OF the oven, lightly dust the top WITH a little pepper IF desired.</li></ol>  british  45  4  f  f  t  f
48  Rich Jelly Scones  https://spoonacular.com/recipeImages/Rich-Jelly-Scones-658300.jpg  <ol><li>Pre-heat oven TO 400 degrees.</li><li>Mix dry ingredients together.</li><li>Cut butter INTO the dry ingredients USING a fork OR hand-held pastry blender.WHEN well blended, the mixture will have the look OF crumbly sand.</li><li> ADD the vanilla, eggs, AND milk, mixing ONLY long enough TO blend the ingredients.*You DO NOT want TO BEGIN TO melt the butter INTO the flour mixture BY OVER -mixing.</li><li>Turn the dough onto a lightly floured counter top OR pastry board.Shape it INTO a round disc 8 inches across, slightly thicker IN the center.</li><li> USING a long knife, cut the dough INTO eight even pie-shaped portions.</li><li>Place scones ON a lightly greased baking sheet.USING a spoon, press a well INTO the wide END OF EACH triangle, AND fill the well WITH a spoonful OF fruit jam.Brush the exposed surface OF EACH scone WITH the milk/egg mixture, </li><li>Bake FOR twenty-five minutes, UNTIL scones are a beautiful golden brown.</li></ol>  british  45  4  f  f  f  f
49  Ricotta Chocolate Chips Scones  https://spoonacular.com/recipeImages/Ricotta-Chocolate-Chips-Scones-658326.jpg  <ol><li>Preheat the oven TO 400F degress.LINE a baking sheet WITH parchment paper.</li><li> IN a bowl whisk together the flour, the sugar, the baking powder, the baking soda AND the salt.</li><li>Cut IN the ricotta AND butter AND lightly WORK WITH your fingers UNTIL the mixture resembles coarse sand.Gently stir IN the buttermilk, the vanilla EXTRACT AND the chocolate chips.</li><li>Turn the dough OUT onto a floured surface.Knead gently FOR 1  2 minutes, the dough should HOLD together but be a BIT crumbly.</li><li>Place the dough ON the PREPARED baking sheet lined WITH parchment paper.Pat the dough INTO a 3/4-inch-thick CIRCLE.</li><li>Cut  the dough INTO 4 wedges WITHOUT separating them.Use a pastry brush TO brush the surface OF the dough WITH milk AND THEN sprinkle WITH brown sugar.</li><li>Bake FOR about 15 minutes OR UNTIL lightly browned.Let them cool ON a cooling  rack.</li></ol>  british  45  4  f  f  f  f
50  Strawberries AND Cream Scones  https://spoonacular.com/recipeImages/Strawberries- AND -Cream-Scones-661725.jpg  <ol><li>Preheat the oven TO 425F.</li><li> CUBE AND chill butter.</li><li>Combine dry ingredients (flour, sugar, baking powder, lemon zest, salt, AND cinnamon) IN a LARGE bowl.</li><li> WITH your fingertips WORK the butter INTO the flour mixture.</li><li>Make a well IN the center OF the butter AND flour mixture.ADD the heavy cream AND stir.</li><li> ADD a tablespoon OF milk AND stir UNTIL the dough IS moistened but NOT wet.</li><li> ADD the diced strawberries.</li><li>Gently WORK the strawberries INTO the dough AND knead it together.</li><li>Pat INTO an 8 inch CIRCLE AND cut triangles.DO NOT be afraid OF USING flour, excess flour can ALWAYS be dusted OFF.</li><li>Transfer scones TO a parchment lined baking sheet.</li><li>Brush WITH egg wash.</li><li>Bake AT 425F FOR 12-15 minutes OR UNTIL the tops AND edges are golden.</li><li>Cool ON a cooling rack.</li><li>Drizzle WITH glaze (powdered sugar mixed WITH a BIT OF liquid OF your choice)</li></ol>  british  45  8  f  f  f  f
51  Trifle IN A Jiffy  https://spoonacular.com/recipeImages/Trifle- IN -A-Jiffy-663815.jpg  <ol><li>Mix jelly AS per packet instruction</li><li>Place cut up fruits IN a glass AND pour the jelly</li><li>Refrigerate</li><li> FOR the custard layer~Mix custard powder WITH 1/4 OF milk AND stir INTO a smooth mixture...</li><li>Pour the remainder OF the milk INTO a saucepan, follow BY the custard mix.Place ON the stove ON low heat...</li><li>Keep ON whisking TO avoid HAVING a lumpy custard.</li><li>Custard will slowly thickened...</li><li>Spoon the custard onto the jelly layer AND back INTO the refrigerator</li><li> FOR the cream layer ~ USING electric beater, beat the cream AND sugar UNTIL peak</li></ol>  british  45  1  f  f  t  f
52  Vegetarian Mushroom Shepherd''s Pie  https://spoonacular.com/recipeImages/Vegetarian-Mushroom-Shepherds-Pie-664680.jpg  <ol><li>Go TO my blog FOR the FULL instructions:http://gourmandelle.com/vegetarian-mushroom-shepherds-pie- WITH -vegan- VERSION /</li></ol>  british  45  12  t  f  t  t
53  Beef Wellington  https://spoonacular.com/recipeImages/beef_wellington-75081.jpg NONE british  139  10  f  f  f  f
54  Tenderloin Beef Wellington  https://spoonacular.com/recipeImages/tenderloin_beef_wellington-82518.jpg NONE british  25  1  f  f  t  t
55  Avocado AND Crawfish Appetizers  https://spoonacular.com/recipeImages/Avocado- AND -Crawfish-Appetizers-633123.jpg  <ol><li>Halve the tomato, scoop OUT AND DISCARD the seeds.Chop what IS LEFT AND place IN bowl WITH sherry vinegar, olive oil AND salt.Gently whisk.</li><li>Just BEFORE you are ready TO serve, fold the crayfish bits INTO the tomato mixture.</li><li>Halve the avocado, remove pit, scoop OUT SOME OF the pulp AND place spoons OF the crayfish mixture inside.Serve SOME OF the leftover avocado ON the side.</li><li>It can make a colorful AND pretty presentation....</li></ol>  cajun  45  4  f  f  t  t
56  Bananas Foster French TOAST https://spoonacular.com/recipeImages/Bananas-Foster-French- TOAST - BY -Mommie-Cooks-634234.jpg  <ol><li> SLICE up your loaf OF bread INTO 1 inch thick slices.</li><li> IN a separate bowl, whisk together the eggs, half & half AND cinnamon.</li><li>Dip EACH SLICE OF bread IN the egg mixture being sure TO coat BOTH sides.</li><li>Cook up ON a griddle FOR about 2-3 minutes ON EACH side OR UNTIL cooked through.</li><li> IN a pan ON the stove SET TO medium low heat, melt up the butter AND ADD IN the brown sugar.</li><li> ADD TO the mixture the syrup, cinnamon, salt AND vanilla.</li><li> ADD IN the bananas.Stir TO coat bananas completely.Remove FROM heat.</li><li> TO make the whipped cream, whip together your cream, maple syrup AND sugar UNTIL stiff peaks form.Serve OVER the top OF french TOAST.</li></ol>  cajun  45  1  f  f  f  f
57  Bananas Foster Ice Cream  https://spoonacular.com/recipeImages/Bananas-Foster-Ice-Cream-634237.jpg  <ol><li> IN a heavy bottomed saucepan, heat the milk, salt AND 1/4 cup sugar OVER med-low heat UNTIL steaming but NOT boiling AND the sugar IS dissolved.ADD the vanilla bean AND vanilla bean caviar TO the mixture.Cover AND let steep FOR 1 HOUR.</li><li> IN a small saute pan, melt the butter, brown sugar AND salt.Bring TO a boil stirring constantly UNTIL the mixture turns a deep golden brown.ADD the bananas AND CONTINUE TO saute the mixture FOR approximately 5 more minutes OR UNTIL the bananas soften.Stir IN the rum AND remove FROM heat.Let the mixture cool TO room temperature.</li><li>Fill a LARGE bowl WITH ice AND water.Place a small bowl IN the ice water AND ADD the heavy cream.Top the small bowl WITH a wire strainer AND SET aside.</li><li> IN a small bowl, whisk together the egg yolks AND remaining 1/4 cup sugar UNTIL light IN color AND ribbons BEGIN TO form.</li><li>Reheat the milk mixture OVER med-low heat AND slowly ADD TO egg mixture whisking constantly so the eggs DO NOT scramble.RETURN the milk/egg mixture TO the pan AND heat.Stir constantly WITH a heat resistant spatula being sure TO scrape the sides AND bottom UNTIL it begins TO thicken (it will coat the back OF the spatula).</li><li>Strain the milk mixture INTO the cream, remove the strainer AND stir UNTIL combined.Cover WITH plastic wrap AND chill IN the refrigerator FOR 2 hours OR overnight.</li><li>Pour the mixture INTO the freezer can OF an electric ice cream maker AND FREEZE according TO the manufacturers instructions.WHEN the mixture reaches soft serve consistency, ADD the banana mixture AND CONTINUE churning UNTIL combined.</li><li>Transfer the ice cream TO a freezer safe container AND FREEZE.</li></ol>  cajun  45  2  f  f  t  f
58  Boudin  https://spoonacular.com/recipeImages/Boudin-635701.jpg  <ol><li>Cook pork meat, liver AND seasonings IN water ( TO cover) UNTIL meat falls apart;
remove meat AND reserve SOME broth.</li><li>Grind meat, onion, green onions AND parsley (reserving about 1/2 cup EACH OF green onion tops AND parsley).</li><li>Mix ground meat mixture WITH the 1/2 cups OF green onion tops AND parsley, rice AND enough broth TO make a moist dressing.</li><li>Stuff dressing INTO casing, USING a sausage stuffer.</li></ol>  cajun  45  6  f  f  t  t
59  Boudin Sausage  https://spoonacular.com/recipeImages/Boudin-Sausage-635708.jpg  <ol><li> IN a LARGE sauce pan, combine the pork butt, pork liver, water, onions, garlic, bell peppers, celery, 1 teaspoon salt, 1/4 teaspoon cayenne, AND 1/4 teaspoon black pepper.Bring the liquid up TO a boil AND reduce TO a simmer.Simmer FOR 1 1/12 hours, OR UNTIL the pork AND liver are tender.Remove FROM the heat AND drain, reserving 1 1/2 cups OF the broth.</li><li> USING a meat grinder WITH a 1/4-inch die, grind the pork mixture.1/2 cup OF the parsley, AND 1/2 cup OF the green onions, together.Turn the mixture INTO a mixing bowl.Stir IN the rice, remaining salt, cayenne, black pepper, parsley, AND green onions.ADD the broth, 1/2 cup AT a TIME, AND mix thoroughly.Either USING a feeding tube OR a funnel, stuff the sausage INTO the casings AND make 3-inch links.</li><li>Bring 1 gallon OF salted water up TO a boil.Poach the sausage FOR about 5 minutes, OR UNTIL the sausage IS firm TO the touch AND plump.Remove FROM the water AND allow TO cool.</li></ol>  cajun  45  1  f  f  t  t
60  Vegan Jambalaya  https://spoonacular.com/recipeImages/Cajun-Cuisine--Vegan-Jambalaya-636714.jpg	<ol><li>Place 2 cups rice, 3 1/2 cups water and salt in a medium pot. Cook until water boils. Turn heat down to low.</li><li>Cook for 45 minutes.</li><li>Meanwhile, chop carrots, celery, onions and garlic.</li><li>In a wok or large pot, heat 2 Tbsp olive oil.</li><li>Fry vegetables.</li><li>Add instant roux, creole seasoning, pepper, tomato paste.</li><li>Add water, and bouillon cube and simmer until sauce thickens.</li><li>Add sausage and cooked for 5 minutes and then add beans Add petite diced tomatoes and cook for another 5 to 7 minutes.</li><li>Add 3 cups of cooked rice to mixture.</li><li>Cook for 10 to 15 minutes until sauce has distributed.</li><li>Turn heat off and add green onions and parsley before serving.</li><li>This dish is not spicy at all, but full of flavor.</li><li>Feel free to substitute with real sausage and cooked chicken.</li></ol>	cajun	45	4	t	f	f	t
61  Cajun Lobster Pasta  https://spoonacular.com/recipeImages/Cajun-Lobster-Pasta-636732.jpg  <ol><li>Cook up your bacon IN a small frying pan OVER medium heat.Remove the bacon AND drain OFF the fat, reserving about a tablespoon.</li><li> TO the pan ADD IN your garlic AND pepper.Cook it up ON medium heat FOR about two TO three minutes.</li><li> ADD IN the green onions.Let cook FOR an additional MINUTE.</li><li>Chop up your bacon AND ADD it TO the pan along WITH the broth.Love me SOME bacon.</li><li>Now ADD IN your spices;
the cajun, old bay, onion powder, garlic powder, lemon pepper, oregano, AND pepper.</li><li>Allow the mixture TO heat back up AND THEN turn your heat down TO medium low.ADD IN your lobster AND allow it about three TO five minutes TO heat up completely.</li><li> LAST up, ADD IN your cream.</li><li>Serve your finished lobster OVER fresh cooked pasta WITH a few pinches OF parmesan cheese AND a sprinkle OF chopped green onions OVER the top.</li></ol>  cajun  45  1  f  f  t  f
62  Cajun Potato Wedges  https://spoonacular.com/recipeImages/Cajun-Potato-Wedges-636733.jpg  <ol><li>Preheat oven TO 425 degrees Fahrenheit.SLICE potatoes INTO inch thick wedges that are half the length OF the potato.</li><li>Make spice mixture:combine ALL spices AND mix together IN a small bowl.</li><li>Spray cookie sheet WITH olive oil cooking spray.Place potatoes ON cookie sheet.Toss WITH olive oil.Sprinkle spice mixture OVER potatoes AND toss.</li><li>Cook FOR 25 minutes.Flip OVER AND cook FOR another 5 minutes.</li></ol>  cajun  45  4  t  t  t  t
63  Cajun Seafood AND Andouille Sausage Gumbo  https://spoonacular.com/recipeImages/Cajun-Seafood- AND -Andouille-Sausage-Gumbo-636736.jpg  <ol><li>1. IN a small bowl, combine the seasoning ingredients AND SET aside.</li><li>2. IN a medium bowl, combine the onions, peppers AND celeryand SET aside.</li><li>3. IN a lightly oiled 5  quart Dutch oven, brown the sausage rounds OVER medium high heat AND SET aside.</li><li>4. ADD the C oil AND WHEN it starts TO smoke, slowly combine the flour AND cook WHILE whisking UNTIL the roux reaches a dark reddish brown color.</li><li>5. Immediately ADD half OF the vegetables AND stir IN FOR 1 MINUTE.THEN ADD the remaining vegetables, mix thoroughly AND cook FOR 2 more minutes.</li><li>6. ADD the seasoning mix, stir IN well AND cook 2 more minutes OR so.THEN ADD the garlic, stir IN AND cook FOR another MINUTE.</li><li>7. ADD the fish stock OR clam juice AND, mix well, bring TO a boil AND reduce TO a simmer;
THEN simmer this FOR about 30 minutes covered.</li><li>8. ADD the reserved browned sausage rounds, the crab, shrimps AND oysters WITH their liquid AND cook OVER medium heat FOR about 10 minutes stirring occasionally.</li></ol>  cajun  45  4  f  f  f  t
64  Cajun Shrimp Chowder  https://spoonacular.com/recipeImages/Cajun-Shrimp-Chowda-636742.jpg  <ol><li>Grab up your frying pan AND cook up the three strips OF bacon.WHEN they''re cooked up, pull them OUT, chop them up, AND drain the bacon fat, reserving about a tablespoon.Turn your heat up TO medium AND ADD IN your asparagus, onion, AND garlic.Cook it up FOR 2 TO 3 minutes.</li><li> ADD IN the corn AND tomatoes.</li><li>Mix it together, give it a MINUTE OR two TO warm up AND THEN ADD IN the broth, the chopped bacon AND your spices;
the old bay, cajun, lemon pepper, AND salt AND pepper TO taste.</li><li>Let the whole kit AND kaboodle heat up FOR a good five minutes AND THEN ADD IN your cream.</li><li> AND LAST but most definitely NOT least, grab up your shrimp AND pop them INTO the pan.</li><li>Give the whole pan a swirl OR two AND allow the soup a couple minutes TO heat back up.</li><li>Serve WITH green onions sprinkled OVER the top.</li></ol>  cajun  30  8  f  f  t  f
65  Cajun Shrimp AND Marinated Cucumber Salad  https://spoonacular.com/recipeImages/Cajun-Shrimp- AND -Marinated-Cucumber-Salad-636743.jpg  <ol><li>Preheat broiler TO high.</li><li>Place shrimp ON a small rimmed baking sheet.Sprinkle WITH 1/2 tsp cajun seasoning, lemon juice ( OR vinegar), 1 T oil ( IF USING ) AND pinch OR two OF salt AND black pepper.</li><li>Place IN the oven ON the upper third rack.Broil FOR 3-5 minutes UNTIL shrimp IS completely OPAQUE AND pink.</li><li>Meanwhile, place cucumber slices IN a bowl AND toss WITH remaining 1/2 tsp cajun seasoning, 2 T vinegar, 2 T olive oil ( IF USING ), AND salt AND pepper TO taste.</li><li>Divide cucumbers BETWEEN two bowls, top EACH WITH half OF the shrimp AND a couple spoonfuls OF pico de gallo.</li></ol>  cajun  15  2  f  f  t  t
66  Creamy Crawfish Pasta  https://spoonacular.com/recipeImages/Creamy-Crawfish-Pasta-640630.jpg  <ol><li>Cook linguine according TO package directions;
drain.Keep warm.</li><li>Melt butter IN a Dutch oven OVER medium heat.ADD flour, AND cook, stirring constantly, 2 minutes OR UNTIL blended.ADD green onions AND NEXT 4 ingredients;
saut 5 minutes OR UNTIL tender.ADD bouillon CUBE AND NEXT 7 ingredients;
cook 10 minutes OR UNTIL thickened.Stir IN hot sauce, IF desired.Serve OVER linguine noodles;
sprinkle WITH shredded Parmesan cheese.Garnish, IF desired.</li><li>Pounds peeled, medium-size fresh OR frozen shrimp can be substituted FOR crawfish tails.</li></ol>  cajun  45  8  f  f  f  f
67  Jambalaya  https://spoonacular.com/recipeImages/Jambalaya-648427.jpg  <ol><li>Brown sausage.blacken fish WITH pepper AND paprika.Brown IN hot skillet.Saute onion, celery, green pepper, garlic UNTIL limp.ADD stock AND tomato sauce, spices, vegetable AND meats TO crock pot OR LARGE stock pot;
boil FOR 1 HOUR ON low OR crock pot UNTIL done.</li></ol>  cajun  45  10  f  f  t  t
68  Jambalaya Soup  https://spoonacular.com/recipeImages/Jambalaya-Soup-648430.jpg  <ol><li> IN saucepan, bring broth, tomatoes, garlic, herbs AND pepper TO a boil.IN 5- OR 6-quart slow cooker, mix onion, celery, rice AND sausage.ADD broth.Tuck IN drumsticks, meaty-sides down, TO cover.Cover;
cook ON LOW 7 TO 8 hours, OR ON HIGH 2 1/2 TO 3 hours, UNTIL rice has softened AND chicken IS tender.</li><li>Uncover;
turn TO HIGH.ADD shrimp AND okra;
cover.Simmer 5 minutes, UNTIL shrimp are cooked AND okra IS crisp-tender.Remove drumsticks;
remove bones, IF desired.Ladle soup INTO bowls;
ADD chicken TO EACH serving.</li><li>Stovetop Method:IN 5- OR 6-quart covered Dutch oven, simmer ALL ingredients EXCEPT shrimp AND okra, 1 HOUR AND 10 minutes.ADD shrimp AND okra;
simmer 5 TO 8 minutes.</li><li>This recipe yields 8 servings.</li></ol>  cajun  45  8  f  f  t  t
69  Jambalaya Stew  https://spoonacular.com/recipeImages/Jambalaya-Stew-648432.jpg  <ol><li> ADD ALL ingredients EXCEPT shrimp TO a LARGE pot ON the stove.Mix thoroughly.Bring TO a boil.</li><li>Reduce heat TO medium low.Cover AND simmer UNTIL vegetables are tender AND rice IS fluffy, about 35 minutes.</li><li> ADD shrimp AND re-cover.CONTINUE TO cook UNTIL shrimp are tender AND cooked through, about 6 minutes.</li><li> IF you LIKE, season TO taste WITH salt, black pepper, AND additional hot sauce.Serve AND enjoy!!!</li></ol>  cajun  45  4  f  f  t  t
70  Jean''s Seafood Gumbo  https://spoonacular.com/recipeImages/Jeans-Seafood-Gumbo-648524.jpg  <ol><li>Fill a 14-16-quart pot WITH two quarts OF water AND bring TO a boil.</li><li>Meanwhile, peel AND devein the shrimp, keeping the heads AND hulls.SET the shrimp aside IN cold water.IN the LARGE "gumbo pot" boil heads AND hulls FOR 30 minutes TO an HOUR.This will give you Creole gumbo.Strain shrimp heads AND hulls FROM stock AND SET aside.DISCARD heads AND hull immediately.Otherwise, the NEXT DAY your kitchen will smell LIKE Bayou St.John.</li><li>Clean the fresh crabs IF the crabs are fresh, you must take TIME TO clean them.DISCARD the hard back shell AND SOME OF the so- CALLED "dead man," OR yellow insides.Clean AND separate crabs AND SET aside.(Note:IF necessary, you can use meat FROM king, Dungeness, snow OR stone crabs FOR your gumbo).</li><li> BEFORE you fire up the stove again, cut up your celery, parsley, peppers, onions AND garlic, especially IF you''re alone AND there IS NO one TO help you stir the pots.It takes TIME peeling the onions AND garlic  Put the celery AND parsley IN a separate container FROM the other chopped ingredients AND refrigerate UNTIL needed TO keep them fresh.</li><li>Place the gumbo pot WITH the shrimp stock ON the stove.ADD cleaned crabs AND bay leaves.Stir slowly.You don''t want your shrimp stock messing up the floor.ADD celery, parsley, AND tomato paste TO the gumbo brewing ON the stove.Bring TO a boil.Turn down heat, cover, AND let simmer.</li><li>Here comes the roux -- a thick and flavorful sauce that has become one of the most important staples of Louisiana cuisine. Pour oil or shortening into a separate heavy skillet (please do not use a thin omelet pan) over a medium-low heat. Slowly stir in flour to make the roux. Keep your eyes on the skillet. If the phone rings, let the answering machine pick it up. Cook roux until it has a dark mahogany color. Do not stop stirring until roux appears nutty or grainy. If black specks appear, the roux is burned. Throw it out and start from scratch. A good roux could take 30 to 45 minutes cooking time.</li><li>Now you are ready to add the holy trinity of onions, garlic, and green peppers to the roux mixture. Stir ingredients in slowly because the flour is still sizzling. The moisture will begin to disappear. This is when Jean would add another quart or two of water to the gumbo pot. Add roux to the gumbo pot. Bring to a boil, stirring constantly. Lower heat and cover. The kitchen should smell good right now. Pour yourself another cold something-or-other. You''re halfway there. Come back to look and stir in an hour or so.</li><li>Season to taste: add salt, pepper, thyme, Worcestershire sauce, Tabasco sauce and any Creole seasoning you like. Don''t overdo it right now. Let the roux work its magic absorbing all the wonderful ingredients. Gumbo is usually very spicy, but you can keep it mild. Remember, if you have decided to use andouille sausage it is also hot.</li><li>Fry sausages and okra with a little bit of the leftover grease. Sprinkle a little leftover flour if the okra is fresh. Add to gumbo pot. Add chopped peeled tomatoes, stirring until well blended. Add more water if necessary. The roux will keep it thick and tasty. Return to a boil and simmer for 10 minutes. Reduce heat and let simmer, uncovered, for 2 1/2 to 3 hours over low heat.</li><li>Skim any excess fat. Add shrimp. Stir in slowly as you increase the heat one last time. It''s time to stir in the fil powder. Cook another 20 to 30 minutes until the gumbo is thick. Taste and adjust seasonings one more time. Did I mention the rice? Seafood gumbo is served over Louisiana rice. Of course, you can substitute for your own favorite rice. Just plain old brown or white rice will do. Before serving, taste one more time and adjust seasoning. Turn off heat and remove seafood gumbo from the stove.</li><li>To cool down the pot before serving, place it in the sink with a few inches of ice-cold water. If needed, add additional salt and Tabasco sauce. If you can see through the gumbo to the bottom of the pot, work on your roux next time.</li></ol>	cajun	45	9	f	f	f	t
71  King Cake  https://spoonacular.com/recipeImages/King-Cake-648921.jpg  <ol><li>Scald milk.Pour OVER butter, sugar AND salt.Mix together IN LARGE mixing bowl.Let cool TO lukewarm.IN another bowl, sprinkle yeast ON 1/4 cup warm water ( OR use lukewarm water FOR compressed yeast).Stir softened yeast INTO milk mixture.ADD beaten eggs.Stir a little flour IN, beating UNTIL smooth.ADD sufficient remaining flour TO make soft dough, stirring UNTIL dough forms ball which leaves side OF bowl.</li><li>Turn dough OUT onto lightly floured board.Press INTO flattened ball, about 1 1/2 inch thick.Knead UNTIL smooth AND elastic, adding ONLY enough flour TO keep dough FROM sticking.Grease mixing bowl.RETURN dough TO bowl, turning dough once TO grease its surface.Coat top OF dough lightly WITH softened shortening.Cover WITH folded kitchen towel.Let rise IN warm, NOT hot, place about 50 minutes, OR UNTIL DOUBLE IN bulk.</li><li>Punch dough down AND turn OUT onto lightly floured board.Roll OUT INTO 10x16 inch rectangle TO about 1/4 TO 1/2 inch thick.Cut lengthwise INTO 3 strips.Spread EACH strip WITH melted butter.Sprinkle EACH strip WITH cinnamon, sugar AND ginger mixture.(This IS easiest IF kept away FROM edges AND mixture IS "funneled" IN the middle OF the strips.) Fold EACH strip OVER ON long side.Press TO seal EACH strip."Braid" dough AND place ON lightly greased baking sheet.</li><li>Cover ring lightly WITH folded kitchen towel.Let rise IN warm place away FROM draft about 30 minutes OR overnight.Bake IN preheated 350 degree oven FOR 24-28 minutes.Drip (drizzle) confectioners'' sugar mixture OVER top OF hot bread.Sprinkle WITH colored "sanding" sugar OR colored baking sugar.</li><li>Stuff "baby" OR "surprise" INTO dough, FROM the bottom OR under side AFTER baking.</li></ol>  cajun  45  1  f  f  f  f
72  New Orleans Red Beans AND Rice WITH Andouille Sausage  https://spoonacular.com/recipeImages/New-Orleans-Red-Beans- AND -Rice- WITH -Andouille-Sausage-653055.jpg  <ol><li>Soak the beans overnight IN cool water.The NEXT DAY, drain AND ADD fresh water TO cover beans IN Dutch oven.Bring TO a boil, THEN reduce TO medium-high heat AND simmer FOR 45-60 minutes OR UNTIL tender, but NOT falling apart.Drain.</li><li>Meanwhile, ADD oil TO a skillet AND saute onions, celery AND bell pepper UNTIL translucent, about 8-10 minutes.ADD garlic AND saute FOR 2 more minutes, stirring occasionally.ADD sauteed vegetables TO beans, ham hock, sausage, seasonings, AND just enough water TO cover.</li><li>Bring TO a boil, THEN reduce heat TO a low simmer.Cook FOR 2 hours AT least, preferably 3, UNTIL the gravy gets creamy.Adjust seasonings AS you go along.Stir occasionally, making sure that it doesn''t burn AND / OR stick TO the bottom OF the pot.</li><li> IF the gravy does NOT GET TO the RIGHT consistancy, you can scoop SOME OF the beans OUT AND mash them, THEN RETURN them TO the pot AND stir.Note:it''s NOT considered cheating:)</li><li>Serve OVER long-grain rice.</li></ol>  cajun  45  6  f  f  t  t
73  Seafood Gumbo  https://spoonacular.com/recipeImages/Seafood-Gumbo-659638.jpg  <ol><li>Heat oil IN a LARGE heavy stockpot OVER medium-high heat.</li><li> ADD the flour AND stir constantly UNTIL a light brown roux IS formed.</li><li> ADD the onions, bell pepper, celery AND garlic.Saut UNTIL the onions become translucent AND the vegetables are tender.</li><li> ADD the tomatoes AND tomato pure AND cook OVER medium heat FOR 10 minutes.</li><li> ADD the Creole seasoning, thyme, bay leaves AND about 1/2 teaspoon EACH OF salt AND pepper, AND CONTINUE TO cook another 10 minutes.</li><li> ADD the okra, AND cook FOR another 10 minutes, THEN ADD the stock.Bring TO a boil, THEN reduce heat TO simmer AND cook another 30 minutes.</li><li>Reduce heat TO low.</li><li>About 10 minutes PRIOR TO serving, ADD the shrimp, oysters AND oyster liquor.Just PRIOR TO serving, ADD the crab meat (the crab meat does NOT need TO be cooked, just stir UNTIL it IS heated through.</li><li>Taste AND correct seasonings IF necessary.</li><li>Remove FROM heat AND sprinkle the fil powder ON the surface OF the gumbo;
cover AND let stand FOR 15 minutes.Uncover AND stir TO mix.</li><li>Serve hot WITH French bread AND cold beverages.</li></ol>  cajun  45  12  f  f  f  t
74  Authentic Jamaican Curry Chicken  https://spoonacular.com/recipeImages/Authentic-Jamaican-Curry-Chicken-633088.jpg  <ol><li>Season the chicken WITH ALL OF the ingredients EXCEPT FOR the potatoes AND water AND marinate up TO 2 hours OR overnight IN the fridge.</li><li> ADD the oil TO a Dutch oven AND ON high heat, fry the ONLY the chicken pieces UNTIL it IS brown AND seared ON EACH side FOR about 10 minutes.</li><li> AFTER the meat IS nice AND brown ON BOTH sides, ADD the remaining vegetable marinade, scotch bonnet pepper AND water TO the pot, cover AND bring TO a boil.</li><li> ADD the potatoes AND lower TO a simmer AND stew it FOR about 1 HOUR UNTIL it has a thick consistency.</li></ol>  caribbean  45  4  f  f  t  t
75  Caribbean black bean AND sweet potato soup  https://spoonacular.com/recipeImages/Caribbean-black-bean- AND -sweet-potato-soup-637099.jpg  <ol><li>Rinse beans AND place IN a LARGE bowl.Cover beans WITH 4 inches OF water AND soak overnight ( OR 8 hours).Strain AND rinse black beans.</li><li> IN a LARGE soup pot, heat the oil OVER medium heat.ADD onion AND jalapeno AND saut FOR 10 minutes, UNTIL soft.</li><li> ADD beans AND vegetable broth OR water.Stir IN ginger, allspice, thyme AND salt.Bring TO a boil, THEN reduce heat AND simmer FOR 1 HOUR 30 minutes.</li><li> ADD sweet potatoes AND brown sugar AND simmer FOR an additional 30 minutes, UNTIL beans AND sweet potatoes are soft.</li><li>Puree 1 cup OF the soup IN a blender AND THEN ADD it back INTO the soup pot.Stir IN cilantro AND green onion.Salt AND pepper TO taste.</li></ol>  caribbean  45  6  t  t  t  t
76  Caribbean Chicken Thighs  https://spoonacular.com/recipeImages/Caribbean-Chicken-Thighs-637103.jpg  <ol><li> PREPARE marinade:IN a food processor, ADD lime juice, garlic, onion, jalapeno, AND green onion.Pulse UNTIL pureed.</li><li>Pour INTO a small bowl, ADD pineapple juice, brown sugar, AND spices.Mix together.</li><li> IN a gallon plastic bag, ADD chicken, AND marinade.Mix together.Place IN fridge AND let marinate FOR AT least 4 hours TO 24 hours.</li><li>Preheat broiler.Remove FROM bag AND place chicken skin side down IN a baking sheet lined WITH aluminum foil.Cook FOR 5 minutes till the tops are NO longer pink.Flip OVER AND cook FOR remaining 25 minutes till the skin IS crispy.</li><li>Serve immediately.Enjoy!</li></ol>  caribbean  45  2  f  f  t  t
77  Caribbean Truffle Pie  https://spoonacular.com/recipeImages/Caribbean-Truffle-Pie-637116.jpg  <ol><li>Heat oven TO 450 degrees.Allow 1 crust pouch TO stand AT room temperature FOR 15 TO 20 minutes.(Refrigerate remaining crust FOR a later use.) Remove pie crust FROM pouch.Unfold crust;
remove plastic sheet.Sprinkle WITH 2 tablespoons coconut;
press IN lightly.Carefully lift crust OFF SECOND plastic sheet.Place crust, coconut side up, IN 9-inch pie pan;
press IN bottom AND up sides OF pan.Flute edge;
prick crust generously WITH fork.Bake AT 450 degrees FOR 9 TO 11 minutes OR UNTIL golden brown.Cool crust WHILE preparing streusel AND filling.Reduce oven temperature TO 425 degrees.</li><li> IN small bowl, combine flour AND 1/4 cup sugar.WITH pastry blender OR fork, cut IN butter UNTIL mixture resembles coarse crumbs.Stir IN 1/4 cup coconut.Spread mixture IN ungreased shallow baking pan.Bake AT 425 degrees FOR 4 TO 8 minutes OR UNTIL golden brown, stirring every minutes.SET aside.</li><li> IN medium saucepan, combine pudding mix, 1/2 cup sugar, lime juice AND egg yolks;
mix well.Stir IN 2 cups water.Cook AND stir OVER medium heat UNTIL mixture comes TO a FULL boil.Remove FROM heat;
stir IN lime peel.IN small bowl, combine white chocolate chips AND 1/2 cup OF the hot pudding mixture;
stir UNTIL chips are melted.</li><li> IN small bowl, beat cream cheese UNTIL light AND fluffy.ADD white chocolate chip mixture;
beat UNTIL smooth.Spoon AND spread IN baked crust.Stir sour cream INTO remaining pie filling mixture;
blend well.Spoon AND spread OVER cream cheese layer.Refrigerate 2 hours OR UNTIL chilled.</li><li> IN small bowl, beat whipping cream UNTIL stiff peaks form.Pipe OR spoon around edge OF pie;
garnish WITH LINE slices.Sprinkle streusel IN center OF pie.Store IN refrigerator.</li></ol>  caribbean  150  8  f  f  f  f
78  Trinidad Callaloo Soup  https://spoonacular.com/recipeImages/Trinidad-Callaloo-Soup-663822.jpg  <ol><li>Saute onion, okra, salt pork, thyme, garlic, habanero AND scallions UNTIL the okra AND onions brown.</li><li>Stir IN the callaloo WITH the chicken stock AND simmer UNTIL the callaloo IS tender.</li><li>Puree WITH a stick blender.Adjust seasoning TO taste WITH salt AND pepper.</li><li>Stir IN coconut milk AND crab, THEN warm gently.</li><li>Serve WITH rice.</li></ol>  caribbean  45  4  f  f  t  t
79  Rice AND Peas WITH Coconut Curry Mackerel  https://spoonacular.com/recipeImages/rice- AND -peas- WITH -coconut-curry-mackerel-716364.jpg  Pour 1 cup OF coconut milk IN a pot WITH 1 seasoning CUBE AND allow TO boil FOR a MINUTE.Pour IN your rice AND peas IN the boiling coconut milk AND pour 2 cups OF water AND leave TO boil till the rice AND peas are soft ON low heat.IN a separate pot, season AND bring the mackerel TO boil IN the rest OF the coconut milk, curry powder AND SOME water.Toss IN the chopped onion, scotch bonnet peppers AND garlic AND allow TO simmer ON medium heat.Once the fish IS cooked, ADD the corn starch TO thicken the sauce AND allow TO simmer FOR 4 minutes ON low heat.Serve WITH the rice AND peas  caribbean  45  4  f  f  t  t
80  A Christmas WITH Peking Duck  https://spoonacular.com/recipeImages/A-Christmas- WITH -Peking-Duck-631888.jpg  <ol><li>Rinse duck AND remove innards.Cut skin around neck AND remove tail.</li><li>Hang duck neck-side-up OVER a LARGE pot.Boil water.</li><li>Pour boiling water OVER the duck UNTIL skin IS puffed up.Remove boiled water FROM pot.</li><li>Combine salt, white pepper, five spice powder AND 2 tsp OF hoison sauce.</li><li>Brush mixture ON the outside AND inside OF the duck TO marinate it.</li><li>Let mixture dry - about 2 hours.</li><li>Combine corn syrup, honey, rice vinegar AND brush outside OF the duck.Let duck air dry FOR 12-24 hours.</li><li>Preheat oven TO 450 degrees.Roast duck FOR 40 minutes.</li><li>Let meat rest FOR 15 minutes AFTER cooking.Cut the meat INTO thin slices AND enjoy.Serve WITH Bao, Chinese pan cakes ADD hosin sauce AND scallions.</li></ol>  chinese  45  12  f  f  t  t
81  Chinese Chicken Salad WITH Chipotle Dressing  https://spoonacular.com/recipeImages/Chinese-Chicken-Salad- WITH -Chipotle-Dressing-638642.jpg  <ol><li>Dressing:</li><li>Whisk together the vinegar, peanut &amp;
almond butters, ginger, chipotle pepper puree, soy sauce, honey, sesame oil, AND canola oil IN a medium bowl.Season WITH salt AND pepper, TO taste.</li><li>Salad:</li><li>Combine cabbage, lettuce, carrots, snow peas, cilantro, AND green onion IN a LARGE bowl.ADD the dressing AND toss TO combine.</li><li>Transfer TO a serving platter AND top WITH the shredded chicken, chopped peanuts, AND mint.Drizzle WITH chili oil, IF desired.Garnish WITH lime halves.</li></ol>  chinese  45  4  f  f  t  t
82  Chinese Chicken Salad WITH Creamy Soy Dressing  https://spoonacular.com/recipeImages/Chinese-Chicken-Salad- WITH -Creamy-Soy-Dressing-638649.jpg  <ol><li>Whisk mayonnaise, soy sauce AND ginger together IN a LARGE bowl UNTIL blended.</li><li> ADD chicken, snow peas, peppers, carrots AND green onion;
toss TO mix AND coat.</li><li>Serve OVER torn spinach leaves.</li></ol>  chinese  30  2  f  f  t  f
83  Chinese Five Spice Braised Pork Belly WITH Lotus Root AND Steamed Yucca  https://spoonacular.com/recipeImages/Chinese-Five-Spice-Braised-Pork-Belly- WITH -Lotus-Root- AND -Steamed-Yucca-638662.jpg  <ol><li>How TO Steam Pork Belly:</li><li>Take a LARGE pot AND fill it a QUARTER OF the way up WITH water.Take your pork belly AND place it IN a heatproof bowl.ADD 1/4 cup OF ShaoHsing Cooking Wine AND one cinnamon stick AND place it ON a steamer rack inside the LARGE pot.Cover pot AND allow pork TO steam FOR 10-15 minutes OR UNTIL the meat feels firm TO the touch.</li><li> IN a LARGE heavy bottomed pot, heat the oil AT medium high heat.WHEN almost smoking, ADD the spices along WITH the ginger, garlic AND shallots.Once the spices are aromatic, ADD the pork belly along WITH the cooking wine AND remaining liquids TO the pot.Stir TO mix well AND ADD the rock sugar.Once sugar IS dissolved, reduce mixture TO low heat AND braise FOR 2 hours.IF the liquid becomes too low, simply ADD more water AND adjust the sweetness AND salty LEVEL TO your tastes.</li><li>Peel the lotus root AND cut INTO thin slices.Place IN the braising liquid AND cook UNTIL slightly tender, about 20 minutes.It will have a nice starchy AND crunchy texture TO it.Meanwhile, take the yucca AND place it IN a heat proof bowl.Allow TO steam UNTIL cooked through, about 30 minutes.Once done, peel OFF the skin AND mash the yucca TO a paste.ADD a little BIT OF salt AND sesame oil, SET aside UNTIL ready TO serve.</li></ol>  chinese  180  2  f  f  t  t
84  Chinese Hot Pots Gluten-Free AND Low-Carb  https://spoonacular.com/recipeImages/Chinese-Hot-Pots-Gluten-Free- AND -Low-Carb-638668.jpg  <ol><li> IN a LARGE pot, bring the chicken stock, water, vinegar, soy sauce, sesame oil, ginger AND garlic TO a boil.</li><li> ADD the chicken AND simmer FOR 5-7 minutes, UNTIL just cooked through.ADD the noodles.Stir, THEN cover AND remove FROM heat.</li><li>Meanwhile chop ALL the veggies AND place IN serving bowls.</li><li> WHEN ready TO serve, allow EACH person TO fill their bowls WITH fresh vegetables AND a BIT OF chile sauce.</li><li> THEN ladle the scalding hot soup OVER the veggies AND let them sit FOR 5 minutes.</li><li>Mix AND eat!</li></ol>  chinese  25  6  f  f  t  t
85  Five Spice Chinese Pork Stew  https://spoonacular.com/recipeImages/Five-Spice-Chinese-Pork-Stew-643011.jpg  <ol><li> IN a LARGE pot, ADD the pork WITH the rest OF the ingredients FOR boiling.ADD water, enough the cover BY pork BY 1/2 inch.</li><li>Boil ON medium heat UNTIL the pork IS fork tender.Once done, remove the pork FROM the pot.</li><li>Reserve the stock AND run it through a fine sieve TO strain the impurities.</li><li> IN a wok OR LARGE pan, heat the oil AND ADD the garlic.Allow TO TOAST but be careful NOT TO burn it.</li><li> ADD the shallots AND the white onion AND saute UNTIL it sweats AND goes slightly limp.ADD the ginger AND fry UNTIL very fragrant.Remove around 1/4 OF the onion AND ginger AND reserve FOR garnish.</li><li> ADD the pork AND mix everything well UNTIL the pork IS lightly toasted, around 2-3 minutes.ADD the pork stock (the water used TO boil the pork), followed the the soy sauce.</li><li> ADD IN the remaining ingredients AND mix well.Cover the pot AND allow the stew TO reduce FOR 2  3 minutes.ADD the mushrooms AND cook FOR another MINUTE.Remove FROM pan AND serve hot, garnished WITH the sauteed onions AND ginger, AND WITH a heaping scoop OF rice.Enjoy!</li></ol>  chinese  45  6  f  f  t  t
86  Fried Wonton  https://spoonacular.com/recipeImages/Fried-Wonton-643829.jpg  <ol><li>Cook IN pan FOR 3-4 minutes.</li><li>Ketchup</li><li>Sugar</li><li>Garlic powder</li><li>Salt</li><li> SOME water</li></ol>  chinese  45  1  f  f  t  t
87  Gluten Free Dairy Free Sugar Free Chinese Chicken Salad  https://spoonacular.com/recipeImages/Gluten-Free-Dairy-Free-Sugar-Free-Chinese-Chicken-Salad-644826.jpg  <ol><li> FOR the salad:</li><li>Finely SLICE the red, AND green cabbage.</li><li>Remove ends AND finely SLICE romaine lettuce.</li><li> TRIM ends OF scallions (white AND green side) AND finely SLICE.</li><li>Peel AND grate carrots, OR put INTO a mini food processor TO finely chop.</li><li>Peel clementines THEN remove pith FROM slices.</li><li> ADD ALL the ingredients INTO a LARGE serving bowl.</li><li> FOR the dressing:</li><li> ADD ALL the ingredients INTO a glass jar AND shake UNTIL well blended, OR whisk ALL the ingredients IN a mixing bowl.</li><li>Pour dressing OVER salad, toss TO combine well.</li><li> IF making ahead, dress the salad just BEFORE serving.</li></ol>  chinese  45  6  f  f  t  t
88  Healthier Pork Fried Rice  https://spoonacular.com/recipeImages/Healthier-Pork-Fried-Rice-646425.jpg  <ol><li>1. PREPARE Rice:Place 1 cup OF rice, 2 cups OF water ( OR whatever the rice directions say) AND the ginger slices IN a medium pot.Bring TO a boil, cover AND them reduce heat TO low.Simmer UNTIL rice IS tender, about 20 minutes.Once done, take ginger slices OUT OF pan.</li><li>2. PREPARE pork:Meanwhile, preheat oven TO 350 degrees Fahrenheit AND a grill pan ( OR grill) TO high heat).SLICE pork tenderloin INTO 1/2 inch strips AND season strips WITH, garlic, onion, ginger, pepper AND salt ON BOTH sides.Once the grill pan IS hot, ADD the pork.Cook 3 minutes per side TO GET SOME good grill marks.Once done.Place ON baking sheet AND IN OVER FOR 2 minutes.Take OUT OF oven SET aside AND let rest.</li><li>3. IN a frying pan OR LARGE pan ON medium high heat, ADD olive oil.Once oil IS hot, ADD garlic, ginger AND green onion, cooking UNTIL onion IS tender, about 1 MINUTE ( make sure TO stir garlic so it does NOT burn).ADD peas AND carrots, stir AND cook UNTIL vegetables are tender about 3 minutes.ADD eggs OVER veggies AND stir till scrambled, about 1 MINUTE.ADD rice TO pan.Gently fold rice IN.Remove FROM heat.ADD Pork, soy sauce AND hoisin ( you may want TO ADD more later, but go slow, it gets very strong quickly).Gently stir together till ALL rice IS coated IN sauce.</li><li>4. Serve AND enjoy!</li></ol>  chinese  45  3  f  f  t  t
89  Noodles WITH Chinese Kale AND Shitake Mushrooms  https://spoonacular.com/recipeImages/Noodles- WITH -Chinese-Kale---Shitake-Mushrooms-653255.jpg	<ol><li>Saute sliced shallots in 3 tbsps of oil until golden brown (see photo above). Remove the fried shallots and spread them out on a flat plate. Leave the remaining shallots-infused oil in the pan/wok.</li><li>Heat up the oil and saute the  mushrooms until aromatic.</li><li>Add garlic and saute further until aromatic.</li><li>Add kale and 2 tbsps of water. Cook until the vegetables become slightly soften.</li><li>Add noodles, sweet soy sauce and oyster sauce and mix to combine all the ingredients. If the noodles start to stick at the bottom of the pan/wok, add a little water. Cook for 3-5 minutes.</li><li>Sprinkle fried shallots over the noodles just before serving. You can  garnish the noodles with some fresh spring onions and chilles. It also goes well with sambal.</li></ol>	chinese	45	1	f	f	f	t
90  Pan Fried Pork AND Chive Potstickers  https://spoonacular.com/recipeImages/Pan-Fried-Pork- AND -Chive-Potstickers-654408.jpg  <ol><li> BEGIN BY making the dough.Combine water AND flour AND mix UNTIL ALL flour IS just incorporated.Let dough rest FOR 10 minutes.</li><li> NEXT, make the filling.Mix the pork, chives, dried shrimp, salt AND sesame oil.</li><li>Youre now ready TO START making your wrappers AND filling the dumplings.Roll OUT the dough INTO long sushi roll AND cut INTO small round 1 inch pieces.</li><li>Use a small rolling pin TO flatten it INTO a WRAPPER about 3 inches wide.You are looking FOR wrappers about the same thickness AS gyoza, so WHEN rolling OUT your own dough, its pretty thin.Its really an art  you make small balls about 1-inch IN diameter, THEN smash down WITH your hand.Roll the pin around the edges UNTIL you GET your thin WRAPPER, leaving it a little thicker IN the middle AND thinner ON the edges.</li><li>Sprinkle SOME flour ON a clean surface ON the kitchen counter.</li><li>Place EACH WRAPPER ON the floured surface WITH the floured side facing up.</li><li>Put 1 heaping tsp OF the filling IN the center OF EACH WRAPPER.</li><li>Wet your finger IN the cup OF water AND wet ALL around the OUTER edge OF the wrappers.</li><li> CLOSE it BY folding it up AND pressing two wetted sides together.</li><li> SET it down ON a flat surface AND make the bottom flat.</li><li> AFTER about 20 TO 30 finished dumplings, you can SET a non-stick flat bottom skillet ON the stove.</li><li> ADD 1 tablespoon OF vegetable oil IN it AND place the dumplings ALL around the skillet.</li><li> ADD two cups OF cold water, AND THEN put a lid ON the skillet.Turn the temperature TO high.</li><li> WHEN the water IS dry, turn the fire TO low.Take OUT the dumplings WHEN they are golden brown AND crispy AT the bottom.</li><li>Serve WITH soy dipping sauce OF chopped garlic, 1/2 C.OF soy, 1/3 C.OF rice wine vinegar, 1/2 tsp.OF salt, 1/2 tbs.OF sugar AND 1/2 tbs.OF sesame oil.IF you LIKE things hot, you can make a spicier dipping sauce OUT OF hot chili paste, soy sauce AND sesame oil.</li></ol>  chinese  45  1  f  f  f  t
91  Pork Fried Rice  https://spoonacular.com/recipeImages/Pork-Fried-Rice-656777.jpg  <ol><li>Cut pork INTO 1/4 inch slices, THEN cut INTO 1/4 inch strips AND SET aside.</li><li>Heat half the oil IN a hot wok UNTIL the surface begins TO quiver.Pour IN beaten eggs AND allow TO cook FOR 10 seconds, THEN fold egg mixture OVER onto itself WITH a spatula AND lightly scramble FOR about 1 MINUTE.Carefully remove egg FROM wok WITH a spatula AND drain ON paper towel.SET aside.</li><li>Heat remaining oil IN hot wok AND stir fry onion AND ginger FOR 30 seconds.ADD sugar AND stir fry FOR 30 more seconds.ADD pork AND stir fry FOR a further 30 seconds.Stir IN hoisin sauce, soy sauce, vinegar, AND sesame oil AND cook, stirring, FOR 1 MINUTE.Toss IN rice AND cooked egg AND stir, USING a spatula TO break up the egg INTO smaller pieces, FOR 1 MINUTE.Finally, ADD green onions AND stir fry FOR a further 30 seconds OR UNTIL well combined AND rice IS heated through.</li><li>Transfer rice TO a platter AND serve.</li></ol>  chinese  45  4  f  f  t  t
92  Skinny Veggie Fried Rice  https://spoonacular.com/recipeImages/Skinny-Veggie-Fried-Rice-660231.jpg  <ol><li>Heat a wok OR skillet ON med-high AND ADD 1 tsp oil.TO it ADD minced ginger AND 1 tsp minced garlic.Saute UNTIL fragrant but NOT burnt.ADD mushroom pieces.Cook UNTIL tender FOR 5-6 minutes.Keep mushrooms along WITH ANY juices aside IN a bowl.</li><li>Heat wok again ADD 1 tsp oil.TO it ADD remaining garlic.Saute UNTIL fragrant AND ADD ALL the vegetables.Stir it ALL together ON high flame.ADD salt, black pepper AND splash OF soy sauce.Toss TO coat AND let them cook FOR few more minutes UNTIL they GET tender but NOT soft.You want veggies TO be cooked but WITH a little crunch.Now ADD the cold already cooked rice AND stir it so it ALL gets mixed together.DO WITH a gentle hand.Let the rice GET warm AT med- high flame.Add the remaining 1 tsp oil along WITH salt, black pepper AND soy sauce.ADD the mushrooms AND tofu( IF USING ).Mix it ALL together.Toss AND taste.</li><li>Garnish WITH chopped green parts OF green onions AND sesame seeds.</li></ol>  chinese  45  2  t  t  t  t
93  Stuffed mushrooms AND Chow Mein noodles  https://spoonacular.com/recipeImages/Stuffed-mushrooms- AND -Chow-Mein-noodles-662054.jpg  <ol><li>Blanch the spinach IN a very little water IN the microwave oven FOR 3 minutes ON MAX.Drain AND coarsely chop.Chop mushroom stems IN a blender.</li><li>Melt the butter OVER low heat, ADD the onion AND cook FOR 1 MINUTE.ADD chopped mushroom stems, AND saut FOR 4-5 minutes, stirring often.</li><li> ADD chopped spinach;
stir well AND saut 2 more minutes.Remove FROM the heat.</li><li>Mix AND combine WITH a fork IN a separate bowl ricotta, blue cheese, chives AND pepper INTO a fine mixture, almost a paste.</li><li> ADD chopped stalks AND spinach mixture, stir AND combine thoroughly.</li><li> USING a small teaspoon, place mounds OF filling ON the top OF EACH mushroom cap, pressing slightly TO GET it down INTO the cavity.</li><li>Mix breadcrumbs AND grated Parmesan cheese, sprinkle evenly OVER EACH mushroom.Drizzle EACH filled cap WITH olive oil.</li><li>Place the mushroom caps ON a baking sheet lined WITH parchment paper OR silicon sheet, AND bake IN the oven AT 180 C FOR 20 minutes OR UNTIL the cheese browns a little.Allow TO cool FOR 5 minutes OR so BEFORE serving.</li><li>Meanwhile cook the Chow Mein OR rice noodles AS directed ON the package;
drain.</li><li>Mix AND combine garlic, sour cream AND salt AND stir INTO the cooked pasta.</li><li>Sprinkle WITH chopped parsley AND served WITH stuffed mushrooms.</li></ol>  chinese  45  2  f  f  f  f
94  Vegetable Fried Rice  https://spoonacular.com/recipeImages/Vegetable-Fried-Rice-664553.jpg  <ol><li>Cook the basmati rice WITH 4 cups water..</li><li>Meanwhile, IN a saucepan ADD the oil AND fry the onions..</li><li>Once they turn soft AND translucent ADD the ginger garlic paste AND green chilies AND saute FOR a MINUTE ..</li><li> THEN ADD ALL the vegetables, salt AND pepper..</li><li>Sprinkle very little water AND allow the veggies TO cook FOR two minutes..</li><li>They should be half cooked..</li><li>Now ADD the soya sauce AND chili sauce..</li><li>Now ADD the cooked rice TO this vegetable mixture AND stir this mixture FOR a MINUTE OR two IN low flame..</li><li>Roast SOME cashews AND raisins IN ghee AND ALSO ADD them..</li><li> IF you dont LIKE the sweet taste you can omit the raisins..</li><li>Fried rice IS ready..</li><li>It tastes good WHEN served WITH gobi Manchurian..</li><li> OR just tomato sauce AND raita will DO ..</li></ol>  chinese  45  2  t  t  t  t
95  Salmon Fried Rice  https://spoonacular.com/recipeImages/salmon-fried-rice-667701.jpg  <p><strong>1</strong> Dissolve the brown sugar IN the soy sauce IN a small bowl.SET aside.</p><p><strong>2</strong> Heat the olive oil IN a LARGE saut� pan OR wok ON medium high heat.ADD the diced red onion AND bell pepper AND saut� UNTIL lightly browned, about 5 minutes.Lower the heat TO medium AND stir IN the garlic AND grated ginger.Cook FOR a MINUTE more.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-1.jpg" alt="salmon-fried-rice-method-600-1"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-2.jpg" alt="salmon-fried-rice-method-600-2"></p><p><strong>3</strong> ADD the beaten eggs AND stir UNTIL just cooked.ADD the cooked rice, increase the heat TO medium high AND cook FOR a couple minutes more, stirring often.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-3.jpg" alt="salmon-fried-rice-method-600-3"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-4.jpg" alt="salmon-fried-rice-method-600-4"></p><p> ADD the peas, salmon, AND green onions.(Be gentle WITH the salmon so you don''t break it up too much.) Stir IN the soy sauce mixture AND remove FROM heat.</p><p><img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-5.jpg" alt="salmon-fried-rice-method-600-5"> <img src="http://www.simplyrecipes.com/wp-content/uploads/2015/05/salmon-fried-rice-method-600-6.jpg" alt="salmon-fried-rice-method-600-6"></p><p>Garnish WITH cilantro TO serve, serve immediately.</p>  chinese  25  4  f  f  t  t
96  Mango Fried Rice  https://spoonacular.com/recipeImages/mango-fried-rice-716311.jpg  Wash your rice AND bring TO boil ON medium heat WITH very little water AS you are still going TO cook it IN chicken stock.Once the rice IS slightly soft AND the initial water has dried up, reduce the heat AND pour IN the chicken stock AND cook till the chicken stock IS ALL absorbed AND has dried up.The chicken stock IF freshly made will have SOME oil FROM the chicken so your rice does NOT need oil.Increase the heat AND stir IN the chopped vegetables AND pepper.ADD your seasoning CUBE.Finally stir IN your cubed mango AND serve warm WITH ANY protein OF your choice.I�d say chicken but it�s up TO you.chinese  45  2  t  t  t  t
97  Cauliflower Fried Rice - More Veggies Than Rice (But Your Kids Won''t NOTICE )  https://spoonacular.com/recipeImages/cauliflower-fried-rice-more-veggies-than-rice-(but-your-kids-wont- NOTICE )-716426.jpg    chinese  45  2  t  t  t  t
98  Austrian Goulash  https://spoonacular.com/recipeImages/Austrian-Goulash-633063.jpg  <ol><li>You will need a LARGE Dutch oven WITH a lid FOR best results.ADD just enough olive oil TO coat the pan AND turn the heat high enough TO make the oil shimmer, but NOT smoke.</li><li>Pat the meat dry AND dredge IN flour, seasoned WITH kosher salt & cracked pepper.</li><li> ADD one piece OF meat TO the hot oil TO make sure that it sizzles.ADD the remaining meat, WITHOUT crowding the pan AND sear FOR about 3-4 minutes per side.You want a golden crust that will give the gravy great flavor.</li><li>Cook the meat IN batches, IF necessary AND SET aside IN a bowl-- to collect the juice.</li><li>When all the meat is seared, turn the heat to medium and add a little more olive oil to the pan and cook the onion until tender-- 3-4 minutes. Add the sliced garlic and cook till fragrant-- 30 seconds or so.</li><li>Add the tomato paste and paprika, and cook for 1-2 minutes.</li><li>Add the tomato sauce, caraway seeds, lemon zest and chicken stock and stir well.</li><li>Bring to a simmer for about 15 minutes and taste for seasoning. Adjust as necessary. If the sauce is too thick, thin with a little more chicken stock or water until it is the consistency of a gravy.</li><li>Simmer for 2 hours, or you can use a slow cooker for 4-6 hours.</li><li>This stew tastes even better if made one day in advance.  Serve or buttered egg noodles or spaetzle or Bavarian Bread Dumplings-- recipes coming soon to my blog!</li></ol>	easternEuropean	45	12	f	f	f	t
99  Beef Stroganoff WITH Bella Mushrooms  https://spoonacular.com/recipeImages/Beef-Stroganoff-w-Bella-Mushrooms-634699.jpg  <ol><li>1. Cut beef across grain INTO thin 2-inch strips OR PREFERRED sizes.FOR easier slicing, place beef IN the freezer FOR about an HOUR.Cut the onions INTO thin rings, mushrooms thinly sliced (decapping IS optional).</li><li>2. Cook beef strips IN non-stick pan OR skillet OVER medium heat FOR about 5 minutes OR UNTIL browned.ADD the mushrooms, onions, minced garlic, AND butter, stirring occasionally, UNTIL onions are tender.</li><li>3. Meanwhile, IN a sauce pan ADD the water AND beef stroganoff sauce packet, stir constantly TO avoid clumping.Cook according TO packet directions, WHILE adjusting the amount OF sour cream AND Worcestershire sauce according TO taste preference.FOR extra sauce, ADD IN beef broth OR water.</li><li>4. Stir IN the sauce WITH the beef mixture AND cook FOR another 5 minutes OR UNTIL sauce thickens up.</li><li>5. Top the sauce OVER the cooked egg noodles AND garnish WITH parsley flakes.Enjoy!</li><li>* FOR original beef stroganoff sauce, simply melt 1 tbsp butter IN pan OVER medium heat.ADD 2 tbsp flour.Cook 1 MINUTE, stirring WITH a whisk.Gradually ADD 1 cup beef broth AND 1 tbsp Worcestershire sauce, stirring constantly.Cook 1 MINUTE OR UNTIL thickened AND bubbly, stirring constantly TO avoid clumping.Remove FROM heat AND lastly ADD the sour cream.ADD salt AND pepper according TO taste.</li></ol>  easternEuropean  45  4  f  f  f  f
100  Buckwheat Blini  https://spoonacular.com/recipeImages/Buckwheat-Blini-636388.jpg  <ol><li> IN a LARGE bowl, combine buckwheat flour, ALL purpose flour, 1 tablespoon sugar, AND 1 teaspoon salt.IN a medium bowl, combine warm milk AND yeast, stirring UNTIL combined.Whisk IN egg yolks AND melted butter.ADD milk mixture TO dry ingredients AND stir just UNTIL combined.ADD beer, AND stir TO combine.</li><li> IN a LARGE bowl, combine egg whites, pinch OF salt, AND pinch OF sugar.Beat egg whites UNTIL soft peaks form.Gently, but thoroughly, fold egg whites INTO batter.Cover, AND let rise FOR 1 1/2 hours.</li><li>Heat a plett pan (Swedish pancake pan), which will keep your blini AT a uniform size, OR a skillet OVER medium heat UNTIL hot.Lightly oil pan AND, USING a 2-ounce ladle, pour batter INTO pan.Cook 45 seconds, turn, AND cook FOR an additional 30 seconds.</li><li>These can ALSO be baked:Heat oven TO 500 degrees TO 550 degrees.Use lightly oiled 2- TO 2 1/2-inch diameter nonstick pans.Bake 4 TO 5 minutes ON one side, turn, AND bake an additional 1 MINUTE.</li><li>Serve the blini WITH smoked caviar AND smoked salmon, AND top WITH creme fraIche AND lemon.</li><li>This recipe yields 20 blini.</li><li>Yield:20 blini</li></ol>  easternEuropean  45  1  f  f  f  f
101  Duck Egg Omelette WITH Caviar AND Sour Cream  https://spoonacular.com/recipeImages/Duck-Egg-Omelette- WITH -Caviar- AND -Sour-Cream-641700.jpg  <ol><li>An omelette pan WITH a 15cm (6") base.</li><li>Make the omelettes one at a time.</li><li>Mix 2 eggs in a bowl with half the water, salt & pepper & beat lightly.</li><li>Melt some butter in pan over moderately high heat.</li><li>Add eggs when it is foaming.</li><li>Leave for a few seconds, then tilt pan & with a fork draw the egg from the edges into the centre so that the liquid egg flows into the space.</li><li>Continue for about 30 seconds until almost all the liquid egg has gone.</li><li>Then roll the omelette rather like a spring roll, tipping it onto a warm dinner plate.</li><li>Using a small sharp knife, make a slit down the centre of the omelette, spoon over some of the sour cream, top with half of the caviar, scatter with a little dill and serve immediately.</li><li>Make the 2nd omelette in the same way.</li></ol>	easternEuropean	45	2	f	f	t	f
102  Easy Weeknight Beef Stroganoff  https://spoonacular.com/recipeImages/Easy-Weeknight-Beef-Stroganoff-642147.jpg  <ol><li> IN a LARGE skillet  brown the steak AND onions ON medium high x 4 minutes.ADD mushrooms AND cook FOR another 2-3 minutes.</li><li>Stir IN water AND bring TO a boil.ADD the noodles AND bring TO a boil again.Reduce TO simmer AND cook x 7 minutes UNTIL the noodles are done.</li><li> ADD the other ingredients, simmer UNTIL velveeta IS melted.Adjust salt AND pepper TO taste.</li></ol>  easternEuropean  45  8  f  f  f  f
103  German Goulash  https://spoonacular.com/recipeImages/German-Goulash-644476.jpg  <ol><li>Cut roast IN 1 inch cubes.IN Dutch oven, brown meat, AND onions IN oil.ADD water, bouillon cubes, flour, tomato sauce, paprika, AND pepper.Simmer low FOR 2 hours, UNTIL meat IS tender.</li><li>Serve OVER egg noodles.</li><li>This dish cooks up very well IN a crock pot.</li></ol>  easternEuropean  45  4  f  f  f  t
104  Hungarian Beef Goulash  https://spoonacular.com/recipeImages/Hungarian-Beef-Goulash-647645.jpg  <ol><li> IN a 3 1/2, 4 OR 5 quart crockery cooker, place potatoes, onions AND garlic.</li><li> ADD beef.IN a bowl combine broth, undrained tomatoes, tomato paste, paprika, caraway OR fennel seed AND salt.Pour OVER ALL.cover;
cook ON low heat setting FOR 10-12 hours OR ON high heat setting FOR 5-6 hours.Stir thawed artichoke hearts INTO cooker.Cover AND let stand FOR 10 minutes.Serve OVER hot cooked noodles.Top EACH serving WITH a spoonful OF sour cream.</li><li>Makes 6 servings.</li></ol>  easternEuropean  45  6  f  f  f  f
105  Hungarian Goulash Soup  https://spoonacular.com/recipeImages/Hungarian-Goulash-Soup-647656.jpg  <ol><li>Heat butter IN LARGE pan AND fry onion UNTIL golden brown.</li><li> ADD meat AND fry 5 more minutes.</li><li> ADD carrot, green pepper, tomatoes, paprika, salt, pepper, AND garlic salt.Stir well.</li><li> ADD 3/4 pint water, cover AND simmer FOR 1 HOUR, adding more water, IF necessary.</li><li> BEFORE serving, ADD cream.FOR variation, ADD a pinch OF cumin AND 2 cubed, peeled potatoes FOR the LAST 30 minutes OF cooking.</li></ol>  easternEuropean  45  2  f  f  t  f
106  Hungarian Plum Dumplings  https://spoonacular.com/recipeImages/Hungarian-Plum-Dumplings-647659.jpg  <ol><li>Go TO my blog FOR the FULL instructions:http://gourmandelle.com/hungarian-plum-dumplings- WITH -vegansugar-free- VERSION /</li></ol>  easternEuropean  45  25  t  f  f  t
107  Hungarian Potato Soup  https://spoonacular.com/recipeImages/Hungarian-Potato-Soup-647661.jpg  <ol><li> IN soup pot, saute celery AND onions IN oil UNTIL limp.ADD TO soup pot:parsley, potatoes, pepperoni chunks, pepper corns, Bay leaves AND 2 quarts OF water.</li><li>Simmer slowly FOR AT least one HOUR, UNTIL potatoes are soft.</li><li> ADD the 3 Tbsp.OF vinegar.Taste AND IF soup does NOT have enough salt, ADD TO taste.WHILE soup IS simmering, break 6 raw eggs, one egg AT a TIME, INTO the pot.Space them so they will cook TO a firm stage, WITHOUT touching one another.</li><li> DO NOT stir soup! Serve soup, eggs AND chunks OF sausage IN EACH soup plate.Put a heaping tablespoon OF sour cream IN EACH plate.Serve WITH good bread.</li><li>Serves 6.</li></ol>  easternEuropean  45  6  f  f  t  f
108  Hungarian Pot Roast  https://spoonacular.com/recipeImages/Hungarian-Pot-Roast-647662.jpg  <ol><li> AND Jars"</li><li>Trim excess fat off meat. Sprinkle with paprika, salt and pepper. Brown in oil in Dutch oven over medium heat. Add water and bay leaf; simmer, covered, 2 hours, or until meat is almost tender. Place onions and carrots around meat. Add Hunt''s tomato sauce, garlic and onion salt. Cover; simmer 50 minutes longer until meat and vegetables are tender. Just before serving, remove from heat and gradually stir in sour cream, if desired.</li></ol>	easternEuropean	45	1	f	f	t	f
109  Kielbasa WITH Brussels Sprouts IN Mustard Cream Sauce  https://spoonacular.com/recipeImages/Kielbasa- WITH -Brussels-Sprouts- IN -Mustard-Cream-Sauce-648895.jpg  <ol><li>Peel the shallot AND cut INTO quarters.Make a small pouch OUT OF aluminum foil (2 layers thick) AND place inside the shallot AND garlic.Coat WITH olive oil AND a generous pinch OF salt.Seal the pouch tightly AND place IN the oven (I recommend the toaster oven) AT 400F FOR 30 minutes.</li><li>Rinse AND pick clean the brussels sprouts.Cut EACH sprout IN half, discarding ANY wilted OR fugly OUTER leaves.Steam ( OR boil, your choice) the brussels sprouts UNTIL tender WHEN pierced WITH a fork.SET aside.</li><li>Rinse AND drain the beans.Honestly, 1 can IS a little too bean-heavy.You may want TO save about 1/3 OF the beans FOR something ELSE.I know, Im telling you now AFTER youve bought a whole can, AS opposed TO buying 2/3 OF a can.</li><li> SLICE the kielbasa ON a steep bias INTO 1/4 slices.Heat 1 tsp.OF olive oil IN a LARGE, heavy bottomed non-nonstick skillet OVER medium high heat.Arrange the kielbasa slices AND fry UNTIL crispy ON EACH side, about 3 minutes per side.Itll smell LIKE bacon, confusing your dog.SET aside (the kielbasa, NOT your dog) ON paper towels TO drain.</li><li> IF your skillet IS FULL OF porky goodness, keep it there.ADD a generous tablespoon OF good olive oil AND keep the heat AT medium high.Unwrap the garlic AND shallot AND smash them USING the flat side OF your knife.They should be very soft.ADD them TO the skillet AND cook FOR about 1 MINUTE.</li><li> ADD the mustard AND cream TO the skillet AND stir TO combine.Reduce the heat TO medium low AND ADD the brussels sprouts AND beans ( AS many AS you want TO use).Toss everything together TO coat, THEN season TO taste WITH a generous amount OF salt AND black pepper.</li><li>Plate the kielbasa ON top OF your brussels sprouts AND beans IN a LARGE bowl TO serve.</li></ol>  easternEuropean  45  4  f  f  t  f
110  Salmon, Watercress, Fennel AND Baby Beetroot Salad WITH Lemony Caviar Dressing  https://spoonacular.com/recipeImages/Salmon--Watercress--Fennel-and-Baby-Beetroot-Salad-With-Lemony-Caviar-Dressing-659143.jpg	<ol><li>Place the salmon in a pan, cover with water, and add the wine, bay and tarragon stalks.  Bring to the boil and then immediately turn off and leave for a couple of minutes to cook in the residual heat. Remove to a plate with a slotted spoon and leave to cool before flaking into large pieces.</li><li>Make the dressing by lightly whisking the olive oil and lemon juice together. Stir in the Arnkha MSC and season with some black pepper.</li><li>Next, arrange the watercress, beets and fennel in 4 shallow salad bowls, then add the salmon and tarragon.  Drizzle over the Arnkha MSC dressing and serve.</li></ol>	easternEuropean	45	4	f	f	t	t
111  Transylvanian Goulash  https://spoonacular.com/recipeImages/Transylvanian-Goulash-663792.jpg  <ol><li>Wash sauerkraut under cold running water THEN soak IN cold water FOR 20 minutes TO reduce sourness.Strain well, pressing OUT excess water.</li><li>NOTE:I am a big fan OF searing meat, because I think it gives sauces a deeper flavor.WHILE the original recipe didn''t say TO DO this-- I plan to sear the pork in some olive oil and then to continue with cooking the onion and garlic and carrying on with the rest of the steps.</li><li>Melt butter in a 5-quart casserole; add the onions. Cook over medium heat, stirring occasionally until lightly colored, 6 to 8 minutes.</li><li>Add the garlic, season with salt and cook a minute or two longer.</li><li>Stir in paprika, pour in 1/2 cup of broth and bring to boil.</li><li>Add the pork cubes. Spread sauerkraut over pork sprinkle with caraway seeds. Combine tomato puree, tomato paste and reserved broth, in a small bowl. Mix well and pour over sauerkraut. Bring to a boil.</li><li>If using a crock-pot, transfer contents of casserole to crock-pot insert. Cover, and cook on high, for 3 to 3-1/2 hours, or until pork is fork tender but still retains its shape.</li><li>If using a conventional oven, preheat to 250 degrees F. Cover casserole and transfer to the oven. Cook, covered, for 3 to 3-1/2 hours, or until pork cubes are tender but still retain their shape.</li><li>When the pork is tender, transfer meat and sauerkraut to a serving platter with high sides. Tent with foil to keep warm.</li><li>Transfer the sauce to a 2-quart pan. Set over medium heat. Combine flour, heavy cream and sour cream in a small bowl. Whisk until smooth. Stir mixture into sauce and simmer for 10 minutes longer. Do not boil. Season to taste with salt and pepper. Pour over meat and serve. Pass additional sour cream as a side.</li><li>NOTES: I added 2 Tablespoons of tomato paste to this recipe, which we thought gave the sauce deep depth of flavor. We also served this over creamy mashed potatoes. This freezes really well.</li></ol>	easternEuropean	45	8	f	f	f	f
112  Turkey Goulash  https://spoonacular.com/recipeImages/Turkey-Goulash- BY -Mommie-Cooks-664031.jpg  <ol><li> IF you''re USING ground turkey, START OUT BY browning it up, THEN adding IN your garlic, onion, AND pepper.Cook it FOR 3-4 minutes.IF you''re USING leftover cooked turkey, cook up the garlic, onion, AND pepper IN a tablespoon OF oil FOR 3-4 minutes ON medium heat AND THEN ADD IN the turkey.</li><li> NEXT you''ll ADD IN your spices;
the garam masala, paprika, cumin, ginger, curry AND coriander.ADD IN your tomatoes AND stir it ALL together.</li><li> NEXT up you''ll ADD IN the stock AND let it cook ON medium heat FOR about 5 minutes.</li><li> ADD IN your spinach AND give it a whirl OR two UNTIL it heat up AND wilts down INTO your meal.</li><li>Now stir IN your cup OF sour cream.</li><li>The final step IS TO ADD IN your noodles.</li></ol>  easternEuropean  45  6  f  f  f  f
113  Chocolate Crepes Cake  https://spoonacular.com/recipeImages/Chocolate-Crepes-Cake-472333.jpg  <p style="margin-left: 120px;"><em><span></span></span></span></span></span></span></span></span>Quick AND Easy Desserts</span></em></p><p><u>Making Crepes</u> :</p><div><br><div>Achieve 16 crepes AS follows:<br><p> PREPARE a hazelnut butter, that IS TO say, cook the butter IN a saucepan OVER high heat FOR 1 MINUTE, they will become brown.</p><p> IN a bowl, ADD the flour, salt, sugar AND form a fountain.Break the eggs IN the center AND mix gently pouring the milk gradually.ADD the hazelnut butter AND mixture together UNTIL it smooth dough, THEN let it sit FOR about 1 HOUR.</p><div> IN a hot crepe pan (the same diameter AS the cake pan used TO mounting<br><div> the cake), pour a ladle OF batter INTO the pan<br><div> AND cook FOR about 2 minutes ON EACH side ( BY monitoring the color).<br><div> THEN let them cool.</div></div></div></div><p><br><u> FOR Filling</u> :<br><br>Melt the chocolate AND butter IN a DOUBLE boiler.WHEN they are still warm, ADD the sugar.ADD Nutella AND mix well, THEN ADD the egg AND egg yolks AND mix well again.</p><p><br><u> FOR the Chocolate Glaze</u> :</p><div>Preheat oven TO 180 ° C (th.6-7).<p> IF necessary, cut the crepes the same size AS the cake pan.butter the sides OF the cake pan AND put a CIRCLE OF baking parchment paper ON the bottom.</p><p> START BY putting down one crepe, AND THEN cover it WITH chocolate mixture.THEN put again another crepe AND chocolate, AND so ON up the cake pan.Finish WITH a crepe.</p><div>Bake FOR 15 minutes, AND THEN cool almost completely BEFORE unmolding ON a platter.<p>Frost the chocolate cake</p><div> AND decorate WITH the chips chocolate FOR example.<div>That''s ALL IF you want TO make a <a href="http://www.qaedesserts.com/"><em>Quick AND Easy Desserts</em></a><p>Notes :</p><p><em>"if you want </em><em>stands well </em><em>your cake, make enough pancakes."</em></p><p><em>More Recipes here :</em>http://www.qaedesserts.com</p></div></div></div></div></div></div>  french  120  6  f  f  f  f
114  Baked Ratatouille  https://spoonacular.com/recipeImages/Baked-Ratatouille-633754.jpg  <ol><li>Heat oil IN a heavy, LARGE Dutch oven OVER medium heat.ADD garlic;
stir 1 MINUTE.ADD eggplant, green bell peppers, tomatoes, onion, zucchini AND basil.Saute FOR 5 minutes.Cover AND simmer UNTIL ALL vegetables are tender, stirring occasionally, about 25 minutes.</li><li>Uncover pot AND simmer UNTIL juice thickens, stirring occasionally, about 10 minutes.Mix IN vinegar;
season TO taste WITH salt AND pepper.</li><li>Preheat oven TO 350 degrees.Spread IN 9-inch pie dish.Sprinkle WITH cheese, IF desired.Bake UNTIL heated through, about 20 minutes.</li><li>This recipe yields about 3 cups.</li><li>Yield:3 cups</li></ol>  french  45  1  t  f  t  f
115  Banana Crepes  https://spoonacular.com/recipeImages/Banana-Crepes-634068.jpg  <ol><li>Make Batter:IN a medium mixing bowl, mix the egg, milk AND sugar together, SET aside.IN a small mixing bowl, combine flour, spices AND salt.Pour the flour mixture INTO the egg AND milk mixture AND whisk rapidly.Pour IN melted butter AND stir.SET aside.</li><li>Make Crepes:Place 2 teaspoons OF butter INTO a medium non-stick pan OVER high heat.WHEN butter begins TO melt, use a heat resistant spatula TO spread it around the saut pan.Pick up the saut pan TO guide the melting butter around IN a circular motion.WHEN it looks LIKE pan IS almost smoking hot, ADD one ladle OF batter, (approximately 4 ounces) AND pick up the saut pan TO CREATE a circular motion again TO coat the pan WITH batter.Let batter cook FOR 25-30 seconds AND THEN use spatula TO scrape along the edges AND underneath the crepe.Flip crepe AND cook FOR another 25 seconds.Crepe should have a golden color, but NOT too tan.Place crepe onto a 3Make Filling:melt butter AND brown sugar IN a medium saute pan OVER medium high heat AND stir.ADD sliced bananas, stir AND coat WITH brown sugar AND butter.Taste FOR seasoning, may need TO ADD salt.ADD optional cream AND stir.Keep warm.</li><li>Make Filling:melt butter AND brown sugar IN a medium saute pan OVER medium high heat AND stir.ADD sliced bananas, stir AND coat WITH brown sugar AND butter.Taste FOR seasoning, may need TO ADD salt.ADD optional cream AND stir.Keep warm.</li><li>Assemble Crepes:Preheat the oven TO 300F degreesAdd approximately half cup OF filling INTO EACH crepe, roll AND place IN a warm place, OR onto a baking sheet TO heat ALL the crepes AT one TIME.Once ALL the crepes are  asembled, top WITH a dollop OF whip cream AND a sprinkle OF powdered sugar, cinnamon AND nutmeg.</li></ol>  french  45  1  t  f  f  f
116  Beef Bourguignon Pie WITH Mushy Green Pea  https://spoonacular.com/recipeImages/Beef-Bourguignon-Pie- WITH -Mushy-Green-Pea-634585.jpg  <ol><li>Making beef bourguignon</li><li>Cook bacon ON medium heat UNTIL crispy.Absorb the excessive fat WITH paper AND rest</li><li> IN the same pan, ADD onions AND cook UNTIL browned (approx.3-5 minutes) AND remove FROM pan</li><li> ADD olive oil onto the same pan, cook mushrooms UNTIL browned AND remove FROM pan</li><li> IN the same pan, cook beef UNTIL browned.THEN ADD cooked bacon AND onions together WITH thyme AND tomato paste.Stir fry UNTIL well combined.</li><li> ADD wine AND stock IN AND bring it TO boil.Reduce TO low heat AND let it simmer (covered) FOR 1 HOUR </li><li> ADD cooked mushrooms AND CONTINUE TO let it simmered (uncovered) UNTIL beef IS tender (approx.40-45 minutes).THEN ADD IN the parsley.</li><li>Making puff pie lid</li><li>Preheat the oven TO 200'' C (390''f) fan forced</li><li>Cut the puff pastry sheet TO fit your baking dishes.Use cookie cutters TO make creative shapes TO decorate your puff pie lid such AS flowers OR alphabets OR words (e.g.NAME, love etc).Bake the pastry ON oil sprayed tray UNTIL light golden browned (5-10 minutes).Your tray must be AT the middle OF your fan oven.</li><li>Making mushy pea</li><li> ON medium heat, cook onion UNTIL light golden browned.</li><li> ADD cream AND stock AND bring TO boil.Reduce heat TO low AND let it simmer FOR a few minutes.</li><li>Turn the heat OFF AND mash it WITH folk gently.Season WITH salt AND pepper.</li><li> TO serve, spoon the beef bourguignon onto a baking dish (microwaved so it IS warm).CLOSE WITH the puff pie lid AND serve WITH mushy green pea IN another baking dish.</li></ol>  french  45  2  f  f  f  f
117  Braided Brioche  https://spoonacular.com/recipeImages/Braided-Brioche-635785.jpg  <ol><li>1. ADD ingredients TO bread machine pan according TO manufacturer''s directions.</li><li>2. SELECT sweet OR dough CYCLE.</li><li>3. AT the END OF the CYCLE, scrape the dough onto a board lightly coated WITH ALL -purpose flour.Divide dough INTO 3 equal pieces.IF making a 1 1/2-pound loaf, roll EACH piece TO form a rope about 12 inches long.FOR a 2-pound loaf, roll EACH piece TO form a rope about 14 inches long.Lay ropes parallel about 1 inch apart ON a buttered 14 x 17 inch baking sheet.Pinch ropes together AT one END, braid loosely, THEN pinch braid END together.</li><li>4. Cover loaf lightly WITH plastic wrap AND let stand IN a warm place UNTIL puffy, about 35 minutes.Remove plastic wrap.</li><li>5. Beat 1 LARGE egg yolk TO blend WITH 1 tablespoon water.Brush braid WITH egg mixture.</li><li>6. Bake braid IN a 350 F oven UNTIL golden brown, about 30 minutes.Cool ON a rack AT least 15 minutes BEFORE slicing.Serve hot, warm, OR cool.</li></ol>  french  45  1  f  f  f  t
118  Classic French Mussels  https://spoonacular.com/recipeImages/Classic-French-Mussels-Done-Light-639599.jpg  <ol><li>Scrub mussels WITH a stiff brush, DISCARD ANY that are OPEN AND stay that way even WHEN you CLOSE the shell.DISCARD ANY WITH broken shells.</li><li>Soak them IN cool clean water FOR AT least an HOUR.Mussels are alive AND breathing AND have taken IN sand OVER TIME.This allows them TO expel the sand.</li><li>Mussels have a small fibrous "beard" that should be removed.Pull it OUT toward the hinge OF the shell TO keep FROM injuring the mussel.</li><li>Heat the olive oil IN a LARGE pot OVER medium-high heat.ADD the shallots AND garlic AND cook UNTIL soft, about 5 minutes.ADD the mussels, wine, buttermilk, butter, AND parsley AND season well WITH the kosher salt.Give it a good stir, cover the pot, AND cook UNTIL mussels OPEN AND are cooked through, 10 TO 15 minutes.Divide the mussels AND the juices BETWEEN 2 bowls AND serve WITH a crusty whole-grain bread TO sop up that wonderful sauce.</li></ol>  french  45  2  f  f  t  f
119  Creamy Ratatouille OVER Penne  https://spoonacular.com/recipeImages/Creamy-Ratatouille-640693.jpg  <ol><li>Heat olive oil IN a LARGE skillet OVER medium heat.ADD onion, bell pepper, AND zucchini AND saut FOR about 7 minutes, stirring occasionally, UNTIL slightly softened.</li><li> ADD eggplant AND CONTINUE TO saut mixture FOR another 3 minutes, stirring frequently.WHEN vegetables are softened, ADD garlic AND cook UNTIL fragrant, about 1 MINUTE.</li><li> ADD dried spices, salt, AND pepper, followed BY the tomato sauce AND water.Allow mixture TO come TO a simmer AND cook FOR 5 minutes, UNTIL slightly thickened.</li><li>Stir IN mascarpone cheese AND serve immediately.</li></ol>  french  45  2  t  f  f  f
120  Crock Pot Shredded French Dip  https://spoonacular.com/recipeImages/Crock-Pot-Shredded-French-Dip-640869.jpg  <ol><li>Place beef IN crock pot.ADD beef broth, garlic, onion, Italian seasoning, ground mustard, AND pepper.</li><li>Turn ON low FOR 7 hours.</li><li>Take OUT AND place ON cutting board.USING a fork, shred the beef.Strain au jus (broth FROM crock pot) so that there are NO LARGE chunks.</li><li> SLICE rolls IN half.Place OF the beef ON EACH roll.Place au jus IN 4 small individual bowls.Serve sandwiches AND au jus together.</li></ol>  french  450  4  f  f  f  t
121  Dulce De Leche Creme Brulee  https://spoonacular.com/recipeImages/Dulce-De-Leche-Crme-Brle-641727.jpg  <ol><li>Oven:325F</li><li>Place six ramekins IN a water bath.Whisk eggs AND sugar UNTIL pale, THEN slowly pour the hot cream INTO the yolks, whisking thoroughly.Pour custards INTO ramekins AND bake ~35 min.UNTIL SET.Chill AT least 3 hours BEFORE serving.</li><li> TO serve, sprinkle ~2 tsp sugar evenly OVER EACH custard AND heat WITH a kitchen torch UNTIL a burnt crust forms atop EACH custard.</li></ol>  french  45  1  t  f  t  f
122  Dunkin French Onion Soup  https://spoonacular.com/recipeImages/Dunkin-French-Onion-Soup-641744.jpg  <ol><li> IN a soup pot melt the 4 Tbs.OF the butter WITH the oil, saut the onions UNTIL just slightly caramelized, this will take about 20 minutes.WHEN tender AND a golden rich color ADD IN the chicken AND beef stock along WITH the pepper, Montreal steak seasoning AND 1  Tbs.OF the Johnny''s garlic, simmer the soup FOR another 15 minutes.IN the mean TIME use the remaining butter AND Johnny''s TO turn your French bread INTO garlic bread, place onto a baking sheet AND cook IN a 350 degree oven just UNTIL the butter mixture has melted.Once the bread IS ready remove the tray FROM the oven AND turn the oven TO broil, top EACH SLICE OF bread </li></ol>  french  45  1  f  f  f  f
123  Easy Beef Bourguignon  https://spoonacular.com/recipeImages/Easy-Beef-Bourguignon-641842.jpg  <ol><li>Cut your vegetables AND SET aside (put mushrooms IN a separate bowl).</li><li>Cut beef INTO bite size AND put IN a bowl.Sprinkle flour OVER AND toss the meat around TO coat lightly.WITH a LARGE pot OVER high heat, ADD 1 tbsp olive oil.Wait FOR about a MINUTE UNTIL the pot IS really hot AND ADD your beef (otherwise your meat will stay a grey color INSTEAD OF a nice golden brown.IF you DO NOT have a LARGE pot, DO your beef IN batches so AS NOT TO crowd the pot).Cook FOR about 5 minutes AND turn the meat OVER.Cook FOR another 3-4 minutes UNTIL you GET a nice color AND remove FROM the pot ( DO NOT turn OFF the heat).Put aside IN a bowl.</li><li> ADD 1 tbsp olive oil TO the pot AND ADD onions, carrots, thyme AND rosemary.Cook FOR about 7 minutes (stir frequently TO keep the bottom OF the pot FROM burning).Put the meat back IN the pot AND ADD wine.Bring TO boil, lower the heat AND simmer FOR 5 minutes.ADD bay leaf, cayenne pepper, beef broth, AND bring TO boil.Lower the heat, cover, AND simmer FOR 20 minutes.</li><li> ADD mushrooms AND simmer FOR 30 minutes.Remove bay leaf, season WITH salt AND pepper, AND serve.</li></ol>  french  45  4  f  f  f  t
124  Leek AND Gruyere Quiche  https://spoonacular.com/recipeImages/Leek- AND -Gruyere-Quiche-649434.jpg  <ol><li>Make crust IN a food processor.Place flour AND salt IN WORK bowl.ADD butter pieces AND sour cream.Pulse TO combine.WITH machine running, drizzle IN ice water UNTIL a ball forms.Flour a WORK surface AND roll OUT INTO a 12 inch round.Quickly foldinto quarters AND gently lay IN an 11 inch shallow, tin fluted tart pan;
press INTO pan.Place IN freezer 15 minutes (can be LEFT frozen FOR up TO a MONTH ).Preheat oven TO 400 degrees.Place a layer OF foil ON top OF crust AND fill WITH dried beans.Prebake 15 minutes TO 18 minutes, UNTIL just pale golden.Red</li><li>Place leeks AND 1/4 cup water IN a LARGE skillet.Heat OVER medium-high heat AND cook a few minutes TO sweat ( NOT brown them) UNTIL water evaporates AND leeks are tender.SET aside TO cool.</li><li> IN a mixing bowl, combine milk, cream, eggs AND seasoning.Beat WITH a whisk TO combine.ADD cheese.Place cooked leeks INTO prebaked shell AND gently pour IN custard.Immediately place IN oven AND bake 20 minutes TO 25 minutes UNTIL puffed, brown AND SET.Cool 10 minutes AND serve hot, OR cool TO room temperature.</li></ol>  french  45  1  f  f  f  f
125  Leek, Mushroom, AND Bacon Quiche  https://spoonacular.com/recipeImages/Leek--Mushroom--and-Bacon-Quiche-649450.jpg	<ol><li>Preheat your oven to 400.</li><li>Dump flour, salt, and sugar into a food processor.</li><li>Pulse to combine.</li><li>Add cubes of butter straight from the freezer.</li><li>If your processor has a feed tube, pour the water through while it is running.</li><li>Chill the dough for an hour or so</li><li>Roll it out on a floured surface</li><li>Gently work it into the tart pan.</li><li>Line it with foil and pierce holes all over with a fork.</li><li>Place pie weights or dry beans in the foil</li><li>Blind bake for 8 to 9 minutes.</li><li>When done, lower the baking temperature to 375.</li><li>Fry up the bacon until crispy in a large saucepan.</li><li>Set aside.</li><li>Saute the leek in melted butter and leftover bacon fat over medium heat.</li><li>When they are translucent and fragrant, sprinkle in salt and pepper and add sliced mushrooms.</li><li>Allow the mushrooms to absorb excess fat and heat through. When they are finished, set aside.</li><li>Now whisk together eggs and milk.</li><li>Add salt, pepper, and leek and mushroom mixture.</li><li>Lay the slices of potato on the bottom of the tart pan.</li><li>Pour into the tart crust and top with parmesan shavings.</li><li>Bake for 20-35 minutes.</li></ol>	french	45	1	f	f	f	f
126  Party Quiches  https://spoonacular.com/recipeImages/Party-Quiches-654744.jpg  <ol><li>This recipe describes four quiches WITH different fillings.IF PREFERRED, one single filling may be chosen, but the ingredients must be multiplied BY four.</li><li>1. Salmon WITH Broccoli AND Stilton</li><li>2. Salmon WITH Asparagus AND Cheddar</li><li>3. Salmon AND Mozzarella</li><li>4. Salmon WITH Tomatoes AND Feta Cheese</li><li>Pre-heat oven TO 200 C, 400 F, Gas mark 6. Drain the cans OF salmon.Flake AND SET aside.</li><li>Divide the pastry INTO four AND roll OUT TO LINE four 22.5 cm / 9inch flan dishes.Spread the salmon evenly OVER the base OF EACH flan.</li><li>Arrange the broccoli IN one flan, the asparagus IN another, AND the leeks AND tomatoes IN the other two.Sprinkle the spring onions OVER the asparagus quiche, onion OVER the broccoli, smoked salmon INTO the leeks AND olives INTO the tomato.</li><li>Top the broccoli quiche WITH Stilton, the asparagus WITH Cheddar, the leek quiche WITH Mozzarella AND the tomato WITH Feta cheese AND pesto.Beat the remaining ingredients AND pour INTO EACH flan.Bake FOR 10 minutes.Reduce the temperature TO 160 C, 325F, Gas mark 3 AND cook FOR 40 minutes.Serve WITH salad.</li><li>Makes 4, serves 24-32. Approx.255 kcals per serving</li></ol>  french  45  4  f  f  f  f
127  Ratatouille Pasta  https://spoonacular.com/recipeImages/Ratatouille-Pasta-657933.jpg  <ol><li>Saute the yellow onion IN a LARGE skillet OR saute pan WITH enough Olive oil TO coat the bottom OF the pan, OVER medium-low heat UNTIL tender AND translucent.Season WITH salt AND pepper.ADD garlic, saute UNTIL fragrant.</li><li> ADD another tablespoon OF Olive oil AND the zucchini, eggplant AND Italian seasoning.CONTINUE sauteing UNTIL the zucchini AND eggplant START TO break down AND become limp AND tender.</li><li> ADD the artichokes AND tomatoes.Season WITH salt AND pepper.Bring TO a simmer FOR ten - fifteen minutes.Taste AND re-season IF needed.</li><li>Meanwhile cook the spaghetti TO al dente according TO package directions.</li><li>Toss WITH pasta AND serve WITH a drizzle OF extra-virgin Olive oil AND Parmesan cheese.</li></ol>  french  45  4  f  f  f  f
128  Ratatouille WITH Brie  https://spoonacular.com/recipeImages/Ratatouille- WITH -Brie-657939.jpg  <ol><li>Remove OUTER peel FROM eggplant AND dice INTO inch pieces</li><li>Heat 1-2 oz.OF olive oil IN a heavy gauge skillet</li><li>Saut the diced eggplant FOR 2-3 minutes THEN place ON a towel TO drain</li><li> AFTER draining place cooked eggplant INTO a small oval casserole dish</li><li>Preheat oven TO 375 F</li><li>Carefully SLICE the zucchini, yellow squash, AND tomatoes about  inch even slices</li><li> SLICE the Brie ALSO INTO inch slices (utilizing a cheese wire makes simplifies this)</li><li> BEGIN PLACING sliced yellow squash, zucchini, sliced Brie AND tomatoes IN a shingled pattern working FROM the outside OF the casserole towards the center</li><li> WHEN ALL vegetables AND cheese are placed IN the casserole, drizzle WITH the remaining olive oil AND sprinkle WITH chopped thyme</li><li>Season WITH salt AND pepper AND bake IN the oven FOR 10-15 minutes UNTIL bubbly</li></ol>  french  45  4  t  f  t  f
129  Roasted Ratatouille Gratin  https://spoonacular.com/recipeImages/Roasted-Ratatouille-Gratin-658641.jpg  <ol><li>Cut up everything AND SET aside UNTIL needed.DO the eggplant LAST, AS it turns brownish AFTER being cut.</li><li>Preheat oven TO 425 F.</li><li>Place whole red pepper ON a baking sheet AND roast FOR 20 minutes.</li><li>Spray another baking sheet WITH canola oil AND place eggplant ON it IN a single layer.</li><li>Drizzle WITH 2 tablespoons olive oil AND toss TO combine.Sprinkle WITH salt AND pepper.</li><li>Turn red pepper OVER AFTER 20 minutes.</li><li> ADD eggplant TO oven, AND roast UNTIL BOTH are tender, about 15 minutes more.</li><li> WHILE the eggplant AND pepper are roasting, heat 2 tablespoons olive oil IN a LARGE soup pot OVER medium heat.Stir IN leek AND shallot AND cook UNTIL softened, about 5 minutes.</li><li>Stir IN zucchini AND CONTINUE cooking, stirring occasionally, UNTIL zucchini IS soft, 6-8 minutes.</li><li>Stir IN mushrooms, 1 teaspoon salt, dash black pepper, AND wine.</li><li>Simmer UNTIL mushrooms are soft, about 8 minutes.</li><li>Remove eggplant AND pepper FROM oven.</li><li>Turn oven down TO 400.</li><li>Cover pepper WITH aluminum foil.Covering it creates steam that will loosen its skin, making the skin easier TO remove.Allow pepper TO cool about 10 minutes BEFORE handling.</li><li>Stir IN the eggplant, tomatoes AND their juices, thyme, AND rosemary.</li><li>Bring back up TO a simmer.</li><li> AFTER pepper has cooled, remove the skin, core, AND seeds.Chop flesh AND ADD TO the stockpot.</li><li>Simmer, covered, FOR 5 minutes TO combine flavors.</li><li>Taste, AND ADD salt AND pepper IF needed.</li><li>Pour everything INTO an 8x8 baking dish.</li><li>Top WITH Parmesan AND bread crumbs.</li><li>Bake UNTIL topping IS browned, about 20 minutes.</li><li>Allow ratatouille TO stand 10 minutes BEFORE serving.</li><li>Garnish EACH serving WITH fresh basil.Make sure TO have more freshly grated Parmesan ON hand TO pass AT the TABLE.</li></ol>  french  45  4  f  f  f  f
130  Salmon AND Broccoli Crepes  https://spoonacular.com/recipeImages/Salmon- AND -Broccoli-Crepes-659037.jpg  <ol><li>Combine milk, water, egg AND melted butter IN a small bowl.ADD flour AND salt AND whip UNTIL well blended.Allow TO sit FOR 10 minutes.</li><li>Steam broccoli UNTIL just tender, AND combine salmon, shallot, thyme, lemon juice, dijon AND 1/2 cup sour cream.Chop pieces OF salmon AND broccoli WITH a spoon IF you have extra LARGE pieces.Warm salmon mixture IN the microwave FOR 2 minutes.</li><li>Combine remaining sour cream AND lemon zest.</li><li>Heat a medium non-stick skillet OVER medium heat AND spray WITH cooking spray.ADD 1/4 cup crepe batter TO the pan AND swirl around TO CREATE an even pancake.Cook 1  2 minutes ON the FIRST side TO brown crepe, THEN flip AND brown the other side.Crepes cook quickly because they are so thin.Remove TO a plate AND keep warm.</li><li>Fill a crepe WITH 1/4 salmon lengthwise AND gently roll.SLICE IN half ON a diagonal AND top WITH a tablespoon OF sour cream AND lemon zest mixture.</li></ol>  french  45  4  f  f  f  f
131  Vegetarian Ratatouille  https://spoonacular.com/recipeImages/Vegetarian-Ratatouille-664689.jpg  <ol><li>Saute onion AND garlic IN a LARGE saucepan OVER medium low heat UNTIL onions are translucent.ADD tomatoes AND stir.ADD ALL the remaining ingredients AND cook FOR 30 minutes ON low stirring occasionally OR UNTIL eggplant IS tender.</li></ol>  french  45  6  t  t  t  t
132  Zucchini Quiche Appetizers  https://spoonacular.com/recipeImages/Zucchini-Quiche-Appetizers-665778.jpg  <ol><li>Preheat oven TO 350 degrees F.</li><li>Grease bottom AND sides OF rectangular pan 13 x 9 x 2.</li><li>Stir together ALL ingredients;
spread IN pan.</li><li>Bake about 40 minutes OR UNTIL golden brown.</li><li>Cut INTO 2" squares.  Cut squares diagonally in half into triangles.</li></ol>	french	45	1	f	f	f	f
133  Red, White AND Blue Crepes  https://spoonacular.com/recipeImages/red-white-blue-crepes-happy-july-4th-driscollsberry-716414.jpg    french  45  1  f  f  f  f
134  Muesli-Coated German TOAST https://spoonacular.com/recipeImages/muesli-coated-german- TOAST -149663.jpg  <p>I don''t know why French TOAST IS CALLED French TOAST TO BEGIN WITH, but since I''m living IN Germany I''m calling this variation German TOAST.START BY pre-heating your OVER TO 375 degrees F (about 190 degrees C ).</p><p>1. whisk together the eggs AND soy milk.ADD cinnamon AND nutmeg IF desired.</p><p>2. dip the toasted bread INTO the egg/soy milk mixture AND let soak FOR 30 seconds per side</p><p>4. dip the soaked bread INTO the muesli AND press gently TO coat</p><p>5. fry the slices IN oil OR butter IN a hot skillet UNTIL golden brown, 2-3 minutes per side</p><p>6. place the finished German toasts IN the oven FOR 5 minutes</p><p>Serve WITH maple syrup, honey, OR Nutella AND a fresh fruit salad.</p>  german  25  2  t  f  f  t
135  Nutella Banana Pancakes German Style  https://spoonacular.com/recipeImages/Nutella-Banana-Pancakes-German-Style-157514.jpg  <ol><li>Separate the egg whites FROM the yolks.</li><li>Beat the egg whites UNTIL they are stiff.</li><li>Mix egg yolks, flour, water, AND milk IN a big bowl UNTIL smooth.</li><li>Gently fold the stiff egg whites IN.</li><li>Heat a LARGE pan TO medium TO high heat WITH 1 tablespoon OF oil per pancake.Distribute about 1 ladle OF the batter IN the pan AND fry FOR about 2 minutes per side.</li><li> IF you don''t want TO eat-cook-eat-cook, you could pre-heat the oven AND make ALL the pancakes, keeping them warm IN the oven UNTIL ALL are PREPARED BEFORE you dig IN.</li></ol>  german  20  2  t  f  f  f
136  Brown Butter Spaetzle WITH Prosciutto AND Broccoli Rabe  https://spoonacular.com/recipeImages/Brown-Butter-Spaetzle- WITH -Prosciutto- AND -Broccoli-Rabe-636280.jpg  <ol><li>Put a LARGE pot OF salted water ON the stove AND OVER high heat TO boil.</li><li> IN a LARGE bowl, crack the eggs AND ADD milk, parsley, salt AND pepper AND mix UNTIL combined.ADD IN flour a little BIT AT a TIME AND mix UNTIL combined.The dough will be a BIT runny, AND this IS just fine.Let sit FOR 10 minutes TO rest.</li><li>Put a colander OR cheese grater OVER the pot OF boiling water AND spoon dough through holes.Youll have a bunch OF wiggly noodle nuggets that DROP INTO the pot.Cook these FOR 5 TO 6 minutes UNTIL just tender.Drain.</li><li>Melt butter IN a saut pan OVER high heat.WHEN butter starts TO separate AND brown, have your ingredients AT the ready.Youll know the butter IS ready TO go WHEN you START smelling a sweet, nutty aroma.</li><li>Dump IN the drained spaetzle, garlic, onion, pine nuts AND broccoli rabe.Cook IN browned butter FOR about 2 minutes, THEN remove FROM heat.Toss IN prosciutto AND top WITH a sprinkling OF Parmesan cheese AND lemon juice.Season WITH salt AND pepper, TO taste.</li></ol>  german  45  3  f  f  f  f
137  Frikadellen German Meat Patties  https://spoonacular.com/recipeImages/Frikadellen-German-Meat-Patties-643851.jpg  <ol><li>Peel AND dice the onions, THEN saute IN oil UNTIL transparent.ADD sauteed onions TO ground meat IN a mixing bowl.Stir together breadcrumbs AND milk AND ADD TO meat mixture.</li><li> ADD egg, basil, salt AND pepper AND mix well.Dampen hands AND form meat mixture INTO palm-sized patties.</li><li>Preheat non-stick skillet WITH a little oil.Pan-fry the meat patties OVER medium high heat UNTIL browned ON BOTH sides.Serve them WITH salad, fries AND tzatziki.Alternatively they can be served WITH German dumplings AND black pepper sauce.</li></ol>  german  45  18  f  f  f  f
138  German Lemon Cake WITH Cranberry aka Cranberry Zitronenkuchen  https://spoonacular.com/recipeImages/German-Lemon-Cake- WITH -Cranberry-Aka-Cranberry-Zitronenkuchen-644477.jpg  <ol><li>Grate the zest OF two lemons, careful that you are grating ONLY the coloured part OF the rind.AND squeeze the lemon TO EXTRACT 11 tablespoons OF juice.Grease AND flour a 32x11 cm loaf pan.Preheat the oven TO 180 C /350F.Whisk together the flour AND baking powder IN a bowl.</li><li>Cream the butter, sugar AND pinch OF salt WITH a hand-held beater UNTIL light AND fluffy.ADD IN eggs one AT a TIME, alternately mixing IN a tablespoon OF flour mixture AFTER EACH addition.Pour IN the whipping cream, AND THEN 8 tablespoons OF lemon juice AND finely grated zest.Fold TO combine.Sift IN the rest OF the flour mixture AND gently stir TO combine.Finally fold the dried cranberries INTO the batter.</li><li>Pour the batter INTO the PREPARED loaf pan.Place the pan ON the lower SECOND rack AND bake FOR about 80-90 minutes.AFTER 35 minutes, cover the cake WITH a foil greased WITH butter.Remove AND cool the cake IN the tin briefly.THEN remove the cake FROM the tin AND allow it TO cool completely.</li><li>Sift the powdered sugar IN a bowl AND ADD IN the rest OF lemon juice.Stir TO combine.Pour evenly OVER the cake.Allow the glaze TO SET BEFORE slicing AND serving.</li></ol>  german  45  8  f  f  f  f
139  German Meatloaf Falscher Hase  https://spoonacular.com/recipeImages/German-Meatloaf-Falscher-Hase-644482.jpg  <ol><li>Thoroughly mix ground meats, onion, bread crumbs, cold water, AND eggs.</li><li>Season the mixture WITH salt, paprika, mustard, AND parsley.Blend ingredients thoroughly AND shape INTO a loaf.</li><li>Place the loaf IN a baking pan AND bake IN a preheated oven FOR about 45 minutes.WHILE meat IS baking, gradually pour hot beef broth OVER the top OF the meatloaf AND basting occasionally.Serve WITH German bread dumplings.</li></ol>  german  45  4  f  f  f  t
140  German Rhubarb Cake WITH Meringue  https://spoonacular.com/recipeImages/German-Rhubarb-Cake- WITH -Meringue-644488.jpg  <ol><li>Preheat the oven TO 350F Convection.Grease a round 26 cm Spring pan (9 1/2 inch).</li><li>Wash, dry AND peel the rhubarb.Cut it IN little pieces, mix WITH 2 tablespoon OF sugar AND let sit FOR AT least 1/2 HOUR.It will EXTRACT a lot OF water that needs TO be drained.Pat rhubarb dry FOR further use.</li><li> IN a kitchen machine beat together butter, sugar AND vanilla EXTRACT UNTIL the butter IS fluffy AND the sugar IS dissolved.Put IN the eggs, one AT a TIME AND mix well.</li><li> IN a separate bowl sift together flour, ground almonds, salt AND baking powder, ADD slowly TO the egg mixture.Dont OVER mix.</li><li>Fill dough INTO the spring pan, top WITH dried rhubarb AND bake FOR 25 min.</li><li> IN the mean TIME PREPARE the meringue/ baiser topping.Beat egg whites UNTIL stiff peaks form.Slowly ADD the sugar UNTIL meringue IS firm AND shiny.</li><li>Spread the meringue evenly OVER the rhubarb AND decorate WITH almond slices.RETURN TO the oven FOR another 15 min.Cover the cake WITH aluminum foil AFTER 5 min.IN CASE the meringue does turn too dark.</li><li>Cool completely BEFORE removing the cake FROM the pan.</li></ol>  german  45  12  f  f  f  t
141  German White Chocolate Cake  https://spoonacular.com/recipeImages/German-White-Chocolate-Cake-644504.jpg  <ol><li>CAKE</li><li>1. POSITION the racks IN the upper AND lower thirds AND preheat oven TO 350 deg F.Lightly butter the bottom AND sides OF three 8 inch round cake pans.LINE the pans WITH parchment paper.Dust the bottom AND sides WITH flour;
tap OUT the excess.</li><li>2. INTO a medium bowl, sift the cake flour AND the baking soda.USING an electric mixer SET AT mdeium speed, cream the butter AND the sugar IN a LARGE bowl UNTIL light AND fluffy, about 5 minutes.Beat IN one egg yolk AT a TIME, blending well AFTER EACH addition.Beat IN the melted white chocolate mixture AND the vanilla.AT low speed, blend IN the sifted flour mixture alternately WITH the buttermilk;
DO NOT overbeat.Fold IN the coconut AND pecans.</li><li>3. Beat the egg whites UNTIL stiff peaks form.Blend 1/3 OF the egg whites INTO the cake mixture TO lighten it;
carefully fold IN the remaining egg whites.Spoon the batter INTO the PREPARED pans.</li><li>4. Bake UNTIL the cake springs back WHEN touched IN the center AND a cake tester inserted IN the center OF the pans comes OUT clean, about 35 TO 40 minutes.Transfer the cakes IN the pans TO wire racks AND cool 10 minutes.Invert the cakes onto the wire racks, carefully peel OFF the parchment paper, AND cool completely.</li><li> FOR THE FROSTING:5. IN a heavy medium saucepan OVER medium heat, combine the evaporated milk, sugar, butter, AND egg yolks.Simmer FOR 10 minutes, stirring constantly.DO NOT let mixture boil fast;
lower the heat IF necessary.</li><li>Remove FROM heat AND stir IN the vanilla, pecans, AND coconut.Plance the saucepan INTO a bowl filled WITH ice AND stir constantly UNTIL the frosting IS cool AND slightly thickened.</li><li>6. Place a cake layer ON a serving platter.Spread 1/4 OF the frosting evenly OVER the cake layer, making sure TO spread it ALL the way TO the edges.Top WITH the SECOND layer, AND spread WITH 1/4 OF the frosting.Top WITH the third cake layer.Evenly frost the top AND sides OF the cake WITH the remaining frosting.</li></ol>  german  45  6  f  f  f  f
142  Knockwurst WITH sauerkraut  https://spoonacular.com/recipeImages/Knockwurst- WITH -sauerkraut-648986.jpg  <ol><li>Butter a medium fry pan AND heat the wurst UNTIL brown, about 10-12 minutes.</li><li>Drain the sauerkraut, rinse, AND drain well.</li><li> IN a LARGE pot cook onion UNTIL onion IS tender but NOT brown.Stir IN beer.</li><li> IN a 2-cup glass measure combine the water, cornstarch, brown mustard, molasses, caraway seed, allspice, AND pepper;
stir INTO onion mixture.</li><li>Cook AND stir UNTIL thickened AND bubbly.ADD rutabaga;
cover AND cook 15 minutes.</li><li>Stir IN the knockwurst, apple wedges, AND sauerkraut.Cook, covered, 15 TO 20 minutes more OR UNTIL apples are tender.</li></ol>  german  45  4  f  f  f  t
143  Pork Schnitzel AND Apple Salad  https://spoonacular.com/recipeImages/Pork-Schnitzel- AND -Apple-Salad-656817.jpg  <ol><li>1. USING a meat mallet, pound pork slices evenly TO 5mm thick.Marinate it WITH cornflour, cooking wine AND lightly beaten egg FOR about 3 - 5 minutes.</li><li>2. Coat marinated pork slices evenly WITH breadcrumbs BY pressing the meat down against the crumbs.</li><li>3. Heat oil IN a frying pan ON medium heat, cook pork schnitzel FOR 3 minutes ON EACH side OR UNTIL golden AND cooked through.Drain well ON paper towels.</li><li>4. Meanwhile, toss the pre-packed salad WITH accompany dressing BEFORE transferring them TO a serving plate AND top WITH apple slices.(you can soak apple slices WITH SOME lightly salted water TO prevent it FROM oxidized AND turns brown)</li><li>5. NEXT thickly SLICE pork AND arrange ON salad AND drizzle mustard dressing OVER pork AND serve.</li></ol>  german  45  4  f  f  f  t
144  Pork schnitzel WITH tarragon cream sauce  https://spoonacular.com/recipeImages/Pork-schnitzel- WITH -tarragon-cream-sauce-656819.jpg  <ol><li> USING the side OF a rolling pin OR a meat tenderiser, gently beat the pork UNTIL flattened TO a 0.5cm thickness.</li><li>Sprinkle the seasoned flour onto a plate.Beat the eggs IN a bowl.Mix the breadcrumbs WITH the grated parmesan AND sprinkle the mixture onto another plate.</li><li>Dredge EACH escalope lightly IN the flour ON BOTH sides, shaking OFF ANY excess, THEN dip INTO the egg, THEN press INTO the breadcrumb mixture, TO coat ON BOTH sides.Chill IN the fridge FOR 20 minutes BEFORE cooking.</li><li>Heat the oil IN a frying pan OVER a medium heat AND fry the schnitzels FOR 2-3 minutes ON EACH side, OR UNTIL golden-brown ON BOTH sides AND completely cooked through (there should be NO trace OF pink IN the middle).Remove FROM the pan AND SET aside TO drain ON kitchen paper.</li><li> FOR the sauce, pour the wine INTO a small saucepan, ADD the tarragon sprig AND bring TO the boil.CONTINUE TO boil FOR 1-2 minutes, OR UNTIL the volume OF liquid has almost completely reduced.</li><li>Pour IN the stock AND RETURN the mixture TO the boil.Boil FOR 3-4 minutes, OR UNTIL reduced IN volume BY half, THEN ADD the cream AND simmer FOR 2-3 minutes UNTIL thickened.Season, TO taste, WITH salt AND freshly ground black pepper, THEN stir IN the chopped tarragon.</li><li> TO serve, place one pork schnitzel onto EACH OF two plates AND spoon OVER the sauce.Garnish WITH wedges OF lemon AND serve WITH your choice OF vegetables ON the side.</li></ol>  german  45  2  f  f  f  f
145  Potatoes WITH Sauerkraut AND Crunchy Smoked Ham  https://spoonacular.com/recipeImages/Potatoes- WITH -Sauerkraut- AND -Crunched-Smoked-Turkey-Ham-657037.jpg  <ol><li>Directions:</li><li> INTO a big enough pot, put potatoes, salt, AND black pepper.Cover WITH water AND bring TO a boil OVER high heat.ADD sauerkraut WITH pickling liquid, bring TO a boil again, lower heat TO medium, AND cook UNTIL potatoes are soft, approximately 15 minutes.Drain the liquid, cover the pot, AND SET aside.</li><li> INTO a hot skillet OVER medium heat, pour olive oil AND ADD cubed smoked turkey ham.Cook UNTIL ham becomes browned AND crunchy.Don''t forget TO ADD garlic TO ham 2-3 minutes BEFORE ham IS done.</li><li>Onto EACH plate arrange 6 potato halves, half OF the sauerkraut, AND pour OVER hot olive oil WITH crunched turkey ham.FOR those who are NOT meat fans, just olive oil AND garlic will give the same delicious tasty results!</li></ol>  german  45  2  f  f  t  t
146  Sauerkraut Dip WITH Bacon AND Garlic  https://spoonacular.com/recipeImages/Sauerkraut-Dip- WITH -Bacon- AND -Garlic-659321.jpg  <ol><li>Cook bacon UNTIL crisp, THEN drain AND crumble.</li><li>Drain OFF bacon drippings AND cook shallot IN the same skillet UNTIL soft.DISCARD drained bacon drippings.</li><li>Place drained sauerkraut AND other ingredients IN a food processor AND run UNTIL smooth.</li></ol>  german  45  6  f  f  t  f
147  Classic Greek Moussaka  https://spoonacular.com/recipeImages/Classic-Greek-Moussaka-639606.jpg  <ol><li>Sprinkle the egg plant slices WITH salt AND let them stand FOR 45 minutes.THEN wash thoroughly TO remove excess salt.</li><li>Thinly brush EACH SLICE WITH olive oil AND bake IN the preheated grill pan FOR several minutes ON EACH side.SET aside.Repeat UNTIL ALL slices are grilled.</li><li> FOR the meat sauce lightly saute the onions IN olive oil UNTIL tender.</li><li> ADD ground beef AND saute, stirring frequently TO break up the clumps OF meat, UNTIL the meat IS NO longer pink.</li><li>Stir IN tomatoes, garlic, cinnamon, allspice, salt AND pepper AND simmer briefly ON low heat.</li><li> ADD IN tomato paste AND a little water IF the sauce IS TO thick.Remove FROM heat AND SET aside.</li><li> FOR the bchamel sauce ADD flour TO the melted butter, stirring constantly.WHEN the mixture IS evenly thick, gradually whisk IN warm milk.Gently bring TO the boil, THEN remove FROM heat, season WITH pepper AND nutmeg.Whisk IN (vigorously) the egg yolks.SET aside.</li><li>Thinly coat WITH olive oil a suitable ovenproof baking dish, sprinkle the bottom WITH homemade bread crumbs.</li><li>Place a layer OF egg plant, cover WITH SOME meat sauce AND feta cheese AND repeat this UNTIL the pan IS almost FULL.Finish WITH a layer OF feta cheese.</li><li>Top WITH bchamel sauce.</li><li>Cover WITH tin foil AND bake IN a preheated oven AT 180 C FOR 1 HOUR.</li><li>Remove moussaka FROM the oven AND let it SET AT room temperature 45 minutes BEFORE serving.</li></ol>  greek  135  4  f  f  f  f
148  Eggplant Fries WITH Tzatziki Sauce  https://spoonacular.com/recipeImages/Eggplant-Fries- WITH -Tzatziki-Sauce-642287.jpg  <ol><li>Preheat oven TO 450F</li><li>Mix salt, garlic powder, italian seasonings, paprika, AND breadcrumbs IN a bowl.</li><li> IN another bowl, mix yogurt &amp;
egg together.</li><li>- FIRST place the eggplant strips INTO egg/yogurt mixture THEN coat them IN breadcrumb mixture evenly.</li><li>Place them ON a parchment paper lined OR greased baking pan AND bake FOR 10-15 minutes rotating once AND UNTIL slightly brown.</li><li>Serve WITH tzatziki.</li></ol>  greek  25  2  t  f  f  f
149  Fire-Roasted Jalapeno Hummus WITH Turnip AND Beet Chips  https://spoonacular.com/recipeImages/Fire-Roasted-Jalapeo-Hummus- WITH -Turnip- AND -Beet-Chips-642893.jpg  <ol><li> START BY making the chips.Preheat oven TO 415 degrees ( AND IF you have a convection OPTION ON your oven, I recommend USING it!).SLICE turnip AND beet thinly (peel ON OR OFF ...I leave the peels ON ), place ALL slices IN a plastic bag (I just use the plastic produce bags FROM the produce section OF the store), drizzle IN olive oil, ADD your salt AND garlic powder, AND shake it LIKE Shake N Bake! Lay roots flat ON a lightly-oiled cookie sheet ( OR two) AND bake IN the oven TO desired crip LEVEL, BETWEEN 11 AND 15 minutes.The thicker slices will likely need TO be turned OVER IF they''re NOT getting crispy WITHIN 10 minutes OR so.</li><li> WHILE the chips are baking, make the hummus.Wrap the cloves OF garlic IN foil.USING tongs, roast the jalapeo AND wrapped garlic OVER a flame (I used my gas stove) UNTIL the flesh IS blackened, soft AND hot.WHEN cool enough TO handle, remove the stem AND seeds FROM the jalapeo.Place ALL ingredients ( INCLUDING jalapeo flesh) IN a blender OR food processor, AND blend UNTIL ingredients are combined AND there are NO more chunks.You may need TO use a rubber spatula TO stir around the ingredients IN ORDER TO blend them well.Spoon hummus INTO a serving bowl.Drizzle olive oil ON top AND sprinkle paprika AND turmeric.Serve WITH beet AND turnip chips.</li></ol>  greek  45  4  t  t  t  t
150  Great Greek Salad  https://spoonacular.com/recipeImages/Great-Greek-Salad-645265.jpg  <ol><li> IN a LARGE salad bowl, toss together the cucumbers, olives, roma tomatoes, sun-dried tomatoes, 2 tablespoons reserved sun-dried tomato oil, red onion, vinegar, AND seasoning.</li><li>Chill UNTIL serving.</li><li> RIGHT BEFORE serving toss IN the feta AND stir TO combine.</li></ol>  greek  15  4  t  f  t  f
151  Greek Side Salad  https://spoonacular.com/recipeImages/Greek-Salad-645348.jpg  <ol><li> SLICE the vegetables INTO bite-size wedges</li><li>Toss IN a bowl WITH olive oil </li><li>Place feta ON top OF the salad OR break up INTO crumbles</li></ol>  greek  15  4  t  f  t  f
152  Greek Shrimp Orzo  https://spoonacular.com/recipeImages/Greek-Shrimp-Orzo-645354.jpg  <ol><li>Combine lemon juice AND 1/2 cup olive oil.</li><li>Bring LARGE pot OF salted water TO a boil OVER high heat.</li><li>Pour IN orzo AND cook UNTIL al dente.</li><li>Drain the pasta, pour INTO a LARGE serving bowl, AND immediately ADD lemon juice/olive oil mixture.Stir well.</li><li>Heat a LARGE skillet OVER medium-high heat AND ADD 1 tbsp olive oil.ADD shrimp, salt AND pepper, AND cook FOR about 2 minutes, OR UNTIL the shrimp are just done.</li><li> ADD the shrimp, green onions, parsley, AND feta TO the orzo mixture.Stir well.</li><li>Let the orzo sit FOR 1 HOUR.IF you make it earlier IN the DAY, cover AND refrigerate.Bring TO room temperature BEFORE serving.</li><li>Just BEFORE serving, ADD the basil AND gently mix.IF desired, serve OVER a bed OF spinach OR lettuce.</li></ol>  greek  45  6  f  f  f  f
153  Grilled Chicken Gyros WITH Tzatziki  https://spoonacular.com/recipeImages/Grilled-Chicken-Gyros- WITH -Tzatziki-645646.jpg  <ol><li>Whisk together the garlic, lemon juice, vinegar, oil, yogurt, AND oregano IN a bowl.ADD the chicken AND rub the marinade IN.Cover AND refrigerate FOR AT least an HOUR.</li><li>Preheat the grill TO medium heat ( OR broiler, OR pan ON the stove).Sprinkle the chicken WITH salt AND pepper ON BOTH sides, AND THEN grill UNTIL cooked through, about 5 minutes per side, depending  what size/ TYPE chicken you are USING.Allow the chicken TO rest FOR a few minutes BEFORE slicing INTO strips.</li><li>Meanwhile, heat your pitas IN a fry pan, IN the toaster OR spray WITH a BIT OF oil AND place RIGHT ON a gas burner.Top the pita WITH the chicken, tzatziki, tomatoes AND onions.</li><li> FOR the Tzatziki:Shred the cucumbers AND THEN wrap IN a towel AND squeeze TO remove AS much moisture AS possible.Don''t SKIP this step!</li><li>Mix together the strained yogurt, shredded cucumbers, garlic, vinegar AND lemon juice.ADD salt AND pepper TO taste.Its best TO refrigerate FOR 30 minutes OR more BEFORE serving, so flavors can meld.</li><li>Drizzle a little olive oil OVER the top.</li></ol>  greek  75  2  f  f  f  f
154  Hummus WITH roasted orange peppers  https://spoonacular.com/recipeImages/Hummus- WITH -roasted-orange-peppers-647634.jpg  <ol><li>Find the directions FOR preparation here - http://divinespicebox.com/2014/06/08/hummus- WITH -roasted-orange-peppers/</li></ol>  greek  45  2  t  t  t  t
155  Hummus WITH Tahini Sauce  https://spoonacular.com/recipeImages/Hummus- WITH -Tahini-Sauce-647636.jpg  <ol><li> IN a food processor mix ALL the ingredients AND process them ON high speed.</li><li>Pour INTO a serving bowl, garnish WITH parsley, Sumac, Cumin AND Olive Oil, OR you may garnish TO your liking USING whole chickpeas AND Olive Oil.</li></ol>  greek  45  2  t  t  t  t
156  Hummus Wrap WITH Carrots AND Cucumbers  https://spoonacular.com/recipeImages/Hummus-Wrap- WITH -Carrots- AND -Cucumbers-647638.jpg  <ol><li> START WITH hummus.Throw ALL the ingredients INTO a food processor AND process UNTIL smooth.The mixture might be a BIT thick AND hard TO process so you can ADD few tablespoons OF water OR a BIT more olive oil.</li><li>Tip:IF I dont have tahini AT home I simply TOAST 1 OR 2 Tbsp sesame seeds AND throw TO a food processor INSTEAD OF tahini.</li><li>Spread 2 Tbsp hummus IN the center OF a tortilla leaving about an inch ON a top AND bottom AND few inches ON a sides.</li><li>Follow WITH the lettuce, carrots, cucumbers AND olives.</li><li>Fold top AND bottom edges OF the tortilla, turn 90 degrees AND wrap the remaining tortilla around the filling.Wrap the tortilla IN aluminum foil TO HOLD its shape.Cut INTO half.</li></ol>  greek  45  1  t  t  t  t
157  Lamb AND Fresh Goat Cheese Roulade  https://spoonacular.com/recipeImages/Lamb- AND -Fresh-Goat-Cheese-Roulade-649183.jpg  <ol><li>Heat 2 tbsp.olive oil IN a saut pan OVER medium high heat.</li><li> ADD the garlic AND saut FOR 10 seconds THEN ADD the spinach AND saut ONLY UNTIL the spinach wilts.</li><li> SET aside TO cool.</li><li>Lay OUT the lamb loin AND butterfly TO CREATE a flat piece about 6 inches wide.</li><li>Season the loin WITH salt AND pepper.</li><li>Squeeze the excess water FROM the spinach AND spread evenly OVER the lamb loin.</li><li>Split the goat cheese IN half lengthwise AND THEN IN half again TO CREATE 4 lengthwise quarters.</li><li>Place 2 quarters END TO END ON EACH PREPARED lamb loin.</li><li>Roll AND truss EACH PREPARED loin.</li><li>Preheat oven TO 375F.</li><li> IN a LARGE saut pan, heat cooking oil OVER medium high heat AND sear EACH loin FOR 3-4 minutes ON ALL sides.</li><li>Roast lamb loins IN the oven FOR 10 -12 minutes UNTIL an INTERNAL temperature OF 120F IS reached.</li><li>Remove FROM the oven AND let rest FOR 10 minutes.</li><li>Remove string AND SLICE INTO medallions.</li><li>Divide among 2 plates AND serve.</li></ol>  greek  45  6  f  f  t  f
158  Lamb Burgers WITH Tzatziki Sauce  https://spoonacular.com/recipeImages/Lamb-Burgers- WITH -Tzatziki-Sauce-649195.jpg  <ol><li> FOR the lamb burger, mix 1 pound ground lamb, 1 egg, 1 splash OF extra-virgin olive oil, the juice OF 1 lemon, 1/4 cup chopped flat leaf parsley, AND 6 cloves OF chopped garlic.Season WITH kosher salt &amp;
pepper TO taste AND let sit FOR TO 1 HOUR.</li><li>Grill burgers TO your liking.</li><li> FOR the tzatziki sauce, mix together 1 pint Greek yogurt, 1 diced cucumber, juice OF 1 lemon, 1 tablespoon extra-virgin olive oil, 6 garlic cloves ( ADD garlic BIT BY BIT UNTIL you have the LEVEL OF garlic you LIKE ), 1 handful minced fresh dill, AND kosher salt AND fresh cracked pepper TO taste.Refrigerate overnight TO let the flavors intensify.</li><li>Serve the grilled burgers ON toasted buns AND ADD a dollop OF the sauce ON top.</li></ol>  greek  45  4  f  f  f  f
159  Lamb Moussaka  https://spoonacular.com/recipeImages/Lamb-Moussaka-649225.jpg  <ol><li>CUT eggplant INTO 1/4" (5mm) thick slices. Layer in colander, sprinkling each layer with salt. Let stand 30 minutes.</li><li>RINSE eggplant; pat dry. Place in single layer on baking sheet. Brush with olive oil. Broil, turning once for 4 to 6 minutes on each side, until golden and softened. Set aside. Repeat until all eggplants are cooked.</li><li>SAUTE zucchini in large oiled frying pan until tender-crisp. Set aside.</li><li>Meat Sauce:COOK lamb in large saucepan on high heat, breaking up with spoon, for 5 minutes. Drain off fat. Add onions, garlic and oregano. Cook on medium for 5 minutes. Add tomatoes, tomato paste and wine. Simmer 10 minutes, or until mixture starts to thicken. Stir in parsley, salt and pepper. Set aside.</li><li>White Sauce:MELT margarine in large saucepan. Add flour, mixing until smooth. Gradually add milk. Cook, stirring constantly until mixture comes to a boil and is thickened. Add salt and nutmeg. Add a bit of hot mixture to beaten eggs then return to saucepan and cook 2 minutes longer, stirring occasionally.</li><li>To Assemble:Tips:Place pan on a baking sheet or piece of foil to catch any drips that may boil over.</li><li>MAKE-AHEAD: After assembling, cool completely, uncovered in refrigerator. Cover with plastic wrap and refrigerate for 1 day or overwrap with heavy foil and freeze up to 3 weeks. Thaw in refrigerator 48 hours before baking.</li><li>Replace lamb with beef.</li><li>A thin bottom layer of sauteed sliced potatoes can be added.</li><li>A make-ahead layered Greek casserole that''s ideal for potlucks and family reunions.</li></ol>	greek	45	12	f	f	f	f
160  Lemony Greek Lentil Soup  https://spoonacular.com/recipeImages/Lemony-Greek-Lentil-Soup-649886.jpg  <ol><li>Put the lentils, water, carrot AND 1 teaspoon dried thyme INTO an 8-quart stockpot, cover AND SET OVER medium heat.</li><li> AFTER 15 minutes, lower the heat somewhat AND gently bring the water TO a simmer, which should take another half an HOUR OR so.</li><li>Once the lentils have reached the boiling POINT, turn OFF the burner AND let them sit FOR 1 HOUR.</li><li> AFTER the HOUR, bring the soup back TO a simmer AND ADD the lemon juice, dry basil, fresh thyme, oregano, pepper AND salt AND simmer FOR 1 HOUR.</li><li>Now, slowly saut the onion AND garlic IN the olive oil UNTIL the onion IS tender.</li><li>Coarsely chop the tomatoes (I DO this WITH kitchen scissors RIGHT IN the can), AND ADD them AND the onion mixture TO the soup.Adjust the salt TO taste.</li><li>Bring everything back TO the boiling POINT AND simmer FOR another HOUR.AFTER this POINT, you can turn your burner TO its lowest setting, AND this soup will happily sit steaming WITH its lid cocked FOR several hours UNTIL you are ready TO enjoy it.ADD more water IF necessary.</li><li>Serve WITH crusty bread AND a soft cheese LIKE St.Andre OR Cambazola</li></ol>  greek  45  6  f  f  t  t
161  Pasta WITH Roasted Vegetables AND Greek Olives  https://spoonacular.com/recipeImages/Pasta- WITH -Roasted-Vegetables---Greek-Olives-654939.jpg	<ol><li>Preparation:</li><li>Cook spaghetti, rinse & drain, set aside </li><li>Sear the meat with onions, set aside (color equal flavor dont make gray and bubbly)</li><li>Roast vegetables with olive oil (sear them dont Cooke them)</li><li>Roast sliced mushrooms</li><li>For the sauce: combine all ingredients bring to boil then simmer on low heat for about 10 minutes</li><li>Serve:</li><li>Lay pasta in the bottom of the plate then the sauce, meat goes on top of sauce</li><li>Then start layering the vegetables the mushrooms, add a the cheese & olives</li><li>Garnish with fresh Basil.</li></ol>	greek	45	8	f	f	f	f
162  Roasted Eggplant Hummus  https://spoonacular.com/recipeImages/Roasted-Eggplant-Hummus-658573.jpg  <ol><li>Preheat oven TO 425 degrees.</li><li> ON a LARGE baking sheet toss eggplant, 2 tablespoons olive oil, salt AND pepper AND spread IN a single layer.</li><li>Roast FOR 18-20 minutes.</li><li>Remove FROM oven AND SET aside.</li><li> IN food processor combine, chickpeas, tahini, garlic, lemon juice, 2 tablespoons olive oil AND pulse 3 OR 4 times.</li><li> ADD eggplant AND blend ON highest LEVEL UNTIL desired consistency.</li><li>Store IN air tight containers IN the refrigerator.</li></ol>  greek  45  6  t  t  t  t
163  Spanakopita (Greek Spinach Pie)  https://spoonacular.com/recipeImages/Spanakopita-(Greek-Spinach-Pie)-660843.jpg  <ol><li>Heat vegetable oil IN a LARGE saucepan OVER medium heat.Slowly cook AND stir onions UNTIL softened.Mix IN spinach, dill AND flour.Cook approximately 10 minutes, OR UNTIL most OF the moisture has been absorbed.Remove FROM heat.Mix IN feta cheese, eggs, salt AND pepper.</li><li>Lay 1 sheet OF phyllo dough IN PREPARED baking pan, AND brush lightly WITH olive oil.Lay another sheet OF phyllo dough ON top, brush WITH olive oil, AND repeat process WITH 10 more sheets OF phyllo.The sheets will overlap the pan.</li><li>Spread spinach AND cheese mixture INTO pan AND fold overhanging dough OVER filling.Brush WITH oil, THEN layer remaining sheets OF phyllo dough, brushing EACH WITH oil.Tuck overhanging dough INTO pan TO seal filling.</li><li>Bake IN preheated oven FOR 30 TO 40 minutes, UNTIL golden brown.Cut INTO squares AND serve WHILE hot.</li></ol>  greek  45  8  t  f  f  f
164  Easy Lemon Feta Greek Yogurt Dip  https://spoonacular.com/recipeImages/easy-lemon-feta-greek-yogurt-dip-716403.jpg    greek  45  1  t  f  t  f
165  Coconut Chicken Curry WITH Snow Peas AND Rice  https://spoonacular.com/recipeImages/Coconut-Chicken-Curry- WITH -Snow-Peas- AND -Rice-157311.jpg  <p>1. Heat coconut oil IN a pan OVER medium-high heat.Pre-heat the oven TO 190 C OR 375 F.START cooking the brown rice.</p><p>2. ADD the cubed chicken breast TO the pan FOR a couple minutes UNTIL browned.Transfer the chicken FROM the pan INTO a casserole dish.</p><p>3. Fry the garlic AND ginger IN the pan, adding more coconut oil IF necessary.ADD the spices UNTIL fragrant.</p><p>4. ADD the coconut milk AND tomato paste TO the pan.</p><p>5. START steaming the frozen snow peas, giving the flavors IN the sauce SOME TIME TO meld.</p><p>6. Pour the sauce OVER the chicken breast cubes.</p><p>7. Put the casserole dish IN the oven FOR about 25 minutes, adding the snow peas FOR the LAST 10 minutes OR so.Once the chicken IS cooked through, stir IN the lemon grass paste.</p><p>8. Serve the chicken curry OVER brown rice.</p><p><span></span></p>  indian  45  2  f  f  t  t
166  Indian Spiced Red Lentil Soup  https://spoonacular.com/recipeImages/Indian-Spiced-Red-Lentil-Soup-631752.jpg  <ol><li>Put Cilantro Stems IN Water AND bring TO a boil THEN remove Stems (This step IS optional)</li><li>Rinse the Lentils AND ADD TO Stem Broth</li><li>Bring Lentils TO a boil THEN turn heat down TO medium</li><li> ADD a BIT OF Lentil water TO the Bullion cubes, mash well THEN ADD TO Lentils</li><li> IN a saut pan ADD Grapeseed Oil, Coriander Seeds (you can put the seeds IN a coffee grinder IF you prefer) Cumin Seeds, Turmeric, Garam Masala.</li><li>Saut ON medium heat UNTIL fragrant approximately about 5 minutes.</li><li>Mince Serranos, grate Ginger, mince Onions, mince Garlic AND ADD TO pan THEN saut UNTIL Onions are soft.</li><li> ADD Tomato Sauce AND cook ON medium low FOR about 10 minutes THEN ADD TO cooked Lentils AND cook FOR 20 more minutes ON low heat.</li><li> IF you LIKE a smooth texture TO your soup you can put ALL OF it IN a food processor (blender OR hand blender) TO puree` OR ONLY use half FOR a slightly textured soup OR leave it IF you LIKE it that way.</li></ol>  indian  45  12  t  t  t  t
167  Apple Curry Soup  https://spoonacular.com/recipeImages/Apple-Curry-Soup-632528.jpg  <ol><li>Sweat leeks AND mushrooms IN vegetable oil UNTIL tender ( WITHOUT color) IN a heavy gauge sauce pot</li><li> ADD apples, apple cider, coconut milk, curry powder, turmeric.Bring TO boil AND simmer FOR 20 minutes.</li><li> ADD the Chavrie AND season WITH salt AND pepper</li><li>Pour entire contents IN a blender AND puree OR puree WITH a hand held mixer</li><li>Strain through a fine chinois.AND keep warm</li><li>Serve hot</li><li>Garnish WITH slices OF apple OR a dollop OF Chavrie</li></ol>  indian  45  1  t  f  t  f
168  Baked Chickpea AND Chili Koftas IN a Hot Jalfrezi Curry Sauce  https://spoonacular.com/recipeImages/Baked-Chickpea---Chili-Koftas-in-a-Hot-Jalfrezi-Curry-Sauce-633544.jpg	<ol><li>Preheat oven to 180 degrees celcius (356 Fahrenheit) and line a large baking tray with parchment paper.</li><li>Make the Kofta  Heat 2 tbsp water in a saute pan over a medium heat and add the onion, garlic and chili and cook for 4 minutes, transfer to a food processor (or use a stick blender) add the coriander and the Kofta Spice Mix and pulse until smooth.</li><li>In a large mixing bowl, mash the chickpeas until they are all crushed then add the mixture from step 2 along with the gram flour and mix thoroughly together, if its too wet, add a little more gram flour. Using damp hands take a heaped tablespoon of the kofta mixture and shape into a ball and place on the parchment paper, you should get 18  20 koftas. Cook in the oven for 20  25 minutes, they should firm up quite nicely in the oven.</li><li>Now make the Jalfrezi  Add the onion, ginger, garlic and chili to a food processor and pulse until smooth.</li><li>Heat 2 tbsp of water in a deep sauce pan, add the onion mixture from step 4 along with all the Jalfrezi Spice Mix and cook for 3 minutes to release the flavours before adding in the green peppers, passata, peas and lemon juice, bring to the boil then reduce the heat to medium, cover the pan and cook for 20 minutes and just before serving stir through the coriander. Serve in a bowl with the koftas placed on top!</li></ol>	indian	45	2	t	t	t	t
169  Balti Butter Chicken  https://spoonacular.com/recipeImages/Balti-Butter-Chicken-633960.jpg  <ol><li>Marinate the cleaned cubed chicken FOR ALL the ingredients AND keep it IN fridge FOR a minimum OF 5 hours OR the best overnight.</li><li>Grill it IN a Tandoor oven OR bake it conventional oven AT 400 F FOR 30-40 minutes, till they are firm n brown.When the juices run OUT, take it n reserve.</li><li>Take a kadai n melt SOME butter, ADD the onion AND green chilies AND saute till pink.Take it OUT n blend IN a mixer.</li><li> IN the same pan, pour butter, splutter fennel seeds AND roast the whole spices.</li><li>Now ADD the nuts AND raisins AND roast till brown n plump.(you can roast it separately n ADD TO the gravy AT LAST ALSO )</li><li>Now bring back the onion paste AND saute till brown.Add the reserved juice too..</li><li> ADD the tomato puree AND mix.</li><li> ADD the chili powder, pepper powder, salt AND half OF garam masala.Mix well AND simmer FOR 2 minutes</li><li>Sprinkle the ketchup.</li><li>Now put the roasted chicken IN it AND cover WITH the gravy.</li><li>Simmer AND cover WITH a lid FOR 5-8 minutes.</li><li>Now remove the lid AND cook UNTIL the desired dryness LEVEL IS achieved.</li><li> ADD the fresh cream n stir IN FOR a MINUTE.</li><li>Sprinkle the Garam masala powder, a tad OF sugar AND mix well.</li><li>Garnish WITH cilantro leaves.</li><li> ADD a wee BIT OF butter BEFORE serving..:)</li></ol>  indian  45  2  f  f  t  f
170  Beef AND Tomato Curry OVER Quinoa  https://spoonacular.com/recipeImages/Beef- AND -Tomato-Curry- OVER -Quinoa-634579.jpg  <ol><li>Season BOTH sides OF the beef WITH curry powder AND SET aside.</li><li>Cook the onion IN the olive oil OVER medium heat IN a sautee pan.</li><li> ADD the garlic, ginger, AND chile once the onion becomes translucent.</li><li> ADD the curry powder AND stir TO coat everything IN the pan.</li><li> ADD the tomato paste AND cook UNTIL the paste starts TO darken, stirring often TO prevent burning.</li><li>Deglaze WITH the wine AND stir UNTIL the liquid IS absorbed.</li><li>Transfer the contents OF the pan INTO a crock pot.</li><li>Sear the beef OVER high heat ON BOTH sides, transfer TO crock pot.</li><li> ADD the can OF tomatoes AND bay leaf.IF needed, ADD chicken stock OR water so the beef IS almost covered.SET your crock pot ON low AND cook UNTIL you can shred the beef WITH a fork.CHECK FOR seasoning AND ADD salt AND pepper TO taste.(Remove bay leaf AND ginger piece.)</li><li> PREPARE quinoa according TO package directions AND serve tomato beef curry OVER the top.</li></ol>  indian  45  4  f  f  t  t
171  Beef Vindaloo  https://spoonacular.com/recipeImages/Beef-Vindaloo-634712.jpg  <ol><li> FOR marinade:Blend together garlic AND red wine vinegar.ADD chilies, cumin, turmeric, mustard, ginger, salt, sugar, lemon peel, juice, AND pulp AND blend well.</li><li>Place beef IN bowl AND pour marinade OVER it.Stir IN poppy seeds AND sit FOR 2 hours.</li><li>Heat clarified butter IN pan AND ADD onion.Cook UNTIL translucent, THEN ADD bay leaves AND cloves.WITH slotted spoon, lift meat FROM marinade AND ADD TO onions.Increase heat TO sear meat.Pour IN marinade.Cover tightly, reduce heat AND cook 1 HOUR.</li><li> AFTER 1 HOUR, ADD tomato paste, stirring thoroughly, AND cook another 30 minutes, UNTIL meat IS tender.Season WITH salt AND pepper.</li><li>This recipe yields 4 servings.</li><li> COMMENTS :A specialty OF The Sultan, Surfers'' Paradise, Australia.</li></ol>  indian  45  1  f  f  t  f
172  Channa-Chickpea, Potato AND Cauliflower Curry  https://spoonacular.com/recipeImages/Channa-Chickpea--Potato---Cauliflower-Curry-637426.jpg	<ol><li>In a large pot heat oil.</li><li>Add onions saute until very soft.</li><li>Add garlic and ginger, saute for 3-4 minutes.</li><li>Add spices, saute with potatoes until they are covered with the spice mixture.</li><li>Add water to cover.</li><li>Simmer until potatoes are soft.</li><li>Add chickpeas, and cauliflower.</li><li>Simmer with lid on for 20 minutes,stirring occasionally.</li><li>Season with salt,sugar and vinegar. Serve with brown rice</li></ol>	indian	45	8	t	t	t	t
173  Curry Beef OVER Rice Noodles  https://spoonacular.com/recipeImages/Curry-Beef- OVER -Rice-Noodles-641111.jpg  <ol><li> IN nonstick skillet, ADD oil AND saut beef OVER medium-high heat FOR 3-4 min.ADD red onions, garlic, saut FOR about 4 minutes.ADD fresh ginger, sambal oelek, curry powder;
cook, stirring, UNTIL fragrant, about 45 seconds.</li><li> ADD soy sauce, lime juice AND peanuts.Saut another 30 seconds.SERVER OVER rice noodles.</li></ol>  indian  45  2  f  f  f  t
174  Curry Mussels  https://spoonacular.com/recipeImages/Curry-Mussels-641128.jpg  <ol><li> IN a big pot OR cocotte, put IN olive oil AND onion.Fry the onions UNTIL soft but NOT brown.</li><li> THEN, put IN white wine, parseley, salt, pepper, AND cayenne pepper.</li><li>Stir FOR a few minutes BEFORE putting the mussels IN the pot.Put the lid ON AND cook the mussels FOR about 2-3 minutes, shaking the pan occasionally.</li><li>Use tongs TO lift OUT the mussels AS they OPEN, putting them INTO a warm dish.Throw away ANY mussels that havent opened AFTER 3 minutes.</li><li>Strain the liquid through a fine sieve INTO a clean saucepan, leaving behind ANY grit OR sand.</li><li>Bring TO the boil AND boil FOR 2 minutes.</li><li> ADD the curry powder AND crme fraiche, stir.Reheat the sauce WITHOUT boiling AND let the sauce thicken.</li><li>Serve the mussels IN individual bowls WITH the sauce poured OVER.</li><li>Sprinkle WITH SOME parsley.</li></ol>  indian  20  4  f  f  t  f
175  Dum Mutton Biryani  https://spoonacular.com/recipeImages/Dum-Mutton-Biryani-641739.jpg  <ol><li>N a pressure cooker, ON medium high heat ADD mutton, dry spices AND 1 tsp salt TO 2 cups water.Close the lid AND let it pressure cook UNTIL the meat IS 80%% cooked.This can be tested BY opening the lid AND squeezing the mutton pieces WITH fingers, it should be just tender & AND NOT falling apart OR soft.</li><li>Once cooked, reserve the stock FROM pressure cooker INTO a bowl, separate the mutton FROM spices AND SET aside the mutton pieces TO cool.Throw away the collected spices.</li><li>Meanwhile, wash the rice thoroughly AND SET aside.</li><li> IN a pan, heat the oil till ripples are formed ON the surface.Stir-fry the cooled mutton pieces IN this oil FOR about 1-2 minutes.Take the mutton OUT AND IN the same oil ON medium heat, ADD the onions AND stir fry them untill golden brown.Once the onions are done, ADD the cumin seeds, red chili powder[IF USING], dry coriander powder AND saute FOR about 2 minutes.</li><li> NEXT, ADD the washed rice TO the pan AND saute FOR about 3 minutes.This gives the rice a nutty flavor.</li><li> AFTER the rice IS sauted, switch OFF the heat AND ADD the mutton pieces, salt AND about 2.5 cups OF reserved stock TO the pan.Let the rice soak FOR about 20 minutes.</li><li> TO the soaked rice, ADD the saffron -milk, cover WITH lid AND let the rice cook ON low- medium heat.The amount OF rice I used took around 15 minutes TO cook AT low heat.You can adjust stock/water AS per your rice variety.</li><li> WHILE the rice IS cooking, let the tava/girdle heat up ON high heat.Switch OFF the heat once the rice IS done AND transfer the pan TO the top OF heated tava.Seal the edges OF the pan AND lid WITH kneaded dough ON ALL sides so that NO steam can ESCAPE.This process IS CALLED dum cooking wherein the dish IS slowly cooked ON very low heat, mostly IN sealed containers, allowing the meats TO cook, AS much AS possible, IN their own juices andso thatthe aromas OF spices are absorbed WITHIN the dish.You can READ more about it here AND here.</li><li> AFTER cooking ON dum FOR about 8-10 minutes remove the pan FROM tava AND let it rest FOR about 10 minutes.</li><li>Thereafter, break the dough seal, transfer TO a serving vessel AND garnish WITH cilantro leaves, fried onions & nuts [IF USING].</li><li>Serve WITH raita AND salad.</li><li>Notes:</li><li>Seasoning the water IN which the rice will cook IS very important ELSE the biryani will be tasteless.</li><li>Be patient WHILE the biryani cooks.Avoid opening the lid again AND again AND stirring WHILE the rice cooks.</li><li> AFTER dum cooking, it IS mandatory TO let the biryani rest FOR SOME TIME.Do NOT SKIP this step.</li><li>Enjoy!</li></ol>  indian  45  3  f  f  f  f
176  Gujarati Dry Mung Bean Curry  https://spoonacular.com/recipeImages/Gujarati-Dry-Mung-Bean-Curry-646043.jpg  <ol><li>Wash the mung beans AND boil them IN plenty OF hot water WITH a pinch OF baking powder UNTIL al-dente.IF you have a pressure cooker thats about 6-7 whistles.Drain AND SET aside.</li><li> IN a LARGE pan heat the oil AND ADD the mustard seeds (wait FOR them TO pop) THEN ADD the cumin seeds, asafoetida, curry leaves, garlic AND chilies.Saut UNTIL aromatic.Obviously dont let it burn.</li><li> ADD the tomatoes, turmeric AND mung beans AND cook FOR two minutes.Be careful NOT TO mash it up AS you stir.</li><li> ADD the salt, sugar, lemon juice AND cinnamon powder AND cook FOR a further two minutes.</li><li>Throw IN the chopped coriander, combine AND serve.</li></ol>  indian  45  4  t  t  t  t
177  Keema Curry  https://spoonacular.com/recipeImages/Keema-Curry-648809.jpg  <ol><li>Saute curry powder IN oil OVER medium heat FOR 2 TO 3 minutes.ADD onions AND brown.ADD garlic AND coriander AND stir.ADD meat AND brown.ADD salt AND tomatoes, IF USING fresh tomatoes FIRST peel, seed, AND SLICE AND cover.Cook OVER low heat FOR about 20 TO 25 minutes.ADD peas, mix IN, cover again, AND cook FOR about 5 minutes UNTIL peas are done.</li><li> DO NOT use a black CAST iron skillet, the curry powder will GET IN the pores.Frozen peas WORK better ( AND are easier) than fresh.</li></ol>  indian  45  4  f  f  t  t
178  Luscious Palak Paneer  https://spoonacular.com/recipeImages/Luscious-Palak-Paneer-650484.jpg  <ol><li>Blanch the spinach IN hot water WITH a tiny pinch OF baking powder (which keeps it beautifully green!) AND drain WHEN wilted.Place IN a blender AND puree WITH a cup OF water.SET the puree aside.</li><li> IN a LARGE pan heat the oil AND ADD the onions, garlic, ginger, chilies AND tomatoes.Cook FOR around 5 minutes ON a high heat stirring constantly.DO NOT let it burn.</li><li> ADD the spinach puree, turmeric powder, cumin powder, coriander powder, fennel powder, cinnamon powder, cardamom powder AND salt TO taste.Simmer ON a medium heat UNTIL the oil separates FROM the spinach mixture.</li><li> ADD the paneer AND single cream IF you wish AND remove FROM the heat.</li><li>Serve WITH naan, rice, paratha OR IF you cant wait, a spoon.</li></ol>  indian  45  4  t  f  t  f
179  Mughlai Malai Kofta Curry  https://spoonacular.com/recipeImages/Mughlai-Malai-Kofta-Curry-652542.jpg  <ol><li>Boil the potatoes, cool, peel AND grate them.</li><li>Grate paneer.</li><li>Wash ALL green chilies, deseed AND chop them fine.</li><li>Peel carrots, grate them, ADD peas AND SOME water, boil them IN microwave FOR 10 mins.Once done, remove excess BY PASSING &amp;
squeezing it through a muslin cloth.</li><li>Peel onions, cut them INTO halves AND boil WITH a cup OF water FOR ten minutes.Drain excess water, cool onions AND grind them INTO a smooth paste.SET Aside.</li><li> IN a bowl, mix mashed potatoes, paneer, SOME chopped green chilies, boiled carrot-peas, corn flour AND salt.Mix well.Divide INTO 20-22 equal sized balls.Stuff  raisins &amp;
cashew INTO them.Deep fry IN hot oil UNTIL slightly golden brown.Drain AND keep aside.Fry one kofta AND CHECK FOR binding, IF it breaks, ADD a little more cornflour.Deep fry IN hot oil.</li><li> OR BAKE IN a 375F pre-heat oven, BY arranging &amp;
spraying oil ON these koftas PLACING them ON a cookie sheet wraped WITH aluminum foil, FOR 10 mins.Keep a CLOSE watch, WITH the help OF tongs, turn them once they are slight brown ON one side.</li><li> ON the other side heat oil IN a kadai, ADD shahjeera, boiled onion paste AND cook FOR five minutes.ADD ginger &amp;
garlic, few chopped green chilies, coriander powder, cumin powder, turmeric powder, AND salt.cook FOR a MINUTE.</li><li> ADD tomato puree AND red chili powder AND cook ON medium flame untill oil separates FROM gravy.</li><li> ADD half&amp;
half along WITH SOME water &amp;
bring it TO a boil AND simmer FOR ten minutes ON a slow flame.Stir occasionally.</li><li>Stir IN fresh cream AND garam masala powder.</li><li>Gently put ALL OF these kofta''s IN the gravy WHEN ready TO serve.Simmer FOR another 2 mins AND enjoy this rich, creamy gravy WITH Nan/Roti (Indian Flat Bread.)</li></ol>  indian  45  4  t  f  t  f
180  Roasted Acorn Squash Stuffed WITH Spicy Biryani  https://spoonacular.com/recipeImages/Roasted-Acorn-Squash-Stuffed-W-spicy-Biryani-(Veg-vegan)-658482.jpg  <ol><li>Preheat the oven TO 400 degrees.ON a baking sheet place the squash halves, spray WITH PAM AND sprinkle WITH 1-2 tbsp garam masala.Place IN the oven AND BROIL till tender AND charred- about 10-15 minutes.</li><li> WHILE the squashes are roasting, IN a LARGE skillet, spray WITH PAM AND ADD vegetable oil AND SET OVER medium heat.ADD the cashews AND saute UNTIL fragrant AND slightly darkened.ADD onions AND peppers, sprinkle WITH black pepper AND saute UNTIL soft, about 5-7 minutes.Once the onions AND peppers are soft, but now brown, ADD the soaked basmati rice (make sure NOT TO GET ANY water IN it!).Saute FOR 5-7 minutes.You want TO TOAST the the rice.</li><li>Remove the squash FROM the oven AND cool FOR a few minutes BEFORE handling.Score the squash INTO small cubes, WITHOUT cutting through the skin.Scoop the cubes OUT INTO a bowl AND SET aside.Keep the shell aside, DONT throw OUT !</li><li>Once the rice IS toasted ADD 1 cup OF water, pinch OF saffron, cover AND cook ON medium-low heat, about 15 minutes.You want the rice TO be cooked thru, NOT mushy so dont mix it around too much! Once the rice IS cooked, ADD the cubed squash, tossing gently (you dont want the squash TO break AND mush around the rice).ADD the Biryani paste AND toss TO coat.Mix IN 3/4 OF the chopped cilantro.Taste FOR salt AND biryani flavor- it should be strong, spicy AND aromatic.</li><li> IN a small skillet, spray WITH PAM AND SET OVER medium-high heat.ADD onion slices, AND saute WITHOUT breaking up the circles.Cook UNTIL brown-ish about 4-5 minutes.SET aside.</li><li>Fill EACH squash bowl WITH rice, just coming OVER the top.Top EACH one WITH an onion round AND sprinkle WITH remaining chopped cilantro.Serve WITH yogurt OR raita.</li><li>Biryani paste:</li><li> IN a medium skillet, spray WITH pam, ADD oil AND SET OVER medium-high flame.ADD onions AND tomatoes, saute UNTIL golden-brown about 4-5 minutes.ADD garlic, ginger, chili powder AND cilantro.Saute UNTIL vegetables are soft AND fragrant about 4-5 minutes.ADD the biryani paste AND mix well, making sure ALL the veggies are coated.Remove FROM the heat AND let cool (10-15 minutes).</li><li> IN a grinder/food processor, ADD the biryani mixture AND grind UNTIL smooth (slightly chunky IS ok).Store IN an air tight container.Can be kept IN the fridge FOR 1-2 weeks, OR IN the freezer- FOR a WHILE !</li></ol>  indian  45  4  t  f  t  t
181  Slow Cooker Lamb Curry  https://spoonacular.com/recipeImages/Slow-Cooker-Lamb-Curry-660290.jpg  <ol><li>Pull OUT your slow cooker AND ADD everything INTO the pot WITH the EXCEPTION OF the yogurt.</li><li>Now turn ON your pot, setting it ON low FOR the NEXT 4-6 hours OR high FOR the NEXT 3-5.</li><li> WHEN the TIME IS up, OPEN up your slow cooker, grab your yogurt AND stir it INTO the curry.</li><li>Serve OVER rice.</li></ol>  indian  45  8  f  f  t  f
182  Beef Pot Pies WITH Irish Cheddar Crust  https://spoonacular.com/recipeImages/Beef-Pot-Pies- WITH -Irish-Cheddar-Crust-634660.jpg  <ol><li>Make the pastry:Place the cut up butter pieces IN the freezer FOR 15 minutes TO chill.Meanwhile, IN the WORK bowl OF a food processor combine flour, sugar, dry mustard, salt AND cayenne pepper.Pulse TO combine.AFTER the butter has chilled, scatter the pieces OVER the flour mixture (still IN the food processor), along WITH the cheddar.Pulse about 10 times.Sprinkle half the ice water OVER the dough, pulse about 3 times, repeat WITH remaining water, pulsing 3 more times.Pinch the dough TO CHECK IF it sticks together, IF NOT ADD a tablespoon OR two more ice water, UNTIL it comes together.Dump the mix IN a LARGE bowl AND press it together TO form the dough.Divide dough IN half, shaping EACH INTO a 4-inch disk.Wrap EACH piece IN plastic wrap AND refrigerate AT least an HOUR.</li><li> BEGIN the filling:Pat the meat dry WITH paper towels AND season WITH salt & pepper.Heat 2 t.oil IN a LARGE skillet OVER medium high heat UNTIL just smoking.ADD the meat IN a single layer AND cook, WITHOUT stirring, UNTIL the meat browns well ON the underside, anywhere BETWEEN 5-10 minutes (the meat will give OFF liquid, just let it evaporate - leave it alone!) Stir the meat AND cook another couple minutes, UNTIL it looses the raw color.Remove TO a plate AND SET aside.</li><li>Reduce heat TO medium, ADD the remaining 2 t.oil AND the onions AND carrots.Saute UNTIL softened AND starting TO brown, stirring occasionally, around 5 minutes.ADD the garlic, thyme AND marjoram, cook UNTIL very fragrant, about a MINUTE.Stir IN flour, cook AND stir about a MINUTE.Slowly ADD IN the beef broth AND water, THEN the meat, along WITH ANY juices LEFT ON the plate.Bring TO a simmer, THEN reduce the heat TO low, TO med-low.Cover AND cook, (adjusting the heat AS necessary TO maintain a simmer) stirring occasionally UNTIL the meat IS just becoming tender, around 45 minutes.Remove FROM heat, ADD IN the Dijon AND parsley.Adjust seasoning WITH salt & pepper.SET aside TO cool.</li><li>Rolling OUT the crust, filling & baking the pot pies:Remove the dough FROM the refrigerator 10 minutes BEFORE rolling it OUT.Roll the dough OUT ON a well-floured surface, LARGE enough TO cut OUT 3, 7-inch circles OUT OF EACH half (save the scraps).LINE EACH cup OF a LARGE -sized muffin tin WITH the dough.(It won''t look very pretty, you just kind OF have your way WITH it TO GET it pressed IN there.) Refrigerate the filled tins AS well AS the dough scraps 15 minutes TO firm back up.</li><li>Meanwhile, preheat oven TO 400 degrees.AFTER 15 minutes AND the filling has cooled down quite a BIT.Divide the mixture evenly BETWEEN crusts.Divide the remaining dough INTO 6 balls.Roll OUT EACH piece wide enough TO cover the pot pies.Pinch the top AND bottom crust edges together TO seal, AND finish the edges IN whatever decorative way you LIKE.Brush the tops WITH the beaten egg.Bake 35-40 minutes, rotating the pan AFTER 20 minutes.Remove FROM oven & let sit 5 minutes BEFORE (carefully) removing the pot pies FROM the tin.</li></ol>  irish  45  6  f  f  f  f
183  Colcannon  https://spoonacular.com/recipeImages/Colcannon-639900.jpg  <ol><li>Cut INTO top OF cabbage AND hollow it OUT, leaving 3-4 outside leaves intact, reserving the hollowed- OUT portion.Plunge the hollowed- OUT head INTO LARGE amount OF boiling water;
simmer 5 minutes OR UNTIL tender-crisp.It must HOLD its shape.Cool quickly IN cold water;
invert AND drain.</li><li>Chop reserved cabbage pieces, measure 1 1/2 cups.Stir fry IN butter along WITH green onions UNTIL tender.SET aside.Boil AND mash potatoes adding milk AND seasonings.Stir IN the sauteed mixture AND parsley.</li></ol>  irish  45  8  f  f  t  f
184  Corned Beef AND Cabbage  https://spoonacular.com/recipeImages/Corned-Beef- AND -Cabbage-640134.jpg  <ol><li>Wipe corned beef WITH damp paper towels.Place IN LARGE pan, cover WITH water.ADD garlic, cloves, black peppercorns, AND bay leaves.Bring TO boil.Reduce heat;
simmer 5 minutes.Skim surface AND cover pan;
simmer 3 TO 4 hours, OR UNTIL corned beef IS fork-tender.ADD carrots, potatoes, AND onions during LAST 25 minutes.ADD cabbage wedges during LAST 15 minutes.Cook vegetables just till tender.SLICE across the grain.Arrange slices ON platte</li></ol>  irish  45  6  f  f  t  t
185  Corned Beef AND Cabbage WITH Irish Mustard Sauce  https://spoonacular.com/recipeImages/Corned-Beef- AND -Cabbage- WITH -Irish-Mustard-Sauce-640136.jpg  <ol><li>Combine corned beef AND water TO cover IN a LARGE Dutch oven;
bring TO a boil THEN remove FROM heat.Drain.ADD fresh water TO cover.ADD onion, carrot, parsley, bay leaf, AND pepper.Bring TO a boil once again, THEN reduce TO a low simmer.Skim OFF foam, IF necessary.Cover AND simmer 4 hours OR UNTIL tender.</li><li>Remove onion AND parsley.ADD potatoes TO Dutch oven.Simmer 10 minutes.ADD cabbage wedges, AND simmer 20 minutes OR UNTIL vegetables are tender.Remove AND DISCARD bay leaf.</li><li> TO make the Irish Mustard Sauce, combine cornstarch, sugar, dry mustard AND salt IN a medium saucepan;
stir well.ADD water AND cook OVER low heat, stirring constantly, UNTIL thickened.Remove FROM heat.Stir IN vinegar, butter AND horseradish.Gradually stir about 1/4 OF hot mixture INTO yolks;
ADD TO remaining hot mixture, stirring constantly.Cook OVER low heat, stirring constantly, UNTIL thickened.</li><li>Transfer corned beef AND vegetables TO a serving platter.Serve WITH Irish Mustard Sauce.</li></ol>  irish  270  6  f  f  t  t
186  Guinness Braised Corned Beef AND Cabbage  https://spoonacular.com/recipeImages/Guinness-Braised-Corned-Beef- AND -Cabbage-646034.jpg  <ol><li>Season BOTH sides OF the corned beef liberally WITH pepper.The corning OF the beef makes the beef salty enough, so NO need TO ADD more.</li><li>Heat 1 TBSP oil IN a LARGE, shallow oven-safe pot OVER medium-high heat.ADD beef AND sear EACH side FOR about 3 minutes, just TO develop a nice brown crust.This will seal IN the beef''s juices.</li><li>Remove beef TO a plate.Pour guinness INTO the pot TO deglaze.Scrape up ANY browned bits.ADD beef broth, pickling spice, brown sugar, bay leaf, AND minced garlic.Bring mixture up TO a simmer.</li><li> RETURN the beef TO the pot WITH ANY additional juices that have accumulated ON the plate.</li><li>Cover the pot AND place ON the bottom rack IN your oven.Bake FOR 2 1/2 - 3 hours, OR UNTIL a fork can easily be inserted INTO the meat.</li><li>Baste the meat WITH the surrounding juices every 30 minutes OR so.</li><li> AFTER 2 hours, ADD carrots, parsnips, AND potatoes TO the pot.They will ONLY take about 25-30 minutes OF simmering TO cook.</li><li>Remove pot FROM the oven.Place beef ON a cutting board AND let it rest FOR 15 minutes BEFORE carving INTO thin slices (cut against the grain OF the meat).Remove vegetables AND arrange them ON a serving platter.Cover WITH foil.Place the pot ON the burner AND bring sauce TO a boil.ADD cabbage AND cook FOR about 7 minutes, UNTIL it has softened.Place the cabbage ON the serving platter WITH the other vegetables.</li><li>Strain the sauce IN the pot AND stir IN 2 OR 3 TBSP OF spicy honey mustard UNTIL dissolved.Place IN a small dish OR gravy boat WITH a ladle AND serve alongside the beef.</li><li> AFTER slicing the beef AND arranging it ON the serving platter, ladle the guinness mustard sauce OVER the top TO rehydrate AND glaze the beef AND vegetables.</li></ol>  irish  45  6  f  f  f  t
187  Irish Colcannon  https://spoonacular.com/recipeImages/Irish-Colcannon-647974.jpg  <ol><li>Chop the cabbage AND steam, USING minimal water, UNTIL quite well done.</li><li>Boil potatoes.Clean AND chop the leeks, INCLUDING the FIRST couple OF inches OF green, put INTO a saucepan WITH the milk AND simmer UNTIL tender.</li><li> IF USING bacon, saute UNTIL crisp.WHEN cool enough TO handle, break INTO bite size pieces.</li><li>Drain potatoes AND mash.</li><li>Stir IN milk WITH leeks, cabbage, mace, garlic, AND bacon.Gently mix TO combine ALL ingredients, but take care NOT TO OVER mash the potatoes.</li></ol>  irish  45  4  f  f  t  f
188  Irish Soda Bread WITH Raisins  https://spoonacular.com/recipeImages/Irish-Soda-Bread- WITH -Raisins-648004.jpg  <ol><li>Preheat oven TO 375F.Spray 8-inch-diameter cake pan WITH nonstick spray.Whisk flour, 4 tablespoons sugar, baking powder, salt, AND baking soda IN LARGE bowl TO blend.ADD butter.USING fingertips, rub IN UNTIL coarse meal forms.Make well IN center OF flour mixture.ADD buttermilk.Gradually stir dry ingredients INTO milk TO blend.Mix IN raisins.</li><li> USING floured hands, shape dough INTO ball.Transfer TO PREPARED pan AND flatten slightly (dough will NOT come TO edges OF pan).WITH a sharp knife, SLICE a shallow X across the top (optional).Sprinkle dough WITH remaining 1 tablespoon sugar.</li><li>Bake bread UNTIL brown AND tester inserted INTO center comes OUT clean, about 40 minutes.Cool bread IN pan 10 minutes.Transfer TO rack.Serve warm OR AT room temperature.</li></ol>  irish  45  8  f  f  f  f
189  Irish Soda Bread  https://spoonacular.com/recipeImages/Irish-Soda-Bread- BY -Mommie-Cooks-648006.jpg  <ol><li> TO a bowl ADD together your dry ingredients;
the flour, salt, AND baking soda.Mix well.</li><li> ADD IN the caraway seed AND combine.</li><li>Now ADD IN the honey, egg, AND buttermilk.Stir it up UNTIL a dough just begins TO form.</li><li> ADD IN the melted butter AND knead dough UNTIL ALL ingredients are combined.Don''t overknead.</li><li>Form INTO a ball AND cut a few 1" slits at the top.</li><li>Place dough on a baking sheet and place in an oven preheated to 350 degrees for 50 min. to an hour.</li><li>Test with a toothpick in the center to assure loaf is cooked completely.</li></ol>	irish	45	8	t	f	f	f
190  Irish Whiskey Pie  https://spoonacular.com/recipeImages/Irish-Whiskey-Pie-648010.png  <ol><li> FOR the crust:</li><li>Sift flour AND salt together INTO a LARGE bowl.</li><li> USING a food processor, a pastry blender OR two knives AND a good amount OF patience, cut the butter INTO the flour.</li><li> ADD water AND vodka stirring AFTER EACH addition UNTIL the dough comes together.</li><li>Form INTO a ball AND cut it IN half.</li><li>Flatten EACH half INTO a disc, wrap them IN wax paper AND refrigerate FOR AT least half an HOUR BEFORE baking.</li><li>You will ONLY need one half FOR this recipe, so feel free TO FREEZE the other half FOR future pie emergencies.</li><li> WHEN ready TO bake, preheat oven TO 375</li><li>Place pastry ON a well-floured surface AND USING a well-floured rolling pin, roll OUT the pastry TO fit a 9-inch pie plate.</li><li>Place pastry INTO the pie plate AND TRIM AND crimp the edges.</li><li>Prick the dough several times WITH a fork.</li><li>Wrap tin foil around the pastry AND fill the center WITH pie weights OR dried beans.</li><li>Place IN the center OF the oven AND bake FOR 25 minutes.</li><li>Remove weights AND tin foil AND bake FOR an additional nine minutes OR UNTIL golden brown.</li><li>Remove FROM the oven AND let cool.</li><li> FOR the Filling:</li><li> IN a medium sized bowl whisk together condensed milk, cornstarch AND salt.</li><li> ADD egg yolks one AT a TIME, whisking UNTIL combined AFTER EACH addition.SET aside.</li><li> IN a medium sized saucepan melt butter OVER moderate heat.</li><li> ADD brown sugar AND allow TO bubble slightly.</li><li>Slowly whisk IN milk.</li><li> ADD egg mixture slowly, whisking constantly.</li><li>Bring back TO a boil WHILE whisking the mixture.</li><li>Once the mixture IS boiling, let it cook WHILE stirring FOR approximately one MINUTE OR UNTIL thick.</li><li>Remove FROM heat AND stir IN whiskey.</li><li>Pour INTO a cooled pie shell AND cover WITH plastic wrap.</li><li>Place IN the fridge AND let SET FOR four hours.</li><li>You may serve the pie WITH whipped cream IF you wish, but I find it so rich that I LIKE TO eat it au naturale.</li></ol>  irish  45  10  t  f  f  f
191  Kale Colcannon  https://spoonacular.com/recipeImages/Kale-Colcannon-648718.jpg  <ol><li>Cook potatoes IN a pot OF boiling water UNTIL tender;
drain, reserving water.</li><li>Place potatoes IN a LARGE bowl AND mash potatoes WITH a hand masher OR put through a ricer.ADD 2 tablespoons butter, milk, salt AND pepper TO potatoes AND gently mix UNTIL combined.</li><li> ADD chopped kale TO the reserved potato water.Cook 6-8 minutes OR UNTIL tender.Drain well AND chop.</li><li>Meanwhile, saut chopped onions IN 2 tablespoons butter ON medium-high UNTIL slightly brown.ADD TO potato mixture AND combine.</li><li>Serve hot.</li></ol>  irish  45  4  f  f  t  f
192  Mussels IN Irish Ale  https://spoonacular.com/recipeImages/Mussels- IN -Irish-Ale-652760.jpg  <ol><li> DISCARD ANY mussels that are OPEN BEFORE cooking AND ANY that stay closed AFTER cooking.</li><li>Place a LARGE pot OVER a high heat AND brown the pancetta pieces UNTIL just golden AND sizzling.ADD IN a knob OF butter, allow it TO melt AND THEN ADD the onion AND garlic.Cook gently FOR three minutes UNTIL the onion IS soft.</li><li> ADD IN the cider AND allow TO bubble away FOR a few minutes so ALL the flavours mingle IN together.Tumble IN the mussels, cover WITH a lid AND allow them TO steam FOR about four minutes UNTIL they OPEN, making sure TO give the pot a good shake once OR twice during the cooking TIME.</li><li>Remove FROM the heat AND stir IN the cream AND parsley AND season WITH sea salt AND ground black pepper.</li><li>Serve WITH SOME crusty bread TO mop up the liquid!</li></ol>  irish  45  4  f  f  f  f
193  Oatmeal, Apricot, Walnut Soda Bread  https://spoonacular.com/recipeImages/Oatmeal--Apricot--Walnut-Soda-Bread-653500.jpg	<ol><li>In a medium bowl, combine 2 c. oats and buttermilk. Let sit for 1 hour.</li><li>Adjust oven rack to the upper-middle position and preheat to 400 degrees f. In a large bowl, combine flours, remaining 1/2 c. oats, brown sugar, baking soda, cream of tartar and salt. Add in the 2 T. softened butter and using your fingertips, rub the butter into the flour until the texture resembles coarse crumbs.</li><li>After the oats have soaked for an hour add the egg and mix well. Add this mix into the flour mixture along with the walnuts and apricots. Mix with a fork until it starts to come together (it still is going to be very loose). Turn the mix out onto a floured surface and knead a few times (around 12-14 times or so) to get everything to come together. Don''t overdo it with the kneading or the bread will be tough.</li><li>Shape the dough into a round shape that is 6-inches in diameter and 2-inches high. Place on a large parchment-lined (or greased) baking sheet. Using a serrated knife, make a large X in the top of the loaf. Bake for 45- 50 minutes, until a skewer inserted in the center comes out clean. As soon as it is out of the oven, brush the crust with the melted butter. Let cool to room temperature before slicing.</li></ol>	irish	45	8	f	f	f	f
194  Raspberry Soda Bread  https://spoonacular.com/recipeImages/Raspberry-Soda-Bread--New-Take-On-An-Irish-Tradition-657898.jpg	<ol><li>Preheat oven to 325 degrees Grease two 8x4 inch loaf pans or muffins tins.</li><li>Mix the flour, sugar, baking soda, baking powder and salt. Add the eggs, sour cream and milk or half and half in necessary and mix until just combined. Gently fold in frozen raspberries. Distribute batter in the greased pans.</li><li>Allow the batter to sit for 20 min before baking.</li><li>Bake at 325 degrees for 1 hour. Muffins may take 10-15 min less.</li><li>Allow the bread rest and cool before serving.</li></ol>	irish	45	2	t	f	f	f
195  Rosemary Rum Raisin Soda Bread WITH Pecans  https://spoonacular.com/recipeImages/Rosemary-Rum-Raisin-Soda-Bread- WITH -Pecans-658803.jpg  <ol><li>Combine the rum AND raisins IN a small saucepan.Bring TO a boil.Simmer FOR 30 seconds, THEN remove FROM heat.Cover AND allow the raisins TO macerate FOR AT least 4 hours, but preferably overnight.</li><li> WHEN youre ready TO bake the bread, preheat the oven TO 375F.</li><li>Coat a baking sheet WITH olive oil AND lightly dust it WITH flour, OR LINE it WITH parchment paper.</li><li> IN a LARGE mixing bowl whisk together the flours, baking soda, salt, AND rosemary.Stir IN the toasted pecans.</li><li> IN a separate bowl combine the raisins WITH the rum, the yogurt, AND honey.</li><li> ADD the wet ingredients TO the dry.Mix UNTIL the dough IS too stiff TO stir.Use your hands TO bring it together IN the bowl.ADD additional yogurt one teaspoon AT a TIME IF its too dry.You want a stiff, slightly tacky ball.</li><li>Turn dough onto a lightly floured board AND shape INTO a round loaf.(Dont OVER -knead the dough.Too much kneading will produce a tough bread.).</li><li>Transfer the loaf TO the PREPARED baking sheet.Use a sharp knife TO make deep slashes across the top OF the loaf, 4-6 cuts about half way through.Brush the top WITH milk.Sprinkle WITH seeds OR oats IF USING.</li><li>Bake FOR 40-45 minutes, UNTIL a toothpick comes OUT clean.WHEN you tap the loaf, it will sound hollow.</li><li>Cool ON a wire rack.Serve warm OR AT room temperature WITH a generous slather OF butter.</li></ol>  irish  45  16  t  f  f  f
196  Slow Cooked Corned Beef AND Cabbage  https://spoonacular.com/recipeImages/Slow-Cooked-Corned-Beef- AND -Cabbage-660266.jpg  <ol><li>Stir the broth AND vinegar INTO a 6-quart slow cooker.ADD the onions, potatoes, carrots, beef AND cabbage.Submerge the Bouquet Garni IN the broth mixture.</li><li>Cover AND cook ON LOW FOR 8 TO 9 hours OR UNTIL the beef IS fork-tender.Remove the Bouquet Garni.</li></ol>  irish  45  10  f  f  t  t
197  Vegan Colcannon Soup  https://spoonacular.com/recipeImages/Vegan-Colcannon-Soup-664419.jpg  <ol><li>Heat the oil IN a LARGE stockpot SET OVER medium-high heat, UNTIL it shimmers.ADD the leeks, garlic, AND celery, AND cook, stirring frequently, FOR 3 TO 4 minutes, UNTIL the edges are golden.ADD the parsnips, potatoes, cabbage, kale, stock, salt, AND pepper AND stir well.Reduce the heat TO medium AND cover.</li><li>Bring the soup TO a boil;
THEN reduce the heat TO a low simmer.Cook FOR 30 TO 35 minutes, UNTIL the vegetables are tender AND soft.ADD the lemon juice.</li><li> USING an immersion blender ( OR working IN batches IN a blender), pure UNTIL completely smooth.Serve immediately OR store IN an airtight container FOR up TO 3 days.</li></ol>  irish  45  8  t  t  t  t
198  Xocai Irish Cream WITH Xocai Healthy Dark Chocolate Nuggets  https://spoonacular.com/recipeImages/Xocai-Irish-Cream- WITH -Xocai-Healthy-Dark-Chocolate-Nuggets-665480.jpg  <ol><li>Heat Irish cream syrup.Remove FROM heat AND ADD Nuggets.Stir UNTIL melted.Cool.Mix 2 tbsp.OF cream mixture WITH 2 tbsp.OF whiskey AND ADD TO 1 cup OF hot coffee.Repeat WITH SECOND cup.Garnish WITH whipped cream AND grated Nugget.Serves 2</li></ol>  irish  45  2  f  f  f  f
199  Asparagus Lemon Risotto  https://spoonacular.com/recipeImages/Asparagus-Lemon-Risotto-632935.jpg  <ol><li> IN a LARGE saucepan, combine broth AND water.Bring TO a simmer.Keep warm OVER low heat.</li><li>Heat oil IN a LARGE Dutch oven OVER medium heat.ADD onion;
saute 5 minutes OR UNTIL tender.ADD garlic;
saute 30 seconds.ADD rice;
cook 2 minutes, stirring constantly.Stir IN wine;
cook 2 minutes OR UNTIL liquid IS nearly absorbed, stirring constantly.Mix IN pepper.ADD broth mixture, 1/2 cup AT a TIME, stirring constantly, cook UNTIL EACH portion OF broth IS absorbed BEFORE adding the NEXT (about 25 minutes).ADD asparagus, AND frozen peas, during the LAST 10 minutes OF cooking.Remove FROM heat;
stir IN cheese AND remaining ingredients.</li><li>T(Cooking):"0:40"</li><li>NOTES :</li></ol>  italian  45  4  f  f  t  f
200  Crispy Italian Cauliflower Poppers Appetizer  https://spoonacular.com/recipeImages/Crispy-Italian-Cauliflower-Poppers- WITH -Marinara-640819.jpg  <ol><li>Preheat oven TO 400 f.Brush a LARGE baking sheet WITH a tablespoon OF the olive oil.IN a LARGE, shallow dish combine the breadcrumbs, Parmesan, garlic powder, salt, pepper AND 2 tablespoons OF the olive oil.Toss well WITH a fork UNTIL the oil IS completely dispersed INTO the bread crumbs.Combine the eggs WITH 1 tablespoon OF water IN a medium bowl.Place the flour IN a LARGE resealable bag.</li><li> ADD half OF the cauliflower florets TO the bag WITH the flour, seal AND shake TO coat well.Remove the cauliflower TO a fine mesh strainer AND shake TO remove excess flour.Place the floured cauliflower ON a plate.Repeat WITH the remaining cauliflower.</li><li>Working WITH a few pieces AT a TIME.ADD TO the beaten egg.USING a fork, turn AND toss the florets IN the egg TO completely coat.Transfer TO the breadcrumb mixture AND coat, pressing the crumbs INTO the florets, the help them adhere.Place ON the oiled baking sheet, making sure you leave a little space BETWEEN EACH florets so they crisp up really well.Repeat this step WITH the rest OF the cauliflower.Spray the tops OF the breaded florets lightly WITH cooking spray.Bake the cauliflower FOR 20 minutes, Flip the pieces OVER AND CONTINUE baking FOR about 15 more minutes, UNTIL the cauliflower IS crunchy ON the outside AND tender ON the inside.</li><li> WHILE the cauliflower IS baking, PREPARE the marinara.Pulse the undrained tomatoes IN a food processor a few times UNTIL mostly broken down.Heat 1 tablespoon OF the oil WITH the garlic AND pepper flakes IN a medium saucepan OVER medium heat UNTIL just sizzling.ADD the tomatoes AND simmer FOR about 10 minutes UNTIL the marinara thickens slightly AND the flavors develop.ADD 2 tablespoons OF the fresh basil, season WITH salt AND pepper IF needed.</li><li> WHEN the cauliflower IS done baking, transfer TO a serving dish AND sprinkle WITH the remaining basil.Serve WITH the marinara.</li></ol>  italian  45  4  f  f  f  f
201  Easy Cheesy Pizza Casserole  https://spoonacular.com/recipeImages/Easy-Cheesy-Pizza-Casserole-641893.jpg  <ol><li>Brown ground beef IN skillet;
drain fat.Mix IN pasta OR pizza sauce AND pepper flakes;
SET aside.Mix ricotta cheese WITH the herbs AND Parmesan IN a separate bowl;
SET aside.</li><li>Mix the dry ingredients FOR the biscuits.ADD milk AND stir UNTIL combined.</li><li>Preheat oven TO 375 degrees.Spray a 13 x 9 pan WITH non-stick spray.DROP biscuit dough BY teaspoons IN the bottom OF pan, spacing evenly.It''s OK IF there IS space BETWEEN the dough--it will expand as it''s cooked.  Top with ground beef mixture and dot with the ricotta cheese mixture.  Bake at 375 for about 20 min or until biscuits are puffed and beginning to get golden brown.</li><li>Top with mozzarella and provolone cheeses and distribute pepperoni slices evenly over top, increase oven temperature to 425 degrees.  Return to oven and bake until cheeses are melted and beginning to bubble.  This should take about 10 minutes.</li><li>Remove from oven and let stand 5 minutes before slicing and serving.  May be topped with the additional Parmesan cheese.</li></ol>	italian	45	6	f	f	f	f
202  Easy Skillet Garden Lasagna  https://spoonacular.com/recipeImages/Easy-Skillet-Garden-Lasagna-642095.jpg  <ol><li>Preheat oven TO 425 F.</li><li>Boil water FOR pasta AND cook pasta according TO directions, shaving a few minutes OFF the TIME.</li><li>Meanwhile water IS boiling OR pasta IS cooking, heat a LARGE oven-safe skillet OVER medium heat AND ADD olive oil.</li><li> ADD IN your veggies AND garlic, tossing TO coat FOR about 10 minutes OR UNTIL softened.IF USING spinach, ADD it LAST towards the END since it cooks really fast.Season WITH salt AND pepper.</li><li> ADD sauce, mozzarella AND cooked lasagna noodles TO the skillet WITH the veggies, gently tossing TO distribute.</li><li>Cover WITH scoops OF ricotta AND sprinkle WITH fresh basil IF you''d LIKE.</li><li>Bake FOR 15-20 minutes, OR UNTIL cheese IS golden AND bubbly.Serve WITH extra parmesan IF you are a cheese lover LIKE me!</li></ol>  italian  45  4  f  f  f  f
203  Hearty Minestrone Soup  https://spoonacular.com/recipeImages/Hearty-Minestrone-Soup-646577.jpg  <ol><li> START BY simmering your chicken stock ON the stove.WHILE it IS simmering dice your onions, SLICE your carrots, crush your garlic, AND ADD them TO the pot.THEN ADD the half can OF tomato sauce AND let the mixture cook ON low TO medium heat.NEXT ADD your diced tomatoes, potatoes, spinach, AND beans.Keep the mixture ON medium heat UNTIL your potatoes START TO soften.THEN you can turn the heat low AND let it cook FOR AS long AS you would LIKE.I seasoned the soup WITH Kosher salt, fresh cracked pepper, red pepper flakes, </li><li>A touch OF paprika AND a touch OF Madras curry powder.You can season WITH whatever you would LIKE TO cater TO your taste.WHEN you are ready TO eat the soup turn the heat back up AND bring it TO a low boil adding the pasta.You can turn it back down TO low WHEN the pasta IS starting TO GET TO al dente status.THEN CONTINUE TO cook ON low UNTIL the pasta IS cooked TO your liking.We topped our individual bowls OF the minestrone WITH a little shredded parmesan cheese! Hope you enjoy!</li></ol>  italian  45  1  f  f  f  t
204  Insalata Caprese WITH Pesto Vinaigrette  https://spoonacular.com/recipeImages/Insalata-Caprese- WITH -Pesto-Vinaigrette-647922.jpg  <ol><li> ON a serving plate alternate slices OF mozzarella AND tomatoes.</li><li>Sprinkle WITH half OF basil.</li><li> IN a blender OR food processor blend basil AND ALL remaining ingredients together UNTIL smooth.</li><li>Drizzle OVER salad.</li></ol>  italian  45  1  f  f  t  f
205  Italian Sausage AND Vegetable Soup  https://spoonacular.com/recipeImages/Italian-Sausage- AND -Vegetable-Soup-648238.jpg  <ol><li>Heat oil IN LARGE pot OVER medium heat AND ADD sausages, WITHOUT the casings.</li><li>Mix sausage UNTIL it IS broken up INTO small pieces AND cook UNTIL sausages IS browned AND almost cooked through.</li><li> ADD carrots, onions, bay leaf, Italian seasoning, red pepper flakes AND salt AND pepper.Cook 5-6 minutes longer, UNTIL onions START TO soften.</li><li> ADD chicken stock AND diced tomatoes.Bring stock up TO a simmer.Once the stock IS AT a simmer, reduce heat TO low AND simmer WITH the top ON UNTIL vegetables are tender, about 10 minutes longer.</li><li>Turn the heat OFF AND ADD cannellini beans AND spinach AND stir IN UNTIL spinach wilts.</li></ol>  italian  45  6  t  t  t  t
206  Italian Seafood Stew  https://spoonacular.com/recipeImages/Italian-Seafood-Stew-648247.jpg  <ol><li> PREPARE ingredients.</li><li> IN a LARGE pot, heat up 3 tbsp OF olive oil AND ADD garlic AND onion.Sautee OVER medium heat.</li><li> ADD salt, tomato paste, tomatoes WITH juice, stock, club soda, bay leaves AND stir.</li><li>Simmer OVER medium low heat FOR 30 min.</li><li> ADD mushrooms.</li><li> ADD salt TO taste.</li><li>Cook mussels according TO package directions.</li><li> ADD shrimp AND fish INTO stew.</li><li> ADD mussels.</li><li>Simmer FOR a few minutes.</li><li>Ready TO serve WITH SOME baked bread.</li></ol>  italian  45  3  f  f  t  t
207  Italian Steamed Artichokes  https://spoonacular.com/recipeImages/Italian-Steamed-Artichokes-648257.jpg  <ol><li>Snip the thorns OFF the artichoke leaves.Place the garlic slices inside the leaves throughout the artichoke.Put the artichoke INTO a medium-size saucepan.ADD water TO come halfway up the artichoke.</li><li>Put the bay leaf IN the water.</li><li>Crush the coriander seeds, oregano AND basil together;
sprinkle ON top OF the artichoke.</li><li>Cook OVER medium heat FOR 30 minutes, OR UNTIL the leaves pull OFF easily.</li></ol>  italian  35  1  t  t  t  t
208  Italian Tuna Pasta  https://spoonacular.com/recipeImages/Italian-Tuna-Pasta-648279.jpg  <ol><li>Once pasta IS cooked, drain AND leave TO cool FOR a MINUTE.</li><li>Place small skillet ON medium fire, drizzle olive oil, ADD IN red pepper AND stir-fry FOR 1-2 minutes.Put aside.</li><li>Toss pasta shells, red pepper, tuna, parsley, garlic, chilies AND lemon juice.Season WITH ground black pepper TO taste, spoon INTO serving bowls.Stir through ricotta AND serve immediately.</li></ol>  italian  20  3  f  f  f  t
209  Pappa Al Pomodoro  https://spoonacular.com/recipeImages/Pappa-Al-Pomodoro-654614.jpg  <ol><li>Warm the olive oil AND garlic IN a medium cooking pot.WHEN the garlic has coloured slightly, ADD the leeks.Saute OVER a low heat FOR 20 minutes, adding water AS necessary TO keep the vegetables FROM turning brown.</li><li>Stir IN the stock AND pured tomatoes AND bring TO the boil, THEN reduce the heat AND simmer gently FOR 20 minutes.</li><li>Turn OFF the heat AND ADD the bread, pushing it INTO the liquid WITH a wooden spoon.</li><li>Stir IN the torn basil leaves AND season TO taste WITH salt AND pepper.Leave TO rest FOR 30 minutes.</li><li>Now whisk the soup energetically UNTIL it has a porridge- LIKE consistency.Taste AND adjust the seasoning.</li><li>Ladle INTO bowls, drizzle WITH extra-virgin olive oil AND serve.</li></ol>  italian  45  4  f  f  f  t
210  Roasted Brussels Sprouts WITH Garlic  https://spoonacular.com/recipeImages/Roasted-Brussels-Sprouts- WITH -Garlic-658515.jpg  <ol><li>Heat oven TO 450 degrees.TRIM bottom OF Brussels sprouts AND remove ANY undesirable OUTER leaves.SLICE EACH sprout IN half FROM top TO bottom.</li><li>Heat oil IN a LARGE heavy skillet OVER medium-high heat;
put sprouts cut side down IN one layer IN pan.ADD garlic, AND sprinkle WITH salt AND pepper.</li><li>Cook, undisturbed, UNTIL sprouts BEGIN TO brown ON bottom, AND transfer TO oven.Cook, shaking pan occasionally, UNTIL sprouts are quite brown AND tender, about 1/2 HOUR.</li><li>Taste, AND adjust seasoning IF necessary.Stir IN balsamic vinegar, AND serve hot OR warm.</li></ol>  italian  45  4  t  t  t  t
211  Salmon Quinoa Risotto  https://spoonacular.com/recipeImages/Salmon-Quinoa-Risotto-659109.jpg  <ol><li> IN a 4 quart saucepan, heat 2 tablespoons OF olive oil OVER medium high heat.</li><li> WHEN oil IS shimmering, ADD diced onion.</li><li>Saute onion UNTIL transparent.ADD quinoa TO onion mixture AND stir, TO TOAST quinoa, FOR 2 minutes.</li><li> ADD 1 cup OF vegetable stock TO quinoa AND onions.</li><li>Stir UNTIL stock IS absorbed.Once stock IS absorbed, ADD 1 cup OF stock.</li><li> CONTINUE stirring UNTIL stock IS absorbed.</li><li> ADD remaining stock IN 1/2 cup intervals, stirring UNTIL ALL stock IS absorbed.</li><li>Remove FROM heat.</li><li> WHILE preparing the onion quinoa mixture, heat 1 tablespoon OF oil IN a saute pan WITH chopped garlic ( OVER medium high heat).</li><li>Once garlic IS sizzling, ADD chopped kale TO the pan.</li><li>Turn kale TO coat WITH oil AND garlic.</li><li>Turn kale mixture UNTIL fragrant (approximately 2 minutes).Remove kale mixture FROM heat.</li><li>Once quinoa IS complete, ADD kale AND salmon.</li><li>Stir TO combine.</li><li> ADD salt AND pepper TO taste.</li></ol>  italian  45  4  f  f  t  t
212  Vegetable Minestrone Soup  https://spoonacular.com/recipeImages/Vegetable-Minestrone-Soup-664565.jpg  <ol><li> IN a deep sauce pan OR pot, heat about 2 tsps OF oil OR butter.ADD bay leaf.WHEN the bay leaf begins TO splutter, ADD finely chopped onions AND saute FOR a couple OF mins UNTIL the onions are translucent.</li><li> IN the meanwhile, boil water WITH a pinch OF salt IN another pot.ADD pasta AND cook FOR about 6 TO 7 mins.WHEN done, drain ALL the water AND SET the pasta aside.</li><li> ADD the chopped zucchini AND chopped carrots TO the sauteed onions.Now, ADD salt AND ground pepper AND saute FOR a couple OF mins.Empty the diced tomato cans INTO the sauce pan now.ADD the remaining spices  red chili powder AND dried basil TO the tomatoes.Cover AND let cook FOR AT least 5 mins.</li><li>Empty the cannellini beans INTO a bowl.Rinse under running water TO drain OUT ALL the canned liquid AND ADD the beans TO the sauce pan.ALSO, ADD the cooked pasta now.ADD about 2 cups OF water, cover AND let cook FOR about 15 mins.Give a taste test AND adjust salt IF needed.</li><li>Serve WITH a HINT OF grated Parmesan cheese AS garnish AND SOME bread TO dip INTO it!</li></ol>  italian  30  4  f  f  f  f
213  Veggie Lasagna Rolls WITH Peppery Pecorino Marinara  https://spoonacular.com/recipeImages/Veggie-Lasagna-Rolls-W--Peppery-Pecorino-Marinara-664737.jpg	<ol><li>PREHEAT THE OVEN TO 425*</li><li>COOK THE LASAGNA NOODLES PER PACKAGE</li><li>INSTRUCTIONS. RINSE W/ COOL WATER, DRAIN &amp;</li><li>SET ASIDE.</li><li>COMBINE ALL THE INGREDIENTS FOR THE RICOTTA  FILLING &amp; SET ASIDE.</li><li>BEGIN THE SAUCE. PLACE THE GARLIC &amp; OLIVE OIL IN  A SAUTE PAN, COOK UNTIL THE GARLIC JUST STARTS TO BROWN. ADD THE CANNED TOMATOES ALL AT ONCE AND COOK FOR 1-2 MINUTES. THE TOMATO JUICE WILL START TO CARAMELIZE. CRUSH THE WHOLE TOMATOES WITH THE BACK OF A SPOON. ADD THE DRIED BASIL, OREGANO AND SAGE AND COOK DOWN AT MEDIUM HAT FOR ABOUT 20 MINUTES, UNTIL THE SAUCE IS THICK. ADD THE CHEESE AND COOK FOR ANOTHER MINUTES, STIRRING THE CHEESE INTO THE SAUCE.</li><li>LAY THE LASAGNA NOODLES OUT ON A CUTTING BOARD AND SPREAD WITH THE RICOTTA FILLING. DIVIDE THE SPINACH EQUALLY ON THE NOODLES AND THEN TOP WITH THE BASIL LEAVES.</li><li>SPRINKLE THE MUSHROOMS AND ZUCCHINI ON TOP AND ROLL THE NOODLES MAKING A ROLLED NOODLE.</li><li>PLACE A SMALL SPOONFUL OF MARINARA IN A DISH, PLACE THE LASAGNA ROLLS ON TOP OF THE SAUCE. BAKE ABOUT 15 MINUTES UNTIL THE ROLLS ARE HOT AND THE SPINACH IS JUST WILTED.</li><li>TOP WITH THE MARINARA AND SOME SHAVED PECORINO. SERVE HOT.</li></ol>	italian	45	6	f	f	f	f
214  Japanese Vegetable Stew  https://spoonacular.com/recipeImages/japanese_vegetable_stew-17913.jpg NONE japanese  45  1  t  t  t  t
215  Japanese Salad Dressing  https://spoonacular.com/recipeImages/japanese_salad_dressing-37513.jpg NONE japanese  12  1  t  t  t  t
216  Baked Teriyaki Chicken Drumsticks  https://spoonacular.com/recipeImages/Baked-Teriyaki-Chicken-Drumsticks-633841.jpg  <ol><li> IN a LARGE bowl, mix teriyaki sauce, salt vegetable oil, honey, AND ginger.ADD the chicken TO the marinade.Let the chicken marinade FOR about 4-5 hours.</li><li>Preheat oven TO 450 degrees.ADD the sliced onions AND diced garlic ON the baking pan.Lay the chicken ON top OF the onions AND garlic.Bake the chicken FOR 30 minutes turning once UNTIL cooked.</li></ol>  japanese  45  1  f  f  t  t
217  Beef Teriyaki Stir Fry  https://spoonacular.com/recipeImages/Beef-Teriyaki-Stir-Fry-634710.jpg  <ol><li>Whisk ingredients together IN a small bowl AND refrigerate FOR AT least 30 minutes.</li><li>Heat oil IN a LARGE frying pan OVER medium heat.ADD beef AND saut FOR 3-4 minutes just TO brown it ON ALL sides.</li><li>Remove FROM pan AND SET aside.</li><li> ADD vegetables AND saut FOR 5 minutes more, UNTIL beginning TO soften.</li><li>Stir IN teriyaki sauce AND allow mixture TO come TO a simmer.</li><li> ADD beef AND ANY drippings that have accumulated ON the plate.Cook FOR 5 minutes, stirring occasionally.</li><li> IN a small bowl, combine cornstarch WITH 2 tsp cold water TO dissolve.Stir INTO the pan OF beef AND vegetables.Allow the mixture TO simmer AND thicken FOR 2 minutes.Toss TO evenly coat vegetables AND beef IN teriyaki sauce.Serve.</li></ol>  japanese  45  2  f  f  t  t
218  Chicken Teriyaki WITH Soba Noodles  https://spoonacular.com/recipeImages/Chicken-Teriyaki- WITH -Soba-Noodles-638382.jpg  <ol><li>1. Preheat oven TO 400 degrees Fahrenheit.SLICE shiitakes INTO bite sized pieces.Place chicken breasts IN a 9 BY 13 glass dish.</li><li>2. Make sauce:IN a small bowel, ADD ALL the ingredients AND whisk together.</li><li>3. Pour sauce OVER chicken breasts.Place IN oven AND cook FOR 20 min.Take OUT OF oven AND ADD shiitakes.Toss shiitakes WITH the sauce that IS around the chicken, flip chicken.Place IN oven FOR 10 minutes more.Once done, take OUT OF oven.Let rest 5 minutes BEFORE slicing chicken INTO bite sized pieces.</li><li>4. Meanwhile, ADD water TO a medium pot.Once brought TO a boil, ADD soba noodles AND cook FOR 7 minutes till done.Drain AND rinse under cold water AND ADD back TO pot.ADD shitakes AND ALL OF sauce TO the soba noodles.Toss together.</li><li>5. ADD 1/2 the soba noodles AND shitakes TO EACH plate.ADD 1 sliced chicken breast TO EACH plate.Garnish WITH green onion AND sesame seeds.Serve immediately.</li><li>ENJOY!</li></ol>  japanese  45  2  f  f  f  t
219  Hokkaido Pomegranate Risotto  https://spoonacular.com/recipeImages/Hokkaido-Pomegranate-Risotto-646817.jpg  <ol><li>Method</li><li>Cut the top OF the hokkaido squash horizontally, scoop OUT the seeds AND THEN scrape OFF the flesh FROM the squash.(I got 1 cup OF flesh FROM a small hokkaido)</li><li>Heat oil IN a pan, ADD the garlic, onions AND the rice AND saute FOR a couple OF minutes, stirring continously, ON high flame.</li><li> ADD salt, pepper AND the finely chopped hokkaido squash AND mix well.</li><li>Reduce the heat TO low AND keep adding water little BY little, AS it IS absorbed.</li><li> WHEN the rice IS cooked, ADD the chives, the parmesan AND the pomegranate seeds, AND mix well.</li><li>Spoon the risotto INTO the hokkaido shell AND garnish it WITH pomegranate seeds, chives AND parmesan crisps AND serve hot.</li></ol>  japanese  45  2  f  f  t  f
220  Japanese Chicken Donburi  https://spoonacular.com/recipeImages/Japanese-Chicken-Donburi-648460.jpg  <ol><li> IN a deep 10-inch OR 12-inch frying pan OVER high heat, stir oil, onion, AND ginger UNTIL onion IS lightly browned, about 2 minutes.</li><li> ADD broth, soy sauce, AND sugar.ADD chicken TO pan.Bring TO a boil.</li><li> ADD spinach, cover, AND cook UNTIL wilted, about 1 MINUTE.Meanwhile, IN a small bowl, beat eggs TO blend.</li><li>Reduce heat TO low, evenly distribute mixture IN pan, AND pour IN eggs.WITH a spatula, push vegetables aside slightly so egg mixture can flow down through sauce.Cover AND cook just UNTIL eggs are softly SET, 2 TO 2 1/2 minutes.</li><li>Meanwhile, spoon rice INTO bowls.Top equally WITH egg-spinach mixture, INCLUDING juices.Sprinkle WITH tomato.</li></ol>  japanese  45  4  f  f  t  t
221  Japanese Clear Soup  https://spoonacular.com/recipeImages/Japanese-Clear-Soup-648462.jpg  <ol><li>1. IN a LARGE saucepan bring chicken stock TO a boil.Stir IN sherry AND soy sauce.Reduce heat AND simmer several minutes.</li><li>2. Arrange your choice OF garnishes IN small bowls TO pass AT the TABLE.</li><li>Ladle broth INTO soup bowls AND serve.</li><li>Microwave VERSION :1. Place chicken stock IN a deep 2-quart casserole.Microwave, uncovered, ON 100%% power UNTIL stock boils, about 5 TO 7 minutes.</li><li>2. Stir IN sherry AND soy sauce.Microwave ON 30%% power 2 minutes.</li><li>3. CONTINUE WITH step 2.</li></ol>  japanese  45  4  t  t  t  t
222  Japanese Coleslaw  https://spoonacular.com/recipeImages/Japanese-Coleslaw-648465.jpg  <ol><li>Brown almonds AND sesame seeds IN 1 tbsp.butter.Mix cabbage AND onions.Just BEFORE serving, ADD almonds, seeds AND crushed noodles TO cabbage AND mix WITH dressing.</li></ol>  japanese  45  1  f  f  f  t
223  Japanese Curry Puffs  https://spoonacular.com/recipeImages/Japanese-Curry-Puffs-648470.jpg  <ol><li>Preheat oven TO 350 degrees.</li><li> IN a pot OVER medium/high heat, ADD oil AND onions.Cook FOR 2 minutes.ADD potatoes AND carrots, cook FOR 5 minutes.ADD water AND bring TO the boil.Lower heat AND simmer FOR 15 minutes.ADD curry mix AND cook FOR another 10 minutes.</li><li> ON a sheet pan, cut puff pastry INTO squares (1 sheet should give you 4 squares) AND WITH a spoon, fill the middle OF 1/2 OF the squares you have.</li><li>Bake FOR 20 minutes OR UNTIL the crust IS a golden brown AND serve!</li></ol>  japanese  45  4  t  t  f  t
224  Japanese Fried Rice  https://spoonacular.com/recipeImages/Japanese-Fried-Rice-648474.jpg  <ol><li> IN a pan OVER medium heat, ADD oil, garlic AND cook FOR a MINUTE.ADD chopped carrots AND cook FOR 2 minutes.ADD chicken AND cook FOR 2-3 minutes, UNTIL the chicken IS cooked through.</li><li> ADD rice AND peas AND mix well.ADD soy sauce, tonkatsu sauce, black pepper AND salt, AND mix well.Push the rice TO one side AND break the eggs ON the clear side.Slowly scramble the eggs AND incorporate WITH the rice.Serve!</li></ol>  japanese  45  2  f  f  t  t
225  Japanese Noodle Soup  https://spoonacular.com/recipeImages/Japanese-Noodle-Soup-648481.jpg  <ol><li> IN a saucepan bring the water TO a boil WITH the kombu</li><li>Simmer the kombu FOR ONLY 2 minutes, THEN DISCARD.</li><li>Stir IN the bonito flakes OR Hon Dashi</li><li>Simmer, stirring FOR 3 minutes</li><li>Stir IN the soy sauce, the mirin, AND the sugar</li><li>Simmer the broth FOR 5 minutes</li><li> IN a pot OF water, cook the noodles till done, drain.</li><li> ADD carrots AND ginger TO broth AND simmer, covered, FOR 5 minutes</li><li>Stir IN the spinach, noodles AND tofu AND simmer 1 MINUTE </li><li> IN small bowl, stir together 1/2 cup broth AND miso</li><li>Pour miso back INTO pan OF broth.</li><li>Ladle soup INTO bowls AND sprinkle scallions ON top.</li></ol>  japanese  45  1  t  t  f  t
226  Japanese Mushroom Noodle Soup  https://spoonacular.com/recipeImages/Japanese-Mushroom-Noodle-Soup-648483.jpg  <ol><li>Break noodles IN half;
cook according TO package directions.Meanwhile, IN LARGE saucepan, heat chile oil OVER medium heat.ADD mushrooms, garlic AND ginger;
cook 5 minutes, stirring occasionally.ADD broth, mirin AND soy sauce;
bring TO a boil.Simmer, uncovered, 10 minutes, stirring once.</li><li>Drain noodles, stir INTO soup.Stir IN green onions AND sesame oil.Ladle INTO shallow soup bowls.</li></ol>  japanese  45  4  f  f  f  t
227  Japanese Salmon WITH Sesame Seeds  https://spoonacular.com/recipeImages/Japanese-Salmon- WITH -Sesame-Seeds-648493.jpg  <ol><li>Place salmon IN marinade made BY mixing soy sauce, hot pepper, honey, vinegar, AND 1 tbsp.sesame oil AND allow TO marinate FOR 2 hours.Lift fish FROM marinade, AND dry well ON paper towels.</li><li>Heat remaining sesame oil IN skillet.ADD salmon scallops AND saute quickly, turning once, about 2 minutes ON EACH side.Sprinkle WITH sesame seeds AND scallions.</li></ol>  japanese  45  4  f  f  t  t
228  Japanese Steak Salad  https://spoonacular.com/recipeImages/Japanese-Steak-Salad-648500.jpg  <ol><li> PREPARE Sesame Marinade AND Dressing.Place beef top sirloin steak IN plastic bag;
ADD reserved marinade, turning TO coat.CLOSE bag securely AND marinate IN refrigerator 2 hours, turning once.Remove FROM marinade;
place ON rack IN broiler pan so surface OF meat IS 3 TO 4 inches FROM heat.Broil 14 TO 16 minutes TO doneness desired (rare TO medium-rare), turning once.Let stand 5 minutes.Carve steak INTO thin slices.</li><li>Meanwhile, combine napa cabbage, romaine, carrots AND radishes;
place an equal amount OF EACH ON 4 individual plates.Arrange an equal number OF cucumber slices IN CIRCLE AT top OF salad greens ON EACH plate.Mound 1/4 cup rice ON EACH cucumber CIRCLE.Fan pea pods around BOTH sides OF rice.Arrange steak slices AS spokes ON salad greens, radiating down FROM rice.Serve dressing WITH salad.Makes 4 servings.</li><li>Combine dry sherry, soy sauce, vinegar, hoisin sauce AND ginger;
mix well.Divide mixture IN half;
reserve half FOR steak marinade.TO PREPARE dressing, combine remaining mixture WITH water, green onion, sugar AND oil;
mix well.Yield:1/3 cup marinade;
3/4 cup dressing.</li></ol>  japanese  45  8  f  f  t  t
229  Japanese Souffle Cheesecake  https://spoonacular.com/recipeImages/Japanese-Souffle-Cheesecake-648501.jpg  <ol><li> ADD 500 ml water INTO a big baking tray ( that the tin you use FOR the cheesecake can fit IN ) AND place the tray IN the oven THEN preheat the oven TO 160 C.Line the base AND side OF a 18-20 cm springform/cake tin WITH parchment paper.THEN use a big piece OF foil TO wrap the tin around FROM the bottom upto top OF the tin side.</li><li>Place the butter, creamcheese AND milk IN a bowl SET OVER a saucepan OF barely simmering water, being careful NOT TO let the bowl touch the water, THEN wait UNTIL the butter has melted, remove the bowl FROM the heat AND give it a really good stir UNTIL the mixture IS smooth, SET aside AND leave TO cool AT the room temperature.</li><li> ADD the orange juice AND zest TO the creamcheese mixture, stir TO blend THEN ADD the yolks AND mix them UNTIL incorperated.Sift the flour AND salt INTO another mixing bowl, pour OVER the cream cheese AND egg mixture IN the center OF thr flour.Quickly whisk OR stir everything UNTIL just blended ( don''t overmix OR the cake will be tough) </li><li> IN a seperate mixing bowl, beat the egg white WITH cream OF tartar UNTIL foamy, THEN gradually ADD the sugar, few tablespoons AT a TIME, AND CONTINUE TO beat AT high speed UNTIL reach the soft-medium peak ( more than soft but NOT hard peak).Gently fold the white INTO the creamcheese mixture UNTIL blended.</li><li>Pour the batter INTO the PREPARED tin.Place the tin IN the preheated baking tray AND bake FOR 50-60 minutes OR UNTIL a toothpick inserted FROM center comes OUT clean.Turn the cake OUT ON TO a wire rack once taken FROM the oven ( the cake will shrink IF LEFT too long IN the tin!).Leave TO cool AT room temperature, THEN let it SET IN the fridge FOR another HOUR OR so BEFORE slicing AND serve.</li></ol>  japanese  45  1  f  f  f  f
230  Japanese Style Curry  https://spoonacular.com/recipeImages/Japanese-Style-Curry-648504.jpg  <ol><li>Whisk the curry powder INTO 1 cup cold water IN a small bowl AND SET aside.</li><li>Heat the oil IN a LARGE pot OVER medium-high heat.ADD the onions AND salt AND saute, stirring occasionally, UNTIL the onions are translucent, about 8 minutes.</li><li> ADD the mushrooms AND saute UNTIL they BEGIN TO soften, about 2 minutes.Stir IN the potatoes AND saute FOR 1 MINUTE more.ADD 4 cups cold water AND the curry mixture AND bring TO a boil.Reduce the heat TO low, cover AND simmer, stirring occasionally, UNTIL the potatoes can easily be pierced WITH a fork, about 20 minutes.</li><li>Whisk the cornstarch OR potato starch WITH the tamari AND 2 tablespoons cold water IN a small bowl.ADD TO the curry AND stir gently UNTIL the sauce thickens.</li><li>Gently stir IN the tofu, IF USING, AND the peas AND cook UNTIL heated through, 5 TO 10 minutes.Taste AND adjust the seasonings WITH additional curry powder, salt AND - OR tamari, IF desired.IF you LIKE, serve WITH small bowls OF raisins AND walnuts ON the side.</li></ol>  japanese  45  1  f  f  t  t
231  Japanese Sushi  https://spoonacular.com/recipeImages/Japanese-Sushi-648506.jpg  <ol><li>Recipe one:Pour cooked rice INTO a tray.Finely SLICE the salmon AND the tuna.</li><li>Put the seaweed onto a sushi mat AND press rice down onto it.</li><li> SLICE the mushrooms AND asparagus pieces AND lay along the rice.ADD the wasabi.Roll the sushi AND cut INTO slices.Serve WITH salmon caviar, wasabi AND soy.</li><li>Recipe two:Squeeze the rice INTO balls AND press the prawns, tuna OR salmon INTO the top.</li></ol>  japanese  45  1  f  f  t  t
232  Kyuri Tsukemono  https://spoonacular.com/recipeImages/Kyuri-Tsukemono-649137.jpg  <ol><li>Rough chop cucumbers.</li><li> IN a medium, securely sealable container, combine soy sauce, rice vinegar, AND sesame oil.</li><li> ADD cucumbers TO the marinade, CLOSE container AND shake.</li><li>Refrigerate FOR 1 TO 2 hours.Shake cucumbers periodically, OR leave overnight TO marinate.Note, the longer the cucumbers are LEFT IN the marinade the saltier they become.I''ve LEFT them IN the marinade FOR up TO 3 days AND the cucumbers were good.</li><li>Serve AND enjoy!</li></ol>  japanese  45  4  t  t  t  t
233  Miso Soup WITH Thin Noodles  https://spoonacular.com/recipeImages/Miso-Soup- WITH -Thin-Noodles-652078.jpg  <ol><li>Directions:</li><li> AFTER the miso has been PREPARED, START adding the "stuff" TO the soup pot.It can be your preference, but I opted TO START WITH the onions AND chives AND THEN added the zucchini, parsnip, carrots, mushrooms AND ginger.Cover the pot AND let cook ON a low flame FOR 20-30 minutes, tasting AS you go.ADD the tofu AND pasta, allowing the pasta TO cook FOR 8-10 minutes.Taste the soup, adding red pepper AND turn OFF flame WHEN ready.Place spinach ON the bottom OF your soup bowl.You can ALSO place the spinach directly IN the pot, but since it wilts so quickly I usually DO it this way.</li><li>What DO you usually ADD TO your Miso Soup?</li><li>Seriously Soupy Serena</li></ol>  japanese  45  8  t  t  f  t
234  Oriental Filet Mignon ON Crisp Kataifi WITH Shrimp Tempura  https://spoonacular.com/recipeImages/Oriental-Filet-Mignon- ON -Crisp-Kataifi- WITH -Shrimp-Tempura-654072.jpg  <ol><li>Combine the FIRST three ingredients IN a shallow dish AND ADD the filet mignon steaks.Spoon the marinade OVER them UNTIL they are well covered, SET aside FOR about 30 minutes, covered WITH plastic wrap.</li><li>Heat oven TO 400o.</li><li> LINE a baking sheet WITH parchment, AND divide the kataifi INTO two neat rounds.Drizzle lightly WITH a neutral oil, AND bake UNTIL golden AND crisp.Remove FROM oven AND SET aside.</li><li>Meanwhile, place the corn starch, whisked egg whites AND panko IN separate bowls.</li><li>Roll EACH shrimp FIRST IN the corn starch, THEN IN the egg whites AND the IN the panko.Pat them firmly WITH your palms TO make sure the panko sticks well.SET aside ON paper towels ON a plate OR tray.Repeat WITH the rest OF the shrimp.</li><li>Fill a LARGE deep skillet WITH oil (such AS Safflower OR Canola), enough TO cover the shrimp WHEN frying.</li><li>Turn BBQ TO high.Meanwhile, heat oil IN frying pan UNTIL very hot, AND fry the shrimp, turning once OR twice, FOR about 2 minutes UNTIL golden.Place back ON paper towels AND SET aside IN a lightly warmed oven.</li><li> WHEN BBQ IS very hot, remove steaks FROM marinade AND grill ON high FOR about 3-4 minutes ON EACH side.WHILE the steaks are grilling, ADD the rice vinegar, garlic, pepper flakes AND ginger TO the remaining marinade, AND warm it up IN a small saucepan UNTIL boiling, THEN SET aside.</li><li> TO serve:ON EACH dinner plate place one mound OF kataifi, topped BY sliced filet mignon, drizzle WITH 2 spoonfuls OF marinade AND top WITH 2 fried shrimp.Serve WITH your favorite steamed vegetable(s) OR stir fry.</li></ol>  japanese  45  2  f  f  f  t
235  Soba Noodle IN Kombu Dashi WITH Teriyaki Salmon  https://spoonacular.com/recipeImages/Soba-Noodle- IN -Kombu-Dashi- WITH -Teriyaki-Salmon-660493.jpg  <ol><li> TO make kombu dashi, soak the dried kelp/seaweed IN water FOR 2 hours.Put the kombu AND water IN a cooking pot.Put ON medium heat.Turn OFF the heat WHEN the water comes TO a boil.THEN, remove the kombu WITH a strainer.The remaining liquid IS your kombu dashi.You can leave SOME kombu IN the soup.</li><li>Cook the soba noodles according TO the packet.Drain AND SET aside.</li><li> TO make teriyaki salmon, marinate salmon filet/loin WITH sake, soya sauce, mirin, AND sugar.</li><li>Heat up a pan WITH oil.Put the skin side down AND cook FOR 3 minutes OR UNTIL crispy.Turn AND cook the other side FOR another 2-3 minutes.Pour ANY remaining sauce.</li><li>Remove FROM heat.Drizzle ANY remaining sauce FROM the frying pan.</li><li> TO serve the soba, heat up the broth.IN a bowl, serve good portion OF Soba noodles.Lardle good amount OF kombu dashi OVER the noodles.Garnish WITH goji berries IF desired.Place the teriyaki salmon ON top OF the noodles.Sprinkle WITH SOME toasted sesame seeds.</li></ol>  japanese  45  2  f  f  f  t
236  Classic Matzo Ball Soup  https://spoonacular.com/recipeImages/Classic-Matzo-Ball-Soup-639616.jpg  <ol><li>Wash the chicken WITH cold water AND place IN pot.Cover WITH water AND bring TO a simmer ( DO NOT boil OR your broth won''t be clear).</li><li>Skim OFF bubbling foam AS it forms.ADD celery, carrots, onion, herbs, salt AND pepper AND CONTINUE TO simmer FOR about 45 minutes.</li><li>Pour soup through strainer AND let cool.WHEN broth has completely cooled, remove the chicken meat AND skim OFF the fat AND save FOR the matzo balls.</li><li> IN a mixing bowl, mix together 4 eggs AND 4 tablespoons chicken fat ( OR vegetable oil).Stir IN the matzo meal AND salt.ADD 1/4 selter water.Cover AND refrigerate FOR AT least 1 HOUR.</li><li>Form the matzo dough INTO teaspoon-size balls.</li><li>Bring the chicken broth TO a boil.ADD the matzo balls, cover, AND cook FOR 20 minutes.</li><li>Serve immediately.</li><li>Garnish WITH fresh dill OR parsley.</li></ol>  jewish  45  6  f  f  t  t
237  Jewish Mandlebrot  https://spoonacular.com/recipeImages/Jewish-Mandlebrot-648587.jpg  <ol><li>1. IN medium bowl, combine eggs AND 1 cup EACH sugar AND salad oil.Beat UNTIL well combined.</li><li>2. Sift flour WITH baking powder INTO very LARGE bowl.</li><li>3. Make a well IN the center;
pour IN egg mixture.Stir around the bowl USING a wooden spoon, UNTIL well blended.</li><li>4. Turn dough OUT onto lightly floured pastry cloth.WITH flour knead UNTIL smooth, about 5 minutes.</li><li>5. Preheat oven TO 350 degrees.Grease lightly roasting pans OR cookie sheets.IN small bowl mix together filling (nuts, sugar, cinnamon AND raisins).</li><li>6. Divide dough INTO 5 equal parts.</li><li>7. Roll EACH INTO 10x12 rectangle.Roll OUT ON oiled surface.</li><li>8. Brush lightly WITH tsp.oil.Spread 5 tbsp.preserves;
sprinkle 1/2 cup mixture evenly around.FROM long side, roll AS FOR jelly roll;
pinch EACH END.</li><li>9. Place 5 loaves IN pans 1/2 inch apart.Put seam side up.Bake 45-50 minutes OR UNTIL golden brown.</li><li>10. Remove TO wire rack;
cool 10 minutes BEFORE removing FROM pan.Cool completely.Cut INTO 12 diagonal slices.IF desired, sprinkle WITH confectioners'' sugar..</li><li>11. Store covered IN cool, dry place.Mellows WITH age.</li></ol>  jewish  45  12  t  f  f  f
238  Jojo''s Potato Pancakes  https://spoonacular.com/recipeImages/Jojos-Potato-Pancakes-648608.jpg  <ol><li> AS you grate your potatoes have a LARGE bowl OF ice water ready TO put THEN IN so that they DO NOT brown.</li><li> ADD ALL other ingredients TO another bowl WITHOUT mixing.Drain potatoes well AND THEN place ON either a thin towel OR cheese cloth AND squeeze AS much OF the liquid OUT AS possible, THEN ADD TO the rest OF the ingredients AND mix.Use your hands TO bring mixture together AND make INTO small flat pancakes.IF the mixture IS too wet AND will NOT form THEN ADD a BIT more flour.ADD 1 OR 2 tablespoons OF olive oil TO a very hot frying pan AND fry one side OF the pancake UNTIL crispy AND brown.Flip AND cook the other side.Serve these hot WITH apple sauce OR sour cream.</li></ol>  jewish  45  16  t  f  t  t
239  Latkes  https://spoonacular.com/recipeImages/Latkes--Fried-Vegetable-Pancakes-from-Europe-and-the-Middle-East-649300.jpg	<ol><li>1. Skin the vegetables and in a standard food processor, grate them into a suitable bowl.</li><li>2. Take a handful of the grated vegetables and squeeze as much moisture from it as possible. Then place on a paper towel. Continue until you have squeezed out as much of the moisture as you can.</li><li>3. Clean and dry the original bowl and repeat the process of squeezing the vegetables dry but putting them in the bowl when finished. Then stir them to mix thoroughly.</li><li>4. In a separate bowl, beat the egg with the flour to form a sticky glue that will hold the latkes together.</li><li>5. Mix the sticky egg and flour with the vegetable mixture and form into flat pancakes about 3 to 4 inches in diameter then place on a cutting board.</li><li>6. Heat about 1/8 inch of peanut oil in a 10 inch cast iron skillet over medium high heat until a drop of water sizzles upon contact.</li><li>7. Place three of the pancakes into the skillet, press down with a spatula to thin them and cook until the edges start to turn deep brown. Flip them over carefully and cook for 2 to 3 minutes more.</li><li>8. Remove from pan and place on paper towels to drain excess oil.</li><li>9. Repeat until all are cooked and drained then place in a 175-200*F warming oven until ready to be served.</li></ol>	jewish	45	2	t	f	f	f
240  Mama''s Challah  https://spoonacular.com/recipeImages/Mamas-Challah-650703.jpg  <ol><li>Mix IN tall glass:3 T.flour, 2 T.sugar, BOTH packages OF yeast.Stir mixture slightly THEN ADD cup lukewarm water (100-115. measure USING liquid thermometer) Let this bubble & rise TO brim OF glass FOR about 10 minutes.(NOTE:This should bubble up TO the top.IF it doesnt START TO foam WITHIN IN a few minutes, try again WITH warmer water.) IN the meantime.</li><li> IN medium bowl (bowl A), combine 3 cups flour AND 2 tsp.salt</li><li> IN larger bowl (bowl B) whisk together brown sugar, oil, 2 eggs</li><li>Pour contents FROM bowl A INTO bowl B</li><li> ADD contents OF glass INTO bowl B</li><li> ADD another 1  cups lukewarm water (110-115 degrees) INTO bowl B</li><li> ADD 4 more cups flour INTO bowl B</li><li>Mix everything WITH wooden spoon AT quick pace! WHEN its too thick TO mix WITH spoon, transfer dough TO floured wooden board OR other surface FOR about 5 minutes.</li><li>Keep hands floured, ADD small amounts flour BY hand WHEN dough gets sticky.It should be smoothnot too loose, NOT too, firm, NOT too sticky.Scrap OFF bits OF dough FROM board, so surface IS clean, & smooth.Form INTO a round.</li><li>Lightly oil another LARGE bowl, place dough IN bowl, turn OVER TO coat WITH oil.Cover bowl WITH lightly damp towel.</li><li>Have warm oven ready (NOTE:preheat oven TO 150 THEN turn OFF BEFORE putting dough IN )</li><li>Place bowl IN oven FOR 45 minutes / 1 HOUR.AT 45 minutes CHECK TO see IF doubled IN size.</li><li>Remove bowl FROM oven, dip fist INTO flour, very gently punch 10-12 times TO punch OUT air.</li><li>Knead again ON floured board 5 minutes, ADD a BIT OF oil TO bowl again, make round;
RETURN dough TO bowl, cover, RETURN TO oven, let rise again 30/40ish minutes.</li><li>Punch down again, knead INTO a round.Gently divide INTO 2 loaves WITH sharp knife DO NOT saw.Pre-heat oven TO 350.</li><li>Place 1 loaf aside IN bowl.WITH remaining loaf, knead WITH 1 hand INTO ball (NOTE:IF USING raisins, ADD them here), THEN divide INTO 3 pieces, braid ON lightly floured board.Roll OUT, fatter IN middle, skinny ON ends OF EACH rope.Pinch ends together, tuck under.Repeat WITH other loaf.</li><li>Place ON oiled cookie sheet.Make egg wash  mix 1 egg & a BIT OF water, brush OVER loaves.Bake 30 minutes.</li></ol>  jewish  45  16  t  f  f  t
241  Pineapple AND Noodle Kugel  https://spoonacular.com/recipeImages/Noodle-Kugel- WITH -Pineapple-Gluten-free--Dairy-Free-653234.jpg	<ol><li>Preheat the oven temperature to 350 degrees F</li><li>Fill a medium stockpot with water set over high heat.  When water boils add 2 tablespoons kosher salt, then add pasta, stir well to prevent sticking.</li><li>Stir occasionally, cook for 8-10 minutes.</li><li>Let it sit in the water for a few minutes before transferring to a large glass, or heatproof bowl.</li><li>Meanwhile prepare other ingredients.</li><li>Pasta should cool off a bit during your preparation of the other ingredients.</li><li>Add coconut milk, creamer, pineapple, sugar, xylitol, cinnamon, nutmeg, oil, combine well.</li><li>Add egg yolks, stir to combine well.</li><li>Prepare the crumble.</li><li>Line 2 cupcake pans with cupcake liners.</li><li>Add noodle mixture into the cupcake liners with a dry 1/4 cup measuring spoon, filling it over the top.  Add any remaining liquid to each kugel that may look dry.</li><li>With your fingers, sprinkle  crumble over each (about 1/2 teaspoon for each).</li><li>Bake for 40-45 minutes.</li><li>Cool for 10 minutes before removing from cupcake pans.</li><li>Remove liners before serving if you like.  Serve hot or warm.</li></ol>	jewish	45	24	f	f	f	t
242  Red Wine Braised Beef Brisket  https://spoonacular.com/recipeImages/Red-Wine-Braised-Beef-Brisket-658125.jpg  <ol><li>Preheat the oven TO 325 degrees F.</li><li> ON a cutting board, mash the garlic AND 1/2 teaspoon OF the salt together INTO a paste.ADD the rosemary AND CONTINUE TO mash UNTIL incorporated.Put the garlic-rosemary paste IN a small bowl AND ADD 2 tablespoons OF olive oil;
stir TO combine.</li><li>Season BOTH sides OF the brisket WITH a fair amount OF kosher salt AND ground black pepper.Place a LARGE roasting pan OR Dutch oven OVER medium-high flame AND coat WITH the remaining olive oil.Put the brisket IN the roasting pan AND sear TO form a nice brown crust ON BOTH sides.Lay the vegetables ALL around the brisket AND pour the rosemary paste OVER the whole thing.ADD the wine AND tomatoes;
toss IN the parsley AND bay leaves.Cover the pan tightly WITH aluminum foil AND transfer TO the oven.Bake FOR about 3 TO 4 hours, basting every 30 minutes WITH the pan juices, UNTIL the beef IS fork tender.</li><li>Remove the brisket TO a cutting board AND let it rest FOR 15 minutes.Scoop the vegetables OUT OF the roasting pan AND onto a platter, cover TO keep warm.Pour OUT SOME OF the excess fat, AND put the roasting pan WITH the pan juices ON the stove OVER medium-high heat.Boil AND stir FOR 5 minutes UNTIL the sauce IS reduced BY 1/2. ( IF you want a thicker sauce, mix 1 tablespoon OF flour WITH 2 tablespoons OF wine OR water AND blend INTO the gravy).</li><li> SLICE the brisket across the grain (the muscle lines) AT a slight diagonal.</li></ol>  jewish  45  10  f  f  f  t
243  Chapchae - Korean Stir-Fried Noodles  https://spoonacular.com/recipeImages/Chapchae-(Korean-Stir-Fried-Noodles)-637440.jpg  <ol><li>Cook noodles according TO package directions</li><li> IN a LARGE pan OR wok OVER medium heat, heat olive oil AND 1 Tbsp sesame oil</li><li> ADD onion slices AND garlic AND saut FOR about 1 min</li><li> ADD rest OF vegetables AND cook FOR 4-5 min, UNTIL the vegetables are half-cooked AND still a BIT crispy</li><li>Turn heat TO low AND ADD cooked noodles, soy sauce, sugar, AND the remaining sesame oil</li><li>Mix TO combine AND cook FOR another 2 min</li><li> ADD salt OR more soy sauce IF needed ( OR IF you want it a BIT sweeter, ADD a touch more sugar)</li><li> IF USING sesame seeds, ADD them AT finish</li></ol>  korean  15  4  t  t  t  t
244  Dak Bulgogi - Korean BBQ Chicken  https://spoonacular.com/recipeImages/Dak-Bulgogi-(Korean-BBQ-Chicken)-641208.jpg  <ol><li>Peel OFF thigh skins WITH a paring knife.TRIM OFF excess fat.Cut INTO one single "steak" piece working around the bone.Save smaller pieces FOR cooking AS well.SET aside IN a LARGE mixing bowl.</li><li>Pulse the marinade ingredients IN a food processor UNTIL smooth.</li><li>Coat the chicken pieces WITH the marinade.Marinate overnight IN the refrigerator OR a minimum OF 6-12 hours.WITH a skewer OR toothpick, piercing the thighs FOR extra marinade absorption IS optional.</li><li>Preheat a skillet OR non stick pan OVER medium heat.ADD the chicken thighs AND cook FOR about 15-20 minutes OR UNTIL cooked through.TO ensure fully cooked thighs, use a meat thermometer AND CHECK FOR a reading OF 165-170F.</li><li>Transfer TO a serving plate AND garnish WITH scallion.Serve WITH lettuce leaves.Enjoy!</li></ol>  korean  400  4  f  f  t  t
245  Dolsot Bibimbap  https://spoonacular.com/recipeImages/Dolsot-Bibimbap-641559.jpg  <ol><li>Marinate beef AND tofu overnight IN Korean barbecue marinade.</li><li>Cook rice AND keep warm.</li><li> IN sesame oil AND a pinch OF salt, saut carrots AND zucchini UNTIL almost tender.IF necessary ADD a BIT more sesame oil AND toss IN the remaining vegetables, garlic AND a pinch OF sugar AND CONTINUE TO saut approximately 2 minutes, OR UNTIL the vegetables are almost done (they will CONTINUE TO cook IN the dolsot OR stone bowl)</li><li>Broil OR barbecue the beef.</li><li>Pour a 1/2 - 1 teaspoon OF sesame oil IN the base OF EACH stone bowl.Divide rice BETWEEN the 4 stone bowls.Arrange ALL ingredients ON top OF the rice side BY side around the bowl.Put a teaspoon ( OR more depending ON taste) OF the Korean chili paste ON top OF the vegetables AND IN the middle OF the bowl place an egg yolk.Pour a tablespoon OF sesame seed oil around the edge OF the bowl.</li><li>Place stone bowl ON top OF stove AND ON high heat leave FOR approx 5 minutes OR UNTIL you can hear the rice popping AND crackling.</li><li>Remove FROM heat AND serve.Be very careful AS the stone bowl will be extremely hot.</li></ol>  korean  45  4  f  f  t  t
246  Galbi Tang (Korean Beef Short Ribs Soup)  https://spoonacular.com/recipeImages/Galbi-Tang-(Korean-Beef-Short-Ribs-Soup)-644135.jpg  <ol><li>1.Soak the ribs IN a bowl OF cold water FOR about an HOUR TO drain the blood, changing the water IF necessary.</li><li>2.Mix sliced radish AND ADD WITH the seasoning sauce.</li><li>3. AFTER soaking AND rinsing the ribs, place IN a LARGE pot AND cover WITH water UNTIL submerged.ADD half onion, few garlic pieces, AND a SLICE OF ginger (this step IS optional).</li><li>4.Bring TO a boil FOR about 15 minutes, removing ANY foam OR scum that FLOAT TO the top.</li><li>5.Drain AND rinse the ribs under cold water removing ANY impurities.ADD new water just UNTIL ribs are submerged (more water can be added IF desired).</li><li>6.Bring TO a boil, AND THEN simmer OVER medium heat FOR 20 minutes.</li><li>7. ADD the radish AND sauce mixture AND cook FOR an additional 10 minutes.</li><li>8.Lastly, ADD the vermicelli noodles AND scallions AND cook FOR another few minutes.</li><li>9.Garnish WITH thinly cut egg strips AND toasted sesame seeds.</li><li>10.Serve WITH rice AND other banchan (side dishes).</li></ol>  korean  45  4  f  f  f  t
247  Kimchi  https://spoonacular.com/recipeImages/Kimchi-648910.jpg  <ol><li>Shred cabbage IN 2 inch strips.Mix WITH half the salt.Let stand 30 minutes.Wash AND drain.</li><li>Mix the scallions, garlic, ginger, chili pepper, cabbage AND the rest OF salt.Pack INTO a crock OR glass jar.</li><li>Put the containers aside FOR three OR four days IN a cool LOCATION.AFTER that, store it IN the refrigerator.</li></ol>  korean  45  6  t  t  t  t
248  Kimchi (Korean Fermented Spicy Cabbage)  https://spoonacular.com/recipeImages/Kimchi-Kimchee-Gimchi-(Korean-Fermented-Spicy-Cabbage)-648916.jpg  <ol><li>1. Remove discolored, bruised OUTER leaves OF cabbage AND rinse well under cold water.Cut cabbage head INTO desired pieces;
smaller 2-inch pieces IS recommended FOR easier ACCESS later.IN 3 separate LARGE bowls, PREPARE one cup sea salt AND water mixture FOR EACH bowl.Sprinkle remaining 1 cup OF sea salt onto the leaves OF the cabbages BEFORE soaking them IN the salt water.Cabbages should be partially submerged IN the salt water.Let sit FOR a minimum 6 hours but 12 hours IS PREFERRED.</li><li>2. Once finished soaking, rinse the cabbage leaves thoroughly under cold water several times.Remove water FROM the cabbage BY giving them a squeeze (they should have a rubbery texture BY now) TO remove excess water.SET IN a colander OR basket FOR AT least 2 hours so the water will drain OUT thoroughly.Meanwhile, PREPARE the red pepper mixture TO be mixed WITH cabbage leaves.</li><li>3. PREPARE 3 tbsp OF the sweet rice flour WITH 3 cups OF water INTO a small pot.Bring TO a boil AND whisk UNTIL the mixture turns INTO a glue- LIKE consistency.Let cool AND SET aside.</li><li>4. IN a food processor, puree onion, garlic, ginger AND SOME water UNTIL smooth.Pour gochugaru (chili flakes) IN a LARGE mixing bowl, ADD the garlic mixture puree, cooled rice glue, fish sauce, salted shrimp, sugar, AND sesame seeds.Mix well AND ADD the sliced radish AND green onions.</li><li>5. Lather EACH cabbage piece WITH red pepper mixture BY rubbing them well (rubber gloves highly recommended).CONTINUE UNTIL ALL the cabbage leaves are covered IN the red pepper mixture.Pack them inside air-tight glass jars/containers.SET OUT AT room temperature FOR 2 days FOR fermentation TO take place.AFTER that, place IN the refrigerator AND serve AS needed.The kimchi may keep FOR 2 OR 3 months IN the refrigerator.</li><li>*Making kimchi IS NOT easy, but IF done RIGHT, the rewards are endless.You can take the easy way OUT AND purchase them AT your LOCAL Korean grocery store AND even possibly IN the Asian foods section OF your LOCAL grocery.</li></ol>  korean  45  20  f  f  t  t
249  Kogi Kimchi Quesadillas  https://spoonacular.com/recipeImages/Kogi-Kimchi-Quesadillas-649002.jpg  <ol><li>1. IN a skillet OR non-stick frying pan, melt the 2 tbsp butter AND ADD the chopped kimchi, cook OVER medium heat UNTIL caramelized AND slightly charred.Remove ANY excess liquid AND SET aside.Seasoning WITH garlic powder IS recommended.</li><li>2. IN the same pan, saute the thin slices OF beef ON medium heat UNTIL browned.ADD salt AND pepper FOR seasoning.Remove ANY excess liquid AND SET aside.</li><li>3. ON LARGE pan OR griddle, heat OVER medium heat.Brush 1 tsp vegetable OR olive oil ON pan AND coat evenly.Place 1 tortilla ON pan AND spread ingredients according TO preference.Make sure TO leave an inch FROM the edges clear AND top WITH another tortilla.Slightly press down WITH hand TO compress the quesadilla.Drizzle SOME oil ON the top tortilla AND brush evenly TO coat.</li><li>4. Heat the quesadilla UNTIL browned ON the bottom, flip carefully AND CONTINUE cooking UNTIL browned AND blistered ON BOTH sides.WHEN finished, carefully transfer TO a cutting board AND let cool FOR a few minutes.Cut INTO 4 equal pieces AND transfer TO serving plate.Repeat WITH remaining ingredients TO make 4 quesadillas.Mixing AND matching ingredients TO your liking IS encouraged.^^</li></ol>  korean  45  4  f  f  f  f
250  Korean BBQ Beef  https://spoonacular.com/recipeImages/Korean-Bbq-Beef-649024.jpg  <ol><li>(The Meades)</li><li>Mix it ALL together AND marinate AT least 2 hours.Can either cook it ON the grill AS kebabs OR stir-fry BY itself.Enjoy.</li><li> WHEN I don''t have sirloin tips, I use flank steak AND it tastes just AS good.ALSO, I substitute hot pepper sesame oil AND ALSO ADD cayenne pepper FOR more kick.The sugar allows the beef TO caramelize a little (I tried USING cane sugar once but it didn''t caramelize).</li><li>NOTES:Just tried this recipe recently (4 OR 5 times) AND it IS absolutely wonderful - FROM Omaha Steaks recipe book</li></ol>  korean  45  1  f  f  t  t
251  Korean Bulgogi  https://spoonacular.com/recipeImages/Korean-Bulgogi-649034.jpg  <ol><li>Season the beef WITH salt AND pepper.IN a mixing bowl, combine the oil, soy sauce, garlic AND ginger.Season WITH crushed red pepper TO taste.</li><li>Place the meat IN a shallow bowl.Pour the marinade OVER the meat.Cover AND refrigerate FOR AT least 1 HOUR OR overnight.Remove AND bring TO room temperature.Preheat the hibachi.Remove the meat FROM the pan, reserving the marinade.Place the marinade IN a saucepan, OVER medium heat.Bring TO a boil AND cook FOR 6 TO 8 minutes OR UNTIL the mixture reduces BY 3/4. Remove, SET aside, AND keep warm.Grill the meat FOR a couple OF minutes ON EACH side, FOR medium rare.TO serve, spoon the rice IN the center OF EACH plate.Lay the strips OF meat around the rice.Drizzle the sauce OVER the </li><li>Yield:4 servings</li></ol>  korean  45  1  f  f  t  t
252  Vegetable Bibimbap  https://spoonacular.com/recipeImages/Vegetable-Bibimbap-664523.jpg  <ol><li>Marinate tofu overnight IN Korean barbecue marinade.</li><li>Cook rice AND keep warm</li><li> IN sesame oil AND a pinch OF salt, saut carrots AND zucchini UNTIL almost tender.IF necessary ADD a BIT more sesame oil AND toss IN the remaining vegetables, garlic AND a pinch OF sugar AND CONTINUE TO saut approximately 2 minutes, OR UNTIL the vegetables are almost done (they will CONTINUE TO cook IN the dolsot OR stone bowl)</li><li>Broil OR barbecue the beef.</li><li>Pour 1/2 - 1 teaspoon OF sesame oil IN the base OF EACH stone bowl.Divide rice BETWEEN the 4 stone bowls.Arrange ALL ingredients ON top OF the rice side BY side around the bowl.Put a teaspoon ( OR more depending ON taste) OF the Korean chili paste ON top OF the vegetables AND IN the middle OF the bowl place an egg yolk.Pour a tablespoon OF sesame seed oil around the edge OF the bowl.</li><li>Place stone bowl ON top OF stove AND ON high heat leave FOR approx 5 minutes OR UNTIL you can hear the rice popping AND crackling.</li><li>Remove FROM heat AND serve.Be very careful AS the stone bowl will be extremely hot.</li></ol>  korean  45  4  f  f  t  t
253  Winter Kimchi  https://spoonacular.com/recipeImages/Winter-Kimchi-665379.jpg  <ol><li>Soak the quartered cabbage IN the brine solution FOR 4 hours, weighing the cabbage down WITH a heavy plate.</li><li>Remove AND drain.</li><li>Place garlic cloves, rice, fermented shrimp, fish sauce, sugar, chilly paste AND chilly flakes IN a food processor AND zap TO a smooth paste.Stir IN spring onions.</li><li>Stuff the cabbage WITH the paste, making sure TO stuff IN BETWEEN the individual leaves AND coating every inch OF it.</li><li>Place kimchi INTO an airtight container AND leave AT room temperature FOR a DAY BEFORE leaving it TO ferment further IN the fridge FOR AT least another WEEK BEFORE consuming.I LEFT mine FOR about 3 weeks.</li></ol>  korean  45  1  f  f  t  t
254  Zomppa''s Kimchi  https://spoonacular.com/recipeImages/Zomppas-Kimchi-665680.jpg  <ol><li>Peel skin OFF OF cucumbers.</li><li> SLICE the cucumbers IN OF inch slices.</li><li>Place cumbers IN a bowl WITH salt.Let sit FOR 15 minutes.</li><li> WITH hands, squeeze liquid OUT OF the cucumbers.</li><li>Place cucumbers back IN bowl.ADD the garlic, ginger, red pepper powder, fish sauce, lemon juice, sesame oil AND honey.</li><li> WITH hands, mush ALL ingredients together.Taste.</li><li> ADD more hot pepper, fish sauce OR honey TO adjust the taste TO your liking.8. Place IN airtight container AND let refrigerate FOR 3 hours BEFORE enjoying.</li></ol>  korean  45  1  f  f  t  t
255  Ahi Tuna Ceviche  https://spoonacular.com/recipeImages/Ahi-Tuna-Ceviche-632021.jpg  <ol><li> IN medium bowl mix soy sauce, toasted sesame oil, rice vinegar, Serrano pepper, lime juice, mint, AND sesame seeds.THEN ADD diced tuna AND toss TO coat.</li><li>The tuna IS ready TO eat AS soon AS it''s tossed AND coated but you can marinate it FOR a few minutes IF desired.The tuna will START TO turn white almost immediately, a sign that it IS cooking FROM the acidity OF the lime juice.It IS NOT necessary TO cook the tuna.IN fact, it IS best served immediately WHILE it IS melt- IN -your-mouth tender AND moist.</li><li>Serve immediately BY mounding atop crackers, chips, micro-greens, OR even roasted sweet potato slices.</li></ol>  latinAmerican  45  3  f  f  t  t
256  Carne Asada Burritos  https://spoonacular.com/recipeImages/Carne-Asada-Burritos-637133.jpg  <ol><li> IN a medium sized bowl combine beef, cumin, paprika, pepper, salt AND lime juice.Toss TO combine AND coat meat.Cover AND place IN refrigerator FOR AT least 30 minutes.</li><li> PREPARE pico de gallo IN a small bowl.Cover AND let sit UNTIL ready TO assemble burritos.</li><li> PREPARE avocado slices AND drizzle WITH fresh lime juice TO keep them FROM browning.</li><li> IN a LARGE skillet heat olive oil OVER medium-high heat.ADD onion AND garlic TO pan AND cook just UNTIL garlic IS fragrant.ADD beef TO pan AND cook FOR 3-5 minutes.</li><li>Warm tortillas IN a LARGE pan OVER medium heat.</li><li>Place  cup meat, 2 tablespoons OF pico de gallo, AND a DOUBLE layer OF spinach leaves IN the center OF EACH tortilla.Fold sides OVER filling, THEN roll one edge OVER filling AND roll UNTIL filling IS completely covered.Place seam side down ON plate.</li><li>Serve WITH lime wedge AND sliced avocado.</li></ol>  latinAmerican  30  6  f  f  f  t
257  Chimichurri  https://spoonacular.com/recipeImages/Chimichurri-638619.jpg  <ol><li>Put the parsley, cilantro AND garlic INTO a medium mixing bowl AND toss TO combine.ADD the vinegar, salt, red AND black pepper AND stir.Pour IN the olive oil AND mix well TO combine.Allow the mixture TO sit FOR 30 minutes TO allow the flavors TO blend.This sauce IS NOT ONLY great ON steak but I think it would ALSO be wonderful ON pork AND chicken AS well.</li></ol>  latinAmerican  45  4  t  t  t  t
258  Chimichurri Skirt Steak WITH Grilled Asparagus  https://spoonacular.com/recipeImages/Chimichurri-Skirt-Steak- WITH -Grilled-Asparagus-638626.jpg  <ol><li>Place ALL chimichurri sauce ingredients EXCEPT FOR the olive oil IN a food processor &amp;
pulse UNTIL well chopped.WHILE the food processor IS going, slowly pour the olive oil INTO the mixture UNTIL blended.Reserve half OF the sauce TO serve ON the side WITH the meal.</li><li>Season skirt steaks WITH salt &amp;
pepper ON bother sides.Spoon the remaining chimichurri sauce OVER the steaks &amp;
let marinate FOR 30 minutes up TO overnight.</li><li>Pre-heat the grill TO 350 TO 400 F.</li><li> IN a plastic resealable bag, ADD asparagus, olive oil, garlic, salt &amp;
pepper.Shake TO coat &amp;
place IN a grill basket.</li><li>Place the steak &amp;
grill basket OF asparagus directly OVER a hot grill.Gently toss the asparagus FOR even grilling &amp;
baste WITH garlic, olive oil mixture  10 minutes.</li><li>Grill the skirt steak TO desired temperature  5 TO 8 minutes per side.</li><li>Remove FROM grill &amp;
let steak rest FOR 10 minutes BEFORE SLICE long strips.Spoon reserved chimichurri sauce OVER steak &amp;
serve WITH asparagus ON the side.</li></ol>  latinAmerican  45  4  f  f  t  t
259  Dulce De Leche  https://spoonacular.com/recipeImages/Dulce-De-Leche-641723.jpg  <ol><li>Combine the FIRST four ingredients IN IN a LARGE saucepan AND place OVER medium heat.Bring TO a simmer, stirring occasionally, UNTIL the sugar has dissolved.</li><li>Once the sugar has dissolved, ADD the baking soda AND stir TO combine.Reduce the heat TO low AND cook uncovered AT a bare simmer.Stir occasionally.CONTINUE TO cook FOR 1 HOUR.</li><li>Remove the vanilla bean AFTER 1 HOUR AND CONTINUE TO cook UNTIL the mixture IS a dark caramel color AND has reduced TO about 1 cup, approximately 1 1/2 TO 2 hours.</li><li>Strain the mixture through a fine mesh strainer.</li></ol>  latinAmerican  45  4  t  f  t  f
260  Dulce De Leche Cheesecake  https://spoonacular.com/recipeImages/Dulce-De-Leche-Cheesecake-641730.jpg  <ol><li>Toss the cookie crumbs INTO the melted butter IN a mixing bowl.Reserve 1 tablespoon OF the mixture FOR the topping.Press the rest OF the mixture onto the bottom AND up 3cm high OF a greased 24cm spring form pan.Chill UNTIL its ready FOR use.</li><li> USING electric mixer beat balance cream cheese AND sugar IN a LARGE mixing bowl UNTIL smooth.ADD yogurt AND eggs, beating UNTIL just blended.Stir IN cornstarch, dulce de leche, lemon juice AND zest UNTIL blended.</li><li>Pour the mixture INTO the crust AND sprinkle the top WITH reserved cookie crumbs.Steamed bake the cheesecake AT 165 C /330F FOR 65 minutes UNTIL almost SET.Turn oven OFF.Leave the cake WITH the oven door ajar FOR 1 HOUR.Cool completely AND chill AT least 4 hours OR overnight UNTIL firm.</li></ol>  latinAmerican  45  10  t  f  t  f
261  Dulce De Leche Shortbread Cookies  https://spoonacular.com/recipeImages/Dulce-De-Leche-Shortbread-Cookies-641731.jpg  <ol><li> USING your fingers, combine ALL the ingredients TO make a uniform dough.IF it seems a little dry ( LIKE mine was) ADD IN a TSP OF cold water UNTIL it IS the correct dough consistency.</li><li>Roll OUT TO 1/2 inch thickness  I was IN a place WITH NO rolling pin WHEN I was making these so I used a wine bottle, it works really well IF you are IN a pinch!</li><li>Cut them INTO circles  I used a shot glass AND that was actually the perfect size! They were either 1 big bite OR 2 little ones, just enough AT one TIME.</li><li>Dont forget TO keep USING your scraps TO make more cookies.</li><li>Bake the cookies AT 350 F FOR 10-15 minutes ON a parchment lined cookie sheet.</li><li> WHEN the cookies are cool, spread WITH 1 TBSP dulce de leche.IF you want, sprinkle WITH either pink himalaya salt OR sea salt.Enjoy!</li></ol>  latinAmerican  45  1  f  f  f  f
262  Dulce De Leche Swirled Amaretto Frozen Yogurt  https://spoonacular.com/recipeImages/Dulce-De-Leche-Swirled-Amaretto-Frozen-Yogurt-641732.jpg  <ol><li>Drained the yogurt overnight</li><li>Mix the amaretto cream INTO the yogurt & churn IN your ice cream maker AS according TO the manufacturer''s instruction.</li><li>Warm the dulce de leche, OR caramel IN the microwave FOR 30 seconds.WHEN yogurt IS done churning, layer drizzles OF dulce de leche INTO the yogurt AND store IN the freezer.</li></ol>  latinAmerican  45  4  t  f  t  f
263  Flank Steak WITH Chimichurri Sauce  https://spoonacular.com/recipeImages/Flank-Steak- WITH -Chimichurri-Sauce-643055.jpg  <ol><li> FOR the Sauce:Mix parsley, oregano, red pepper flakes ( IF you are USING ) AND garlic IN a food processor OR blender AND mix UNTIL combined.Drizzle IN olive oil AND red wine vinegar AND process UNTIL combined.</li><li> Season sauce TO taste WITH salt AND pepper.Let SET FOR AT least 1 HOUR.</li><li>Season steak WITH salt AND pepper.Grill OVER medium high heat FOR 5 minutes ON EACH side FOR medium rare.Let rest FOR 5 minutes.</li></ol>  latinAmerican  75  4  f  f  t  t
264  Fresh AND SIMPLE Swai Ceviche  https://spoonacular.com/recipeImages/Fresh- AND - SIMPLE -Swai-Ceviche-643428.jpg  <ol><li>Place the diced fish INTO OF the lime juice AND refrigerate FOR AT least 3 hours.Strain WHEN ready TO proceed.</li><li>Mix the veggies WITH the remaining lime juice.</li><li>Stir IN the fish AND cilantro.Drizzle WITH olive oil AND ADD the chile-garlic sauce.Gently toss.</li><li>Salt AND pepper TO taste.Serve WITH tortilla chips OR a salad.</li></ol>  latinAmerican  45  4  f  f  t  t
265  Gluten-Free Tres Leches Cake  https://spoonacular.com/recipeImages/Gluten-Free-Tres-Leches-Cake-644907.jpg  <ol><li>Preheat oven TO 350 degrees.Generously butter a 13X9 baking dish.IN a LARGE bowl, beat C sugar, egg yolks, AND butter UNTIL light AND fluffy, about 5 minutes.Fold IN the vanilla EXTRACT, orange zest, cinnamon, sorghum flour, masa harina, baking powder, xanthan gum, AND milk.</li><li> IN another LARGE bowl, beat egg whites TO soft peaks, adding cream OF tartar AFTER about 20 seconds.Gradually ADD the remaining C sugar AND CONTINUE beating UNTIL egg whites are glossy AND firm, but NOT dry.</li><li>Gently fold the egg whites INTO the cake mixture.Pour this batter INTO the baking dish, spreading OUT evenly.Bake UNTIL the cake IS golden AND a toothpick inserted IN the center comes OUT clean, about 25 minutes.Pierce cake ALL OVER WITH a toothpick.</li><li>Whisk together the milks, AND pour evenly OVER cake.Allow TO cool FOR a BIT, AND cover AND place IN refrigerator FOR 4 hours, up TO overnight.</li><li> BEFORE serving, place the whipping cream, sugar, AND vanilla IN a mixer bowl AND whisk TO stiff peaks, AND nice AND thick.Spread OVER cake AND top WITH strawberries AND mint leaves.</li><li>Allow TO chill IN refrigerator UNTIL ready TO serve.</li></ol>  latinAmerican  45  10  f  f  t  f
266  Lomo Saltado Beef Stir Fry  https://spoonacular.com/recipeImages/Lizs-Lomo-Saltado-650225.jpg  <ol><li> PREPARE the frozen french fries according TO directions.SET aside WHEN complete AND keep warm.</li><li>Heat a LARGE wok OR skillet OVER medium-high heat.Saute the onions AND bell peppers UNTIL translucent, about 10 minutes.ADD the garlic AND jalapeno AND cook FOR an additional MINUTE.Mix everything UNTIL combined.</li><li> ADD the beef chunks, cumin, complete seasoning, soy sauce AND red wine vinegar sauce.Mix well AND cook UNTIL beef IS NO longer pink about 5 TO 7 minutes.</li><li> ADD the tomato chunks AND ADD the cover AND cook FOR additional 5 minutes.WHEN ready TO serve, ADD the french fries AND toss everything gently together.</li><li>Serve lomo saltado OVER a bed OF white rice AND garnish WITH freshly chopped cilantro leaves.Enjoy WITH aji sauce ON the side.</li></ol>  latinAmerican  45  4  f  f  t  t
267  Crispy-Crowned Guacamole Fish Fillets  https://spoonacular.com/recipeImages/Crispy-Crowned-Guacamole-Fish-Fillets-157399.jpg  <ol><li> PREPARE the guacamole BY dicing the onion, cutting the tomatoes, AND crushing the garlic.Mix these ingredients WITH the ripe avocado AND spice WITH salt, pepper, cilantro, AND tabasco.</li><li>Fry the fish FOR 5 minutes.</li><li>Crush the tortilla chips WITH your hands.</li><li>Cut the bell peppers IN strips.</li><li>Place the fish ON a plate, use a fork TO distribute the guacamole ON the fish AND crown the fish WITH the crispy crushed tortilla chips.</li></ol>  mexican  30  2  f  f  t  t
268  Black Bean AND Peppers Taco Filling  https://spoonacular.com/recipeImages/Black-Bean- AND -Peppers-Taco-Filling-635058.jpg  <ol><li> IN a skillet ADD olive oil, onions AND bell pepper.Cook UNTIL tender, about 3  5 minutes.ADD tomatoes AND seasonings, saute FOR 10 minutes.ADD black beans AND cook UNTIL warm.</li><li>Serve WITH tortillas.</li><li>Additional toppings:Romaine Lettuce, Cheese, jalapenos, salsa, hot sauce, avocado, AND greek yogurt</li></ol>  mexican  45  8  t  t  t  t
269  Black Bean AND Veggie Burgers WITH Corn Salsa  https://spoonacular.com/recipeImages/Black-Bean- AND -Veggie-Burgers- WITH -Corn-Salsa-635059.jpg  <ol><li>Mix ALL the salsa ingredients together AND chill FOR about an HOUR BEFORE serving.</li><li>Preheat your oven TO 425 degrees F.Spray two baking sheets lightly WITH the nonstick spray AND SET aside.</li><li> ADD the carrot TO a bowl WITH a little water, cover it AND microwave FOR about two minutes.Once cooled, mash them AND ADD them TO the mashed black beans.Mix together THEN ADD the remaining vegetables AND mix well.</li><li> ADD the oatmeal, breadcrumbs, seasoning AND salsa.Mix together UNTIL combined.ADD the flour AND mix well.IF the mixture IS too moist, ADD more flour AND adjust the seasoning, AS needed.</li><li>Form the mixture INTO patties AND place them ON the baking sheets.Bake FOR about 20 minutes, flipping them halfway through cooking.WHEN the burgers are finished, serve WITH the Corn Salsa OR your favorite topping.</li></ol>  mexican  45  8  t  t  f  t
270  Chilled Avocado AND Cucumber Soup WITH Prawn AND Scallop Salsa  https://spoonacular.com/recipeImages/Chilled-Avocado- AND -Cucumber-Soup- WITH -Prawn- AND -Scallop-Salsa-638588.jpg  <ol><li> IN a small sauce pot, combine the minced shallots, red chili pepper flakes AND oil.</li><li>Heat the oil OVER very low heat AND simmer FOR about 3 minutes.</li><li>Remove FROM the heat AND let stand FOR 3 minutes.Stir IN the lime zest AND the water.</li><li>Let stand FOR AT least an HOUR, THEN strain the oil INTO a small bowl OR jar.</li><li>Adding water IN the oil WITH the lime zest dissolves AND carries water-soluble flavors.</li><li> SET aside, WHILE you PREPARE the soup.</li><li>Place the cucumber, avocado AND green onion IN a blender.</li><li>Squeeze the lime juice AND ADD 2 tablespoon OF the miso paste.</li><li>Blend the ingredients adding the water TO dilute the mixture UNTIL smooth AND creamy.</li><li>Season the soup ( TO taste) WITH more miso paste AND lime juice IF necessary.</li><li>Transfer the soup INTO a LARGE bowl, cover AND chill IN the refrigerator FOR AT least 2 hours.</li><li> TO cook the prawns AND scallops, heat a skillet OVER medium-high heat.</li><li> THEN, season the prawns AND scallops WITH salt AND pepper ON BOTH sides.</li><li>Once the pan IS nice AND hot, ADD one tablespoon OF the oil.</li><li> ADD the prawns AND scallops AND cooked UNTIL they are done.</li><li>Remove AND transfer TO a bowl.THEN, ADD the orange pieces, black olives AND cilantro.</li><li>Cut the prawns INTO 3 OR 4 pieces depending ON the size AND ADD these TO the bowl.</li><li>Season WITH a little BIT OF sea salt AND black pepper ( IF necessary) AND drizzle WITH chili-lime oil.</li><li>Toss gently WITH a spoon TO combine.</li><li> TO serve the dish, bring OUT the four individual bowls AND the avocado soup FROM the fridge.</li><li>Ladle the soup onto the bowls, THEN garnish WITH the prawn AND scallop salsa AND finish WITH more drizzle OF the chili-lime oil.</li></ol>  mexican  45  4  f  f  t  t
271  Corn Avocado Salsa  https://spoonacular.com/recipeImages/Corn-Avocado-Salsa-640062.jpg  <ol><li>Preheat oven TO 375 degrees.</li><li>Spread corn flat ON a baking sheet.</li><li>Spray lightly WITH olive oil spray.</li><li>Roast corn IN the oven FOR about 8-10 minutes.(Be careful NOT TO brown too much OR burn.)</li><li>Remove FROM heat AND allow TO cool.</li><li>Finely chop red pepper AND garlic AND mix IN a bowl.</li><li>Peel AND coarsely chop avocado AND ADD TO bowl.</li><li> ADD cooled corn.</li><li>Mix IN cumin AND vinegar AND blend well.</li></ol>  mexican  25  2  t  t  t  t
272  Flank Steak WITH Herbed Salsa  https://spoonacular.com/recipeImages/Flank-Steak- WITH -Herbed-Salsa-643061.jpg  <ol><li>Preheat a grill pan OR light a grill.</li><li> IN a medium bowl, combine the tomatoes WITH the scallions, cilantro, Jalapeno, garlic AND lemon  lime juice.Season the salsa WITH salt AND freshly ground pepper.</li><li>Season WITH salt AND pepper the flank steak.</li><li> USING a grill pan brush a shadow OF oil ON the bottom OF it.Place the pan OVER high heat AND WHEN hot ADD the flank steak.Cook UNTIL nicely charred outside AND medium rare inside.About 3 minutes per side.</li><li>Transfer the steak TO a carving board AND let rest FOR 5 minutes.</li><li>Thinly SLICE the steak across the grain AND serve WITH the herbed salsa.</li></ol>  mexican  45  4  f  f  t  t
273  Grilled Chicken WITH Pineapple Salsa  https://spoonacular.com/recipeImages/Grilled-Chicken- WITH -Pineapple-Salsa-645670.jpg  <ol><li>Make marinade OF 1/3 cup lime juice, 1/3 cup olive oil, 1 teaspoon salt, AND 1/4 teaspoon pepper.</li><li>Marinate chicken overnight.Combine salsa.Saute pineapple, mango, peppers, onions, AND garlic.ADD lime juice AND honey AND refrigerate (up TO 24 hours).</li><li>Bring TO room temperature TO serve.Grill chicken breasts AND serve WITH sauce AND white rice.</li></ol>  mexican  45  1  f  f  t  t
274  Grilled Fish Tacos WITH Spicy Tequila-Lime Guacamole  https://spoonacular.com/recipeImages/Grilled-Fish-Tacos-W--Spicy-Tequila-Lime-Guacamole-645711.jpg	<ol><li>Using a fork or potato masher, mash avocado in a bowl.</li><li>Add yogurt, lime juice, lime zest and tequila; mix well.</li><li>Add jalapeno, onion, salt/pepper and cilantro; stir until all ingredients are incorporated and smooth.</li><li>Adjust seasonings if desired.</li><li>Pour finished guacamole into serving bowl; set aside.</li><li>Preheat a grill pan to med-high heat.</li><li>Drizzle fish on each side with olive oil and season with salt and pepper.</li><li>Grill fish on each side until opaque, about 4 mins.</li><li>Remove fish from grill and flake into large chunks with a fork.</li><li>Heat tortillas on the grill pan until blisters form.</li><li>To assemble tacos, spread a dollop of guacamole onto tortilla, add fish, and top with shredded lettuce and chopped tomatoes (or whatever toppings you prefer).</li><li>Optional: squeeze additional lime juice over the fish.</li><li>Enjoy with a Mexican beer or tasty margarita! :)</li><li>Note: if you have any leftover guacamole, serve it as a dip with tortilla chips!</li></ol>	mexican	45	4	f	f	f	f
275  Grilled Salmon WITH Cherry, Pineapple, Mango Salsa  https://spoonacular.com/recipeImages/Grilled-Salmon- WITH -Cherry--Pineapple--Mango-Salsa-645856.jpg	<ol><li>Combine all the above ingredients except the olive oil and salmon into a mixing bowl. Stir gently. Add one splash of olive oil and taste for seasoning. Cover and refrigerate until ready to use.</li><li>Lightly oil and season a salmon fillet with a splash of olive oil and salt and pepper. Place flesh side down on a cleaned and oiled grill or pan. Cook for 2-4 minutes depending on the thickness. Flip and cook for another 2-4 minutes. Salmon will be cooked when the flesh is no longer opaque. I tend to like it pretty rare, but it''s your salmon- cook it how you want it!</li><li>Top salmon with salsa and serve!</li></ol>	mexican	45	2	f	f	t	t
276  Grilled Salmon WITH Mango Salsa  https://spoonacular.com/recipeImages/Grilled-Salmon- WITH -Mango-Salsa-645863.jpg  <ol><li> TO make salsa:IN bowl, combine mango, pineapple, onion, cilantro AND lime juice.Season TO taste WITH salt.SET aside 20 MINUTE TO 1 HOUR, TO blend.</li><li>Heat grill TO medium-high.Season salmon WITH salt AND pepper.Place fish ON hot grill, skin-side down, AND cook 5 minutes.DO NOT worry IF skin IS blackened.Turn AND grill fish UNTIL it IS NO longer raw IN center, about 3 minutes, depending ON thickness OF the fish.</li><li> TO serve, place piece OF grilled salmon IN center OF EACH OF 4 dinner plates.Arrange about 1/4 cup salsa along either side OF fish.</li><li>This recipe yields 4 servings.</li></ol>  mexican  45  4  f  f  t  t
277  Homemade Hard Taco Night WITH Carnitas AND Pinto Beans  https://spoonacular.com/recipeImages/Homemade-Hard-Taco-Night- WITH -Carnitas- AND -Pinto-Beans-647015.jpg  <ol><li> INTO a hot pan sizzling WITH a glug OR two OF vegetable oil I sear my pork, USING tongs TO turn EACH piece OVER UNTIL EACH side OF EACH CUBE IS nicely browned.</li><li>I ADD 1 cup OF red onion AND garlic TO my sizzling pork pieces, AND toss well.I cook this UNTIL the onion softens about 4 minutes.</li><li> THEN I ADD my orange juice AND the juice FROM 1/2 a lime, which I stir IN well.I bring them just TO a boil BEFORE I ADD my chicken stock, which covers about 3/4 OF my meat.I SET the heat TO medium, AND bring this TO a slow simmer TO braise FOR the NEXT three hours.</li><li>I fried taco shells BY adding a few inches OF vegetable oil TO a deep fry pan AND SET it TO high heat.WHEN sizzling, USING tongs, I floated 1/2 OF a 10 corn tortilla ON the surface OF the blistering oil  about 5 seconds did the trick, OR UNTIL it SET.</li><li>Moving quickly but carefully, I flipped the tortilla OVER, rolling it IN the oil, releasing the tongs FROM one edge AND immediately catching the other edge IN their grip.</li><li>Holding the other edge under the hot oil, I fried it UNTIL crunchy, THEN dipped the center fold INTO the pot TO crisp it up LAST.Be careful TO pour ALL the oil OUT WHEN lifting your shells FROM the fryer.I sprinkled them WITH sea salt WHILE hot</li><li>I put my small deep pan, WITH a few glugs OF oil, OVER the heat FOR about 10 minutes BEFORE adding 1/2 a cup OF my diced onion AND SOME minced garlic.I cook this UNTIL just softened AND fragrant.THEN I ADD about a teaspoon OF black pepper, a healthy sprinkling OF cumin, AND a dash OF sea salt.Finally, I ADD my can OF pinto beans, liquid AND ALL.I cover AND bring TO a simmer, heating ALL the beans through.</li><li>I peel AND mash the avocados, adding fresh cilantro, a dash OF minced garlic, a squeeze OF lemon juice, sea salt, cracked black pepper, 1/4 cup diced red onion, AND ground cumin TO make guacamole.</li><li> IN another bowl, Ive mixed my diced tomatoes, 1/4 cup diced red onion, minced garlic, fresh cilantro, the juice OF 1/2 a lime, a glug OF oil, AND a dash OF white vinegar together (along WITH SOME diced jalapeno, IF you want heat), TO make a quick fresh delicious pico de gallo.</li><li>Scoop up about 4 tablespoons OF the fat FROM the carnitas AND dump it INTO the beans FOR flavor.</li><li> AFTER about 15 minutes, AND SOME squishing OF beans WITH my fork, they are thick AND syrupy.</li><li>Build tacos AS desired USING shredded cheese, pork, beans, pico, guacamole, sour cream AND cilantro.</li></ol>  mexican  240  2  f  f  t  f
278  Mini Stuffed Mexican Bell Peppers  https://spoonacular.com/recipeImages/Mini-Stuffed-Mexican-Bell-Peppers-651977.jpg  <ol><li>1. Roast the vegetables:Preheat oven TO 400 degrees.Cut the tomatillos IN half, SLICE the onion INTO 1/2 IN slices AND remove garlic FROM covering.Place ON baking sheet.Roast till tomatillos are tender AND START TO brown, about 20 minutes.</li><li>2. Meanwhile, make the sauce:ADD tomatillos, onion, garlic, tomatoes, green chilies, chipotles, chili powder, cumin, paprika, AND coriander TO blender OR food processor.Blend UNTIL smooth.</li><li>3. IN a LARGE bowel, ADD the turkey, beans, AND sauce, Mix together UNTIL everything IS evenly distributed.</li><li>4. Cut tops OFF mini bell peppers AND remove ANY seeds.Stuff turkey mixture INTO peppers UNTIL slightly overflowing.Place IN 9 BY 13 glass dish.Repeat FOR ALL bell peppers.</li><li>5. Cook AT 400 FOR 20 minutes.FOR the LAST 5 minutes, turn ON the broiler AND GET SOME color ON the peppers.</li><li>6. Serve WITH your favorite salsa (used my Pico De Gallo FROM my tortilla soup), sour cream AND avocado.</li><li>ENJOY!</li></ol>  mexican  45  4  f  f  t  t
279  Nacho Mama''s Cheese Nachos  https://spoonacular.com/recipeImages/Nacho-Mamas-Cheese-Nachos-652926.jpg  <ol><li> TO GET started, grab a pan AND melt up your butter.ADD IN the flour AND CREATE a roux.THEN ADD IN your milk, put the heat ON medium AND let the mixture thicken.</li><li>Turn the heat down TO low AND ADD IN the cheese.</li><li>Once it''s melted ADD IN your green chilies, chili powder, cumin, AND cilantro.Now ADD IN the salsa.</li><li>Lay your chips IN an oven proof bowl AND pour the cheese OVER the top.Now ADD ON your desired toppings.</li><li>Throw them IN the oven FOR about 10 minutes AT 350 degrees.</li></ol>  mexican  45  1  f  f  f  f
280  Poblano, Mango, AND Black Bean Quesadilla  https://spoonacular.com/recipeImages/Poblano--Mango--and-Black-Bean-Quesadilla-656519.jpg	<ol><li>Heat olive oil, onions, poblano, oregano, salt and pepper in large pan. Saute for about five minutes.</li><li>Add black beans. Let heat for one minute, stirring occasionally.</li><li>Pull pan off heat. Add mangoes and avocado. Stir.</li><li>In another pan, sprinkle large flour tortilla with cheddar cheese, and fry in butter. *Note: for a lower-fat option, place tortilla on baking sheet, sprinkle tortilla with cheese and place under broiler.</li><li>Place pan under broiler to allow cheese to melt.</li><li>Cover half the tortilla with bean mixture, and fold in half.</li><li>Serve with sour cream, salsa and guacamole.</li></ol>	mexican	45	2	t	f	f	f
281  Pork Shoulder Tacos WITH Chipotle Greek Yogurt AND Coleslaw  https://spoonacular.com/recipeImages/Pork-Shoulder-Tacos- WITH -Chipotle-Greek-Yogurt- AND -Coleslaw-656820.jpg  <ol><li> TO Make the pork shoulder:</li><li>Place ALL ingredients IN the crock pot.Cook FOR 5 hours ON low.Meat should be tender AND easily shred WHEN finished cooking.</li><li> TO Make the Chipotle Greek Yogurt:</li><li> IN a small bowl, ADD the Greek yogurt.Crack OPEN your can OF chipotle chilies IN adobo sauce AND remove the seeds FROM 3 OR 4 OF the chilies (about half OF the can).Finely chop AND ADD TO the Greek yogurt.ADD about a teaspoon OF the adobo sauce.Stir.FOR a spicier sauce, ADD additional chipotle chilies.</li><li> TO Make the NO -mayo coleslaw:</li><li>Thinly SLICE the cabbage AND chop the green onion.Peel AND julienne the carrot.ADD ALL veggies TO a LARGE mixing bowl.Mix the lime juice, apple cider vinegar AND olive oil together IN a small bowl.Drizzle the liquid OVER the veggies.ADD salt AND pepper TO taste AND IF youre one OF those cilantro people, ADD a handful OF chopped cilantro.Mix thoroughly AND serve ON your taco.</li><li> TO assemble the tacos, simply heat your favorite tortilla ON the stove UNTIL warm.Spoon desired amount OF meat, chipotle Greek yogurt sauce, AND coleslaw ON the tortilla AND enjoy!</li><li>Nutritional information IS per taco.</li></ol>  mexican  45  12  f  f  t  f
282  Pork Tenderloin WITH Mango-Kiwi Glaze Served WITH Tomatillo Salsa  https://spoonacular.com/recipeImages/Pork-Tenderloin- WITH -Mango-Kiwi-Glaze-Served- WITH -Tomatillo-Salsa-656839.jpg  <ol><li>Dry Rub the Pork:</li><li>Mix together the spices.</li><li>Rub the pork WITH the spice mix.Cover AND refrigerate FOR 2 hours.</li><li>Make the Glaze*:</li><li>Saute the onion, garlic, ginger, AND jalapeno IN 2 teaspoons OF olive oil.</li><li> ADD the mango, kiwi, salt, pepper, AND cayenne.Cook OVER medium heat FOR 10 minutes OR UNTIL mixture thickens slightly.</li><li>Cool.</li><li>Puree IN blender OR food processor.Strain INTO a clean bowl.</li><li> ADD lime juice AND SET aside.</li><li>This can be made a DAY ahead.</li><li>Cook AND glaze the pork:</li><li>Preheat oven TO 425F.</li><li>Heat 2 teaspoons olive oil IN an oven-proof pan.Sear the pork ON ALL sides IN the hot pan.</li><li>Place the pork IN the oven FOR 5 minutes.Brush WITH glaze.</li><li>Cook FOR another 5 minutes AND brush WITH more glaze.Reserve the remaining glaze TO serve alongside the pork.</li><li>Allow TO finish cooking FOR 10 minutes OR UNTIL the INTERNAL temperature reaches 145F.</li><li>Remove FROM oven AND allow TO rest FOR AT least 10-15 minutes BEFORE slicing.</li><li>Make the Tomatillo Salsa**:</li><li>Mix ingredients together.</li><li>Allow TO sit UNTIL ready TO use.</li><li>Serve WITH the pork tenderloin.</li><li>Can be made a DAY ahead.</li><li>Serve it up:</li><li> SLICE the pork AND serve WITH the salsa AND ANY remaining glaze.</li></ol>  mexican  45  4  f  f  t  t
283  Pressed Bean, Veggie AND Cheddar Burrito  https://spoonacular.com/recipeImages/Pressed-Bean--Veggie---Cheddar-Burrito-657126.jpg	<ol><li>Get all the ingredients ready first, diced the veggies, shred the cheese, rinse the beans. I leave the avocado slicing until I''m ready to assemble so it does''t brown.</li><li>In a large saute pan, over medium high heat, add a few drizzles of olive oil and the corn, bell peppers and onions. Season with salt, pepper and garlic powder. You are looking just to cook until the veggies are just starting to soften. Add in the black beans and the lime juice. Cook for a couple minutes until the beans are warmed through.</li><li>Thats it! Now time to assemble. Lay the tortilla flat, add a line of cheese, the veggies and a few slices of avocado.</li><li>Fold the end over the filling then fold in the sides. Roll until almost at the end then add a little bit more cheese so it gets sealed a bit better.</li><li>Place the burrito onto a panini press set on high, You are looking just to crunch up the outside a bit. Notice mine opened up in the corner, its because I used whole grain tortilla wraps and found that they were more brittle then a regular wrap.</li></ol>	mexican	45	4	t	f	t	f
284  Restaurant Style Salsa  https://spoonacular.com/recipeImages/Restaurant-Style-Salsa-658180.png  <ol><li>Combine ALL ingredients IN a food processor.Pulse UNTIL you GET the salsa consistency you LIKE.10 TO 15 pulses.Test seasonings AND adjust accordingly.</li><li>Store IN a Tupperware container.</li><li>Ready IN 5 minutes</li></ol>  mexican  5  4  f  f  t  t
285  Roasted Veggie Burrito  https://spoonacular.com/recipeImages/Roasted-Veggie-Burrito-658705.jpg  <ol><li>Preheat oven TO 425 degrees.SLICE veggies INTO inch bite sizes pieces, AND onion INTO small slices.Place ON baking sheet, ADD 1 tbsp olive oil, pepper TO taste, garlic powder, onion powder AND chili powder.Toss together UNTIL evenly distributed.Bake UNTIL veggies BEGIN TO caramelize, about 25 minutes.</li><li>Heat 1 tbsp olive oil IN a LARGE frying pan OVER medium high heat.ADD beans AND spices.Stir AND cook UNTIL beans are heated through, about 5 minutes.ADD veggies AND mix together.Let everything heat together FOR about 2 minutes.Remove FROM heat.</li><li>Assemble Burrito:ON a flour burrito tortilla, place about  cup veggie AND black bean mixture per burrito.ADD OF the cheese TO EACH burrito.ADD 1 TBSP sour cream, salsa ON top ON EACH burrito.ADD 2 TBSP OF guacamole AND corn TO EACH burrito.Fold the edges IN AND roll along the long edge OF the tortilla.If desired, place ON foil AND roll so that foil IS wrapped around the burrito.</li></ol>  mexican  45  4  t  f  f  f
286  Vanilla AND Lime Flan BY Esperanza Platas Alvarez  https://spoonacular.com/recipeImages/Vanilla- AND -Lime-Flan- BY -Esperanza-Platas-Alvarez-(Planet-Food-Mexico)-664284.jpg  <ol><li>Preheat the oven TO 360 degrees Fahrenheit.</li><li> TO make the caramel, heat together the water AND sugar gently OVER a medium flame FOR about 10 minutes, ensuring the mixture does NOT burn.</li><li>Meanwhile, pour the condensed milk AND whole milk INTO a pan.ADD the zest OF the limes.SLICE the vanilla pod IN half AND carefully scrape OUT the vanilla seeds AND ADD these TO your milk mixture.</li><li>Simmer the milk slowly FOR fifteen minutes TO let the flavours infuse.</li><li>Once the caramel IS ready, pour INTO a cake pan AND swirl it around TO evenly coat the bottom OF the pan.SET aside.</li><li> IN a bowl, crack the eggs AND beat together.Slowly pour a little OF the warm milk, vanilla AND lime mixture INTO the eggs.This will temper the eggs AND prevent them FROM scrambling FROM the heat.Once the temperature OF the eggs has been raised BY the warm milk, pour IN the rest OF the milk.Pour ALL OF the mixture INTO the cake pan OVER the caramel.</li><li>Cook the cake pan IN a water bath BY PLACING the pan inside a larger pan which IS filled half way WITH water.Place IN the oven AND cook FOR 45 minutes TO an HOUR.</li><li>Once ready, allow TO cool AND place inside a fridge overnight.The flan IS THEN ready TO be flipped OVER gently AND served.</li></ol>  mexican  45  8  t  f  t  f
287  Vegetarian Tamales  https://spoonacular.com/recipeImages/Vegetarian-Tamales---Mommie-Cooks-664720.jpg	<ol><li>Start off by soaking your corn husks in water for at least 30 minutes.</li><li>Grab a bowl and add in the masa, baking powder, 1/2 tsp of the salt, and 1 tsp of both the cumin, and chili powder.</li><li>Now add 2 cups of the veggie broth to your mixture and form a dough.</li><li>Pop your stick of butter into your mixer and whip it up for a minute or so.</li><li>Add the masa dough in and mix it up well again.</li><li>Set your finished dough aside and let''s move on to the filling.</li><li>Grab your saute pan and cook up your zucchini, green onions, and garlic on medium heat in the tbsp of oil for 2 to 3 minutes.</li><li>Now add in the rest of your broth (1/4 cup), the cilantro, tomatoes, lime juice, and the remaining cumin, chili powder (1 tsp each) and salt (1/4 tsp).</li><li>Stir it together and add in the shredded cheese.</li><li>Are you ready to assemble cuz it''s time! Grab up one of your soaked corn husks and slather a good amount of the masa mixture on top.</li><li>Now, take a spoonful of your veggie filling and place it down the middle third of your tamale. Make sure to leave a bit of space at the ends.</li><li>Wrap it up like you would a burrito and tie it off. I used another corn husk to tie it up.</li><li>Grab a big pot and steam those beautiful rolled up veggie delights for about 90 minutes on medium high heat. I didn''t have a steamer that big, so I used my large stock pot and placed my noodle strainer inside of it with the pot cover over the top.</li><li>While the tamales are steaming, periodically check your water level to ensure you don''t boil it all away!</li><li>Pull one out after 90 minutes and unwrap it to see if it''s cooked through. The masa should be firm.</li></ol>	mexican	45	1	t	f	t	f
288  Mango Salsa  https://spoonacular.com/recipeImages/mango-salsa-716290.jpg  Peel AND chop your mango INTO small cubesCube your bell peppers AND onions AS well AND mix IN WITH the mangoes.ADD the cherry tomatoes AND mix IN.sprinkle your sugar AND lime juice OVER it.Chop your scent/mint leaves AND mix IN AND refrigerate.Serve cool AS a side dish OR IF you want something refreshing ON a hot DAY.mexican  45  1  t  t  t  t
289  Chavrie Tabbouleh  https://spoonacular.com/recipeImages/Chavrie-Tabbouleh-637481.jpg  <ol><li>Place Bulgur wheat IN a LARGE bowl AND pour the boiling water OVER AND cover WITH aluminum foil OR a LARGE lid.</li><li>Let stand FOR 30 minutes UNTIL the liquid IS absorbed</li><li>Mix IN the remaining ingredients omitting the Chavrie Goat LOG.</li><li>Season WITH salt AND pepper AND chill well</li><li>Dice the Chavrie Goat LOG AND fold INTO the mixture</li><li>Serving Suggestions:</li><li>Serve well chilled AS part OF a platter WITH the Chavrie Hummus Recipe</li><li> FOR an easy preparation follow directions ON a package OF instant Tabbouleh AND fold IN diced 4oz.Chavrie Goat LOG </li></ol>  middleEastern  45  10  t  f  f  f
290  Chicken Shawarma Bowl  https://spoonacular.com/recipeImages/Chicken-Shawarma-Bowl-638316.jpg  <ol><li>Preheat oven TO 400 degrees.Peel carrots.ON a baking sheet toss carrots WITH olive oil.ADD spices AND toss.Place IN oven AND cook FOR 30 minutes, flipping AT 15 minutes.</li><li>Meanwhile SLICE chicken breasts INTO 1/2 inch bite sized pieces.ON a separate baking sheet, place chicken.Squeeze juice OF 1/2 lemon OVER chicken.ADD spices AND toss UNTIL evenly distributed.Place chicken IN oven AND bake till chicken IS cooked though, about 23 minutes.Once done, SET aside AND let rest.</li><li> AS the chicken AND carrots are cooking, PREPARE rice.ADD olive oil TO a medium pot ON medium high heat.ADD onion AND garlic, stirring so garlic does NOT burn, AND cook about 2 minutes.ADD spices AND stir TO distribute evenly.ADD rice, chicken broth AND juice OF 1/2 lemon.Bring TO a boil AND THEN cover AND reduce TO a simmer till rice IS thoroughly cooked through, about 20 minutes.</li><li>Make Tzatziki:Stir together yogurt WITH dill, garlic powder AND pepper.Place IN refrigerator till ready TO serve.</li><li>Serve:Place rice ON bottom, THEN chicken.ADD dollops OF hummus AND taziki ON top OF chicken.Sprinkle parsley AND tomatoes ON top.Scoop up WITH pita.</li><li>ENJOY!</li></ol>  middleEastern  45  4  f  f  f  f
291  Colorful Red Quinoa NOT So Tabbouleh Salad  https://spoonacular.com/recipeImages/Colorful-Red-Quinoa- NOT -So-Tabbouleh-Salad-639950.jpg  <ol><li>Wash the 1 cup OF quinoa IN a colander FOR several seconds.ADD quinoa, water AND salt TO a small pot AND boil FOR 15 minutes.You will know it IS cooked WHEN it becomes soft AND you see little white antennas pop FROM the grain.</li><li>Meanwhile, wash ALL your veggies well AND chop AND dice them accordingly.</li><li> ADD ALL the veggies TO a medium glass bowl AND toss.IN a small bowl mix the red wine vinegar, olive oil AND ALL the spices AND blend well.ADD the vinagrette TO the salad AND enjoy.</li></ol>  middleEastern  30  4  t  t  t  t
292  Easy Tabouleh  https://spoonacular.com/recipeImages/Easy-Tabouleh-642121.jpg  <ol><li>Chop the vegetables AND parsley finely.The restaurant VERSION has the veggies diced fairly small AND I wanted TO stay TRUE TO that.</li><li>Rinse the cracked wheat IN a fine mesh sieve AND let drain.</li><li>Combine ALL ingredients IN a LARGE bowl.</li></ol>  middleEastern  45  1  t  t  f  t
293  Falafel Burger  https://spoonacular.com/recipeImages/Falafel-Burger-642539.png  <ol><li>Pat the chickpeas dry WITH a paper towel AND throw them INTO a food processor along WITH the garlic.</li><li>Puree UNTIL smooth.</li><li> USING your clean hands incorporate tahini, sriracha, parsley AND onion INTO the chickpea mixture.</li><li>Form mixture INTO four patties AND SET aside.</li><li>Heat peanut oil IN a LARGE skillet OVER medium heat.</li><li>Once the oil begins TO shimmer ADD the patties AND cook FOR three minutes per side OR UNTIL golden brown.</li><li>Remove FROM AND place IN a hamburger bun.</li><li>Top EACH burger WITH 2 slices OF tomato, 2 slices OF cucumber AND a dollop OF tzatziki.</li><li>Serve immediately.</li></ol>  middleEastern  45  4  t  f  f  t
294  Falafel Burgers  https://spoonacular.com/recipeImages/Falafel-Burgers-642540.jpg  <ol><li>Combine the chickpeas, onion, garlic, parsley, flour, spices, AND salt, AND pulse UNTIL the mixture IS well combined.Form the mixture INTO 4 LARGE patties.</li><li>Heat the oil IN a LARGE, nonstick skillet SET OVER medium-high heat.Cook FOR about 3 minutes per side.</li><li>Make the tahini sauce:Whisk the tahini paste WITH the water, lemon juice AND zest, salt, AND freshly ground black pepper IN a mixing bowl.</li><li>Serve the burgers IN pita pockets OR ON a bun.Top them WITH tahini sauce, lettuce, AND tomato.</li></ol>  middleEastern  45  4  t  t  f  t
295  Indian-Inspired Falafel Appetizer  https://spoonacular.com/recipeImages/Falafel- WITH -An-Indian-Twist-642547.jpg  <ol><li>Clean AND wash the garbanzo beans, black eyed peas AND green gram.Soak the lentils overnight/ 6-8 hours IN excess water.Drain AND SET them aside.</li><li>Grind them TO a coarse paste IN a grinder WITHOUT water.Mix IN ALL the ingredients AND let the mixture sit FOR 1-2 hours IN refrigerator.Bring them down TO room temperature AND roll them INTO small balls USING a falafel scoop OR a spoon OR a small ice cream scoop AND place OVER a baking sheet covered WITH a parchment paper.</li><li>Heat 3 inches OF oil IN a deep cooking vessel (375 degrees).Once the oil gets heated up, FIRST fry 1 ball AND IF the balls lose shape, ADD little more flour FOR maintaining the shape.</li><li>Fry them IN batches OF 6 AT a TIME FOR 2-3 minutes ON one side OR UNTIL they turn golden brown.Drain excess oil AND serve WITH a salad/pita bread/tahini sauce.</li></ol>  middleEastern  45  12  t  t  f  t
296  Grilled Fattoush  https://spoonacular.com/recipeImages/Grilled-Fattoush-645704.jpg  <ol><li>Preheat the grill TO high.Halve the zucchinis length-wise AND cut the peppers INTO LARGE chunks AND remove seeds.</li><li>Separate the layers OF the pitas TO make 6 pita circles.</li><li>Drizzle olive oil OVER the zucchini, peppers, AND pitas, AND salt AND pepper them.Roll them around, TO make sure they have a good coat OF oil.Grill the veggies FOR about 2-3 minutes per side, UNTIL nice grill marks have formed AND the veggies are slightly tender.THEN grill the pitas, FOR 1 MINUTE per side, UNTIL toasty.</li><li> IN a LARGE serving bowl, ADD ALL the other veggies AND herbs.</li><li>Once the grilled veggies have cooled, chop them INTO inch cubes AND ADD them TO the serving bowl.</li><li>Break the pitas INTO bite-size pieces AND ADD TO the mix.Toss the salad AND sprinkle the feta OVER the top.</li><li>Mix  cup OF olive oil AND the juice OF one lemon IN a small bowl.Season WITH cumin, salt AND pepper AND whisk.Drizzle OVER the salad WHEN ready TO serve!</li></ol>  middleEastern  45  6  t  f  f  f
297  Izmir Kofte  https://spoonacular.com/recipeImages/Izmir-Kofte-648306.jpg  <ol><li>Heat the oven TO 175 degrees Celsius OR 350 degrees Fahrenheit.</li><li>Make the sauce FIRST.Melt the butter IN a small saucepan.Stir IN the tomato paste, THEN ADD the tomatoes AND water OR stock.Season WITH salt AND pepper.Bring the mixture TO a boil.Let simmer, stirring occasionally, WHILE you make the köfte so that the tomatoes boil down.</li><li>Combine the ground lamb OR beef, onion, garlic, eggs, paprika, cumin AND parsley IN a LARGE bowl.Season WITH salt AND pepper.WITH moistened hands, mix the ingredients FOR about 2 minutes.Keep a bowl OF warm water nearby TO wet your hands WHILE working.Shape the meat mixture INTO 20-25 oval balls.</li><li>Heat the oil IN a LARGE skillet OVER high heat, ADD the köfte AND lightly brown the meat ALL OVER (about 5 minutes).Place the kfte IN an ovenproof dish AND SET them aside.</li><li>Pour the tomato sauce OVER the kfte.Arrange the green peppers ON top.Cover the dish AND bake FOR 40 minutes.TO CHECK FOR doneness, cut one köfte OPEN;
it should be brown, NOT pink.</li><li>Serve WITH fried potatoes OR rice AND salad.</li></ol>  middleEastern  45  6  f  f  t  f
298  Jordanian Mansaf  https://spoonacular.com/recipeImages/Jordanian-Mansaf-648615.jpg  <ol><li> IN A LARGE POT BEFORE TURNING ON HEAT MIX IN ALL YOGuRT</li><li> ON HIGH HEAT BRING YOGuRT ( OR Jameed) TO A BOIL.(VERY IMPORTANT) MAKE SURE WHILE BRINGING YOGuRT TO BOIL, YOU ARE CONSTANTLY STIRRING YOGART WITH A WOODEN LADLE ONE WAY ONLY.SO IF YOU STARTED STIRRING TO THE LEFT YOU MUST KEEP STIRRING THAT WAY UNTIL YOGurT STARTS TO BOIL.</li><li>ONCE YOGuRT BOILS TURN HEAT OFF.</li><li> IN ANOTHER POT COVER lamb shanks OR CUT UP LAMB ( WITH BONES) WITH WATER.</li><li> ADD 1/4 OF AN ONION.</li><li>BOIL UNTIL LAMB IS TENDER.</li><li>REMOVE LAMB AND STRAIN WATER (LAMB BROTH) TO REMOVE ANY SMALL PARTICALS.</li><li> ADD ABOUT 2-3 CUPS OF THE WATER (LAMB BROTH ) TO THE POT OF COOKED YOGART.</li><li> ADD salt TO taste AND IF NOT tart enough you may ADD juice FROM about 1/2 a lemon.</li><li> ADD lamb meat TO the yogart AND broth mixture (make sure TO remove the onion) AND let boil one more TIME.</li><li>Cook rice WITH 1 cup OF butter</li><li>Brown almonds AND pine nuts IN remaining butter.</li><li>Once rice IS cooked remove it FROM pot AND place it IN a LARGE round platter, THEN spread half OF the nuts ON top OF rice, THEN place lamb meat OVER rice AND nuts, THEN spread remaining nuts OVER entire platter</li><li>Place the cooked yogurt IN a LARGE serving bowl</li><li> WHEN serving put Arabic bread AND wet it WITH SOME yogurt, THEN ADD rice AND meat IN individual plates AND spread cooked yogurt AND slivered nuts OVER it.</li><li>Enjoy</li></ol>  middleEastern  45  6  f  f  f  f
299  Kick Butt Baklava  https://spoonacular.com/recipeImages/Kick-Butt-Baklava-648865.jpg  <ol><li> DO :</li><li>Preheat the oven TO 350 degrees.</li><li>Butter your pan...I used my small Mario Batali loaf pan.Note:this recipe makes a very small baklava so keep that IN mind WHEN choosing your pan.That OR just DOUBLE /triple it TO make it IN a bigger pan.</li><li> IN a bowl, combine the walnuts AND cinnamon AND mix together.</li><li>Unroll phyllo dough AND cut it TO MATCH your pan length.I say this because the Mario Batali pan that I used was long AND quite narrow;
it''s about 2 inches wide.</li><li>Lay two sheets OF phyllo INTO the bottom OF your pan.Sprinkle SOME OF your walnut cinnamon mixture ON top;
just enough TO cover the phyllo.Repeat layers UNTIL ALL ingredients are used, finishing WITH a phyllo dough layer.</li><li> USING a sharp knife, cut the uncooked baklava INTO 1 1/2 TO 2 inch pieces.Again, adapt this depending ON what kind OF pan you are USING.</li><li>Put your pan INTO your oven AND bake FOR 30-35 minutes, UNTIL golden AND crispy.</li><li> WHILE your baklava IS cooking, PREPARE your ''sauce''.</li><li> IN a pan ON the stove, combine sugar AND water AND bring TO a boil.</li><li>Stir IN agave nectar, vanilla AND lime zest, reduce heat AND simmer FOR about 15 minutes.Note:keep an eye ON it AND stir continually so you don''t GET a sticky gross mess IN the bottom OF your pan.</li><li> WHEN baklava IS done IN the oven, remove AND immediately pour the ''sauce'' ON top.It will simmer something crazy against the hot baklava pan.That''s ok.Pour it ON AND THEN leave it alone.That means let it sit UNTIL it''s cooled.</li></ol>  middleEastern  45  1  f  f  f  t
300  Lamb Kofta  https://spoonacular.com/recipeImages/Lamb-Kofta-649219.jpg  <ol><li>Combine lamb mince, egg, breadcrumbs AND garam masala.Shape INTO 24 meatballs.</li><li>Heat oil IN LARGE pan ON high.Fry meatballs 8-10 minutes turning them occasionally.Remove FROM pan.</li><li>Saute garlic AND ginger IN pan.ADD curry powder AND cook 1 MINUTE.Reduce heat TO low, THEN ADD tomatoes WITH their liquid.Simmer FOR 2-3 mins.</li><li> ADD meatballs AND heat through FOR about 5 mins.</li><li>Serves 4</li></ol>  middleEastern  45  1  f  f  f  t
301  Lebanese Falafel  https://spoonacular.com/recipeImages/Lebanese-Falafel-649407.jpg  <ol><li> IN a food processor combine ALL ingredients AND pulse UNTIL smooth.Place IN a sealable container AND refrigerate FOR AT least one HOUR.</li><li>Preheat oven TO 400. Spray a cookie sheet WITH cooking oil, SET aside.</li><li>Scoop two tablespoons OF mixture AND roll WITH your hands TO CREATE a ball.Place ON PREPARED cookie sheet.Repeat FOR ALL the mixture.Makes about 12 equally sized falafel balls.</li><li>Brush falafel WITH olive oil AND bake IN the oven FOR 20 minutes.You can opt TO broil them FOR an additional 2 minutes TO brown the tops.</li><li> IN the meantime combine ALL ingredients FOR the lemon tahini sauce IN a small bowl.Whisk UNTIL smooth;
SET aside.</li><li> TO assemble spread tzatziki OVER four warmed pitas.Top WITH three falafel ball, diced tomato, red onion, cucumber AND lettuce.Drizzle WITH lemon tahini sauce AND sprinkle WITH feta cheese AND tabouleh.Fold the pita AND secure WITH tin foil.Serve warm.</li></ol>  middleEastern  45  4  f  f  f  f
302  Lebanese Tabouleh  https://spoonacular.com/recipeImages/Lebanese-Tabouleh-649411.jpg  <ol><li>Remove stems FROM parsley AND mint.Rinse leaves IN a colander.Pat dry WITH paper towel.</li><li> IN a food processor pulse parsley AND mint UNTIL finely chopped.Transfer TO a LARGE mixing bowl.</li><li> ADD green onions, tomatoes AND bulgur wheat;
stir TO combine.</li><li>Toss WITH lemon juice AND olive oil.Refrigerate FOR an HOUR BEFORE serving.</li><li>Serve ON its own OR WITH pita bread</li><li>Serves 2</li></ol>  middleEastern  45  2  t  t  f  t
303  Lettuce-Less Fattoush Salad WITH Grilled Chicken  https://spoonacular.com/recipeImages/Lettuce-Less-Fattoush-Salad- WITH -Grilled-Chicken-649970.jpg  <ol><li>Season your chicken cutlets (3 per person) OR chicken breasts (2 per person) WITH salt AND pepper.Squeeze lemon juice AND drizzle olive oil OVER the chicken AND mix UNTIL coated.ON a hot grill pan, grill the chicken.Let cool AND cut INTO strips.SET aside.</li><li>Stack your 3 whole wheat pitas AND chop them INTO 2-inch pieces.SET aside.</li><li>Prep your vegetables AND herbs AND mix them IN a bowl.Season WITH salt AND pepper.WHEN it''s TIME TO serve the salad, squeeze the juice OF half a lemon AND drizzle 2-3 tablespoons OF your olive oil AND mix the salad UNTIL the vegetables are fully coated IN the dressing.</li><li>Preheat your oven''s broiler.Spray cooking spray onto a non-stick baking sheet.Spread your pieces OF pita OVER the sheet AND spray those pieces WITH cooking spray.That way you have the pieces lightly coated IN oil ON BOTH sides.ADD TO your oven AND broil FOR 3-4 minutes ( OR less depending ON your oven''s broiler).Flip the pieces OVER AND broil again FOR 3-4 more minutes.The pita chips should be nice AND crispy.</li><li> ADD your salad TO a plate AND cover WITH pita chips AND chicken.Garnish WITH a few sprigs OF parsley.</li><li>I highly recommend toasting whole-wheat pita chips (the ones I used had flax seed) AS a healthy alternative TO croutons!</li></ol>  middleEastern  45  2  f  f  f  t
304  Moroccan kofte AND sausage stew  https://spoonacular.com/recipeImages/Moroccan-kofte- AND -sausage-stew-652427.jpg  <ol><li>Mix the beef, onion, chili, spices AND the chopped coriander leaves.</li><li> ADD the egg AND salt, mix AND combine.</li><li>Form small meatballs about the size OF a walnut (approximately 26 meatballs).</li><li>Fry the meatballs AND the sausage IN olive oil IN a LARGE frying pan UNTIL browned ALL OVER (you may need TO DO this IN batches).</li><li>Scoop OUT, THEN ADD the harissa* AND cook FOR a MINUTE.</li><li> ADD the tomatoes, chicken stock AND cinnamon.Simmer FOR 15 minutes.</li><li> RETURN the meatballs AND sausage AND simmer FOR another 20 minutes, UNTIL cooked.</li><li>Stir through the rest OF the coriander TO finish.</li><li>*Harissa:</li><li>Soak the dried chilies IN hot water FOR 30 minutes.Drain.Remove stems AND seeds.</li><li> IN a food processor blend chili peppers, garlic, salt, AND olive oil.</li><li> ADD remaining spices AND blend TO form a smooth paste.</li><li>Drizzle a small amount OF olive oil ON top TO keep fresh.</li><li>Store IN airtight container AND keep FOR a MONTH IN the refrigerator.</li></ol>  middleEastern  45  8  f  f  t  t
305  Quinoa Tabbouleh Salad  https://spoonacular.com/recipeImages/Quinoa-Tabbouleh-Salad-657686.jpg  <ol><li>Bring water TO a boil IN a medium saucepan.ADD quinoa AND stir.Cover AND reduce heat.Allow quinoa TO simmer ON medium-low heat UNTIL ALL water IS cooked OFF, about 20 minutes.Stir occasionally.Be careful NOT TO burn your quinoa.Allow TO cool.</li><li>Place cooled quinoa INTO a LARGE bowl (preferably something WITH an airtight lid).</li><li> ADD ALL remaining ingredients AND gently stir UNTIL very well-mixed.Cover AND refrigerate FOR AT least an HOUR.</li><li>Stir again BEFORE serving.</li><li>Can be stored, covered, IN the refrigerator FOR two OR three days.But it''s best ON the FIRST DAY, WHEN the veggies are still fresh AND crisp!</li></ol>  middleEastern  45  8  t  t  t  t
306  Turkey Kofta Pitas  https://spoonacular.com/recipeImages/Turkey-Kofta-Pitas-664037.jpg  <ol><li>Mix the ground turkey WITH the yellow onion, garlic, cumin, coriander, turmeric, parsley, egg, 2 tbsp olive oil, salt, AND pepper.Make sure they are evenly distributed.Make INTO 1 inch thick patties.ADD olive oil TO frying pan OVER medium high heat.Once hot, place SOME OF the turkey patties AND cook 4 minutes per side.Cook IN batches UNTIL ALL are finished.SET aside.</li><li>Meanwhile, make tzatziki.IN a small bowl, ADD Greek yogurt, dill, lemon juice, AND pepper.Refrigerate UNTIL ready TO use.</li><li> TO make pitas, place 2 turkey patties INTO EACH pita pocket half.ADD a tomato, a few slices OF red onion, SOME parsley, tzatziki AND hummus.Enjoy!</li></ol>  middleEastern  45  4  f  f  f  f
307  Winter Fattoush Salad  https://spoonacular.com/recipeImages/Winter-Fattoush-Salad-665378.jpg  <ol><li> TOAST the pita:Preheat the oven TO 350F.Whisk the oil, zaatar AND salt IN a small bowl.Lay the pita bread ON a baking sheet AND brush BOTH sides WITH the oil.Bake UNTIL crisp, 5 TO 7 minutes.WHEN cool enough TO handle, tear pitas INTO bite-size pieces.There should be about 2 cups.</li><li>Make the lentils:Saute the onions AND oil IN a small skillet UNTIL onions soften AND BEGIN TO brown.ADD the lentils AND stir TO blend.Stir IN the garlic AND parsley AND remove FROM heat.Season WITH salt AND pepper.</li><li>Cut away the thickest part OF the kale AND cabbage ribs AND DISCARD, THEN roll the leaves INTO bundles AND shred.TRIM the cucumber ends, THEN cut lengthwise INTO -inch slices.Stack the slices AND cut crosswise INTO shreds.Repeat WITH the radishes.Tear whole leaves FROM parsley AND / OR mint.</li><li>Make the dressing:Whisk the dressing ingredients IN a bowl UNTIL fully combined.You can ALSO use a handheld blender.</li><li>Compose the salad:Toss the salad ingredients IN a LARGE bowl.ADD the lentils AND pita crisps.Drizzle WITH the dressing AND toss again.Mound the salad ON a serving platter.Top WITH feta cheese AND sprinkle WITH sumac.</li></ol>  middleEastern  45  6  t  f  f  f
308  Baklava FROM Turkey  https://spoonacular.com/recipeImages/baklava_from_turkey-68401.jpg NONE middleEastern  94  1  f  f  f  f
309  A Southern Belle Visits Provence (Shrimp AND Grits Provencal Style)  https://spoonacular.com/recipeImages/A-Southern-Belle-Visits-Provence-(Shrimp---Grits-Provencal-Style)-631916.jpg	<ol><li>Pour the boiling water into a heated sauce pan and stir in the salt, onion powder, grits and Herbs de Provence.</li><li>Bring to a boil and reduce heat to a simmer and cook for 15 minutes</li><li>While grits are cooking prepare the shrimp</li><li>When the shrimp go into the saut pan add the cheese to the grits and stir well; lower heat to just keep warm</li><li>Saut onion until clear in the olive oil</li><li>Add the spinach and mix well</li><li>Cover and continue cooking over medium/low heat until wilted</li><li>Clean and devein the shrimp</li><li>Prepare a pesto using the basil leaves, sun dried tomatoes, garlic, olive oil and salt</li><li>Heat I tablespoon butter in saut pan until bubbling then add the shrimp</li><li>Cook for 2 minutes add the remainder of the butter and cook for 2 minutes</li><li>Add the pesto and lemon; coat the shrimp well</li></ol>	southern	45	4	f	f	t	f
310  Almond Sandies  https://spoonacular.com/recipeImages/Almond-Sandies-632178.jpg  <ol><li> IN a mixing bowl, cream butter AND sugar.ADD EXTRACT;
mix well.Combine flour, baking soda, baking powder AND salt;
gradually ADD TO creamed mixture.Fold IN almonds.DROP BY rounded teaspoonfuls onto ungreased baking sheets.Bake AT 300 degrees FOR 22-24 minutes OR UNTIL lightly browned.Cool 1-2 minutes BEFORE removing TO a wire rack.</li><li>Yield:about 4dozen.</li><li>NOTES :"''Buttery, rich and delicious, Almond Sandies are my husband''s favorite cookie and very popular where ever I take them,'' remarks Joyce Pierce of Caldonia, Michigan."</li></ol>  southern  45  1  f  f  f  t
311  Almond Toffee Bars  https://spoonacular.com/recipeImages/Almond-Toffee-Bars-632197.jpg  <ol><li>1. Preheat oven TO 350 degrees (325 IF USING glass dish)</li><li>2. IN a medium bowl, combine flour AND icing sugar, cut IN margarine UNTIL crumbly.Press firmly ON the bottom OF 13X9 IN baking pan.Bake 15 minutes.</li><li>3. Meanwhile, IN a LARGE bowl combine condensed milk, egg, AND almond EXTRACT </li></ol>  southern  45  1  f  f  f  f
312  Auntie Naynay''s Spicy Greens  https://spoonacular.com/recipeImages/Auntie-Naynays-Spicy-Greens-633048.jpg  <ol><li>Take the collard greens AND separate the leaves ( IF fresh).Rinse EACH leaf individually under cold running water.AFTER you rinse the collard greens thoroughly, stack several leaves ON top OF EACH other.Roll these leaves together.THEN SLICE the leaves INTO thin strips USING a cutting board AND LARGE knife.Rolling them together speeds up the process AS you are slicing through several leaves AT once.WITH Kale AND Mustard Greens, just break OFF the stem AND breakup WITH your hands, AFTER a thorough rinse.SET aside.</li><li>Combine water, onions, seasoned salt, red pepper flakes AND olive oil IN a LARGE pot.Bring it TO rolling boil, the lower the heat halfway.Cook FOR 5 minutes.THEN ADD the greens TO the pot UNTIL FULL, cover, AND let it cook down (2 minutes) THEN ADD the rest OF the greens.Cover, turn the heat down just a little AND let it cook - stirring every few minutes FOR about 45 minutes OR TO the tenderness you prefer.ADD a little water IF needed during cooking.</li></ol>  southern  45  6  t  t  t  t
313  Baked Fried Chicken WITH Cauliflower Mash  https://spoonacular.com/recipeImages/Baked-Fried-Chicken- WITH -Cauliflower-Mash-633624.jpg  <ol><li> FOR marinade:</li><li>Fillet chicken breast IN half TO make thinner pieces, AND cut IN half again TO make smaller pieces.</li><li>Whisk ALL marinade ingredients ( EXCEPT FOR the chicken) IN LARGE bowl.</li><li> ADD chicken AND coat IN marinade.</li><li>Chill overnight FOR more intense flavor.But IF you are short ON TIME (which I usually am) it IS ok TO use RIGHT away AS well.</li><li> FOR breading:</li><li>Preheat TO 450F</li><li>Mix breading ingredients LARGE bowl.Place wire rack ON baking sheets.Remove chicken breast FROM bowl AND place IN coating mixture.Transfer TO rack.Repeat WITH remaining chicken breasts.- Place chicken breasts ON rack AND spray WITH olive oil.</li><li>Bake chicken 20 minutes OR UNTIL coating IS browned AND instant- READ thermometer registers 155F.</li><li> FOR Cauliflower:</li><li>Cut up cauliflower IN small pieces.</li><li>Place IN LARGE saut pan WITH about 1 cup OF water (enough TO cover the bottom OF pan, plus a little extra TO make sure it doesn''t ALL evaporate)</li><li>Cook UNTIL tender.</li><li>Combine cauliflower WITH buttermilk, sour cream, ricotta AND salt AND pepper.</li><li> IN batches, place IN blender AND puree UNTIL smooth.( IF it IS HAVING a hard TIME blending, ADD either SOME chicken OR vegetable stock, OR even more buttermilk)</li></ol>  southern  45  6  f  f  f  f
314  Baked Sweet Potato Fries  https://spoonacular.com/recipeImages/Baked-Sweet-Potato-Fries-633837.jpg  <ol><li>Spray a 15 x 10 x 1 inch baking pan WITH nonstick coating.Scrub potatoes;
cut lengthwise INTO quarters, THEN cut EACH QUARTER INTO 2 wedges.Arrange potatoes IN a single layer IN pan.</li><li>Combine margarine OR butter, salt, AND nutmeg.Brush onto potatoes.Bake IN a 450 oven 20 minutes OR UNTIL brown AND tender.</li></ol>  southern  45  1  f  f  t  t
315  Banana Sponge Cake  https://spoonacular.com/recipeImages/Banana-Sponge-Cake-634190.jpg  <ol><li> IN mixing bowl, whisk mashed banana, sugar, eggs, milk AND SP AT high speed till thick.</li><li>Lower speed ADD IN banana essence AND vanilla essence, THEN slowly ADD IN PLAIN flour.</li><li>Stop machine AND use hand whisk TO mix well.</li><li>Lastly pour IN corn oil IN 3 batches AND mix well again.</li><li>Pour batter INTO a 9" (lined) square cake tin.</li><li>Bake in preheated oven at 170C for about one hour.</li><li>Place cake tin at the lowest rack of the oven and cover cake with foil if the topping is too brown after 40 mins of baking.</li></ol>	southern	45	1	t	f	f	f
316  BBQ Beef Brisket  https://spoonacular.com/recipeImages/BBQ-Beef-Brisket-634486.jpg  <ol><li> TRIM ANY LARGE, thick pieces OF fat FROM the brisket (dont remove ALL OF the fat because it keeps the meat moist during cooking AND adds flavor)</li><li>Sprinkle brisket WITH salt AND pepper.</li><li>Mix the onion powder, garlic powder, smoked paprika, cumin, AND cayenne pepper together IN a small bowl.</li><li>Dry rub BOTH sides OF the brisket WITH the seasoning mixture.</li><li>Heat oil IN a pan OVER medium-high heat AND sear the meat ON BOTH sides.</li><li>Remove FROM the heat AND SET aside.</li><li>Stir together the honey barbecue sauce AND brown sugar.</li><li>Pour half OF the sauce INTO the bottom OF your slow cooker.</li><li>Place the brisket, fatty side up, INTO the slow cooker.</li><li>Cover the top o the brisket WITH the remaining sauce.</li><li>Cover the slow cooker AND SET heat TO low FOR 9 hours, OR UNTIL fork tender.</li><li> WHEN the brisket IS cooked, remove it carefully FROM the slow cooker AND place it ON a cutting board.</li><li>Pour the sauce FROM the slow cooker INTO a saucepan AND let it cool.</li><li>Skim the fat that has risen TO the top OF the sauce IN the LARGE bowl.</li><li>It will appear lighter IN color than the sauce, LIKE droplets OF oil ON the surface.Skim AS much fat AS you can.</li><li> IN a small bowl, stir together cornstarch AND 1 tbs.OF water till completely smooth.</li><li>Pour the cornstarch mixture INTO the bowl OF sauce AND stir TO combine.</li><li>Reduce the sauce quickly IN a saucepan ON the stovetop BY simmering it TO 10 minutes.</li><li>Pour the sauce OVER the brisket AND serve.</li><li>The leftovers make great BBQ sandwiches.</li><li> IF you LIKE crockpot food, be sure TO CHECK OUT SOME OF my favorite recipes AT www.mealdiva.com</li></ol>  southern  45  8  f  f  t  t
317  Boozy BBQ Chicken  https://spoonacular.com/recipeImages/Boozy-Bbq-Chicken-635675.jpg  <ol><li>DIRECTIONS:</li><li> OPEN beer START TO drink.</li><li>Soak wooden skewers IN a shallow dish filled WITH water.IN a LARGE glass OR ceramic dish, mix orange juice, olive oil, wine, soy sauce, Sriracha OR Tabasco sauce, molasses, garlic, ginger AND pepper.</li><li>Cut orange, peppers, onion & broccoli INTO LARGE bite-sized chunks ( AT least 1" thick) and place in the dish.</li><li>Add mushrooms and tomatoes.</li><li>Stir veggies in marinade to coat.</li><li>Cover and refrigerate while you prep chicken.</li><li>Warm outdoor grill to medium heat.</li><li>Rinse chicken and pat dry with paper towel (toss that towel!).</li><li>In small bowl mix mustard, salt and pepper. Brush chicken with mustard mixture.</li><li>Wash your hands and go stir those veggies so all sides absorb the marinade.</li><li>When beer is half empty, refill can with salad dressing and squeeze in juice from 1/2 lemon.</li><li>Put can on a disposable baking sheet. Place upright chicken on can like a stand, inserting can into cavity of chicken.</li><li>Place baking sheet with beer and chicken on the preheated grill.</li><li>Cover. Set your time for 1 hour.</li><li>Start on a second beer or that remaining white wine.</li><li>In a medium saucepan, pour rice, water, and 3-4 splashes of your beverage (about 1/4 cup) into medium sauce pan.</li><li>Bring to a boil, stir and reduce heat to low.</li><li>Cover with lid and cook for 25-30 minutes.</li><li>Back to the kebabs.</li><li>Remove veggies from fridge and using the sharp end of the skewer begin threading.</li><li>Distribute veggies evenly onto 6-8 skewers.</li><li>Check rice: It''s done when all liquid is absorbed but before it starts sticking to the bottom of the pan.</li><li>Turn off heat under the rice and let it sit.</li><li>Go back to grill.</li><li>You should be at about an hour on the chicken.</li><li>Carefully slice in to see meat has gone from pink to white.</li><li>Remove from grill</li><li>Allow to cool for at least 15 minutes so you don''t burn the hell out of yourself cutting it into pieces for your guest(s).</li><li>In the meantime throw those kebabs directly on the grill.</li><li>Flip them over after about 5 minutes to get the other side and allow to cook for another 5-8min.</li><li>Kebabs are done when veggies are al dente (softened but still firm).</li><li>Turn off grill and remove from heat.</li><li>Put rice in a serving dish, and chicken pieces and full skewers on a platter. Squeeze remaining lemon juice over chicken.</li><li>Let people serve themselves.</li><li>Eat, drink and be merry!</li><li>DW | Food and Drink</li></ol>	southern	45	6	f	f	f	t
318  Brandy Bread Pudding  https://spoonacular.com/recipeImages/Brandy-Bread-Pudding-635901.jpg  <ol><li>Preheat oven TO 325. Put the raisins IN a bowl, pour the brandy OVER them AND let soak FOR 1/2 HOUR.Arrange the 8 slices OF bread, which you have buttered ON BOTH sides, IN a buttered baking dish.Bring the milk TO a boil, remove FROM the heat AND stir IN the sugar UNTIL completely dissolved.WITH an electric mixer, beat the eggs AND egg yolks;
pour IN the milk gradually AND ADD the vanilla.IN the baking dish pour the raisins AND brandy OVER the </li></ol>  southern  45  1  t  f  f  f
319  Gluten Free AND Flour-Less Bread WITH Collard Greens  https://spoonacular.com/recipeImages/Gluten-Free---Flour-Less-Bread-w--Collard-Greens-644791.jpg	<ol><li>Preheat your oven to 375 degrees. Begin by roasting the garlic, jalapenos and bell pepper. Leave the skin on the garlic cloves, wrap in tin foil and place wrapped garlic and all peppers on a cookie sheet; roast for 20 - 25 minutes, until veggies look puffy and skin is browned and flaying away from the flesh of the peppers.  A few minutes after putting the garlic and peppers in the oven, open both bags of collard greens, spread the greens over a cookie sheet and place in oven for 12 minutes with the roasting peppers in order to thaw the greens.</li><li>Remove the greens and roasted veggies from the oven; allow to cool. While cooling, crack the eggs into a large mixing bowl. Beat eggs, add the grapeseed oil and stir.  Once the greens are cool enough to handle, take large handfuls of the collard greens and squeeze all the water out of them over the sink. Once the water is squeezed out, put the handfuls in the mixing bowl with the egg.  Do this for all of the collards.</li><li>Using your fingers, remove the skin from the peppers, remove the seeds and chop into small pieces.  Remove the garlic cloves from the foil, remove the skin and coarsely chop the garlic.  Add chopped peppers and garlic to the mixing bowl with the collards and egg.  Add salt and crushed red pepper to the mixing bowl.  Using a fork, mix everything together until everything is coated with egg.</li><li>Line a baking sheet with parchment paper. Turn the collard mixture out on top of the parchment paper.  Using a fork, press mixture firmly into the parchment paper. There is enough in this recipe to cover a 12 x 17 baking sheet, though be prepared to do a lot of pressing in order to evenly disburse the mixture over the full sheet.</li><li>Bake in the oven for 30  35 minutes until the edges are just barely beginning to brown and the collards feel dry and firm to the touch.</li><li>Allow to cool and pulling the edges of the parchment paper, place on a chopping block. Chop the bread into desired sizes. This makes 12 decent sized squares. Use for sandwiches, paninis, personal-sized pizzas or eat plain as a snack.</li></ol>	southern	45	12	t	f	t	t
320  Herb chicken WITH sweet potato mash AND sauteed broccoli  https://spoonacular.com/recipeImages/Herb-chicken- WITH -sweet-potato-mash- AND -sauted-broccoli-646651.jpg  <ol><li> Preheat the oven TO 350F (180 C ) OR 320F (160 C ) FOR convection oven AND cook the chicken according TO the pack instructions.</li><li> About 15 minutes BEFORE the END OF the chicken cooking TIME, place the diced potato INTO boiling water FOR 5 minutes, THEN ADD the sweet potato AND cook UNTIL the potatoes are tender.Roughly mash, adding butter, salt, AND pepper TO taste, THEN mash thoroughly.</li><li> Heat the oil IN a pan AND quickly saut the broccoli UNTIL tender.Cover TO keep warm.</li><li> Remove the chicken FROM the oven, leave TO cool FOR a MINUTE THEN cut the bag OPEN AND gently tip the contents INTO a dish.</li><li> SLICE the chicken breasts INTO chunky pieces ON a board, keeping the chicken breast shape together.</li><li> Serve the mash potato topped WITH the chicken AND remaining sauce WITH a side OF broccoli.</li></ol>  southern  45  4  f  f  t  f
321  How Sweet It IS Sweet Potato Lasagne  https://spoonacular.com/recipeImages/How-Sweet-It- IS -Sweet-Potato-Lasagne-647563.jpg  <ol><li> SLICE the Sweet Potato INTO 1/4 inch thick slices.Boil UNTIL semi-cooked (about 10 min).Rub the slices WITH a dry curry powder & olive oil (1cup) mixture.SET aside AND let marinate FOR AT least 10 min.</li><li> SLICE Eggplants INTO 1/4 inch thick slices AND rub ALL OVER WITH an olive oil (1 cup)/dried basil/salt & pepper mix.SET aside AND let marinate FOR AT least 15 min.</li><li>Pour canola OR vegetable cooking oil INTO a pan.Saute spinach AND mushrooms FOR about 3-5 min, ADD IN jalapenos AND salt & pepper TO taste.</li><li>Turn the heat down AND ADD IN SOME heavy cream AND about 1/2 OF the mexican cheeses UNTIL mixture IS creamy, but NOT watery.</li><li> START layering the lasagne IN this ORDER :Sweet Potatoes, Spinach/Mushroom Mix, Eggplants, Marinara Sauce, Sweet Potatoes, Spinach/Mushrom Mix, Eggplants, THEN finally sprinkle the remaining Monterey Jack/Cheddar Cheese Blend ON top.</li><li>Bake AT 350-375 FOR about 35-45 min, depending ON how your oven works.You''ll know it''s ready WHEN you can pass through a fork easily through ALL the layers.</li><li>Devour WITH Passion</li></ol>  southern  45  6  t  f  t  f
322  Kale AND Roasted Sweet Potato Soup WITH Chicken Sausage  https://spoonacular.com/recipeImages/Kale- AND -Roasted-Sweet-Potato-Soup- WITH -Chicken-Sausage-648721.jpg  <ol><li>Place cubed sweet potatoes IN a baking pan OR dish.Season WITH salt AND pepper AND coat WITH olive oil.</li><li>Bake FOR 20  25 minutes, UNTIL soft.Remove FROM oven AND SET aside.</li><li> IN a dutch oven OVER medium heat, warm SOME olive oil.</li><li>Cook the chicken sausage UNTIL just browned.</li><li> ADD IN onion AND mushrooms AND cook FOR about 3  5 minutes, UNTIL softened.</li><li> ADD IN garlic, thyme, coriander, SOME sea salt AND black pepper.Stir IN AND cook FOR about 1 MINUTE.</li><li>Pour IN chicken stock AND bring TO a boil.</li><li>Reduce heat AND simmer FOR about 5  10 minutes.</li><li> ADD IN roasted sweet potatoes AND kale.</li><li>Push the kale down INTO the soup so its submerged.Cook FOR about 3  5 minutes, UNTIL bright green AND tender.</li></ol>  southern  45  4  f  f  t  t
323  Lamb AND Sweet Potato Stew  https://spoonacular.com/recipeImages/Lamb- AND -Sweet-Potato-Stew-649190.jpg  <ol><li> IN a bowl toss lamb WITH flour AND salt AND pepper TO taste.IN a 10-inch skillet heat oil OVER moderately high heat AND saute garlic, stirring, 1 MINUTE.ADD lamb AND brown, stirring, about 2 minutes.ADD wine AND boil 1 MINUTE.ADD water AND cinnamon stick AND scatter sweet potato ON top.</li><li>Simmer stew, covered, about 30 minutes, OR UNTIL lamb IS tender, AND season WITH salt AND pepper.</li><li>Serves 2.</li></ol>  southern  45  1  f  f  f  t
324  Lentil, Sweet Potato AND Spinach Soup  https://spoonacular.com/recipeImages/Lentil--Sweet-Potato-and-Spinach-Soup-649946.jpg	<ol><li>Let the dry beans soak for a 2-3 hours before you start the soup. When ready to cook, pour the water in a pot, let boil and add the onions and garlic. Add the lentils, peanut butter, and bay leaves when the water comes to a steady boil. Cover the pot and cut up the potatoes and carrots. Let the lentils cook for an hour or so, checking on it periodically (adding water is common). Then add the potatoes and carrots, along with various seasonings (curry, salt, pepper and cumin) and cover. Make sure to taste as go and let cook for about another 45 minutes to an hour. Turn off the flame and place a bunch of fresh spinach on the bottom of a bowl, pour in the soup and enjoy!</li></ol>	southern	45	6	t	t	t	t
325  Mashed Sweet Potato, Apple AND Cotija Quesadillas  https://spoonacular.com/recipeImages/Mashed-Sweet-Potato--Apple-and-Cotija-Quesadillas-651245.jpg	<ol><li>Heat 1 tablespoon of oil in a medium saucepan and add onions and apples. Cook until they turn begin to brown, approximately 15-20 minutes.</li><li>As onions and apples cook, heat tortillas slightly in the oven (300 degrees for 10-15 minutes) or on the stove in a pan sprayed lightly with cooking spray. They should not get crispy, only warm.</li><li>In a small bowl, mash warm sweet potatoes, honey, 1 tablespoon butter, lime juice and zest, cumin, cilantro and red pepper flakes.</li><li>Spread a layer of sweet potatoes, onion-apple mixture and then crumble cheese on one half of the tortilla and fold over. (Resist the urge to overfill.) Using remaining 1 tablespoon of butter and 1 tablespoon oil, toast quesadillas on both sides until golden brown.</li><li>For a little added snazzle, whisk a bit of chili pepper, honey and lime juice together and drizzle on top.</li><li>We used Fujis. A crisp, sweet apple works best.</li></ol>	southern	45	3	f	f	t	f
326  Okra Tomato Side Salad  https://spoonacular.com/recipeImages/Okra-Tomato-Salad-653549.jpg  <ol><li>Remove ends OF okra pods, DISCARD.SLICE okra.</li><li>Place okra IN a basket AND steam FOR five TO seven minutes.</li><li>Roughly chop a tomato.</li><li> WHEN okra IS cooked, place IN a bowl AND toss WITH tomato.</li><li>Season WITH salt AND pepper.</li><li> IN a small bowl whisk basil INTO balsamic vinegar.</li><li>Drizzle OVER okra AND tomato.</li></ol>  southern  45  1  t  t  t  t
327  Smoky Black Bean Soup WITH Sweet Potato AND Kale  https://spoonacular.com/recipeImages/Smoky-Black-Bean-Soup- WITH -Sweet-Potato---Kale-660405.jpg	<ol><li>Spread the dry beans out on a baking sheet and pick out any pebbles. </li><li>Place the beans in a big soup pot, cover with water by 3 inches and allow them to soak overnight or for 6-8 hours, then discard that water. </li><li>Return the soaked beans to the pot and cover with 3 inches of water again, bring to a boil. Reduce heat to medium low, put the cover on and allow to cook until the beans start to get tender but still firm, about 1 1/2 hours. Drain the beans.</li><li>Heat the oil in a soup pot over med-high heat. </li><li>Add the onion along with a pinch of salt and saute until softened and golden. </li><li>Stir in 1 tbsp of ground cumin, add the beans along with the broth or water and bring to a boil. Reduce heat to medium-low, cover and cook for 30 min. </li><li>Meanwhile peel and chop the sweet potatoes. </li><li>Wash the kale, remove the stems and chop the leaves.</li><li>Remove half of the beans and liquid and set aside to cool a bit. </li><li>Add the sweet potatoes and kale to the pot with some salt and pepper. Cover and cook for 10 minutes. </li><li>Transfer the cooled beans to a blender and puree until smooth, then return them to the pot. </li><li>Stir in the remaining 1 tbsp of ground cumin. </li><li>Now add 1 tbsp of the chipotles in adobo. Taste and continue to add more until it has a spice level that you like. </li><li>Adjust the salt &amp; pepper as needed.</li><li>Serve with a dollop of sour cream.</li></ol>	southern	630	6	t	t	t	t
328  Southern Fried Catfish  https://spoonacular.com/recipeImages/Southern-Fried-Catfish-660697.jpg  <ol><li>Combine flour, cornmeal, garlic powder AND salt.Coat catfish WITH mixture, shaking OFF excess.Fill deep pot OR 12-inch skillet half FULL WITH oil.Heat TO 350 degrees.ADD catfish IN a single layer, AND fry UNTIL golden brown, 5 TO 6 minutes, depending ON size.Remove AND drain ON paper towels.</li></ol>  southern  45  6  f  f  f  t
329  Spicy Sweet Barbecue Sauce  https://spoonacular.com/recipeImages/Spicy-Sweet-Barbecue-Sauce-661205.jpg  <ol><li> IN a medium saucepan, heat oil OVER medium heat.ADD onion AND garlic.Cook, stirring, UNTIL onion IS soft AND translucent, about 5 minutes.</li><li>Stir IN tomatoes, chile, Worcestershire, vinegar, molasses, AND lemon juice.Simmer OVER medium-low heat UNTIL reduced BY a third, stirring occasionally, about 45 minutes.</li><li>Allow TO cool slightly, THEN pure USING an immersion blender ( IF you don''t have one, you can pure the sauce IN a blender, working WITH batches.Season WITH salt AND black pepper.Refrigerate IN a jar WITH tight-fitting lid FOR up TO 2 weeks.</li></ol>  southern  45  1  f  f  t  t
330  Splendid Texas Caviar  https://spoonacular.com/recipeImages/Splendid-Texas-Caviar-661386.jpg  <ol><li>Mix together ALL OF the ingredients AND allow them TO sit IN the refrigerator FOR 5 hours OR overnight ( IF you can).</li><li>It''s best IF you take the bean salad OUT OF the refrigerator about an HOUR BEFORE serving TO bring them TO room temperature.</li></ol>  southern  300  3  t  t  t  t
331  Sweet AND Sour BBQ Spare Ribs  https://spoonacular.com/recipeImages/Sweet- AND -Sour-BBQ-Spare-Ribs-662442.jpg  <ol><li>Preheat oven TO 250</li><li> IN a bowl, whisk together ketchup, barbecue sauce, vinegar, brown sugar, mustard powder, garlic powder, AND Worcestershire sauce.Salt AND pepper TO taste.SET aside.</li><li> IN a LARGE skillet, melt butter OVER medium high heat.ADD ribs AND brown ON BOTH sides.Place ribs, meat side down, IN a 913 inch baking pan.ADD diced onions TO dish AND cover WITH sauce.</li><li>Cover baking dish WITH tin foil AND bake IN the oven FOR 4  4  hours UNTIL meat IS tender AND easily falls OFF the bone.</li><li>serves 2-3</li></ol>  southern  45  2  f  f  t  t
332  Sweet Potato, Kale AND White Bean Soup  https://spoonacular.com/recipeImages/Sweet-Potato--Kale---White-Bean-Soup-662604.jpg	<ol><li>In a large pot, heat the grapeseed oil over medium high and add the sweet potato. Saut the sweet potato, stirring consistently about 5 minutes before adding the onion. Saut about 8 minutes then add a splash of chicken broth to help steam the sweet potato and onion (the chicken broth should sizzle when it hits the pot). Continue cooking until sweet potato is softened but still al dente, another 5 minutes or so.</li><li>Add all of the chicken broth, white wine, cannellini beans and the oregano and thyme. Stir well and bring to a boil. Reduce heat to medium low and simmer covered about 10 minutes. Add the chopped kale leaves, stir, cover again and cook another 5 minutes until kale leaves are softened. Taste the soup and add salt and ground black pepper to taste.</li></ol>	southern	45	4	t	t	t	t
333  Dutch Oven Paella  https://spoonacular.com/recipeImages/Dutch-Oven-Paella-631747.jpg  <ol><li>Adjust oven rack TO lower middle POSITION AND heat oven TO 350. IN a med bowl, toss shrimp WITH 1 t.minced garlic, 1 T.olive oil, 1/4 t.salt &amp;
1/4 t.pepper.Refrigerate UNTIL needed.Season chicken WITH salt &amp;
pepper, SET aside.</li><li>Heat 2 t.oil IN a LARGE Dutch oven OVER med-high heat UNTIL oil shimmers, ADD bell pepper AND cook, stirring occasionally UNTIL skins blister AND brown about 3-4 minutes.Remove TO a plate AND SET aside.ADD 1 T.more oil TO the pot, ADD chicken thighs AND brown well, flipping once, about 3 minutes per side.Remove chicken TO a bowl, reduce heat TO medium, ADD sausage AND cook 4-5 minutes, stirring frequently, UNTIL browned AND fat starts TO render.ADD TO bowl WITH the browned chicken.</li><li>3. AT medium heat, ADD enough oil TO the pot TO equal 2 T., ADD onion AND cook, stirring frequently, UNTIL tender, about 3 minutes, ADD remaining garlic, cook FOR 1 MINUTE, ADD tomatoes, cook AND stir UNTIL tomatoes thicken AND darken slightly about 3 minutes.ADD rice, cook AND stir FOR about 2 minutes, making sure everything IS evenly mixed.ADD broth, wine, saffron, bay leaf AND 1/2 t.salt.ADD the browned chicken AND sausage.Increase heat TO med-high, bring TO a boil, stirring often.Cover pot AND place IN the oven.Bake FOR 15 minutes (liquid should be mostly absorbed).Remove pot FROM the oven (keep oven door closed TO retain heat), remove the lid, nestle the artichoke hearts down IN the rice a BIT.Sprinkle the shrimp OVER the top OF the rice, THEN, sprinkle WITH the peas AND bell pepper strips.REPLACE the led, ADD back TO the oven FOR another 10 minutes OR UNTIL the shrimp are OPAQUE.</li><li>Turn stove burner TO med-high heat.Remove the pot FROM the oven, place ON the stove cook FOR 5 minutes TO GET the browned portion ON the bottom OF the rice ( CALLED Soccarat), rotating the pot 180 degrees halfway through TO ensure even browning.Remove pot FROM heat AND let the paella rest, covered, FOR 5 minutes.Sprinkle WITH fresh chopped parsley AND lemon wedges.</li></ol>  spanish  45  6  f  f  t  t
334  Basque Paella  https://spoonacular.com/recipeImages/Basque-Paella-634454.jpg  <ol><li>Calories per serving:221. Preparation TIME :35 minutes.Cooking TIME :45 minutes.</li><li>1. IN LARGE, heavy skillet OVER medium-high heat, combine oils AND cook chicken pieces UNTIL just OPAQUE.Remove chicken TO platter.Reserve skillet.</li><li>2. Soak rice IN the boiling water FOR 10 minutes, THEN drain.</li><li>3. IN reserved skillet saute onion OVER medium heat UNTIL soft (about 5 minutes).ADD garlic, bell peppers, AND tomato AND CONTINUE sauteing FOR 5 more minutes.</li><li>4. ADD snapper, soaked rice WITH water, stock, salt substitute, saffron, AND oregano.Bring TO a boil, THEN lower heat TO medium.Cover pot AND let simmer UNTIL rice IS tender AND has absorbed liquid (about 15 minutes).</li></ol>  spanish  45  1  f  f  t  t
335  Clams WITH Spanish Sausage  https://spoonacular.com/recipeImages/Clams- WITH -Spanish-Sausage-639557.jpg  <ol><li>Scrub clams AND remove ANY that are NOT closed OR that have a bad smell.</li><li>Heat olive oil IN a pot AND sweat the garlic.</li><li> SLICE the chorizo AND ADD it TO the garlic AND olive oil TO brown.</li><li> ADD fingerling potatoes split lengthwise.Stir IN fat FROM chorizo AND cook ON medium heat UNTIL slightly borwned.ADD a small amount OF wine TO avoid burning AND TO RELEASE drippings FROM bottom OF pot.</li><li> ADD remainder OF wine, reduce TO a simmer AND cover FOR about 10 minutes, UNTIL potatoes are cooked AND soft.</li><li> ADD clams, RAISE heat TO a low boil, AND cover FOR another 10 minutes.Cook UNTIL ALL the clams OPEN up.</li><li>Sprinkle WITH chopped parsley AND serve.</li></ol>  spanish  45  4  f  f  t  t
336  Corn Flan Side Dish  https://spoonacular.com/recipeImages/Corn-Flan-640085.jpg  <ol><li>Preheat the oven TO 325 degrees.Grease four 1-cup capacity ramekins AND SET them aside.</li><li> IN a blender OR food processor, combine 1 cup OF corn kernels WITH 1/2 cup OF milk.Puree UNTIL smooth, AND repeat WITH the remaining corn AND milk.</li><li> IN a LARGE mixing bowl, ideally one WITH a handy pouring spout IF you happen TO have one OF that TYPE available TO you, combine the corn puree, ricotta, Pecorino-Romano, AND eggs.Mix them up well, AND season WITH salt AND pepper.Now pour the mixture INTO the greased ramekins, leaving a half-inch OF custard-free space LEADING up TO the top edge OF the ramekin TO allow FOR expansion.</li><li>The most difficult thing about this recipe may be HAVING TO tell your loved ones that you''re utilizing a bain-marie, AND THEN explaining what a bain-marie IS.SET your ramekins INTO a lasagna pan OR roasting pan.Carefully pour IN enough water so that the water LEVEL IS half the way up the sides OF the ramekins.Too much more, AND you run the risk OF water sneaking INTO your custards, AND we don''t want that.This IS your bain-marie, OR water bath, IN which you will cook the custards FOR 55 minutes TO one HOUR, UNTIL a knife inserted INTO the custard emerges clean.Carefully remove the bain-marie FROM the oven - we don''t want ANY splashing ON the EXIT FROM the oven, either - AND allow TO cool FOR 5 TO 10 minutes.The custards may be served warm OR AT </li></ol>  spanish  45  4  f  f  t  f
337  Easy Chicken, Kielbasa AND Shrimp Paella  https://spoonacular.com/recipeImages/Easy-Chicken--Kielbasa-and-Shrimp-Paella-641911.jpg	<ol><li>Heat the oil in a 12-inch skillet over medium heat. Add the rice and cook for 30 seconds, stirring constantly. Stir the broth, picante sauce and turmeric in the skillet and heat to a boil. Reduce the heat to low. Cover and cook for 15 minutes.</li><li>Stir the kielbasa, shrimp and chicken in the skillet. Cover and cook for 5 minutes or until the rice is tender.</li></ol>	spanish	45	8	f	f	t	t
338  Kiwi Strawberry Flan  https://spoonacular.com/recipeImages/Kiwi-Strawberry-Flan-648967.jpg  <ol><li> TO make shell, PREPARE cake mix according TO package directions AND pour batter INTO flan pan that has been sprayed WITH Pam.Bake IN a preheated 350 degree oven FOR about 25 minutes.Cool 10 minutes;
remove FROM pan.USING milk AND cream, PREPARE pudding according TO package directions.Pour INTO cooled flan shell.Top WITH kiwi fruit.Chill UNTIL firm.Just PRIOR TO serving, top kiwi WITH strawberries.Garnish WITH small amount OF whipped </li></ol>  spanish  45  1  t  f  f  f
339  Leche Flan (Caramel Flan)  https://spoonacular.com/recipeImages/Leche-Flan-(Caramel-Flan)-649419.jpg  <ol><li>Making the Caramel Syrup:Simply put 2 tablespoons OF white sugar FOR EACH mould, AND HOLD the mould OVER medium heat, allowing the sugar TO dissolve.Swirl the mould gently TO evenly distribute the caramel TO coat the mould.Make sure NOT TO burn the caramel AS this would make it bitter.A pale brown color IS what you should achieve.SET EACH aside TO cool down.</li><li>Making the Custard:IN a mixing bowl, combine ALL the ingredients namely the egg yolks, vanilla EXTRACT, white sugar, condense AND evaporated milk.Make sure you include AS little egg white AS possible TO the mixture.This will make your flan creamier AND bubble-free.</li><li>Use a whisk TO mix the ingredients thoroughly, making sure the sugar has been completely dissolved.</li><li>Pour the mixture IN the moulds.Fill EACH up AT least just half high AS the mould, because the mixture IS expected TO expand once it''s steamed.</li><li>Cover EACH mould WITH an aluminum foil TO avoid the moisture FROM the steam TO come IN contact WITH the flan.This will cause it TO become watery.</li><li>Steam cook FOR around an HOUR AT steady heat.It IS essential that you DO NOT change the amount OF heat AS this might cause uneven cooking.</li><li> CHECK every now AND THEN whether the flan IS already ready OR NOT, WITH the use OF a fork.Just gently poke the flan WITH the fork AND you will know it''s ready IF NOTHING sticks TO the fork AS you pull it OUT.</li><li>Once you achieve this, remove the moulds FROM the steamer RIGHT away AND let it cool AT room temperature.Avoid overcooking the flan AS this will make it hard AND dry.</li><li>Once the flans have cooled down, refrigerate FOR AT least an HOUR BEFORE serving.</li><li>Upon Serving:Unmould the Leche Flan BY running a knife around the edge OF the mould, carefully inverting it onto a serving dish, allowing the caramelized sugar coat the flan.Serve AND enjoy!</li></ol>  spanish  45  3  t  f  t  f
340  Leek Flan  https://spoonacular.com/recipeImages/Leek-Flan-649441.jpg  <ol><li>Butter 6 (4-ounce) ramekins AND place IN the refrigerator.WHEN the butter hardens, ADD a SECOND coating OF butter TO the ramekins.SET aside.Heat the oven TO 350 degrees.</li><li>Heat the olive oil IN a medium skillet OVER low heat.ADD the leeks, shallots AND salt AND cook UNTIL the leeks are translucent but still retain a bite, about 10 minutes.Drain.</li><li>Place the whipping cream AND half- AND -half IN a medium saucepan AND bring TO a boil.Turn OFF the heat AND cool.</li><li>Put the leek mixture IN the blender along WITH the cream mixture AND the egg whites.Blend UNTIL smooth, about 30 seconds.</li><li>Spoon the mixture INTO the PREPARED ramekins.Place the ramekins IN a LARGE baking pan.Pour boiling water INTO the pan UNTIL it reaches halfway up the sides OF the ramekins.Place the pan IN the oven.Bake UNTIL the flans are SET, about 35 TO 40 minutes.</li><li> TO serve, unmold the flans AND garnish WITH 2 (3-inch) pieces OF chives crossed OVER the top.</li><li>This recipe yields 6 servings.</li></ol>  spanish  45  6  f  f  t  f
341  Mixed Paella  https://spoonacular.com/recipeImages/Mixed-Paella-652134.jpg  <ol><li>I a very LARGE non-stick skillet OR paella pan preheated OVER medium-high heat, ADD 2 teaspoons OF your oil (you will need more oil IF you''re NOT USING non-stick), garlic, red pepper flakes AND rice.Saute FOR about 3 minutes.ADD saffron, thyme, bay leaf AND broth AND bring TO a boil.Cover AND reduce heat TO a simmer.Leave covered, DO NOT stir.</li><li> IN another non-stick skillet, heat TO medium-high.ADD chorizo AND crumble AS you saute.WHEN the sausage IS cooked through, ADD red pepper AND onion.Salt AND pepper TO taste IF needed.Saute UNTIL the onion IS tender AND remove FROM heat, SET aside.</li><li> WHEN the rice IS nearly done (about 15 minutes) ADD fish AND shrimp AND press INTO rice.ADD mussels, peas AND sprinkle WITH lemon zest.Cover AND CONTINUE TO simmer UNTIL the rice IS done AND the mussels have opened.DISCARD ANY that DO NOT.</li><li>Top WITH chorizo mixture AND parsley.Serve WITH lemon wedges AND a crusty bread.</li></ol>  spanish  45  8  f  f  t  t
342  My SIMPLE Custard Flan (Filipino Leche Flan)  https://spoonacular.com/recipeImages/My- SIMPLE -Custard-Flan-(-Filipino-Leche-Flan)-652885.jpg  <ol><li> IN a pan, mix water AND sugar UNTIL there IS NO lump.</li><li>Heat AND wait UNTIL it boils THEN turn the heat TO simmering MODE.</li><li>Simmer UNTIL the caramel IS thick.</li><li>Cool slightly AND transfer TO aluminum moulds.</li><li>Mix well the egg yolk, condensed milk AND evaporated milk BY hand.</li><li> THEN ADD vanilla AND lemon juice.</li><li>Use wooden spatula AND mix gently UNTIL well combined.</li><li>Strain the mixture AND gently pour ON TO the PREPARED moulds WITH caramel.</li><li>Fill ONLY UNTIL 3/4 OF the moulder.</li><li>Cover WITH aluminum foil AND place the moulds ON a larger baking pan half filled WITH very hot water.</li><li>Bake AT 350 OR 180 FOR 1 HOUR.</li><li>Cool AND THEN SET aside IN the fridge.</li><li> TO serve:run a thin knife around the edges OF the mould TO loosen the Leche Flan.Place a platter ON top OF the mould AND quickly turn upside down TO POSITION the golden brown caramel ON top.</li></ol>  spanish  45  4  t  f  t  f
343  Paella Soup  https://spoonacular.com/recipeImages/Paella-Soup-654326.jpg  <ol><li>Rinse, stem, seed, AND chop bell peppers.IN a 5- TO 6-quart nonstick pan OVER high heat, stir 1 1/2 cups chopped red peppers WITH the oil AND ham UNTIL peppers are limp, about 5 minutes.ADD rice, water ( AS specified ON package), AND seasoning packets.Bring TO a boil, cover, reduce heat, AND simmer UNTIL rice IS tender TO bite, 18 TO 20 minutes, stirring occasionally.</li><li>About 8 minutes BEFORE rice IS done, IN a 4- TO 5-quart pan OVER high heat, bring broth AND saffron TO a boil.Stir IN shrimp, cover, AND RETURN TO a boil.Reduce heat AND simmer UNTIL shrimp IS OPAQUE IN center OF thickest part (cut TO test), about 5 minutes.WITH a slotted spoon, transfer shrimp TO a small bowl.RETURN broth TO a boil OVER high heat.</li><li>Stir peas INTO rice mixture AND cook UNTIL they''re hot, about 2 minutes.</li><li>Mound hot rice mixture equally IN the center OF 6 wide soup bowls, spoon shrimp around rice, sprinkle WITH remaining chopped red peppers, AND ladle broth around rice.</li><li>This recipe yields 6 servings.</li><li> COMMENTS :A flavored rice mix gives this company-worthy soup a head START.</li></ol>  spanish  45  6  f  f  t  t
344  Paella FOR Four - A Wonderful Spanish Mixed Seafood Stew  https://spoonacular.com/recipeImages/Paella- FOR -Four--A-Wonderful-Spanish-Mixed-Seafood-Stew-654327.jpg	<ol><li>1. Use a 12 inch All-Clad stainless steel pan or equivalent. A paella pan is not necessary.</li><li>2. Mix the Spice Mix and rub on the chicken and refrigerate for 1 hour. Let the chicken warm up for 30 minutes before cooking.</li><li>3. Heat half of the oil in the pan to medium high heat and brown the sausage rounds, then reserve.</li><li>4. Add the remaining oil and chicken and brown on all sides, then reserve.</li><li>5. Reduce the heat to medium and add the onions, garlic and parsley to start the sofrito. Cook for 2 to 3 minutes then add the crushed and drained tomatoes and cook for about 3 minutes while flavors meld. This base sauce is the sofrito.</li><li>6. Add the rice and stir to mix thoroughly to coat all the rice; about 2 more minutes.</li><li>7. Add back the sausage and chicken. Pour in the hot water, bring to a gentle simmer and cook for about 5 minutes, stirring occasionally to mix and place the pieces.</li><li>8. Place the clams where you want them in the finished dish and don''t stir anymore. Cook for 5 minutes.</li><li>9. Place the shrimp tails up where you want them to appear in the finished dish.</li><li>10. Cook for about 10 minutes or until the clams are open, the shrimp are pink and the rice is fluffy and moist but not dry.</li><li>11. With a fork, feel the bottom of the dish. If it has formed a slight crust, called socarrat, it''s ready to be served. If the socarrat has not formed, turn the heat up for 30 to 45 seconds while the crust forms. Then serve immediately.</li></ol>	spanish	45	4	f	f	t	t
345  Paella Valencian  https://spoonacular.com/recipeImages/Paella-Valencian-654330.jpg  <ol><li>* Note:About 2 inches square;
1 OR 2 OF EACH per serving:8 TO 10 pieces OF chicken breast AND / OR thigh, 6 TO 8 pieces OF rabbit, OR 6 TO 8 pieces OF pork, meatballs, etc.( ALL optional, depending ON appetites).</li><li> IN saucepan, brown meats IN olive oil;
remove meat.IN drippings, ADD onion, green pepper, tomato, minced garlic, bay leaf, AND parsley AND saute UNTIL the onion IS soft.ADD saffron, browned meats, AND 1/4 cup OF water AND cook OVER low heat 5 TO 10 minutes.Drain the juice FROM the saucepan AND save it.</li><li>Steam mussels UNTIL they OPEN.Save the juice;
SET mussels aside.WHEN they are cool, separate the shells, leaving the mussels ON their half shells.</li><li>Transfer saucepan contents TO paella pan, distributing evenly.Place FULL head OF garlic AT center OF the pan.Divide INTO pie wedges WITH the thick strips OF red pepper standing ON edge so that WHEN it IS done, you will see the tops OF the pepper strips.Distribute rings AND heads OF calamari.Sprinkle beans OR chick peas evenly around.THEN sprinkle rice evenly around meats.ADD 8 cups OF liquid, INCLUDING saucepan saute juices AND mussel juice.</li><li>Cook, uncovered, evenly OVER low flame.This can be done IN the oven, but IS much better OVER an OPEN flame WHERE you can tend it.I prefer TO DO it OVER an adjustable grille, starting relatively CLOSE TO the hot coals TO GET it steeping AND simmering, but THEN raising the grille FROM the coals TO slow the cooking AND let the flavors mingle.Important:rotate the pan OVER the flame TO make sure it cooks evenly, AND keep flame FROM scorching the rice AT the bottom OF the paella pan.This pot takes considerable watchful attention.</li><li> WHEN the rice has risen TO the top AND much (but NOT ALL ) OF the water has cooked OFF, fan shrimp OVER the top, THEN stand the mussels IN half shells IN the rice, points down.I DO it IN an attractive pattern OF circled mussels AND fanned shrimp.</li><li> AS it cooks, gauge doneness BY tasting rice FROM several parts OF the pan TO be sure it IS the correct texture (cooked - NOT crunchy, NOT mushy) AND consistent throughout.IF more water IS needed IN certain parts OF the pan, ADD boiling water sparingly, sprinkling FROM a LARGE spoon.IF too much water IS IN the rice, lay newspaper lightly OVER the top OF it AND it will absorb excess water.</li><li>Best served RIGHT OUT OF the pan.IN Spain, eating WITH the men OUT IN the fields, the mussel shells served AS spoons.</li><li>Serve WITH crusty bread AND a tossed salad.I recommend violating the seafood-white wine RULE;
this meal goes best WITH a hardy red OF your choice.</li><li>This recipe yields 6 servings.</li><li> COMMENTS :I suggest the FIRST TIME you DO a paella that you stick CLOSE TO the recipe.AFTER that, feel free TO experiment TO taste.I ALSO suggest you DO NOT attempt a paella FOR two.This IS a meal that requires a great deal OF loving WORK TO PREPARE, more than you would feel inclined TO spend FOR ONLY two persons.It requires CLOSE attention FOR quite a few hours.It cannot be hurried.I have tried TO calculate the quantities required FOR six adults.There will be leftovers - there almost ALWAYS are.</li><li>The FIRST thing you need IS a proper paella pan.You will find paella pans OF many sizes AND shapes.The best will be the most shallow AND broad you can find, WITH its rim slanted outward.NO lid needed.I have a paella pan that serves 8 persons;
it IS about 13 inches across AT the top, 11 inches across the bottom, AND the sides are ONLY about an inch AND a half high.It feeds eight persons comfortably.(I ALSO have one that serves 16!)</li><li>The best way TO clean AND TREAT the pan:rub its insides vigorously WITH a wedge OF lemon AFTER EACH use ( AND BEFORE FIRST use), rinse, dry, AND wipe its insides WITH olive oil ON a paper towel.It should remain rust free AND ready FOR use.</li></ol>  spanish  45  1  f  f  f  t
346  Paella Catalane WITH Mussels, Squid AND Crevettes  https://spoonacular.com/recipeImages/Paella-Catalane- WITH -Mussels--Squid---Crevettes-654331.jpg	<ol><li>1. In a paella pan heat the olive oil and butter.</li><li>2. Add the chicken legs or thighs and cook until brown on both sides.</li><li>3. Next add the pork pieces and jambon and continue to cook on medium heat.</li><li>4. Whilst this is cooking, bring a pan of water to boil and cook the mussels for 10 minutes.  Drain and set aside.</li><li>5. Next wash the tomatoes and add them in a pan of boiling water for 2-3 minutes.  Prick each tomato at least once when it is in the water.</li><li>6. Rinse the tomatoes in cold water, then peel the skins.</li><li>7. Cut the tomato into 4 wedges then under cold running water, remove its seeds.  If you prefer you can skip this stage.</li><li>8. Add the tomatoes and garlic to the paella pan.  Stir into the meat pieces.</li><li>9. Whilst this is cooking, cut your squid into small pieces and add to the paella.</li><li>10.  Add the chopped onions and 1.5L of water and simmer.</li><li>11. Next add the rice.  After 15 minutes, add the sliced chorizo and crevettes.  Stir often to ensure that the rice does not stick to the bottom of the pan.</li><li>12.  Finally add the petit pois, freshly cracked black pepper and the parsley.  When it is nearly done, add the mussels and cook for a few minutes.</li><li>This beastly feast will serve at least 10 people.  The paella is ready once all of the liquid has been absorbed.  Serve with white wine or ros.  This meal was delicious underneath a bright yellow sun.</li></ol>	spanish	45	10	f	f	t	f
347  Patti''s Paella  https://spoonacular.com/recipeImages/Pattis-Paella-655017.jpg  <ol><li>Mix together paprika, cumin, rosemary, thyme, salt, AND pepper AND sprinkle ON the chicken chunks.Marinate IN the refrigerator FOR AT least 1 HOUR.</li><li>Heat oil IN a LARGE Dutch oven OR deep pot ON a medium high heat.ADD chorizo, chicken AND the remaining spice mixture AND cook UNTIL browned.Drain excess oil.</li><li> ADD onion, red AND green pepper, garlic.Cook ON medium heat, stirring UNTIL softened.</li><li> ADD rice, saffron, tomato, AND bay leaf.Stir TO combine AND coat the rice.</li><li> ADD chicken stock AND white wine, AND bring TO a boil.Stir TO blend flavors.Cover.Cook ON low FOR approximately 20 minutes.</li><li> IN the remaining 10 minutes, ADD the peas, shrimp AND ALL other seafood.Bury the seafood deep INTO the rice AND stir.Cover.</li><li> WHEN the rice IS tender, let the dish sit FOR a MINUTE IN the pot BEFORE serving.Garnish ON a platter WITH lemon wedges.</li></ol>  spanish  45  6  f  f  t  t
348  Pumpkin Empanada  https://spoonacular.com/recipeImages/Pumpkin-Empanada-657302.jpg  <ol><li>Melt the butter IN a medium saucepan OVER medium heat.Stir IN the brown sugar UNTIL it dissolves WITH the butter.Stir IN the pumpkin AND the spices.CONTINUE TO stir OVER medium heat FOR about 10 minutes.Make sure the filling IS NOT too watery;
otherwise let it cook FOR a couple more minutes.</li><li>Remove the saucepan FROM the heat AND let it cool down.AFTER its cooled OFF FOR about 15 minutes, put the filling IN the refrigerator TO help it SET FOR 30 minutes OR overnight.</li><li>You can make the Empanada Dough WHILE the filling IS cooling OFF.</li><li>Mix the FIRST 3 dry ingredients.Cut IN the shortening WITH the dry ingredients.Works better IF you use your hands.ADD the eggs, milk AND sugar.CONTINUE TO WORK IN WITH your hands.Split the dough IN half, wrap IN plastic wrap AND put INTO the refrigerator FOR about 20-30 minutes.Take OUT one half OF the dough AND split it INTO 12-18 balls OF dough.Depending ON how small you want your empanadas.I prefer one dozen per half OF the dough.They ALSO fit nicely ON one LARGE cookie sheet.</li><li>Preheat the oven TO 350 degrees.You can fill your empanadas WITH ANY preserves made ahead OF TIME.</li><li>Roll OUT the dough INTO small round circles.ADD a small dollop OF filling ON one half OF the rolled OUT dough.Wet the bottom edge OF the dough WITH water TO help seal the two halves.Fold OVER the dough TO seal.Seal OFF the edges WITH a fork BY pressing down along the two edges.This ALSO makes FOR a pretty pattern WHEN baked.</li><li>Brush EACH empanada WITH egg whites, sprinkle WITH sugar AND puncture EACH empanada WITH a fork TO allow steam TO ESCAPE WHILE baking.Spray a LARGE cookie sheet WITH cooking spray, place the empanadas ON the cookie sheet AND bake FOR 15-20 minutes ON medium rack IN the oven.IF AFTER 15 minutes you NOTICE the bottoms OF the empanadas starting TO brown, MOVE the cookie sheet TO the top rack AND CONTINUE TO bake FOR the LAST 5 minutes.</li></ol>  spanish  45  2  f  f  f  f
349  Spanish Gazpacho Soup IN The Raw WITH Broiled Vegan Cheese TOAST https://spoonacular.com/recipeImages/Spanish-Gazpacho-Soup- IN -The-Raw- WITH -Broiled-Cheese- TOAST -660861.jpg  <ol><li>Spanish Gazpacho Soup</li><li>Place ALL ingredients IN a blender OR Vitamix AND blend well UNTIL smooth FOR about 3 minutes.</li><li>Refrigerate FOR 1 TO 2 hours BEFORE serving.</li><li>Garnish WITH organic crunchy onions AND chopped parsley ( OR dried).</li><li> PREPARE "cheese" toasts.</li><li>Broiled "Cheese" TOAST </li><li>Postition oven rack TO SECOND TO highest rack FROM the top.Turn oven TO broil.</li><li> ON baking sheet, lay OUT bread AND split "cheese" BETWEEN BOTH slices.</li><li>Sprinkle parsley AND salt AND place IN oven rack.</li><li>Broil UNTIL slightly browned AND cheese IS broiled.SLICE IN half once TOAST IS somewhat cool.</li></ol>  spanish  45  4  t  t  f  t
350  Spanish Meatballs IN Tomato Sauce  https://spoonacular.com/recipeImages/Spanish-Meatballs- IN -Tomato-Sauce-660868.jpg  <ol><li> START BY making the tomato sauce.</li><li>Finely chop 1 onion.</li><li>Peel 600g OF tomatoes WITH a serrated peeler.Chop the peeled tomatoes INTO small pieces.</li><li> ADD 2 tablespoons OF olive oil IN a sauce pan.ADD the chopped onions.</li><li> ADD a pinch OF Pimenton de la Vera (Dulce), which IS Spanish smoked sweet paprika.I used 1/4 teaspoon.ADD more IF you prefer the sauce TO be spicy.</li><li> ADD the chopped tomatoes TO the onions mixture AND stir well TO combine.</li><li> ADD 1 fresh bay leaf.I used 2 dried pieces here because I couldnt find fresh ones.</li><li> ADD 1 teaspoon OF sugar andd salt AND pepper TO taste.I added 1/2 teaspoon OF salt AND 1/4 teaspoon OF ground black pepper.Adjust seasoning TO taste.</li><li>Cover the sauce pan AND reduce the heat TO a medium-low AND let the tomato mixture simmer gently till it reduces TO a sauce LIKE consistency.</li><li></li><li> IN the meantime, make the meatballs BY adding 1/2 an onion TO a food processor.</li><li> ADD 2 cloves OF garlic.I used 1 tablespoon OF minced garlic.Process till the onions AND garlic are finely chopped.</li><li>Sweat the onion-garlic mixture IN a frying pan WITH SOME olive oil.I just realised that I had missed this step.The meatballs still tasted great.</li><li> ADD the onion-garlic mixture TO 500g ground beef IN a mixing bowl.</li><li> SLICE OFF the crust OF 4 slices OF white bread.Cut the soft white bread INTO small cubes OF 1cm ALL round.</li><li> ADD the chopped bread TO the beef mixture.</li><li> ADD 2 tablespoons OF chopped parsley.Use Italian flat parsley WHERE possible.I couldnt find ANY, so I used English parsley.</li><li> ADD 1 LARGE egg.</li><li> ADD salt AND pepper TO taste.I used approximately 1/4 teaspoon OF salt AND a pinch OF black pepper.</li><li>Mix well TO combine.</li><li>Shape the meat mixture INTO balls that are slightly bigger than the size OF a golf ball size.Roll the meat tightly TO form meatballs.</li><li> ADD 3/4 cup OF olive oil TO frying pan.The layer OF oil should be approximately 3/4cm IN the pan.</li><li>Put the pan ON medium-high heat AND ADD the meatballs TO the oil.Gently roll them around IN the oil TO brown ALL surfaces AND ensure even cooking.</li><li> WHEN the meatballs are a deep golden brown, remove them FROM the frying pan AND SET aside.</li><li>The tomatoes-onion mixture should have reduced TO a sauce consistency now.You can use a hand blender TO puree the mixture.OR leave the small bits OF tomatoes AND onions AS they are.</li><li> ADD the meatballs TO the tomato sauce AND let the meatballs warm through.</li><li>Garnish WITH more chopped parsley.</li></ol>  spanish  45  20  f  f  f  t
351  Spanish Ketchup - Romesco Sauce  https://spoonacular.com/recipeImages/Spanish-Ketchup--Romesco-Sauce-660883.jpg	<ol><li>Fire up your grill to roast the red bell peppers.  Lightly coat the red peppers with olive oil & place on a pre-heated grill over high heat.  Turn the peppers occasionally to char the skin black  10 to 15 minutes.</li><li>Remove the peppers from the grill & place in a bowl.  Cover with plastic wrap  10 minutes.  Peel & discard the skin, seeds & veins;  Rough chop the peppers & place in a food processor.  Add all the other ingredients & pulse until blended.  Slowly add the olive oil & blend until smooth.  Season with salt & pepper.</li><li>You can serve the romesco sauce at room temperature or chilled.  If needed, gently warm the sauce over low heat.  Over heating the sauce will could cause it to separate.  If so, pour separated sauce in a blender & process for 1 minute.</li></ol>	spanish	45	8	t	t	t	t
352  Sun-Dried Tomato Romesco  https://spoonacular.com/recipeImages/Sun-Dried-Tomato-Romesco-662294.jpg  <ol><li>Combine hazelnuts, almonds, Parmesan, AND garlic IN a food processor.Pulse UNTIL finely ground.</li><li> ADD roasted red peppers, sun-dried tomatoes, vinegar, salt, AND red pepper.</li><li>Process UNTIL smooth, OR desired consistency.</li></ol>  spanish  45  1  f  f  t  f
353  Asparagus Thai Style WITH Squids  https://spoonacular.com/recipeImages/Asparagus-Thai-Style- WITH -Squids-632955.jpg  <ol><li>Heat 2 tbsp oil AND saut chopped garlic UNTIL fragrant.</li><li> ADD IN asparagus, stir fry a WHILE THEN ADD IN carrot AND stir well.</li><li> ADD IN fish sauce, sugar AND a little water IF it becomes too dry.</li><li>Now ADD IN squid, stir-fry FOR about 1-2 minutes, OR UNTIL squid curls up.Don''t overcook squid, AS it will become rubbery.</li><li>Test FOR taste, adding more fish sauce IF NOT salty enough.But IF too salty FOR your taste, ADD a little more sugar.Dish up AND serve immediately.</li></ol>  thai  45  2  f  f  t  t
354  Thai Style Chicken Satay  https://spoonacular.com/recipeImages/Chelleys-Thai-Style-Chicken-Satay-637697.jpg  <ol><li> FOR satay:Marinate chicken WITH marinade FOR AT least 2 hours OR preferably overnight IN the fridge.</li><li>Make sure TO soak bamboo sticks IN water FOR 30 minutes BEFORE skewering the meat.</li><li>Cook satays ON greased grill griddle AND brush ON oil AND leftover marinade AS needed.Cook about 3 minutes ON EACH side.</li><li>Serve satays WITH peanut sauce, cucumber AND onions.</li><li> FOR Peanut Sauce:Bring coconut milk TO a boil AND ADD the rest OF the ingredients AND adjust TO taste accordingly.</li></ol>  thai  140  30  f  f  t  t
355  Drunken Noodles (Pad Kee Mao)  https://spoonacular.com/recipeImages/Drunken-Noodles-(Pad-Kee-Mao)-641671.png  <ol><li>Separate the noodles BY peeling them apart one AT a TIME.IF ALSO USING Yam-cake noodles, rinse well.SET aside.</li><li> PREPARE your ingredients:SLICE the vegetables.Crush the garlic AND chilies, AND SET aside.Pick OFF the leaves & flowers OF the basil, AND SET aside.Chop the LARGE chili INTO rings.</li><li>Combine the oyster sauce, Braggs, fish sauce, AND Stevia IN a small bowl AND SET aside.</li><li> IF USING tofu, pre-fry IN a dry, non-stick skillet UNTIL browned.SET aside.</li><li> ADD the oil TO a Wok (this pan IS PREFERRED but NOT a necessity), AND heat ON medium UNTIL its dancing around.(Heating oil ON too high OF heat will cause it TO turn INTO Trans-fat which IS NOT a good thing.) THEN ADD the garlic, chilies AND green peppercorns.Keep stirring so it doesnt burn.</li><li> WHEN the garlic turns light brown, ADD the veggies & meat/seafood IF adding.Keep stirring AND cook UNTIL finished, about 3-5 minutes depending ON the ingredients used.</li><li> ADD the tofu ( IF adding), THEN the noodles.You may need TO ADD a BIT more water IF the pan gets too dry.Dont ADD a lot, OR the noodles will GET mushy.</li><li> AFTER frying FOR a MINUTE OR two, ADD the sauce mixture.Stir well TO combine.</li><li> ADD the basil & vinegar.Stir TO mix.WHEN the basil IS wilted its done.</li></ol>  thai  45  2  t  t  t  t
356  Green Mango Salad - Thai Side Dish  https://spoonacular.com/recipeImages/Green-Mango-Salad-645474.jpg  <ol><li>Julianne the green mango AND diced the tomato </li><li>Mix AND place IN the bowl </li><li>Roughly pound chili AND garlic AND ADD the fish sauce </li><li>Season WITH sugar TO balance the taste </li><li> ADD lime juice FOR the final touch </li><li>Pour the dressing IN bowl OF mix green mango AND tomato, fold gently </li><li>Place ON the bed OF your favourite lettuce AND serve</li></ol>  thai  15  2  f  f  t  t
357  Sweet AND Spicy Thai Relish  https://spoonacular.com/recipeImages/Sweet---Spicy-Thai-Relish-662427.jpg	<ol><li>Heat a large cast iron skillet over medium heat. Once hot, dry-fry (meaning, dont add any fat or oil to the pan) the whole chilies for one minute, then set aside in a small bowl. They should be fragrant and slightly darker in color, but not burnt. In the same pan, dry-fry the chopped onion, bell pepper, and garlic for 2 minutes until brown but not burnt, then set aside on a large plate.</li><li>Toss in the tomatoes and dry-fry for 1-2 minutes until charred on the outside, stirring frequently. Set on the plate with the onions, pepper, and garlic. Turn the stove off, then use your hands to break apart the chilies into smaller pieces. Dont try to use a knife, because they will fly all over the kitchen. Place the chilies in the bowl of a blender or large food processor, then wash your hands thoroughly with soap and warm water to remove any oils left from the chilies.</li><li>Add the third cup fish sauce, quarter cup lime juice, and sugar to the blender, along with the reserved onion, bell pepper, garlic, and tomatoes. Pulse on chop mode or equivalent until the mixture forms a chunky sauce. Serve either warm or chilled.</li></ol>	thai	45	3	f	f	t	t
358  Thai Chicken Wraps  https://spoonacular.com/recipeImages/Thai-Chicken-Wraps-663078.jpg  <ol><li>Toss chicken strips WITH shoyu AND oil UNTIL well coated.Heat IN saute pan OVER medium-low heat UNTIL heated through.</li><li> IN medium bowl, ADD sesame seeds, sprouts, slaw mix, basil, sugar, vinegar AND salt & pepper.Toss UNTIL thoroughly coated.SET aside.</li><li> TO make the SAUCE:IN small bowl, whisk Earth Balance NATURAL peanut butter WITH shoyu AND vinegar.ADD IN oil WHILE whisking UNTIL consistency IS slightly runny.</li><li>Chop OFF the rough END OF romaine leaves;
smooth OUT flat AND pile ON the chicken, slaw mixture AND drizzle WITH peanut sauce.</li><li>Top WITH crushed peanuts (optional) AND carefully wrap AND roll, starting FROM one END.Leave seam side down.</li></ol>  thai  45  6  f  f  t  t
359  Thai Coconut Curry Lentil Soup  https://spoonacular.com/recipeImages/Thai-Coconut-Curry-Lentil-Soup-663090.jpg  <ol><li>Heat olive oil IN a medium saucepan.ADD the onions, ginger AND garlic.Cook OVER medium heat UNTIL softened, about 3-4 minutes.Stir IN Thai red curry paste, AND cook several minutes OR UNTIL fragrant.ADD water, lentils, sweet potatoes AND turmeric.Bring TO a boil, THEN reduce heat TO medium-low, cover AND cook about 20-25 minutes OR UNTIL lentils AND sweet potatoes are soft.ADD salt AND stir IN coconut milk.Cook five more minutes.Garnish WITH fresh cilantro.</li></ol>  thai  45  5  t  t  t  t
360  Thai Fried Rice  https://spoonacular.com/recipeImages/Thai-Fried-Rice-663104.jpg  <ol><li>Saute garlic IN oil.ADD sliced pork;
cook UNTIL brown.ADD onion, tomato, AND green pepper;
fry slightly.Cook rice IN water;
ADD TO fried mixture.ADD eggs AND fry.CONTINUE stirring UNTIL eggs are cooked.ADD soy sauce, salt, sugar, AND pepper.Yields 6-8 servings.</li></ol>  thai  45  1  f  f  t  t
361  Thai Fish Cakes  https://spoonacular.com/recipeImages/Thai-Fish-Cakes-663108.jpg  <ol><li>Step 1:ADD fish fillets, egg, fish sauce, corn flour, red curry paste, red chilies AND coriander leaves IN blender.Blend it UNTIL combined AND turns IN TO the thick paste.Transfer the paste IN TO a bowl</li><li>Step 2:Now ADD spring onion AND green beans IN TO the paste.Mix well.Form the paste IN TO round patties USING wet palms.Keep them aside</li><li> CONTINUE Reading Thai Fish Cakes Recipes:http://recipes.sandhira.com/thai-fish-cakes.html</li></ol>  thai  45  2  f  f  t  t
362  Thai Green Mango Salad  https://spoonacular.com/recipeImages/Thai-Green-Mango-Salad-663113.jpg  <ol><li>Pound ALL the ingredients IN a clay mortar USING a wooden pestle, THEN ADD carrot AND mangoes.Serve chilled WITH roasted coarse peanuts.</li></ol>  thai  45  6  f  f  t  t
363  Thai Massaman Curry  https://spoonacular.com/recipeImages/Thai-Massaman-Curry-663121.jpg  <ol><li> IN the heated oil, fry curry paste till aromatic AND oil splits.</li><li> ADD bay leaves AND lamb.</li><li>Pour 1/2 liter OF water (more IF you LIKE )</li><li>Stir AND simmer till lamb IS half cooked.</li><li> ADD potatoes AND season WITH salt.</li><li> CONTINUE TO simmer till potatoes AND lamb are tender AND soft.</li><li>Pour IN fish sauce, lime juice AND coconut milk.</li><li>Gently stir AND remove FROM heat.</li></ol>  thai  45  5  f  f  t  t
364  Thai Pasta Salad  https://spoonacular.com/recipeImages/Thai-Pasta-Salad-663126.jpg  <ol><li>Cook pasta according TO package instructions.During the LAST MINUTE, ADD IN the broccoli.</li><li> IN the meantime, you can cook the vegetables AND PREPARE the dressing.</li><li>Heat olive oil IN small non-stick skillet, saut onions UNTIL slightly soften.ADD IN garlic AND CONTINUE TO saut UNTIL fragrant.ADD IN sweet peppers AND cook UNTIL slightly softened.Remove FROM heat, ADD IN remaining ingredients TO finish making the sauce.ADD salt AND pepper TO taste.</li><li> WHEN the pasta AND broccoli IS ready, ADD them TO the skillet AND stir well.Stir IN cilantro leaves.</li><li>Served AT room temperature OR chilled.</li></ol>  thai  45  2  f  f  f  t
365  Thai Red Curry  https://spoonacular.com/recipeImages/Thai-Red-Curry-663144.jpg  <ol><li>Pour coconut milk INTO saucepan.OVER high heat, whisk IN curry paste.IF you prefer spicy cuisine, THEN ADD more red curry paste than suggested.</li><li> ADD fish sauce AND brown sugar.ADD basil, bamboo shoots, pineapple, onion, bell pepper, AND snow peas.Bring TO a boil stirring frequently.</li><li>Reduce heat AND cook 3 minutes UNTIL thickened.</li><li>Optional:IF adding meat, boneless/skinless chicken, beef, OR shrimp IS recommended.Cut one pound OF meat INTO bite sized pieces.ADD raw meat TO finished curry sauce AND allow TO cook OVER medium heat an additional 10 minutes OR UNTIL done.</li></ol>  thai  45  6  f  f  t  t
366  Thai Sausage Salad  https://spoonacular.com/recipeImages/Thai-Sausage-Salad-663149.jpg  <ol><li> IN a small bowl, combine the dressing ingredients AND stir UNTIL the sugar has dissolved.Taste AND adjust WITH more sugar OR fish sauce IF needed ( SOME limes are more tart than OTHERS ).SET aside.</li><li> SLICE the sausage thinly ON the diagonal.Place IN a non stick skillet OVER medium heat AND saut UNTIL the edges are slightly browned AND sausage IS cooked thru, about 5 minutes.Dont OVER cook.SET aside TO cool</li><li>Peel the cucumbers, SLICE thinly AND place IN a LARGE bowl.Thinly SLICE the green onions ON the diagonal AND ADD TO the bowl.ADD the bean sprouts, cooked sausage AND the dressing.Lightly toss AND serve ON plates WITH jasmine rice ON the same plate.Garnish WITH a few slivers OF sliced hot chili pepper, IF desired, AND a few leaves OF fresh parsley OR cilantro.</li><li>Serves 2 AS a MAIN course salad.</li></ol>  thai  45  2  f  f  t  t
367  Thai Savory Brown Fried Rice  https://spoonacular.com/recipeImages/Thai-Savory-Brown-Fried-Rice-663150.jpg  <ol><li>Make my Perfect Brown Rice recipe below.WHILE brown rice IS cooking PREPARE rest OF meal.PERFECT BROWN RICE1 cup uncooked brown rice1 tsp.olive oil2 cups filtered water2 basil leaves (optional)Fix brown rice BY cooking IN 1 tsp.olive oil UNTIL lightly browned.Place 2 basil leaves ON top OF rice AND ADD 2 cups water ALL AT once.Quickly put ON lid AND bring TO boil.Turn down heat TO simmer UNTIL ALL water has evaporated (around 40 minutes).</li><li>Heat oil IN a wok OR LARGE frying pan.ADD the garlic AND cook ON medium UNTIL lightly golden.Watch carefully so you DO NOT burn garlic.</li><li> ADD the red chili peppers, cashew nuts AND toasted coconut.Mix together stevia, Nama Shoyu AND apple cider vinegar together.Cook OVER medium heat FOR 1 minutes.</li><li>Push stir-fry TO one side OF pan AND ADD flax ON opposite END.Cook AND stir the flax egg FOR about a MINUTE AND THEN incorporate INTO stir-fry mixture.</li><li> ADD the green beans, bok choy AND brown rice TO stir-fry.Cook AND stir ON medium FOR another MINUTE.Bok Choy will be wilted, but green beans will still be a BIT crunchy.</li><li>Spoon INTO serving dish AND ADD lime wedge ON side FOR squeezing OVER rice.</li></ol>  thai  45  4  t  f  t  t
368  Thai Shrimp  https://spoonacular.com/recipeImages/Thai-Shrimp-663151.jpg  <ol><li>Peel AND devein shrimp.Wash, dry AND steam basil, mince garlic, thinly SLICE seeded chilies, mince white part OF onion AND cut green part INTO 1 inch pieces.Recipe can be PREPARED ahead TO this stage.</li><li>Heat wok OVER high heat.Swirl oil INTO wok AND heat almost TO smoking.ADD garlic, chilies, onions (white part), AND cook 10-15 seconds;
ADD shrimp AND stir fry 20 seconds OR UNTIL they change color.ADD fish sauce, soy sauce, sugar, chicken, stock AND green part OF onions AND bring mixture TO a boil.Stir IN basil AND cook 20 seconds OR UNTIL leaves wilt AND shrimp are firm AND pink.Dish IS supposed TO be soupy.Serve OVER hot cooked rice.</li></ol>  thai  45  4  f  f  t  t
369  Thai Stir-Fry Chicken WITH Cashew Nuts  https://spoonacular.com/recipeImages/Thai-Stir-Fry-Chicken- WITH -Cashew-Nuts-663156.jpg  <ol><li> ON medium flame, fry the garlic UNTIL fragrant AND NOT brown.</li><li> ADD IN the chicken AND cook UNTIL nearly done.THEN, ADD IN Thai chili paste AND stir well.ADD a BIT less than recommended IF you cant take spiciness.</li><li> ADD IN the onion, cashew nuts, dry chilies AND spring onion.Give it a good mix AND cook FOR about 2 minutes.</li><li> THEN, season WITH soya sauce.ADD IN dark soya sauce TO sweeten the dish AND give it a little BIT OF colour.Serve warm.</li></ol>  thai  45  3  f  f  t  t
370  Thai Street Vendor Salmon Skewers  https://spoonacular.com/recipeImages/Thai-Street-Vendor-Salmon-Skewers-663157.jpg  <ol><li>Remove skin FROM salmon fillet AND TRIM away ANY brown fatty areas.</li><li>Place 8 bamboo skewers INTO the fillet running FROM the thick side TO the thin about 1.5 inches apart.THEN SLICE the fillet so that you have individual pieces OF salmon ON the skewers.</li><li>Make a sauce combining the remaining ingredients, INCLUDING the juice FROM the lime AND the zest.It''s ALSO easiest TO mince the ginger BY putting it through a garlic press.You can adjust the mix OF ingredients TO MATCH your personal tastes.</li><li>Place the salmon IN a deep bowl OR ziploc bag AND marinate IN about half OF the sauce, reserving the rest FOR serving.Refrigerate FOR 30 minutes TO an HOUR, more will break down the fish AND cause it TO "cook" a BIT IN the lime juice.</li><li>Grill skewers ON a high heat AND serve.Eat WITH chilled raw Yu Choy, which you use TO wrap bits OF the fish AND drizzle WITH remaining sauce.</li></ol>  thai  45  4  f  f  t  t
371  Thai Tofu WITH Bok Choy  https://spoonacular.com/recipeImages/Thai-Tofu- WITH -Bok-Choy-663166.jpg  <ol><li>Cut the tofu INTO 1" cubes. Whisk together sauce ingredients (soy sauce, oyster sauce, fish sauce, brown sugar, and chili paste). Set aside.</li><li>Heat 2 tsp sesame oil over medium-high heat in a large wok or pan. When the pan is hot, add the tofu and let cook for 2 minutes on one side, undisturbed, until they develop a crisp crust. Flip and cook 2 minutes more.</li><li>Remove the tofu to a plate. Return pan to the heat.</li><li>Add remaining 1 tsp sesame oil to the pan along with the carrots. Saute for 3 minutes, until the carrots begin to soften.</li><li>Add the bok choy and saute for 2 minutes, until it begins to soften and wilt.</li><li>Stir in the sauce.</li><li>Return the tofu to the pan and stir in the corn starch mixture. Allow the sauce to come to a boil for it to thicken. Stir.</li><li>Serve with rice.</li></ol>	thai	45	4	f	f	t	t
372  Thai Veggie Slaw WITH Peanut Dressing AND Crispy Wontons  https://spoonacular.com/recipeImages/Thai-Veggie-Slaw- WITH -Peanut-Dressing- AND -Crispy-Wontons-663169.jpg  <ol><li>1. Make the crispy wontons:Preheat oven TO 375 degrees f.Lay the wontons OUT ON a LARGE baking sheet.Spray lightly WITH cooking spray AND sprinkle WITH the Chinese five spice AND cayenne.Flip the wontons OVER AND repeat.Stack ALL the wonton skins ON top OF EACH other AND SLICE INTO 1/2-3/4-inch strips.Spread the strips IN an even layer back onto the baking sheet.Bake 10-12 minutes, UNTIL crisp AND golden brown, flipping the strips halfway through AND rotating the baking sheet.(Watch carefully that they don''t burn) Remove FROM the oven AND let cool BEFORE USING.</li><li>2. PREPARE the dressing:IN the jar OF a blender, ADD 1/2 C.peanuts AND 2 T.canola oil.Blend UNTIL completely smooth, about a MINUTE, scraping down the sides OF the blender jar AS necessary.ADD IN the remaining canola oil, lime juice, fish sauce, brown sugar, sriracha, ginger AND garlic.Blend UNTIL smooth.</li><li>3. IN a LARGE bowl combine ALL the vegetables.ADD the dressing AND the remaining 1/2 C.peanuts.Toss well TO combine.You can either mix the wontons INTO the salad, OR reserve them FOR crumbling onto individual portions.</li></ol>  thai  45  6  f  f  t  t
373  Vegetarian Thai Red Curry  https://spoonacular.com/recipeImages/Vegetarian-Thai-Red-Curry-664716.jpg  <ol><li>Whizz the paste ingredients IN a food processor.Marinate the tofu IN 2 tbsp soy sauce, juice 1 lime AND the chopped chili.</li><li>Heat half the oil IN a LARGE pan.ADD 3-4 tbsp paste AND fry FOR 2 mins.Stir IN the coconut milk WITH 100ml water, the courgette, aubergine AND pepper AND cook FOR 10 mins UNTIL almost tender.</li><li>Drain the tofu, pat dry, THEN fry IN the remaining oil IN a small pan UNTIL golden.</li><li> ADD the mushrooms, sugar snaps AND most OF the basil TO the curry, THEN season WITH the sugar, remaining lime juice AND soy sauce.Cook FOR 4 mins UNTIL the mushrooms are tender, THEN ADD the tofu AND heat through.Scatter WITH sliced chili AND basil AND serve WITH jasmine rice.</li></ol>  thai  45  4  t  t  t  t
374  Easy TO Make Spring Rolls  https://spoonacular.com/recipeImages/Easy- TO -Make-Spring-Rolls-642129.jpg  <ol><li>Have ALL the ingredients ready FOR assembly.IN a LARGE bowl filled WITH water, dip a WRAPPER IN the water.The rice WRAPPER will BEGIN TO soften AND this IS your cue TO remove it FROM the water AND lay it flat.Place 2 shrimp halves IN a ROW across the center AND top WITH basil, mint, cilantro AND lettuce.Leave about 1 TO 2 inches uncovered ON EACH side.Fold uncovered sides inward, THEN tightly roll the WRAPPER, beginning AT the END WITH the lettuce.Repeat WITH remaining wrappers AND ingredients.Cut AND serve AT room temperature WITH dipping sauce.</li><li>The Culinary Chases Note:The rice WRAPPER can be fussy TO handle IF you let it soak too long.I usually give it a couple OF swishes IN the water AND THEN remove.It may feel slightly stiff but BY the TIME you are ready TO roll up, the WRAPPER will become very pliable.A typical spring roll contains cooked rice vermicelli, slivers OF cooked pork AND julienned carrots but you can use whatever suits your fancy.Enjoy!</li></ol>  vietnamese  45  4  f  f  t  t
375  Gluten Free Vegetarian Spring Rolls WITH Thai-Style Peanut Sauce  https://spoonacular.com/recipeImages/Gluten-Free-Vegetarian-Spring-Rolls- WITH -Thai-Style-Peanut-Sauce-644859.jpg  <ol><li>Bring a LARGE pot OF water TO boil OVER high heat.Remove FROM heat AND stir IN the rice noodles.Let stand 10 minutes, stirring occasionally, OR UNTIL soft AND OPAQUE.Drain AND rinse under cold water FOR 30 seconds;
drain again.Cut INTO 1-inch lengths AND transfer TO a LARGE bowl.</li><li> ADD ALL OF the remaining ingredients, EXCEPT the rice papers AND sauce, TO the noodles AND mix well.</li><li> PREPARE a bowl OF warm water LARGE enough TO dip the rice papers.Working WITH one AT a TIME, dip the rice paper IN the warm water UNTIL it begins TO soften, 8-10 seconds.Transfer TO a flat WORK surface.Working quickly, put about 1/4 cup filling ON EACH WRAPPER.Fold the bottom OF the WRAPPER up OVER the filling, AND THEN fold EACH side toward the center.Roll FROM the bottom TO the top OF EACH roll, AS tightly AS you can WITHOUT ripping the WRAPPER.Wrap IN plastic TO keep FROM drying OUT.Repeat WITH remaining wrappers AND filling.Serve AT room temperature, WITH Peanut Dipping sauce.Alternatively, refrigerate FOR a minimum OF 2 hours, OR overnight, AND serve 4 TO PREPARE Peanut Dipping Sauce:</li><li> TO PREPARE Peanut Dipping Sauce:</li><li> IN a small bowl, combine the warm water AND sugar, stirring UNTIL the sugar IS dissolved.ADD the remaining ingredients, whisking UNTIL smooth AND well blended.Serve AT room temperature.</li></ol>  vietnamese  45  15  t  f  f  t
376  Grilled Chicken Banh Mi  https://spoonacular.com/recipeImages/Grilled-Chicken-Banh-Mi-645634.jpg  <ol><li>Mix the FIRST six ingredients IN a baking dish.ADD the chicken breasts TO the dish, cover, AND refrigerate AT least 1 HOUR.</li><li>Stir the hot tap water AND sugar IN a medium bowl, UNTIL the sugar dissolves.ADD the vinegar, salt, red pepper, sliced carrots AND radishes.Cover AND refrigerate FOR AT least 30 minutes.</li><li>Heat the grill TO medium.Grill the chicken breasts FOR 5 minutes per side.Remove FROM heat AND cover them WITH foil TO rest FOR 5 minutes.</li><li> OPEN the sub rolls AND grill the insides FOR about 1-3 MINUTE UNTIL toasted.</li><li>Drain the pickled veggies.SLICE the chicken INTO thin pieces.</li><li>Spread mayo OVER IN the sub rolls.Layer the cucumbers, chicken, pickled veggies, cilantro leaves AND jalapenos IN the rolls.</li><li>Serve immediately! </li></ol>  vietnamese  110  6  f  f  f  t
377  Phyllo Dough Baked Spring Rolls  https://spoonacular.com/recipeImages/Phyllo-Dough-Baked-Spring-Rolls-655903.jpg  <ol><li>Place 2 Tbsp.oil IN a wok OR LARGE frying pan OVER medium TO high heat.</li><li> ADD garlic, galangal ( OR ginger), shallots, AND chili.Stir-fry UNTIL fragrant (about 1 MINUTE ).Stir-frying Tip:ADD a little water TO the wok/pan WHEN it gets too dry INSTEAD OF more oil.</li><li> ADD cabbage, mushrooms, AND tofu AND shrimp. AS you stir-fry, ADD the sauce.</li><li>Stir-fry 1-2 minutes, ADD the rest OF the vegetables, EXCEPT FOR the bean sprouts, coriander AND basil.</li><li>Stir-fry UNTIL vegetables have softened.</li><li>Remove FROM heat AND ADD bean sprouts, tossing TO mix IN.</li><li> DO a taste test FOR salt, adding 1 Tbsp.more fish OR soy sauce IF NOT salty enough.</li><li>ASSEMBLING THE ROLLS</li><li>Paint half OF 1 sheet OF phyllo dough WITH melted butter, margarine, OR olive oil.</li><li> USING the butter AS glue, fold the sheet IN half TO form a rectangle.</li><li>Pile about 1/3 cup OF filling AT the bottom OF a narrow side, leaving a 2-inch border ON 3 sides.</li><li> TO form the LOG, fold the bottom flap up AND OVER the filling, fold IN the sides AND roll up TO seal.</li><li>Paint the roll WITH melted butter AND place, seam side down, onto a baking sheet.</li><li>Repeat WITH the remaining sheets OF phyllo dough.</li><li>Tips:Spread the filling lengthwise along the phyllo dough nearer the END closest TO you.ALSO, try NOT TO include too much OF the liquid LEFT IN the bottom OF your wok/pan (a slotted spoon works well FOR this  drier filling IS better.Now sprinkle SOME OF the fresh coriander AND basil OVER the filling.</li><li>BAKING THE ROLLS</li><li>Preheat the oven TO 400.</li><li>Bake IN the center OF the oven FOR 15 TO 20 minutes, UNTIL lightly golden ALL OVER.</li></ol>  vietnamese  45  20  f  f  f  t
378  Vegetarian Spring Rolls WITH Garlic Lime Sauce  https://spoonacular.com/recipeImages/Vegetarian-Spring-Rolls- WITH -Garlic-Lime-Sauce-664708.jpg  <ol><li>Julienne red AND yellow bell pepper, carrots, jicama AND Thai basil INTO 1/8 IN thin AND 2 inch long strips.</li><li>Fill a round pie pan OR shallow plate WITH warm water.Dip one rice paper, making sure BOTH sides are soaked.Lay ON a flat flour towel cloth.Wait ten seconds FOR the paper TO soft BEFORE USING.</li><li>Peel rice paper OFF OF cloth.</li><li>Place half OF one butter leaf lettuce ON top.Make sure TO DISCARD the ribbing.</li><li> ADD a thin layer OF EACH vegetable AND finish WITH a few pieces OF Thai Basil.</li><li>Starting AT one END, fold the edge towards the middle.Repeat WITH parallel side.Rotate the spring roll BY 90 degrees AND roll form one END TO the NEXT.</li><li>Cut EACH roll diagonally AND place facing up ON a serving platter.</li><li>Garlic Lime Hoisin Sauce:USING a mortar AND pestle crush garlic AND ginger.Whisk IN lime AND Sriracha.ADD hoisin sauce AND whisk TO combine.</li></ol>  vietnamese  45  10  t  f  t  t
379  Vietnamese Banh Mi  https://spoonacular.com/recipeImages/Vietnamese-Banh-Mi-664828.jpg  <ol><li>Mix ALL marinade ingredients ( EXCEPT FOR pork) IN a plastic bag.Let ALL ingredients dissolve IN oil, THEN ADD slices OF pork.</li><li>Allow pork TO marinade FOR AT least 1 HOUR.</li><li>Heat pan ON medium heat, lay slices OF pork, one layer AT a TIME.WHEN one side IS cooked, flip TO other side TO finish cooking.</li><li>Let the meat rest FOR 10 minutes AND THEN SLICE INTO strips</li><li>Assemble pork IN your sandwich</li></ol>  vietnamese  45  6  f  f  f  t
380  Vietnamese Beef-Noodle Soup WITH Asian Greens  https://spoonacular.com/recipeImages/Vietnamese-Beef-Noodle-Soup- WITH -Asian-Greens--Okay-Vietnamese-japanese-664830.jpg	<ol><li>Freeze beef for 10 minutes; cut across grain into 1/8-inch-thick slices.</li><li>Cook noodles according to package directions.</li><li>Drain and rinse with cold water; drain.</li><li>Place onion and next 5 ingredients (through star anise) in a large saucepan; cook over medium-high heat 5 minutes, stirring frequently.</li><li>Add broth and 2 cups water (dashi); bring to a boil.</li><li>Strain broth mixture though a fine sieve over a bowl; discard solids. Return broth to pan.</li><li>Add soy sauce, sugar, fish sauce, and sesame oil; bring to a boil.</li><li>Add bok choy and snow peas; simmer 4 minutes or until peas are crisp-tender and bok choy wilts.</li><li>Add miso at the last minute.</li><li>Arrange 1/2 cup noodles into each of 4 large bowls.</li><li>Divide raw beef and chile slices sambal oelek evenly among bowls.</li><li>Ladle about 1 2/3 cups hot soup over each serving (broth will cook beef). Top each serving with 1/4 cup bean sprouts, 1 tablespoon basil, and 1 tablespoon mint.</li><li>Serve with lime wedges.</li><li>Makes 4 servings.</li></ol>	vietnamese	45	4	f	f	f	t
381  Vietnamese Pho  https://spoonacular.com/recipeImages/Vietnamese-Pho-664836.jpg  <ol><li>Soak bone overnight IN cold water.Place bones, oxtails AND flank steak IN a LARGE stock pot.ADD water TO cover AND bring TO a boil.Cook 10 minutes, drain AND rinse pot AND bones.RETURN bones TO pot, ADD 6 quarts water AND bring TO a boil.Skim surface OF scum AND fat.Stir bones AT bottom FROM TIME TO TIME.ADD 3 more quarts water, bring TO a boil again AND skim scum.Lower heat AND let simmer.CHAR clove-studded onions, shallots, AND ginger under a broiler UNTIL they RELEASE their fragrant odors.Tie charred vegetables, star anise, AND cinnamon stick IN a thick, dampened cheesecloth.Put it IN stock WITH daikon.Simmer FOR 1 HOUR.Remove flank steak AND CONTINUE simmering broth, uncovered pot, FOR 4-5 hours.ADD more water IF LEVEL goes below bones.</li><li>Meanwhile, SLICE beef sirloin against grain INTO paper-thin slices, about 2- BY -2 inches.SLICE flank steak the same way.SET aside.IN a small bowl, combine scallions, cilantro, AND half the sliced onions.Place remaining onions IN another bowl AND mix IN hot chili sauce.Soak rice noodles IN warm water FOR 30 minutes.Drain AND SET aside.</li><li> WHEN broth IS ready, DISCARD bones.Strain broth through a colander lined WITH a DOUBLE layer OF damp cheesecloth INTO a clean pot.ADD fish sauce AND bring TO a boil.Reduce heat TO simmer.IN another pot, bring 4 quarts OF water TO a boil.ADD noodles AND drain immediately.DO NOT overcook noodles.Divide among 4 LARGE soup bowls.Top noodles WITH sliced meats.</li><li>Bring broth TO a rolling boil, THEN ladle INTO soup bowls.Garnish WITH scallions mixture AND black pepper.Serve the onions IN hot chili sauce AND remaining ingredients ON the side TO ADD AS desired.ALSO, you can ADD Hoisin sauce AS a dip.</li></ol>  vietnamese  45  42  f  f  f  t
382  Vietnamese Spring Rolls WITH Hoisin Peanut Dipping Sauce  https://spoonacular.com/recipeImages/Vietnamese-Spring-Rolls- WITH -Hoisin-Peanut-Dipping-Sauce-664845.jpg  <ol><li>Bring a saucepan TO a boil ON medium heat.ADD shrimp AND poach FOR 3-4 minutes UNTIL bright pink.Allow TO cool TO room temperature.Remove skins, devein AND SLICE IN half crosswise.SET aside.Bring a medium saucepan filled halfway WITH water TO a boil.Once a rapid boil IS reached, ADD rice vermicelli noodles, cover AND immediately remove FROM heat.SET timer FOR 5 minutes.AFTER 5 minutes, drain noodles IN a colander AND rinse WITH cold water TO stop cooking.Allow TO dry AT room temperature OR IN the refrigerator.</li><li>Meanwhile, BEGIN TO PREPARE the dipping sauce.Heat a small small saucepan WITH olive oil ON medium-low heat.ADD garlic AND saute quickly, about 20 seconds.DO NOT let garlic burn.ADD peanut butter AND hoisin sauce AND CONTINUE TO stir.WHEN sauce begins TO incorporate AND thickens up, ADD water.Adjust TO taste AND CONTINUE TO ADD water, 1 tbsp.AT a TIME, IF it becomes too thick.Remove FROM heat AND SET aside.</li><li> TO assemble rolls, dip single sheets OF rice paper INTO hot water.Allow excess water TO drain AND quickly place ON a plate.Once rice paper becomes pliable AND soft, ADD shrimp, softened noodles, cucumbers, red peppers, cilantro AND mint.Carefully roll closed AND SLICE IN half.Serve WITH hoisin peanut dipping sauce.</li></ol>  vietnamese  45  1  f  f  f  t
383  Vietnamese Spring Rolls  https://spoonacular.com/recipeImages/Vietnamese-Spring-Rolls-664847.jpg  <ol><li>Soak the rice vermicelli IN warm water UNTIL they turn soft, THEN drain them.</li><li>Fill a bowl WITH warm water.Dip one WRAPPER AT a TIME INTO the water FOR about 1-2 SECOND TO soften.</li><li>Lay the WRAPPER ON a dry chopping board OR dinner plate.The rice paper should become pliable WITHIN seconds.</li><li> IN a ROW across the centre, put 3 prawns, SOME vermicelli, carrots, bean sprouts, AND a few leaves OF basil.Leaving about 4-5cm ON EACH side.</li><li>Fold the sides inward, THEN START TO roll tightly AND firmly FROM the END that IS near TO you INTO a cylinder, enclosing the filling completely.</li><li>Repeat WITH the remaining ingredients.</li><li> FOR the dipping sauce, mix ALL the ingredients AND stir well UNTIL the sugar dissolves.THEN, put IN chopped coriander.</li><li>Serve spring rolls WITH dipping sauce.</li></ol>  vietnamese  45  4  f  f  f  t
384  Wholemeal Steam Bun  https://spoonacular.com/recipeImages/Wholemeal-Steam-Bun-665306.jpg  <ol><li>METHOD:</li><li>1.Mix ALL the ingredients A together AND knead INTO smooth AND elastic dough.</li><li>2.Cover WITH a piece OF wet cloth AND leave TO prove UNTIL DOUBLE its size.</li><li>3.Sift B top OF the dough AND knead well TO distribute the baking powder UNTIL the dough IS smooth again.</li><li>4.Cover AND allow dough TO rest FOR 15 minutes BEFORE shaping.</li><li>Meat Fillings :</li><li>boiled eggs (shelled AND cut INTO )</li><li>Marinade FOR meat :30 minutes</li><li>Shredded chicken/pork</li><li>2 tbsp.BBQ sauce</li><li>water</li><li>Filling:</li><li>1.Heat oil IN a pan adds IN marinated meat AND stirs fry till aromatic, adds IN SOME water AND cooks FOR 5 minutes UNTIL soft.Taste AND dish up AND leave TO cool AND chill IN the fridge FOR 3 hours.</li><li>2.Divide dough 12 portions AND shape balls.</li><li>3.Flatten, roll INTO a round shape AND ADD 1 tbsp OF filling AND pleat the top INTO a Pau/Bun.</li><li>4. LINE Pau/Bun WITH a piece OF white paper AND let it prove again FOR another 15 minutes.</li><li>5.Steam Pau/Bun WITH high heat FOR about 15 minutes OR UNTIL the Pau/Bun IS cooked.</li><li>6.Serve hot.</li></ol>  vietnamese  45  16  f  f  f  t
\.


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 174
-- Name: Recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Recipe_id_seq"', 385, TRUE);

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
  ADD CONSTRAINT "IngredientsInRecipes_pkey" PRIMARY KEY (recipe_id, ingredient_id);

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

