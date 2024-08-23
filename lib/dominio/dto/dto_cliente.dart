import 'package:pudins_da_nega/dominio/endereco.dart';

class DTOCliente {
  late dynamic? id;
  late String nome;
  late String cpf;
  late String cep;
  late Endereco endereco;
  late String telefone;

  DTOCliente({this.id, required this.nome, required this.cpf, required this.cep, required this.endereco, required this.telefone});
}
