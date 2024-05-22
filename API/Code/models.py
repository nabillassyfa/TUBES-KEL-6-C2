from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, Nullable, String, func
from sqlalchemy.orm import relationship
from sqlalchemy.orm import Mapped
from typing import List
from sqlalchemy import Table
from sqlalchemy import Date, DateTime

class RS(BaseDB):
    __tablename__ = "RS"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    deskripsi = Column(String, index=True)
    lokasi = Column(String,nullable=False)
    fasilitas = Column(String,nullable=False)
    img = Column(String)
    
class Dokter(BaseDB):
    __tablename__ = "dokter"
    id = Column(Integer, primary_key=True)
    nama =  Column(String, index=True)
    spesialis = Column(String, index=True)
    foto = Column(String, index=True)
    informasi = Column(String,nullable=False)
    pengalaman = Column(Integer)
    
    rekam_medis = relationship("RekamMedis", back_populates="dokter")
    rating = relationship("Rating", back_populates="dokter")
    
class RekamMedis(BaseDB):
    __tablename__ = "rekam_medis"
    id = Column(Integer, primary_key=True)
    keterangan = Column(String, index=True)
    catatan_dokter = Column(String, index=True)
    tanggal = Column(DateTime, nullable=False)
    id_user = Column(Integer, ForeignKey('user.id'))
    id_dokter = Column(Integer, ForeignKey('dokter.id'))
    obat = Column(String, index=True)

    dokter = relationship("Dokter", back_populates="rekam_medis")
    user = relationship("User", back_populates="rekam_medis")

class Rating(BaseDB):
    __tablename__ = "rating"
    id = Column(Integer, primary_key=True)
    rating = Column(String, index=True)
    pesan = Column(String, index=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    id_dokter = Column(Integer, ForeignKey('dokter.id'))
    
    dokter = relationship("Dokter", back_populates="rating")
    user = relationship("User", back_populates="rating")
    

class InfoUser(BaseDB):
    __tablename__ = "infoUser"
    id = Column(Integer, primary_key=True)
    jenis_kelamin = Column(String, index=True)
    umur = Column(Integer, index=True)
    berat_badan = Column(Integer, index=True)
    tanggal_lahir = Column(Date, index=True)
    tinggi_badan = Column(Integer, index=True)
    golongan_darah = Column(String, index=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    
    user = relationship("User", back_populates="infoUser")
    

class Artikel(BaseDB):
    __tablename__ = "Artikel"
    id = Column(Integer, primary_key=True)
    judul = Column(String, index=True)
    abstrak = Column(String, index=True)
    hasil = Column(String,nullable=False)
    kesimpulan = Column(String,nullable=False)
    penerbit = Column(String,nullable=False)
    penulis = Column(String,nullable=False)
    img = Column(String)  
    tanggal = Column(Date, nullable=False, index=True)

class User(BaseDB):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    username = Column(String, index=True)
    password = Column(String)
    email = Column(String, index=True, unique=True)
    no_telp = Column(String, index=True)
    
    rekam_medis = relationship("RekamMedis", back_populates="user")
    rating = relationship("Rating", back_populates="user")
    infoUser = relationship("InfoUser", back_populates="user")