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
  Future<DTOCliente> alterarStatus(DTOCliente dto) async {
    return dto;
  }
}

void main() {
  group('Entidade Cliente', () {
    group('Teste de Nome', () {
      test('Nome válido', () {
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
          ).ehNomeValido(),
          returnsNormally,
        );
      });

      test('Nome vazio', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: '',
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
          ).ehNomeValido(),
          throwsException,
        );
      });

      test('Nome com caracteres inválidos', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'João123',
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
          ).ehNomeValido(),
          throwsException,
        );
      });

      test('Nome muito curto', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'Jo',
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
          ).ehNomeValido(),
          throwsException,
        );
      });

      test('Nome muito longo', () {
        expect(
          () => Cliente(
            dao: MockDAOCliente(),
            dto: DTOCliente(
              id: 1,
              nome: 'A' * 151, 
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
          ).ehNomeValido(),
          throwsException,
        );
      });
    });

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
    });
  });
}
