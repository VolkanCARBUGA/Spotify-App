
from models.base import Base
from sqlalchemy import VARCHAR, Column, LargeBinary


class User(Base):  
       __tablename__ = "users"
       id=Column(VARCHAR(10), primary_key=True)
       name=Column(VARCHAR(100))
       email=Column(VARCHAR(100))   
       password=Column(LargeBinary,nullable=False)