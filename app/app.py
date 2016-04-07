#!/usr/bin/env python3

import re
from flask import Flask, jsonify, request, render_template
from flask_restful import reqparse, abort, Api, Resource
import RecipeQueries
import IngredientQueries
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

api.add_resource(ListRecipes, '/recipes')
api.add_resource(RecipeByID, '/recipes/<int:rec_id>')
api.add_resource(SearchRecipesByIngredients, '/recipes/ingredientSearch')
api.add_resource(ListIngredients, '/ingredients')
api.add_resource(IngredientByID, '/ingredients/<int:ingred_id>')
api.add_resource(NutritionInformationByIngredientID, '/ingredients/<int:ingred_id>/nutrition')
api.add_resource(LookupRecipesByIngredientID, '/ingredients/<int:ingred_id>/recipes')

# END RESTful API Implementation
# ============================

@app.route("/")
def splash():
    return render_template('index.html', title="Home", indexlit="active")

@app.route('/about.html')
def about():
	return render_template('about.html', title="About", aboutlit="active")

@app.route('/recipes.html')
def recipes():
	return render_template('recipes.html', title="Recipes", recipeslit="active")

@app.route("/<path:path>")
def static_html(path):
    return app.send_static_file('html/{}'.format(path))

@app.route("/unittest")
def unittest():
    out = subprocess.getoutput('python3 tests.py -v')
    return out

############  WEBSITE TEST ENTRY POINTS ###########
# These are temporary and just so that web development can begin
# while we nail down getting the database working and api implemented
@app.route("/dbdump")
def dump_database():
    rlist = []
    for r in RecipeQueries.getAllRecipes():
        rlist.append(dict({"id": r.id, "title": r.title, "image_uri":r.image_uri, "cuisine": r.cuisine, "ready_in_minutes": r.ready_in_minutes, "servings": r.servings}))
    return jsonify({"recipes": rlist})

@app.route("/r")
@app.route("/recipestest\?limit=2&page=1")
def test_recipes():
    testdict = {
  "recipes": [
    {
      "cuisine": "african",
      "id": 1,
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
}
    return jsonify(testdict)

@app.route('/test/r')
def test_r():
	return jsonify({
  "cuisine": "african",
  "dairy_free": True,
  "gluten_free": True,
  "image_uri": "https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg",
  "ingredients": [
    {
      "amount": 2.0,
      "id": 1,
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
    },
    {
      "amount": 1.0,
      "id": 4,
      "original_string": "1 large chopped onion",
      "unit": "cup"
    },
    {
      "amount": 4.0,
      "id": 5,
      "original_string": "peanut butter",
      "unit": "tablespoon"
    },
    {
      "amount": 0.75,
      "id": 6,
      "original_string": "3/4 teaspoon salt",
      "unit": "teaspoon"
    },
    {
      "amount": 6.0,
      "id": 7,
      "original_string": "6 cups water",
      "unit": "cups"
    }
  ],
  "instructions": "<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>",
  "ready_in_minutes": 45,
  "servings": 4,
  "title": "African Bean Soup",
  "vegan": True,
  "vegetarian": True
})

@app.route('/recipe.html')
@app.route('/recipe_<r_id>.html')
def recipe(r_id=None):
	store = {"id":"1",
	"instructions":"<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>",
	"ingredients":["a","<b>b</b>"],
	"test_ingred":"1 teaspoon <a href=\"/2044.html\">basil</a>",
	"ingred":4,
	"title":"Jamba",
	"img_uri":"https://webknox.com/recipeImages/648427-556x370.jpg"}
	split_ingredients(store)
	split_instructions(store)
	return render_template('recipe.html', recipeslit="active", **store)

def split_ingredients(d):
	l = d["ingredients"]
	halfI = (len(l) + 1) // 2
	d["ingredients1"] = l[0:halfI]
	d["ingredients2"] = l[halfI:len(l)]

def split_instructions(d):
	s = d["instructions"].replace("<ol><li>", "").replace("</li></ol>", "")
	d["instructions"] = re.compile("\s?</li><li>").split(s)

@app.route('/ingredient.html')
@app.route('/ingredient_<i_id>.html')
def ingredient(i_id=None):
	store = {"id":"1",
	"title":"Fresh Basil",
	"size":"1 egg",
	"calories":"171",
	"total_fat":"11.88g",
	"sat_fat":"3.632",
	"cholesterol":"933",
	"sodium":"151mg",
	"total_carb":"1.15",
	"fiber":"0g",
	"sugar":"NA",
	"protein":"13.68g",
	"vit_a":"554 IU",
	"vit_c":"0%",
	"calcium":"99%",
	"iron":"4.1%",
	"place":"30.2849185,-97.73624",
	"img_uri":"http://www.essentialoilspedia.com/wp-content/uploads/basil_plant.jpg"}
	return render_template('ingredient.html', i_id=i_id, ingredientslit="active", **store)

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
