#!/usr/bin/env python3

from flask import Flask, jsonify
app = Flask(__name__)

@app.route("/")
def splash():
    return app.send_static_file('html/index.html')

@app.route("/<path:path>")
def static_html(path):
    return app.send_static_file('html/{}'.format(path))

############  WEBSITE TEST ENTRY POINTS ###########
# These are temporary and just so that web development can begin
# while we nail down getting the database working and api implemented
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
    
@app.route("/test/recipes/1")
def test_recipe():
    testdict = {
        "id": 1,
        "title": "Jambalaya",
        "ingredients": [
            {
                "id": 1,
                "name": "basil",
                "amount": 1,
                "unit": "teaspoon",
                "original_string": "1 teaspoon basil"
            },
            {
                "id": 2,
                "name": "bay leaf",
                "amount": 1,
                "unit": "",
                "originalString": "1 Bay leaf"
            },
            {
                "id": 3,
                "name": "canned tomato sauce",
                "amount": 8,
                "unit": "ounces",
                "originalString": "8 ounces can tomato sauce"
            }
        ],
        "image_uri": "https://spoonacular.com/recipeImages/Jambalaya-648427.jpg",
        "instructions": "1. Brown sausage. blacken fish with pepper and paprika. Brown in hot skillet. Saute onion, celery, green pepper, garlic until limp. Add stock and tomato sauce, spices, vegetable and meats to crock pot or large stock pot; boil for 1 hour on low or crock pot until done.",
        "cuisine": "cajun",
        "ready_in_minutes": 45,
        "servings": 10,
        "vegetarian": False,
        "vegan": False,
        "gluten_free": True,
        "dairy_free": True
    }
    return jsonify(testdict)
############ END WEBSITE TEST ENTRY POINTS ###########


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
