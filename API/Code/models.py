from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, func
from sqlalchemy.orm import relationship
from sqlalchemy.orm import Mapped
from typing import List
from sqlalchemy import Table
from sqlalchemy import Date, DateTime, Time

class RS(BaseDB):
    __tablename__ = "RS"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    deskripsi = Column(String, index=True)
    lokasi = Column(String,nullable=False)
    fasilitas = Column(String,nullable=False)
    img = Column(String)

    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="RS")
    
    DataRS = relationship("DaftarRS", back_populates="Rs")
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="rs")
    
class Dokter(BaseDB):
    __tablename__ = "dokter"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    spesialis = Column(Integer, ForeignKey('spesialis.id'))
    foto = Column(String, index=True)
    informasi = Column(String, nullable=False)
    pengalaman = Column(Integer)
    
    spesialis_ref = relationship("Spesialis", back_populates="dokter")
    rekam_medis = relationship("RekamMedis", back_populates="dokter")
    rating = relationship("Rating", back_populates="dokter")
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="dokter")
    
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


class Spesialis(BaseDB):
    __tablename__ = "spesialis"
    id = Column(Integer, primary_key=True)
    spesialis = Column(String, index=True)
    icon = Column(String, index=True)
    
    dokter = relationship("Dokter", back_populates="spesialis_ref")
<<<<<<< HEAD
    dataSpesialis = relationship("DaftarRS", back_populates="Spesialis")
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="spesialis")
=======
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="spesialis_ref")

>>>>>>> 753958fad54f30ae62234f4499d50b6121f06ade
       
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
    id_user = Column(Integer, primary_key=True)  # Menggunakan id_user sebagai primary key
    jenis_kelamin = Column(String, index=True)
    umur = Column(Integer, index=True)
    berat_badan = Column(Integer, index=True)
    tanggal_lahir = Column(Date, index=True)
    tinggi_badan = Column(Integer, index=True)
    golongan = Column(String, index=True)
    id_pengguna = Column(Integer, ForeignKey('user.id'))  # Foreign key ke user

    user = relationship("User", back_populates="infoUser")

    
class DaftarRS(BaseDB):
    __tablename__ = "daftarRS"
    id = Column(Integer, primary_key=True)
    id_spesialis = Column(Integer, ForeignKey('spesialis.id'))
    id_RS = Column(Integer, ForeignKey('RS.id'))
    
    Spesialis = relationship("Spesialis", back_populates="dataSpesialis")
    Rs = relationship("RS", back_populates="DataRS")
    

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
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="user")

<<<<<<< HEAD

=======
>>>>>>> 753958fad54f30ae62234f4499d50b6121f06ade
class JadwalJanjiTemu(BaseDB):
    __tablename__ = "jadwal_janji_temu"
    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    id_dokter = Column(Integer, ForeignKey('dokter.id'))
    id_rs = Column(Integer, ForeignKey('RS.id'))
    id_spesialis = Column(Integer, ForeignKey('spesialis.id'))
    tanggal = Column(Date, nullable=False, index=True)
    waktu = Column(Time, nullable=False)
    durasi = Column(Integer, index=True)

    dokter = relationship("Dokter", back_populates="jadwal_janji_temu")
    user = relationship("User", back_populates="jadwal_janji_temu")
    rs = relationship("RS", back_populates="jadwal_janji_temu")
    spesialis = relationship("Spesialis", back_populates="jadwal_janji_temu")