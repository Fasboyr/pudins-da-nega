class Ingrediente {
  late String ingrediente;
  late String causaAlergia;

  Ingrediente({required this.ingrediente, required this.causaAlergia}) {
    ehAlergiaValido();
    ehIngredienteValido();
  }


  ehAlergiaValido() {
    if (causaAlergia != 'S' || causaAlergia != 'N') {
      throw Exception('Alergia deve ser preenchido apenas com S ou com N ');
    }
  }

  ehIngredienteValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (ingrediente.isEmpty) {
      throw Exception('O Ingrediente é obrigatório');
    } else if (!formato.hasMatch(ingrediente)) {
      throw Exception(
          'O Ingrediente deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }
}
