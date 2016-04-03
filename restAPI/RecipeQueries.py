import sys, os
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), os.pardir))
from sqlalchemy import orm
from useDatabase import sessionInstance
import models
from enums import Cuisine
import QueryHelpers

def getAllRecipes(limit=10, **kwargs):
    """Gets all the recipes in the database, limiting the results to up to 'limit' results.

    Args:
        limit (Optional(int)): The uppoer-bound on the number of recipes to return. Defaults to 10. Must be positive.
        **kwargs:
            cuisine (str): The cuisine to filter by. (e.g. 'mexican')
            diet (str): The dietary restriction for which a recipe must be compliant (e.g. vegan)

    Returns:
        list: A list of recipe objects, up to 'limit' of them, filtered by the given kwargs (if any).

    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
                                           If a kwarg is given that isn't 'cuisine' or 'diet'
    """

    QueryHelpers.ensureIsNonNegative(limit)
    QueryHelpers.ensureDictOnlyContains(kwargs, 'cuisine', 'diet')
    with sessionInstance() as session:
        restrictions = []

        restrictions = {}
        if 'cuisine' in kwargs:
            restrictions['cuisine'] = Cuisine[kwargs['cuisine']]

        if 'diet' in kwargs:
            diet = kwargs['diet']
            knownDietRestrictions = ['vegetarian', 'vegan', 'gluten_free', 'dairy_free']
            if not diet in knownDietRestrictions:
                raise BadQueryException()
            else:
                restrictions[diet] = True

        return session.query(models.Recipe).filter_by(**restrictions).limit(limit).all()

def getRecipeByID(id):
    """Gets the single recipe from the database, whose id matches the given id.

    Args:
        id (int): ID of the recipe.

    Retuns:
        Recipe: The recipe with the given id if it exists, 'None' otherwise.
    """

    with sessionInstance() as session:
        try:
            return session.query(models.Recipe).filter(models.Recipe.id == id).one()
        except orm.exc.NoResultFound:
            return None

def getRecipesByIngredients(ingredients):
    """Gets all recipes that contain the given ingredients.

    Args:
        ingredients (list): The list of ingredients, as strings, that each recipe returned must contain.

    Retuns:
        list:  A list of recipe objects, where each recipe contains every ingredient in 'ingredients'.

    Raises:
        QueryExceptions.BadQueryException: If 'ingredients' is empty.
    """

    QueryHelpers.ensureListIsntEmpty(ingredients)
    lowercaseIngredients = [i for i in map(lambda x:x.lower(), ingredients)]
    with sessionInstance() as session:
        allIngredientsInRecipes = session.query(models.IngredientsInRecipes).all()

        filteredIngredientsInRecipes = filter(lambda x: x.ingredient.name.lower() in lowercaseIngredients, allIngredientsInRecipes)

        # The following makes the assumption that ingredient names are unique (which is enforced by the Ingredients model)
        recipes = []
        counts = {}
        for ingredientInRecipe in filteredIngredientsInRecipes:
            if ingredientInRecipe.recipe_id in counts:
                counts[ingredientInRecipe.recipe_id] = counts[ingredientInRecipe.recipe_id] + 1
                assert counts[ingredientInRecipe.recipe_id] <= len(ingredients)
            else:
                counts[ingredientInRecipe.recipe_id] = 1

            if counts[ingredientInRecipe.recipe_id] == len(ingredients):
               recipes.append(ingredientInRecipe.recipe)

        return recipes
