import 'package:flutter/material.dart';
import 'package:pudins_da_nega/aplicacao/a_cliente.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/widget/cliente_lista_back.dart';

class ClienteLista extends StatelessWidget {
  final _back = ClienteListBack();


  CircleAvatar circleAvatar(String? url)  {
    var avatar = const CircleAvatar(child: Icon(Icons.person));
    if(url != null){
      var uri = Uri.tryParse(url);
      if(uri != null && uri.isAbsolute){
        avatar = CircleAvatar(backgroundImage: NetworkImage(url));
      }
    }
    return avatar;
  }

  Widget iconEditButton(VoidCallback onPressed){
    return IconButton(icon: const Icon(Icons.edit), color: Colors.orange, onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, VoidCallback remove){
    return IconButton(
      icon: const Icon(Icons.delete), 
      color: Colors.red, 
      onPressed: () {
        showDialog(
          context: context, 
          builder:  (context) => AlertDialog(
            title: const Text('Excluir'),
            content: const Text('Confirma a Exclusão?'),
            actions: [
              TextButton(
                child: const Text('Não'), 
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: remove,
                child: const Text('Sim'),
              ),
            ],
          )
        );
      }
    );
  }

   @override
  Widget build(BuildContext context) {
    var apCliente = ACliente();
    var lista = apCliente.consultar();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Clientes'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _back.goToForm(context);
                })
          ],
        ),
        body: FutureBuilder(
            future: lista,
            builder: (BuildContext context,
                AsyncSnapshot<List<DTOCliente>> futuro) {
              if (!futuro.hasData || futuro.data == null) {
                return const CircularProgressIndicator();
              } else {
                List<DTOCliente> lista = futuro.data!;
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
                               _back.goToForm(context, cliente);
                            }),
                            iconRemoveButton(context, () {
                              // _back.remove(contato.id, context);
                            })
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
