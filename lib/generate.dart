import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'Qr.dart';

class Generate extends StatefulWidget {
  final List<String> details = <String>[];
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _company = new TextEditingController();
  final TextEditingController _designation = new TextEditingController();
  final TextEditingController _webSite = new TextEditingController();
  final TextEditingController _linkedInUrl = new TextEditingController();
  final TextEditingController _contactNumber = new TextEditingController();

  List<String> details = <String>[];

  void addItemToList() {
    setState(() {
      details.insert(0, _name.text);
      details.insert(1, _email.text);
      details.insert(2, _company.text);
      details.insert(3, _designation.text);
      details.insert(4, _webSite.text);
      details.insert(5, _linkedInUrl.text);
      details.insert(6, _contactNumber.text);
    });
  }

  void clearForm() {
    _name.clear();
    _email.clear();
    _company.clear();
    _designation.clear();
    _webSite.clear();
    _linkedInUrl.clear();
    _contactNumber.clear();
  }

  /* void _sendDataToQrPage(BuildContext context) {
    List<String> listToSend = details;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrCode(
            getDetails: listToSend,
          ),
        ));
  } */

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
                key: _formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.zero,
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.perm_identity)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(errorText: 'Not Valid !'),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: _company,
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
                        controller: _designation,
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
                        controller: _webSite,
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
                        controller: _linkedInUrl,
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
                        controller: _contactNumber,
                        decoration: InputDecoration(
                            labelText: "Contact Number",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone)),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          LengthRangeValidator(
                              min: 10,
                              max: 10,
                              errorText: "Please enter valid mobile number ! ")
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton.icon(
                        elevation: 5.0,
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            addItemToList();
                            clearForm();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QrCode(
                                    getDetails: details,
                                  ),
                                ));
                          }
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
