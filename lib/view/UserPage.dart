import 'package:flutter/material.dart';
import 'package:inventory/view/DataBarang.dart';
import 'package:inventory/view/DataKaryawan.dart';
import 'package:inventory/view/SearchKaryawan.dart';

class UserPage extends StatefulWidget {
  final VoidCallback signOut;
  @override
  UserPage(this.signOut);
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  sigOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.orange,
        title: Text('User Page'),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              sigOut();
            },
            icon: Icon(Icons.double_arrow),
            color: Colors.white,
          ),
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
                                builder: (context) => new DataBarang()));
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
                              "Data Barang",
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
                                builder: (context) => new SearchKaryawan()));
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
                              "Cari karyawan",
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
      ),
    );
  }
}
