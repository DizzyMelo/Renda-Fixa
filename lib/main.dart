import 'package:flutter/material.dart';
import 'package:rendafixa/classes/fundo.dart';
import 'package:rendafixa/classes/navegacao.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Renda Fixa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Fundo> carregarFundos() async {
    List<Fundo> tempListaDeFundos = new List();
    var jsonText = await rootBundle.loadString('assets/data.json');

    var fundos = json.decode(jsonText);
    
    for (var fundo in fundos['fundos_arr']) {
       tempListaDeFundos.add(new Fundo(
         double.parse(fundo['aplicacao_minima']),
         double.parse(fundo['rentabilidade']),
         double.parse(fundo['score']),
         fundo['classe'],
         fundo['cnpj'],
         fundo['gestor'],
         fundo['liquidez'],
         fundo['nome'],
         fundo['perfil'],
       ));
    }
    setState(() {
      Fundo.listaDeFundos = tempListaDeFundos;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.carregarFundos();
  }
  
  @override
  Widget build(BuildContext context) {

    Navegacao navegacao = new Navegacao(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index){
          return SizedBox(height: 10.0,);
        },
        scrollDirection: Axis.vertical,
        itemCount: Fundo.listaDeFundos.length, 
        itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            navegacao.irParaDetalhes(Fundo.listaDeFundos[index]);
          },
          child: CardInfo(Fundo.listaDeFundos[index]),
        );
      },),
    );
  }
}
