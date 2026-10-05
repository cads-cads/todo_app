import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const TarefaApp());

class TarefaApp extends StatelessWidget {
  const TarefaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      //themeMode: ThemeMode.system,

      home: TelaTarefa(),
    );
  }
}

class TelaTarefa extends StatefulWidget {
  const TelaTarefa({super.key});
  @override
  State<TelaTarefa> createState() => _TelaTarefaState();
}

class _TelaTarefaState extends State<TelaTarefa> {
  final List<String> lista = [];
  final controllerInout = TextEditingController();

  void limpaInput() {
    controllerInout.clear();
  }

  void alerta({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Error")));
  }

  @override
  void dispose() {
    controllerInout.dispose();
    super.dispose();
  }

  //const TelaTarefa({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List V1")),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lista[index]),
            leading: const Icon(Icons.check_box_outlined),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  lista.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alerta Input"),
                content: TextField(
                  controller: controllerInout,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Tarefa",
                    hintText: "Add tarefa",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controllerInout.clear();
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      final campo = controllerInout.text;
                      if (campo.isNotEmpty) {
                        setState(() {
                          lista.add(campo);
                        });
                        limpaInput();
                        Navigator.pop(context);
                      }
                      alerta(context: context, message: "Error");
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
