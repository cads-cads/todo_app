import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    ); // MaterialApp
  } // Widget
} // MyApp

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Todo list"),
        leading: const Icon(Icons.menu),
      ), //AppBar
    ); //Scaffold
  }
} //Home

Widget _todoItem(String nome, bool concluida) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.purple,
      borderRadius: BorderRadiusGeometry.circular(5),
      boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 4)],
    ), //BoxDecoration
    child: Row(
      children: [
        Icon(
          concluida ? Icons.check_circle : Icons.radio_button_unchecked,
          color: concluida ? Colors.red : Colors.grey,
        ),
        const SizedBox(height: 10), //SizedBox
        Expanded(

          child: Text("Texto", style: TextStyle(decoration: concluida ? TextDecoration.lineThrough : null)),
        ), //Expanded
      ], //children
    ), //Row
  ); //Container
} //Widget
