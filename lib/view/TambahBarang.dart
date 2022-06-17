import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_barang.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class TambahBarang extends StatefulWidget {
  final VoidCallback reload;
  TambahBarang(this.reload);
  @override
  _TambahBarangState createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  String? id_pc, id_user;
  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      simpan_barang();
    }
  }

  simpan_barang() async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.urltambah_barang.toString()),
          body: {"id_pc": id_pc, "id_user": id_user});
      final data = jsonDecode(response.body);
      print(data);
      int code = data['success'];
      String pesan = data['message'];
      print(data);
      if (code == 1) {
        setState(() {
          Navigator.pop(context);
          widget.reload();
        });
      } else {
        print(pesan);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Tambah Data PC",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi ID PC";
                  }
                },
                onSaved: (e) => id_pc = e,
                decoration: InputDecoration(labelText: "ID PC"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi ID User";
                  }
                },
                onSaved: (e) => id_user = e,
                decoration: InputDecoration(labelText: "ID User"),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color(0xff0066cc),
                onPressed: () {
                  check();
                },
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
