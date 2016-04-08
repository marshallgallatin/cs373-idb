from sqlalchemy import CheckConstraint

def isPercentage(name):
    return CheckConstraint('(' + name + '>=0 AND ' + name + '<=100)')

def isNonnegative(name):
    return CheckConstraint('(' + name + '>=0)')

def isNotNull(name):
    return CheckConstraint('(' + name + 'IS NOT NULL)')
