import 'package:flutter/material.dart';
import 'package:pudins_da_nega/banco/sqlite/dao/dao_catalogo.dart';
import 'package:pudins_da_nega/dominio/catalogo/catalogo.dart';
import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_catalogo.dart';

class CatalogoFormBack {
  late DTOCatalogo catalogo;
  late Catalogo catalogoService;
  late IDAOCatalogo _dao;

  late bool _nomeIsValid;
  late bool _urlAvatarIsValid;
  late bool _descricaoIsValid;
  late bool _quantidadeIsValid;
  late bool _tamanhosIsValid;
  late bool _ingredientesIsValid;
  late bool _statusIsValid;

  bool get isValid =>
      _nomeIsValid &&
      _urlAvatarIsValid &&
      _quantidadeIsValid &&
      _tamanhosIsValid &&
      _ingredientesIsValid &&
      _statusIsValid;

  CatalogoFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    catalogo = (parameter == null)
        ? DTOCatalogo(
            nome: '',
            urlAvatar: '',
            descricao: '',
            quantidade: 0,
            tamanhos: [],
            ingredientes: [])
        : parameter as DTOCatalogo;

    _dao = DAOCatalogo();
    catalogoService = Catalogo(dao: _dao);
  }

  save() async {
    await catalogoService.salvar(catalogo);
  }

  String? validateName(String? nome) {
    try {
      catalogoService.nome = nome; // Usa o setter para validar o nome
      _nomeIsValid = true;
      print('Nome ta valido ${_nomeIsValid}');
      return null;
    } catch (e) {
      _nomeIsValid = false;
      return e.toString(); // Retorna a exceção como mensagem de erro
    }
  }

  String? validateDescricao(String? descricao) {
    try {
      catalogoService.descricao = descricao; // Usa o setter para validar o nome
      _descricaoIsValid = true;
      print('descricao ta valido ${_descricaoIsValid}');
      return null;
    } catch (e) {
      _descricaoIsValid = false;
      return e.toString(); // Retorna a exceção como mensagem de erro
    }
  }

  String? validateQuantidade(String? quantidadeStr) {
    try {
      int quantidade = int.parse(quantidadeStr!);
      catalogoService.quantidade = quantidade;
      _quantidadeIsValid = true;
      print('quantidade ta valido ${_quantidadeIsValid}');
      return null;
    } catch (e) {
      _quantidadeIsValid = false;
      return e.toString();
    }
  }

  String? validateUrlAvatar(String? urlAvatar) {
    try {
      catalogoService.urlAvatar =
          urlAvatar; // Usa o setter para validar a URL do avatar
      _urlAvatarIsValid = true;
      print('avatar ta valido ${_urlAvatarIsValid}');
      return null;
    } catch (e) {
      _urlAvatarIsValid = false;
      return e.toString();
    }
  }

  String? validateTamanhos(List<Tamanho> tamanhos) {
    try {
      catalogoService.tamanhos = tamanhos; // Validação ocorre no setter
      _tamanhosIsValid = true;
    } catch (e) {
      _tamanhosIsValid = false;
      return e.toString();
    }
  }

  String? validateIngredientes(List<Ingrediente> ingredientes) {
    try {
      catalogoService.ingredientes = ingredientes; // Validação ocorre no setter
      _ingredientesIsValid = true;
    } catch (e) {
      _ingredientesIsValid = false;
      return e.toString();
    }
  }

  String? validateStatus(String? status) {
    try {
      catalogoService.status = status; // Usa o setter para validar o status
      _statusIsValid = true;
      print('status ta valido ${_statusIsValid}');
      return null;
    } catch (e) {
      _statusIsValid = false;
      return e.toString();
    }
  }
}
