import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/encomenda/encomenda.dart';

class DTOCarrinho {
  late dynamic id;
  late List<Encomenda> encomenda;
  late String formaEntrega;
  late String formaPagamento;
  late Endereco endereco;

  DTOCarrinho(
      {this.id,
      required this.encomenda,
      required this.formaEntrega,
      required this.formaPagamento,
      required this.endereco});
}
