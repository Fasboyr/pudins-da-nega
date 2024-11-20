import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';

class DTOCatalogo {
  late dynamic id;
  late String nome;
  late String? urlAvatar;
  late String descricao;
  late int quantidade;
  late List<Tamanho> tamanhos;
  late List<Ingrediente> ingredientes;
  late String status;

  DTOCatalogo({
    this.id,
    required this.nome,
    required this.urlAvatar,
    required this.descricao,
    required this.quantidade,
    required this.tamanhos,
    required this.ingredientes,
    this.status = 'A'
  });
}
