import 'package:flutter/material.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_details.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_form.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_lista.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const CLIENT_LIST = '/';
  static const CLIENT_FORM = 'client-form';
  static const CLIENT_DETAILS = 'client-details';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pudins da Nega',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        CLIENT_LIST: (context) => ClienteLista(),
        CLIENT_FORM: (context) => ClienteForm(),
        CLIENT_DETAILS: (context) => ClienteDetails(),
      },
    );
  }
}
