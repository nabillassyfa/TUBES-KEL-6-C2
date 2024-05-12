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


app = FastAPI(title="Web service BarayaFood",
    description="Web service untuk quiz provis Mei 2024",
    version="0.0.1",)

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