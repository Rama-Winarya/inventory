class model_divisi {
  String? id_divisi;
  String? nama_divisi;
  model_divisi(this.id_divisi, this.nama_divisi);
  model_divisi.fromJson(Map<String, dynamic> json) {
    id_divisi = json['id_divisi'];
    nama_divisi = json['nama_divisi'];
  }
}
