import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/view/Admin.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class SearchAdmin extends StatefulWidget {
  SearchAdmin() : super();
  final String title = "AutoComplate Search Flutter";
  @override
  State<SearchAdmin> createState() => _SearchAdminState();
}

class _SearchAdminState extends State<SearchAdmin> {
  AutoCompleteTextField? searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Admin>> key = new GlobalKey();
  static List<Admin> Admins = new List<Admin>.from(<Admin>[]);
  bool loading = true;

  void getUsers() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.43.233/api_project/api/data_karyawan.php"));
      if (response.statusCode == 200) {
        Admins = loadUsers(response.body);
        print('Admin: ${Admins.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting Admin");
      }
    } catch (e) {
      print("error getting data API");
    }
  }

  static List<Admin> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Admin>((json) => Admin.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(Admin Admin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          Admin.nama_karyawan.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(Admin.gender.toString()),
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
                : searchTextField = AutoCompleteTextField<Admin>(
                    key: key,
                    clearOnSubmit: false,
                    suggestions: Admins,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      hintText: "Cari Admin",
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
}
