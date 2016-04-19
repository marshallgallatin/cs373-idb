from sqlalchemy import orm
from sqlalchemy import or_, and_
from useDatabase import sessionInstance
import models
import QueryHelpers
import re

replaceTagWithSpaceRegularExpression = re.compile('\</li\>\<li\>')
removeTagRegularExpression = re.compile('\<ol\>\<li\>|\</li\>\</ol\>')
boldTagsRegularExpression = re.compile('.*(\<b\>.*\</b\>).*')
numberOfWordsOnEitherSideOfMatch = 3

def search(keywords):
    with sessionInstance() as session:
        def ilikeGenerator(column):
            return map(lambda x:column.ilike('%' + x + '%'), keywords)

        recipesAnd = session.query(models.Recipe).filter(or_(and_(*ilikeGenerator(models.Recipe.title)), and_(*ilikeGenerator(models.Recipe.instructions)))).all()
        ingredientsAnd = session.query(models.Ingredient).filter(or_(and_(*ilikeGenerator(models.Ingredient.name)), and_(*ilikeGenerator(models.Ingredient.scientific_name)))).all()
        recipesOr = session.query(models.Recipe).filter(or_(or_(*ilikeGenerator(models.Recipe.title)), or_(*ilikeGenerator(models.Recipe.instructions)))).all()
        ingredientsOr = session.query(models.Ingredient).filter(or_(or_(*ilikeGenerator(models.Ingredient.name)), or_(*ilikeGenerator(models.Ingredient.scientific_name)))).all()

        def getAllSnippets(iterable):
            def bound(number):
                return max(0, min(len(iterable), number))

            for index, word in enumerate(iterable):
                if boldTagsRegularExpression.match(word).group(0):
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
