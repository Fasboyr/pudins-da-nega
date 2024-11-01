class Tamanho {
  late String? tamanho;
  late double? preco;
  late double? peso;

  Tamanho({required this.tamanho, required this.preco, required this.peso});
  
  tamanhoValidacao(){
    ehTamanhoValido();
    ehPrecoValido();
    ehPesoValido();
  }
  ehTamanhoValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (tamanho == null) {
      throw Exception('O tamanho não pode ser nulo');
    } else if (tamanho!.isEmpty) {
      throw Exception('O tamanho é obrigatório');
    } else if (!formato.hasMatch(tamanho!)) {
      throw Exception(
          'O tamanho deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehPrecoValido() {
    if (preco == null) {
      throw Exception('O preço não pode ser nulo');
    } else if (preco! <= 0) {
      throw Exception('O preço do produto deve ser maior que 0');
    }
  }

  ehPesoValido() {
    if (peso == null) {
      throw Exception('O peso não pode ser nulo');
    } else if (peso! <= 0) {
      throw Exception('O peso do produto deve ser maior que 0');
    }
  }
}
