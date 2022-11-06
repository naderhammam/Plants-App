import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/colors.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _barcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Scanner',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 230.w,
              height: 54.h,
              decoration: BoxDecoration(
                color: PrimaryGreen,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: MaterialButton(
                onPressed: () => scanCode(),
                child: Text(
                  'Scan Now',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scanCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#1ABC00', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        _barcode = qrCode;
      });
    } on PlatformException {
      _barcode = 'Failed to get platform version.';
    }
  }
}
