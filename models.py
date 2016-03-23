from sqlalchemy import Column, ForeignKey, Integer, Float, String, Table, Interval, Enum, Boolean, CheckConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from enums import enumToTuple, Continent, Cuisine
from constraints import isPercentage, isNonnegative, isNotNull

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
        imageURI (str): The URI of the image for this recipe.
        instructions (str): The instructions for the recipe as a str.
        cuisine (str): The region where the recipe originates from.
        preparationMinutes (int): The amount of time, in minutes, the recipe should take to prepare.
        cookingMinutes (int): The amount of time, in minutes, the recipe will need to cook.
        readyInMinutes (int): The sum of preparationMinutes and cookingMinutes, if given.
        servings (int): The amount of food made by recipe, where one serving is enough to feed one person.
        vegetarian (bool): False if meat is an ingredient, True otherwise
        vegan (bool): False if an animal product is an ingredient, True otherwise.
        glutenFree (bool): False if an ingredient contains Gluten, True otherwise.
        dairyFree (bool): False if an ingredient contains dairy products, True otherwise.

    Single Column Constraints:
        None.

    Table Constraints:
        - A recipe can't be vegan and not vegetarian, assuming both are not None.
        - A recipe can't be vegan, and not dairyFree, assuming both are not None.
    """
    __tablename__ = 'Recipe'

    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)

    ingredients = relationship('IngredientsInRecipes', back_populates ='recipe')

    imageURI     = Column(String, nullable=True)
    instructions = Column(String, nullable=True) #@TODO: Make this cleaner/formatted
    cuisine      = Column(Enum(*enumToTuple(Cuisine)), nullable=True)

    preparationMinutes = Column(Integer, nullable=True) # Add constaint
    cookingMinutes     = Column(Integer, nullable=True) # Add constaint
    readyInMinutes     = Column(Integer, nullable=True) # Add constaint
    servings           = Column(Integer, nullable=True) # Add constaint

    vegetarian         = Column(Boolean, nullable=True)
    vegan              = Column(Boolean, nullable=True)
    glutenFree         = Column(Boolean, nullable=True)
    dairyFree          = Column(Boolean, nullable=True)

    CheckConstraint('NOT ((vegan IS NOT NULL AND vegetarian IS NOT NULL) AND (vegan AND NOT vegetarian))')
    CheckConstraint('NOT ((vegan IS NOT NULL AND dairyFree IS NOT NULL) AND (vegan AND NOT dairyFree))')

class Ingredient(Base):
    """The Ingredient Table
    The Ingredient table has entries for an ingredient.

    Required Attributes:
        name (str): The name of the ingredient.

    Relational Attributes:
        recipes (IngredientsInRecipes): A list of IngredientsInRecipes objects that apply to this ingredient.
            The relevant information for this object is everything but 'ingredient', since 'ingredient' will refer
            to this object.
        nutrionalContent(NutrionalContent): The nutrional content object that describes the nutrional content of the ingredient.

    Optional Attributes:
        scientificName (str): The scientific name of the ingredient.
        continentOfOrigin (Continent): The continent that the ingredient originates from.
            Valid values are Africa, Antartica, Asia, Australia, Europe, NorthAmerica, and SouthAmerica.

    Single Column Constraints:
        None.

    Table Constraints:
        None.
    """
    __tablename__ = 'Ingredient'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    recipes = relationship('IngredientsInRecipes', back_populates ='ingredient')
    nutrionalContent = relationship("NutrionalContent", uselist=False, back_populates="ingredient")

    scientificName = Column(String, nullable=True)
    continentOfOrigin = Column(Enum(*enumToTuple(Continent)), nullable=True)

class NutrionalContent(Base):
    """The NutrionalContent Table
    The NutrionalContent table has entries that describe the nutrional information of ingredients.

    Required Attributes:
        None

    Relational Attributes:
        ingredient (Ingredient): The ingredient object this content is describing.

    Optional Attributes:
        servingSize (float): The amount of the ingredient that is generally served, in units of 'servingSizeUnits'.
        servingSizeUnits (str) : The units that the 'servingSize' is in.
        calories (int): The number of Calories in one serving.
        ... (The rest are assumed to be self-documenting)

    Single Column Constraints:
        - 'servingSize' is non-negative
        - 'calories' is non-negative
        - 'totalFatInGrams' is non-negative
        - 'saturatedFatInGrams' is non-negative
        - 'cholesterolInMilligrams' is non-negative
        - 'sodiumInMilligrams' is non-negative
        - 'totalCarbohydratesInGrams' is non-negative
        - 'dietaryFiberInGrams' is non-negative
        - 'sugarInGrams' is non-negative
        - 'protienInGrams' is non-negative
        - 'vitaminAPercentage' is in the range [0.0, 100.0]
        - 'vitaminCPercentage' is in the range [0.0, 100.0]
        - 'calciumPercentage' is in the range [0.0, 100.0]
        - 'ironPercentage' is in the range [0.0, 100.0]

    Table Constraints:
        None.
    """
    __tablename__ = 'Nutrional Content'

    id = Column(Integer, primary_key=True)
    ingredient = relationship("Ingredient", back_populates="nutrionalContent")

    servingSize               = Column(Float,   isNonnegative('servingSize')              , nullable=False)
    servingSizeUnits          = Column(String,                                              nullable=False)
    calories                  = Column(Integer, isNonnegative('calories')                 , nullable=False)
    totalFatInGrams           = Column(Integer, isNonnegative('totalFatInGrams')          , nullable=False)
    saturatedFatInGrams       = Column(Integer, isNonnegative('saturatedFatInGrams')      , nullable=False)
    cholesterolInMilligrams   = Column(Integer, isNonnegative('cholesterolInMilligrams')  , nullable=False)
    sodiumInMilligrams        = Column(Integer, isNonnegative('sodiumInMilligrams')       , nullable=False)
    totalCarbohydratesInGrams = Column(Integer, isNonnegative('totalCarbohydratesInGrams'), nullable=False)
    dietaryFiberInGrams       = Column(Float,   isNonnegative('dietaryFiberInGrams')      , nullable=False)
    sugarInGrams              = Column(Float,   isNonnegative('sugarInGrams')             , nullable=False)
    protienInGrams            = Column(Float,   isNonnegative('protienInGrams')           , nullable=False)
    vitaminAPercentage        = Column(Integer, isPercentage('vitaminAPercentage')        , nullable=False)
    vitaminCPercentage        = Column(Integer, isPercentage('vitaminCPercentage')        , nullable=False)
    calciumPercentage         = Column(Integer, isPercentage('calciumPercentage')         , nullable=False)
    ironPercentage            = Column(Integer, isPercentage('ironPercentage')            , nullable=False)

class IngredientsInRecipes(Base):
    """The IngredientsInRecipes Table
    The IngredientsInRecipes table has entries for each ingredient in each recipe.

    Required Attributes:
        recipe_id (int)(ForeignKey): The id of the recipe in the 'Recipe' table.
        ingredient_id (int)(ForeignKey): The id of the ingredient in the 'Ingredient' table.
        originalString (str): The ingredient string as it appears in the recipe. (E.g. "One half cup of sugar.")
        ingredientIndex (int): The index the ingredient appears in the recipe's ingredient list, 0-based.

    Relational Attributes:
        recipe (Recipe): The Recipe object for this entry.
        ingredient (Ingredient): The Ingredient object for this entry

    Optional Attributes:
        amount (float): The amount of the ingredient in units of 'unit'.
        unit (str): The string representation of the unit the amount is in.
        unitShort (str): The abbreviated version of unit.

    Single Column Constraints:
        None.

    Table Constraints:
        None.
    """
    __tablename__ = 'IngredientsInRecipes'
    recipe_id     = Column(Integer, ForeignKey('Recipe.id'),     primary_key=True)
    ingredient_id = Column(Integer, ForeignKey('Ingredient.id'), primary_key=True)

    originalString = Column(String, nullable=False)
    amount         = Column(Float,  nullable=True)
    unit           = Column(String, nullable=True)
    unitShort      = Column(String, nullable=True)

    ingredientIndex  = Column(Integer, nullable=False)

    # Relationships
    recipe     = relationship(Recipe,     back_populates="ingredients")
    ingredient = relationship(Ingredient, back_populates="recipes")
