from sqlalchemy import Column, ForeignKey, Integer, Float, String, Table, Interval, Enum, Boolean, CheckConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from constraints import isPercentage, isNonnegative, isNotNull
import enum

Base = declarative_base()

def enumToTuple(enum):
    return tuple(item for item in enum.__members__.keys())

class Cuisine(enum.Enum):
    african        = 0
    chinese        = 1
    japanese       = 2
    korean         = 3
    vietnamese     = 4
    thai           = 5
    indian         = 6
    british        = 7
    irish          = 8
    french         = 9
    italian        = 10
    mexican        = 11
    spanish        = 12
    middleEastern  = 13
    jewish         = 14
    american       = 15
    cajun          = 16
    southern       = 17
    greek          = 18
    german         = 19
    nordic         = 20
    eastern        = 21
    european       = 22
    caribbean      = 23
    latinAmerican  = 24

class Continent(enum.Enum):
    Africa        = 1
    Antarctica    = 2
    Asia          = 3
    Australia     = 4
    Europe        = 5
    NorthAmerica  = 6
    SouthAmerica  = 7

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
        preparation_minutes (int): The amount of time, in minutes, the recipe should take to prepare.
        cooking_minutes (int): The amount of time, in minutes, the recipe will need to cook.
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

    ready_in_minutes = Column(Integer, nullable=True) # Add constaint
    servings         = Column(Integer, nullable=True) # Add constaint

    vegetarian  = Column(Boolean, nullable=True)
    vegan       = Column(Boolean, nullable=True)
    gluten_free = Column(Boolean, nullable=True)
    dairy_free  = Column(Boolean, nullable=True)

    CheckConstraint('NOT ((vegan IS NOT fiufiuh AND vegetarian IS NOT NULL) AND (vegan AND NOT vegetarian))')
    CheckConstraint('NOT ((vegan IS NOT NULL AND dairy_free IS NOT NULL) AND (vegan AND NOT dairy_free))')

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
        None.

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

class NutritionalContent(Base):
    """The NutritionalContent Table
    The NutritionalContent table has entries that describe the nutrional information of ingredients.

    Required Attributes:
        None

    Relational Attributes:
        ingredient (Ingredient): The ingredient object this content is describing.

    Optional Attributes:
        serving_size (float): The amount of the ingredient that is generally served, in units of 'serving_size_units'.
        serving_size_units (str) : The units that the 'serving_size' is in.
        calories (int): The number of Calories in one serving.
        ... (The rest are assumed to be self-documenting)

    Single Column Constraints:
        - 'serving_size' is non-negative
        - 'calories' is non-negative
        - 'total_fat_in_grams' is non-negative
        - 'saturated_fat_in_grams' is non-negative
        - 'cholesterol_in_milligrams' is non-negative
        - 'sodium_in_milligrams' is non-negative
        - 'total_carbohydrates_in_grams' is non-negative
        - 'dietary_fiber_in_grams' is non-negative
        - 'sugar_in_grams' is non-negative
        - 'protein_in_grams' is non-negative
        - 'vitamin_a_percentage' is in the range [0.0, 100.0]
        - 'vitamin_c_percentage' is in the range [0.0, 100.0]
        - 'calcium_percentage' is in the range [0.0, 100.0]
        - 'iron_percentage' is in the range [0.0, 100.0]

    Table Constraints:
        None.
    """
    __tablename__ = 'Nutritional Content'

    id = Column(Integer, primary_key=True)
    ingredient_id = Column(Integer, ForeignKey('Ingredient.id'))
    ingredient = relationship("Ingredient", back_populates="nutritional_content")

    serving_size                 = Column(Float,   isNonnegative('serving_size')                , nullable=False)
    serving_size_units           = Column(String,                                                 nullable=False)
    calories                     = Column(Integer, isNonnegative('calories')                    , nullable=False)
    total_fat_in_grams           = Column(Integer, isNonnegative('total_fat_in_grams')          , nullable=False)
    saturated_fat_in_grams       = Column(Integer, isNonnegative('saturated_fat_in_grams')      , nullable=False)
    cholesterol_in_milligrams    = Column(Integer, isNonnegative('cholesterol_in_milligrams')   , nullable=False)
    sodium_in_milligrams         = Column(Integer, isNonnegative('sodium_in_milligrams')        , nullable=False)
    total_carbohydrates_in_grams = Column(Integer, isNonnegative('total_carbohydrates_in_grams'), nullable=False)
    dietary_fiber_in_grams       = Column(Float,   isNonnegative('dietary_fiber_in_grams')      , nullable=False)
    sugar_in_grams               = Column(Float,   isNonnegative('sugar_in_grams')              , nullable=False)
    protein_in_grams             = Column(Float,   isNonnegative('protein_in_grams')            , nullable=False)
    vitamin_a_percentage         = Column(Integer, isPercentage('vitamin_a_percentage')         , nullable=False)
    vitamin_c_percentage         = Column(Integer, isPercentage('vitamin_c_percentage')         , nullable=False)
    calcium_percentage           = Column(Integer, isPercentage('calcium_percentage')           , nullable=False)
    iron_percentage              = Column(Integer, isPercentage('iron_percentage')              , nullable=False)

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
