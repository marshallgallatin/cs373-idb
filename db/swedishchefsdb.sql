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
1  black eyed peas  \N  \N
2  carrots  \N  \N
3  green pepper  \N  \N
4  onion  \N  \N
5  peanut butter  \N  \N
6  salt  \N  \N
7  water  \N  \N
14  canned chickpeas  \N  \N
15  canola oil  \N  \N
16  garlic  \N  \N
17  harissa  \N  \N
18  leek  \N  \N
19  lemon juice  \N  \N
20  rice noodles  \N  \N
21  spinach leaves  \N  \N
22  tomato paste  \N  \N
36  brown rice  \N  \N
37  canned coconut milk  \N  \N
38  chicken breast  \N  \N
39  chili flakes  \N  \N
40  coconut oil  \N  \N
41  curry powder  \N  \N
42  garam masala  \N  \N
43  ginger  \N  \N
44  lemon grass  \N  \N
45  snow peas  \N  \N
46  canned tomatoes  \N  \N
47  coriander seeds  \N  \N
48  cumin seeds  \N  \N
49  filtered water  \N  \N
50  fresh ginger  \N  \N
51  garlic cloves  \N  \N
52  grapeseed oil  \N  \N
53  red lentils  \N  \N
54  sea salt  \N  \N
55  serrano peppers  \N  \N
56  turmeric  \N  \N
57  vegetable bouillon CUBE \N  \N
58  white onion  \N  \N
59  apple cider  \N  \N
60  coconut milk  \N  \N
61  goat cheese  \N  \N
62  granny smith apples  \N  \N
63  leeks  \N  \N
64  vegetable oil  \N  \N
65  white mushrooms  \N  \N
66  allspice  \N  \N
67  green bell pepper  \N  \N
68  pepper  \N  \N
69  scallions  \N  \N
70  scotch bonnet pepper  \N  \N
71  skinless chicken thighs  \N  \N
72  sweet potatoes  \N  \N
73  thyme  \N  \N
74  bay leaves  \N  \N
75  boneless chicken breast  \N  \N
76  butter  \N  \N
77  chilli powder  \N  \N
78  chillies  \N  \N
79  cilantro leaves  \N  \N
80  cream  \N  \N
81  fennel seeds  \N  \N
82  ketchup  \N  \N
83  lime juice  \N  \N
84  nuts  \N  \N
85  red pepper powder  \N  \N
86  sugar  \N  \N
87  tomato  \N  \N
88  yogurt  \N  \N
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
5  1  2 cups dried black-eyed peas  2  cups C 0
5  2  2 cups sliced carrots  2  cups C 1
5  3  1 cup green pepper, diced  1  cup C 2
5  4  1/2 cup chopped onion  0.5  cup C 3
5  5  2 tablespoons peanut butter  2  tablespoons  T  4
5  6  3/4 teaspoon salt  0.75  teaspoon  t  5
5  7  150 ml water  150  ml  ml  6
6  14  14 ounces can chickpeas (garbanzo beans), drained AND rinsed  14  ounces  oz  0
6  15  1 tablespoon grapeseed OR canola oil  1  tablespoon  T  1
6  16  10 Cloves garlic, (3 tbsp.) minced  3  tbsp  T  2
6  17  2 tablespoons harissa  2  tablespoons  T  3
6  18  1 leek, finely chopped  1      4
6  19  A tablespoon OF lemon juice  1  tablespoon  T  5
6  4  1 small Onion, minced  1      6
6  20  1 package fresh pasta OR a LARGE handful OF rice noodles  1  package  pkg  7
6  21  1/2 package OF fresh spinach leaves OR 3 good handfuls  0.5  package  pkg  8
6  22  3 tablespoons tomato paste OR ketchup (yep, ketchup works great!)  3  tablespoons  T  9
6  7  1 liter (4 cups) water, chicken broth, vegetable broth  4  cups C 10
8  36  200 g brown rice  200  g  g  0
8  37  1 can (400 ml) coconut milk  400  ml  ml  1
8  38  400 g chicken breast, cubed  400  g  g  2
8  39  chili flakes, TO taste  2  servings  servings  3
8  40  1 tablespoon coconut oil  1  tablespoon  T  4
8  41  2 teaspoons curry powder  2  teaspoons  t  5
8  42  2 teaspoons garam masala  2  teaspoons  t  6
8  16  2 cloves garlic  2  cloves  cloves  7
8  43  1 inch ginger  1  inch  inch  8
8  44  1 tablespoon lemon grass paste  1  tablespoon  T  9
8  45  200 g snow peas, frozen  200  g  g  10
8  22  1 tablespoon tomato paste  1  tablespoon  T  11
9  46  1 Cup canned crushed tomatoes  1  Cup  Cup  0
9  47  2 Teaspoons Coriander Seeds OR 1 Teaspoon Powder  2  Teaspoons  Teaspoons  1
9  48  1 Teaspoon Cumin Seeds  1  Teaspoon  Teaspoon  2
9  49  12 Cups Filtered Water  12  Cups  Cups  3
9  50  2 Teaspoons Fresh organic Ginger  2  Teaspoons  Teaspoons  4
9  42  1 Tablespoon Garam Masala  1  Tablespoon  Tablespoon  5
9  51  2-3 organic Garlic Cloves  2      6
9  52  1/4 Cup Expeller Pressed Grapeseed Oil  0.25  Cup  Cup  7
9  53  3 Cups organic Red Lentils  3  Cups  Cups  8
9  54  1 Tablespoon + 1 Teaspoon Sea Salt OR TO taste  1  Tablespoon  Tablespoon  9
9  55  2-4 Serrano peppers  2      10
9  56  3 Tablespoons Turmeric  3  Tablespoons  Tablespoons  11
9  57  2 Vegetable Bouillon CUBE 2      12
9  58  1/2 organic White Onion  0.5      13
10  59  24 ounces Apple cider OR juice  24  ounces  oz  0
10  60  7 ounces Coconut milk  7  ounces  oz  1
10  41  2 teaspoons Curry powder  2  teaspoons  t  2
10  61  2 packages Chavrie fresh goat cheese (reserve 1 pkg.FOR garnishing)  2  packages  packages  3
10  62  2 inches Granny Smith apples (cut wedges)  2  inches  inches  4
10  63  2 Leeks (chopped AND washed)  2      5
10  56  1/2 teaspoon Turmeric  0.5  teaspoon  t  6
10  64  2 ounces Vegetable oil  2  ounces  oz  7
10  65  1 cup Sliced white mushrooms  1  cup C 8
11  66  1tsp.allspice  1  tsp  t  0
11  40  1 tbsp.coconut oil  1  tbsp  T  1
11  41  6 tbsp.curry powder  6  tbsp  T  2
11  16  1 tablespoon Garlic, granulated  1  tablespoon  T  3
11  67  1 LARGE green pepper (chopped)  1      4
11  4  1/2 medium Onion, chopped  0.5      5
11  68  2 tsp.black pepper pepper  2  tsp  t  6
11  6  1 1/2 teaspoons salt  1.5  teaspoons  t  7
11  69  3 scallions (chopped)  3      8
11  70  1 scotch bonnet pepper OR habanero (seeded AND minced)  1      9
11  71  3lb OF chicken thighs, legs OR breast (skinless)  3  lb  lb  10
11  72  2 sweet potatoes (chopped)  2      11
11  73  1tbsp.thyme  1  tbsp  T  12
11  7  2 cups water  2  cups C 13
12  74  6 Bay leaves  6      0
12  75  1 pound Chicken breast (boneless)  1  pound  lb  1
12  76  Butter AS needed( I used oil+butter)  2  servings  servings  2
12  77  1 tablespoon Chilli powder  1  tablespoon  T  3
12  78  4 Green chillies  4      4
12  79  Cilantro leaves  1  leaves  leaves  5
12  80  1/4 cup Fresh Cream  0.25  cup C 6
12  81  1/2 teaspoon Fennel seeds  0.5  teaspoon  t  7
12  42  1 teaspoon garam masala  1  teaspoon  t  8
12  82  1 teaspoon Ketchup  1  teaspoon  t  9
12  83  1 tablespoon Lime juice  1  tablespoon  T  10
12  84  A few nuts n raisins  9  servings  servings  11
12  4  1 Big Onion Chopped  1      12
12  85  1/2 teaspoon Pepper Powder  0.5  teaspoon  t  13
12  6  1/4 teaspoon salt  0.25  teaspoon  t  14
12  86  Sugar  2  servings  servings  15
12  87  1 medium sized tomato blanched n Pureed  1      16
12  88  1 tablespoon Yogurt  1  tablespoon  T  17
\.


--
-- TOC entry 2050 (class 0 OID 16693)
-- Dependencies: 177
-- Data for Name: Nutritional Content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Nutritional Content" (id, ingredient_id, calories, total_fat_g, saturated_fat_g, cholesterol_mg, sodium_mg, total_carbohydrates_g, dietary_fiber_g, sugar_g, protein_g, vitamin_a_iu, vitamin_c_mg, calcium_mg, iron_mg) FROM STDIN;
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
6  North African Chickpea Soup  https://spoonacular.com/recipeImages/North-African-Chickpea-Soup-653275.jpg  <ol><li> IN a LARGE soup pot ADD the oil, onions AND celery.Cook OVER medium low heat UNTIL translucent.ADD the garlic AND saute UNTIL fragrant.ADD the tomato paste AND harissa.Cook a MINUTE THEN ADD the water OR stock slowly WHILE stirring TO combine the flavor paste IN the pot WITH the liquids.Throw IN the chickpeas AND bring TO a boil. AS soon AS it reaches a boil, reduce heat TO a simmer.</li><li> ADD the pasta AND cook according TO the package directions.My suggestion IS that IF you are USING fresh pasta, give it a rinse under tap water TO remove the starch BEFORE adding it TO the soup.It might make the broth cloudy.IF USING rice noodles ADD them RIGHT BEFORE serving TO prevent overcooked mushy noodles.TO cook rice noodles place them IN a shallow dish AND cover WITH hot water FOR 10-15 minutes TO soften.</li><li>Just BEFORE serving taste FOR seasoning, adjust TO your taste.Adding too much salt earlier ON could make things too salty because SOME OF the ingredients can bring a lot OF salt TO the pot.THEN ADD the spinach, it will ONLY take a MINUTE TO shrink INTO nearly NOTHING, but it IS sure a powerhouse vegetable that amps up the nutrition IN this meal quickly AND WITHOUT fuss.A squeeze OF fresh lemon juice AFTER it has been taken OFF the heat will ADD a nice bright flavor TO perk up those dreary dark days OF winter.Enjoy WITH SOME crusty bread.A meal you can feel good about, filling yet light.</li></ol>  african  45  4  t  t  f  t
8  Coconut Chicken Curry WITH Snow Peas AND Rice  https://spoonacular.com/recipeImages/Coconut-Chicken-Curry- WITH -Snow-Peas- AND -Rice-157311.jpg  <p>1. Heat coconut oil IN a pan OVER medium-high heat.Pre-heat the oven TO 190 C OR 375 F.START cooking the brown rice.</p><p>2. ADD the cubed chicken breast TO the pan FOR a couple minutes UNTIL browned.Transfer the chicken FROM the pan INTO a casserole dish.</p><p>3. Fry the garlic AND ginger IN the pan, adding more coconut oil IF necessary.ADD the spices UNTIL fragrant.</p><p>4. ADD the coconut milk AND tomato paste TO the pan.</p><p>5. START steaming the frozen snow peas, giving the flavors IN the sauce SOME TIME TO meld.</p><p>6. Pour the sauce OVER the chicken breast cubes.</p><p>7. Put the casserole dish IN the oven FOR about 25 minutes, adding the snow peas FOR the LAST 10 minutes OR so.Once the chicken IS cooked through, stir IN the lemon grass paste.</p><p>8. Serve the chicken curry OVER brown rice.</p><p><span></span></p>  indian  45  2  f  f  t  t
5  African Bean Soup  https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg  <ol><li>Saute onions IN LARGE pot UNTIL soft.ADD ALL ingredients EXCEPT FOR peanut butter AND simmer FOR 1 1/2 hours.</li><li>Stir a spoonful OF peanut butter INTO EACH serving.</li></ol>  african  45  4  t  t  t  t
9  Indian Spiced Red Lentil Soup  https://spoonacular.com/recipeImages/Indian-Spiced-Red-Lentil-Soup-631752.jpg  <ol><li>Put Cilantro Stems IN Water AND bring TO a boil THEN remove Stems (This step IS optional)</li><li>Rinse the Lentils AND ADD TO Stem Broth</li><li>Bring Lentils TO a boil THEN turn heat down TO medium</li><li> ADD a BIT OF Lentil water TO the Bullion cubes, mash well THEN ADD TO Lentils</li><li> IN a saut pan ADD Grapeseed Oil, Coriander Seeds (you can put the seeds IN a coffee grinder IF you prefer) Cumin Seeds, Turmeric, Garam Masala.</li><li>Saut ON medium heat UNTIL fragrant approximately about 5 minutes.</li><li>Mince Serranos, grate Ginger, mince Onions, mince Garlic AND ADD TO pan THEN saut UNTIL Onions are soft.</li><li> ADD Tomato Sauce AND cook ON medium low FOR about 10 minutes THEN ADD TO cooked Lentils AND cook FOR 20 more minutes ON low heat.</li><li> IF you LIKE a smooth texture TO your soup you can put ALL OF it IN a food processor (blender OR hand blender) TO puree` OR ONLY use half FOR a slightly textured soup OR leave it IF you LIKE it that way.</li></ol>  indian  45  12  t  t  t  t
11  Authentic Jamaican Curry Chicken  https://spoonacular.com/recipeImages/Authentic-Jamaican-Curry-Chicken-633088.jpg  <ol >< li > Season the chicken WITH ALL OF the ingredients EXCEPT FOR the potatoes AND water AND marinate up TO 2 hours OR overnight IN the fridge.</li><li> ADD the oil TO a Dutch oven AND ON high heat, fry the ONLY the chicken pieces UNTIL it IS brown AND seared ON EACH side FOR about 10 minutes.</li><li> AFTER the meat IS nice AND brown ON BOTH sides, ADD the remaining vegetable marinade, scotch bonnet pepper AND water TO the pot, cover AND bring TO a boil.</li><li> ADD the potatoes AND lower TO a simmer AND stew it FOR about 1 HOUR UNTIL it has a thick consistency.</li></ol>  caribbean  45  4  f  f  t  t
10  Apple Curry Soup  https://spoonacular.com/recipeImages/Apple-Curry-Soup-632528.jpg  <ol><li>Sweat leeks AND mushrooms IN vegetable oil UNTIL tender ( WITHOUT color) IN a heavy gauge sauce pot</li><li> ADD apples, apple cider, coconut milk, curry powder, turmeric.Bring TO boil AND simmer FOR 20 minutes.</li><li> ADD the Chavrie AND season WITH salt AND pepper</li><li>Pour entire contents IN a blender AND puree OR puree WITH a hand held mixer</li><li>Strain through a fine chinois.AND keep warm</li><li>Serve hot</li><li>Garnish WITH slices OF apple OR a dollop OF Chavrie</li></ol>  indian  45  1  t  f  t  f
12  Balti Butter Chicken  https://spoonacular.com/recipeImages/Balti-Butter-Chicken-633960.jpg  <ol><li>Marinate the cleaned cubed chicken FOR ALL the ingredients AND keep it IN fridge FOR a minimum OF 5 hours OR the best overnight.</li><li>Grill it IN a Tandoor oven OR bake it conventional oven AT 400 F FOR 30-40 minutes, till they are firm n brown.When the juices run OUT, take it n reserve.</li><li>Take a kadai n melt SOME butter, ADD the onion AND green chillies AND saute till pink.Take it OUT n blend IN a mixer.</li><li> IN the same pan, pour butter, splutter fennel seeds AND roast the whole spices.</li><li>Now ADD the nuts AND raisins AND roast till brown n plump.(you can roast it separately n ADD TO the gravy AT LAST ALSO )</li><li>Now bring back the onion paste AND saute till brown.Add the reserved juice too..</li><li> ADD the tomato puree AND mix.</li><li> ADD the chilli powder, pepper powder, salt AND half OF garam masala.Mix well AND simmer FOR 2 minutes</li><li>Sprinkle the ketchup.</li><li>Now put the roasted chicken IN it AND cover WITH the gravy.</li><li>Simmer AND cover WITH a lid FOR 5-8 minutes.</li><li>Now remove the lid AND cook UNTIL the desired dryness LEVEL IS achieved.</li><li> ADD the fresh cream n stir IN FOR a MINUTE.</li><li>Sprinkle the Garam masala powder, a tad OF sugar AND mix well.</li><li>Garnish WITH cilantro leaves.</li><li> ADD a wee BIT OF butter BEFORE serving..:)</li></ol>  indian  45  2  f  f  t  f
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

