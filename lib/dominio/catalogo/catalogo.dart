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
  late double preco;
  late List<Ingrediente> ingredientes;
  late IDAOCatalogo dao;
  late DTOCatalogo dto;

  Catalogo({required this.dao, required this.dto}) {
    id = dto.id;
    urlAvatar = dto.urlAvatar;
    descricao = dto.descricao;
    tamanhos = dto.tamanho;
    preco = dto.preco;
    ingredientes = dto.ingredientes;
    verificarTamanho(tamanhos);
    ehNomeValido();
    ehDescricaoValido();
  }

  verificarTamanho(List<Tamanho> tamanhos) {
    for(var i = 0; i < tamanhos.length; i++){
         ehTamanhoValido(tamanhos[i].tamanho);
    }
  }
  ehTamanhoValido(String tamanho) {
    if (tamanho != 'Pequeno' || tamanho != 'Médio' || tamanho != 'Grande'){
      throw Exception('Tamanho não pode ser diferente de Pequeno, Médio e Grande.');
    } else if( tamanho == 'Pequeno'){
      tamanho = 'Pequeno - 120 gm';
    } else if( tamanho == 'Médio'){
      tamanho = 'Médio - 500 gm';
    } else if( tamanho == 'Grande'){
      tamanho = 'Grande - 1kg e 100 gm';
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
}