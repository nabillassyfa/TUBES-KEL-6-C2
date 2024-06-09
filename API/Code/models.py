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

    daftarRS = relationship("DaftarRS", back_populates="RS")
    jadwal_dokter = relationship("JadwalDokter", back_populates="RS")
    
class Dokter(BaseDB):
    __tablename__ = "dokter"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    id_spesialis = Column(Integer, ForeignKey('spesialis.id'))
    foto = Column(String, index=True)
    informasi = Column(String, nullable=False)
    pengalaman = Column(Integer)
    
    spesialis = relationship("Spesialis", back_populates="dokter")
    rekam_medis = relationship("RekamMedis", back_populates="dokter")
    rating = relationship("Rating", back_populates="dokter")
    jadwal_dokter = relationship("JadwalDokter", back_populates="dokter")
    
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
    
    dokter = relationship("Dokter", back_populates="spesialis")
    daftarRS = relationship("DaftarRS", back_populates="spesialis")

       
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
    id = Column(Integer, primary_key=True)  # Menggunakan id_user sebagai primary key
    jenis_kelamin = Column(String, index=True)
    umur = Column(Integer, index=True)
    berat_badan = Column(Integer, index=True)
    tanggal_lahir = Column(Date, index=True)
    tinggi_badan = Column(Integer, index=True)
    golongan_darah = Column(String, index=True)
    id_user = Column(Integer, ForeignKey('user.id'))  # Foreign key ke user

    user = relationship("User", back_populates="infoUser")

    
class DaftarRS(BaseDB):
    __tablename__ = "daftarRS"
    id = Column(Integer, primary_key=True)
    id_spesialis = Column(Integer, ForeignKey('spesialis.id'))
    id_RS = Column(Integer, ForeignKey('RS.id'))
    
    spesialis = relationship("Spesialis", back_populates="daftarRS")
    RS = relationship("RS", back_populates="daftarRS")
    

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
    status_rawatJalan = relationship("StatusRawatJalan", back_populates="user")
    pembayaran = relationship("Pembayaran", back_populates="user")
    jadwal_obat = relationship("JadwalObat", back_populates="user")

class JadwalJanjiTemu(BaseDB):
    __tablename__ = "jadwal_janji_temu"
    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    id_jadwal_dokter = Column(Integer, ForeignKey('jadwal_dokter.id'))
    tanggal = Column(Date, nullable=False, index=True)
    durasi = Column(Integer, index=True)

    user = relationship("User", back_populates="jadwal_janji_temu")
    jadwal_dokter = relationship("JadwalDokter", back_populates="jadwal_janji_temu")
    

class StatusRawatJalan(BaseDB):
    __tablename__ = "status_rawat_jalan"
    id_status = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    keterangan_status = Column(String, index=True)
    deskripsi = Column(String, index=True)
    
    user = relationship("User", back_populates="status_rawatJalan")
    

class JadwalDokter(BaseDB):
    __tablename__ = "jadwal_dokter"
    id = Column(Integer, primary_key=True)
    hari = Column(String, index=True)
    waktu_mulai = Column(Time, index=True)
    waktu_berakhir = Column(Time, index=True)
    id_dokter = Column(Integer, ForeignKey('dokter.id'))
    id_RS = Column(Integer, ForeignKey('RS.id'))
    
    dokter = relationship("Dokter", back_populates="jadwal_dokter")
    RS = relationship("RS", back_populates="jadwal_dokter")
    jadwal_janji_temu = relationship("JadwalJanjiTemu", back_populates="jadwal_dokter")

class Pembayaran(BaseDB):
    __tablename__ = "pembayaran"
    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('user.id'))
    waktu_pembayaran = Column(DateTime, nullable=False, index=True)
    metode_pembayaran = Column(String, index=True)
    total_pembayaran = Column(Integer, index=True)
    status = Column(String, index=True)
     
    user = relationship("User", back_populates="pembayaran")


class Obat(BaseDB):
    __tablename__ = "obat"
    id = Column(Integer, primary_key=True)
    nama = Column(String, index=True)
    harga = Column(Integer, index=True)
    keterangan = Column(String, index=True)

    jadwal_obat = relationship("JadwalObat", back_populates="obat")

class JadwalObat(BaseDB):
    __tablename__ = "jadwal_obat"
    id = Column(Integer, primary_key=True)
    id_obat = Column(Integer, ForeignKey('obat.id'))
    kondisi_makan = Column(String, index=True)
    takaran = Column(String, index=True)
    id_user = Column(Integer, ForeignKey('user.id'))

    user = relationship("User", back_populates="jadwal_obat")
    obat = relationship("Obat", back_populates="jadwal_obat")
    jadwal_obat_konsumsi = relationship("JadwalObatKonsumsi", back_populates="jadwal_obat")

class JadwalObatKonsumsi(BaseDB):
    __tablename__ = "jadwal_obat_konsumsi"
    id = Column(Integer, primary_key=True)
    id_jadwal_obat = Column(Integer, ForeignKey('jadwal_obat.id'))
    waktu = Column(Time, index=True)

    jadwal_obat = relationship("JadwalObat", back_populates="jadwal_obat_konsumsi")

class MetodePembayaran(BaseDB):
    __tablename__ = "metode_pembayaran"
    id = Column(Integer, primary_key=True)
    nama_pembayaran = Column(String, index=True)