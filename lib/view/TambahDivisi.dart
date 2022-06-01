import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_divisi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class TambahDivisi extends StatefulWidget {
  final VoidCallback reload;
  TambahDivisi(this.reload);
  @override
  _TambahDivisiState createState() => _TambahDivisiState();
}

class _TambahDivisiState extends State<TambahDivisi> {
  String? nama_divisi;
  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      simpandivisi();
    }
  }

  simpandivisi() async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.urltambah_divisi.toString()),
          body: {"nama_divisi": nama_divisi});
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
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi Nama Divisi";
                  }
                },
                onSaved: (e) => nama_divisi = e,
                decoration: InputDecoration(labelText: "Nama Divisi"),
              ),
              MaterialButton(
                onPressed: () {
                  check();
                },
                child: Text("Simpan"),
              )
            ],
          ),
        ));
  }
}
