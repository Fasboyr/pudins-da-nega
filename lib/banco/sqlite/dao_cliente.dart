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
    'INSERT INTO cliente (nome, cpf, cep, telefone, endereco_id) VALUES (?,?,?,?,?)'
  ''';

  final sqlAlterarEndereco = '''
    UPDATE endereco SET rua=?, numero=?, complemento=?, bairro=?, cidade=?, estado=?,
    WHERE id = ?
  ''';

  final sqlAlterarCliente = '''
    UPDATE cliente SET nome=?, cpf=?, cep=?, telefone=?, endereco_id=?
    WHERE id = ?
  ''';

  final sqlAlterarStatus = '''
    UPDATE cliente SET status='I'
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT * FROM cliente WHERE id = ?;
  ''';

  final sqlConsultar = '''
    SELECT * FROM cliente;
  ''';

  @override
  Future<List<DTOCliente>> consultar() async {
    _db = await Conexao.abrir();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOCliente> clientes = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOCliente(
          id: linha['id'],
          nome: linha['nome'].toString(),
          cpf: linha['CPF'].toString(),
          cep: linha['cep'].toString(),
          telefone: linha['telefone'].toString(),
          endereco: Endereco(
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
        cpf: resultado['CPF'].toString(),
        cep: resultado['cep'].toString(),
        telefone: resultado['telefone'].toString(),
        endereco: Endereco(
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

    int clienteId = await _db.rawInsert(sqlInserirCliente,
        [dto.nome, dto.cpf, dto.cep, dto.telefone, enderecoId]);

    dto.id = clienteId;
    return dto;
  }

  @override
  Future<DTOCliente> alterar(DTOCliente dto) async {
    _db = await Conexao.abrir();

    await _db.rawUpdate(sqlAlterarEndereco, [
      dto.endereco.rua,
      dto.endereco.numero,
      dto.endereco.complemento,
      dto.endereco.bairro,
      dto.endereco.cidade,
      dto.endereco
          .estado, // Certifique-se de que o ID do endereço está presente no DTOCliente
    ]);

    await _db.rawUpdate(
        sqlAlterarCliente, [dto.nome, dto.cep, dto.cpf, dto.telefone, dto.id]);
    return dto;
  }


  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarStatus, [id]);
    return true;
  }
}
