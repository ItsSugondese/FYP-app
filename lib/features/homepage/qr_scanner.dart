import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  final Function(String, bool) callback;
  const QrScannerScreen({super.key, required this.callback});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  Widget build(BuildContext context) {
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
            String val = barcodes[0].rawValue ?? "empty";
            bool isTrue = false;
            RegExp regExp = RegExp(r':');

            if (val.isNotEmpty && regExp.hasMatch(val)) {
              isTrue = true;
            }
            widget.callback(val, isTrue);

            final Uint8List? image = capture.image;
            barcodes.removeAt(0);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class QrScanner {
  static Future<void> showForQr(
      BuildContext context, Function(String, bool) callback) async {
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
                    String val = barcodes[0].rawValue ?? "empty";
                    bool isTrue = false;
                    RegExp regExp = RegExp(r':');

                    if (val.isNotEmpty && regExp.hasMatch(val)) {
                      isTrue = true;
                    }
                    callback(val, isTrue);
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
