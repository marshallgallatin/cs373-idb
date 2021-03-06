from enum import Enum

class Cuisine(Enum):
    african         = 0
    chinese         = 1
    japanese        = 2
    korean          = 3
    vietnamese      = 4
    thai            = 5
    indian          = 6
    british         = 7
    irish           = 8
    french          = 9
    italian         = 10
    mexican         = 11
    spanish         = 12
    middleEastern   = 13
    jewish          = 14
    american        = 15
    cajun           = 16
    southern        = 17
    greek           = 18
    german          = 19
    nordic          = 20
    easternEuropean = 21
    caribbean       = 22
    latinAmerican   = 23

class Origin(Enum):
    Africa        = 1
    Asia          = 2
    Europe        = 3
    NorthAmerica  = 4
    Oceania       = 5
    SouthAmerica  = 6
    Worldwide     = 7

def enumToTuple(enum):
    return tuple(item for item in enum.__members__.keys())
