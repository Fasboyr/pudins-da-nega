import 'package:flutter_test/flutter_test.dart';
import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:pudins_da_nega/banco/sqlite/dao/dao_catalogo.dart';
import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_catalogo.dart';
import 'package:pudins_da_nega/dominio/catalogo/catalogo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    db = (await Conexao.abrir())!;
  });

  var dtoCatalogo = DTOCatalogo(
    id: 1,
    nome: 'Pudim de Leite',
    urlAvatar: 'https://example.com/avatar.png',
    descricao: 'Um delicioso pudim feito com leite condensado',
    quantidade: 10,
    tamanhos: [
      Tamanho(tamanho: 'Pequeno', peso: 500, preco: 15.0),
      Tamanho(tamanho: 'Grande', peso: 1000, preco: 25.0),
    ],
    ingredientes: [
      Ingrediente(
          ingrediente: 'Leite condensado',
          causaAlergia: 'Intolerância a Lactose'),
      Ingrediente(ingrediente: 'Ovos', causaAlergia: 'Sim'),
    ],
    status: 'A',
  );
  var daoCatalogo = DAOCatalogo();
  var catalogo = Catalogo(dao: daoCatalogo);
  catalogo.validar(dto: dtoCatalogo);

  group('Entidade Catálogo', () {
    group('Teste de Nome', () {
      test('Nome válido', () {
        expect(() => catalogo.nome = 'Pudim de Leite', returnsNormally);
      });

      test('Nome vazio', () {
        expect(() => catalogo.nome = '', throwsException);
      });

      test('Nome com caracteres inválidos', () {
        expect(() => catalogo.nome = 'Pudim123', throwsException);
      });

      test('Nome muito curto', () {
        expect(() => catalogo.nome = 'Pu', throwsException);
      });

      test('Nome muito longo', () {
        expect(() => catalogo.nome = 'A' * 151, throwsException);
      });
    });

    group('Teste de URL Avatar', () {
      test('URL válida', () {
        expect(() => catalogo.urlAvatar = 'https://example.com/avatar.png',
            returnsNormally);
      });

      test('URL nula', () {
        expect(() => catalogo.urlAvatar = null, throwsException);
      });

      test('URL vazia', () {
        expect(() => catalogo.urlAvatar = '', throwsException);
      });
    });

    group('Teste de Descrição', () {
      test('Descrição válida', () {
        expect(
            () => catalogo.descricao = 'Um delicioso pudim', returnsNormally);
      });

      test('Descrição muito curta', () {
        expect(() => catalogo.descricao = 'Curta', throwsException);
      });

      test('Descrição muito longa', () {
        expect(() => catalogo.descricao = 'A' * 151, throwsException);
      });

      test('Descrição vazia', () {
        expect(() => catalogo.descricao = '', throwsException);
      });
    });

    group('Teste de Quantidade', () {
      test('Quantidade válida', () {
        expect(() => catalogo.quantidade = 10, returnsNormally);
      });

      test('Quantidade nula', () {
        expect(() => catalogo.quantidade = null, throwsException);
      });

      test('Quantidade negativa', () {
        expect(() => catalogo.quantidade = -1, throwsException);
      });
    });

    group('Teste de Tamanhos', () {
      test('Lista de tamanhos válida', () {
        expect(
          () => catalogo.tamanhos = [
            Tamanho(tamanho: 'Médio', peso: 750, preco: 20.0)
          ],
          returnsNormally,
        );
      });

      test('Lista de tamanhos vazia', () {
        expect(() => catalogo.tamanhos = [], throwsException);
      });

      test('Tamanho com preço zero ou negativo', () {
        expect(
          () => catalogo.tamanhos = [
            Tamanho(tamanho: 'Grande', peso: 1000, preco: 0)
          ],
          throwsException,
        );
      });
    });

    group('Teste de Ingredientes', () {
      test('Lista de ingredientes válida', () {
        expect(
          () => catalogo.ingredientes = [
            Ingrediente(ingrediente: 'Leite', causaAlergia: 'Não'),
          ],
          returnsNormally,
        );
      });

      test('Lista de ingredientes vazia', () {
        expect(() => catalogo.ingredientes = [], throwsException);
      });

      test('Ingrediente com nome inválido', () {
        expect(
          () => catalogo.ingredientes = [
            Ingrediente(ingrediente: '', causaAlergia: 'Sim')
          ],
          throwsException,
        );
      });
    });

    group('Teste de Status', () {
      test('Status válido (A)', () {
        expect(() => catalogo.status = 'A', returnsNormally);
      });

      test('Status inválido', () {
        expect(() => catalogo.status = 'X', throwsException);
      });

      test('Status nulo', () {
        expect(() => catalogo.status = null, throwsException);
      });
    });

    group('Funções CRUD', () {
      setUpAll;
      test('Salvar catálogo', () async {
        var catalogoSalvo = await catalogo.salvar(dtoCatalogo);
        expect(catalogoSalvo.nome, equals(dtoCatalogo.nome));
      });

      test('Alterar catálogo', () async {
        var catalogoAlterado = await catalogo.alterar(dtoCatalogo);
        expect(catalogoAlterado.nome, equals(dtoCatalogo.nome));
      });

      test('Excluir catálogo', () async {
        var excluido = await catalogo.excluir(1);
        expect(excluido, isTrue);
      });
    });
  });
}
