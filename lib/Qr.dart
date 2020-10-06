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
  List<String> getDetails;
  _QrCodeState(this.getDetails);
  GlobalKey globalKey = new GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
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
          title: Text('HomePage'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  _captureAndSharePng();
                })
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          RepaintBoundary(
            key: globalKey,
            child: QrImage(
              data: "some text",
              size: 300.0,
              version: 10,
              backgroundColor: Colors.white,
            ),
          ),
          /* Padding(
              padding: EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: getDetails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${getDetails[index]}'),
                  );
                },
              )), */
        ]));
  }
}
