def getColumnNamesInDeclarationOrder(model):
    return [col.name for col in model.__table__._columns._all_columns]

def renameKeyInDict(oldKey, newKey, theDict):
    theDict[newKey] = theDict[oldKey]
    del theDict[oldKey]