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
  total_fat_g           INTEGER          NOT NULL,
  saturated_fat_g       INTEGER          NOT NULL,
  cholesterol_mg        INTEGER          NOT NULL,
  sodium_mg             INTEGER          NOT NULL,
  total_carbohydrates_g INTEGER          NOT NULL,
  dietary_fiber_g       DOUBLE PRECISION NOT NULL,
  sugar_g               DOUBLE PRECISION NOT NULL,
  protein_g             DOUBLE PRECISION NOT NULL,
  vitamin_a_iu          INTEGER          NOT NULL,
  vitamin_c_mg          INTEGER          NOT NULL,
  calcium_mg            INTEGER          NOT NULL,
  iron_mg               INTEGER          NOT NULL,
  CONSTRAINT "Nutritional Content_calcium_mg_check" CHECK ((calcium_mg >= 0)),
  CONSTRAINT "Nutritional Content_calories_check" CHECK ((calories >= 0)),
  CONSTRAINT "Nutritional Content_cholesterol_mg_check" CHECK ((cholesterol_mg >= 0)),
  CONSTRAINT "Nutritional Content_dietary_fiber_g_check" CHECK ((dietary_fiber_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_iron_mg_check" CHECK ((iron_mg >= 0)),
  CONSTRAINT "Nutritional Content_protein_g_check" CHECK ((protein_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_saturated_fat_g_check" CHECK ((saturated_fat_g >= 0)),
  CONSTRAINT "Nutritional Content_sodium_mg_check" CHECK ((sodium_mg >= 0)),
  CONSTRAINT "Nutritional Content_sugar_g_check" CHECK ((sugar_g >= (0) :: DOUBLE PRECISION)),
  CONSTRAINT "Nutritional Content_total_carbohydrates_g_check" CHECK ((total_carbohydrates_g >= 0)),
  CONSTRAINT "Nutritional Content_total_fat_g_check" CHECK ((total_fat_g >= 0)),
  CONSTRAINT "Nutritional Content_vitamin_a_iu_check" CHECK ((vitamin_a_iu >= 0)),
  CONSTRAINT "Nutritional Content_vitamin_c_mg_check" CHECK ((vitamin_c_mg >= 0))
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
1	black-eyed pea	https://upload.wikimedia.org/wikipedia/commons/d/d0/BlackEyedPeas.JPG Vigna unguiculata subsp. unguiculata	Africa
2	carrot	https://upload.wikimedia.org/wikipedia/commons/b/bd/13-08-31-wien-redaktionstreffen-EuT-by-Bi-frie-037.jpg	Daucus carota	Asia
3	green bell pepper	https://upload.wikimedia.org/wikipedia/commons/5/59/Capsicum3.JPG	Capsicum annuum	NorthAmerica
4	onion	https://upload.wikimedia.org/wikipedia/commons/6/6a/White_onion_cross_section.jpg	Allium cepa	Africa
5	peanut butter	https://commons.wikimedia.org/wiki/File:96_-_IMG_20150804_111725.jpg	\N	NorthAmerica
6	salt	https://upload.wikimedia.org/wikipedia/commons/7/78/Salt_shaker_on_white_background.jpg	Sodium chloride	Worldwide
7	water	\N	Dihydrogen oxide	Worldwide
8	baking powder	\N	Sodium aluminum sulfate	\N
9	banana	\N	Musa acuminata Colla	\N
10	butter	https://upload.wikimedia.org/wikipedia/commons/f/fd/Western-pack-butter.jpg	\N	\N
11	canola oil	\N	\N	\N
12	cinnamon	\N	Cinnamomum aromaticum	\N
13	cream cheese	\N	\N	\N
14	egg	\N	\N	\N
15	flour	\N	\N	\N
16	nutmeg	\N	Myristica fragrans	\N
17	honey	\N	\N	\N
18	lemon juice	\N	\N	\N
19	maple syrup	\N	\N	\N
20	milk	\N	\N	\N
21	white bread	\N	\N	\N
22	bacon	\N	\N	\N
23	garlic	\N	Allium sativum	\N
24	cabbage	\N	Brassica oleracea (Capitata Group)	\N
25	leek	\N	Allium ampeloprasum	\N
26	mace	\N	Myristica fragrans	\N
27	potato	\N	Solanum tuberosum	\N
\.


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 172
-- Name: Ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Ingredient_id_seq"', 95, TRUE);

--
-- TOC entry 2051 (class 0 OID 16717)
-- Dependencies: 178
-- Data for Name: IngredientsInRecipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "IngredientsInRecipes" (recipe_id, ingredient_id, original_string, amount, unit, unit_short, ingredient_index) FROM STDIN;
1	1	2 cups dried black-eyed peas	2	cups	c	0
1	2	2 cups sliced carrots	2	cups	c	1
1	3	1 cup green pepper, diced	1	cup	c	2
1	4	1 large chopped onion	1	cup	c	3
1	5	peanut butter	4	tablespoon	T	4
1	6	3/4 teaspoon salt	0.75	teaspoon	t	5
1	7	6 cups water	6	cups	c	6
7	8	5 1/2 teaspoons baking powder	5.5	teaspoons	t	0
7	9	2 ripe but firm bananas, sliced thin	2	\N	\N	1
7	10	1/2 cup butter or margarine - (¼ lb)	0.25	lb	lb	2
7	11	4 t. canola (or vegetable) oil	4	t	t	3
7	12	1/2 t. cinnamon	0.5	t	t	4
7	13	8 ounces cream cheese	8	ounces	oz	5
7	14	3 eggs	3	\N	\N	6
7	15	10 1/2 cups all-purpose flour	10.5	cups	c	7
7	16	dash of fresh ground nutmeg	1	dash	dash	8
7	17	1 T. honey	1	T	T	9
7	18	1/2 t. lemon juice	0.5	t	t	10
7	19	maple syrup, for serving	4	servings	servings	11
7	20	1 c. milk	1	c	c	12
7	6	1/2 teaspoon salt	0.5	teaspoon	t	13
7	21	8 slices of good quality white sandwich bread	8	slices	slices	14
188	22	2-3 rashers bacon (optional)	2	slices	slices	0
188	23	2 To 3 cloves garlic, minced	2	cloves	cloves	1
188	24	1 pound green cabbage (kale can also be used)	1	pound	lb	2
188	25	2 medium leeks, split lengthwise and rinsed well	2	\N	\N	3
188	26	1/4 teaspoon mace	0.25	teaspoon	t	4
188	27	2 pounds yellow or red potatoes, scrubbed and cubed but not peeled	2	pounds	lb	5
188	6	Salt to taste	1	\N	\N	6
188	20	1 cup whole milk	1	cup	c	7
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
\.


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 176
-- Name: Nutritional Content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Nutritional Content_id_seq"', 1, FALSE);

--
-- TOC entry 2048 (class 0 OID 16682)
-- Dependencies: 175
-- Data for Name: Recipe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Recipe" (id, title, image_uri, instructions, cuisine, ready_in_minutes, servings, vegetarian, vegan, gluten_free, dairy_free) FROM STDIN;
1	African Bean Soup	https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg	<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>	african	45	4	t	t	f	t
7	Banana & Cream Cheese Stuffed French Toast	https://spoonacular.com/recipeImages/Banana---Cream-Cheese-Stuffed-French-Toast-633971.jpg	<ol><li>In a small bowl combine the softened cream cheese, honey, cinnamon, nutmeg and lemon juice, set aside while preparing the batter.</li><li>Whisk together all of the batter ingredients until thoroughly mixed. (This is a breeze if you use a blender.) Pour the batter into a wide, shallow dish (like a pie plate).</li><li>Spread the filling mixture equally over 1 side of each slice of bread, divide the sliced bananas between 4 slices of the bread, top with the remaining 4 slices, press lightly.</li><li>Melt 2 t. butter and 2 t. oil in a 12 inch nonstick skillet over medium heat until the butter foams and then subsides. Working with one sandwich at a time dip both sides in the batter and let the excess drip away, add to the hot pan, repeat with a second sandwich. Cook until golden brown on the first side, around 3-5 minutes, flip and repeat on the second side. Repeat this process with the remaining, oil, butter and sandwiches. To serve, cut into triangles and serve with maple syrup.</li></ol>	american	45	4	t	f	f	f
188	Irish Colcannon	https://spoonacular.com/recipeImages/Irish-Colcannon-647974.jpg	<ol><li>Chop the cabbage and steam, using minimal water, until quite well done.</li><li>Boil potatoes. Clean and chop the leeks, including the first couple of inches of green, put into a saucepan with the milk and simmer until tender.</li><li>If using bacon, saute until crisp. When cool enough to handle, break into bite size pieces.</li><li>Drain potatoes and mash.</li><li>Stir in milk with leeks, cabbage, mace, garlic, and bacon. Gently mix to combine all ingredients, but take care not to over mash the potatoes.</li></ol>	irish	45	4	f	f	t	f
\.


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 174
-- Name: Recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Recipe_id_seq"', 13, TRUE);

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

