import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_kontrak.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class TambahKontrak extends StatefulWidget {
  final VoidCallback reload;
  TambahKontrak(this.reload);
  @override
  _TambahKontrakState createState() => _TambahKontrakState();
}

class _TambahKontrakState extends State<TambahKontrak> {
  String? vendor;
  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      simpankontrak();
    }
  }

  simpankontrak() async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.urltambah_kontrak.toString()),
          body: {"vendor": vendor});
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
                    return "Silahkan isi Nama Vendor";
                  }
                },
                onSaved: (e) => vendor = e,
                decoration: InputDecoration(labelText: "Nama Vendor"),
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
