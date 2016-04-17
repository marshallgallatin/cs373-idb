#!/usr/bin/env python3

from constants import databaseName
from models import Base
from utility import renameKeyInDict
from SearchQueries import *
from QueryExceptions import BadQueryException
from QueryHelpers import ensureIsNonNegative, ensureIsPositive, ensureDictOnlyContains, ensureDictExactlyContains, ensureListIsntEmpty
from testModels import *
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
class UtilityTest(TestCase):
    def test_renameKeyInDict(self):
        aDict = {'keyBefore':'Value'}
        renameKeyInDict('keyBefore', 'keyAfter', aDict)
        self.assertEqual(aDict, {'keyAfter':'Value'})

class QueryHelpersTest(TestCase):
    def test_ensureIsNonNegative1(self):
        ensureIsNonNegative(1)

    def test_ensureIsNonNegative2(self):
        ensureIsNonNegative(18237642834)

    def test_ensureIsNonNegative3(self):
        ensureIsNonNegative(0)

    def test_ensureIsNonNegative3(self):
        ensureIsNonNegative(0.0)

    def test_ensureIsNonNegative4(self):
        with self.assertRaises(BadQueryException):
            ensureIsNonNegative(-1)

    def test_ensureIsNonNegative5(self):
        with self.assertRaises(BadQueryException):
            ensureIsNonNegative(-1.0)

    def test_ensureIsPositive1(self):
        ensureIsPositive(1)

    def test_ensureIsPositive2(self):
        ensureIsPositive(1.0)

    def test_ensureIsPositive3(self):
        with self.assertRaises(BadQueryException):
            ensureIsPositive(0.0)

    def test_ensureDictOnlyContains1(self):
        ensureDictOnlyContains({}, 1, "bar")

    def test_ensureDictOnlyContains2(self):
        ensureDictOnlyContains({1:1}, 1, "bar")

    def test_ensureDictOnlyContains3(self):
        with self.assertRaises(BadQueryException):
            ensureDictOnlyContains({2:1}, 1, "bar")

    def test_ensureDictOnlyContains4(self):
        with self.assertRaises(BadQueryException):
            ensureDictOnlyContains({1:1, "bar":"bar", "extra":1.0}, 1, "bar")

    def test_ensureDictExactlyContains1(self):
        ensureDictExactlyContains({})

    def test_ensureDictExactlyContains2(self):
        ensureDictExactlyContains({1:1}, 1)

    def test_ensureDictExactlyContains3(self):
        ensureDictExactlyContains({1:1, "key1":"Value1"}, 1, "key1")

    def test_ensureDictExactlyContains4(self):
        with self.assertRaises(BadQueryException):
            ensureDictExactlyContains({1:1, "key1":"Value1"}, 1, "key1", 2.0)

    def test_ensureDictExactlyContains5(self):
        with self.assertRaises(BadQueryException):
            ensureDictExactlyContains({1:1, "key1":"Value1"}, 1)

    def test_ensureListIsntEmpty1(self):
        ensureListIsntEmpty([1, 2])

    def test_ensureListIsntEmpty2(self):
        ensureListIsntEmpty(["1", "2"])

    def test_ensureListIsntEmpty3(self):
        with self.assertRaises(BadQueryException):
            ensureListIsntEmpty([])

class RecipeTest(DatabaseTest):
    def test_instantiation1(self):
        new_recipe = TestRecipe(title="Ikea's Swedish Meatballs")
        self.session.add(new_recipe)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_recipe = TestRecipe() # no title
            self.session.add(new_recipe)
            self.session.commit()

    @skip("Table level constraints don't seem to be working")
    def test_tableConstraint1(self):
        with self.assertRaises(Exception):
            new_recipe = TestRecipe(title="Ikea's Swedish Vegan Meatballs", vegan = True, vegetarian = False)
            self.session.add(new_recipe)
            self.session.commit()

    @skip("Table level constraints don't seem to be working")
    def test_tableConstraint2(self):
        with self.assertRaises(Exception):
            new_recipe = TestRecipe(title="Ikea's Swedish Vegan Milkballs", vegan = True, dairy_free = False)
            self.session.add(new_recipe)
            self.session.commit()

class IngredientTest(DatabaseTest):
    def test_instantiation1(self):
        new_ingredient = TestIngredient(name="egg noodles from IKEA")
        self.session.add(new_ingredient)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_ingredient = TestIngredient() # no name
            self.session.add(new_ingredient)
            self.session.commit()

    def test_enum(self):
        with self.assertRaises(Exception):
            new_ingredient = TestIngredient(name='flour', continent_of_origin = 99) # an undefined continent
            self.session.add(new_ingredient)
            self.session.commit()

    def test_name_uniqueness(self):
        new_ingredient1 = TestIngredient(name="egg noodles from IKEA")
        new_ingredient2 = TestIngredient(name="egg noodles from IKEA")
        self.session.add(new_ingredient1)
        self.session.add(new_ingredient2)
        with self.assertRaises(Exception):
            self.session.commit()

class NutritionalContentTest(DatabaseTest):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.test_kwargs = {
            'calories'              : 100,
            'total_fat_g'           : 2,
            'saturated_fat_g'       : 1,
            'cholesterol_mg'        : 20,
            'sodium_mg'             : 20,
            'total_carbohydrates_g' : 1,
            'dietary_fiber_g'       : 1.5,
            'sugar_g'               : 30.0,
            'protein_g'             : 2.0,
            'vitamin_a_iu'          : 50.0,
            'vitamin_c_mg'          : 50.0,
            'calcium_mg'            : 50.0,
            'iron_mg'               : 50.0
        }

        self.bad_args1 = {
            'calories'              : -100,
            'total_fat_g'           : -2,
            'saturated_fat_g'       : -1,
            'cholesterol_mg'        : -20,
            'sodium_mg'             : -20,
            'total_carbohydrates_g' : -1,
            'dietary_fiber_g'       : -1.5,
            'sugar_g'               : -30.0,
            'protein_g'             : -2.0,
            'vitamin_a_iu'          : -50.0,
            'vitamin_c_mg'          : -50.0,
            'calcium_mg'            : -50.0,
            'iron_mg'               : -50.0
        }

    def test_instantiation1(self):
        new_nutritional_content = TestNutritionalContent(**self.test_kwargs)
        self.session.add(new_nutritional_content)
        self.session.commit()

    def test_instantiation2(self):
        for key in self.test_kwargs:
            with self.subTest(key = key):
                incomplete_kwargs = copy.copy(self.test_kwargs)
                incomplete_kwargs.pop(key)
                with self.assertRaises(Exception):
                    new_nutritional_content = TestNutritionalContent(**incomplete_kwargs)
                    self.session.add(new_nutritional_content)
                    self.session.commit()

    def test_constraints1(self):
        for key in self.bad_args1:
            with self.subTest(key = key):
                bad_kwargs = copy.copy(self.test_kwargs)
                bad_kwargs[key] = self.bad_args1[key]
                with self.assertRaises(Exception):
                    new_nutritional_content = TestNutritionalContent(**bad_kwargs)
                    self.session.add(new_nutritional_content)
                    self.session.commit()

class IngredientsInRecipesTest(DatabaseTest):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.new_recipe = Recipe(title="Ikea's Swedish Meatballs")
        self.new_ingredient = Ingredient(name='unittest noodles')

    def test_instantiation1(self):
        new_ingredientsInRecipes = TestIngredientsInRecipes(original_string='1 pound egg noodles', ingredient_index=0)

        new_ingredientsInRecipes.recipe = self.new_recipe
        new_ingredientsInRecipes.ingredient = self.new_ingredient

        self.session.add(new_ingredientsInRecipes)
        self.session.commit()

    def test_instantiation2(self):
        with self.assertRaises(Exception):
            new_ingredientsInRecipes = TestIngredientsInRecipes(original_string='1 pound egg noodles') # no ingredient index

            new_ingredientsInRecipes.recipe = self.new_recipe
            new_ingredientsInRecipes.ingredient = self.new_ingredient

            self.session.add(new_ingredientsInRecipes)
            self.session.commit()

    def test_instantiation3(self):
        with self.assertRaises(Exception):
            new_ingredientsInRecipes = TestIngredientsInRecipes(ingredient_index=0) # no original string

            new_ingredientsInRecipes.recipe = self.new_recipe
            new_ingredientsInRecipes.ingredient = self.new_ingredient

            self.session.add(new_ingredientsInRecipes)
            self.session.commit()

if __name__ == "__main__" :
    if importlib.find_loader('psycopg2') is not None:
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
