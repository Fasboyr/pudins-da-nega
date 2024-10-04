import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const HOME = '/';
  static const CLIENT_LIST = 'client-list';
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
      /*routes: {
        CLIENT_LIST: (context) => SubjectList(),
        CLIENT_FORM: (context) => SubjectForm(),
        CLIENT_DETAILS: (context) => SubjectDetails(),
      },*/
    
    );
  }
}
