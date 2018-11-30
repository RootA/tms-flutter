import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tms/scopes/main_scope.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApplyForTenderPage extends StatefulWidget {
  final Map _data;
  final String public_id;
  ApplyForTenderPage(this._data, this.public_id);
  @override
  _ApplyForTenderPageState createState() => _ApplyForTenderPageState();
}



class applicationValues {
  String postResponse = 'Proccessing...';
  String amount = '';
  String tender_id = '';
  String session_id =  '';
  String duration = '';
}

class PostApplication extends _ApplyForTenderPageState {
  applicationValues _values = new applicationValues();
  Future postData(Map<String, dynamic> postValues) async {
    var newpostValues = json.encode(postValues);
    String mainurl = 'http://localhost:5000/api/v1/bid';
    http.Response response = await http.post(mainurl, body: newpostValues,  headers: {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json'
    });
    print(response.body);
    if(response.statusCode == 200){
      _values.postResponse = 'Successfully placed your bid';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
//      _ApplyForTenderPageState()._showDialog;
    } else if(response.statusCode == 422){
      _values.postResponse = 'Looks like youve already applied';
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
//      _ApplyForTenderPageState()._showDialog;
    } else {
        _values.postResponse = 'An error has occured';
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
//        _ApplyForTenderPageState()._showDialog;
    }
  }
}

class _ApplyForTenderPageState extends State<ApplyForTenderPage> {
  applicationValues _values = new applicationValues();
  PostApplication _application = new PostApplication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Now"),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.save), onPressed: () {
            Map<String, dynamic> postData = {
              'amount' : _values.amount,
              'duration' : _values.duration,
              'tender_id' : widget._data['public_id'],
              'session_id': widget.public_id
            };
            _application.postData(postData);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
          })
        ],
      ),
      body: ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              ListTile(
                leading: Icon(Icons.description),
                title: Text(widget._data['title']),
                subtitle: Text(widget._data['application_start_date'] + "-" + widget._data['application_close_date']),
              ),
              ListTile(
                leading: Icon(Icons.control_point_duplicate),
                title: Text(widget._data['category']),
                subtitle: Text(widget._data['tender_code']),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Days required to complete project (DAYS)",
                      hintText: "90 Days"
                  ),
                  onChanged: (String value){
                    _values.duration = value;
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Cost",
                      hintText: "10000 KES"
                  ),
                  onChanged: (String value){
                      _values.amount = value;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
            ],
          );
      }),
    );
  }
}
