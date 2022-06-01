import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/model/api.dart';
import 'package:inventory/model/model_karyawan.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class SearchKaryawan extends StatefulWidget {
  SearchKaryawan() : super();
  final String title = "AutoComplate Search Flutter";

  @override
  State<SearchKaryawan> createState() => _SearchKaryawanState();
}

class _SearchKaryawanState extends State<SearchKaryawan> {
  AutoCompleteTextField? searchTextField;
  GlobalKey<AutoCompleteTextFieldState<model_karyawan>> key = new GlobalKey();
  static List<model_karyawan> Karyawans =
      new List<model_karyawan>.from(<model_karyawan>[]);
  bool loading = true;
  void getKaryawan() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.urldata_karyawan));
      if (response.statusCode == 200) {
        Karyawans = loadKaryawan(response.body);
        print('Karyawan: ${Karyawans.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting Teknisi");
      }
    } catch (e) {
      print("error getting data API");
    }
  }

  static List<model_karyawan> loadKaryawan(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<model_karyawan>((json) => model_karyawan.fromJson(json))
        .toList();
  }

  @override
  void initState() {
    getKaryawan();
    super.initState();
  }

  Widget row(model_karyawan karyawan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          karyawan.nama_karyawan.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(karyawan.gender.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loading
                ? CircularProgressIndicator()
                : searchTextField = AutoCompleteTextField<model_karyawan>(
                    key: key,
                    clearOnSubmit: false,
                    suggestions: Karyawans,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      hintText: "Cari Karyawan",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    itemFilter: (item, query) {
                      return item.nama_karyawan!
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.nama_karyawan!.compareTo(b.nama_karyawan!);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        searchTextField?.textField!.controller?.text =
                            item.nama_karyawan.toString();
                      });
                    },
                    itemBuilder: (context, item) {
                      return row(item);
                    },
                  )
          ],
        ));
  }

  Widget _buildContainer(model_karyawan karyawan) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "ID : " + karyawan.id_karyawan.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "Nama : " + karyawan.nama_karyawan.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text("Gender" + karyawan.gender.toString()),
          ],
        ),
      ),
    );
  }
}
