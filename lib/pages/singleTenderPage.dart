import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tms/scopes/main_scope.dart';
import 'applyTenderPage.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';


class SingleTenderPage extends StatefulWidget {
final Map _data;

  SingleTenderPage(this._data);
  @override
  _SingleTenderPageState createState() => _SingleTenderPageState();
}

class _SingleTenderPageState extends State<SingleTenderPage> {
  _SingleTenderPageState();

  SharedPreferences sharedPreferences;
  bool is_logged_in = false;
  String public_id = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs =  await SharedPreferences.getInstance();
    if(prefs.getString("public_id") != null){
      is_logged_in = true;
      public_id = prefs.getString("public_id");
    } else {
      is_logged_in = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("READ MORE"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
        return Container(
          child: ListView(
            children: <Widget>[
              Card(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget._data['category'], style: TextStyle(color: Colors.blue)),
                      Padding(padding: EdgeInsets.only(bottom: 3.0)),
                      Text(widget._data['company_name']),
                      Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      ListTile(
                        title: Text(widget._data['title'] ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(widget._data['description']),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('APPLY NOW'),
                              onPressed: () {
                                if(is_logged_in == true){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ApplyForTenderPage(widget._data, public_id)),
                                  );
                                } else {
                                  this._showDialog();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        );
        }
      )
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login Required"),
          content: new Text("To apply first login in"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
