import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/dominio/cadastro/cpf.dart';

void main() {
  group('Entidade CPF', () {
    group('Teste de CPF vazio', () {
      test('CPF correto', () {
        expect(() => CPF('070.304.390-07'), returnsNormally);
      });

      test('CPF vazio', () {
        expect(() => CPF(''), throwsException);
      });
    });

    group('[e04] CPF - deve possuir 11 números', () {
      test('teste cpf com 11 números', () {
        expect(() => CPF('070.304.390-07').ehOnzeNumeros(), returnsNormally);
      });

      test('teste cpf com 10 números', () {
        expect(() => CPF('070.304.390-0').ehOnzeNumeros(), throwsException);
      });

      test('teste cpf com 12 números', () {
        expect(() => CPF('070.304.390-071').ehOnzeNumeros(), throwsException);
      });
    });

    group('[e05] CPF - verificar se os números são diferentes', () {
      test('Teste cpf com numeros diferentes', () {
        expect(
            () => CPF('070.304.390-07').ehNumeroDiferente(), returnsNormally);
      });

      test('Teste cpf com numeros iguais', () {
        expect(
            () => CPF('000.000.000-00').ehNumeroDiferente(), throwsException);
      });

      test('Teste cpf com numeros iguais no começo', () {
        expect(
            () => CPF('111.304.390-07').ehNumeroDiferente(), returnsNormally);
      });
    });

    group('[e06] CPF – verificar os dígitos verificadores;', () {
      test('Teste com digitos validos', () {
        expect(
            () => CPF('070.304.390-07').ehNumeroDiferente(), returnsNormally);
      });
    });
  });
}