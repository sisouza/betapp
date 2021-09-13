import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
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

  //adicionando um item a lista
  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.itens.add(
        Iten(
          title: newTaskCtrl.text,
          done: false,
        ),
      );
      newTaskCtrl.text = "";
      save();
    });
  }

  //removendo itens
  void remove(int index) {
    setState(() {
      widget.itens.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data'); //sera salvo no formato json

    if (data != null) {
      //tranformar de string pra json
      Iterable decoded = jsonDecode(data);
      List<Iten> result = decoded.map((e) => Iten.fromJson(e)).toList();
      setState(() {
        widget.itens = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    //salvar e transformar em uma lista string json
    await prefs.setString('data', jsonEncode(widget.itens));
  }

  _HomePageState() {
    load();
  }
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

          return Dismissible(
            child: CheckboxListTile(
              title: Text(iten.title),
              value: iten.done,
              onChanged: (value) {
                setState(() {
                  iten.done = value!;
                  save();
                });
              },
            ),
            key: Key(iten.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
              child: Icon(
                Icons.remove,
              ),
            ),
            onDismissed: (direction) {
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlueAccent),
    );
  }
}
