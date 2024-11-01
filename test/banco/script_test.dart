import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pudins_da_nega/banco/sqlite/script.dart';

main() async {
  setUpAll(() {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  });
   test('Teste do script para criar tabelas', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      expect(() => criarTabelas.forEach(db.execute), returnsNormally);
    });
    await db.close();
  });

  test('Teste do script para inserir registros', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      criarTabelas.forEach(db.execute);
      expect(() => inserirRegistros.forEach(db.execute), returnsNormally);
    });
    await db.close();
  });


    test('teste script criar tabela e inserir registro', () async {
    var db2 = await openDatabase(inMemoryDatabasePath);
    deleteDatabase(db2.path);

    var db = await openDatabase(
      inMemoryDatabasePath,
      version: 2,
      onCreate: (db, version) {
        criarTabelas.forEach(db.execute);
        inserirRegistros.forEach(db.execute);
      },
    );

    var list = await db.rawQuery('SELECT * FROM cliente');
    expect(list.length, 3);
  });
}
