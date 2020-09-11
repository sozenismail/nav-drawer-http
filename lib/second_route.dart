import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:httprequestlogin/detailPage.dart';
import 'package:httprequestlogin/http_service.dart';
import 'package:httprequestlogin/main.dart';
import 'package:httprequestlogin/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'userPage.dart';
import 'user_model.dart';



class SecondRoute extends StatelessWidget {
  final String token;

  SecondRoute({this.token});
  HttpService service = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Kullanıcı Listesi"),
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
          child: FutureBuilder<UserModel>(
            future: service.userGet(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                List<Datum> users = snapshot.data.data;
                return ListView(
                  children: users
                      .map((Datum info) => Card(
                        child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(info),
                                  ),
                                );
                              },
                              title: Text(info.firstName),
                              subtitle: Text(info.email),
                              leading: Image.network(info.avatar,),
                    trailing: Icon(Icons.delete),
                            ),
                      ))
                      .toList(),
                );
              } else {}
              return CircularProgressIndicator();
            },
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


class NavDrawer extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Menüler',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Giris Sayfası'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Kullanıcılar'),
            onTap: () =>
              {

            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
            )
         }
            ,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap: () => {},
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}