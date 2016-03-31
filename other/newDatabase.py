from sqlalchemy import create_engine
from models import Base
from constants import databaseName
import os

try:
    os.remove(databaseName)
except OSError:
    pass

engine = create_engine(databaseName)
Base.metadata.create_all(engine)