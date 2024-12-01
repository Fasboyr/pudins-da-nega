import 'package:flutter/material.dart';
import 'package:pudins_da_nega/aplicacao/a_cliente.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_lista_back.dart';

class ClienteLista extends StatefulWidget {
  @override
  _ClienteListaState createState() => _ClienteListaState();
}

class _ClienteListaState extends State<ClienteLista> {
  final ClienteListBack _back = ClienteListBack();
  late Future<List<DTOCliente>> _lista;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    var apCliente = ACliente();
    setState(() {
      _lista = apCliente.consultar();
      print('Lista: $_lista');
    });
  }

  CircleAvatar circleAvatar(String? url) {
    var avatar = const CircleAvatar(child: Icon(Icons.person));
    if (url != null) {
      var uri = Uri.tryParse(url);
      if (uri != null && uri.isAbsolute) {
        avatar = CircleAvatar(backgroundImage: NetworkImage(url));
      }
    }
    return avatar;
  }

  Widget iconEditButton(VoidCallback onPressed) {
    return IconButton(
      icon: const Icon(Icons.edit),
      color: Colors.orange,
      onPressed: onPressed,
    );
  }

  Widget iconRemoveButton(BuildContext context, VoidCallback remove) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir'),
            content: const Text('Confirma a Exclusão?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: remove,
                child: const Text('Sim'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Atualiza a lista diretamente pelo retorno da função goToForm
              _back.goToForm(context).then((novaLista) {
                if (novaLista.isNotEmpty) {
                  setState(() {
                    _lista = Future.value(
                        novaLista); // Atualiza o Future com os novos dados
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<DTOCliente>>(
        future: _lista,
        builder:
            (BuildContext context, AsyncSnapshot<List<DTOCliente>> futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (futuro.hasError) {
            return Center(
                child: Text('Erro ao carregar dados: ${futuro.error}'));
          }
          if (!futuro.hasData || futuro.data!.isEmpty) {
            return const Center(child: Text('Nenhum cliente encontrado.'));
          }

          var lista = futuro.data!;
          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, i) {
              var cliente = lista[i];
              return ListTile(
                leading: circleAvatar(cliente.urlAvatar),
                title: Text(cliente.nome),
                onTap: () {
                  _back.goToDetails(context, cliente);
                },
                subtitle: Text(cliente.telefone),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      iconEditButton(() {
                        _back.goToForm(context, cliente).then((novaLista) {
                          if (novaLista.isNotEmpty) {
                            print('Nova lista: ${novaLista}');
                            setState(() {
                              _lista = Future.value(novaLista);
                            });
                          }
                        });
                      }),
                      iconRemoveButton(context, () async {
                        //await _back.remove(cliente.id, context);
                        _loadData(); // Atualiza a lista após remoção
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
