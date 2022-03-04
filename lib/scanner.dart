// Open QR scanner, return a String of the scanned content
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanBarcode() async {
  // store result of scan
  String barcodeScanResult;

  barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", "Cancel", false, ScanMode.BARCODE);

  // return result
  return barcodeScanResult;
}
