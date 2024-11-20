

import 'package:flutter/material.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';
import 'package:pudins_da_nega/my_app.dart';


class ClienteListBack{

  goToForm(BuildContext context, [DTOCliente? cliente]){
    Navigator.of(context).pushNamed(MyApp.CLIENT_FORM, arguments: cliente);
  }

  goToDetails(BuildContext context, DTOCliente cliente){
    Navigator.of(context).pushNamed(MyApp.CLIENT_DETAILS, arguments: cliente);
  }

 

}