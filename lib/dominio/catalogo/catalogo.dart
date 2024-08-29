import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/dao_catalogo.dart';

class Catalogo{

  late dynamic id;
  late String nome;
  late String urlAvatar;
  late String descricao;
  late List<Tamanho> tamanhos;
  late List<Ingrediente> ingredientes;
  late IDAOCatalogo dao;
  late DTOCatalogo dto;

  Catalogo({required this.dao, required this.dto}) {
    id = dto.id;
    urlAvatar = dto.urlAvatar;
    descricao = dto.descricao;
    tamanhos = dto.tamanho;
    ingredientes = dto.ingredientes;
    verificarTamanho(tamanhos);
    verificarIngrediente(ingredientes);
    ehNomeValido();
    ehDescricaoValido();
  }

  verificarTamanho(List<Tamanho> tamanhos) {
    for(var i = 0; i < tamanhos.length; i++){
         tamanhos[i].tamanho = ehTamanhoValido(tamanhos[i].tamanho);
         ehPrecoValido(tamanhos[i].preco);
    }
  }
  
  verificarIngrediente(List<Ingrediente> ingredientes){
    for(var i = 0; i < ingredientes.length; i++){
         ehIngredienteValido(ingredientes[i].ingrediente);
         ehAlergiaValido(ingredientes[i].causaAlergia);
    }

  }


  ehNomeValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var min = 3;
    var max = 40;

    if (nome.isEmpty) {
      throw Exception('O nome é obrigatório');
    } else if (!formato.hasMatch(nome)) {
      throw Exception(
          'O nome deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (nome.length < min) {
      throw Exception('O nome deve possuir pelo menos $min caracteres');
    } else if (nome.length > max) {
      throw Exception('O nome deve possuir no maximo $max caracteres');
    }
  }

  ehDescricaoValido() {
    var min = 20;
    var max = 150;

    if (descricao.isEmpty) {
      throw Exception('A descrição é obrigatória');
    } else if (descricao.length < min) {
      throw Exception('O nome deve possuir pelo menos $min caracteres');
    } else if (descricao.length > max) {
      throw Exception('O nome deve possuir no maximo $max caracteres');
    }
  }


  ehTamanhoValido(String tamanho) {
    if (tamanho != 'Pequeno' || tamanho != 'Médio' || tamanho != 'Grande'){
      throw Exception('Tamanho não pode ser diferente de Pequeno, Médio e Grande.');
    } else if( tamanho == 'Pequeno'){
      return 'Pequeno - 120 gm';
    } else if( tamanho == 'Médio'){
      return 'Médio - 500 gm';
    } else if( tamanho == 'Grande'){
      return'Grande - 1kg e 100 gm';
    }
  }

  ehPrecoValido(double preco){
    if(preco <=0){
      throw Exception('O preço do produto deve ser maior que 0');
    }
  }

  ehAlergiaValido(String alergia){
    if(alergia != 'S' || alergia != 'N'){
      throw Exception('Alergia deve ser preenchido apenas com S ou com N ');
    }
  }

  ehIngredienteValido(String ingrediente) {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

    if (ingrediente.isEmpty) {
      throw Exception('O Ingrediente é obrigatório');
    } else if (!formato.hasMatch(ingrediente)) {
      throw Exception(
          'O Ingrediente deve ter apenas caracteres alfabéticos, acentuações e espaços');
    }
  }
}