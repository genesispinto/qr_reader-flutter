import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBprovider{
  static  Database? _database;
  static final DBprovider db = DBprovider._();

  //constructor privado
  DBprovider._();

   get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

   Future<Database>initDB() async {

    //Path de donde almacenaremos la base de datos 
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //final path = join(documentsDirectory.path, 'ScanDB.db');
    final path = join( await getDatabasesPath() , 'ScanDB.db');
    // var databasesPath = await getDatabasesPath();
    // String path = join(databasesPath, 'ScanDB.db');
    debugPrint(path);

    //Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{
        await db.execute('CREATE TABLE Scans( id INTEGER PRIMARY KEY, tipo TEXT, valor TEXT )');
      },
    );

  }

  Future<int> nuevoScanRaw ( ScanModel nuevoScan) async {

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
  // verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES( $id, '$tipo', '$valor')
    ''');
    return res;

  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final Database db = await database;
    //final res = await db.insert(table, values)
    final res = await db.insert('Scans',nuevoScan.toJson());

    //res es el id del ultimo registro insertado
    print(res);
    return res;
  }

  getScanById (int id) async{

    final Database db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromJson(res.first);
    } else {
      return null;
    }

  }

  Future<List<ScanModel>> getTodosLosScans () async {

    final Database db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
           ? res.map((e) => ScanModel.fromJson(e)).toList()
           : [];

  }

  Future<List<ScanModel>> getScansPorTipo (String tipo) async {

    final Database db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
           ? res.map((e) => ScanModel.fromJson(e)).toList()
           : [];

  }

   Future<int> actualizarScan(ScanModel nuevoScan) async {
    final Database db = await database;
    final res = await db.update('Scans',nuevoScan.toJson(), where: 'id =?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> borrarScan(int id) async {
    final Database db = await database;
    final res = await db.delete('Scans', where: 'id =?', whereArgs: [id]);

    return res;
  }
  Future<int> deleteAllScans() async {
    final Database db = await database;
    final res = await db.delete('Scans');

    return res;
  }
}//data/user/0/com.example.qr_reader/app_flutter/ScanDB.db