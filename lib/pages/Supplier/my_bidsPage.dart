import 'package:flutter/material.dart';
import 'package:tms/scopes/main_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyBidsPage extends StatefulWidget {
  final MainScope _model;
  MyBidsPage(this._model);
  @override
  _MyBidsPageState createState() => _MyBidsPageState();
}

class _MyBidsPageState extends State<MyBidsPage> {

  SharedPreferences sharedPreferences;
  String public_id = null;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs =  await SharedPreferences.getInstance();
    String is_logged_in = prefs.getString("public_id");
    if(is_logged_in != null){
      setState(() {
        public_id = prefs.getString("public_id");
      });
      widget._model.fetchMybidsListings(widget._model, public_id);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Bids"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container(
          child: Text("Login is required"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bids"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
        return Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, index){
              return Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text(widget._model.mybidListings[index]['tender']['tender_code'], style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                            Text(widget._model.mybidListings[index]['tender']['category'], style: TextStyle(color: Colors.lightBlueAccent)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mybidListings[index]['tender']['title']),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text('Bid Amount :' + widget._model.mybidListings[index]['amount'], style: TextStyle(color: Colors.grey)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text('Status :' + widget._model.mybidListings[index]['status'], style: TextStyle(color: Colors.blueAccent)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Divider(
                              height: 4.0,
                            ),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mybidListings[index]['tender']['owner']['company'] ?? "N/A", style: TextStyle(color: Colors.black54)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mybidListings[index]['tender']['owner']['email'], style: TextStyle(color: Colors.grey)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mybidListings[index]['tender']['owner']['phone_number'], style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                  )
                ],
              );
            },
            itemCount: widget._model.mybidListings.length,
          )
          ,
        );
      }),
    );
  }
}
