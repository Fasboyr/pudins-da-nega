import 'package:flutter/material.dart';
import 'package:pudins_da_nega/aplicacao/a_cliente.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/my_app.dart';

class ClienteListBack {
  Future<List<DTOCliente>> goToForm(BuildContext context,
      [DTOCliente? cliente]) async {
    // Navega para o formulário
    final result = await Navigator.of(context).pushNamed(
      MyApp.CLIENT_FORM,
      arguments: cliente,
    );

    if (result == true) {
      var apCliente = ACliente();
      await Future.delayed(Duration(seconds: 1));

      // Após o atraso, realiza a consulta
      return await apCliente.consultar();
    }

    return [];
  }

  goToDetails(BuildContext context, DTOCliente cliente) {
    Navigator.of(context).pushNamed(MyApp.CLIENT_DETAILS, arguments: cliente);
  }
}
