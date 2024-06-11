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
    catatan_dokter: str
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
    pesan: str | None = None
    id_dokter:int
    id_user:int

class RatingCreate(RatingBase):
    pass

class Rating(RatingBase):
    id: int
    class Config:
        orm_mode = True

# InfoUser
class InfoUserBase(BaseModel):
    jenis_kelamin: str | None = None
    umur: int | None = None
    berat_badan: float | None = None
    tanggal_lahir: date | None = None
    tinggi_badan: float | None = None
    golongan_darah: str | None = None
    id_user:int
    alamat:str
    foto:str
    
class UpdateInfoUserBase(BaseModel):
    jenis_kelamin: str | None = None
    umur: int | None = None
    berat_badan: float | None = None
    tanggal_lahir: date | None = None
    tinggi_badan: float | None = None
    golongan_darah: str | None = None
    alamat:str
    foto:str

class InfoUser(InfoUserBase):
    id: int
    class Config:
        orm_mode = True

class UpdateInfoUser(UpdateInfoUserBase):
    id: int
    id_user:int
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

class UpdateUserBase(BaseModel):
    nama: str
    no_telp: str

class UpdateUser(UpdateUserBase):
    id: int
    class Config:
        orm_mode = True
        
# Janji Temu
class JadwalJanjiTemuBase(BaseModel):
    id_user: int
    id_jadwal_dokter: int
    tanggal: date
    durasi: int

class JadwalJanjiTemu(JadwalJanjiTemuBase):
    id: int

    class Config:
        orm_mode = True
        
# Konsul Online
class JadwalkonsulOnlineBase(BaseModel):
    id_user: int
    tanggal: date
    durasi: int
    link_video_call: str
    id_jadwal_dokter_online: int

class JadwalkonsulOnline(JadwalkonsulOnlineBase):
    id: int

    class Config:
        orm_mode = True
        
# Panggil dokter
class JadwalPanggilDokterBase(BaseModel):
    id_user: int
    tanggal: date
    id_jadwal_dokter_panggil_dokter: int
    alamat: str

class JadwalPanggilDokter(JadwalPanggilDokterBase):
    id: int

    class Config:
        orm_mode = True
        
# Status Rawat Jalan
class StatusRawatJalanBase(BaseModel):
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

# Jadwal Dokter Online
class JadwalDokterOnlineBase(BaseModel):
    hari: str
    waktu_mulai: time
    waktu_berakhir: time
    id_dokter: int
        
class JadwalDokterOnline(JadwalDokterOnlineBase):
    id: int
    
    class Config:
        orm_mode = True
        
class JadwalDokterPanggilDokterBase(BaseModel):
    hari: str
    waktu_mulai: time
    waktu_berakhir: time
    id_dokter: int
        
class JadwalDokterPanggilDokter(JadwalDokterPanggilDokterBase):
    id: int
    
    class Config:
        orm_mode = True
        
class PembayaranBase(BaseModel):
    id_user: int
    waktu_pembayaran: datetime
    metode_pembayaran: str
    total_pembayaran: int
    status: str
    item: str
        
class Pembayaran(PembayaranBase):
    id: int
    
    class Config:
     orm_mode = True

# Obat
class ObatBase(BaseModel):
    nama: str
    harga: int
    keterangan: str

class Obat(ObatBase):
    id: int
    
    class Config:
     orm_mode = True

class JadwalObatBase(BaseModel):
    id_obat: int
    kondisi_makan: str
    takaran: str
    id_user: int

class JadwalObat(JadwalObatBase):
    id: int
    
    class Config:
     orm_mode = True

class JadwalObatKonsumsiBase(BaseModel):
    id_jadwal_obat: int
    waktu: time

class JadwalObatKonsumsi(JadwalObatKonsumsiBase):
    id: int
    
    class Config:
     orm_mode = True
     
# Lab
class LabBase(BaseModel):
    nama: str
    kategori : str
    deskripsi : str
    harga : str
        
class Lab(JadwalDokterBase):
    id: int
    
    class Config:
        orm_mode = True
        
class JadwalLabBase(BaseModel):
    hari: str
    waktu_mulai: time
    waktu_berakhir: time
    id_lab: int
    id_rs: int
        
class JadwalLab(JadwalDokterBase):
    id: int
    
    class Config:
        orm_mode = True

# Status User
class StatusUserBase(BaseModel):
    id_janjiTemu: int
    id_statusRawatJalan: int

class StatusUser(StatusUserBase):
    id: int

    class Config:
        orm_mode = True