import 'package:pudins_da_nega/dominio/cadastro/endereco.dart';

class DTOCliente {
  late dynamic id;
  late String nome;
  late String cpf;
  late String cep;
  late String status;
  late String? urlAvatar;
  late Endereco endereco;
  late String telefone;

  DTOCliente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.cep,
    this.status = 'A',
    this.urlAvatar,
    required this.endereco,
    required this.telefone,
  });

  @override
  String toString() {
    return 'DTOCliente{id: $id, nome: $nome, cpf: $cpf, cep: $cep, status: $status, urlAvatar: $urlAvatar, telefone: $telefone, endereco: $endereco}';
  }
}
