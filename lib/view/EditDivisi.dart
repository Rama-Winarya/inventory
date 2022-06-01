import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_divisi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class EditDivisi extends StatefulWidget {
  final VoidCallback reload;
  final model_divisi model;
  EditDivisi(this.model, this.reload);
  @override
  _EditDivisiState createState() => _EditDivisiState();
}

class _EditDivisiState extends State<EditDivisi> {
  String? id_divisi, nama_divisi;
  final _key = new GlobalKey<FormState>();
  TextEditingController? txtidDivisi, txtNamaDivisi;
  setup() async {
    txtNamaDivisi = TextEditingController(text: widget.model.nama_divisi);
    id_divisi = widget.model.id_divisi;
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      prosesdivisi();
    }
  }

  prosesdivisi() async {
    try {
      final respon = await http.post(
          Uri.parse(BaseUrl.urledit_divisi.toString()),
          body: {"id_divisi": id_divisi, "nama_divisi": nama_divisi});
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
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtNamaDivisi,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Nama Divisi";
                } else {
                  return null;
                }
              },
              onSaved: (e) => nama_divisi = e,
              decoration: InputDecoration(labelText: "Nama Divisi"),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Ubah"),
            )
          ],
        ),
      ),
    );
  }
}
