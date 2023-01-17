import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/direccioes_page.dart';
import 'package:qr_reader/screens/mapas_page.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Historial')),
        actions: [
          IconButton(
            onPressed: (() => scanListProvider.borrarTodos()), 
            icon: const Icon(Icons.delete_forever_outlined))
        ]),
      body:  _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
      );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Obtener el select menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    
    //Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar el scanListProvider

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);


    switch(currentIndex){
      case 0:
      scanListProvider.cargarScanPorTipo('geo');
      return const MapasScreen();

      case 1:
      scanListProvider.cargarScanPorTipo('http');
      return const DireccionesScreen();

      default: 
      return const MapasScreen();
    }
  }
}