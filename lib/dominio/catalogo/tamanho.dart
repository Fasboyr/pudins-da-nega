class Tamanho {
  late String? tamanho;
  late double? peso;
  late double? preco;

  Tamanho({required this.tamanho, required this.peso, required this.preco}) {
    ehTamanhoValido();
    ehPesoValido();
    ehPrecoValido();
  }

  ehTamanhoValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (tamanho!.isEmpty || tamanho == null) {
      throw Exception('O tamanho é obrigatório');
    } else if (!formato.hasMatch(tamanho!)) {
      throw Exception(
          'O tamanho deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehPesoValido() {
    if(peso == null){
      throw Exception('O preço não pode ser vazio');
    }
    else if (peso! <= 0) {
      throw Exception('O preço do produto deve ser maior que 0');
    }
  }

  ehPrecoValido() {
    if(preco == null){
      throw Exception('O preço não pode ser vazio');
    }
    else if (preco! <= 0) {
      throw Exception('O preço do produto deve ser maior que 0');
    }
  }
}
