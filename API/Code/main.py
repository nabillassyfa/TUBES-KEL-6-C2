from os import path
from fastapi import Depends, Request, FastAPI, HTTPException

from fastapi.responses import FileResponse
from fastapi.security import OAuth2PasswordRequestForm,OAuth2PasswordBearer
from pydantic import BaseModel

from sqlalchemy.orm import Session
from datetime import time, datetime



import crud, models, schemas
from database import SessionLocal, engine
models.BaseDB.metadata.create_all(bind=engine)

# from jose import jwt
from fastapi.middleware.cors import CORSMiddleware
from typing import List


app = FastAPI(title="Web service DIHospital",
    description="Web service untuk Tubes provis Kel 6",
    version="0.1.0 (Beta)",)

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

## Rumah Sakit 
@app.get("/RS/", response_model=list[schemas.RS])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data_rs = crud.get_RS(db, skip=skip, limit=limit)
    return data_rs

path_img = "../img/RS/"
@app.get("/RS_image/{rs_id}")
def read_image(rs_id:int,  db: Session = Depends(get_db)):
    
    RS = crud.get_RS_by_id(db,rs_id)
    if not(RS):
        raise HTTPException(status_code=404, detail="id tidak valid")
    nama_image =  RS.img 
    print (path_img + nama_image)
    if not(path.exists(path_img+nama_image)):
        raise HTTPException(status_code=404, detail="File dengan nama tersebut tidak ditemukan")
        
    fr =  FileResponse(path_img+nama_image)
    return fr  

## Daftar RS berdasarkan id spesialis
@app.get("/daftar_RS/{id}")
def read_items(id: int, db: Session = Depends(get_db)):
    daftar_RS = crud.get_RS_by_spesialis(db, id)
    return daftar_RS


@app.get("/daftar_RS_by_idLab/{id}")
def read_items(id: int, db: Session = Depends(get_db)):
    daftar_RS = crud.get_RS_by_Lab(db, id)
    return daftar_RS


## Daftar Spesialis berdasarkan id RS
@app.get("/daftar_spesialis/{id}")
def read_items(id: int, db: Session = Depends(get_db)):
    daftar_RS = crud.get_spesialis_by_RS(db, id)
    return daftar_RS

## Daftar Spesialis berdasarkan id
@app.get("/daftar_spesialis_by_id/{id}")
def read_items(id: int, db: Session = Depends(get_db)):
    spesialis = crud.get_spesialis_by_id(db, id)
    return spesialis


## Artikel
@app.get("/artikel/", response_model=list[schemas.Artikel])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data_artikel = crud.get_Artikel(db, skip=skip, limit=limit)
    return data_artikel

# Dokter
@app.get("/daftar_dokter/")
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data_dokter = crud.get_Dokter(db, skip=skip, limit=limit)
    return data_dokter

# Dokter By Id
@app.get("/data_dokter_by_id_withS/{dokter_id}")
def read_items(dokter_id: int , db: Session = Depends(get_db)):
    data_dokter = crud.get_Dokter_by_id_withS(db, dokter_id)
    return data_dokter

# Dokter By RS
@app.get("/daftar_dokter_by_RS_Spesialis/{rs_id}/{spesialis_id}")
def read_items(spesialis_id: int ,rs_id: int, db: Session = Depends(get_db)):
    data_dokter = crud.get_dokter_by_rs_spesialis(db, spesialis_id, rs_id)
    return data_dokter

# Dokter By Jadwal
@app.get("/daftar_dokter_by_jadwal/{rs_id}/{spesialis_id}/{hari}")
def read_items(spesialis_id: int ,rs_id: int, hari: str, db: Session = Depends(get_db)):
    data_dokter = crud.get_dokter_by_rs_spesialis_jadwal(db, spesialis_id, rs_id, hari)
    return data_dokter

## Jadwal Dokter
@app.get("/jadwal_dokter/{dokter_id}/{rs_id}")
def read_jadwal(dokter_id:int, rs_id:int, db: Session = Depends(get_db)):
    return crud.get_jadwal_dokter(db=db, dokter_id=dokter_id, rs_id=rs_id)


@app.get("/jadwal_dokter_online/{dokter_id}")
def read_jadwal(dokter_id:int, db: Session = Depends(get_db)):
    return crud.get_jadwal_dokter_Online(db=db, dokter_id=dokter_id)

@app.get("/jadwal_dokter_panggil_dokter_by_dokter/{dokter_id}")
def read_jadwal(dokter_id:int, db: Session = Depends(get_db)):
    return crud.get_jadwal_dokter_panggil_dokter_by_dokter(db=db, dokter_id=dokter_id)

@app.get("/jadwal_dokter_panggil_dokter/{waktu}/{hari}/{spesialis}")
def read_jadwal(waktu:str, hari:str, spesialis:int, db: Session = Depends(get_db)):
    print (hari)
    print (spesialis)
    print (waktu)
    return crud.get_jadwal_dokter_panggil_dokter(db=db, waktu=waktu, hari=hari, spesialis=spesialis)


## Jadwal Dokter by Hari
@app.get("/jadwal_dokter_by_hari/{dokter_id}/{rs_id}/{hari}")
def read_jadwal(dokter_id:int, rs_id:int, hari:str, db: Session = Depends(get_db)):
    return crud.get_jadwal_dokter_by_hari(db=db, dokter_id=dokter_id, rs_id=rs_id, hari=hari)

## Jadwal Dokter by Hari dan Jam
@app.get("/jadwal_dokter_by_hari_jam/{waktu}/{rs_id}/{hari}/{spesialis}")
def read_jadwal(waktu: str, rs_id: int, hari: str, spesialis: int, db: Session = Depends(get_db)):
    try:
        waktu_obj = datetime.strptime(waktu, "%H:%M").time()
    except ValueError:
        raise HTTPException(status_code=400, detail="Format waktu tidak valid. Harap gunakan format: 'HH:MM'")
    
    return crud.get_jadwal_dokter_by_hari_jam(db=db, waktu=waktu_obj, rs_id=rs_id, hari=hari, spesialis=spesialis)

## Jadwal Dokter by Hari, Spesialis dan Jam 
@app.get("/jadwal_dokter_daring/{waktu}/{hari}/{spesialis}")
def read_jadwal(waktu:str, hari:str, spesialis:int, db: Session = Depends(get_db)):
    return crud.get_jadwal_dokter_daring(db=db, waktu=waktu, hari=hari, spesialis=spesialis)

path_image = "../img/dokter/"
@app.get("/dokter_image/{dokter_id}")
def read_image(dokter_id:int,  db: Session = Depends(get_db)):
    
    FotoDokter = crud.get_Dokter_by_id(db,dokter_id)
    if not(FotoDokter):
        raise HTTPException(status_code=404, detail="id tidak valid")
    nama_image =  FotoDokter.foto
    if not(path.exists(path_image+nama_image)):
        print(path_image+nama_image)
        raise HTTPException(status_code=404, detail="File dengan nama tersebut tidak ditemukan")
    
    fr =  FileResponse(path_image+nama_image)
    return fr  

## Rekam Medis
@app.get("/rekam_medis/{user_id}")
def read_items(user_id: int, db: Session = Depends(get_db)):
    rekam_medis = crud.get_rekam_medis(db, user_id)
    return rekam_medis

## Rating
@app.get("/rating/{dokter_id}")
def read_items(dokter_id: int, db: Session = Depends(get_db)):
    ratings = crud.get_rating_dokter(db, dokter_id)
    return ratings

@app.post("/ratings/", response_model=schemas.Rating)
def create_rating(beri_rating: schemas.RatingCreate, db: Session = Depends(get_db)):
    return crud.add_rating(db=db, beri_rating=beri_rating)

## InfoUser
@app.get("/infoUser/{user_id}")
def read_info(user_id: int, db: Session = Depends(get_db)):
    infoUser = crud.get_infoUser(db, user_id)
    return infoUser

path_imageU = "../img/user/"
@app.get("/user_image/{infoUser_id}")
def read_image(infoUser_id:int,  db: Session = Depends(get_db)):
    
    FotoUser = crud.get_infoUser_by_id(db,infoUser_id)
    if not(FotoUser):
        raise HTTPException(status_code=404, detail="id tidak valid")
    nama_imageU =  FotoUser.foto
    if not(path.exists(path_imageU+nama_imageU)):
        raise HTTPException(status_code=404, detail="File dengan nama tersebut tidak ditemukan")
    
    fr =  FileResponse(path_imageU+nama_imageU)
    return fr  

@app.put("/infoUser/{user_id}", response_model= schemas.UpdateInfoUser)
def update_info_user(user_id: int, user_data: schemas.UpdateInfoUser, db: Session = Depends(get_db)):
    db_user = crud.get_infoUser_by_userId(db, user_id)
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    return crud.update_infoUser(db, user_id, user_data)

## Spesialis
@app.get("/spesialis/", response_model=list[schemas.Spesialis])
def read_items(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    data = crud.get_Spesialis(db, skip=skip, limit=limit)
    return data

path_icon = "../img/spesialis/"
@app.get("/spesialis_icon/{id}")
def read_image(id:int,  db: Session = Depends(get_db)):
    
    spesialis = crud.get_spesialis_by_id(db,id)
    if not(spesialis):
        raise HTTPException(status_code=404, detail="id tidak valid")
    nama_image =  spesialis.icon 
    if not(path.exists(path_icon+nama_image)):
        raise HTTPException(status_code=404, detail="File dengan nama tersebut tidak ditemukan")
        
    fr =  FileResponse(path_icon+nama_image)
    return fr

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

@app.put("/user/{user_id}", response_model= schemas.UpdateUser)
def update_user(user_id: int, user_data: schemas.UpdateUser, db: Session = Depends(get_db)):
    db_user = crud.get_user_by_id(db, user_id)
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    return crud.update_user(db, user_id, user_data)

######################## AUTH

# periksa apakah username ada dan passwordnya cocok
# return boolean TRUE jika username dan password cocok
def authenticate(db,user: schemas.UserCreate):
    user_cari = crud.get_user_by_email(db=db, email=user.email)
    if user_cari:
        return (user_cari.password == crud.hashPassword(user.password))
    else:
        return False    
    
# Jadwal Janji Temu
@app.post("/jadwal_janji_temu/", response_model=schemas.JadwalJanjiTemu)
def create_jadwal(jadwal: schemas.JadwalJanjiTemuBase, db: Session = Depends(get_db)):
    return crud.create_jadwal_janji_temu(db=db, jadwal=jadwal)

@app.get("/jadwal_janji_temu/", response_model=List[schemas.JadwalJanjiTemu])
def read_jadwal(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return crud.get_jadwal_janji_temu(db=db, skip=skip, limit=limit)

@app.get("/jadwal_janji_temu_by_id/{jadwal_id}", response_model=schemas.JadwalJanjiTemu)
def read_jadwal_by_id(jadwal_id: int, db: Session = Depends(get_db)):
    db_jadwal = crud.get_jadwal_janji_temu_by_id(db, jadwal_id=jadwal_id)
    if db_jadwal is None:
        raise HTTPException(status_code=404, detail="Jadwal not found")
    return db_jadwal

@app.get("/jadwal_janji_temu_by_user/{user_id}")
def read_jadwal_by_id(user_id: int, db: Session = Depends(get_db)):
    db_jadwal = crud.get_jadwal_janji_temu_by_idUser(db, user_id=user_id)
    if db_jadwal is None:
        raise HTTPException(status_code=404, detail="Jadwal not found")
    return db_jadwal

# Jadwal Konsultasi Online
@app.post("/jadwal_konsul_online/", response_model=schemas.JadwalkonsulOnline)
def create_jadwal(jadwal: schemas.JadwalkonsulOnlineBase, db: Session = Depends(get_db)):
    return crud.create_jadwal_konsul_online(db=db, jadwal=jadwal)

@app.get("/jadwal_konsul_online_by_user/{user_id}")
def read_jadwal_by_id(user_id: int, db: Session = Depends(get_db)):
    db_jadwal = crud.get_jadwal_konsul_online_by_idUser(db, user_id=user_id)
    if db_jadwal is None:
        raise HTTPException(status_code=404, detail="Jadwal not found")
    return db_jadwal
    
# Jadwal Panggil Dokter
@app.post("/jadwal_panggil_dokter/", response_model=schemas.JadwalPanggilDokter)
def create_jadwal(jadwal: schemas.JadwalPanggilDokterBase, db: Session = Depends(get_db)):
    return crud.create_jadwal_panggil_dokter(db=db, jadwal=jadwal)

@app.get("/jadwal_panggil_dokter_by_user/{user_id}")
def read_jadwal_by_id(user_id: int, db: Session = Depends(get_db)):
    db_jadwal = crud.get_jadwal_panggil_dokter_by_idUser(db, user_id=user_id)
    if db_jadwal is None:
        raise HTTPException(status_code=404, detail="Jadwal not found")
    return db_jadwal
    
# Status Rawat Jalan
@app.get("/status_rawat_jalan/", response_model=List[schemas.StatusRawatJalan])
def read_status_rawat_jalan(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    status_rawat_jalan_list = crud.get_status_rawat_jalan(db, skip=skip, limit=limit)
    return status_rawat_jalan_list

@app.get("/status_rawat_jalan/{status_rawat_jalan_id}", response_model=schemas.StatusRawatJalan)
def get_status_rawat_jalan_by_id(status_rawat_jalan_id: int, db: Session = Depends(get_db)):
    db_status_rawat_jalan = db.query(models.StatusRawatJalan).filter(models.StatusRawatJalan.id_status == status_rawat_jalan_id).first()
    if db_status_rawat_jalan is None:
        raise HTTPException(status_code=404, detail="StatusRawatJalan not found")
    return db_status_rawat_jalan


# Pembayaran
@app.get("/pembayaran/", response_model=List[schemas.Pembayaran])
def read_pembayaran(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    pembayaran_list = crud.get_pembayaran(db, skip=skip, limit=limit)
    return pembayaran_list

@app.post("/create_pembayaran/", response_model=schemas.Pembayaran)
def create_pembayaran(pembayaran: schemas.PembayaranBase, db: Session = Depends(get_db)):
    return crud.create_pembayaran(db=db, pembayaran=pembayaran)

@app.get("/pembayaran/{pembayaran_id}", response_model=schemas.Pembayaran)
def get_pembayaran_by_id(pembayaran_id: int, db: Session = Depends(get_db)):
    db_pembayaran = db.query(models.Pembayaran).filter(models.Pembayaran.id == pembayaran_id).first()
    if db_pembayaran is None:
        raise HTTPException(status_code=404, detail="StatusRawatJalan not found")
    return db_pembayaran

# Obat
@app.get("/obat")
def read_obat(db:Session = Depends(get_db)):
    jadwal_obat_list = crud.get_obat(db=db)
    return jadwal_obat_list

# Jadwal Obat
@app.get("/jadwal_obat/{user_id}")
def read_jadwal_obat(user_id:int, db:Session = Depends(get_db)):
    jadwal_obat_list = crud.get_jadwal_obat_by_user(db=db, user_id=user_id)
    return jadwal_obat_list

# Metode Pembayaran
@app.get("/metode_pembayaran/")
def read_metode_pembayaran(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    metode_list = crud.get_metode_pembayaran(db, skip=skip, limit=limit)
    return metode_list

# Lab
@app.get("/daftar_lab/")
def read_lab(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    lab_list = crud.get_Lab(db, skip=skip, limit=limit)
    return lab_list

@app.get("/jadwal_lab_by_idrs/{rs_id}/{id_lab}")
def read_items(id_lab: int ,rs_id: int, db: Session = Depends(get_db)):
    data = crud.get_jadwal_lab_by_idrs(db, id_lab=id_lab, rs_id=rs_id)
    return data

# Status rawat jalan user
@app.get("/status_rawat_jalan_user/{jadwal_janji_temu_id}")
def read_items(jadwal_janji_temu_id: int, db: Session = Depends(get_db)):
    data = crud.get_statusRawatJalanUser(db, id_jadwal_janji_temu=jadwal_janji_temu_id)
    return data

@app.patch("/status_rawat_jalan_user/{jadwal_janji_temu_id}")
def update_status(jadwal_janji_temu_id: int, status_data: dict, db: Session = Depends(get_db)):
    status_user = db.query(models.StatusUser).filter(models.StatusUser.id_janjiTemu == jadwal_janji_temu_id).first()
    if status_user:
        status_user.id_statusRawatJalan = status_data['id_statusRawatJalan']
        db.commit()
        db.refresh(status_user)
    return status_user