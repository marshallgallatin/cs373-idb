from enums import Cuisine
from sqlalchemy import orm
from sqlalchemy import or_, and_
from useDatabase import sessionInstance
import models
import QueryHelpers
import re

replaceTagWithSpaceRegularExpression = re.compile('\</li\>\<li\>')
removeTagRegularExpression = re.compile('\<ol\>\<li\>|\</li\>\</ol\>')
boldTagsRegularExpression = re.compile('.*(\<b\>.*\</b>).*')
numberOfWordsOnEitherSideOfMatch = 3


def search(keywords):
    with sessionInstance() as session:

        # Diet and cuisine restrictions
        parsedKeywords = list(keywords)
        filteredRecipesAnd = session.query(models.Recipe)
        filteredRecipesOr = None
        for keyword in keywords:
            kw = keyword.lower()
            # Conditional from hell... dear Mr. Downing, please show me how to refactor in Python
            if kw in ['vegetarian', 'meat-free', 'meat free']:
                filteredRecipesAnd = filteredRecipesAnd.filter(models.Recipe.vegetarian)
                if filteredRecipesOr:
                    filteredRecipesOr = filteredRecipesOr.union(session.query(models.Recipe).filter(models.Recipe.vegetarian))
                else:
                    filteredRecipesOr = session.query(models.Recipe).filter(models.Recipe.vegetarian)
                parsedKeywords.remove(kw)
            elif kw in ['vegan']:
                filteredRecipesAnd = filteredRecipesAnd.filter(models.Recipe.vegan)
                if filteredRecipesOr:
                    filteredRecipesOr = filteredRecipesOr.union(session.query(models.Recipe).filter(models.Recipe.vegan))
                else:
                    filteredRecipesOr = session.query(models.Recipe).filter(models.Recipe.vegan)
                parsedKeywords.remove(kw)
            elif kw in ['gluten-free', 'gluten free']:
                filteredRecipesAnd = filteredRecipesAnd.filter(models.Recipe.gluten_free)
                if filteredRecipesOr:
                    filteredRecipesOr = filteredRecipesOr.union(session.query(models.Recipe).filter(models.Recipe.gluten_free))
                else:
                    filteredRecipesOr = session.query(models.Recipe).filter(models.Recipe.gluten_free)
                parsedKeywords.remove(kw)
            elif kw in ['dairy-free', 'lactose-free', 'nondairy', 'non-dairy', 'dairy free']:
                filteredRecipesAnd = filteredRecipesAnd.filter(models.Recipe.dairy_free)
                if filteredRecipesOr:
                    filteredRecipesOr = filteredRecipesOr.union(session.query(models.Recipe).filter(models.Recipe.dairy_free))
                else:
                    filteredRecipesOr = session.query(models.Recipe).filter(models.Recipe.dairy_free)
                parsedKeywords.remove(kw)
            elif kw in Cuisine.__members__:
                filteredRecipesAnd = filteredRecipesAnd.filter(models.Recipe.cuisine == Cuisine[kw].name)
                if filteredRecipesOr:
                    filteredRecipesOr = filteredRecipesOr.union(session.query(models.Recipe).filter(models.Recipe.cuisine == Cuisine[kw].name))
                else:
                    filteredRecipesOr = session.query(models.Recipe).filter(models.Recipe.cuisine == Cuisine[kw].name)
                parsedKeywords.remove(kw)

        def ilikeGenerator(column):
            return map(lambda x:column.ilike('%' + x + '%'), keywords)

        def ilikeGeneratorParsed(column):
            return map(lambda x: column.ilike('%' + x + '%'), parsedKeywords)

        # If we still have keywords beyond the special keywords for dietary restrictions and cuisine, grep them
        if (parsedKeywords):
            filteredRecipesAnd = filteredRecipesAnd.filter(or_(and_(*ilikeGeneratorParsed(models.Recipe.title)), and_(*ilikeGeneratorParsed(models.Recipe.instructions))))
        # But still do a lookup on the special keywords within titles and instructions
        keywordAnd = session.query(models.Recipe).filter(or_(and_(*ilikeGenerator(models.Recipe.title)), and_(*ilikeGenerator(models.Recipe.instructions))))
        recipesAnd = filteredRecipesAnd.union(keywordAnd).all()

        ingredientsAnd = session.query(models.Ingredient).filter(or_(and_(*ilikeGenerator(models.Ingredient.name)), and_(*ilikeGenerator(models.Ingredient.scientific_name)))).all()

        if (parsedKeywords):
            filteredRecipesOr = filteredRecipesAnd.filter(or_(or_(*ilikeGeneratorParsed(models.Recipe.title)),
                                                              or_(*ilikeGeneratorParsed(models.Recipe.instructions))))
        keywordOr = session.query(models.Recipe).filter(or_(or_(*ilikeGenerator(models.Recipe.title)), or_(*ilikeGenerator(models.Recipe.instructions))))
        recipesOr = [recipe for recipe in filteredRecipesOr.union(keywordOr).all() if recipe not in recipesAnd]

        ingredientsOr = session.query(models.Ingredient).filter(or_(or_(*ilikeGenerator(models.Ingredient.name)), or_(*ilikeGenerator(models.Ingredient.scientific_name)))).all()

        def getAllSnippets(iterable):
            def bound(number):
                return max(0, min(len(iterable), number))

            for index, word in enumerate(iterable):
                match = boldTagsRegularExpression.match(word)
                if match:
                    yield ' '.join(iterable[bound(index-numberOfWordsOnEitherSideOfMatch):bound(index+numberOfWordsOnEitherSideOfMatch)])

        keywordFinderRegularExpressions = []
        for keyword in keywords:
            keywordFinderRegularExpressions.append(re.compile(keyword, re.IGNORECASE))

        def recipeResultDict(recipe):
            returnDict = recipe.summaryDict()
            returnDict['type'] = 'recipe'

            title = recipe.title
            instructions = removeTagRegularExpression.sub('', replaceTagWithSpaceRegularExpression.sub(' ', recipe.instructions))

            for kIndex in range(0, len(keywords)):
                # We use a lambda function as a way of preserving the original string's case
                title = keywordFinderRegularExpressions[kIndex].sub(lambda x: '<b>' + x.group(0) + '</b>', title)
                instructions = keywordFinderRegularExpressions[kIndex].sub(lambda x: '<b>' + x.group(0) + '</b>', instructions)

            returnDict['title'] = title
            returnDict['snippets'] = [snippet for snippet in getAllSnippets(instructions.split(' '))]

            QueryHelpers.removeNoneDictEntries(returnDict)
            return returnDict

        def ingredientResultDict(ingredient):
            returnDict = ingredient.fullDict()
            returnDict['type'] = 'ingredient'

            name = ingredient.name
            scientificName = ingredient.scientific_name if ingredient.scientific_name else ''

            for kIndex in range(0, len(keywords)):
                # We use a lambda function as a way of preserving the original string's case
                name = keywordFinderRegularExpressions[kIndex].sub(lambda x: '<b>' + x.group(0) + '</b>', name)
                scientificName = keywordFinderRegularExpressions[kIndex].sub(lambda x: '<b>' + x.group(0) + '</b>', scientificName)

            returnDict['name'] = name
            returnDict['snippets'] = [snippet for snippet in getAllSnippets(scientificName.split(' '))]

            QueryHelpers.removeNoneDictEntries(returnDict)
            return returnDict

        andResults = [recipeResultDict(recipe) for recipe in recipesAnd] + [ingredientResultDict(ingredient) for ingredient in ingredientsAnd]
        orResults = [recipeResultDict(recipe) for recipe in recipesOr] + [ingredientResultDict(ingredient) for ingredient in ingredientsOr]

        return {
            'and':{
                'count':len(andResults),
                'results':andResults
            },
            'or': {
                'count':len(orResults),
                'results':orResults
            }
        }
