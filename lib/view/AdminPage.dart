import 'package:flutter/material.dart';
import 'package:inventory/view/DataBarang.dart';
import 'package:inventory/view/DataDivisi.dart';
import 'package:inventory/view/DataKaryawan.dart';
import 'package:inventory/view/DataKontrak.dart';
import 'package:inventory/view/SearchKaryawan.dart';

// import 'package:cupertino_icons/cupertino_icons.dart';
class AdminPage extends StatefulWidget {
  final VoidCallback signOut;

  @override
  AdminPage(this.signOut);
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = 0xffF6F8FC;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.orange,
          title: Text('Administrator Page'),
          actions: <Widget>[
            new IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.logout_rounded),
                color: Colors.white)
          ],
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 0,
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Container 2 clicked");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DataDivisi()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.business_outlined,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Divisi",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Inventaris");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DataBarang()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.computer_rounded,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Inventaris",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Flexible(
              flex: 0,
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Container 1 clicked");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DataKaryawan()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.group,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Karyawan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Container 1 clicked");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DataKontrak()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.book_rounded,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Kontrak",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Flexible(
              flex: 0,
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Container 1 clicked");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new SearchKaryawan()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search_rounded,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Cari Karyawan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // print("Container 1 clicked");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DataKontrak()));
                        },
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.book_rounded,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Kontrak",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
