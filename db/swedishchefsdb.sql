--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-03-31 00:59:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2056 (class 1262 OID 12135)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE irdbpostgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: <enum 'Continent'>; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE "<enum 'Continent'>" AS ENUM (
    'Africa',
    'Antarctica',
    'Asia',
    'Australia',
    'Europe',
    'NorthAmerica',
    'SouthAmerica'
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
    'eastern',
    'european',
    'caribbean',
    'latinAmerican'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 16669)
-- Name: Ingredient; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "Ingredient" (
    id integer NOT NULL,
    name character varying NOT NULL,
    scientific_name character varying,
    continent_of_origin "<enum 'Continent'>"
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
    recipe_id integer NOT NULL,
    ingredient_id integer NOT NULL,
    original_string character varying NOT NULL,
    amount double precision,
    unit character varying,
    unit_short character varying,
    ingredient_index integer NOT NULL
);


--
-- TOC entry 177 (class 1259 OID 16693)
-- Name: Nutritional Content; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "Nutritional Content" (
    id integer NOT NULL,
    ingredient_id integer,
    calories integer NOT NULL,
    total_fat_in_grams integer NOT NULL,
    saturated_fat_in_grams integer NOT NULL,
    cholesterol_in_milligrams integer NOT NULL,
    sodium_in_milligrams integer NOT NULL,
    total_carbohydrates_in_grams integer NOT NULL,
    dietary_fiber_in_grams double precision NOT NULL,
    sugar_in_grams double precision NOT NULL,
    protein_in_grams double precision NOT NULL,
    vitamin_a_in_iu integer NOT NULL,
    vitamin_c_in_milligrams integer NOT NULL,
    calcium_in_milligrams integer NOT NULL,
    iron_in_milligrams integer NOT NULL,
    CONSTRAINT "Nutritional Content_calcium_in_milligrams_check" CHECK ((calcium_in_milligrams >= 0)),
    CONSTRAINT "Nutritional Content_calories_check" CHECK ((calories >= 0)),
    CONSTRAINT "Nutritional Content_cholesterol_in_milligrams_check" CHECK ((cholesterol_in_milligrams >= 0)),
    CONSTRAINT "Nutritional Content_dietary_fiber_in_grams_check" CHECK ((dietary_fiber_in_grams >= (0)::double precision)),
    CONSTRAINT "Nutritional Content_iron_in_milligrams_check" CHECK ((iron_in_milligrams >= 0)),
    CONSTRAINT "Nutritional Content_protein_in_grams_check" CHECK ((protein_in_grams >= (0)::double precision)),
    CONSTRAINT "Nutritional Content_saturated_fat_in_grams_check" CHECK ((saturated_fat_in_grams >= 0)),
    CONSTRAINT "Nutritional Content_sodium_in_milligrams_check" CHECK ((sodium_in_milligrams >= 0)),
    CONSTRAINT "Nutritional Content_sugar_in_grams_check" CHECK ((sugar_in_grams >= (0)::double precision)),
    CONSTRAINT "Nutritional Content_total_carbohydrates_in_grams_check" CHECK ((total_carbohydrates_in_grams >= 0)),
    CONSTRAINT "Nutritional Content_total_fat_in_grams_check" CHECK ((total_fat_in_grams >= 0)),
    CONSTRAINT "Nutritional Content_vitamin_a_in_iu_check" CHECK ((vitamin_a_in_iu >= 0)),
    CONSTRAINT "Nutritional Content_vitamin_c_in_milligrams_check" CHECK ((vitamin_c_in_milligrams >= 0))
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
    id integer NOT NULL,
    title character varying NOT NULL,
    image_uri character varying,
    instructions character varying,
    cuisine "Cuisine",
    ready_in_minutes integer,
    servings integer,
    vegetarian boolean,
    vegan boolean,
    gluten_free boolean,
    dairy_free boolean
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

ALTER TABLE ONLY "Ingredient" ALTER COLUMN id SET DEFAULT nextval('"Ingredient_id_seq"'::regclass);


--
-- TOC entry 1909 (class 2604 OID 16696)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Nutritional Content" ALTER COLUMN id SET DEFAULT nextval('"Nutritional Content_id_seq"'::regclass);


--
-- TOC entry 1908 (class 2604 OID 16685)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Recipe" ALTER COLUMN id SET DEFAULT nextval('"Recipe_id_seq"'::regclass);


--
-- TOC entry 2046 (class 0 OID 16669)
-- Dependencies: 173
-- Data for Name: Ingredient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Ingredient" (id, name, scientific_name, continent_of_origin) FROM stdin;
1	black eyed peas	\N	\N
2	carrots	\N	\N
3	green pepper	\N	\N
4	onion	\N	\N
5	peanut butter	\N	\N
6	salt	\N	\N
7	water	\N	\N
14	canned chickpeas	\N	\N
15	canola oil	\N	\N
16	garlic	\N	\N
17	harissa	\N	\N
18	leek	\N	\N
19	lemon juice	\N	\N
20	rice noodles	\N	\N
21	spinach leaves	\N	\N
22	tomato paste	\N	\N
36	brown rice	\N	\N
37	canned coconut milk	\N	\N
38	chicken breast	\N	\N
39	chili flakes	\N	\N
40	coconut oil	\N	\N
41	curry powder	\N	\N
42	garam masala	\N	\N
43	ginger	\N	\N
44	lemon grass	\N	\N
45	snow peas	\N	\N
46	canned tomatoes	\N	\N
47	coriander seeds	\N	\N
48	cumin seeds	\N	\N
49	filtered water	\N	\N
50	fresh ginger	\N	\N
51	garlic cloves	\N	\N
52	grapeseed oil	\N	\N
53	red lentils	\N	\N
54	sea salt	\N	\N
55	serrano peppers	\N	\N
56	turmeric	\N	\N
57	vegetable bouillon cube	\N	\N
58	white onion	\N	\N
59	apple cider	\N	\N
60	coconut milk	\N	\N
61	goat cheese	\N	\N
62	granny smith apples	\N	\N
63	leeks	\N	\N
64	vegetable oil	\N	\N
65	white mushrooms	\N	\N
66	allspice	\N	\N
67	green bell pepper	\N	\N
68	pepper	\N	\N
69	scallions	\N	\N
70	scotch bonnet pepper	\N	\N
71	skinless chicken thighs	\N	\N
72	sweet potatoes	\N	\N
73	thyme	\N	\N
74	bay leaves	\N	\N
75	boneless chicken breast	\N	\N
76	butter	\N	\N
77	chilli powder	\N	\N
78	chillies	\N	\N
79	cilantro leaves	\N	\N
80	cream	\N	\N
81	fennel seeds	\N	\N
82	ketchup	\N	\N
83	lime juice	\N	\N
84	nuts	\N	\N
85	red pepper powder	\N	\N
86	sugar	\N	\N
87	tomato	\N	\N
88	yogurt	\N	\N
\.


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 172
-- Name: Ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Ingredient_id_seq"', 95, true);


--
-- TOC entry 2051 (class 0 OID 16717)
-- Dependencies: 178
-- Data for Name: IngredientsInRecipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "IngredientsInRecipes" (recipe_id, ingredient_id, original_string, amount, unit, unit_short, ingredient_index) FROM stdin;
5	1	2 cups dried black-eyed peas	2	cups	c	0
5	2	2 cups sliced carrots	2	cups	c	1
5	3	1 cup green pepper, diced	1	cup	c	2
5	4	1/2 cup chopped onion	0.5	cup	c	3
5	5	2 tablespoons peanut butter	2	tablespoons	T	4
5	6	3/4 teaspoon salt	0.75	teaspoon	t	5
5	7	150 ml water	150	ml	ml	6
6	14	14 ounces can chickpeas (garbanzo beans), drained and rinsed	14	ounces	oz	0
6	15	1 tablespoon grapeseed or canola oil	1	tablespoon	T	1
6	16	10 Cloves garlic, (3 tbsp.) minced	3	tbsp	T	2
6	17	2 tablespoons harissa	2	tablespoons	T	3
6	18	1 leek, finely chopped	1			4
6	19	A tablespoon of lemon juice	1	tablespoon	T	5
6	4	1 small Onion, minced	1			6
6	20	1 package fresh pasta or a large handful of rice noodles	1	package	pkg	7
6	21	1/2 package of fresh spinach leaves or 3 good handfuls	0.5	package	pkg	8
6	22	3 tablespoons tomato paste or ketchup (yep, ketchup works great!)	3	tablespoons	T	9
6	7	1 liter (4 cups) water, chicken broth, vegetable broth	4	cups	c	10
8	36	200 g brown rice	200	g	g	0
8	37	1 can (400 ml) coconut milk	400	ml	ml	1
8	38	400 g chicken breast, cubed	400	g	g	2
8	39	chili flakes, to taste	2	servings	servings	3
8	40	1 tablespoon coconut oil	1	tablespoon	T	4
8	41	2 teaspoons curry powder	2	teaspoons	t	5
8	42	2 teaspoons garam masala	2	teaspoons	t	6
8	16	2 cloves garlic	2	cloves	cloves	7
8	43	1 inch ginger	1	inch	inch	8
8	44	1 tablespoon lemon grass paste	1	tablespoon	T	9
8	45	200 g snow peas, frozen	200	g	g	10
8	22	1 tablespoon tomato paste	1	tablespoon	T	11
9	46	1 Cup canned crushed tomatoes	1	Cup	Cup	0
9	47	2 Teaspoons Coriander Seeds or 1 Teaspoon Powder	2	Teaspoons	Teaspoons	1
9	48	1 Teaspoon Cumin Seeds	1	Teaspoon	Teaspoon	2
9	49	12 Cups Filtered Water	12	Cups	Cups	3
9	50	2 Teaspoons Fresh organic Ginger	2	Teaspoons	Teaspoons	4
9	42	1 Tablespoon Garam Masala	1	Tablespoon	Tablespoon	5
9	51	2-3 organic Garlic Cloves	2			6
9	52	1/4 Cup Expeller Pressed Grapeseed Oil	0.25	Cup	Cup	7
9	53	3 Cups organic Red Lentils	3	Cups	Cups	8
9	54	1 Tablespoon + 1 Teaspoon Sea Salt or to taste	1	Tablespoon	Tablespoon	9
9	55	2-4 Serrano peppers	2			10
9	56	3 Tablespoons Turmeric	3	Tablespoons	Tablespoons	11
9	57	2 Vegetable Bouillon Cube	2			12
9	58	1/2 organic White Onion	0.5			13
10	59	24 ounces Apple cider or juice	24	ounces	oz	0
10	60	7 ounces Coconut milk	7	ounces	oz	1
10	41	2 teaspoons Curry powder	2	teaspoons	t	2
10	61	2 packages Chavrie fresh goat cheese (reserve 1 pkg. for garnishing)	2	packages	packages	3
10	62	2 inches Granny Smith apples (cut wedges)	2	inches	inches	4
10	63	2 Leeks (chopped and washed)	2			5
10	56	1/2 teaspoon Turmeric	0.5	teaspoon	t	6
10	64	2 ounces Vegetable oil	2	ounces	oz	7
10	65	1 cup Sliced white mushrooms	1	cup	c	8
11	66	1tsp. allspice	1	tsp	t	0
11	40	1 tbsp. coconut oil	1	tbsp	T	1
11	41	6 tbsp. curry powder	6	tbsp	T	2
11	16	1 tablespoon Garlic, granulated	1	tablespoon	T	3
11	67	1 large green pepper (chopped)	1			4
11	4	1/2 medium Onion, chopped	0.5			5
11	68	2 tsp. black pepper pepper	2	tsp	t	6
11	6	1 1/2 teaspoons salt	1.5	teaspoons	t	7
11	69	3 scallions (chopped)	3			8
11	70	1 scotch bonnet pepper or habanero (seeded and minced)	1			9
11	71	3lb of chicken thighs, legs or breast (skinless)	3	lb	lb	10
11	72	2 sweet potatoes (chopped)	2			11
11	73	1tbsp. thyme	1	tbsp	T	12
11	7	2 cups water	2	cups	c	13
12	74	6 Bay leaves	6			0
12	75	1 pound Chicken breast (boneless)	1	pound	lb	1
12	76	Butter as needed( I used oil+butter)	2	servings	servings	2
12	77	1 tablespoon Chilli powder	1	tablespoon	T	3
12	78	4 Green chillies	4			4
12	79	Cilantro leaves	1	leaves	leaves	5
12	80	1/4 cup Fresh Cream	0.25	cup	c	6
12	81	1/2 teaspoon Fennel seeds	0.5	teaspoon	t	7
12	42	1 teaspoon garam masala	1	teaspoon	t	8
12	82	1 teaspoon Ketchup	1	teaspoon	t	9
12	83	1 tablespoon Lime juice	1	tablespoon	T	10
12	84	A few nuts n raisins	9	servings	servings	11
12	4	1 Big Onion Chopped	1			12
12	85	1/2 teaspoon Pepper Powder	0.5	teaspoon	t	13
12	6	1/4 teaspoon salt	0.25	teaspoon	t	14
12	86	Sugar	2	servings	servings	15
12	87	1 medium sized tomato blanched n Pureed	1			16
12	88	1 tablespoon Yogurt	1	tablespoon	T	17
\.


--
-- TOC entry 2050 (class 0 OID 16693)
-- Dependencies: 177
-- Data for Name: Nutritional Content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Nutritional Content" (id, ingredient_id, calories, total_fat_in_grams, saturated_fat_in_grams, cholesterol_in_milligrams, sodium_in_milligrams, total_carbohydrates_in_grams, dietary_fiber_in_grams, sugar_in_grams, protein_in_grams, vitamin_a_in_iu, vitamin_c_in_milligrams, calcium_in_milligrams, iron_in_milligrams) FROM stdin;
\.


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 176
-- Name: Nutritional Content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Nutritional Content_id_seq"', 1, false);


--
-- TOC entry 2048 (class 0 OID 16682)
-- Dependencies: 175
-- Data for Name: Recipe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Recipe" (id, title, image_uri, instructions, cuisine, ready_in_minutes, servings, vegetarian, vegan, gluten_free, dairy_free) FROM stdin;
6	North African Chickpea Soup	https://spoonacular.com/recipeImages/North-African-Chickpea-Soup-653275.jpg	<ol><li>In a large soup pot add the oil, onions and celery.  Cook over medium low heat until translucent.  Add the garlic and saute until fragrant.   Add the tomato paste and harissa.  Cook a minute then add the water or stock slowly while stirring to combine the flavor paste in the pot with the liquids.  Throw in the chickpeas and bring to a boil.  As soon as it reaches a boil, reduce heat to a simmer.</li><li>Add the pasta and cook according to the package directions.  My suggestion is that if you are using fresh pasta, give it a rinse under tap water to remove the starch before adding it to the soup.  It might make the broth cloudy.  If using rice noodles add them right before serving to prevent overcooked mushy noodles.  To cook rice noodles place them in a shallow dish and cover with hot water for 10-15 minutes to soften.</li><li>Just before serving taste for seasoning, adjust to your taste.  Adding too much salt earlier on could make things too salty because some of the ingredients can bring a lot of salt to the pot.  Then add the spinach, it will only take a minute to shrink into nearly nothing, but it is sure a powerhouse vegetable that amps up the nutrition in this meal quickly and without fuss.  A squeeze of fresh lemon juice after it has been taken off the heat will add a nice bright flavor to perk up those dreary dark days of winter.  Enjoy with some crusty bread.  A meal you can feel good about, filling yet light.</li></ol>	african	45	4	t	t	f	t
8	Coconut Chicken Curry with Snow Peas and Rice	https://spoonacular.com/recipeImages/Coconut-Chicken-Curry-with-Snow-Peas-and-Rice-157311.jpg	<p>1. Heat coconut oil in a pan over medium-high heat. Pre-heat the oven to 190 C or 375 F. Start cooking the brown rice.</p><p>2. Add the cubed chicken breast to the pan for a couple minutes until browned. Transfer the chicken from the pan into a casserole dish.</p><p>3. Fry the garlic and ginger in the pan, adding more coconut oil if necessary. Add the spices until fragrant.</p><p>4. Add the coconut milk and tomato paste to the pan.</p><p>5. Start steaming the frozen snow peas, giving the flavors in the sauce some time to meld.</p><p>6. Pour the sauce over the chicken breast cubes.</p><p>7. Put the casserole dish in the oven for about 25 minutes, adding the snow peas for the last 10 minutes or so. Once the chicken is cooked through, stir in the lemon grass paste.</p><p>8. Serve the chicken curry over brown rice.</p><p><span></span></p>	indian	45	2	f	f	t	t
5	African Bean Soup	https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg	<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>	african	45	4	t	t	t	t
9	Indian Spiced Red Lentil Soup	https://spoonacular.com/recipeImages/Indian-Spiced-Red-Lentil-Soup-631752.jpg	<ol><li>Put Cilantro Stems in Water and bring to a boil then remove Stems (This step is optional)</li><li>Rinse the Lentils and add to Stem Broth</li><li>Bring Lentils to a boil then turn heat down to medium</li><li>Add a bit of Lentil water to the Bullion cubes, mash well then add to Lentils</li><li>In a saut pan add  Grapeseed Oil, Coriander Seeds (you can put the seeds in a coffee grinder if you prefer) Cumin Seeds, Turmeric, Garam Masala.</li><li>Saut on medium heat until fragrant approximately about 5 minutes.</li><li>Mince Serranos, grate Ginger, mince Onions, mince Garlic and add to pan then saut until Onions are soft.</li><li>Add Tomato Sauce and cook on medium low for about 10 minutes then add to cooked Lentils and cook for 20 more minutes on low heat.</li><li>If you like a smooth texture to your soup you can put all of it in a food processor (blender or hand blender) to puree` or only use half for a slightly textured soup or leave it if you like it that way.</li></ol>	indian	45	12	t	t	t	t
11	Authentic Jamaican Curry Chicken	https://spoonacular.com/recipeImages/Authentic-Jamaican-Curry-Chicken-633088.jpg	<ol><li>Season the chicken with all of the ingredients except for the potatoes and water and marinate up to 2 hours or overnight in the fridge.</li><li>Add the oil to a Dutch oven and on high heat, fry the only the chicken pieces until it is brown and seared on each side for about 10 minutes.</li><li>After the meat is nice and brown on both sides, add the remaining vegetable marinade, scotch bonnet pepper and water to the pot, cover and bring to a boil.</li><li>Add the potatoes and lower to a simmer and stew it for about 1 hour until it has a thick consistency.</li></ol>	caribbean	45	4	f	f	t	t
10	Apple Curry Soup	https://spoonacular.com/recipeImages/Apple-Curry-Soup-632528.jpg	<ol><li>Sweat leeks and mushrooms in vegetable oil until tender (without color) in a heavy gauge sauce pot</li><li>Add apples, apple cider, coconut milk, curry powder, turmeric. Bring to boil and simmer for 20 minutes.</li><li>Add the Chavrie and season with salt and pepper</li><li>Pour entire contents in a blender and puree or puree with a hand held mixer</li><li>Strain through a fine chinois. And keep warm</li><li>Serve hot</li><li>Garnish with slices of apple or a dollop of Chavrie</li></ol>	indian	45	1	t	f	t	f
12	Balti Butter Chicken	https://spoonacular.com/recipeImages/Balti-Butter-Chicken-633960.jpg	<ol><li>Marinate the cleaned cubed chicken for all the ingredients and keep it in fridge for a minimum of 5 hours or the best overnight.</li><li>Grill it in a Tandoor oven or bake it conventional oven at 400 F for 30-40 minutes,till they are firm n brown.When the juices run out,take it n reserve.</li><li>Take a kadai n melt some butter,add the onion and green chillies and saute till pink.Take it out n blend in a mixer.</li><li>In the same pan,pour butter,splutter fennel seeds and roast the whole spices.</li><li>Now add the nuts and raisins and roast till brown n plump.(you can roast it separately n add to the gravy at last also)</li><li>Now bring back the onion paste and saute till brown.Add the reserved juice too..</li><li>Add the tomato puree and mix.</li><li>Add the chilli powder,pepper powder ,salt and half of garam masala.Mix well and simmer for 2 minutes</li><li>Sprinkle the ketchup.</li><li>Now put the roasted chicken in it and cover with the gravy.</li><li>Simmer and cover with a lid for 5-8 minutes.</li><li>Now remove the lid and cook until the desired dryness level is achieved.</li><li>Add the fresh cream n stir in for a minute.</li><li>Sprinkle the Garam masala powder,a tad of sugar and mix well.</li><li>Garnish with cilantro leaves.</li><li>Add a wee bit of butter before serving..:)</li></ol>	indian	45	2	f	f	t	f
\.


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 174
-- Name: Recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Recipe_id_seq"', 13, true);


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
    ADD CONSTRAINT "IngredientsInRecipes_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES "Ingredient"(id);


--
-- TOC entry 1934 (class 2606 OID 16725)
-- Name: IngredientsInRecipes_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "IngredientsInRecipes"
    ADD CONSTRAINT "IngredientsInRecipes_recipe_id_fkey" FOREIGN KEY (recipe_id) REFERENCES "Recipe"(id);


--
-- TOC entry 1933 (class 2606 OID 16712)
-- Name: Nutritional Content_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Nutritional Content"
    ADD CONSTRAINT "Nutritional Content_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES "Ingredient"(id);


-- Completed on 2016-03-31 00:59:09

--
-- PostgreSQL database dump complete
--

