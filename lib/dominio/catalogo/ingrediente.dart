class Ingrediente {
  late String? ingrediente;
  late String? causaAlergia;

  Ingrediente({required this.ingrediente, required this.causaAlergia}) {
    ehAlergiaValido();
    ehIngredienteValido();
  }

  ehAlergiaValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var min = 3;
    var max = 150;

    if (causaAlergia == null) {
      throw Exception('O campo de alergia não pode ser nulo.');
    } else if (causaAlergia!.isEmpty) {
      throw Exception('O campo de alergia é obrigatório');
    } else if (!formato.hasMatch(causaAlergia!)) {
      throw Exception(
          'O campo de alergia deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (causaAlergia!.length < min) {
      throw Exception('O campo de alergia deve possuir pelo menos $min caracteres');
    } else if (causaAlergia!.length > max) {
      throw Exception('O campo de alergia deve possuir no maximo $max caracteres');
    }
  }

  ehIngredienteValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (ingrediente!.isEmpty || ingrediente == null) {
      throw Exception('O Ingrediente é obrigatório');
    } else if (!formato.hasMatch(ingrediente!)) {
      throw Exception(
          'O Ingrediente deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }
}
