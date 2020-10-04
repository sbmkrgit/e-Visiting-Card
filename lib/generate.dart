import 'package:e_visiting_card/Qr.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Generate Card"),
        ),
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              Form(
                //autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.zero,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.perm_identity)),
                        validator:
                            RequiredValidator(errorText: "Can't be Empty !"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email)),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Can't be Empty !"),
                            EmailValidator(errorText: 'Not Valid !'),
                          ])),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Company Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.work)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Designation",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                            labelText: "Web-Site",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.web_asset)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                            labelText: "LinkedIn URL",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.web)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Contact Number",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone)),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Can't be Empty !"),
                          ])),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton.icon(
                        elevation: 5.0,
                        color: Colors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QrCode()),
                          );
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        label: Text(
                          'SUBMIT',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
