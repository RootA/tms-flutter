import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tms/scopes/main_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  final MainScope _model;
  LoginPage(this._model);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class postDetails {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  postDetails _details = new postDetails();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool checkValue = false;
  SharedPreferences sharedPreferences;

  Map _authDetails = {};

  Map get authDetails {
    return Map.from(_authDetails);
  }

  @override
  void initState() {
    super.initState();
    getCredential();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
        return Container(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              ListTile(
                leading: Icon(Icons.email),
                title: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email"
                  ),
                  onChanged: (String value){
                    _details.email = value;
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "********"
                  ),
                  onChanged: (String value){
                    _details.password = value;
                  },
                ),
              ),
//              CheckboxListTile(
//                value: checkValue,
////                onChanged: _onChanged,
//                title: new Text("Remember me"),
//                controlAffinity: ListTileControlAffinity.leading,
//              ),
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              RaisedButton(
                color: Colors.lightBlueAccent,
                  elevation: 2.0,
                  child: Text("LOGIN", style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: (){
                    Map<String, dynamic> credentials = {
                      'email': _details.email,
                      'password': _details.password
                    };
//                    _api.postLogin(credentials);
                  _onChanged(credentials);
                  }
              )
            ],
          ),
        );
      }),
    );
  }
  Future _onChanged(Map<String, dynamic> credentials) async {
    sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post('http://localhost:5000/api/v1/login', body: json.encode(credentials), headers: {
      'Accept' : 'application/json',
      'Content-Type': 'application/json'
    });
    setState(() {
      checkValue = true;
      if (response.statusCode == 200) {
        _authDetails = json.decode(response.body);

        sharedPreferences.setBool("check", checkValue);
        sharedPreferences.setString("email", email.text);
        sharedPreferences.setString("password", password.text);
        sharedPreferences.setString("company_name", _authDetails['company_name']);
        sharedPreferences.setString("user_type", _authDetails['user_type']);
        sharedPreferences.setString("type_id", _authDetails['type_id']);
        sharedPreferences.setString("full_name", _authDetails['full_name']);
        sharedPreferences.setString("auth_token", _authDetails['auth_token']);
        sharedPreferences.setString("phone_number", _authDetails['phone_number']);
        sharedPreferences.setString("public_id", _authDetails['public_id']);

        showDialog(
            context: context,
            barrierDismissible: false,
            child: new AlertDialog(
              content: new Text(
                _authDetails['message'],
                style: new TextStyle(fontSize: 16.0),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: new Text("OK"))
              ],
            ));
//        return _authDetails;
      } else {
        _authDetails = json.decode(response.body);
        return showDialog(
            context: context,
            barrierDismissible: false,
            child: new AlertDialog(
              content: new Text(
                _authDetails['message'],
                style: new TextStyle(fontSize: 16.0),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
//                      email.clear();
//                      password.clear();
//                      sharedPreferences.clear();
                      Navigator.pushNamed(context, '/login');
                    },
                    child: new Text("OK"))
              ],
            ));
      }
        });
    }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          email.text = sharedPreferences.getString("email");
          password.text = sharedPreferences.getString("password");
        } else {
          email.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
}

