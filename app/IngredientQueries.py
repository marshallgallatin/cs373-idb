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
    QueryHelpers.ensureIsPositive(page)
    with sessionInstance() as session:
        return [ingredient.summaryDict() for ingredient in session.query(models.Ingredient).slice(limit * (page - 1) + 1, limit * page + 1).all()]

def getIngredientByID(id):
    """Gets the single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Returns:
        dict: The ingredient's full dict with the given id if it exists, 'None' otherwise.
    """

    if id == 0:
        return None
    with sessionInstance() as session:
        try:
            fullDict = session.query(models.Ingredient).filter(models.Ingredient.id == id).one().fullDict()
            del fullDict['id']
            return fullDict
        except orm.exc.NoResultFound:
            return None


def getNutritionalInformationFromIngredientByID(id):
    """Gets the nutritional information from a single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Returns:
        dict: The full dict of the nutritional information of the ingredient with the given id if it exists, 'None' otherwise.
              Note: 'None' can be returned if the ingredient doesn't exist, or if the ingredient doesn't have nutritional information.
    """

    if id == 0:
        return None
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
    Returns:
        list: A list of all the recipe summaries dicts who use the given ingredient.
    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
        QueryExceptions.BadQueryException: If page is less than 1.
    """

    if id == 0:
        return None
    QueryHelpers.ensureIsNonNegative(limit)
    QueryHelpers.ensureIsPositive(page)
    with sessionInstance() as session:
        try:
            seenRecipeIDs = set()
            def haveNotSeenYet(recipeID):
                nonlocal seenRecipeIDs
                seen = recipeID in seenRecipeIDs
                seenRecipeIDs.add(recipeID)
                return seen

            ingredient = session.query(models.Ingredient).filter(models.Ingredient.id == id).one()
            return [ingredientInRecipe.recipe.summaryDict() for ingredientInRecipe in ingredient.recipes if not haveNotSeenYet(ingredientInRecipe.recipe_id)][limit * (page - 1): limit * page]
        except orm.exc.NoResultFound:
            return None

def getNumberOfIngredients():
    """Returns the number of ingredients.

    Returns:
       int: The number of ingredients in the database.
   """

    with sessionInstance() as session:
        return session.query(models.Ingredient).count() - 1
