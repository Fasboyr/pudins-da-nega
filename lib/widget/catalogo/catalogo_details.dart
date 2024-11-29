import 'package:flutter/material.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart'; // Supondo que o DTO seja chamado de `dto_catalogo.dart`
import 'package:pudins_da_nega/widget/catalogo/catalogo_details_back.dart';

class CatalogoDetails extends StatelessWidget {
  showModalError(BuildContext context) {
    var alert = AlertDialog(
      title: const Text('Alerta!'),
      content: const Text('Não foi possível encontrar um app compatível'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = CatalogoDetailsBack(context);
    var catalogo = _back.catalogo;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        var radius = width / 4;

        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(60),
            children: [
              (Uri.tryParse(catalogo.urlAvatar as String)?.isAbsolute ?? false)
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(catalogo.urlAvatar as String),
                      radius: radius,
                    )
                  : CircleAvatar(
                      radius: radius,
                      child: Icon(
                        Icons.cake,
                        size: width / 2,
                      ),
                    ),
              Center(
                child: Text(
                  '${catalogo.nome}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: const Text('Descrição:'),
                  subtitle: Text('${catalogo.descricao}'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Quantidade disponível:'),
                  subtitle: Text('${catalogo.quantidade ?? 'Indisponível'}'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Status:'),
                  subtitle: Text(catalogo.status == 'A' ? 'Ativo' : 'Inativo'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tamanhos disponíveis:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...catalogo.tamanhos?.map((tamanho) {
                    return Card(
                      child: ListTile(
                        title: Text('Tamanho: ${tamanho.tamanho ?? 'N/A'}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Peso: ${tamanho.peso?.toStringAsFixed(2) ?? 'N/A'} kg'),
                            Text(
                                'Preço: R\$ ${tamanho.preco?.toStringAsFixed(2) ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    );
                  }).toList() ??
                  [const Text('Nenhum tamanho disponível')],
              const SizedBox(height: 20),
              const Text(
                'Ingredientes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...catalogo.ingredientes?.map((ingrediente) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Ingrediente: ${ingrediente.ingrediente ?? 'N/A'}'),
                        subtitle: Text(
                          'Causa alergia: ${ingrediente.causaAlergia ?? 'N/A'}',
                        ),
                      ),
                    );
                  }).toList() ??
                  [const Text('Nenhum ingrediente listado')],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              _back.goToBack();
            },
          ),
        );
      },
    );
  }
}
