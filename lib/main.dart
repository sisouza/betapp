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
      title: 'Todo App',
      theme: ThemeData(
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
  //controller para o texto
  var newTaskCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
              labelText: "Add New Iten",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          Icon(Icons.plus_one),
        ],
      ),

      //vai mostrar os itens na tela baseado no tamanho deles
      body: ListView.builder(
        itemCount: widget.itens.length,
        //aqui é o que vai mostrar na tela e como vai mostar design
        itemBuilder: (BuildContext ctxt, int index) {
          final iten = widget.itens[index];

          return CheckboxListTile(
            title: Text(iten.title),
            key: Key(iten.title),
            value: iten.done,
            onChanged: (value) {
              setState(() {
                iten.done = value!;
              });
            },
          );
        },
      ),
    );
  }
}
