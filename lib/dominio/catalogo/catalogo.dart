import 'dart:ffi';

import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/dao_catalogo.dart';

class Catalogo {
  late dynamic id;
  late String nome;
  late String urlAvatar;
  late String descricao;
  late int quantidade;
  late List<Tamanho> tamanhos;
  late List<Ingrediente> ingredientes;
  late IDAOCatalogo dao;
  late DTOCatalogo dto;

  Catalogo({required this.dao, required this.dto}) {
    id = dto.id;
    nome = dto.nome;
    urlAvatar = dto.urlAvatar;
    descricao = dto.descricao;
    tamanhos = dto.tamanho;
    ingredientes = dto.ingredientes;
    verificarTamanho(tamanhos);
    verificarIngrediente(ingredientes);
    ehNomeValido();
    ehDescricaoValido();
    ehQuantidadeValido();
  }

  verificarTamanho(List<Tamanho> tamanhos) {
    for (var i = 0; i < tamanhos.length; i++) {
      Tamanho(tamanho: tamanhos[i].tamanho, preco: tamanhos[i].preco);
    }
  }

  verificarIngrediente(List<Ingrediente> ingredientes) {
    for (var i = 0; i < ingredientes.length; i++) {
      Ingrediente(ingrediente: ingredientes[i].ingrediente, causaAlergia: ingredientes[i].causaAlergia);
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

  ehQuantidadeValido() {
    if (quantidade < 0) {
      throw Exception('A quantidade do produto não pode ser negativa');
    }
  }

  DTOCatalogo salvar(DTOCatalogo dto) {
    return dao.salvar(dto);
  }
}
