from QueryExceptions import BadQueryException

def ensureIsNonNegative(number):
    if number < 0:
        raise BadQueryException()

def ensureIsPositive(number):
    if number <= 0:
        raise BadQueryException()

def ensureDictOnlyContains(dictionary, *args):
    if len(set(dictionary.keys()) - set(args)) != 0:
        raise BadQueryException()

def ensureDictExactlyContains(dictionary, *args):
    if len(set(dictionary.keys()) ^ set(args)) != 0:
        raise BadQueryException()

def ensureListIsntEmpty(aList):
    if len(aList) == 0:
        raise BadQueryException()

def removeNoneDictEntries(aDict):
    delKeys = [key for key in aDict if aDict[key] is None]
    for key in delKeys:
        del aDict[key]
