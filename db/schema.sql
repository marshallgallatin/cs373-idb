-- **** ENUMS ****

CREATE TYPE "<enum 'Origin'>" AS ENUM (
    'Africa',
    'Asia',
    'Europe',
    'NorthAmerica',
    'Oceania',
    'SouthAmerica',
    'Worldwide'
);

-- **** TABLES ****

-- Table: "Ingredient"
-- DROP TABLE "Ingredient";
CREATE TABLE "Ingredient"
(
  id serial NOT NULL,
  name character varying NOT NULL,
  image_uri character varying,
  scientific_name character varying,
  origin "<enum 'Origin'>",
  CONSTRAINT "Ingredient_pkey" PRIMARY KEY (id),
  CONSTRAINT "Ingredient_name_key" UNIQUE (name)
);

  
-- Table: "IngredientsInRecipes"
-- DROP TABLE "IngredientsInRecipes";
CREATE TABLE "IngredientsInRecipes"
(
  recipe_id integer NOT NULL,
  ingredient_id integer NOT NULL,
  original_string character varying NOT NULL,
  amount double precision,
  unit character varying,
  unit_short character varying,
  ingredient_index integer NOT NULL,
  CONSTRAINT "IngredientsInRecipes_pkey" PRIMARY KEY (recipe_id, ingredient_id),
  CONSTRAINT "IngredientsInRecipes_ingredient_id_fkey" FOREIGN KEY (ingredient_id)
      REFERENCES "Ingredient" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "IngredientsInRecipes_recipe_id_fkey" FOREIGN KEY (recipe_id)
      REFERENCES "Recipe" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


-- Table: "Nutritional Content"
-- DROP TABLE "Nutritional Content";
CREATE TABLE "Nutritional Content"
(
  id serial NOT NULL,
  ingredient_id integer,
  calories integer NOT NULL,
  total_fat_g integer NOT NULL,
  saturated_fat_g integer NOT NULL,
  cholesterol_mg integer NOT NULL,
  sodium_mg integer NOT NULL,
  total_carbohydrates_g integer NOT NULL,
  dietary_fiber_g double precision NOT NULL,
  sugar_g double precision NOT NULL,
  protein_g double precision NOT NULL,
  vitamin_a_iu integer NOT NULL,
  vitamin_c_mg integer NOT NULL,
  calcium_mg integer NOT NULL,
  iron_mg integer NOT NULL,
  CONSTRAINT "Nutritional Content_pkey" PRIMARY KEY (id),
  CONSTRAINT "Nutritional Content_ingredient_id_fkey" FOREIGN KEY (ingredient_id)
      REFERENCES "Ingredient" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Nutritional Content_calcium_mg_check" CHECK (calcium_mg >= 0),
  CONSTRAINT "Nutritional Content_calories_check" CHECK (calories >= 0),
  CONSTRAINT "Nutritional Content_cholesterol_mg_check" CHECK (cholesterol_mg >= 0),
  CONSTRAINT "Nutritional Content_dietary_fiber_g_check" CHECK (dietary_fiber_g >= 0::double precision),
  CONSTRAINT "Nutritional Content_iron_mg_check" CHECK (iron_mg >= 0),
  CONSTRAINT "Nutritional Content_protein_g_check" CHECK (protein_g >= 0::double precision),
  CONSTRAINT "Nutritional Content_saturated_fat_g_check" CHECK (saturated_fat_g >= 0),
  CONSTRAINT "Nutritional Content_sodium_mg_check" CHECK (sodium_mg >= 0),
  CONSTRAINT "Nutritional Content_sugar_g_check" CHECK (sugar_g >= 0::double precision),
  CONSTRAINT "Nutritional Content_total_carbohydrates_g_check" CHECK (total_carbohydrates_g >= 0),
  CONSTRAINT "Nutritional Content_total_fat_g_check" CHECK (total_fat_g >= 0),
  CONSTRAINT "Nutritional Content_vitamin_a_iu_check" CHECK (vitamin_a_iu >= 0),
  CONSTRAINT "Nutritional Content_vitamin_c_mg_check" CHECK (vitamin_c_mg >= 0)
);

-- Table: "Recipe"
-- DROP TABLE "Recipe";
CREATE TABLE "Recipe"
(
  id serial NOT NULL,
  title character varying NOT NULL,
  image_uri character varying,
  instructions character varying,
  cuisine "Cuisine",
  ready_in_minutes integer,
  servings integer,
  vegetarian boolean,
  vegan boolean,
  gluten_free boolean,
  dairy_free boolean,
  CONSTRAINT "Recipe_pkey" PRIMARY KEY (id)
);


-- **** SEQUENCES ****

-- Sequence: "Ingredient_id_seq"
-- DROP SEQUENCE "Ingredient_id_seq";
CREATE SEQUENCE "Ingredient_id_seq"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence: "Nutritional Content_id_seq"
-- DROP SEQUENCE "Nutritional Content_id_seq";
CREATE SEQUENCE "Nutritional Content_id_seq"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence: "Recipe_id_seq"
-- DROP SEQUENCE "Recipe_id_seq";
CREATE SEQUENCE "Recipe_id_seq"
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
