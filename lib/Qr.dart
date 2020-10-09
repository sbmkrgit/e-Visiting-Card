import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class QrCode extends StatefulWidget {
  final List<String> getDetails;

  const QrCode({Key key, this.getDetails}) : super(key: key);

  @override
  _QrCodeState createState() => _QrCodeState(getDetails);
}

class _QrCodeState extends State<QrCode> {
  List<String> getDetails = <String>[];
  _QrCodeState(this.getDetails);
  GlobalKey globalKey = new GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 16);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      Share.shareFiles(['${tempDir.path}/image.png']);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  _captureAndSharePng();
                })
          ],
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: '${getDetails.join('\n')}',
                        size: 250.0,
                        version: 10,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: 350,
                      child: ListView(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.yellowAccent,
                            elevation: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.person,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[0].toUpperCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.email,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[1].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.home,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[2].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.description,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[3].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.web_asset,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[4].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.web,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[5].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.phone,
                                      size: 30, color: Colors.black),
                                  title: Text('${getDetails[6].toLowerCase()}',
                                      style: TextStyle(fontSize: 20.0)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('SHARE'),
                                      onPressed: () {/* ... */},
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
