


import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    db = (await Conexao.abrir())!;
  });

   test('teste scrit create table', () async {
    var list = await db.rawQuery('SELECT * FROM cliente');
    expect(list.length, 3);
  });
}