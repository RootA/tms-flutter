import 'package:flutter/material.dart';
import 'package:tms/scopes/main_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTendersPage extends StatefulWidget {
  final MainScope _model;
  MyTendersPage(this._model);
  @override
  _MyTendersPageState createState() => _MyTendersPageState();
}

class _MyTendersPageState extends State<MyTendersPage> {

  SharedPreferences sharedPreferences;
  String public_id = null;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs =  await SharedPreferences.getInstance();
    String _public_id = prefs.getString("public_id");
    if(_public_id != null){
      public_id = _public_id;
      widget._model.fetchMyTenderListings(widget._model, _public_id);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Tenders"),
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
        title: Text("My Tenders"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
        return Container(
          child: ListView.builder(
              itemBuilder: (BuildContext context, index){
                return Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text(widget._model.mytenderListings[index]['tender']['tender_code'], style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                            Text(widget._model.mytenderListings[index]['tender']['category'], style: TextStyle(color: Colors.lightBlueAccent)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mytenderListings[index]['tender']['title']),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text('Bid Amount :' + widget._model.mytenderListings[index]['amount'], style: TextStyle(color: Colors.grey)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text('Status :' + widget._model.mytenderListings[index]['status'], style: TextStyle(color: Colors.blueAccent)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Divider(
                              height: 4.0,
                            ),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mytenderListings[index]['tender']['owner']['company'] ?? "N/A", style: TextStyle(color: Colors.black54)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mytenderListings[index]['tender']['owner']['email'], style: TextStyle(color: Colors.grey)),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            Text(widget._model.mytenderListings[index]['tender']['owner']['phone_number'], style: TextStyle(color: Colors.grey)),
                          ],
//                          children: <Widget>[
//                            Text(widget._model.tenderListings[index]['tender']['tender_code'], style: TextStyle(fontWeight: FontWeight.bold)),
//                            Text(widget._model.tenderListings[index]['tender']['category']),
//                            Text(widget._model.tenderListings[index]['tender']['title']),
//                          ],
                        ),
                      )
                    )
                  ],
                );
              },
            itemCount: widget._model.mytenderListings.length,
          )
          ,
        );
      }),
    );
  }
}
