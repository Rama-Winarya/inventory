import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_kontrak.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class EditKontrak extends StatefulWidget {
  final VoidCallback reload;
  final model_kontrak model;
  EditKontrak(this.model, this.reload);
  @override
  _EditKontrakState createState() => _EditKontrakState();
}

class _EditKontrakState extends State<EditKontrak> {
  String? id_kontrak, vendor;
  final _key = new GlobalKey<FormState>();
  TextEditingController? txtidkontrak, txtvendor;
  setup() async {
    txtvendor = TextEditingController(text: widget.model.vendor);
    id_kontrak = widget.model.id_kontrak;
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      proseskontrak();
    }
  }

  proseskontrak() async {
    try {
      final respon = await http.post(
          Uri.parse(BaseUrl.urledit_kontrak.toString()),
          body: {"id_kontrak": id_kontrak, "vendor": vendor});
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
                "Ubah Data Kontrak",
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
              controller: txtvendor,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi Nama Vendor";
                } else {
                  return null;
                }
              },
              onSaved: (e) => vendor = e,
              decoration: InputDecoration(labelText: "Nama Vendor"),
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
          ],
        ),
      ),
    );
  }
}
