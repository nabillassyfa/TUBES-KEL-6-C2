from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, Nullable, String, func
from sqlalchemy.orm import relationship
from sqlalchemy.orm import Mapped
from typing import List
from sqlalchemy import Table
from sqlalchemy import Date

class RS(BaseDB):
    __tablename__ = "RS"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    deskripsi = Column(String, index=True)
    lokasi = Column(String,nullable=False)
    fasilitas = Column(String,nullable=False)
    img = Column(String)  


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