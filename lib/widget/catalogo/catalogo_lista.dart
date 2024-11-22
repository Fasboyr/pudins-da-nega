import 'package:flutter/material.dart';
import 'package:pudins_da_nega/aplicacao/a_catalogo.dart';
import 'package:pudins_da_nega/dominio/dto/dto_catalogo.dart';
import 'package:pudins_da_nega/my_app.dart';

class CatalogoLista extends StatefulWidget {
  const CatalogoLista({Key? key}) : super(key: key);

  @override
  State<CatalogoLista> createState() => _CatalogoListaState();
}

class _CatalogoListaState extends State<CatalogoLista> {
  final ACatalogo _catalogoService = ACatalogo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retorna para a página anterior
          },
        ),
      ),
      body: criarLista(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyApp.CATALOGO_FORM)
              .then((value) => buscarProdutos());
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
        tooltip: 'Adicionar Novo',
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, MyApp.CLIENT_LIST);
              },
              tooltip: 'Clientes',
            ),
            IconButton(
              icon: const Icon(Icons.category),
              onPressed: () {
                Navigator.pushNamed(context, MyApp.CATALOGO_LIST);
              },
              tooltip: 'Catálogo',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarProdutos(),
      builder: (context, AsyncSnapshot<List<DTOCatalogo>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Não há produtos cadastrados.'));
        }
        List<DTOCatalogo> produtos = snapshot.data!;
        return ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            var produto = produtos[index];
            return criarItemLista(context, produto);
          },
        );
      },
    );
  }

  Future<List<DTOCatalogo>> buscarProdutos() async {
    setState(() {});
    return _catalogoService.consultar();
  }

  Widget criarItemLista(BuildContext context, DTOCatalogo produto) {
    return ListTile(
      leading: _circleAvatar(produto.urlAvatar),
      title: Text(produto.nome ?? 'Sem nome'),
      subtitle: Text(produto.descricao ?? 'Sem descrição'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.orange,
            onPressed: () {
              Navigator.pushNamed(context, MyApp.CATALOGO_FORM,
                      arguments: produto)
                  .then((value) => buscarProdutos());
            },
            tooltip: 'Editar',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              // Placeholder para lógica de exclusão
              // _catalogoService.remover(produto.id);
              buscarProdutos();
            },
            tooltip: 'Excluir',
          ),
        ],
      ),
    );
  }

  CircleAvatar _circleAvatar(String? url) {
    if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
      return CircleAvatar(backgroundImage: NetworkImage(url));
    }
    return const CircleAvatar(child: Icon(Icons.fastfood));
  }
}
