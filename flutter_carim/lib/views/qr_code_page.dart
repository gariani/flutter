import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QrCodePage extends StatefulWidget {
  final String data;
 
  QrCodePage({this.data});

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: widget.data,
      version: QrVersions.auto,
      size: 100.0,
    );
  }
}
