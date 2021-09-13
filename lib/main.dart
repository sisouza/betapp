import 'package:flutter/material.dart';
import 'models/iten.dart';

void main() {
  runApp(MyApp());
}

//a casca da aplicacao pode ser stateless
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //nossa app como um td sempre retornar um material app
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  List<Iten> itens = <Iten>[];

//construtor
  HomePage() {
    itens = [];
    itens.add(Iten(title: "Item 1", done: false));
    itens.add(Iten(title: "Item 2", done: true));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: <Widget>[
          Icon(Icons.plus_one),
        ],
      ),

      //vai mostrar os itens na tela baseado no tamanho deles
      body: ListView.builder(
        itemCount: widget.itens.length,
        //aqui é o que vai mostrar na tela e como vai mostar design
        itemBuilder: (BuildContext ctxt, int index) {
          return Text(widget.itens[index].title);
        },
      ),
    );
  }
}
