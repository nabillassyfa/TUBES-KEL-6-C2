from os import path
from fastapi import Depends, Request, FastAPI, HTTPException

from fastapi.responses import FileResponse
from fastapi.security import OAuth2PasswordRequestForm,OAuth2PasswordBearer
from pydantic import BaseModel

from sqlalchemy.orm import Session

import crud, models, schemas
from database import SessionLocal, engine
models.BaseDB.metadata.create_all(bind=engine)

# from jose import jwt
import datetime
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI(title="Web service DIHospital",
    description="Web service untuk Tubes provis Kel 6",
    version="0.0.1 (Alpha)",)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        

@app.get("/")
async def root():
    return {"message": "Dokumentasi API: [url]:8000/docs"}

@app.get("/RS/", response_model=list[schemas.RS])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data_rs = crud.get_RS(db, skip=skip, limit=limit)
    return data_rs

path_img = "../img/"
@app.get("/RS_image/{rs_id}")
def read_image(rs_id:int,  db: Session = Depends(get_db)):
    
    RS = crud.get_RS_by_id(db,rs_id)
    if not(RS):
        raise HTTPException(status_code=404, detail="id tidak valid")
    nama_image =  RS.img 
    if not(path.exists(path_img+nama_image)):
        raise HTTPException(status_code=404, detail="File dengan nama tersebut tidak ditemukan")
    
    fr =  FileResponse(path_img+nama_image)
    return fr  

@app.get("/artikel/", response_model=list[schemas.Artikel])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data_artikel = crud.get_Artikel(db, skip=skip, limit=limit)
    return data_artikel

#hapus ini kalau salt sudah digenerate
# import bcrypt
# @app.get("/getsalt")
# async def getsalt():
#     hasil = bcrypt.gensalt()
#     return {"message": hasil}

# create user 
@app.post("/Signup/", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = crud.get_user_by_email(db,email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Error: Username sudah digunakan")
    return crud.create_user(db=db, user=user)


# hasil adalah id 
@app.post("/login") #,response_model=schemas.Token
async def login(user: schemas.UserLog, db: Session = Depends(get_db)):
    if not authenticate(db,user):
        raise HTTPException(status_code=400, detail="Username atau password tidak cocock")

    # ambil informasi username
    user_login = crud.get_user_by_email(db,user.email)
    if user_login:
        user_id = user_login.id
        return {"user_id":user_id}
    else:
        raise HTTPException(status_code=400, detail="User tidak ditemukan, kontak admin")

#lihat detil user_id
@app.get("/users/{user_id}", response_model=schemas.User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    db_user = crud.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user

######################## AUTH

# periksa apakah username ada dan passwordnya cocok
# return boolean TRUE jika username dan password cocok
def authenticate(db,user: schemas.UserCreate):
    user_cari = crud.get_user_by_email(db=db, email=user.email)
    if user_cari:
        return (user_cari.password == crud.hashPassword(user.password))
    else:
        return False    
    