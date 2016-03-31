from sqlalchemy import CheckConstraint

def isPercentage(name):
    return CheckConstraint('(' + name + '>=0 AND ' + name + '<=100)')

def isNonnegative(name):
    return CheckConstraint('(' + name + '>=0)')

def isNotNull(name):
    return CheckConstraint('(' + name + 'IS NOT NULL)')

def AND(constaint1, constaint2):
    return '(' + constaint1.sqltext + ') AND (' + constaint2.sqltext + ')'

def OR(constaint1, constaint2):
    return '(' + constaint1.sqltext + ') OR (' + constaint2.sqltext + ')'