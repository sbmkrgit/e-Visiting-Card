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
  var globalKeyQr = new GlobalKey();
  var globalKeyCard = new GlobalKey();

  Future<void> _captureAndShareQr() async {
    try {
      RenderRepaintBoundary boundaryQr =
          globalKeyQr.currentContext.findRenderObject();
      var image = await boundaryQr.toImage(pixelRatio: 16);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDirQr = await getTemporaryDirectory();
      final fileQr = await new File('${tempDirQr.path}/imageQr.png').create();
      await fileQr.writeAsBytes(pngBytes);

      Share.shareFiles(['${tempDirQr.path}/imageQr.png']);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _shareCard() async {
    try {
      RenderRepaintBoundary boundaryCard =
          globalKeyCard.currentContext.findRenderObject();
      var image = await boundaryCard.toImage(pixelRatio: 16);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final fileCard = await new File('${tempDir.path}/imageCard.png').create();
      await fileCard.writeAsBytes(pngBytes);

      Share.shareFiles(['${tempDir.path}/imageCard.png']);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: RepaintBoundary(
                      key: globalKeyQr,
                      child: QrImage(
                        data: '${getDetails.join('\n')}',
                        size: 250.0,
                        version: 10,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      width: 350,
                      child: RepaintBoundary(
                        key: globalKeyCard,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.yellowAccent,
                          elevation: 10,
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
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
                                title: Text('${getDetails[2]}',
                                    style: TextStyle(fontSize: 20.0)),
                              ),
                              ListTile(
                                leading: Icon(Icons.description,
                                    size: 30, color: Colors.black),
                                title: Text('${getDetails[3]}',
                                    style: TextStyle(fontSize: 20.0)),
                              ),
                              ListTile(
                                leading: Icon(Icons.web_asset,
                                    size: 30, color: Colors.black),
                                title: Text('${getDetails[4]}',
                                    style: TextStyle(fontSize: 20.0)),
                              ),
                              ListTile(
                                leading: Icon(Icons.web,
                                    size: 30, color: Colors.black),
                                title: Text('${getDetails[5]}',
                                    style: TextStyle(fontSize: 20.0)),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone,
                                    size: 30, color: Colors.black),
                                title: Text('${getDetails[6]}',
                                    style: TextStyle(fontSize: 20.0)),
                              ),

                              /* Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('SHARE'),
                                    onPressed: () {
                                      _shareCard();
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ), */
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton.icon(
                          color: Colors.green,
                          onPressed: () {
                            _captureAndShareQr();
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Share QR',
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(padding: EdgeInsets.all(10)),
                      RaisedButton.icon(
                          color: Colors.green,
                          onPressed: () {
                            _shareCard();
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Share Card',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
