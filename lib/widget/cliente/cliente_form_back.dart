import 'package:flutter/material.dart';
import 'package:pudins_da_nega/banco/sqlite/dao/dao_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class ClienteFormBack {
  late DTOCliente cliente;
  late Cliente clienteService;
  late IDAOCliente _dao;

  late bool _nomeIsValid;
  late bool _cpfIsValid;
  late bool _cepIsValid;
  late bool _telefoneIsValid;
  late bool _statusIsValid;
  late bool _enderecoIsValid;
  late bool _urlAvatarIsValid;

  bool get isValid =>
      _nomeIsValid &&
      _cpfIsValid &&
      _cepIsValid &&
      _telefoneIsValid &&
      _statusIsValid &&
      _enderecoIsValid &&
      _urlAvatarIsValid;

  // Construtor para inicializar a entidade DTOCliente
  ClienteFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    cliente = (parameter == null)
        ? DTOCliente(
            nome: '',
            cpf: '',
            cep: '',
            endereco: Endereco(
                rua: '',
                numero: 0,
                bairro: '',
                cidade: '',
                estado: '',
                complemento: ''),
            telefone: '',
            status: 'A', // Inicialização padrão
            urlAvatar: '',
          )
        : parameter as DTOCliente;

    _dao = DAOCliente();
    clienteService = Cliente(dao: _dao); // Inicializando o serviço de Cliente
  }

  // Função para salvar o cliente
  save() async {
    print("Entrou no save do back");
    await clienteService.salvar(cliente); // Salvando cliente no DAO
  }

  // Validação de nome
  String? validateName(String? nome) {
    try {
      clienteService.nome = nome; // Usa o setter para validar o nome
      _nomeIsValid = true;
      print('Nome ta valido ${_nomeIsValid}');
      return null;
    } catch (e) {
      _nomeIsValid = false;
      return e.toString(); // Retorna a exceção como mensagem de erro
    }
  }

  // Validação de CPF
  String? validateCPF(String? cpf) {
    try {
      clienteService.cpf = cpf; // Usa o setter para validar o CPF
      _cpfIsValid = true;
      print('cpf ta valido ${_cpfIsValid}');
      return null;
    } catch (e) {
      _cpfIsValid = false;
      return e.toString();
    }
  }

  // Validação de CEP
  String? validateCEP(String? cep) {
    try {
      clienteService.cep = cep; // Usa o setter para validar o CEP
      _cepIsValid = true;
      print('cep ta valido ${_cepIsValid}');
      return null;
    } catch (e) {
      _cepIsValid = false;
      return e.toString();
    }
  }

  // Validação de Telefone
  String? validatePhone(String? telefone) {
    try {
      clienteService.telefone =
          telefone; // Usa o setter para validar o telefone
      _telefoneIsValid = true;
      print('telefone ta valido ${_telefoneIsValid}');
      return null;
    } catch (e) {
      _telefoneIsValid = false;
      return e.toString();
    }
  }

  String? validateStatus(String? status) {
    try {
      clienteService.status = status; // Usa o setter para validar o status
      _statusIsValid = true;
      print('status ta valido ${_statusIsValid}');
      return null;
    } catch (e) {
      _statusIsValid = false;
      return e.toString();
    }
  }

  String? validateEndereco(Endereco? endereco) {
    print('Endereço: ${endereco}');
    try {
      clienteService.endereco = Endereco(
        rua:
            endereco?.rua ?? '',
        numero: endereco?.numero ?? 0, 
        complemento: endereco?.complemento ?? '',
        bairro: endereco?.bairro ?? '',
        cidade: endereco?.cidade ?? '',
        estado: endereco?.estado ?? '',
      );
      print('Endereço no clienteService: ${clienteService.endereco}');
      _enderecoIsValid = true;
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

  // Validação de Endereço
  // Validação para Rua
  String? validateRua(String? rua) {
    print('Entrou no validateRua');
    print('>>>> Valor da rua: $rua');

    try {
      print(
          '>>>> Valor da rua antes da atribuição: ${clienteService.endereco!.rua}');

      clienteService.endereco!.rua =
          rua; // Agora, temos a garantia de que endereco não é null
      _enderecoIsValid = true;
      print('Rua válida: $_enderecoIsValid');

      return null; // Se tudo ocorreu bem, retorna null indicando que a validação passou
    } catch (e) {
      _enderecoIsValid = false;
      print('Erro: $e');
      return e
          .toString(); // Retorna a mensagem de erro caso haja algum problema
    }
  }

// Validação para Número
  String? validateNumero(String? numeroStr) {
    print('entrou no validateNumero');
    print('>>>> Valor da ${numeroStr}');
    try {
      int numero = int.parse(numeroStr!);
      clienteService.endereco!.numero = numero;
      _enderecoIsValid = true;
      print('numero ta valido ${_enderecoIsValid}');
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

// Validação para Bairro
  String? validateBairro(String? bairro) {
    try {
      clienteService.endereco!.bairro = bairro;
      _enderecoIsValid = true;
      print(' bairro ta valido ${_enderecoIsValid}');
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

// Validação para Cidade
  String? validateCidade(String? cidade) {
    try {
      clienteService.endereco!.cidade = cidade;
      _enderecoIsValid = true;
      print('cidade ta valido ${_enderecoIsValid}');
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

// Validação para Estado
  String? validateEstado(String? estado) {
    try {
      clienteService.endereco!.estado = estado;
      _enderecoIsValid = true;
      print(' estado ta valido ${_enderecoIsValid}');
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

// Validação para Complemento
  String? validateComplemento(String? complemento) {
    try {
      clienteService.endereco!.complemento = complemento;
      _enderecoIsValid = true;
      print('complemento ta valido $_enderecoIsValid}');
      return null;
    } catch (e) {
      _enderecoIsValid = false;
      return e.toString();
    }
  }

  // Validação de URL do Avatar
  String? validateUrlAvatar(String? urlAvatar) {
    try {
      clienteService.urlAvatar =
          urlAvatar; // Usa o setter para validar a URL do avatar
      _urlAvatarIsValid = true;
      print('avatar ta valido ${_urlAvatarIsValid}');
      return null;
    } catch (e) {
      _urlAvatarIsValid = false;
      return e.toString();
    }
  }
}
