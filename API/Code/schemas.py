from pydantic import BaseModel
from datetime import date, datetime, time


# RS
class RSBase(BaseModel):
    nama: str
    deskripsi: str | None = None
    lokasi: str
    fasilitas:str
    img:str

class RS(RSBase):
    id: int
    class Config:
        orm_mode = True
        
# Artikel
class ArtikelBase(BaseModel):
    judul: str
    abstrak: str | None = None
    hasil: str | None = None
    kesimpulan:str | None = None
    penulis:str
    penerbit:str
    tanggal:date
    img:str

class Artikel(ArtikelBase):
    id: int
    class Config:
        orm_mode = True
        
# Dokter
class DokterBase(BaseModel):
    nama: str
    spesialis: str 
    informasi: str | None = None
    pengalaman: int
    foto:str

class Dokter(DokterBase):
    id: int
    class Config:
        orm_mode = True


# Rekam Medis
class RekamMedisBase(BaseModel):
    keterangan: str
    catatan_dokter: str | None = None
    obat:str
    tanggal:datetime
    id_dokter:int
    id_user:int

class RekamMedis(RekamMedisBase):
    id: int
    class Config:
        orm_mode = True
   
   
# Rating
class RatingBase(BaseModel):
    rating: float
    keterangan: str | None = None
    id_dokter:int
    id_user:int

class Rating(RatingBase):
    id: int
    class Config:
        orm_mode = True

# InfoUser
class InfoUserBase(BaseModel):
    jenis_kelamin: str | None = None
    umur: int | None = None
    berat_badan: int | None = None
    tanggal_lahir: date | None = None
    tinggi_badan: int | None = None
    golongan_darah: str | None = None
    id_user:int

class InfoUser(InfoUserBase):
    id: int
    class Config:
        orm_mode = True
             
# User
class UserBase(BaseModel):
    nama: str
    username: str
    email: str
    no_telp: str

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    class Config:
        orm_mode = True

class UserLogBase(BaseModel):
    email: str

class UserLog(UserLogBase):
    password: str

class UserL(UserBase):
    id: int
    class Config:
        orm_mode = True

class JadwalJanjiTemuBase(BaseModel):
    id_user: int
    id_dokter: int
    id_rs: int
    tanggal: date
    waktu: time
    durasi: int

class JadwalJanjiTemuCreate(JadwalJanjiTemuBase):
    pass

class JadwalJanjiTemu(JadwalJanjiTemuBase):
    id: int

    class Config:
        orm_mode = True