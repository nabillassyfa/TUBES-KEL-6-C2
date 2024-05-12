from sqlalchemy.orm import Session
import models, schemas
import bcrypt
from sqlalchemy import desc

SALT = b'$2b$12$rX.6REj.knvtNtaqkPT1cu'

# ambil semua item
def get_RS(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.RS).offset(skip).limit(limit).all()

# ambil RS dengan id tertentu
def get_RS_by_id(db: Session, rs_id: int):
    return db.query(models.RS).filter(models.RS.id == rs_id).first()

# ambil semua item
def get_Artikel(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Artikel).offset(skip).limit(limit).all()

# User ###########
def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()

# delete semua user
def delete_all_user(db: Session):
    jum_rec = db.query(models.User).delete()
    db.commit()
    return jum_rec

# Pass
def hashPassword(passwd: str):
    bytePwd = passwd.encode('utf-8')
    pwd_hash = bcrypt.hashpw(bytePwd, SALT)
    return pwd_hash

# Create user (Sign up)
def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = hashPassword(user.password)
    db_user = models.User(nama=user.nama,username=user.username, password=hashed_password, email=user.email, no_telp=user.no_telp)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user