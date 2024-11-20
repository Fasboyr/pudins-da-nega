import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';

abstract class IDAOCatalogo {
  Future<DTOCatalogo> salvar(DTOCatalogo dto);
  Future<DTOCatalogo> alterar(DTOCatalogo dto);
  Future<bool> alterarStatus(int id);
  Future<DTOCatalogo> consultarPorId(int id);
  Future<List<DTOCatalogo>> consultar();
}


