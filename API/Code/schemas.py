from pydantic import BaseModel
from datetime import date


# item
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