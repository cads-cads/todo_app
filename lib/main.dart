import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_cores.dart';

// funcao principal a main
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exmpplos",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ), //ThemeData
      themeMode: ThemeMode.dark,
      home: Home(),
    ); //MaterialApp
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exemplos"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ), //AppBar

      body: Column(
        children: [
          pageApp(),

          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: "https://site.com/foto.jpg",
              width: 200,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 200,
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                width: 200,
                height: 150,
                child: Center(child: Icon(Icons.error, size: 40)),
              ),
            ),
          ),
        ],
      ),
    ); //Scaffold
  }
}

Widget pageApp() {
  return SizedBox(
    width: double.infinity,
    height: 200,

    child: Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),

        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ola mundo"),
            const Text("Ola mundo"),
            const Text("Ola mundo"),
          ],
        ), //Column
      ), //Padding
    ), //Card
  ); //SizeBox
}
