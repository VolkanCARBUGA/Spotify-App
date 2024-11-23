import uuid
import bcrypt
from fastapi import Depends, HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import Session

from pydantic_schemas.user_login import UserLogin

router= APIRouter()
def hash_password(password: str) -> bytes:
    # Hash ve salt oluştur
    """
    Verilen parolayı bcrypt ile şifreler.
    
    Parameters
    ----------
    password : str
        Şifrelenecek parola.
    
    Returns
    -------
    bytes
        Şifrelenmiş parola.
    """
    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
@router.post("/signup",status_code=201)
async def signup_user(user: UserCreate,db:Session=Depends(get_db)):
    """
    Kayıt oluşturur.

    Parameters
    ----------
    user : UserCreate
        Kayıt oluşturmak için gereken bilgiler.
    db : Session
        Veritabanına bağlanmak için kullanılan oturum.

    Returns
    -------
    User
        Kayıt edilen kullanıcı.

    Raises
    ------
    HTTPException
        Kullanıcı zaten varsa 400 durum koduyla hata döner.
    """
    user_db=   db.query(User).filter(User.email==user.email).first()
    if user_db:
               raise HTTPException(status_code=400,detail="User already exist")
               
    hashed_password = hash_password(user.password) 
    user_db=User(id=str(uuid.uuid4()),name=user.name,email=user.email,password=hashed_password)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db
@router.post("/login")
async def login_user(user: UserLogin,db:Session=Depends(get_db)):
    user_db=db.query(User).filter(User.email==user.email).first()
    if not user_db:
        raise HTTPException(status_code=400,detail="User not found")
    is_match=bcrypt.checkpw(user.password.encode("utf-8"),user_db.password)
    if not is_match:
        raise HTTPException(status_code=400,detail="Invalid password")
    return user_db
    