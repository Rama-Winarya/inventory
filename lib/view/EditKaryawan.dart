import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_karyawan.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class EditKaryawan extends StatefulWidget {
  final VoidCallback reload;
  final model_karyawan model;
  EditKaryawan(this.model, this.reload);

  @override
  _EditKaryawanState createState() => _EditKaryawanState();
}

class _EditKaryawanState extends State<EditKaryawan> {
  String? id_karyawan, nama_karyawan, divisi, gender, level, username, password;
  final _key = new GlobalKey<FormState>();
  TextEditingController? txtidikaryawan,
      txtnamakaryawan,
      txtdivisi,
      txtgender,
      txtlevel,
      txtusername;
  // txtpassword;
  setup() async {
    txtnamakaryawan = TextEditingController(text: widget.model.nama_karyawan);
    txtdivisi = TextEditingController(text: widget.model.divisi);
    txtgender = TextEditingController(text: widget.model.gender);
    txtlevel = TextEditingController(text: widget.model.level);
    txtgender = TextEditingController(text: widget.model.gender);
    txtusername = TextEditingController(text: widget.model.username);
    //txtpassword = TextEditingController(text: widget.model.password);

    id_karyawan = widget.model.id_karyawan;
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proseskaryawan();
    }
  }

  proseskaryawan() async {
    try {
      final respon = await http
          .post(Uri.parse(BaseUrl.urledit_karyawan.toString()), body: {
        "id_karyawan": id_karyawan,
        "nama_karyawan": nama_karyawan,
        "divisi": divisi,
        "gender": gender,
        "level": level,
        "username": username,
        // "password": password,
      });
      final data = jsonDecode(respon.body);
      print(data);
      int code = data['success'];
      String pesan = data['message'];
      print(data);
      if (code == 1) {
        setState(() {
          widget.reload();
          Navigator.pop(context);
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
    setup();
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
                "Ubah Data Karyawan",
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
              controller: txtnamakaryawan,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Nama Karyawan";
                } else {
                  return null;
                }
              },
              onSaved: (e) => nama_karyawan = e,
              decoration: InputDecoration(labelText: "Nama Karyawan"),
            ),
            TextFormField(
              controller: txtdivisi,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Divisi";
                } else {
                  return null;
                }
              },
              onSaved: (e) => divisi = e,
              decoration: InputDecoration(labelText: "Divisi"),
            ),
            TextFormField(
              controller: txtgender,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Gender";
                } else {
                  return null;
                }
              },
              onSaved: (e) => gender = e,
              decoration: InputDecoration(labelText: "Gender"),
            ),
            TextFormField(
              controller: txtlevel,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Level";
                } else {
                  return null;
                }
              },
              onSaved: (e) => level = e,
              decoration: InputDecoration(labelText: "Level"),
            ),
            TextFormField(
              controller: txtusername,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi username";
                } else {
                  return null;
                }
              },
              onSaved: (e) => username = e,
              decoration: InputDecoration(labelText: "username"),
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
                "Ubah",
                style: TextStyle(color: Colors.white),
              ),
            )
            // TextFormField(
            //  // controller: txtpassword,
            //   validator: (e) {
            //     if (e!.isEmpty) {
            //       return "Silahkan isi Password";
            //     } else {
            //       return null;
            //     }
            //   },
            //   onSaved: (e) => password = e,
            //   decoration: InputDecoration(labelText: "Password"),
            // ),
          ],
        ),
      ),
    );
  }
}
