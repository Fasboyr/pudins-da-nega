import 'package:pudins_da_nega/banco/sqlite/conexao.dart';
import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/dominio/interface/i_dao_catalogo.dart';
import 'package:sqflite/sqflite.dart';

class DAOCatalogo implements IDAOCatalogo {
  late Database _db;

  final sqlInserirCatalogo = '''
    INSERT INTO catalogo (nome, url_avatar, descricao, quantidade, status) VALUES (?,?,?,?,?)
  ''';

  final sqlInserirIngrediente = '''
    INSERT INTO ingrediente (catalogo_id, ingrediente, causa_alergia) VALUES (?,?,?)
  ''';

  final sqlInserirTamanho = '''
    INSERT INTO tamanho (catalogo_id, tamanho, peso, preco) VALUES (?,?,?,?)
  ''';

  final sqlAlterarCatalogo = '''
    UPDATE catalogo SET nome=?, url_avatar=?, descricao=?, quantidade=?, status=? WHERE id = ?
  ''';

  final sqlAlterarIngrediente = '''
  UPDATE ingrediente SET ingrediente = ?, causa_alergia = ? WHERE id = ?;
  ''';

  final sqlAlterarTamanho = '''
  UPDATE tamanho SET tamanho = ?,  peso = ?, preco = ? WHERE id = ?;
  ''';

  final sqlAlterarStatus = '''
    UPDATE catalogo SET status='I' WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT 
      c.id, c.nome, c.url_avatar, c.descricao, c.quantidade, c.status,
      i.ingrediente, i.causa_alergia,
      t.tamanho, t.peso, t.preco
    FROM 
      catalogo c
    LEFT JOIN 
      ingrediente i ON c.id = i.catalogo_id
    LEFT JOIN 
      tamanho t ON c.id = t.catalogo_id
    WHERE 
    c.id = ?;
    AND
    c.status = 'A';
  ''';

  final sqlConsultarIngredientes = '''
    SELECT * FROM ingrediente WHERE catalogo_id = ?;
  ''';

  final sqlConsultarTamanhos = '''
    SELECT * FROM tamanho WHERE catalogo_id = ?;
  ''';

  final sqlConsultar = '''
    SELECT 
      c.id, c.nome, c.url_avatar, c.descricao, c.quantidade, c.status,
      i.ingrediente, i.causa_alergia,
      t.tamanho, t.peso, t.preco
    FROM 
      catalogo c
    LEFT JOIN 
      ingrediente i ON c.id = i.catalogo_id
    LEFT JOIN 
      tamanho t ON c.id = t.catalogo_id
    WHERE 
    c.status = 'A';
  ''';

  @override
  Future<List<DTOCatalogo>> consultar() async {
    _db = await Conexao.abrir();

    // Consulta com join para trazer todos os dados necessários
    var resultados = await _db.rawQuery(sqlConsultar);

    if (resultados.isEmpty) {
      return [];
    }

    // Mapeia os catálogos únicos com seus ingredientes e tamanhos
    Map<int, DTOCatalogo> catalogosMap = {};

    for (var linha in resultados) {
      int catalogoId = linha['id'] as int;

      // Verifica se já existe o catálogo no mapa, se não, cria um novo
      if (!catalogosMap.containsKey(catalogoId)) {
        catalogosMap[catalogoId] = DTOCatalogo(
          id: catalogoId,
          nome: linha['nome'].toString(),
          urlAvatar: linha['url_avatar'].toString(),
          descricao: linha['descricao'].toString(),
          quantidade: int.parse(linha['quantidade'].toString()),
          status: linha['status'].toString(),
          ingredientes: [],
          tamanhos: [],
        );
      }

      // Adiciona ingredientes únicos ao catálogo
      if (linha['ingrediente'] != null &&
          !catalogosMap[catalogoId]!.ingredientes.any(
              (ing) => ing.ingrediente == linha['ingrediente'].toString())) {
        catalogosMap[catalogoId]!.ingredientes.add(Ingrediente(
              ingrediente: linha['ingrediente'].toString(),
              causaAlergia: linha['causa_alergia'].toString(),
            ));
      }

      // Adiciona tamanhos únicos ao catálogo
      if (linha['tamanho'] != null &&
          !catalogosMap[catalogoId]!
              .tamanhos
              .any((tam) => tam.tamanho == linha['tamanho'].toString())) {
        catalogosMap[catalogoId]!.tamanhos.add(Tamanho(
              tamanho: linha['tamanho'].toString(),
              peso: double.tryParse(linha['peso']?.toString() ?? '0') ?? 0,
              preco: double.tryParse(linha['preco']?.toString() ?? '0') ?? 0,
            ));
      }
    }

    // Retorna os valores do mapa como uma lista
    return catalogosMap.values.toList();
  }

  @override
  Future<DTOCatalogo> consultarPorId(int id) async {
    _db = await Conexao.abrir();

    // Consulta única que retorna os dados do catálogo, ingredientes e tamanhos em um join
    var resultados = await _db.rawQuery(sqlConsultarPorId, [id]);

    if (resultados.isEmpty) {
      throw Exception("Catálogo com ID $id não encontrado.");
    }

    // Mapeia o primeiro resultado para os dados do catálogo
    var resultado = resultados.first;

    DTOCatalogo catalogo = DTOCatalogo(
      id: resultado['id'],
      nome: resultado['nome'].toString(),
      urlAvatar: resultado['url_avatar'].toString(),
      descricao: resultado['descricao'].toString(),
      quantidade: int.parse(resultado['quantidade'].toString()),
      status: resultado['status'].toString(),
      ingredientes: [], // Inicializa as listas para preenchê-las a seguir
      tamanhos: [],
    );

    // Itera sobre os resultados para preencher as listas de ingredientes e tamanhos
    for (var linha in resultados) {
      // Adiciona ingredientes únicos
      if (linha['ingrediente'] != null &&
          !catalogo.ingredientes.any(
              (ing) => ing.ingrediente == linha['ingrediente'].toString())) {
        catalogo.ingredientes.add(Ingrediente(
          ingrediente: linha['ingrediente'].toString(),
          causaAlergia: linha['causa_alergia'].toString(),
        ));
      }

      // Adiciona tamanhos únicos
      if (linha['tamanho'] != null &&
          !catalogo.tamanhos
              .any((tam) => tam.tamanho == linha['tamanho'].toString())) {
        catalogo.tamanhos.add(Tamanho(
          tamanho: linha['tamanho'].toString(),
          peso: double.tryParse(linha['peso']?.toString() ?? '0') ?? 0,
          preco: double.tryParse(linha['preco']?.toString() ?? '0') ?? 0,
        ));
      }
    }

    return catalogo;
  }

  @override
  Future<DTOCatalogo> salvar(DTOCatalogo catalogo) async {
    _db = await Conexao.abrir();

    // Inserir catálogo
    int catalogoId = await _db.rawInsert(sqlInserirCatalogo, [
      catalogo.nome,
      catalogo.urlAvatar,
      catalogo.descricao,
      catalogo.quantidade,
      catalogo.status,
    ]);

    // Inserir ingredientes relacionados ao catálogo
    for (var ingrediente in catalogo.ingredientes) {
      await _db.rawInsert(sqlInserirIngrediente, [
        catalogoId, // Associar ao catálogo inserido
        ingrediente.ingrediente,
        ingrediente.causaAlergia,
      ]);
    }

    // Inserir tamanhos relacionados ao catálogo
    for (var tamanho in catalogo.tamanhos) {
      await _db.rawInsert(sqlInserirTamanho, [
        catalogoId, // Associar ao catálogo inserido
        tamanho.tamanho,
        tamanho.peso,
        tamanho.preco,
      ]);
    }

    // Atualizar o ID do objeto DTOCatalogo e retorná-lo
    catalogo.id = catalogoId;
    return catalogo;
  }

  @override
  Future<DTOCatalogo> alterar(DTOCatalogo catalogo) async {
    print('Entrou no alterar do Dao do catalogo');
    _db = await Conexao.abrir();

    // Atualizar catálogo
    await _db.rawUpdate(sqlAlterarCatalogo, [
      catalogo.nome,
      catalogo.urlAvatar,
      catalogo.descricao,
      catalogo.quantidade,
      catalogo.status,
      catalogo.id, // ID do catálogo a ser alterado
    ]);

    // Atualizar ingredientes (se já existirem, será feito update, senão insert)
    for (var ingrediente in catalogo.ingredientes) {
      var resultadoIngrediente = await _db.rawQuery(
          'SELECT id FROM ingrediente WHERE catalogo_id = ? AND ingrediente = ?',
          [catalogo.id, ingrediente.ingrediente]);

      if (resultadoIngrediente.isNotEmpty) {
        // Se o ingrediente já existe, atualize-o
        int ingredienteId = resultadoIngrediente.first['id'] as int;
        await _db.rawUpdate(sqlAlterarIngrediente, [
          ingrediente.ingrediente, // ingrediente atualizado
          ingrediente.causaAlergia, // nova causa de alergia
          ingredienteId,
        ]);
      } else {
        // Caso não exista, insira um novo ingrediente
        await _db.rawInsert(sqlInserirIngrediente, [
          catalogo.id, // Associar ao catálogo
          ingrediente.ingrediente,
          ingrediente.causaAlergia,
        ]);
      }
    }

    // Atualizar tamanhos (se já existirem, será feito update, senão insert)
    for (var tamanho in catalogo.tamanhos) {
      var resultadoTamanho = await _db.rawQuery(
          'SELECT id FROM tamanho WHERE catalogo_id = ? AND tamanho = ?',
          [catalogo.id, tamanho.tamanho]);

      if (resultadoTamanho.isNotEmpty) {
        // Se o tamanho já existe, atualize-o
        int tamanhoId = resultadoTamanho.first['id'] as int;
        await _db.rawUpdate(sqlAlterarTamanho, [
          tamanho.peso,
          tamanho.preco,
          tamanhoId,
        ]);
      } else {
        // Caso não exista, insira um novo tamanho
        await _db.rawInsert(sqlInserirTamanho, [
          catalogo.id, // Associar ao catálogo
          tamanho.tamanho,
          tamanho.peso,
          tamanho.preco,
        ]);
      }
    }
    print('Está retornando: ${catalogo}');
    return catalogo;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarStatus, [id]);
    return true;
  }
}
