import 'dart:convert';
import 'dart:math';

import 'package:pudins_da_nega/aplicacao/a_cliente.dart';
import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';
import 'package:sqflite/sqflite.dart';

class DAOCliente implements IDAOCliente {
  late Database _db;
  final sqlInserirEndereco = '''
    INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES (?,?,?,?,?,?)
  ''';

  final sqlInserirCliente = '''
    INSERT INTO cliente (nome, cpf, cep, status,url_avatar, telefone, endereco_id) VALUES (?,?,?,?,?,?,?)
  ''';

  final sqlAlterarEndereco = '''
    UPDATE endereco SET rua=?, numero=?, complemento=?, bairro=?, cidade=?, estado=?
    WHERE id = ?
  ''';

  final sqlAlterarCliente = '''
    UPDATE cliente SET nome=?, cpf=?, 
    cep=?, status =?, url_avatar=?, telefone=?, endereco_id=?
    WHERE id = ?
  ''';

  final sqlAlterarStatus = '''
    UPDATE cliente SET status='I'
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT c.*, e.*
    FROM cliente c
    JOIN endereco e ON c.endereco_id = e.id
    WHERE c.id = ?;
  ''';

  final sqlConsultar = '''
    SELECT c.*, e.*
    FROM cliente c
    JOIN endereco e ON c.endereco_id = e.id;
  ''';

  @override
  Future<List<DTOCliente>> consultar() async {
    print('A função consultar() do DAO foi acessada.');
    _db = await Conexao.abrir();
    print('Retornando ao consultar a partir do banco');
    var resultado = await _db.rawQuery(sqlConsultar);

    print('Resultado do banco:');
    for (var linha in resultado) {
      print(linha); // Exibe todas as colunas e valores da linha
    }
    List<DTOCliente> clientes = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOCliente(
          id: linha['id'],
          nome: linha['nome'].toString(),
          cpf: linha['cpf'].toString(),
          cep: linha['cep'].toString(),
          status: linha['status'].toString(),
          urlAvatar: linha['url_avatar'].toString(),
          telefone: linha['telefone'].toString(),
          endereco: Endereco(
            id: linha['endereco_id'],
            rua: linha['rua'].toString(),
            numero: int.parse(linha['numero'].toString()),
            complemento: linha['complemento'].toString(),
            bairro: linha['bairro'].toString(),
            cidade: linha['cidade'].toString(),
            estado: linha['estado'].toString(),
          ));
    });
    return clientes;
  }

  @override
  Future<DTOCliente> consultarPorId(int id) async {
    _db = await Conexao.abrir();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTOCliente cliente = DTOCliente(
        id: resultado['id'],
        nome: resultado['nome'].toString(),
        cpf: resultado['cpf'].toString(),
        cep: resultado['cep'].toString(),
        status: resultado['status'].toString(),
        urlAvatar: resultado['url_avatar'].toString(),
        telefone: resultado['telefone'].toString(),
        endereco: Endereco(
          id: resultado['e.id'],
          rua: resultado['rua'].toString(),
          numero: int.parse(resultado['numero'].toString()),
          complemento: resultado['complemento'].toString(),
          bairro: resultado['bairro'].toString(),
          cidade: resultado['cidade'].toString(),
          estado: resultado['estado'].toString(),
        ));
    return cliente;
  }

  @override
  Future<DTOCliente> salvar(DTOCliente dto) async {
    _db = await Conexao.abrir();

    int enderecoId = await _db.rawInsert(sqlInserirEndereco, [
      dto.endereco.rua,
      dto.endereco.numero,
      dto.endereco.complemento,
      dto.endereco.bairro,
      dto.endereco.cidade,
      dto.endereco.estado
    ]);

    int clienteId = await _db.rawInsert(sqlInserirCliente, [
      dto.nome,
      dto.cpf,
      dto.cep,
      dto.status,
      dto.urlAvatar,
      dto.telefone,
      enderecoId
    ]);

    dto.id = clienteId;
    print("dto que foi salvo ${dto}");
    return dto;
  }

  @override
  Future<DTOCliente> alterar(DTOCliente dto) async {
    _db = await Conexao.abrir();

    print('>>>>>>>>>>>>>>>ALTERAR CLIENTES: ${dto}');
    int.parse(dto.endereco.numero.toString());

    print('Alterando endereço com os seguintes dados:');
    print('Rua: ${dto.endereco.rua} (${dto.endereco.rua.runtimeType})');

    try {
      print(
          'Número: ${dto.endereco.numero} (${dto.endereco.numero.runtimeType})');
    } catch (e) {
      print('Erro ao imprimir número: $e');
    }
    print(
        'Complemento: ${dto.endereco.complemento} (${dto.endereco.complemento.runtimeType})');
    print(
        'Bairro: ${dto.endereco.bairro} (${dto.endereco.bairro.runtimeType})');
    print(
        'Cidade: ${dto.endereco.cidade} (${dto.endereco.cidade.runtimeType})');
    print(
        'Estado: ${dto.endereco.estado} (${dto.endereco.estado.runtimeType})');

    try {
      print(
          'ID Endereço: ${dto.endereco.id.toString()} (${dto.endereco.id.runtimeType})');
    } catch (e) {
      print('Erro ao imprimir ID do endereço: $e');
    }
    print('Alterando cliente com os seguintes dados:');
    print('Nome: ${dto.nome} (${dto.nome.runtimeType})');
    print('CPF: ${dto.cpf} (${dto.cpf.runtimeType})');
    print('CEP: ${dto.cep} (${dto.cep.runtimeType})');
    print('Status: ${dto.status} (${dto.status.runtimeType})');
    print('URL Avatar: ${dto.urlAvatar} (${dto.urlAvatar.runtimeType})');
    print('Telefone: ${dto.telefone} (${dto.telefone.runtimeType})');
    print(
        'ID Endereço Cliente: ${dto.endereco.id.toString()} (${dto.endereco.id.runtimeType})');
    print('ID Cliente: ${dto.id.toString()} (${dto.id.runtimeType})');

    print('>>>>>>>>>>>>>ENDEREÇO RUA ${dto.endereco.rua}');
    final rowsUpdatedEndereco = await _db.rawUpdate(sqlAlterarEndereco, [
      dto.endereco.rua,
      dto.endereco.numero,
      dto.endereco.complemento,
      dto.endereco.bairro,
      dto.endereco.cidade,
      dto.endereco.estado,
      int.parse(dto.endereco.id.toString())
    ]);

    if (rowsUpdatedEndereco == 0) {
      throw Exception('Nenhuma linha foi alterada para o endereço.');
    } else {
      print('Colunas alteradas do endereco: ${rowsUpdatedEndereco}');
    }

    print('Id do endereço: ${dto.endereco.id}');

    final rowsUpdatedCliente = await _db.rawUpdate(sqlAlterarCliente, [
      dto.nome,
      dto.cpf,
      dto.cep,
      dto.status,
      dto.urlAvatar,
      dto.telefone,
      int.parse(dto.endereco.id.toString()),
      int.parse(dto.id.toString())
    ]);

    if (rowsUpdatedCliente == 0) {
      throw Exception('Nenhuma linha foi alterada para o endereço.');
    } else {
      print('Colunas alteradas do cliente: ${rowsUpdatedCliente}');
    }

    var apCliente = ACliente();
    var lista = apCliente.consultar();
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarStatus, [id]);
    return true;
  }
}
