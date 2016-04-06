#!/usr/bin/env python3

import re
from flask import Flask, jsonify, request, render_template
from flask_restful import reqparse, abort, Api, Resource
import RecipeQueries
from jsonifyModels import jsonifyQueryResult

app = Flask(__name__)
api = Api(app)

list_recipe_parser = reqparse.RequestParser()
list_recipe_parser.add_argument('limit', type=int, help='The number of recipes to return. ERROR: {error_msg}')
list_recipe_parser.add_argument('cuisine', type=str, help='The Cuisine to filter by. ERROR: {error_msg}')
list_recipe_parser.add_argument('diet', type=str, help='The dietary restriction to filter by. ERROR: {error_msg}')

class ListRecipes(Resource):
    """ 
    Implements the Recipe Collection [/recipes{?limit,cuisine,diet}] RESTful API entry point.
    """
    def get(self):
        rlist = []
        parsed_args = list_recipe_parser.parse_args()
        filtered_args = {k : parsed_args[k] for k in parsed_args if parsed_args[k] is not None }
        for r in RecipeQueries.getAllRecipes(**filtered_args):
            rlist.append(dict({"id": r.id, "title": r.title, "image_uri":r.image_uri, "cuisine": r.cuisine, "ready_in_minutes": r.ready_in_minutes, "servings": r.servings}))
        return jsonify({"recipes": rlist})
        
class RecipeByID(Resource):
    """
    Recipe [/recipes/{id}]
    """
    def get(self, rec_id):
        recipe = RecipeQueries.getRecipeByID(rec_id)
        recipe_dict = { 
            "id": recipe.id,
            "title": recipe.title,
            "ingredients": [
                "TODO: JSONFIY INGREDIENTS"
            ],
            "image_uri": recipe.image_uri,
            "instructions": recipe.instructions,
            "cuisine": recipe.cuisine,
            "ready_in_minutes": recipe.ready_in_minutes,
            "servings": recipe.servings,
            "vegetarian": recipe.vegetarian,
            "vegan": recipe.vegan,
            "gluten_free": recipe.gluten_free,
            "dairy_free": recipe.dairy_free
        }
        return jsonify(recipe_dict)
        
api.add_resource(ListRecipes, '/recipes')
api.add_resource(RecipeByID, '/recipes/<int:rec_id>')

@app.route("/")
def splash():
    return app.send_static_file('html/index.html')

@app.route("/<path:path>")
def static_html(path):
    return app.send_static_file('html/{}'.format(path))

############  WEBSITE TEST ENTRY POINTS ###########
# These are temporary and just so that web development can begin
# while we nail down getting the database working and api implemented
@app.route("/dbdump")
def dump_database():
    rlist = []
    for r in RecipeQueries.getAllRecipes():
        rlist.append(dict({"id": r.id, "title": r.title, "image_uri":r.image_uri, "cuisine": r.cuisine, "ready_in_minutes": r.ready_in_minutes, "servings": r.servings}))
    return jsonify({"recipes": rlist})

@app.route("/test/recipes")
def test_recipes():
    testdict = { "recipes": [
        {
            "id": 1,
            "title": "Jambalaya",
            "image_uri": "https://spoonacular.com/recipeImages/Jambalaya-648427.jpg",
            "cuisine": "cajun",
            "ready_in_minutes": 45,
            "servings": 10
        },
        {
            "id": 2,
            "title": "Second Recipe",
            "image_uri": "https://spoonacular.com/recipeImages/Jambalaya-648427.jpg",
            "cuisine": "italian",
            "ready_in_minutes": 25,
            "servings": 11
        }
    ]}
    return jsonify(testdict)

"""
Copied from  cs373-idb/db/scraped_data/recipes/african/african632003.json

-----------------------------------------
{"vegetarian": true,
"glutenFree": true,
"title": "African Bean Soup",
"veryPopular": false,
"gaps": "no",
"sourceUrl": "http://www.foodista.com/recipe/5WXW6JDS/african-bean-soup",
"sourceName": "Foodista",
"vegan": true,
"sustainable": false,
"instructions": "<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>",
"aggregateLikes": 1,
"dairyFree": true,
"extendedIngredients": [
	{"aisle": "Canned and Jarred",
		"unitLong": "cups",
		"amount": 2.0,
		"unitShort": "c",
		"metaInformation": [],
		"unit": "cups",
		"originalString": "2 cups dried black-eyed peas",
		"name": "black eyed peas"},
	{"aisle": "Produce",
		"unitLong": "cups",
		"amount": 2.0,
		"unitShort": "c",
		"metaInformation": [],
		"unit": "cups",
		"originalString": "2 cups sliced carrots",
		"name": "carrots"},
	{"aisle": "Produce",
		"unitLong": "cup",
		"amount": 1.0,
		"unitShort": "c",
		"metaInformation": [],
		"unit": "cup",
		"originalString": "1 cup green pepper,
		diced",
		"name": "green pepper"},
	{"aisle": "Produce",
		"unitLong": "cups",
		"amount": 0.5,
		"unitShort": "c",
		"metaInformation": [],
		"unit": "cup",
		"originalString": "1/2 cup chopped onion",
		"name": "onion"},
	{"aisle": "Nut butters,
		Jams,
		and Honey",
		"unitLong": "tablespoons",
		"amount": 2.0,
		"unitShort": "T",
		"metaInformation": [],
		"unit": "tablespoons",
		"originalString": "2 tablespoons peanut butter",
		"name": "peanut butter"},
	{"aisle": "Spices and Seasonings",
		"unitLong": "teaspoons",
		"amount": 0.75,
		"unitShort": "t",
		"metaInformation": [],
		"unit": "teaspoon",
		"originalString": "3/4 teaspoon salt",
		"name": "salt"},
	{"aisle": "Beverages",
		"unitLong": "milliliters",
		"amount": 150.0,
		"unitShort": "ml",
		"metaInformation": [],
		"unit": "ml",
		"originalString": "150 ml water",
		"name": "water"}],
"readyInMinutes": 45,
"ketogenic": false,
"veryHealthy": true,
"cheap": false,
"creditText": "Foodista.com \u2013 The Cooking Encyclopedia Everyone Can Edit",
"license": "CC BY 3.0",
"spoonacularSourceUrl": "https://spoonacular.com/african-bean-soup-632003",
"weightWatcherSmartPoints": 4,
"id": 632003,
"image": "https://spoonacular.com/recipeImages/African-Bean-Soup-632003.jpg",
"servings": 4,
"whole30": false,
"lowFodmap": false}
"""
@app.route('/recipe.html')
@app.route('/recipe_<r_id>.html')
def recipe(r_id=None):
	store = {"id":"1",
	"instructions":"<ol><li>Saute onions in large pot until soft. Add all ingredients except for peanut butter and simmer for 1 1/2 hours. </li><li>Stir a spoonful of peanut butter into each serving.</li></ol>", 
	"ingredients":["a","<b>b</b>"], 
	"test_ingred":"1 teaspoon <a href=\"/2044.html\">basil</a>",
	"ingred":4, 
	"title":"Jamba", 
	"recipeslit":"active", 
	"img_uri":"https://webknox.com/recipeImages/648427-556x370.jpg"}
	split_ingredients(store)
	split_instructions(store)
	return render_template('recipe.html', **store)

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
	"ingredientslit":"active", 
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
	return render_template('ingredient.html', i_id=i_id, **store)

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
