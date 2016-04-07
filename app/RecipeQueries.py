from sqlalchemy import orm
from useDatabase import sessionInstance
import models
from enums import Cuisine
import QueryHelpers

def getAllRecipes(limit=10, page=1, **kwargs):
    """Gets all the recipes in the database, limiting the results to up to 'limit' results.

    Args:
        limit (Optional(int)): The upper-bound on the number of recipes to return. Defaults to 10. Must be positive.
        page (Optional(int)): The page for large datasets. Defaults to 1. Must be positive.
        **kwargs:
            cuisine (str): The cuisine to filter by. (e.g. 'mexican')
            diet (str): The dietary restriction for which a recipe must be compliant (e.g. vegan)

    Returns:
        list: A list of recipe summary dicts, up to 'limit' of them, filtered by the given kwargs (if any).

    Raises:
        QueryExceptions.BadQueryException: If limit is less than 0.
                                           If a kwarg is given that isn't 'cuisine' or 'diet'
    """

    QueryHelpers.ensureIsNonNegative(limit)
    QueryHelpers.ensureIsPositive(page)
    QueryHelpers.ensureDictOnlyContains(kwargs, 'cuisine', 'diet')
    with sessionInstance() as session:
        restrictions = []

        restrictions = {}
        if 'cuisine' in kwargs:
            restrictions['cuisine'] = Cuisine[kwargs['cuisine']].name

        if 'diet' in kwargs:
            diet = kwargs['diet']
            knownDietRestrictions = ['vegetarian', 'vegan', 'gluten_free', 'dairy_free']
            if not diet in knownDietRestrictions:
                raise BadQueryException()
            else:
                restrictions[diet] = True

        return [recipe.summaryDict() for recipe in session.query(models.Recipe).filter_by(**restrictions).slice(limit * (page - 1), limit * page).all()]

def getRecipeByID(id):
    """Gets the single recipe from the database, whose id matches the given id.

    Args:
        id (int): ID of the recipe.

    Returns:
        dict: The recipe's full dict with the given id if it exists, 'None' otherwise.
    """

    with sessionInstance() as session:
        try:
            return session.query(models.Recipe).filter(models.Recipe.id == id).one().fullDict()
        except orm.exc.NoResultFound:
            return None

def getRecipesByIngredients(ingredients):
    """Gets all recipes that contain the given ingredients.

    Args:
        ingredients (list): The list of ingredients, as strings, that each recipe returned must contain.

    Returns:
        list: A list of recipe summary dicts, where each recipe contains every ingredient in 'ingredients'.

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

        return [recipe.summaryDict() for recipe in recipes]

def getNumberOfRecipes():
    """Returns the number of recipes

    Returns:
       int: The number of recipes in the database.
   """

    with sessionInstance() as session:
        return session.query(models.Recipe).count()