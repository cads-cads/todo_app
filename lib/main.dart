import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      color: Colors.purpleAccent,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Todo list"),
        leading: const Icon(Icons.menu),
      ),

      body: Center(child: _card()),
    );
  }
}

Widget _card() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
    height: 200,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, size: 50, color: Colors.black),
        ),
        Text(
          "Adicionar amigo",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ],
    ),
  );
}
