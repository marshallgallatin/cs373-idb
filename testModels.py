from models import Recipe, Ingredient, NutritionalContent, IngredientsInRecipes

specialID = -1
testModelEntry = lambda modelType: lambda **kwargs : modelType(id = specialID, **kwargs)

TestRecipe = testModelEntry(Recipe)
TestIngredient = testModelEntry(Ingredient)
TestNutritionalContent = testModelEntry(NutritionalContent)
TestIngredientsInRecipes = IngredientsInRecipes