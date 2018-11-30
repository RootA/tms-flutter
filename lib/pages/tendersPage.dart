import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tms/scopes/main_scope.dart';
import 'singleTenderPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TendersListingPage extends StatefulWidget {
  final MainScope _model;
  TendersListingPage(this._model);
  @override
  _TendersListingPageState createState() => _TendersListingPageState(_model);
}

class _TendersListingPageState extends State<TendersListingPage> {
  final MainScope _model;
  _TendersListingPageState(this._model);

  SharedPreferences sharedPreferences;
  String full_name = null;
  String email = null;
  String route_name = '/login';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    String is_logged_in = prefs.getString("public_id");
    if(is_logged_in != null){
      setState(() {
        full_name = prefs.getString("full_name");
        email = prefs.getString("email");
      });
      route_name = '/account';
      _model.fetchTenderListings(_model);
    } else {
//      Navigator.pushNamed(context, '/login');
      _model.fetchTenderListings(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TMS"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(accountName: Text(full_name ?? ''), accountEmail: Text(email ?? '')),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text("Account"),
              onTap: () {
                Navigator.pushNamed(context, route_name);
              },
            ),
            ListTile(
              title: Text('My Tenders'),
              onTap: () {
                Navigator.pushNamed(context, '/mytenders');
              },
            ),
            ListTile(
              title: Text('My Bids'),
              onTap: () {
                Navigator.pushNamed(context, '/mybids');
              },
            ),
          ],
        ),
      ),
      body: ScopedModelDescendant<MainScope>(builder: (context, child, MainScope model) {
        return Container(
          child: ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: <Widget>[
                    Card(
                      semanticContainer: true,
                      elevation: 2.0,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(_model.tenderListings[index]['title'], style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                            Text(_model.tenderListings[index]['category'], style: TextStyle(color: Colors.blue), textAlign: TextAlign.left,),
                            Text(_model.tenderListings[index]['company_name'], style: TextStyle(color: Colors.grey), textAlign: TextAlign.left),
                            Text(_model.tenderListings[index]['description'], overflow: TextOverflow.ellipsis),
                            ButtonTheme.bar(
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text('READ MORE', style: TextStyle(color: Colors.blue),),
                                    splashColor: Colors.amberAccent,
                                    onPressed: (){
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => SingleTenderPage(_model.tenderListings[index])),
                                        );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: _model.tenderListings.length,
          ),
        );
       },
      )
    );
  }
}

