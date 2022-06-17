import 'package:flutter/material.dart';
import 'package:inventory/model/PCModel.dart';
import 'package:inventory/model/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class DataPC extends StatefulWidget {
  @override
  State<DataPC> createState() => _DataPCState();
}

class _DataPCState extends State<DataPC> {
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

    final response = await http.get(Uri.parse(BaseUrl.urlDataPC));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new PCModel(api['id_pc'], api['nama_pc'], api['tipe_pc']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
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
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
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
                                Text("ID : " + x.id_pc.toString(),
                                    style: TextStyle(fontSize: 15.0)),
                                Text(x.nama_pc.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                                Text(x.tipe_pc.toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
