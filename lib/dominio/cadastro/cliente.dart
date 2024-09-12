import 'package:pudins_da_nega/dominio/cadastro/cpf.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class Cliente {
  late dynamic id;
  late String nome;
  late String cpf;
  late String cep;
  late Endereco endereco;
  late String telefone;
  late IDAOCliente dao;
  late DTOCliente dto;

  Cliente({required this.dao, required this.dto}) {
    id = dto.id;
    nome = dto.nome;
    cpf = dto.cpf;
    cep = dto.cep;
    endereco = dto.endereco;
    telefone = dto.telefone;
    ehNomeValido();
    Endereco( rua: endereco.rua, numero: endereco.numero, complemento: endereco.complemento,
       bairro: endereco.bairro, cidade: endereco.cidade, estado: endereco.estado);
    CPF(cpf);
    ehCEPValido();
    ehTelefoneValido();
  }

  ehNomeValido() {
    var formato = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    var min = 3;
    var max = 150;

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

  ehCEPValido() {
    var formato = RegExp(r'^[0-9]{5}\-[0-9]{3}$');


    if (cep.isEmpty) {
      throw Exception('CEP não pode ser vazio');
    } else if (!formato.hasMatch(cep)) {
      throw Exception(
          'Formato de CEP Inválido. O CEP deve ser no formato 01234-567');
    }
  }

  ehTelefoneValido() {
    var format = RegExp(r'^\([1-9]{2}\) [9] [6-9]{1}[0-9]{3}\-[0-9]{4}$');
    if (telefone.isEmpty) {
      throw Exception('O telefone é obrigatório');
    } else if (!format.hasMatch(telefone)) {
      throw Exception(
          'Formato de número inválido. O formato deve ser (99) 9 9999-9999.');
    }
  }

  Future<DTOCliente> incluir() async {
    return await dao.salvar(dto);
  }

  bool excluir(DTOCliente dto){
    dao.alterarStatus(dto);
    return true;
  }
}
