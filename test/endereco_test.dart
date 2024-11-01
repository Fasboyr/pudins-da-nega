import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';

void main() {
  group('Entidade Endereco', () {
    group('Teste de Rua', () {
      test('Rua válida', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehRuaValido(),
          returnsNormally,
        );
      });

      test('Rua vazia', () {
        expect(
          () => Endereco(
            rua: '',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehRuaValido(),
          throwsException,
        );
      });

      test('Rua com caracteres inválidos', () {
        expect(
          () => Endereco(
            rua: 'Rua 123',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehRuaValido(),
          throwsException,
        );
      });
    });

    group('Teste de Número', () {
      test('Número válido', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehNumeroValido(),
          returnsNormally,
        );
      });

      test('Número negativo', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: -1,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehNumeroValido(),
          throwsException,
        );
      });
    });

    group('Teste de Complemento', () {
      test('Complemento válido', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Apto',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehComplementoValido(),
          returnsNormally,
        );
      });

      test('Complemento vazio', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: '',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehComplementoValido(),
          throwsException,
        );
      });
    });

    group('Teste de Bairro', () {
      test('Bairro válido', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehBairroValido(),
          returnsNormally,
        );
      });

      test('Bairro vazio', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: '',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehBairroValido(),
          throwsException,
        );
      });
    });

    group('Teste de Cidade', () {
      test('Cidade válida', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehCidadeValido(),
          returnsNormally,
        );
      });

      test('Cidade vazia', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: '',
            estado: 'PR'
          ).ehCidadeValido(),
          throwsException,
        );
      });
    });

    group('Teste de Estado', () {
      test('Estado válido', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'PR'
          ).ehEstadoValido(),
          returnsNormally,
        );
      });

      test('Estado com mais de 2 caracteres', () {
        expect(
          () => Endereco(
            rua: 'Rua das Flores',
            numero: 123,
            complemento: 'Casa',
            bairro: 'Centro',
            cidade: 'Curitiba',
            estado: 'Paraná'
          ).ehEstadoValido(),
          throwsException,
        );
      });
    });
  });
}
