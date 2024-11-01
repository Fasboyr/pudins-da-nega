import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';

class DTOCatalogo{

  late dynamic id;
  late String nome;
  late String urlAvatar;
  late String descricao;
  late List<Tamanho> tamanho;
  late List<Ingrediente> ingredientes; 

  DTOCatalogo({this.id, required this.nome, required this.urlAvatar, required this.descricao, required this.tamanho, required this.ingredientes});

}