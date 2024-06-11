from sqlalchemy.orm import Session
import models, schemas
import bcrypt
from datetime import time
from sqlalchemy import desc
from datetime import datetime

SALT = b'$2b$12$rX.6REj.knvtNtaqkPT1cu'

# RS
def get_RS(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.RS).offset(skip).limit(limit).all()

def get_RS_by_id(db: Session, rs_id: int):
    return db.query(models.RS).filter(models.RS.id == rs_id).first()

# Artikel
def get_Artikel(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Artikel).offset(skip).limit(limit).all()

#dokter
def get_Dokter(db: Session, skip: int = 0, limit: int = 100):
    results = (
        db.query(
            models.Dokter,
            models.Spesialis.spesialis.label("spesialis_name")
        )
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .offset(skip).limit(limit)
        .all()
    )

    dokter_list = []
    for dokter, spesialis_name in results:
        dokter_dict = {
            "id": dokter.id,
            "nama": dokter.nama,
            "spesialis": dokter.spesialis,
            "foto": dokter.foto,
            "informasi": dokter.informasi,
            "pengalaman": dokter.pengalaman,
            "nama_spesialis": spesialis_name,
        }
        dokter_list.append(dokter_dict)

    return dokter_list

def get_Dokter_by_id(db: Session, dokter_id: int):
    return db.query(models.Dokter).filter(models.Dokter.id == dokter_id).first()

def get_Dokter_by_id_withS(db: Session, dokter_id:int):
    results = (
        db.query(
            models.Dokter,
            models.Spesialis.spesialis.label("spesialis_name")
        )
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .filter(models.Dokter.id == dokter_id)
        .first()
    )

    dokter, spesialis_name = results

    # Membuat dictionary untuk dokter
    dokter_dict = {
        "id": dokter.id,
        "nama": dokter.nama,
        "spesialis": dokter.spesialis,
        "foto": dokter.foto,
        "informasi": dokter.informasi,
        "pengalaman": dokter.pengalaman,
        "nama_spesialis": spesialis_name,
    }

    return dokter_dict

def get_dokter_by_rs_spesialis(db: Session, id_spesialis: int, id_rs: int):
    results = (
        db.query(
            models.Dokter,
            models.Spesialis.spesialis.label("spesialis_name"),
            models.RS.nama.label("rs_name"),
        )
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .join(models.RS, models.JadwalDokter.id_RS == models.RS.id)
        .join(models.JadwalDokter, models.Dokter.id == models.JadwalDokter.id_dokter)
        .filter(models.Spesialis.id == id_spesialis, 
                models.JadwalDokter.id_RS == id_rs)
        .all()
    )

    dokter_list = []
    for dokter, spesialis_name, rs_name in results:
        dokter_dict = {
            "id": dokter.id,
            "nama": dokter.nama,
            "spesialis": id_spesialis,
            "foto": dokter.foto,
            "informasi": dokter.informasi,
            "pengalaman": dokter.pengalaman,
            "namaSpesialis": spesialis_name,
            "id_rs": id_rs,
            "namaRs": rs_name
        }
        dokter_list.append(dokter_dict)

    return dokter_list

def get_dokter_by_rs_spesialis_jadwal(db: Session, id_spesialis: int, id_rs: int, hari: str):
    results = (
        db.query(
            models.Dokter,
            models.Spesialis.spesialis.label("spesialis_name"),
            models.RS.nama.label("rs_name"),
        )
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .join(models.RS, models.JadwalDokter.id_RS == models.RS.id)
        .join(models.JadwalDokter, models.Dokter.id == models.JadwalDokter.id_dokter)
        .filter(models.Spesialis.id == id_spesialis, 
                models.JadwalDokter.id_RS == id_rs,
                models.JadwalDokter.hari == hari,
                )
        .all()
    )

    dokter_list = []
    for dokter, spesialis_name, rs_name in results:
        dokter_dict = {
            "id": dokter.id,
            "nama": dokter.nama,
            "spesialis": id_spesialis,
            "foto": dokter.foto,
            "informasi": dokter.informasi,
            "pengalaman": dokter.pengalaman,
            "namaSpesialis": spesialis_name,
            "id_rs": id_rs,
            "namaRs": rs_name
        }
        dokter_list.append(dokter_dict)

    return dokter_list


# Spesialis ---------------------------------------------------------
def get_Spesialis(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Spesialis).offset(skip).limit(limit).all()

def get_spesialis_by_id(db: Session, id: int):
    return db.query(models.Spesialis).filter(models.Spesialis.id == id).first()

# Rekam Medis -------------------------------------------------------
def get_rekam_medis(db: Session, user_id: int):
    results = (
        db.query(
            models.RekamMedis,
            models.Dokter.nama.label("dokter_name"),
            models.User.nama.label("user_name"),
            models.Spesialis.spesialis.label("spesialis")  
        )
        .join(models.Dokter, models.RekamMedis.id_dokter == models.Dokter.id)
        .join(models.User, models.RekamMedis.id_user == models.User.id)
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id) 
        .filter(models.RekamMedis.id_user == user_id)
        .all()
    )
    rekam_medis_list = []
    for rekam_medis, dokter_name, user_name, spesialis in results:
        rekam_medis_dict = {
            "id": rekam_medis.id,
            "keterangan": rekam_medis.keterangan,
            "catatan_dokter": rekam_medis.catatan_dokter,
            "tanggal": rekam_medis.tanggal,
            "id_user": rekam_medis.id_user,
            "id_dokter": rekam_medis.id_dokter,
            "obat": rekam_medis.obat,
            "dokter_nama": dokter_name,
            "user_nama": user_name,
            "spesialis": spesialis,
        }
        rekam_medis_list.append(rekam_medis_dict)

    return rekam_medis_list

# Daftar RS berdasarkan Spesialis ----------------------------------------------------------------
def get_RS_by_spesialis(db: Session, id: int):
    results = (
        db.query(
            models.DaftarRS,
            models.RS,
            models.Spesialis.spesialis.label("spesialis")
        )
        .join(models.RS, models.DaftarRS.id_RS == models.RS.id)
        .join(models.Spesialis, models.DaftarRS.id_spesialis == models.Spesialis.id)
        .filter(models.DaftarRS.id_spesialis == id)
        .all()
    )
    
    rs_list = []
    for daftar_rs, rs, spesialis in results:
        rs_dict = {
            "id": rs.id,
            "nama": rs.nama,
            "deskripsi": rs.deskripsi,
            "lokasi": rs.lokasi,
            "fasilitas": rs.fasilitas,
            "img": rs.img,
        }
        rs_list.append(rs_dict)

    return rs_list

def get_spesialis_by_RS(db: Session, id: int):
    results = (
        db.query(
            models.DaftarRS,
            models.RS,
            models.Spesialis
        )
        .join(models.RS, models.DaftarRS.id_RS == models.RS.id)
        .join(models.Spesialis, models.DaftarRS.id_spesialis == models.Spesialis.id)
        .filter(models.DaftarRS.id_RS == id)
        .all()
    )
    
    spesialis_list = []
    for daftar_rs, rs, spesialis in results:
        spesialis_dict = {
            "id": spesialis.id,
            "spesialis": spesialis.spesialis,
        }
        spesialis_list.append(spesialis_dict)

    return spesialis_list



# Rating
def add_rating(db: Session, beri_rating: schemas.RatingCreate):
    db_rating = models.Rating(
        pesan=beri_rating.pesan, 
        rating=beri_rating.rating, 
        id_user=beri_rating.id_user, 
        id_dokter=beri_rating.id_dokter
    )
    db.add(db_rating)
    db.commit()
    db.refresh(db_rating)
    return db_rating


def get_rating_dokter(db: Session, dokter_id: int):
    results = (
        db.query(
            models.Rating,
            models.Dokter.nama.label("nama_dokter"),
            models.User.nama.label("nama_user"),
            models.InfoUser.id.label("info_user_id")  # Tambahkan InfoUser.id ke hasil query
        )
        .join(models.Dokter, models.Rating.id_dokter == models.Dokter.id)
        .join(models.User, models.Rating.id_user == models.User.id)
        .join(models.InfoUser, models.InfoUser.id_user == models.User.id)  # Join dengan InfoUser
        .filter(models.Rating.id_dokter == dokter_id)
        .all()
    )

    rating_dokter_list = []
    for rating_dokter, nama_dokter, nama_user, info_user_id in results:
        rating_dokter_dict = {
            "id": rating_dokter.id,
            "pesan": rating_dokter.pesan,
            "rating": rating_dokter.rating,
            "id_user": rating_dokter.id_user,
            "id_dokter": rating_dokter.id_dokter,
            "nama_dokter": nama_dokter,
            "nama_user": nama_user,
            "info_user_id": info_user_id  # Masukkan info_user_id ke dalam dictionary
        }
        rating_dokter_list.append(rating_dokter_dict)

    return rating_dokter_list


# Jadwal Dokter

# Jadwal Dokter
def get_jadwal_dokter(db: Session, dokter_id: int, rs_id:int):
    results = (
        db.query(
            models.JadwalDokter, 
            models.Dokter.nama.label("nama_dokter")
        )
        .join(models.Dokter, models.JadwalDokter.id_dokter == models.Dokter.id)
        .filter(models.JadwalDokter.id_dokter == dokter_id,
                models.JadwalDokter.id_RS == rs_id)
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "id_RS": jadwal_dokter.id_RS,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list

def get_jadwal_dokter_by_hari(db: Session, dokter_id: int, rs_id: int, hari: str):
    results = (
        db.query(
            models.JadwalDokter, models.Dokter.nama.label("nama_dokter")
        )
        .filter(models.JadwalDokter.id_dokter == dokter_id,
                models.JadwalDokter.id_RS == rs_id,
                models.JadwalDokter.hari==hari)
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "id_RS": jadwal_dokter.id_RS,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list


def get_jadwal_dokter_by_hari_jam(db: Session, waktu: time, rs_id: int, hari: str, spesialis:int):
    try:
        hari, _ = hari.split(", ")
    except ValueError:
        raise ValueError("Format input tidak valid. Harap gunakan format: 'Hari, DD MMMM YYYY'")
    
    results = (
        db.query(models.JadwalDokter, models.Dokter.nama.label("nama_dokter"))
        .join(models.Dokter, models.JadwalDokter.id_dokter == models.Dokter.id)
        .filter(
            models.JadwalDokter.id_RS == rs_id,
            models.JadwalDokter.hari == hari,
            models.JadwalDokter.waktu_mulai <= waktu,
            models.JadwalDokter.waktu_berakhir > waktu,
            models.Dokter.id_spesialis == spesialis,
        )
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "id_RS": jadwal_dokter.id_RS,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list

## Get Jadwal berdasarkan waktu, hari, dan spesialis
def get_jadwal_dokter_daring(db: Session, waktu: str, hari: str, spesialis:int):
    try:
        hari, _ = hari.split(", ")
    except ValueError:
        raise ValueError("Format input tidak valid. Harap gunakan format: 'Hari, DD MMMM YYYY'")
    
    results = (
        db.query(models.JadwalDokterOnline, models.Dokter.nama.label("nama_dokter"))
        .join(models.Dokter, models.JadwalDokterOnline.id_dokter == models.Dokter.id)
        .filter(
            models.JadwalDokterOnline.hari == hari,
            models.JadwalDokterOnline.waktu_mulai <= waktu,
            models.JadwalDokterOnline.waktu_berakhir > waktu,
            models.Dokter.id_spesialis == spesialis,
           
        )
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list


def get_jadwal_dokter_Online(db: Session, dokter_id: int):
    results = (
        db.query(
            models.JadwalDokterOnline, 
            models.Dokter.nama.label("nama_dokter")
        )
        .join(models.Dokter, models.JadwalDokterOnline.id_dokter == models.Dokter.id)
        .filter(models.JadwalDokterOnline.id_dokter == dokter_id)
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list

def get_jadwal_dokter_panggil_dokter_by_dokter(db: Session, dokter_id: int):
    results = (
        db.query(
            models.JadwalDokterPanggilDokter, 
            models.Dokter.nama.label("nama_dokter")
        )
        .join(models.Dokter, models.JadwalDokterPanggilDokter.id_dokter == models.Dokter.id)
        .filter(models.JadwalDokterPanggilDokter.id_dokter == dokter_id)
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list


def get_jadwal_dokter_panggil_dokter(db: Session, waktu: str, hari: str, spesialis:int):
    
    try:
        hari, _ = hari.split(", ")
    except ValueError:
        raise ValueError("Format input tidak valid. Harap gunakan format: 'Hari, DD MMMM YYYY'")
    
    results = (
        db.query(models.JadwalDokterPanggilDokter, models.Dokter.nama.label("nama_dokter"))
        .join(models.Dokter, models.JadwalDokterPanggilDokter.id_dokter == models.Dokter.id)
        .filter(
            models.JadwalDokterPanggilDokter.hari == hari,
            models.JadwalDokterPanggilDokter.waktu_mulai <= waktu,
            models.JadwalDokterPanggilDokter.waktu_berakhir > waktu,
            models.Dokter.id_spesialis == spesialis,
           
        )
        .all()
    )

    jadwal_dokter_list = []
    for jadwal_dokter, nama_dokter in results:
        jadwal_dokter_dict = {
            "id": jadwal_dokter.id,
            "hari": jadwal_dokter.hari,
            "waktu_mulai": jadwal_dokter.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_dokter.waktu_berakhir.strftime("%H:%M"),
            "id_dokter": jadwal_dokter.id_dokter,
            "nama_dokter" : nama_dokter,
        }
        jadwal_dokter_list.append(jadwal_dokter_dict)

    return jadwal_dokter_list

# InfoUser
def get_infoUser(db: Session, user_id: int):
    results = (
        db.query(models.InfoUser,
                 models.User.nama.label('nama_lengkap'),
                 models.User.username.label('username'),
                 models.User.no_telp.label('no_telp'),
                 models.User.email.label('email')
                 )
        .join(models.User, models.InfoUser.id_user == models.User.id)
        .filter(models.InfoUser.id_user == user_id)
        .all()
    )

    info_user_list = []
    for info_user, nama_lengkap, username, no_telp, email in results:
        info_user_dict = {
            "id": info_user.id,
            "jenis_kelamin": info_user.jenis_kelamin,
            "umur": info_user.umur,
            "berat_badan": info_user.berat_badan,
            "tanggal_lahir": info_user.tanggal_lahir.strftime('%Y-%m-%d'),
            "tinggi_badan": info_user.tinggi_badan,
            "golongan_darah": info_user.golongan_darah,
            "id_user": info_user.id_user,
            "alamat": info_user.alamat,
            "foto": info_user.foto,
            "nama_lengkap": nama_lengkap,
            "username": username,
            "no_telp": no_telp,
            "email": email,
        }
        info_user_list.append(info_user_dict)

    return info_user_list

def get_infoUser_by_id(db: Session, infoUser_id: int):
    return db.query(models.InfoUser).filter(models.InfoUser.id == infoUser_id).first()

def get_infoUser_by_userId(db: Session, user_id: int):
    return db.query(models.InfoUser).filter(models.InfoUser.id_user == user_id).first()

def update_infoUser(db: Session, user_id: int, user_data: schemas.UpdateInfoUserBase):
    db_user = db.query(models.InfoUser).filter(models.InfoUser.id_user == user_id).first()
    if db_user:
        db_user.jenis_kelamin = user_data.jenis_kelamin
        db_user.umur = user_data.umur
        db_user.berat_badan = user_data.berat_badan
        db_user.tanggal_lahir = user_data.tanggal_lahir
        db_user.tinggi_badan = user_data.tinggi_badan
        db_user.golongan_darah = user_data.golongan_darah
        db_user.alamat = user_data.alamat
        db_user.foto = user_data.foto
        db.commit()
        db.refresh(db_user)
    return db_user

# User ###########
def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()

def get_user_by_id(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def update_user(db: Session, user_id: int, user_data: schemas.UpdateUserBase):
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    if db_user:
        db_user.nama = user_data.nama
        db_user.no_telp = user_data.no_telp
        db.commit()
        db.refresh(db_user)
    return db_user

# delete semua user
def delete_all_user(db: Session):
    jum_rec = db.query(models.User).delete()
    db.commit()
    return jum_rec

# Pass
def hashPassword(passwd: str):
    bytePwd = passwd.encode('utf-8')
    pwd_hash = bcrypt.hashpw(bytePwd, SALT)
    return pwd_hash


# Create user (Sign up)
def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = hashPassword(user.password)
    db_user = models.User(nama=user.nama, username=user.username, password=hashed_password, email=user.email, no_telp=user.no_telp)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    # Buat record InfoUser baru yang terhubung dengan user yang baru saja dibuat
    default_info_user_values = {
        "jenis_kelamin": "Laki-laki",
        "umur": 0,
        "berat_badan": 0,
        "tanggal_lahir": datetime.now(),
        "tinggi_badan": 0,
        "golongan_darah": "",
        "alamat": "",
        "foto": "user.jpg"
    }
    db_info_user = models.InfoUser(id_user=db_user.id, **default_info_user_values)
    db.add(db_info_user)
    db.commit()
    db.refresh(db_info_user)

    return db_user


# Jadwal Janji Temu
def create_jadwal_janji_temu(db: Session, jadwal: schemas.JadwalJanjiTemuBase):
    db_jadwal = models.JadwalJanjiTemu(
        id_user=jadwal.id_user,
        id_jadwal_dokter=jadwal.id_jadwal_dokter,
        tanggal=jadwal.tanggal,
        durasi=jadwal.durasi
    )
    db.add(db_jadwal)
    db.commit()
    db.refresh(db_jadwal)

    # Buat record status user baru yang terhubung dengan janji temu yang baru saja dibuat
    default_info_user_values = {
        "id_statusRawatJalan": 1,
    }
    db_status_user = models.StatusUser(id_janjiTemu=db_jadwal.id, **default_info_user_values)
    db.add(db_status_user)
    db.commit()
    db.refresh(db_status_user)

    return db_jadwal

def get_jadwal_janji_temu(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.JadwalJanjiTemu).offset(skip).limit(limit).all()

def get_jadwal_janji_temu_by_id(db: Session, jadwal_id: int):
    return db.query(models.JadwalJanjiTemu).filter(models.JadwalJanjiTemu.id == jadwal_id).first()

def get_jadwal_janji_temu_by_idUser(db: Session, user_id: int):
    results = (
        db.query(models.JadwalJanjiTemu,
                 models.Dokter.id.label("id_dokter"),
                 models.Dokter.nama.label("nama_dokter"),
                 models.Spesialis.spesialis.label("nama_spesialis"),
                 models.RS.nama.label("nama_RS"),
                 models.JadwalDokter.waktu_mulai.label("waktu_mulai"),
                 models.JadwalDokter.waktu_berakhir.label("waktu_berakhir"),
                 )
        .join(models.User, models.JadwalJanjiTemu.id_user == models.User.id)
        .join(models.JadwalDokter, models.JadwalJanjiTemu.id_jadwal_dokter == models.JadwalDokter.id)
        .join(models.Dokter, models.JadwalDokter.id_dokter == models.Dokter.id)
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .join(models.RS, models.JadwalDokter.id_RS == models.RS.id)
        .filter(
            models.JadwalJanjiTemu.id_user == user_id,
        )
        .all()
    )

    jadwal_janji_temu_list = []
    for jadwal_janji_temu, id_dokter, nama_dokter, nama_spesialis, nama_RS, waktu_mulai, waktu_berakhir in results:
        jadwal_janji_temu_dict = {
            "id": jadwal_janji_temu.id,
            "id_user": jadwal_janji_temu.id_user,
            "id_jadwal_dokter": jadwal_janji_temu.id_jadwal_dokter,
            "tanggal": jadwal_janji_temu.tanggal,
            "durasi": jadwal_janji_temu.durasi,
            "id_dokter": id_dokter,
            "nama_dokter": nama_dokter,
            "nama_spesialis": nama_spesialis,
            "nama_RS": nama_RS,
            "waktu_mulai": waktu_mulai,
            "waktu_berakhir": waktu_berakhir,
        }
        jadwal_janji_temu_list.append(jadwal_janji_temu_dict)

    return jadwal_janji_temu_list


# Jadwal Konsul Online
def create_jadwal_konsul_online(db: Session, jadwal: schemas.JadwalkonsulOnlineBase):
    db_jadwal = models.JadwalKonsulOnline(
        id_user=jadwal.id_user,
        tanggal=jadwal.tanggal,
        durasi=jadwal.durasi,
        link_video_call=jadwal.link_video_call,
        id_jadwal_dokter_online=jadwal.id_jadwal_dokter_online,
    )
    db.add(db_jadwal)
    db.commit()
    db.refresh(db_jadwal)
    return db_jadwal

def get_jadwal_konsul_online_by_idUser(db: Session, user_id: int):
    results = (
        db.query(models.JadwalKonsulOnline,
                 models.Dokter.id.label("id_dokter"),
                 models.Dokter.nama.label("nama_dokter"),
                 models.Spesialis.spesialis.label("nama_spesialis"),
                 models.JadwalDokterOnline.waktu_mulai.label("waktu_mulai"),
                 models.JadwalDokterOnline.waktu_berakhir.label("waktu_berakhir"),
                 )
        .join(models.User, models.JadwalKonsulOnline.id_user == models.User.id)
        .join(models.JadwalDokterOnline, models.JadwalKonsulOnline.id_jadwal_dokter_online == models.JadwalDokterOnline.id)
        .join(models.Dokter, models.JadwalDokterOnline.id_dokter == models.Dokter.id)
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .filter(
            models.JadwalKonsulOnline.id_user == user_id,
        )
        .all()
    )

    jadwal_konsul_online_list = []
    for jadwal_konsul_online, id_dokter, nama_dokter, nama_spesialis, waktu_mulai, waktu_berakhir in results:
        jadwal_konsul_online_dict = {
            "id": jadwal_konsul_online.id,
            "id_user": jadwal_konsul_online.id_user,
            "tanggal": jadwal_konsul_online.tanggal,
            "durasi": jadwal_konsul_online.durasi,
            "link_video_call": jadwal_konsul_online.link_video_call,
            "id_jadwal_dokter_online": jadwal_konsul_online.id_jadwal_dokter_online,
            "id_dokter": id_dokter,
            "nama_dokter": nama_dokter,
            "nama_spesialis": nama_spesialis,
            "waktu_mulai": waktu_mulai,
            "waktu_berakhir": waktu_berakhir,
        }
        jadwal_konsul_online_list.append(jadwal_konsul_online_dict)

    return jadwal_konsul_online_list

# Jadwal Panggil Dokter
def create_jadwal_panggil_dokter(db: Session, jadwal: schemas.JadwalPanggilDokterBase):
    db_jadwal = models.JadwalPanggilDokter(
        id_user=jadwal.id_user,
        tanggal=jadwal.tanggal,
        id_jadwal_dokter_panggil_dokter=jadwal.id_jadwal_dokter_panggil_dokter,
        alamat=jadwal.alamat,
    )
    db.add(db_jadwal)
    db.commit()
    db.refresh(db_jadwal)
    return db_jadwal

def get_jadwal_panggil_dokter_by_idUser(db: Session, user_id: int):
    results = (
        db.query(models.JadwalPanggilDokter,
                 models.Dokter.id.label("id_dokter"),
                 models.Dokter.nama.label("nama_dokter"),
                 models.Spesialis.spesialis.label("nama_spesialis"),
                 models.JadwalDokterPanggilDokter.waktu_mulai.label("waktu_mulai"),
                 models.JadwalDokterPanggilDokter.waktu_berakhir.label("waktu_berakhir"),
                 )
        .join(models.User, models.JadwalPanggilDokter.id_user == models.User.id)
        .join(models.JadwalDokterPanggilDokter, models.JadwalPanggilDokter.id_jadwal_dokter_panggil_dokter == models.JadwalDokterPanggilDokter.id)
        .join(models.Dokter, models.JadwalDokterPanggilDokter.id_dokter == models.Dokter.id)
        .join(models.Spesialis, models.Dokter.id_spesialis == models.Spesialis.id)
        .filter(
            models.JadwalPanggilDokter.id_user == user_id,
        )
        .all()
    )

    jadwal_panggil_dokter_list = []
    for jadwal_panggil_dokter, id_dokter, nama_dokter, nama_spesialis, waktu_mulai, waktu_berakhir in results:
        jadwal_panggil_dokter_dict = {
            "id": jadwal_panggil_dokter.id,
            "id_user": jadwal_panggil_dokter.id_user,
            "tanggal": jadwal_panggil_dokter.tanggal,
            "id_jadwal_dokter_panggil_dokter": jadwal_panggil_dokter.id_jadwal_dokter_panggil_dokter,
            "alamat": jadwal_panggil_dokter.alamat,
            "id_dokter": id_dokter,
            "nama_dokter": nama_dokter,
            "nama_spesialis": nama_spesialis,
            "waktu_mulai": waktu_mulai,
            "waktu_berakhir": waktu_berakhir,
        }
        jadwal_panggil_dokter_list.append(jadwal_panggil_dokter_dict)

    return jadwal_panggil_dokter_list

## Status Rawat Jalan
def get_status_rawat_jalan(db: Session, skip: int = 0, limit: int = 100):
    results = (
        db.query(
            models.StatusRawatJalan,
        )
        .offset(skip).limit(limit)
        .all()
    )

    status_rawat_jalan_list = []
    for status_rawat_jalan in results:
        status_rawat_jalan_dict = {
            "id_status": status_rawat_jalan.id_status,
            "keterangan_status": status_rawat_jalan.keterangan_status,
            "deskripsi": status_rawat_jalan.deskripsi,
        }
        status_rawat_jalan_list.append(status_rawat_jalan_dict)

    return status_rawat_jalan_list

def get_status_rawat_jalan_by_id(db: Session, id_status:int):
    results = (
        db.query(
            models.StatusRawatJalan,
        )
        .filter(models.StatusRawatJalan.id_status == id_status)
        .all()
    )

    status_rawat_jalan_list = []
    for status_rawat_jalan in results:
        status_rawat_jalan_dict = {
            "id_status": status_rawat_jalan.id_status,
            "keterangan_status": status_rawat_jalan.keterangan_status,
            "deskripsi": status_rawat_jalan.deskripsi,
        }
        status_rawat_jalan_list.append(status_rawat_jalan_dict)

    return status_rawat_jalan_list

def get_status_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.StatusUser).offset(skip).limit(limit).all()

def get_status_user_by_id(db: Session, status_user_id: int):
    return db.query(models.StatusUser).filter(models.StatusUser.id == status_user_id).first()

# pembayaran
def get_pembayaran(db: Session, skip: int = 0, limit: int = 100):
    results = (
        db.query(
            models.Pembayaran,
            models.User.nama.label("nama_user")
        )
        .join(models.User, models.Pembayaran.id_user == models.User.id)
        .offset(skip).limit(limit)
        .all()
    )
    
    pembayaran_list = []
    for pembayaran, nama_user in results:
        pembayaran_dict = {
            "id": pembayaran.id,
            "id_user": pembayaran.id_user,
            "waktu_pembayaran": pembayaran.waktu_pembayaran,
            "metode_pembayaran": pembayaran.metode_pembayaran,
            "total_pembayaran": pembayaran.total_pembayaran,
            "status": pembayaran.status
        }
        pembayaran_list.append(pembayaran_dict)
    
    return pembayaran_list

def create_pembayaran(db: Session, pembayaran: schemas.PembayaranBase):
    db_pembayaran = models.Pembayaran(
        id_user = pembayaran.id_user, 
        waktu_pembayaran = pembayaran.waktu_pembayaran, 
        metode_pembayaran = pembayaran.metode_pembayaran, 
        total_pembayaran = pembayaran.total_pembayaran, 
        status = pembayaran.status, 
        item = pembayaran.item)
    db.add(db_pembayaran)
    db.commit()
    db.refresh(db_pembayaran)
    return db_pembayaran

## Obat
def get_obat(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Obat).offset(skip).limit(limit).all()

def get_jadwal_obat_by_user(db:Session, user_id:int):
    results = (
        db.query(models.JadwalObat,
                 models.Obat.nama.label("nama_obat"),
                 models.JadwalObatKonsumsi.waktu.label("waktu_konsumsi")
                 )
        .join(models.Obat, models.JadwalObat.id_obat == models.Obat.id)
        .join(models.JadwalObatKonsumsi, models.JadwalObat.id == models.JadwalObatKonsumsi.id_jadwal_obat)
        .filter(
            models.JadwalObat.id_user == user_id,
        )
        .order_by(models.JadwalObat.id, models.JadwalObatKonsumsi.waktu)
        .all()
    )

        # Dictionary untuk menyimpan jadwal obat dan waktu konsumsinya
    jadwal_obat_dict = {}

    for jadwal_obat, nama_obat, waktu_konsumsi in results:
        if jadwal_obat.id not in jadwal_obat_dict:
            jadwal_obat_dict[jadwal_obat.id] = {
                "id": jadwal_obat.id,
                "id_obat": jadwal_obat.id_obat,
                "id_user": jadwal_obat.id_user,
                "nama_obat": nama_obat,
                "kondisi_makan": jadwal_obat.kondisi_makan,
                "takaran": jadwal_obat.takaran,
                "waktu_konsumsi": []
            }
        
        # Tambahkan waktu konsumsi ke dalam list waktu_konsumsi
        jadwal_obat_dict[jadwal_obat.id]["waktu_konsumsi"].append(waktu_konsumsi.strftime("%H:%M"))

    # Konversi dictionary ke dalam bentuk list
    jadwal_obat_list = list(jadwal_obat_dict.values())

    return jadwal_obat_list

def get_metode_pembayaran(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.MetodePembayaran).offset(skip).limit(limit).all()

# Lab
def get_Lab(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Lab).offset(skip).limit(limit).all()

def get_jadwal_lab_by_idrs(db: Session, rs_id: int, id_lab: int):
    results = (
        db.query(models.Jadwal_Lab, models.Lab)
        .join(models.Lab, models.Jadwal_Lab.id_lab == models.Lab.id)
        .filter(
            models.Jadwal_Lab.id_rs == rs_id,
            models.Jadwal_Lab.id_lab == id_lab,
        )
        .all()
    )

    jadwal_lab_list = []
    for jadwal_lab, lab in results:
        jadwal_lab_dict = {
            "id": jadwal_lab.id,
            "hari": jadwal_lab.hari,
            "waktu_mulai": jadwal_lab.waktu_mulai.strftime("%H:%M"),
            "waktu_berakhir": jadwal_lab.waktu_berakhir.strftime("%H:%M"),
            "id_RS": jadwal_lab.id_rs,
            "nama_lab": lab.nama,
            "kategori": lab.kategori,
            "harga": lab.harga,
            "deskripsi": lab.deskripsi,
        }
        jadwal_lab_list.append(jadwal_lab_dict)

    return jadwal_lab_list

def get_RS_by_Lab(db: Session, id: int):
    results = (
        db.query(
            models.Jadwal_Lab,
            models.RS,
        )
        .join(models.RS, models.Jadwal_Lab.id_rs == models.RS.id)
        .filter(models.Jadwal_Lab.id_lab == id)
        .all()
    )
    
    rs_list = []
    for daftar_rs, rs in results:
        rs_dict = {
            "id": rs.id,
            "nama": rs.nama,
            "deskripsi": rs.deskripsi,
            "lokasi": rs.lokasi,
            "fasilitas": rs.fasilitas,
            "img": rs.img,
        }
        rs_list.append(rs_dict)

    return rs_list


def get_statusRawatJalanUser(db: Session, id_jadwal_janji_temu: int):
    result = (
        db.query(
            models.StatusUser,
            models.StatusRawatJalan.keterangan_status.label("keterangan_status"),
            models.StatusRawatJalan.deskripsi.label("deskripsi")
        )
        .join(models.StatusRawatJalan, models.StatusUser.id_statusRawatJalan == models.StatusRawatJalan.id_status)
        .join(models.JadwalJanjiTemu, models.StatusUser.id_janjiTemu == models.JadwalJanjiTemu.id)
        .filter(models.StatusUser.id_janjiTemu == id_jadwal_janji_temu)
        .first()
    )
    
    status_user, keterangan_status, deskripsi = result

    status_user_dict = {
        "id": status_user.id,
        "id_janji_temu": status_user.id_janjiTemu,
        "id_statusRawatJalan": status_user.id_statusRawatJalan,
        "keterangan_status": keterangan_status,
        "deskripsi": deskripsi,
    }

    return status_user_dict