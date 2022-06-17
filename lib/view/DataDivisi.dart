import 'package:flutter/material.dart';
import 'package:inventory/model/model_divisi.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/view/EditDivisi.dart';
import 'package:inventory/view/TambahDivisi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DataDivisi extends StatefulWidget {
  @override
  _DataDivisiState createState() => _DataDivisiState();
}

class _DataDivisiState extends State<DataDivisi> {
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
    final response = await http.get(Uri.parse(BaseUrl.urldata_divisi));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new model_divisi(api['id_divisi'], api['nama_divisi']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id_divisi) async {
    final response = await http.post(Uri.parse(BaseUrl.urlhapus_divisi),
        body: {"id_divisi": id_divisi});
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

  dialogHapus(String id_divisi) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: <Widget>[
              Text(
                "Apakah anda yakin ingin menghapus Divisi ini?",
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
                      _proseshapus(id_divisi);
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
                "Nama Divisi",
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
                  builder: (context) => new TambahDivisi(_lihatData)));
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
                                Text("ID : " + x.id_divisi.toString(),
                                    style: TextStyle(fontSize: 15.0)),
                                Text("DIV : " + x.nama_divisi.toString(),
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
                                        EditDivisi(x, _lihatData)));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                // delete
                                dialogHapus(x.id_divisi);
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
