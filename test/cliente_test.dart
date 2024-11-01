import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:pudins_da_nega/banco/sqlite/dao/dao_cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/cliente.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_cliente.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    db = await Conexao.abrir();
  });
  
  var dtoCliente = DTOCliente(
    id: 1,
    nome: 'João da Silva',
    cpf: '12345678909',
    cep: '12345-678',
    urlAvatar: 'aaaaaaaa',
    endereco: Endereco(
        rua: 'Rua A',
        numero: 123,
        cidade: 'Cidade X',
        estado: 'PR',
        complemento: 'Casa',
        bairro: 'Jardim Ipe',
        id: 1),
    telefone: '(41) 9 9999-9999',
    status: 'I',
  );
  var daoCliente = DAOCliente();
  var cliente = Cliente(dao: daoCliente);
  cliente.validar(dto: dtoCliente);

  group('Entidade Cliente', () {
    group('Teste de Nome', () {
      test('Nome válido', () {
        expect(
          () => cliente.nome = 'João da Silva',
          returnsNormally,
        );
      });

      test('Nome vazio', () {
        expect(() => cliente.nome = '', throwsException);
      });

      test('Nome com caracteres inválidos', () {
        expect(
          () => cliente.nome = 'João123',
          throwsException,
        );
      });

      test('Nome muito curto', () {
        expect(
          () => cliente.nome = 'Jo',
          throwsException,
        );
      });

      test('Nome muito longo', () {
        expect(
          () => cliente.nome = 'A' * 151,
          throwsException,
        );
      });
    });

    group('Teste de CPF', () {
      test('CPF válido', () {
        expect(
          () => cliente.cpf = '12345678909',
          returnsNormally,
        );
      });

      test('CPF nulo', () {
        expect(() => cliente.cpf = null, throwsException);
      });

      test('CPF vazio', () {
        expect(() => cliente.cpf = '', throwsException);
      });
    });

    group('Interação com Endereço', () {
      test('Endereço válido', () {
        // Instanciando um objeto de Endereco com dados válidos
        var endereco = Endereco(
          numero: 123,
          complemento: 'Apartamento',
          rua: 'Rua A',
          bairro: 'Centro',
          cidade: 'Cidade X',
          estado: 'PR',
        );
        // Definindo o endereço no cliente e validando
        expect(() => cliente.endereco = endereco, returnsNormally);
      });

      test('Endereço sem rua', () {
        var enderecoInvalido = Endereco(
            rua: null,
            numero: 123,
            complemento: 'Ap 12',
            bairro: 'Centro',
            cidade: 'Cidade X',
            estado: 'PR');
        expect(() => cliente.endereco = enderecoInvalido, throwsException);
      });
    });

    group('Funções CRUD', () {
      test('Salvar cliente', () async {
        var clienteSalvo = await cliente.salvar(dtoCliente);
        expect(clienteSalvo.nome, equals(dtoCliente.nome));
      });

      test('Alterar cliente', () async {
        DTOCliente clienteAlterado = await cliente.alterar(dtoCliente);
        expect(clienteAlterado.id, equals(dtoCliente.id));
      });


      test('Excluir cliente', () async {
        var excluido = await cliente.excluir(1);
        expect(excluido, isTrue);
      });
    });
  });

  group('Teste de Telefone', () {
    test('Telefone válido com DDD', () {
      expect(() => cliente.telefone = '(41) 9 9999-9999', returnsNormally);
    });
    test('Telefone sem DDD', () {
      expect(() => cliente.telefone = '9 9999-9999', throwsException);
    });
    test('Telefone inválido', () {
      expect(() => cliente.telefone = '99999', throwsException);
    });
  });

  group('Tabela de Decisão para CEP', () {
    test('CEP válido', () {
      expect(() => cliente.cep = '12345-678' , returnsNormally);
    });
    test('CEP com formatação incorreta', () {
      expect(() => cliente.cep = '1234-567', throwsException);
    });
    test('CEP vazio', () {
      expect(() => cliente.cep = '', throwsException);
    });
  });
}
