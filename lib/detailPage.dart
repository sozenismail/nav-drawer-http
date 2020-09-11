
import 'package:flutter/material.dart';
import 'package:httprequestlogin/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class DetailPage extends StatelessWidget {

  final Datum info;
  const DetailPage(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detay Sayfası"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    cikisyap(context);
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(info.avatar)
              ),
              SizedBox(height: 30),
              Text(
                info.firstName + " " + info.lastName,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  Future<void> cikisyap(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}
