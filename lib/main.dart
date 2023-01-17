import 'package:flutter/material.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/home_screen.dart';
import 'package:qr_reader/screens/mapa_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => UiProvider())),
        ChangeNotifierProvider(create: ((_) => ScanListProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home':(_) => const HomeScreen(),
          'mapa':(_) => const MapaScreen(),
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple) ,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple )
        ),
      ),
    );
  }
}