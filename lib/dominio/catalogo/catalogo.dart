import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_catalogo.dart';

class Catalogo {
  dynamic _id;
  String? _nome;
  String? _urlAvatar;
  String? _descricao;
  int? _quantidade;
  List<Tamanho>? _tamanhos;
  List<Ingrediente>? _ingredientes;
  String _status = 'A';
  late IDAOCatalogo dao;

  Catalogo({required this.dao});

  validar({required DTOCatalogo dto}) {
    id = dto.id;
    nome = dto.nome;
    urlAvatar = dto.urlAvatar;
    descricao = dto.descricao;
    quantidade = dto.quantidade;
    tamanhos = dto.tamanhos
        .map((t) => Tamanho(tamanho: t.tamanho, peso: t.peso, preco: t.preco))
        .toList();
    ingredientes = dto.ingredientes
        .map((i) => Ingrediente(
            ingrediente: i.ingrediente, causaAlergia: i.causaAlergia))
        .toList();
    status = dto.status;
  }

  String? get nome => _nome;
  String? get urlAvatar => _urlAvatar;
  String? get descricao => _descricao;
  int? get quantidade => _quantidade;
  List<Tamanho>? get tamanhos => _tamanhos;
  List<Ingrediente>? get ingredientes => _ingredientes;
  String get status => _status;

  set id(dynamic id) {
    if (id == null) throw Exception('ID não pode ser nulo.');
    if (id is int && id < 0) throw Exception('ID não pode ser negativo.');
    _id = id;
  }

  set nome(String? nome) {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var min = 3;
    var max = 150;

    if (nome == null) {
      throw Exception('Nome não pode ser nulo.');
    } else if (nome.isEmpty) {
      throw Exception('O nome é obrigatório');
    } else if (!formato.hasMatch(nome)) {
      throw Exception(
          'O nome deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (nome.length < min) {
      throw Exception('O nome deve possuir pelo menos $min caracteres');
    } else if (nome.length > max) {
      throw Exception('O nome deve possuir no maximo $max caracteres');
    }
    _nome = nome;
  }

  set urlAvatar(String? urlAvatar) {
    if (urlAvatar == null || urlAvatar.isEmpty) {
      throw Exception('A URL do avatar não pode ser vazia.');
    }
    _urlAvatar = urlAvatar;
  }

  set descricao(String? descricao) {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var min = 10;
    var max = 150;

    if (descricao == null) {
      throw Exception('A descricao não pode ser nula.');
    } else if (descricao.isEmpty) {
      throw Exception('A descricao é obrigatória');
    } else if (!formato.hasMatch(descricao)) {
      throw Exception(
          'A descricao deve ter apenas caracteres alfabéticos, acentuações e espaços');
    } else if (descricao.length < min) {
      throw Exception('A descricao deve possuir pelo menos $min caracteres');
    } else if (descricao.length > max) {
      throw Exception('A descricao deve possuir no maximo $max caracteres');
    }
    _descricao = descricao;
  }

  set quantidade(int? quantidade) {
    if (quantidade == null) throw Exception('A quantidade não pode ser nula.');
    if (quantidade < 0) throw Exception('A quantidade não pode ser negativa.');
    _quantidade = quantidade;
  }

  set tamanhos(List<Tamanho>? tamanhos) {
    if (tamanhos == null || tamanhos.isEmpty) {
      throw Exception('Pelo menos um tamanho deve ser informado.');
    }

    for (var tamanho in tamanhos) {
      // Garantir que tamanho.tamanho e tamanho.preco são não-nulos antes de acessar.
      if (tamanho.tamanho == null || tamanho.tamanho!.isEmpty) {
        throw Exception('Tamanho inválido ou preço não pode ser zero.');
      }

      if (tamanho.preco == null || tamanho.preco! <= 0) {
        throw Exception('Preço não pode ser zero ou negativo.');
      }
    }

    _tamanhos = tamanhos;
  }

  set ingredientes(List<Ingrediente>? ingredientes) {
    // Verifica se a lista é nula ou vazia.
    if (ingredientes == null || ingredientes.isEmpty) {
      throw Exception('Pelo menos um ingrediente deve ser informado.');
    }

    for (var ingrediente in ingredientes) {
      // Garantir que `ingrediente.ingrediente` não é nulo antes de verificar.
      if (ingrediente.ingrediente == null || ingrediente.ingrediente!.isEmpty) {
        throw Exception('Ingrediente inválido.');
      }

       if (ingrediente.causaAlergia == null || ingrediente.causaAlergia!.isEmpty) {
        throw Exception('Campo de alergia nulo ou vazio.');
      }
    }

    _ingredientes = ingredientes;
  }

  set status(String? status) {
    if (status == null) throw Exception('Status não pode ser nulo.');
    if (status != 'A' && status != 'I') {
      throw Exception('Status deve ser "A" (ativo) ou "I" (inativo).');
    }
    _status = status;
  }

  // Operações no DAO
  Future<DTOCatalogo> salvar(DTOCatalogo dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DTOCatalogo> alterar(DTOCatalogo dto) async {
    print('Entrou no alterar do dominio');
    validar(dto: dto);
    return await dao.alterar(dto);
  }

  Future<bool> excluir(dynamic id) async {
    this.id = id;
    await dao.alterarStatus(_id);
    return true;
  }

  Future<List<DTOCatalogo>> consultar() async {
    return await dao.consultar();
  }
}
