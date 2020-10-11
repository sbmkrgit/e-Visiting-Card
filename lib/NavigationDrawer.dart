import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Stack(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: CircleAvatar(
                    radius: 55,
                    child: ClipOval(
                      //borderRadius:BorderRadius.circular(70),
                      child: Image.asset(
                        'images/person.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("Welcome to E-Visiting Card",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
              ])),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text(
              'My Cards',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text(
              'Help',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'About this App !!',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
