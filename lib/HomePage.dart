import 'package:e_visiting_card/NavigationDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}
