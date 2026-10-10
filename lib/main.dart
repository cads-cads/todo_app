import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaTarefa(),
    ); //MaterialApp
  }
}

class Tarefa {
  String nome;
  bool concluida;

  Tarefa({required this.nome, this.concluida = false});
}

// => TelaTarefa
class TelaTarefa extends StatefulWidget {
  const TelaTarefa({super.key});

  @override
  State<TelaTarefa> createState() => _TelaTarefaState();
}

// => _TelaTarefaState
class _TelaTarefaState extends State<TelaTarefa> {
  @override
  Widget build(BuildContext context) {
    final controllerInut = TextEditingController();
    final List<String> lista = [];
    bool ok = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Todo List"),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ), //IconButton
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ), //IconButton
        ], //actions[]
      ), //AppBar

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(Icons.warning),
                title: const Text("Alert"),
                content: TextField(
                  controller: controllerInut,
                  autofocus: true,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Tarefa",
                    labelText: "nome",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ), //InputDecoration
                ), //TextField
                actions: [], //actions[]
              ); //AlertDialog
            },
          );
        },
        child: const Icon(Icons.add),
      ), //FloatingActionButton
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ), //BoxDecoration
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    ok = !ok;
                  });
                },
                icon: Icon(ok ? Icons.check_box_outlined : Icons.person),
              ),
              title: Text(index.toString()),
            ), //ListTile
          ); //Container
        },
      ), //ListView
    ); //Scaffold
  }
}
