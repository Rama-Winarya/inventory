class Admin {
  String? id_karyawan;
  String? nama_karyawan;
  String? gender;
  Admin({this.id_karyawan, this.nama_karyawan, this.gender});
  factory Admin.fromJson(Map<String, dynamic> parsedJson) {
    return Admin(
        id_karyawan: parsedJson['id_karyawan'] as String,
        nama_karyawan: parsedJson['nama_karyawan'] as String,
        gender: parsedJson['gender'] as String);
  }
}
