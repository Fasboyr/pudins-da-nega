import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';

abstract class IDAOCliente {
  Future<DTOCliente> salvar(DTOCliente dto);
  Future<DTOCliente> alterarStatus(DTOCliente dto);
}
