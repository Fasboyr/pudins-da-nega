import 'package:pudins_da_nega/banco/sqlite/dao/dao_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/cliente.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class ACliente {
  late Cliente cliente;
  late IDAOCliente dao;

  ACliente() {
    dao = DAOCliente();
    cliente = Cliente(dao: dao);
  }

  Future<DTOCliente> salvar(DTOCliente dto) async {
    print("eNTOU NO SALVAR DO APLICAÇÃO");
    return await cliente.salvar(dto);
  }

  Future<DTOCliente> alterar(dynamic id) async {
    return await cliente.alterar(id);
  }

  Future<bool> excluir(dynamic id) async {
    await cliente.excluir(id);
    return true;
  }

  Future<List<DTOCliente>> consultar() async {
    print('A função consultar() de ACliente foi acessada.');
    return await cliente.consultar();
  }
}
