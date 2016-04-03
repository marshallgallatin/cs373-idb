-- **** ENUMS ****

CREATE TYPE "<enum 'Continent'>" AS ENUM (
    'Africa',
    'Asia',
    'Europe',
    'NorthAmerica',
    'Oceania',
    'SouthAmerica'
);

-- **** TABLES ****

-- Table: "Ingredient"
-- DROP TABLE "Ingredient";
CREATE TABLE "Ingredient"
(
  id serial NOT NULL,
  name character varying NOT NULL,
  scientific_name character varying,
  continent_of_origin "<enum 'Continent'>",
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
  CONSTRAINT "Nutritional Content_pkey" PRIMARY KEY (id),
  CONSTRAINT "Nutritional Content_ingredient_id_fkey" FOREIGN KEY (ingredient_id)
      REFERENCES "Ingredient" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "Nutritional Content_calcium_in_milligrams_check" CHECK (calcium_in_milligrams >= 0),
  CONSTRAINT "Nutritional Content_calories_check" CHECK (calories >= 0),
  CONSTRAINT "Nutritional Content_cholesterol_in_milligrams_check" CHECK (cholesterol_in_milligrams >= 0),
  CONSTRAINT "Nutritional Content_dietary_fiber_in_grams_check" CHECK (dietary_fiber_in_grams >= 0::double precision),
  CONSTRAINT "Nutritional Content_iron_in_milligrams_check" CHECK (iron_in_milligrams >= 0),
  CONSTRAINT "Nutritional Content_protein_in_grams_check" CHECK (protein_in_grams >= 0::double precision),
  CONSTRAINT "Nutritional Content_saturated_fat_in_grams_check" CHECK (saturated_fat_in_grams >= 0),
  CONSTRAINT "Nutritional Content_sodium_in_milligrams_check" CHECK (sodium_in_milligrams >= 0),
  CONSTRAINT "Nutritional Content_sugar_in_grams_check" CHECK (sugar_in_grams >= 0::double precision),
  CONSTRAINT "Nutritional Content_total_carbohydrates_in_grams_check" CHECK (total_carbohydrates_in_grams >= 0),
  CONSTRAINT "Nutritional Content_total_fat_in_grams_check" CHECK (total_fat_in_grams >= 0),
  CONSTRAINT "Nutritional Content_vitamin_a_in_iu_check" CHECK (vitamin_a_in_iu >= 0),
  CONSTRAINT "Nutritional Content_vitamin_c_in_milligrams_check" CHECK (vitamin_c_in_milligrams >= 0)
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
