import 'package:flutter/material.dart';
import 'package:inventory/model/model_kontrak.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/view/EditKontrak.dart';
import 'package:inventory/view/TambahKontrak.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:inventory/view/TambahKontrak.dart';

class DataKontrak extends StatefulWidget {
  @override
  _DataKontrakState createState() => _DataKontrakState();
}

class _DataKontrakState extends State<DataKontrak> {
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
    final response = await http.get(Uri.parse(BaseUrl.urldata_kontrak));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new model_kontrak(api['id_kontrak'], api['vendor']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id_kontrak) async {
    final response = await http.post(Uri.parse(BaseUrl.urlhapus_kontrak),
        body: {"id_kontrak": id_kontrak});
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

  dialogHapus(String id_kontrak) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: <Widget>[
              Text(
                "Apakah anda yakin ingin menghapus Kontrak ini?",
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
                      _proseshapus(id_kontrak);
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
                "Nama Kontrak",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("tambah jenis");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new TambahKontrak(_lihatData)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0066cc),
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
                                Text("ID : " + x.id_kontrak.toString(),
                                    style: TextStyle(fontSize: 15.0)),
                                Text("Vendor : " + x.vendor.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                // edit
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditKontrak(x, _lihatData)));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                // delete
                                dialogHapus(x.id_kontrak);
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
