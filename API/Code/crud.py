from sqlalchemy.orm import Session
import models, schemas
import bcrypt
from datetime import time
from sqlalchemy import desc

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
def get_rating_dokter(db: Session, dokter_id: int):
    results = (
        db.query(
            models.Rating,
            models.Dokter.nama.label("nama_dokter"),
            models.User.nama.label("nama_user")
        )
        .join(models.Dokter, models.Rating.id_dokter == models.Dokter.id)
        .join(models.User, models.Rating.id_user == models.User.id)
        .filter(models.Rating.id_dokter == dokter_id)
        .all()
    )

    rating_dokter_list = []
    for rating_dokter, nama_dokter, nama_user in results:
        rating_dokter_dict = {
            "id": rating_dokter.id,
            "pesan": rating_dokter.pesan,
            "rating": rating_dokter.rating,
            "id_user": rating_dokter.id_user,
            "id_dokter": rating_dokter.id_dokter,
            "nama_dokter": nama_dokter,
            "nama_user": nama_user,
        }
        rating_dokter_list.append(rating_dokter_dict)

    return rating_dokter_list

# Jadwal Dokter

# Jadwal Dokter
def get_jadwal_dokter(db: Session, dokter_id: int, rs_id:int):
    results = (
        db.query(
            models.JadwalDokter, models.Dokter.nama.label("nama_dokter")
        )
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


def get_jadwal_dokter_by_hari_jam(db: Session, waktu: str, rs_id: int, hari: str, spesialis:int):
    try:
        hari, _ = hari.split(", ")
    except ValueError:
        raise ValueError("Format input tidak valid. Harap gunakan format: 'Hari, DD MMMM YYYY'")
    
    results = (
        db.query(models.JadwalDokter, models.Dokter.nama.label("nama_dokter"))
        .filter(
            models.JadwalDokter.id_RS == rs_id,
            models.JadwalDokter.hari == hari,
            models.JadwalDokter.waktu_mulai == waktu,
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



# InfoUser
def get_infoUser(db: Session, user_id: int):
    return db.query(models.InfoUser)\
             .join(models.User, models.InfoUser.id_user == models.User.id)\
             .filter(models.InfoUser.id_user == user_id)\
             .all()


# User ###########
def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()

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
    db_user = models.User(nama=user.nama,username=user.username, password=hashed_password, email=user.email, no_telp=user.no_telp)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def create_jadwal_janji_temu(db: Session, jadwal: schemas.JadwalJanjiTemuCreate):
    db_jadwal = models.JadwalJanjiTemu(
        id_user=jadwal.id_user,
        id_dokter=jadwal.id_dokter,
        id_rs=jadwal.id_rs,
        id_spesialis=jadwal.id_spesialis,
        tanggal=jadwal.tanggal,
        waktu=jadwal.waktu,
        durasi=jadwal.durasi
    )
    db.add(db_jadwal)
    db.commit()
    db.refresh(db_jadwal)
    return db_jadwal

def get_jadwal_janji_temu(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.JadwalJanjiTemu).offset(skip).limit(limit).all()

def get_jadwal_janji_temu_by_id(db: Session, jadwal_id: int):
    return db.query(models.JadwalJanjiTemu).filter(models.JadwalJanjiTemu.id == jadwal_id).first()

## Status Rawat Jalan
def get_status_rawat_jalan(db: Session, skip: int = 0, limit: int = 100):
    results = (
        db.query(
            models.StatusRawatJalan,
            models.User.nama.label("nama_user")
        )
        .join(models.User, models.StatusRawatJalan.id_user == models.User.id)
        .offset(skip).limit(limit)
        .all()
    )

    status_rawat_jalan_list = []
    for status_rawat_jalan, nama_user in results:
        status_rawat_jalan_dict = {
            "id_status": status_rawat_jalan.id_status,
            "keterangan_status": status_rawat_jalan.keterangan_status,
            "deskripsi": status_rawat_jalan.deskripsi,
            "id_user": status_rawat_jalan.id_user,
            "nama_user": nama_user,
        }
        status_rawat_jalan_list.append(status_rawat_jalan_dict)

    return status_rawat_jalan_list

## pembayaran
# def get_pembayaran(db: Session, skip: int = 0, limit: int = 100):
#     results = (
#         db.query(
#             models.Pembayaran,
#             models.User.nama.label("nama_user")
#         )
#         .join(models.User, models.Pembayaran.id_user == models.User.id)
#         .offset(skip).limit(limit)
#         .all()
#     )
    
#     pembayaran_list = []
#     for pembayaran, nama_user in results:
#         pembayaran_dict = {
#             "id": pembayaran.id,
#             "id_user": pembayaran.id_user,
#             "waktu_pembayaran": pembayaran.waktu_pembayaran,
#             "metode_pembayaran": pembayaran.metode_pembayaran,
#             "total_pembayaran": pembayaran.total_pembayaran,
#             "status": pembayaran.status
#         }
#         pembayaran_list.append(pembayaran_dict)
    
#     return pembayaran_list