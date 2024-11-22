import 'package:flutter/material.dart';
import 'package:pudins_da_nega/widget/catalogo/catalogo_form.dart';
import 'package:pudins_da_nega/widget/catalogo/catalogo_lista.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_details.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_form.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_lista.dart';
import 'package:pudins_da_nega/widget/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const HOME = '/';
  static const CLIENT_LIST = 'client-list';
  static const CLIENT_FORM = 'client-form';
  static const CLIENT_DETAILS = 'client-details';
  static const CATALOGO_LIST = 'catalogo-list';
    static const CATALOGO_FORM = 'catalogo-Form';

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
      initialRoute: HOME,
      routes: {
        HOME: (context) => const Home(),
        CLIENT_LIST: (context) => ClienteLista(),
        CLIENT_FORM: (context) => ClienteForm(),
        CLIENT_DETAILS: (context) => ClienteDetails(),
        CATALOGO_LIST: (context) => CatalogoLista(),
        CATALOGO_FORM: (context) => CatalogoForm()
      },
    );
  }
}
