from sqlalchemy.orm import Session
import models, schemas
import bcrypt
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
        .join(models.Spesialis, models.Dokter.spesialis == models.Spesialis.id)
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
        .join(models.Spesialis, models.Dokter.spesialis == models.Spesialis.id) 
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