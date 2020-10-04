import 'package:e_visiting_card/NavigationDrawer.dart';
import 'package:e_visiting_card/generate.dart';
import 'package:e_visiting_card/scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("E-Visiting Card"),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Image.asset(
                'images/card.png',
                fit: BoxFit.fill,
              ),
              maxRadius: 150,
              backgroundColor: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scanner()),
                    );
                  },
                  color: Colors.yellow,
                  elevation: 5.0,
                  icon: Icon(Icons.select_all),
                  label: Text('SCAN', style: TextStyle(fontSize: 20))),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: RaisedButton.icon(
                elevation: 5.0,
                color: Colors.lightBlue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Generate()),
                  );
                },
                icon: Icon(Icons.card_travel),
                label: Text(
                  'GENERATE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
