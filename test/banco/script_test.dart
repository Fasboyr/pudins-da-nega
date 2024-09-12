import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pudins_da_nega/banco/script.dart';


main() async {
  setUpAll(() {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  });
  test('teste script create table', () async {
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
