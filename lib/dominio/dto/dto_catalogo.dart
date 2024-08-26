import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';

class DTOCatalogo{

  late dynamic id;
  late String urlAvatar;
  late String descricao;
  late List<Tamanho> tamanho;
  late double preco;
  late List<Ingrediente> ingredientes; 

  DTOCatalogo({this.id, required this.urlAvatar, required this.descricao, required this.tamanho, required this.preco, required this.ingredientes});

}