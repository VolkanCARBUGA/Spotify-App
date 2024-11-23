from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

Database_Url = "postgresql://postgres:volkan123@localhost:5432/spotify_app"
engine = create_engine(Database_Url)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
def get_db():
       db = SessionLocal()
       try:
              yield db
       finally:
              db.close()

