import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:pudins_da_nega/banco/sqlite/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  static Database? _db;

   static Future<Database?> abrir() async {
    if (_db != null) {
      return _db;
    }
     print('Abrindo banco de dados');
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
      }
    var path = join(await getDatabasesPath(), 'banco.db');
     //deleteDatabase(path);
     print('Banco aberto');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print('Criando e inserindo registros');
        criarTabelas.forEach(db.execute);
        inserirRegistros.forEach(db.execute);
      },
      singleInstance: true
    );
   print('Terminando a iniciação do banco');  
       return _db;
  }
}
