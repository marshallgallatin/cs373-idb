from useDatabase import *
import json
import re

def convert(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def addRecipeFromSpoonacular(spoonacularResult):
    loadedJSON = json.loads(spoonacularResult)
    argumentDictionary = {convert(key):loadedJSON[key] for key in loadedJSON if (key in dir(Recipe) and key != 'id')}
    newRecipe = Recipe(**argumentDictionary)

    listOfExtractedIngredients = [ingredient for ingredient in loadedJSON['extendedIngredients']]
    listOfExtractedIngredientsNames = [ingredient['name'] for ingredient in listOfExtractedIngredients]
    knownIngredients = session.query(Ingredient).all()
    knownIngredientsNames = [ingredient.name for ingredient in knownIngredients]

    print(knownIngredientsNames)

    session.add(newRecipe)
    for index, extractedIngredient in enumerate(listOfExtractedIngredients):
        extractedIngredientName = extractedIngredient['name']

        argumentDictionary = {convert(key):extractedIngredient[key] for key in extractedIngredient if (convert(key) in dir(IngredientsInRecipes) and key != 'id')}
        ingredientInRecipe = IngredientsInRecipes(**argumentDictionary)
        ingredientInRecipe.ingredient_index = index
        ingredientInRecipe.recipe = newRecipe

        if extractedIngredientName in knownIngredientsNames:
            ingredientInRecipe.ingredient = [ingredient for ingredient in knownIngredients if ingredient.name == extractedIngredientName][0]
        else:
            # All we get for an ingredient from Spoonacular is the name
            ingredientInRecipe.ingredient = Ingredient(name = extractedIngredientName)
            session.add(ingredientInRecipe)

        session.add(ingredientInRecipe)
    session.commit()