
import 'package:flutter/material.dart';
import 'package:pudins_da_nega/dominio/dto/dto_cliente.dart';

class ClienteDetailsBack{
  BuildContext context;
  late DTOCliente cliente;

  ClienteDetailsBack(this.context){
    cliente = ModalRoute.of(context)!.settings.arguments as DTOCliente;
  }

  goToBack(){
    Navigator.of(context).pop();
  }

/* _launchApp(String url, Function(BuildContext context) showModalError) async{
    final Uri uri = Uri.parse(url);
    await canLaunchUrl(uri)? await launchUrl(uri) : showModalError(context);
  }

  launchPhone(Function(BuildContext context) showModalError){
    _launchApp('tel:${contact.telefone}', showModalError);
  }

  launchSMS(Function(BuildContext context) showModalError){
    _launchApp('sms:${contact.telefone}', showModalError);
  }

  launchEmail(Function(BuildContext context) showModalError){
    _launchApp('mailto:${contact.email}', showModalError);
  }*/

}