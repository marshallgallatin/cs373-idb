from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import sys, os
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), os.pardir))
from constants import databaseName

engine = create_engine(databaseName)
Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)

class sessionInstance():
    def __enter__(self):
        self.session = DBSession()
        return self.session

    def __exit__(self, type, value, traceback):
        self.session.close()
