import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/dominio/cadastro/cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';

class MockDAOCliente implements IDAOCliente {
  @override
  Future<DTOCliente> salvar(DTOCliente dto) async {
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    return true;
  }

  @override
  Future<DTOCliente> alterar(DTOCliente dto) {
    // TODO: implement alterar
    throw UnimplementedError();
  }

  @override
  Future<List<DTOCliente>> consultar() {
    // TODO: implement consultar
    throw UnimplementedError();
  }

  @override
  Future<DTOCliente> consultarPorId(int id) {
    // TODO: implement consultarPorId
    throw UnimplementedError();
  }
}

void main() {
  var cliente = Cliente(dao: MockDAOCliente());
  group('Entidade Cliente', () {
    group('Teste de Nome', () {
      test('Nome válido', () {
        cliente.nome = 'João da Silva';
        expect(
          () => cliente.ehNomeValido(),
          returnsNormally,
        );
      });

      test('Nome vazio', () {
        cliente.nome = '';
        expect(() => cliente.ehNomeValido(), throwsException);
      });

      test('Nome com caracteres inválidos', () {
        cliente.nome = 'João123';
        expect(
          () => cliente.ehNomeValido(),
          throwsException,
        );
      });

      test('Nome muito curto', () {
        cliente.nome = 'Jo';
        expect(
          () => cliente.ehNomeValido(),
          throwsException,
        );
      });

      test('Nome muito longo', () {
        cliente.nome = 'A' * 151;
        expect(
          () => cliente.ehNomeValido(),
          throwsException,
        );
      });
    });
/*
    group('Teste de CEP', () {
      test('CEP válido', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '(41) 9 9876-5432',
              cep: '01234-567',
            ),
          ).ehCEPValido(),
          returnsNormally,
        );
      });

      test('CEP vazio', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '(41) 9 9876-5432',
              cep: '',
            ),
          ).ehCEPValido(),
          throwsException,
        );
      });

      test('CEP com formato inválido', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '(41) 9 9876-5432',
              cep: '01234567',
            ),
          ).ehCEPValido(),
          throwsException,
        );
      });
    });

    group('Teste de Telefone', () {
      test('Telefone válido', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '(41) 9 9876-5432',
              cep: '01234-567',
            ),
          ).ehTelefoneValido(),
          returnsNormally,
        );
      });

      test('Telefone vazio', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '',
              cep: '01234-567',
            ),
          ).ehTelefoneValido(),
          throwsException,
        );
      });

      test('Telefone com formato inválido', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João da Silva',
              cpf: '070.304.390-07',
              endereco: Endereco(
                rua: 'Rua das Flores',
                numero: 123,
                complemento: 'Apto',
                bairro: 'Centro',
                cidade: 'Curitiba',
                estado: 'PR',
              ),
              telefone: '41998765432', // Sem o formato adequado
              cep: '01234-567',
            ),
          ).ehTelefoneValido(),
          throwsException,
        );
      });
    });*/
  });
  
}
