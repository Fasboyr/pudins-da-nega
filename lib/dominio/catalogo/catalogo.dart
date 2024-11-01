import 'dart:ffi';

import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/dao_catalogo.dart';

class Catalogo {
  dynamic _id;
  String? _nome;
  String? _urlAvatar;
  String? _descricao;
  int? _quantidade;
  List<Tamanho>? _tamanhos;
  List<Ingrediente>? _ingredientes;
  late IDAOCatalogo dao;

  Catalogo({required this.dao});

  validar({required DTOCatalogo dto}) {
    id = dto.id;
    nome = dto.nome;
    urlAvatar = dto.urlAvatar;
    descricao = dto.descricao;
    tamanhos = dto.tamanho;
    ingredientes = dto.ingredientes;
  }

  String? get nome => _nome;
  String? get urlAvatar => _urlAvatar;
  String? get descricao => _descricao;
  int? get quantidade => _quantidade;
  List<Tamanho>? get tamanhos => _tamanhos;
  List<Ingrediente>? get ingredientes => _ingredientes;

  set id(int? id) {
    if (id == null) throw Exception('ID não pode ser nulo');
    if (id < 0) throw Exception('ID não pode ser negativo');
    _id = id;
  }

  set nome(String? nome) {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var max = 150;

    if (nome == null) {
      throw Exception('Nome não pode ser nulo.');
    } else if (nome.isEmpty) {
      throw Exception('O nome do produto é obrigatório');
    } else if (!formato.hasMatch(nome)) {
      throw Exception(
          'O nome deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (nome.length > max) {
      throw Exception('O nome deve possuir no maximo $max caracteres');
    }
    _nome = nome;
  }

  set urlAvatar(String? urlAvatar) {
    if (urlAvatar == null) throw Exception('URL não pode ser nulo.');
    _urlAvatar = urlAvatar;
  }

  set descricao(String? descricao) {
    var max = 150;

    if (descricao == null) {
      throw Exception('Descrição não pode ser nula.');
    } else if (descricao.isEmpty) {
      throw Exception('A descrição é obrigatória');
    } else if (descricao.length > max) {
      throw Exception('A descrição deve possuir no maximo $max caracteres');
    }

    _descricao = descricao;
  }

  set quantidade(int? quantidade) {
    if (quantidade == null) {
      throw Exception('Quantidade não pode ser nula.');
    } else if (quantidade < 0) {
      throw Exception('A quantidade do produto não pode ser negativa');
    }

    _quantidade = quantidade;
  }

  set tamanhos(List<Tamanho>? tamanhos) {
    if (tamanhos == null) {
      throw Exception('Tamanho não pode ser nulo.');
    } else {
      for (var i = 0; i < tamanhos.length; i++) {
        tamanhos[i].tamanhoValidacao();
      }
    }
    _tamanhos = tamanhos;
  }

  set ingredientes(List<Ingrediente>? ingredientes) {
    if (ingredientes == null) {
      throw Exception('Ingredientes não pode ser nulo.');
    } else {
      for (var i = 0; i < ingredientes.length; i++) {
        ingredientes[i].ingredienteValidacao();
      }
    }

    _ingredientes = ingredientes;
  }

  DTOCatalogo salvar(DTOCatalogo dto) {
    return dao.salvar(dto);
  }
}
