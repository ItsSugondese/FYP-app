import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner {
  static Future<void> showForQr(BuildContext context, Function(String) callback) async {
    String text = "Hello";
    showDialog(
        context: context,
        builder: (BuildContext newContext) {
          return StatefulBuilder(builder: (newContext, setState) {
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    facing: CameraFacing.back,
                    torchEnabled: false,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    callback(barcodes[0].rawValue ?? "empty");
                    final Uint8List? image = capture.image;
                    barcodes.removeAt(0);
                    Navigator.pop(newContext);
                  },
                ),
              ),
            );
          });
        });
  }
}
