import 'package:flutter/material.dart';
import 'package:pudins_da_nega/main.dart';
import 'package:pudins_da_nega/my_app.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pudins da Nega'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text('Ir para a Lista de Clientes'),
              onPressed: () {
                Navigator.pushNamed(context, MyApp.CLIENT_LIST);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.fastfood),
              label: const Text('Ir para o Catalogo de produtos'),
              onPressed: () {
                Navigator.pushNamed(context, MyApp.CATALOGO_LIST);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
