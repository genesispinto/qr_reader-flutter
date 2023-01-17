import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_list.dart';

class MapasScreen extends StatelessWidget {
   
  const MapasScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
     return const ScanList(icon: Icons.map);
  }
}

