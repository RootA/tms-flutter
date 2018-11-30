import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  SharedPreferences sharedPreferences;

  String full_name = null;
  String email = null;
  String company_name = null;
  String phone_number = null;
  String user_type = null;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final prefs =  await SharedPreferences.getInstance();
    String is_logged_in = prefs.getString("public_id");
    if(is_logged_in != null){
      setState(() {
        full_name = prefs.getString("full_name");
        email = prefs.getString("email");
        company_name = prefs.getString("company_name");
        user_type = prefs.getString("user_type");
        phone_number = prefs.getString("phone_number");
      });
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('public_id');
    prefs.remove('company_name');
    prefs.remove('email');
    prefs.remove('full_name');
    prefs.remove('user_type');
    prefs.remove('type_id');
    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('phone_number');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            clearData();
            Navigator.pushNamed(context, '/');
          })
        ],
      ),
      body: ListView(
          children: [
            Image.network("https://cms-assets.tutsplus.com/uploads/users/23/posts/21305/image/how-to-combine-merge-gmail-accounts.jpg", fit: BoxFit.cover,),
            Padding(padding: EdgeInsets.only(top: 8.0)),
        Container(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        full_name ?? 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      company_name ?? 'N/A',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      email ?? 'N/A',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      phone_number ?? 'N/A',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
//        Icon(
//          Icons.star,
//          color: Colors.red[500],
//        ),
//        Text('41'),
            ],
          ),
          ),
          ]
      ),
    );
  }

//
//  Column buildButtonColumn(IconData icon, String label) {
//    Color color = Theme.of(context).primaryColor;
//
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        Icon(icon, color: color),
//        Container(
//          margin: const EdgeInsets.only(top: 8.0),
//          child: Text(
//            label,
//            style: TextStyle(
//              fontSize: 12.0,
//              fontWeight: FontWeight.w400,
//              color: color,
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget buttonSection = Container(
//    child: Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: [
//        buildButtonColumn(Icons.call, 'CALL'),
//        buildButtonColumn(Icons.near_me, 'ROUTE'),
//        buildButtonColumn(Icons.share, 'SHARE'),
//      ],
//    ),
//  );
}
