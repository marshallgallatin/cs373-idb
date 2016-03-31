from useDatabase import sessionInstance
from models import Recipe, Ingredient, NutritionalContent, IngredientsInRecipes
from enums import Cuisine

class BadQueryException(Exception):
    pass

##### HELPERS #####
def ensureDictOnlyContains(dictionary, *args):
    if len(set(dictionary.keys()) - set(args)) != 0:
        raise BadQueryException()

def ensureDictExactlyContains(dictionary, *args):
    if len(set(dictionary.keys()) ^ set(args)) != 0:
        raise BadQueryException()

def getAllRecipes(limit=10, **kwargs):
    """
    Gets all the recipes in the databse, limiting the results to up to limit results.
    (With 10 being the default).

    kwargs:
        cuisine (str): The cuisine to filter by. (e.g. 'mexican')
        diet (str): The dietary restriction for which a recipe must be compliant (e.g. vegan)
    """

    ensureDictOnlyContains(kwargs, 'cuisine', 'diet')
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

        return session.query(Recipe).filter_by(**restrictions).limit(limit).all()

def getRecipeByID(id):
    """
    ...

    arguments:
        id (int): ID of the recipe.
    """
    with sessionInstance() as session:
        result = session.query(Recipe).filter(Recipe.id = id).one()

def getFilteredRecipes(actionBody):
    """
    ...

    """

    ensureDictExactlyContains(actionBody, 'action_type', 'vegetarian', 'vegan', 'gluten_free', 'dairy_free')
    with sessionInstance() as session:
        return session.query(Recipe).
            filter
            (
                Recipe.vegetarian  == actionBody['vegetarian'],
                Recipe.vegan       == actionBody['vegan'],
                Recipe.gluten_free == actionBody['gluten_free'],
                Recipe.dairy_free  == actionBody['dairy_free']
            ).all()

def getRecipesByIngredients(ingredients):
    """
    ...

    """
    lowercaseIngredients = map(lambda x:x.lower(), ingredients)
    with sessionInstance() as session:
        allIngredientsInRecipes = session.query(Ingredients).all()

        filteredIngredientsInRecipes = filter(lambda x: x.ingredient.name.lower() in lowercaseIngredients, allIngredientsInRecipes)

        # The following makes the assumption that ingredient names are unique (which is enforced by the Ingredients model)
        recipes = []
        counts = {}
        for ingredientInRecipe in filteredIngredientsInRecipes:
            if ingredientInRecipe.recipe_id in counts:
                counts[ingredientInRecipe.recipe_id] = counts[ingredientInRecipe.recipe_id] + 1
                assert counts[ingredientInRecipe.recipe_id] <= len(ingredients)
                if counts[ingredientInRecipe.recipe_id] == len(ingredients):
                   recipes.append(ingredientInRecipe.recipe)
            else
                counts[ingredientInRecipe.recipe_id] = 10

        return recipes
