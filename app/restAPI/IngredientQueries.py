from useDatabase import sessionInstance
from models import Recipe, Ingredient, NutritionalContent, IngredientsInRecipes
from enums import Cuisine

def getAllIngredients(limit=10):
    """
    ...
    """

    with sessionInstance() as session:
        return session.query(Ingredient).limit(limit).all()

def getIngredientByID(id):
    """
    ...

    arguments:
        id (int): ID of the recipe.
    """
    with sessionInstance() as session:
        result = session.query(Ingredient).filter(Recipe.id = id).one()