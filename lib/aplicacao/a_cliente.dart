import 'package:pudins_da_nega/dominio/cadastro/cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class ACliente{
  Cliente cliente;
  IDAOCliente dao;

  ACliente({required this.cliente, required this.dao});


  salvar(){
    cliente.incluir();
  }
}