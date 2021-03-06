#!/usr/bin/env python3

import re
from flask import Flask, jsonify, request, render_template
from flask_restful import reqparse, abort, Api, Resource
import requests
import RecipeQueries
import IngredientQueries
import SearchQueries
import SweetMusicQueries
import subprocess

app = Flask(__name__)

# ============================
# BEGIN RESTful API Implementation
# Uses flask_restful
api = Api(app)

list_recipe_parser = reqparse.RequestParser()
list_recipe_parser.add_argument('limit', type=int, help='The number of recipes to return. ERROR: {error_msg}')
list_recipe_parser.add_argument('cuisine', type=str, help='The Cuisine to filter by. ERROR: {error_msg}')
list_recipe_parser.add_argument('diet', type=str, help='The dietary restriction to filter by. ERROR: {error_msg}')
list_recipe_parser.add_argument('page', type=int, help='Which page of recipes to return. ERROR: {error_msg}')

class ListRecipes(Resource):
    """
    Implements the Recipe Collection [/recipes{?page,limit,cuisine,diet] RESTful API entry point.
    """
    def get(self):
        parsed_args = list_recipe_parser.parse_args()
        filtered_args = {k : parsed_args[k] for k in parsed_args if parsed_args[k] is not None }
        return jsonify(recipes = RecipeQueries.getAllRecipes(**filtered_args))

class CountRecipes(Resource):
    """
    Count of Recipes [/recipes/count]
    """
    def get(self):
        return jsonify(count = RecipeQueries.getNumberOfRecipes())

class RecipeByID(Resource):
    """
    Recipe [/recipes/{id}]
    """
    def get(self, rec_id):
        return jsonify(**(RecipeQueries.getRecipeByID(rec_id)))

search_recipe_parser = reqparse.RequestParser()
search_recipe_parser.add_argument('ingredients', type=str, required=True, help='A list of ingredients that a recipe must contain. ERROR: {error_msg}')

class SearchRecipesByIngredients(Resource):
    """
    Search Recipes by Ingredients [/recipes/ingredientSearch{?ingredients}]
    """
    def get(self):
        return jsonify(recipes = RecipeQueries.getRecipesByIngredients(search_recipe_parser.parse_args()['ingredients'].split(sep=',')))

list_ingredient_parser = reqparse.RequestParser()
list_ingredient_parser.add_argument('limit', type=int, help='The number of ingredients to return. ERROR: {error_msg}')
list_ingredient_parser.add_argument('page', type=int, help='Which page of ingredients to return. ERROR: {error_msg}')

class ListIngredients(Resource):
    """
    Ingredient Collection [/ingredients{?page,limit}]
    """
    def get(self):
        parsed_args = list_ingredient_parser.parse_args()
        filtered_args = {k : parsed_args[k] for k in parsed_args if parsed_args[k] is not None }
        return jsonify(ingredients = IngredientQueries.getAllIngredients(**filtered_args))

class CountIngredients(Resource):
    """
    Count of Ingredients [ingredients/count]
    """
    def get(self):
        return jsonify(count = IngredientQueries.getNumberOfIngredients())

class IngredientByID(Resource):
    """
    Ingredient [/ingredients/{id}]
    """
    def get(self, ingred_id):
        return jsonify(**(IngredientQueries.getIngredientByID(ingred_id)))

class NutritionInformationByIngredientID(Resource):
    """
    Nutrition Information [/ingredients/{id}/nutrition]
    """
    def get(self, ingred_id):
        return jsonify(**(IngredientQueries.getNutritionalInformationFromIngredientByID(ingred_id)))

recipes_by_ingredient_id_parser = reqparse.RequestParser()
recipes_by_ingredient_id_parser.add_argument('limit', type=int, help='The number of recipes to return. ERROR: {error_msg}')
recipes_by_ingredient_id_parser.add_argument('page', type=int, help='Which page of recipes to return. ERROR: {error_msg}')

class LookupRecipesByIngredientID(Resource):
    """
    Recipes ingredient is in [/ingredients/{id}/recipes{?page,limit}]
    """
    def get(self, ingred_id):
        parsed_args = recipes_by_ingredient_id_parser.parse_args()
        filtered_args = {k : parsed_args[k] for k in parsed_args if parsed_args[k] is not None }
        return jsonify(recipes = IngredientQueries.getRecipesUsingIngredientById(ingred_id, **filtered_args))

search_parser = reqparse.RequestParser()
search_parser.add_argument('keywords', type=str, required=True, help='A list of keywords to search on. ERROR: {error_msg}')

class SearchTEST(Resource):
    """
    Search keywords [/searchTEST{?keywords}]
    """
    def get(self):
        parsed_args = search_parser.parse_args()
        return jsonify(SearchQueries.search(parsed_args['keywords'].split(sep=' ')))

api.add_resource(ListRecipes, '/recipes')
api.add_resource(CountRecipes, '/recipes/count')
api.add_resource(RecipeByID, '/recipes/<int:rec_id>')
api.add_resource(SearchRecipesByIngredients, '/recipes/ingredientSearch')
api.add_resource(ListIngredients, '/ingredients')
api.add_resource(CountIngredients, '/ingredients/count')
api.add_resource(IngredientByID, '/ingredients/<int:ingred_id>')
api.add_resource(NutritionInformationByIngredientID, '/ingredients/<int:ingred_id>/nutrition')
api.add_resource(LookupRecipesByIngredientID, '/ingredients/<int:ingred_id>/recipes')
api.add_resource(SearchTEST, '/searchTEST')

# END RESTful API Implementation
# ============================

@app.route("/")
@app.route("/index.html")
def splash():
	return render_template('index.html', title="Home", indexlit="active")

@app.route('/about.html')
def about():
	return render_template('about.html', title="About", aboutlit="active")

@app.route('/search', methods=['GET'])
def search():
	return render_template('search.html', title=request.args.get('q'), testprefix="//")

@app.route('/query', methods=['GET'])
def query():
	return jsonify(
	{
		"results": [
			{
				"type": "recipe",
				"cuisine": "african",
				"id": 2,
				"image_uri": "https://spoonacular.com/recipeImages/Ethiopian-Lentil-Curry-642468.jpg",
				"ready_in_minutes": 75,
				"servings": 6,
				"title": "Ethiopian Lentil Curry",
				"snippet": "Place the bull <b>test</b>icle in the boi"
			},
			{
				"type": "ingredient",
				"id": 789,
				"image_uri": "https://upload.wikimedia.org/wikipedia/commons/d/d0/BlackEyedPeas.JPG",
				"name": "black-eyed pea",
				"origin": "Africa",
				"scientific_name": "Vigna unguiculata subsp. unguiculata",
				"snippet": "Used in <b>Unit Test</b> Soup"
			}
		],
		"count": 12
	})

@app.route('/recipe.html')
@app.route('/recipe_<int:r_id>.html')
def recipe(r_id="test"):
	return render_template('recipe.html', rec_id=r_id, recipeslit="active")

@app.route('/ingredient.html')
@app.route('/ingredient_<int:i_id>.html')
def ingredient(i_id="test"):
	return render_template('ingredient.html', i_id=i_id, ingredientslit="active")

@app.route('/recipes.html')
def recipes():
	return render_template('recipes.html', title="Recipes", recipeslit="active", testprefix="//")

@app.route('/ingredients.html')
def ingredients():
	return render_template('ingredients.html', title="Ingredients", ingredientslit="active", testprefix="//")

@app.route("/<path:path>")
def static_html(path):
	return app.send_static_file('html/{}'.format(path))

@app.route("/unittest")
def unittest():
	return subprocess.getoutput('python3 tests.py -v')

@app.route("/sweetmusic.html")
def sweetmusic():
	major_lazer_id = '738wLrAtLtCtFOLvQBXOXp'
	tree = SweetMusicQueries.buildArtistTree(major_lazer_id, 2)
	tree['root'] = True
	return render_template('sweetmusic.html', title="SweetMusic", json=tree)

############  WEBSITE TEST ENTRY POINTS ###########
# These will be used as unit tests run locally
###################################################
@app.route("/r")
@app.route("/r<int:page>")
def test_recipes(page=0):
	"""
	Taken on 4/8/16 from http://swedishchef.me/recipes?limit=2

	Used for templates/recipes.html
	"""
	return jsonify(
	{
		"recipes": [
			{
				"cuisine": "african",
				"id": 1+page,
				"image_uri": "https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg",
				"ready_in_minutes": 45,
				"servings": 4,
				"title": "African Bean Soup"
			},
			{
				"cuisine": "african",
				"id": 2,
				"image_uri": "https://spoonacular.com/recipeImages/Ethiopian-Lentil-Curry-642468.jpg",
				"ready_in_minutes": 75,
				"servings": 6,
				"title": "Ethiopian Lentil Curry"
			}
		]
	})

@app.route('/recipes/test')
def test_recipe_query():
	"""
	Taken on 4/8/16 from http://swedishchef.me/recipes/1

	Used for /recipe.html
	"""
	return jsonify(
	{
		"cuisine": "african",
		"dairy_free": True,
		"gluten_free": True,
		"image_uri": "https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg",
		"ingredients": [
			{
			"amount": 2.0,
			"id": 0,
			"original_string": "2 cups dried black-eyed peas",
			"unit": "cups"
			},
			{
			"amount": 2.0,
			"id": 2,
			"original_string": "2 cups sliced carrots",
			"unit": "cups"
			},
			{
			"amount": 1.0,
			"id": 3,
			"original_string": "1 cup green pepper, diced",
			"unit": "cup"
			}
		],
		"instructions": "<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>",
		"ready_in_minutes": 45,
		"servings": 4,
		"title": "African Bean Soup",
		"vegan": True,
		"vegetarian": True
	})

@app.route('/ingredients/test')
def test_ingredient_query():
	"""
	Taken on 4/8/16 from http://swedishchef.me/ingredients/1

	Used for /ingredient.html
	"""
	return jsonify(
	{
		"image_uri": "https://upload.wikimedia.org/wikipedia/commons/d/d0/BlackEyedPeas.JPG",
		"name": "black-eyed pea",
		"origin": "Africa",
		"scientific_name": "Vigna unguiculata subsp. unguiculata"
	})

@app.route('/ingredients/list')
def test_ingredient_list_query():
	"""
	Taken on 4/8/16 from http://swedishchef.me/ingredients?limit=3

	Used for /ingredients.html
	"""
	return jsonify(
	{
		"ingredients": [
			{
				"id": 1,
				"name": "black-eyed pea"
			},
			{
				"id": 2,
				"name": "carrot"
			},
			{
				"id": 3,
				"name": "green bell pepper"
			}]
	})

@app.route('/ingredients/test/recipes')
def test_ingredient_recipes_query():
	"""
	Taken on 4/8/16 from http://swedishchef.me/ingredients/1/recipes

	Used for /ingredients.html
	"""
	return jsonify(
	{
		"recipes": [
			{
				"cuisine": "african",
				"id": 1,
				"image_uri": "https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg",
				"ready_in_minutes": 45,
				"servings": 4,
				"title": "African Bean Soup"
			}
		]
	})

@app.route('/ingredients/test/nutrition')
def test_ingredient_nutrition_query():
	"""
	Taken on 4/8/16 from http://swedishchef.me/ingredients/1/nutrition

	Used for /ingredients.html
	"""
	return jsonify(
	{
		"calcium_mg": 110,
		"calories": 336,
		"cholesterol_mg": 0,
		"dietary_fiber_g": 10.6,
		"iron_mg": 8.27,
		"protein_g": 23.52,
		"saturated_fat_g": 0.331,
		"sodium_mg": 16,
		"sugar_g": 6.9,
		"total_carbohydrates_g": 60.03,
		"total_fat_g": 1.26,
		"vitamin_a_iu": 50,
		"vitamin_c_mg": 1.5
	})

############ END WEBSITE TEST ENTRY POINTS ###########

@app.route('/favicon.ico')
def favicon():
	return send_from_directory(os.path.join(app.root_path, 'static'),
		'favicon.ico', mimetype='image/vnd.microsoft.icon')

@app.errorhandler(404)
def page_not_found(error):
	return render_template('404.html', error=error)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
