import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scopes/main_scope.dart';
import 'pages/tendersPage.dart';
import 'pages/login/login.dart';
import 'pages/Supplier/my_tendersPage.dart';
import 'pages/Supplier/my_bidsPage.dart';
import 'pages/login/AccountPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainScope _model = MainScope();

@override
Widget build(BuildContext context) {
  return ScopedModel(
      model: _model,
      child:  MaterialApp(
        theme: ThemeData.light(),
        routes: {
          '/': ((BuildContext context) => TendersListingPage(_model)),
          '/login' : ((BuildContext context) => LoginPage(_model)),
          '/mytenders': ((BuildContext context) => MyTendersPage(_model)),
          '/mybids': ((BuildContext context) => MyBidsPage(_model)),
          '/account': ((BuildContext context) => AccountPage()),
        },
      )
  );
}
}