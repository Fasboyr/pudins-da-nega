import 'package:pudins_da_nega/dominio/catalogo/catalogo.dart';

class Encomenda {
  late int quantidade;
  late String tamanho;
  late Catalogo produto;

  Encomenda(
      {required this.quantidade,
      required this.tamanho,
      required this.produto}) {
    ehTamanhoValido();
    ehQuantidadeValido();
    ehProdutoValido();
  }

  ehTamanhoValido() {
    if (tamanho.isEmpty) {
      throw Exception('O tamanho é obrigatório');
    }
  }

  ehQuantidadeValido() {
    if (quantidade == '' || quantidade == null) {
      throw Exception('A quantidade não pode ser vazia');
    } else if (quantidade <= 0) {
      throw Exception('A quantidade encomendada deve ser maior que 0');
    }
  }

  ehProdutoValido() {
    if (produto == null) {
      throw Exception('Deve ser selecionado um produto');
    }
  }
}
