import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httprequestlogin/second_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: token == null ? MyApp() : SecondRoute(token: token),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Giriş Sayfası'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map<String, String> _user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSNWPxJVAomROTc7ozb-S3HdYajHUPAmadZYA&usqp=CAU",width: 170, height: 170,),
        SizedBox(height: 30,),

        TextField(
        decoration: InputDecoration(
            hintText: "Email",
            border: new OutlineInputBorder(
              //borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(
                    color: Colors.white, width: 0.0) //This is Ignored,
            )),
          onChanged: (val) {
            setState(() {
              _user['email'] = val;
            });
          }),
        SizedBox(height: 25),
        TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                border: new OutlineInputBorder(
                  //borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                        color: Colors.white, width: 0.0) //This is Ignored,
                )),
            onChanged: (val) {
              setState(() {
                _user['password'] = val;
              });
            }),
            SizedBox(height: 35),
            ButtonTheme(
                minWidth: double.infinity,
                height: 45,
                child: OutlineButton(
                  child: Text("Register"),
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    style: BorderStyle.solid,
                    width: 1.9,
                  ),
                  onPressed: () {
                    register();
                  },
                ))
          ],
        ),
      ),
    );
  }

  void register() {
    // http.post("https://reqres.in/api/login", body: {"email": "eve.holt@reqres.in", "password": "pistol"}).then((res) {
    http.post("https://reqres.in/api/login", body: _user).then((res) async {

      var resJson = json.decode(res.body);
      if (resJson['error'] != null) {
        Toast.show("Hata var ->" + resJson['error'], context,
            gravity: Toast.BOTTOM);
      } else {
        //Toast.show("Giriş Başarılı " + resJson['token'], context, gravity: Toast.CENTER);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', resJson['token']);


        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondRoute(token: resJson['token'])),
        );
      }
    });
  }


}
