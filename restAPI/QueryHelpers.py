from QueryExceptions import BadQueryException

def ensureIsNonNegative(number):
    if number < 0:
        raise BadQueryException()

def ensureDictOnlyContains(dictionary, *args):
    if len(set(dictionary.keys()) - set(args)) != 0:
        raise BadQueryException()

def ensureDictExactlyContains(dictionary, *args):
    if len(set(dictionary.keys()) ^ set(args)) != 0:
        raise BadQueryException()

def ensureTypeIs(arg, typeArg):
    if not type(arg) == typeArg:
        raise BadQueryException()

def ensureListIsntEmpty(aList):
    if len(aList) == 0:
        raise BadQueryException()