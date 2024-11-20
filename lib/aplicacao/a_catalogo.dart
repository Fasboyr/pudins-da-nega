import 'package:pudins_da_nega/banco/sqlite/dao/dao_catalogo.dart';
import 'package:pudins_da_nega/dominio/catalogo/catalogo.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_catalogo.dart';

class ACatalogo {
  late Catalogo catalogo;
  late IDAOCatalogo dao;

  ACatalogo() {
    dao = DAOCatalogo();
    catalogo = Catalogo(dao: dao);
  }

  Future<DTOCatalogo> salvar(DTOCatalogo dto) async {
    print("eNTOU NO SALVAR DO APLICAÇÃO");
    return await catalogo.salvar(dto);
  }

  Future<DTOCatalogo> alterar(DTOCatalogo dto) async {
    print('Entrou no alterar da aplicação do catalogo');
    return await catalogo.alterar(dto);
  }

  Future<bool> excluir(dynamic id) async {
    await catalogo.alterar(id);
    return true;
  }

  Future<List<DTOCatalogo>> consultar() async {
    print('A função consultar() de ACatalogo foi acessada.');
    return await catalogo.consultar();
  }
}
