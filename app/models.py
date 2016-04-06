from sqlalchemy import Column, ForeignKey, Integer, Float, String, Table, Interval, Enum, Boolean, CheckConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from enums import enumToTuple, Continent, Cuisine
from constraints import isPercentage, isNonnegative, isNotNull
from utility import getColumnNamesInDeclarationOrder, renameKeyInDict

Base = declarative_base()

class Recipe(Base):
    """The Recipe Table
    The Recipe table has entries for each Recipe with the following attributes:

    Required Attributes:
        title (str): The title of the recipe.

    Relational Attributes:
        ingredients (IngredientsInRecipes): A list of IngredientsInRecipes objects that apply to this recipe.
            The relevant information for this object is everything but 'recipe', since 'recipe' will refer
            to this object.

    Optional Attributes:
        image_uri (str): The URI of the image for this recipe.
        instructions (str): The instructions for the recipe as a str.
        cuisine (str): The region where the recipe originates from.
        ready_in_minutes (int): The sum of preparationMinutes and cookingMinutes, if given.
        servings (int): The amount of food made by recipe, where one serving is enough to feed one person.
        vegetarian (bool): False if meat is an ingredient, True otherwise
        vegan (bool): False if an animal product is an ingredient, True otherwise.
        gluten_free (bool): False if an ingredient contains Gluten, True otherwise.
        dairy_free (bool): False if an ingredient contains dairy products, True otherwise.

    Single Column Constraints:
        None.

    Table Constraints:
        - A recipe can't be vegan and not vegetarian, assuming both are not None.
        - A recipe can't be vegan, and not dairy_free, assuming both are not None.
    """
    __tablename__ = 'Recipe'

    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)

    ingredients = relationship('IngredientsInRecipes', back_populates ='recipe')

    image_uri    = Column(String, nullable=True)
    instructions = Column(String, nullable=True) #@TODO: Make this cleaner/formatted
    cuisine      = Column(Enum(*enumToTuple(Cuisine), name='Cuisine'), nullable=True)

    ready_in_minutes    = Column(Integer, nullable=True) # Add constaint
    servings            = Column(Integer, nullable=True) # Add constaint

    vegetarian  = Column(Boolean, nullable=True)
    vegan       = Column(Boolean, nullable=True)
    gluten_free = Column(Boolean, nullable=True)
    dairy_free  = Column(Boolean, nullable=True)

    CheckConstraint('NOT ((vegan IS NOT NULL AND vegetarian IS NOT NULL) AND (vegan AND NOT vegetarian))')
    CheckConstraint('NOT ((vegan IS NOT NULL AND dairy_free IS NOT NULL) AND (vegan AND NOT dairy_free))')

    def summaryDict(self):
        """ A helper function that returns a dictionary representation of a Recipe, but only with a subset of information.

        Returns:
            dict: A dictionary with the names of a subset of columns as keys, and the value of column as the values.
        """
        summaryKeys = ['id', 'title', 'image_uri', 'cuisine', 'ready_in_minutes', 'servings']
        selfAsDict = self.__dict__
        return {key:selfAsDict[key] for key in summaryKeys}

    def fullDict(self):
        """ A helper function that returns a dictionary representation of a Recipe.
        NOTE: MUST be called while the session is still open!

        Returns:
            dict: A dictionary with the names of each column as keys, and the value of column as the values.
                  For 'ingredients', the value is a list of dictionaries, where each dictionary is a 'massaged' representation of an IngredientsInRecipes's fullDict(). (see massageIngredientInRecipeDict()
        """
        columnKeys = getColumnNamesInDeclarationOrder(Recipe)
        columnKeys.remove('id')
        selfAsDict = self.__dict__
        returnDict = {key:selfAsDict[key] for key in columnKeys}

        unsortedIngredientsInRecipes = [ingredientInRecipe.fullDict() for ingredientInRecipe in self.ingredients]
        ingredientsInRecipesIndeces = [ingredientInRecipe.ingredient_index for ingredientInRecipe in self.ingredients]
        sortedIngredientsInRecipes = [unsortedIngredientsInRecipes[index] for index in ingredientsInRecipesIndeces]

        def massageIngredientInRecipeDict(ingredientInRecipeDict):
            del ingredientInRecipeDict['recipe_id']
            del ingredientInRecipeDict['ingredient_index']
            del ingredientInRecipeDict['unit_short']
            renameKeyInDict('ingredient_id', 'id', ingredientInRecipeDict)
            return ingredientInRecipeDict

        returnDict['ingredients'] = [massageIngredientInRecipeDict(ingredientInRecipe) for ingredientInRecipe in sortedIngredientsInRecipes]
        return returnDict

class Ingredient(Base):
    """The Ingredient Table
    The Ingredient table has entries for an ingredient.

    Required Attributes:
        name (str): The name of the ingredient.

    Relational Attributes:
        recipes (IngredientsInRecipes): A list of IngredientsInRecipes objects that apply to this ingredient.
            The relevant information for this object is everything but 'ingredient', since 'ingredient' will refer
            to this object.
        nutrional_content(NutrionalContent): The nutrional content object that describes the nutrional content of the ingredient.

    Optional Attributes:
        scientific_name (str): The scientific name of the ingredient.
        continent_of_origin (Continent): The continent that the ingredient originates from.
            Valid values are Africa, Antartica, Asia, Australia, Europe, NorthAmerica, and SouthAmerica.

    Single Column Constraints:
        - An ingredient's name must be unique

    Table Constraints:
        None.
    """
    __tablename__ = 'Ingredient'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False, unique=True)

    recipes = relationship('IngredientsInRecipes', back_populates ='ingredient')
    nutritional_content = relationship("NutritionalContent", uselist=False, back_populates="ingredient")

    scientific_name = Column(String, nullable=True)
    continent_of_origin = Column(Enum(*enumToTuple(Continent), name=Continent), nullable=True)

    def summaryDict(self):
        """ A helper function that returns a dictionary representation of an Ingredient, but only with a subset of information.

        Returns:
            dict: A dictionary with the names of a subset of columns as keys, and the value of column as the values.
        """
        summaryKeys = ['id', 'name']
        selfAsDict = self.__dict__
        return {key:selfAsDict[key] for key in summaryKeys}

    def fullDict(self):
        """ A helper function that returns a dictionary representation of a Recipe.

        Returns:
            dict: A dictionary with the names of each column as keys, and the value of column as the values.
        """
        columnKeys = getColumnNamesInDeclarationOrder(Ingredient)
        columnKeys.remove('id')
        selfAsDict = self.__dict__
        return {key:selfAsDict[key] for key in columnKeys}


class NutritionalContent(Base):
    """The NutritionalContent Table
    The NutritionalContent table has entries that describe the nutrional information of ingredients.

    Required Attributes:
        calories (int): The number of Calories in one serving.
        ... (The rest are assumed to be self-documenting)

    Relational Attributes:
        ingredient (Ingredient): The ingredient object this content is describing.

    Optional Attributes:
        None

    Single Column Constraints:
        - 'calories' is non-negative
        - 'total_fat_in_grams' is non-negative
        - 'saturated_fat_in_grams' is non-negative
        - 'cholesterol_in_milligrams' is non-negative
        - 'sodium_in_milligrams' is non-negative
        - 'total_carbohydrates_in_grams' is non-negative
        - 'dietary_fiber_in_grams' is non-negative
        - 'sugar_in_grams' is non-negative
        - 'protein_in_grams' is non-negative
        - 'vitamin_a_in_iu' is non-negative
        - 'vitamin_c_in_milligrams' is non-negative
        - 'calcium_in_milligrams' is non-negative
        - 'iron_in_milligrams' is non-negative

    Table Constraints:
        None.
    """
    __tablename__ = 'Nutritional Content'

    id = Column(Integer, primary_key=True)
    ingredient_id = Column(Integer, ForeignKey('Ingredient.id'))
    ingredient = relationship("Ingredient", back_populates="nutritional_content")

    calories                     = Column(Integer, isNonnegative('calories')                    , nullable=False)
    total_fat_in_grams           = Column(Integer, isNonnegative('total_fat_in_grams')          , nullable=False)
    saturated_fat_in_grams       = Column(Integer, isNonnegative('saturated_fat_in_grams')      , nullable=False)
    cholesterol_in_milligrams    = Column(Integer, isNonnegative('cholesterol_in_milligrams')   , nullable=False)
    sodium_in_milligrams         = Column(Integer, isNonnegative('sodium_in_milligrams')        , nullable=False)
    total_carbohydrates_in_grams = Column(Integer, isNonnegative('total_carbohydrates_in_grams'), nullable=False)
    dietary_fiber_in_grams       = Column(Float,   isNonnegative('dietary_fiber_in_grams')      , nullable=False)
    sugar_in_grams               = Column(Float,   isNonnegative('sugar_in_grams')              , nullable=False)
    protein_in_grams             = Column(Float,   isNonnegative('protein_in_grams')            , nullable=False)
    vitamin_a_in_iu              = Column(Integer, isNonnegative('vitamin_a_in_iu')             , nullable=False)
    vitamin_c_in_milligrams      = Column(Integer, isNonnegative('vitamin_c_in_milligrams')     , nullable=False)
    calcium_in_milligrams        = Column(Integer, isNonnegative('calcium_in_milligrams')       , nullable=False)
    iron_in_milligrams           = Column(Integer, isNonnegative('iron_in_milligrams')          , nullable=False)

    def fullDict(self):
        """ A helper function that returns a dictionary representation of a NutritionalContent.

        Returns:
            dict: A dictionary with the names of each column as keys, and the value of column as the values.
        """
        columnKeys = getColumnNamesInDeclarationOrder(NutritionalContent)
        columnKeys.remove('id')
        columnKeys.remove('ingredient_id')
        selfAsDict = self.__dict__
        return {key:selfAsDict[key] for key in columnKeys}

class IngredientsInRecipes(Base):
    """The IngredientsInRecipes Table
    The IngredientsInRecipes table has entries for each ingredient in each recipe.

    Required Attributes:
        recipe_id (int)(ForeignKey): The id of the recipe in the 'Recipe' table.
        ingredient_id (int)(ForeignKey): The id of the ingredient in the 'Ingredient' table.
        original_string (str): The ingredient string as it appears in the recipe. (E.g. "One half cup of sugar.")
        ingredient_index (int): The index the ingredient appears in the recipe's ingredient list, 0-based.

    Relational Attributes:
        recipe (Recipe): The Recipe object for this entry.
        ingredient (Ingredient): The Ingredient object for this entry

    Optional Attributes:
        amount (float): The amount of the ingredient in units of 'unit'.
        unit (str): The string representation of the unit the amount is in.
        unit_short (str): The abbreviated version of unit.

    Single Column Constraints:
        None.

    Table Constraints:
        None.
    """
    __tablename__ = 'IngredientsInRecipes'
    recipe_id     = Column(Integer, ForeignKey('Recipe.id'),     primary_key=True)
    ingredient_id = Column(Integer, ForeignKey('Ingredient.id'), primary_key=True)

    original_string = Column(String, nullable=False)
    amount          = Column(Float,  nullable=True)
    unit            = Column(String, nullable=True)
    unit_short      = Column(String, nullable=True)

    ingredient_index = Column(Integer, nullable=False)

    # Relationships
    recipe     = relationship(Recipe,     back_populates="ingredients")
    ingredient = relationship(Ingredient, back_populates="recipes")

    def fullDict(self):
        """ A helper function that returns a dictionary representation of an IngredientInRecipe.
        (specially useful for jsonify-ing a row)

        Returns:
            dict: A dictionary with the names of each column as keys, and the value of column as the values.
        """
        columnKeys = getColumnNamesInDeclarationOrder(IngredientsInRecipes)
        selfAsDict = self.__dict__
        return {key:selfAsDict[key] for key in columnKeys}
