from sqlalchemy import CheckConstraint

def isPercentage(name):
    return CheckConstraint('(' + name + '>=0 AND ' + name + '<=100)')

def isNonnegative(name):
    return CheckConstraint('(' + name + '>=0)')

def isNotNull(name):
    return CheckConstraint('(' + name + 'IS NOT NULL)')

def AND(constraint1, constraint2):
    return '(' + constraint1.sqltext + ') AND (' + constraint2.sqltext + ')'

def OR(constraint1, constraint2):
    return '(' + constraint1.sqltext + ') OR (' + constraint2.sqltext + ')'