import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/dto/dto_carrinho.dart';
import 'package:pudins_da_nega/dominio/encomenda/encomenda.dart';
import 'package:pudins_da_nega/dominio/interface/dao_carrinho.dart';

class Carrinho {
  late dynamic id;
  late List<Encomenda> encomenda;
  late String formaEntrega;
  late String formaPagamento;
  late Endereco endereco;
  late IDAOCarrinho dao;
  late DTOCarrinho dto;

  Carrinho({required this.dao, required this.dto}) {
    id = dto.id;
    encomenda = dto.encomenda;
    formaEntrega = dto.formaEntrega;
    formaPagamento = dto.formaPagamento;
    endereco = dto.endereco;

    Endereco(
        rua: endereco.rua,
        numero: endereco.numero,
        complemento: endereco.complemento,
        bairro: endereco.bairro,
        cidade: endereco.cidade,
        estado: endereco.estado);

    verificarEncomenda();
    ehEntregaValida();
  }

  verificarEncomenda() {
    for (var i = 0; i < encomenda.length; i++) {
      Encomenda(
          tamanho: encomenda[i].tamanho,
          quantidade: encomenda[i].quantidade,
          produto: encomenda[i].produto);
    }
  }

  ehEntregaValida() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (formaEntrega.isEmpty) {
      throw Exception('O preenchimento de uma forma de entrega é obrigatório');
    } else if (!formato.hasMatch(formaEntrega)) {
      throw Exception(
          'A forma de entrega deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (formaEntrega != 'Entrega em Domicílio' ||
        formaEntrega != 'Retirada no Local') {
      throw Exception(
          'As únicas formas de entrega são "Entrega em Domicílio" ou  "Retirada no Local"');
    }
  }

  ehPagamentoValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (formaPagamento.isEmpty) {
      throw Exception(
          'O preenchimento de uma forma de pagamento é obrigatório');
    } else if (!formato.hasMatch(formaPagamento)) {
      throw Exception(
          'A forma de pagamento deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (formaPagamento != 'Débito' ||
        formaPagamento != 'Crédito' ||
        formaPagamento != 'Pix' ||
        formaPagamento != 'Cédulas') {
      throw Exception(
          'A forma de pagamento deve ser entre: "Débito", "Crédito", "Pix" ou em "Cédulas"');
    }
  }
}
