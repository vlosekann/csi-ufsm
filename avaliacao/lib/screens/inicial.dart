import 'package:flutter/material.dart';
import 'package:avaliacao/screens/login.dart';

class Inicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicativo em Flutter'),
        centerTitle: true,
          automaticallyImplyLeading: false
      ),
      body: Container(
        //color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 50.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login()));
          },
          color: Colors.blue,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          padding: EdgeInsets.all(20.0),
          child: Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
