import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List <ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan (String valor) async {

    final nuevoScan = ScanModel(valor: valor);
    final id = await DBprovider.db.nuevoScan(nuevoScan);
    // Asignar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if(tipoSeleccionado == nuevoScan.tipo){
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

    cargarScans() async{
      final scans = await DBprovider.db.getTodosLosScans();
      this.scans = [...scans];
      notifyListeners(); 
  }

    cargarScanPorTipo( String tipo) async{
      final scans = await DBprovider.db.getScansPorTipo(tipo);
      this.scans = [...scans];
      tipoSeleccionado = tipo;
      notifyListeners(); 

  }

    borrarTodos() async{
      await DBprovider.db.deleteAllScans();
      scans = [];
      notifyListeners(); 
  }

    borrarScanId(int id) async{
      await DBprovider.db.borrarScan(id);

  }

}