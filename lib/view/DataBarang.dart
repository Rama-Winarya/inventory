import 'package:flutter/material.dart';
import 'package:inventory/model/model_barang.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/view/EditBarang.dart';
import 'package:inventory/view/TambahBarang.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inventory/view/EditBarang.dart';
import 'dart:convert';

import 'package:inventory/view/TambahBarang.dart';

class DataBarang extends StatefulWidget {
  @override
  _DataBarangState createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  var loading = false;
  final list = [];
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.get(Uri.parse(BaseUrl.urldata_barang));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new model_barang(
            api['id_inventaris'], api['id_pc'], api['id_user']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id_inventaris) async {
    final response = await http.post(Uri.parse(BaseUrl.urlhapus_barang),
        body: {"id_inventaris": id_inventaris});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
        ;
      });
    } else {
      print(pesan);
    }
  }

  dialogHapus(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: <Widget>[
              Text(
                "Apakah anda yakin ingin menghapus data ini?",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 25.0),
                  InkWell(
                    onTap: () {
                      _proseshapus(id);
                    },
                    child: Text(
                      "Ya",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data PC",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("tambah pc");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new TambahBarang(_lihatData)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 82, 48, 1),
      ),
      body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("ID : " + x.id_inventaris.toString(),
                                    style: TextStyle(fontSize: 15.0)),
                                Text("ID PC : " + x.id_pc.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                                Text("ID User : " + x.id_user.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ))
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                // edit
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditBarang(x, _lihatData)));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                // delete
                                dialogHapus(x.id_inventaris);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
