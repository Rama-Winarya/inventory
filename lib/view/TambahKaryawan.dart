import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_karyawan.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class TambahKaryawan extends StatefulWidget {
  final VoidCallback reload;
  TambahKaryawan(this.reload);
  @override
  State<TambahKaryawan> createState() => _TambahKaryawanState();
}

class _TambahKaryawanState extends State<TambahKaryawan> {
  String? nama_karyawan, username, divisi, gender, password, level;
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
      final response = await http
          .post(Uri.parse(BaseUrl.urltambah_karyawan.toString()), body: {
        "nama_karyawan": nama_karyawan,
        "username": username,
        "divisi": divisi,
        "gender": gender,
        "password": password,
        "level": level
      });
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
                  "Tambah Karyawan",
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
                    return "Silahkan isi Nama";
                  }
                },
                onSaved: (e) => nama_karyawan = e,
                decoration: InputDecoration(labelText: "Nama Karyawan"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi Nama Kayawan";
                  }
                },
                onSaved: (e) => username = e,
                decoration: InputDecoration(labelText: "username"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi Divisi";
                  }
                },
                onSaved: (e) => divisi = e,
                decoration: InputDecoration(labelText: "Divisi"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi gender";
                  }
                },
                onSaved: (e) => gender = e,
                decoration: InputDecoration(labelText: "Gender"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi Password";
                  }
                },
                onSaved: (e) => password = e,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi Level";
                  }
                },
                onSaved: (e) => level = e,
                decoration: InputDecoration(labelText: "level"),
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
