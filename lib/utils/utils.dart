import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_reader/models/scan_model.dart';

launchUrl1(context, ScanModel scan) async {
  final  url = Uri.parse(scan.valor);

  if(scan.tipo =='http'){
    if (await canLaunchUrl(url)) {
        await launchUrl(url);
    }else{
      throw 'Could not launch $url';
    }
  }else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
  
}