import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanList extends StatelessWidget {
  final IconData icon;
  const ScanList({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =Provider.of<ScanListProvider>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: scanListProvider.scans.length,
        itemBuilder: (_, int index) => Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.deepPurple),
          onDismissed: (direction) => scanListProvider.borrarScanId(scanListProvider.scans[index].id!),
          child: ListTile(
            leading:  Icon(icon, color: Colors.deepPurple,),
            title: Text(scanListProvider.scans[index].valor),
            subtitle: Text('${scanListProvider.scans[index].id}'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => launchUrl1(context,scanListProvider.scans[index] ),
          ),
        ),
      ),
    );
  }
}