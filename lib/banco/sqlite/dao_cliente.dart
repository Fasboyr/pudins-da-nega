import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';
import 'package:sqflite/sqflite.dart';

class DAOCliente implements IDAOCliente{
  late Database _db;

  @override
  Future<DTOCliente> alterarStatus(DTOCliente dto) {
    // TODO: implement alterarStatus
    throw UnimplementedError();
  }

  @override
Future<DTOCliente> salvar(DTOCliente dto) async {
  _db = await Conexao.abrir();
  
  int enderecoId = await _db.rawInsert(
    'INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES (?,?,?,?,?,?)',
    [
      dto.endereco.rua, 
      dto.endereco.numero, 
      dto.endereco.complemento, 
      dto.endereco.bairro, 
      dto.endereco.cidade, 
      dto.endereco.estado
    ]
  );

  int clienteId = await _db.rawInsert(
    'INSERT INTO cliente (nome, cpf, cep, telefone, endereco_id) VALUES (?,?,?,?,?)',
    [
      dto.nome, 
      dto.cpf, 
      dto.cep, 
      dto.telefone, 
      enderecoId 
    ]
  );

  dto.id = clienteId;
  
  return dto;
}
}