import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory/model/api.dart';
import 'package:inventory/view/AdminPage.dart';
import 'package:inventory/view/UserPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn, signUser }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String? username, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autovalidadate = false;

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    } else {
      setState(() {
        _autovalidadate = true;
      });
    }
  }

  login() async {
    final response = await http.post(Uri.parse(BaseUrl.urlLogin),
        body: {"username": username, "password": password});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama_karyawan'];
    String userLevel = data['level'];
    if (value == 1) {
      if (userLevel == "1") {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(value, usernameAPI, namaAPI, userLevel);
        });
      } else {
        setState(() {
          _loginStatus = LoginStatus.signUser;
          savePref(value, usernameAPI, namaAPI, userLevel);
        });
      }
      print(pesan);
    } else {
      print(pesan);
    }
  }

  savePref(int val, String usernameAPI, String namaAPI, userLevel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", val);
      preferences.setString("username", usernameAPI);
      preferences.setString("nama_karyawan", namaAPI);
      preferences.setString("level", userLevel);
      preferences.commit();
    });
  }

  var value;
  var level;
  var nama;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      level = preferences.getString("level");
      nama = preferences.getString("nama_karyawan");
      if (value == 1) {
        if (level == "1") {
          _loginStatus = LoginStatus.signIn;
        } else {
          _loginStatus = LoginStatus.signUser;
        }
      } else {
        _loginStatus = LoginStatus.notSignIn;
      }
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.setString("username", null.toString());
      preferences.setString("nama_karyawan", null.toString());
      preferences.setString("level", null.toString());
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  void disopse() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return new Scaffold(
          body: Form(
            key: _key,
            autovalidate: _autovalidadate,
            child: ListView(
              padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
              children: <Widget>[
                Image.asset('assets/img/logo.png', height: 60, width: 60),
                Text(
                  "Inventory Apps",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
                TextFormField(
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "silahkan isi username";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (e) => username = e,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: showHide)),
                ),
                MaterialButton(
                  padding: EdgeInsets.all(25.0),
                  color: Colors.blue,
                  onPressed: () {
                    check();
                    // print("login");
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return AdminPage(signOut);
        break;
      case LoginStatus.signUser:
        return UserPage(signOut);
        break;
    }
  }
}
