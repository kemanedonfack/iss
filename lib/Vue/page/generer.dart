import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatefulWidget {

  final donnee;

  QRCode(this.donnee);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRcode"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.share), 
            onPressed: (){
              _captureAndSharePng();
            }
          )
        ],
      ),
      body: Center(
        child: RepaintBoundary(
                 key: globalKey,
                  child: QrImage(
              data: widget.donnee,
            version: QrVersions.auto,
            size: 250.0,
            gapless: false,
          ),
        ),
      ),
    );
  }

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
      
      await Share.file(widget.donnee, '$widget.donnee.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }

//  Future<Uint8List> _capturePng() async {
//     try {
//       print('inside');
//       RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData byteData =await image.toByteData(format: ui.ImageByteFormat.png);
//       var pngBytes = byteData.buffer.asUint8List();
//       var bs64 = base64Encode(pngBytes);
//       print(pngBytes);
//       print(bs64);
//       setState(() {});
//       return pngBytes;
//     } catch (e) {
//       print(e);
//     }
//   }

//    void _incrementCounter() async {
//     var imageUint8List = await _capturePng();
//     await WcFlutterShare.share(
//         sharePopupTitle: 'share',
//         fileName: 'share.png',
//         mimeType: 'image/png',
//         bytesOfFile: imageUint8List);
  
//   }

}
