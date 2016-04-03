from sqlalchemy import orm
from useDatabase import *
import models
from enums import Cuisine
import QueryHelpers

def getAllIngredients(limit=10):
    """Gets all the ingredients in the database, limiting the results to up to 'limit' results.

    Args:
        limit (Optional(int)): The uppoer-bound on the number of ingredients to return. Defaults to 10. Must be positive.

    Returns:
        list: A list of ingredient objects, up to 'limit' of them.

    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
    """

    QueryHelpers.ensureIsNonNegative(limit)
    with sessionInstance() as session:
        return session.query(models.Ingredient).limit(limit).all()

def getIngredientByID(id):
    """Gets the single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Retuns:
        Ingredient: The ingredient with the given id if it exists, 'None' otherwise.
    """

    with sessionInstance() as session:
        try:
            return session.query(models.Ingredient).filter(models.Ingredient.id == id).one()
        except orm.exc.NoResultFound:
            return None


def getNutritionalInformationFromIngredientByID(id):
    """Gets the nutritional information from a single ingredient from the database, whose id matches the given id.

    Args:
        id (int): ID of the ingredient.

    Retuns:
        NutritionalInformation: The nutritional information of the ingredient with the given id if it exists, 'None' otherwise.
                                Note: 'None' can be returned if the ingredient doesn't exist, or if the ingredient doesn't have nutritional information.
    """

    ingredient = getIngredientByID(id)
    return None if ingredient is None else ingredient.nutritional_content
