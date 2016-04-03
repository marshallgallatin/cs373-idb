from sqlalchemy import create_engine
import sys, os
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), os.pardir))
from models import Base
from constants import databaseName
import os

try:
    os.remove(databaseName)
except OSError:
    pass

engine = create_engine(databaseName)
Base.metadata.create_all(engine)