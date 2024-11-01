class Ingrediente {
  late String? ingrediente;
  late String? causaAlergia;

  Ingrediente({required this.ingrediente, required this.causaAlergia});

  ingredienteValidacao() {
    ehAlergiaValido();
    ehIngredienteValido();
  }

  ehAlergiaValido() {
    if(causaAlergia == null){
      throw Exception('É necessário informar se o ingrediente comumente causa ou não alergia');
    }else if (causaAlergia != 'S' || causaAlergia != 'N') {
      throw Exception('Alergia deve ser preenchido apenas com S ou com N ');
    }
  }

  ehIngredienteValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    if(ingrediente == null){
      throw Exception('É necessário informar o nome do ingrediente');
    }
    if (ingrediente!.isEmpty) {
      throw Exception('O Ingrediente é obrigatório');
    } else if (!formato.hasMatch(ingrediente!)) {
      throw Exception(
          'O Ingrediente deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }
}
