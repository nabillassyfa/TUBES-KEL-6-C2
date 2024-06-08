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
    spesialis: int 
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
  
  
# Spesialis
class SpesialisBase(BaseModel):
    spesialis: str
    icon:str

class Spesialis(SpesialisBase):
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
    golongan: str | None = None
    id_pengguna:int

class InfoUser(InfoUserBase):
    id_user: int
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
        
# Janji Temu
class JadwalJanjiTemuBase(BaseModel):
    id_user: int
    id_dokter: int
    id_rs: int
    id_spesialis: int
    tanggal: date
    waktu: time
    durasi: int

class JadwalJanjiTemuCreate(JadwalJanjiTemuBase):
    pass
class JadwalJanjiTemu(JadwalJanjiTemuBase):
    id: int

    class Config:
        orm_mode = True
        
# Status Rawat Jalan
class StatusRawatJalanBase(BaseModel):
    id_user: int
    keterangan_status: str
    deskripsi: str
    
class StatusRawatJalan(StatusRawatJalanBase):
    id_status: int
    
    class Config:
        orm_mode = True

# Jadwal Dokter
class JadwalDokterBase(BaseModel):
    hari: str
    waktu_mulai: time
    waktu_berakhir: time
    id_dokter: int
    id_RS: int
        
class JadwalDokter(JadwalDokterBase):
    id: int
    
    class Config:
        orm_mode = True

class PembayaranBase(BaseModel):
    id_user: int
    waktu_pembayaran: datetime
    metode_pembayaran: str
    total_pembayaran: int
    statys: str
        
class Pembayaran(PembayaranBase):
    id: int
    
    class Config:
        orm_mode = True