class model_barang {
  String? id_inventaris;
  String? id_pc;
  String? id_user;
  model_barang(this.id_inventaris, this.id_pc, this.id_user);
  model_barang.fromJson(Map<String, dynamic> json) {
    id_inventaris = json['id_inventaris'];
    id_pc = json['id_pc'];
    id_user = json['id_user'];
  }
}
