import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String result = "Hey there !";

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    _toastInfo(info);
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> _captureAndSavePng() async {
    screenshotController.capture(pixelRatio: 16.0).then((File image) async {
      _toastInfo("Capture Done");
      setState(() {});
      ImageGallerySaver.saveImage(image.readAsBytesSync());
      _toastInfo("File Saved to Gallery");
    }).catchError((onError) {
      print(onError);
    });
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {
                //to be implemented
              }),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _captureAndSavePng();
              })
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  result,
                  style: new TextStyle(
                      color: Colors.orange,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
