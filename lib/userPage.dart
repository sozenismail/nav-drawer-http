import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcı Sayfası"),
       ),

      body: Center(child: Text("Kullanıcı Sayfası", style: TextStyle(color: Colors.blue, fontSize: 20),)),
    );
  }
}
