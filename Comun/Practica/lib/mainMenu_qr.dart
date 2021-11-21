import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainPage1 extends StatefulWidget {
  static final String title = 'GPS-Quest';
  @override
  _ScannerState createState() => _ScannerState();
  }

  class _ScannerState extends State<MainPage1> {
  String result = "Pulsa Escanear";

  Future _scanQR() async {
  try {
  ScanResult qrScanResult = await BarcodeScanner.scan();
  String qrResult = qrScanResult.rawContent;
  setState(() {
  result = qrResult;
  });
  } on PlatformException catch (ex) {
  if (ex.code == BarcodeScanner.cameraAccessDenied) {
  setState(() {
  result = "Acceso a cámara denegado";
  });
  } else {
  setState(() {
  result = "Error desconocido $ex";
  });
  }
  } on FormatException {
  setState(() {
  result = "Presionó volver antes de escanear";
  });
  } catch (ex) {
  setState(() {
  result = "Error desconocido $ex";
  });
  }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text("GPS-Quest QR Scanner"),
  ),
  body: Center(
  child: Text(
  result,
  style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  ),
  ),
  floatingActionButton: FloatingActionButton.extended(
  icon: Icon(Icons.camera_alt),
  label: Text("Escanear"),
  onPressed: _scanQR,
  ),
  );
  }
  }


