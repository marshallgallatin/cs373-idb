from sqlalchemy import orm
from useDatabase import *
import models
from enums import Cuisine
import QueryHelpers

def getAllIngredients(limit=10, page=1):
    """Gets all the ingredients in the database, limiting the results to up to 'limit' results.

    Args:
        limit (Optional(int)): The upper-bound on the number of ingredients to return. Defaults to 10. Must be positive.
        page (Optional(int)): The page for large datasets. Defaults to 1. Must be positive.

    Returns:
        list: A list of ingredient summary dicts, up to 'limit' of them.

    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
    """

    QueryHelpers.ensureIsNonNegative(limit)
    QueryHelpers.ensureIsNonNegative(page)
    with sessionInstance() as session:
        return [ingredient.summaryDict() for ingredient in session.query(models.Ingredient).slice(limit * (page - 1), limit * page).all()]

def getIngredientByID(id):
    """Gets the single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Retuns:
        dict: The ingredient's full dict with the given id if it exists, 'None' otherwise.
    """

    with sessionInstance() as session:
        try:
            return session.query(models.Ingredient).filter(models.Ingredient.id == id).one().fullDict()
        except orm.exc.NoResultFound:
            return None


def getNutritionalInformationFromIngredientByID(id):
    """Gets the nutritional information from a single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Retuns:
        dict: The full dict of the nutritional information of the ingredient with the given id if it exists, 'None' otherwise.
              Note: 'None' can be returned if the ingredient doesn't exist, or if the ingredient doesn't have nutritional information.
    """

    with sessionInstance() as session:
        try:
            ingredient = session.query(models.Ingredient).filter(models.Ingredient.id == id).one()
            return None if ingredient.nutritional_content is None else ingredient.nutritional_content.fullDict()
        except orm.exc.NoResultFound:
            return None

def getRecipesUsingIngredientById(id, limit=10, page=1):
    """Gets the recipes from the database who have the given ingredient id as an ingredient.
    Args:
        id (int): ID of the ingredient.
        limit (Optional(int)): The upper-bound on the number of ingredients to return. Defaults to 10. Must be positive.
        page (Optional(int)): The page for large datasets. Defaults to 1. Must be positive.
    Retuns:
        list: A list of all the recipe summaries dicts who use the given ingredient.
    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
        QueryExceptions.BadQueryException: If page is less than 1.
    """

    QueryHelpers.ensureIsNonNegative(limit)
    QueryHelpers.ensureIsNonNegative(page)
    with sessionInstance() as session:
        try:
            ingredient = session.query(models.Ingredient).filter(models.Ingredient.id == id).one()
            return [ingredientInRecipe.recipe.summaryDict() for ingredientInRecipe in ingredient.recipes][limit * (page - 1): limit * page]
        except orm.exc.NoResultFound:
            return None

