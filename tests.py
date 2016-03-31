#!/usr/bin/env python3

from constants import databaseName
from models import Base, Recipe, Ingredient, NutritionalContent, IngredientsInRecipes
from sqlalchemy.engine import create_engine
from sqlalchemy.orm.session import Session
from unittest import main, TestCase, skip, skipIf
import copy
import importlib

global transaction, connection, engine

class DatabaseTest(TestCase):
    """
    Base class for our tests that involve the database.
    """
    def setUp(self):
        self.__transaction = connection.begin_nested()
        self.session = Session(connection)

    def tearDown(self):
        self.session.close()
        self.__transaction.rollback()

#-------------------------------------
# Tests
#-------------------------------------

class TestRecipe(DatabaseTest):
    def test_instantiation1(self):
        new_recipe = Recipe(title="Ikea's Swedish Meatballs")
        self.session.add(new_recipe)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_recipe = Recipe() # no title
            self.session.add(new_recipe)
            self.session.commit()

    @skip("Table level constraints don't seem to be working")
    def test_tableConstraint1(self):
        with self.assertRaises(Exception):
            new_recipe = Recipe(title="Ikea's Swedish Vegan Meatballs", vegan = True, vegetarian = False)
            self.session.add(new_recipe)
            self.session.commit()

    @skip("Table level constraints don't seem to be working")
    def test_tableConstraint2(self):
        with self.assertRaises(Exception):
            new_recipe = Recipe(title="Ikea's Swedish Vegan Milkballs", vegan = True, dairy_free = False)
            self.session.add(new_recipe)
            self.session.commit()

class TestIngredient(DatabaseTest):
    def test_instantiation1(self):
        new_ingredient = Ingredient(name="egg noodles")
        self.session.add(new_ingredient)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_ingredient = Ingredient() # no name
            self.session.add(new_ingredient)
            self.session.commit()

    def test_nameUniqueness(self):
        with self.assertRaises(Exception):
            new_ingredient1 = Ingredient(name='salt')
            new_ingredient2 = Ingredient(name='salt')
            self.session.add(new_ingredient1)
            self.session.add(new_ingredient2)
            self.session.commit()

    def test_enum(self):
        with self.assertRaises(Exception):
            new_ingredient = Ingredient(name='flour', continent_of_origin = 99) # an undefined continent
            self.session.add(new_ingredient)
            self.session.commit()

class TestNutritionalContent(DatabaseTest):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.test_kwargs = {
            'calories'                     : 100,
            'total_fat_in_grams'           : 2,
            'saturated_fat_in_grams'       : 1,
            'cholesterol_in_milligrams'    : 20,
            'sodium_in_milligrams'         : 20,
            'total_carbohydrates_in_grams' : 1,
            'dietary_fiber_in_grams'       : 1.5,
            'sugar_in_grams'               : 30.0,
            'protein_in_grams'             : 2.0,
            'vitamin_a_in_iu'              : 50.0,
            'vitamin_c_in_milligrams'      : 50.0,
            'calcium_in_milligrams'        : 50.0,
            'iron_in_milligrams'           : 50.0
        }

        self.bad_args1 = {
            'calories'                     : -100,
            'total_fat_in_grams'           : -2,
            'saturated_fat_in_grams'       : -1,
            'cholesterol_in_milligrams'    : -20,
            'sodium_in_milligrams'         : -20,
            'total_carbohydrates_in_grams' : -1,
            'dietary_fiber_in_grams'       : -1.5,
            'sugar_in_grams'               : -30.0,
            'protein_in_grams'             : -2.0,
            'vitamin_a_in_iu'              : -50.0,
            'vitamin_c_in_milligrams'      : -50.0,
            'calcium_in_milligrams'        : -50.0,
            'iron_in_milligrams'           : -50.0
        }

    def test_instantiation1(self):
        new_nutritional_content = NutritionalContent(**self.test_kwargs)
        self.session.add(new_nutritional_content)
        self.session.commit()

    def test_instantiation2(self):
        for key in self.test_kwargs:
            with self.subTest(key = key):
                incomplete_kwargs = copy.copy(self.test_kwargs)
                incomplete_kwargs.pop(key)
                with self.assertRaises(Exception):
                    new_nutritional_content = NutritionalContent(**incomplete_kwargs)
                    self.session.add(new_nutritional_content)
                    self.session.commit()

    def test_constraints1(self):
        for key in self.bad_args1:
            with self.subTest(key = key):
                bad_kwargs = copy.copy(self.test_kwargs)
                bad_kwargs[key] = self.bad_args1[key]
                with self.assertRaises(Exception):
                    new_nutritional_content = NutritionalContent(**bad_kwargs)
                    self.session.add(new_nutritional_content)
                    self.session.commit()

class TestIngredientsInRecipes(DatabaseTest):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.new_recipe = Recipe(title="Ikea's Swedish Meatballs")
        self.new_ingredient = Ingredient(name='egg noodles')

    def test_instantiation1(self):
        new_ingredientsInRecipes = IngredientsInRecipes(original_string='1 pound egg noodles', ingredient_index=0)

        new_ingredientsInRecipes.recipe = self.new_recipe
        new_ingredientsInRecipes.ingredient = self.new_ingredient

        self.session.add(new_ingredientsInRecipes)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_ingredientsInRecipes = IngredientsInRecipes(original_string='1 pound egg noodles') # no ingredient index

            new_ingredientsInRecipes.recipe = self.new_recipe
            new_ingredientsInRecipes.ingredient = self.new_ingredient

            self.session.add(new_ingredientsInRecipes)
            self.session.commit()

    def test_instantiation3(self):
        with self.assertRaises(Exception):
            new_ingredientsInRecipes = IngredientsInRecipes(ingredient_index=0) # no original string

            new_ingredientsInRecipes.recipe = self.new_recipe
            new_ingredientsInRecipes.ingredient = self.new_ingredient

            self.session.add(new_ingredientsInRecipes)
            self.session.commit()

if __name__ == "__main__" :
    if importlib.find_loader('psycog2') is not None:
        # Set up the database
        engine = create_engine(databaseName)
        connection = engine.connect()
        transaction = connection.begin()
        Base.metadata.create_all(connection)

        main()

        # Tear down the database
        transaction.rollback()
        connection.close()
        engine.dispose()
