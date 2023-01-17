import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';


class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() async {
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( '#3D8BEF', 'CANCELAR', false, ScanMode.QR);
        //const barcodeScanRes = 'http://fernando-herrera.com';
        const barcodeScanRes = 'geo:-33.45694,-70.64827';

        if(barcodeScanRes =='-1'){
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchUrl1( context, nuevoScan);
     }),
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      );
  }
}
