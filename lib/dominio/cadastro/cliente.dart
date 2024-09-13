import 'package:pudins_da_nega/dominio/cadastro/cpf.dart' as cpfValidador;
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class Cliente {
  late dynamic _id;
  String? _nome;
  String? _cpf;
  String? _cep;
  Endereco? _endereco;
  String? _telefone;
  String _status = 'A';
  late IDAOCliente dao;

  Cliente({required this.dao}) {}

  validar({required DTOCliente dto}) {
    id = dto.id;
    nome = dto.nome;
    cpf = dto.cpf;
    cep = dto.cep;
    endereco = dto.endereco;
    telefone = dto.telefone;
    status = dto.status;
    endereco = Endereco(
            rua: endereco.rua,
            numero: endereco.numero,
            complemento: endereco.complemento,
            bairro: endereco.bairro,
            cidade: endereco.cidade,
            estado: endereco.estado)
        .enderecoValidacao();
    cpfValidador.CPF(cpf).validacao();
  }

  String? get nome => _nome;
  String? get cpf => _cpf;
  String? get cep => _cep;
  Endereco? get endereco => _endereco;
  String? get telefone => _telefone;
  String? get status => _status;

  set id(int? id) {
    if (id == null) throw Exception('ID não pode ser nulo');
    if (id < 0) throw Exception('ID não pode ser negativo');
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

  set cpf(String? cpf) {
    if (cpf == null) throw Exception('CPF não pode ser nulo.');
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio.');
    _cpf = cpf;
  }

  set status(String? status) {
    if (status == null) throw Exception('Status não pode ser nulo.');
    if (status != 'A' || status != 'I')
      throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }

  set cep(String? cep) {
    var formato = RegExp(r'^[0-9]{5}\-[0-9]{3}$');

    if (cep == null) {
      throw Exception('CEP não pode ser nulo.');
    } else if (cep.isEmpty) {
      throw Exception('CEP não pode ser vazio');
    } else if (!formato.hasMatch(cep)) {
      throw Exception(
          'Formato de CEP Inválido. O CEP deve ser no formato 01234-567');
    }
    _cep = cep;
  }

  set telefone(String? telefone) {
    var format = RegExp(r'^\([1-9]{2}\) [9] [6-9]{1}[0-9]{3}\-[0-9]{4}$');
    if (telefone == null) {
      throw Exception('Telefone não pode ser nulo');
    } else if (telefone.isEmpty) {
      throw Exception('O telefone é obrigatório');
    } else if (!format.hasMatch(telefone)) {
      throw Exception(
          'Formato de número inválido. O formato deve ser (99) 9 9999-9999.');
    }

    _telefone = telefone;
  }

  set endereco(Endereco? endereco) {
    if (endereco == null) throw Exception('Endereco não pode ser nulo!');
    if (endereco.rua == null) throw Expando();

    _endereco = endereco;
  }

  Future<DTOCliente> salvar(DTOCliente dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DTOCliente> alterar(dynamic id) async {
    this.id = id;
    return await dao.alterar(_id);
  }

  Future<bool> excluir(dynamic id) async {
    this.id = id;
    await dao.alterarStatus(_id);
    return true;
  }

  Future<List<DTOCliente>> consutlar() async {
    return await dao.consultar();
  }
}
