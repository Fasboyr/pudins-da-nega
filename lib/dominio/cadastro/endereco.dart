class Endereco {
  late dynamic? id;
  late String? rua;
  late int? numero;
  late String? complemento;
  late String? bairro;
  late String? cidade;
  late String? estado;

  Endereco({
    this.id,
    required this.rua,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
  }) {
    enderecoValidacao();
  }

  @override
  String toString() {
    return 'Endereco{id: $id, rua: $rua, numero: $numero, complemento: $complemento, bairro: $bairro, cidade: $cidade, estado: $estado}';
  }

  enderecoValidacao() {
    ehRuaValido();
    ehNumeroValido();
    ehBairroValido();
    ehComplementoValido();
    ehCidadeValido();
    ehEstadoValido();
  }

  ehRuaValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (rua == null) {
      throw Exception('A rua é obrigatória');
    } else if (!formato.hasMatch(rua!)) {
      throw Exception(
          'A rua deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehNumeroValido() {
    if (numero == null) {
      throw Exception('O numero não pode ser vazio');
    } else if (numero! < 0) {
      throw Exception('O numero do endereço não pode ser negativo');
    }
  }

  ehComplementoValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (complemento == null) {
      throw Exception('O complemento é obrigatória');
    } else if (!formato.hasMatch(complemento!)) {
      throw Exception(
          'O complemento deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehBairroValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (bairro == null) {
      throw Exception('O bairro é obrigatório');
    } else if (!formato.hasMatch(bairro!)) {
      throw Exception(
          'O bairro deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehCidadeValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (cidade == null || cidade!.isEmpty) {
      throw Exception('A cidade é obrigatória');
    } else if (!formato.hasMatch(cidade!)) {
      throw Exception(
          'A cidade deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }

  ehEstadoValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (estado == null) {
      throw Exception('A sigla do estado é obrigatório');
    } else if (!formato.hasMatch(estado!)) {
      throw Exception(
          'A sigla do estado deve ter apenas caracteres alfabéticos');
    } else if (estado!.length > 2 || estado!.length < 2) {
      throw Exception('O estado deve possuir apenas 2 letras');
    }
  }
}
