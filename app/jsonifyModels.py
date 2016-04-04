import json

def jsonifyQueryResult(queryResult):
    def trimTheFat(modelDict):
        return {element:modelDict[element] for element in modelDict if element[0] != '_'}
    if type(queryResult) == list:
        return json.dumps([trimTheFat(result.__dict__) for result in queryResult])
    else:
        return json.dumps(queryResult.__dict__)