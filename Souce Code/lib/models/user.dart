class User {
  int id;
  String nama;
  String username;
  String email;
  String noTelp;

  User({required this.id, required this.nama, required this.username, required this.email, required this.noTelp});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      email: json['email'],
      noTelp: json['no_telp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'username': username,
      'email': email,
      'no_telp': noTelp,
    };
  }
}
