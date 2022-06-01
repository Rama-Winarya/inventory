class model_kontrak {
  String? id_kontrak;
  String? vendor;
  model_kontrak(this.id_kontrak, this.vendor);
  model_kontrak.fromJson(Map<String, dynamic> json) {
    id_kontrak = json['id_kontrak'];
    vendor = json['vendor'];
  }
}
