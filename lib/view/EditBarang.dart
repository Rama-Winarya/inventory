import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_barang.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

class EditBarang extends StatefulWidget {
  final VoidCallback reload;
  final model_barang model;
  EditBarang(this.model, this.reload);

  @override
  _EditBarangState createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  String? id_inventaris, id_pc, id_user;
  final _key = new GlobalKey<FormState>();
  TextEditingController? txtidinventaris, txtidpc, txtiduser;
  setup() async {
    txtidpc = TextEditingController(text: widget.model.id_pc);
    txtiduser = TextEditingController(text: widget.model.id_user);

    id_inventaris = widget.model.id_inventaris;
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      prosesbarang();
    }
  }

  prosesbarang() async {
    try {
      final respon = await http
          .post(Uri.parse(BaseUrl.urledit_barang.toString()), body: {
        "id_inventaris": id_inventaris,
        "id_pc": id_pc,
        "id_user": id_user
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
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtidpc,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi ID PC";
                } else {
                  return null;
                }
              },
              onSaved: (e) => id_pc = e,
              decoration: InputDecoration(labelText: "ID PC"),
            ),
            TextFormField(
              controller: txtiduser,
              validator: (e) {
                if (e!.isEmpty) {
                  return "Silahkan isi ID User";
                } else {
                  return null;
                }
              },
              onSaved: (e) => id_user = e,
              decoration: InputDecoration(labelText: "ID User"),
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
