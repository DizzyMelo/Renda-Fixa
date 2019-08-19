import 'package:flutter/material.dart';
import 'classes/fundo.dart';

class CardInfo extends StatelessWidget {
  Fundo fundo;

  CardInfo(this.fundo);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    TextStyle estiloClasse = new TextStyle(fontSize: 16.0, color: Colors.white);
    TextStyle estiloLarge = new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    TextStyle estiloSmall = new TextStyle(fontSize: 14.0, color: Colors.grey[600]);
    TextStyle estiloDetalhes = new TextStyle(fontSize: 14.0, color: Colors.blue);

    String formatarNome(String nome){
      if(nome.length < 25){
        return nome;
      }else{
        return nome.substring(0, 25) + "...";
      }
    }

    return Container(
      height: 250.0,
      width: w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: fundo.perfil == "moderado" ? Color(0xFF44B95C) : Color(0xFFF18900)
            ),
            width: double.infinity,
            height: 40.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(fundo.classe, style: estiloClasse,)
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(formatarNome(fundo.nome.toUpperCase()), style: estiloLarge,),
          ),
          SizedBox(height: 5.0,),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("CNPJ: ${fundo.cnpj}", style: estiloSmall,),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Valor mínimo", style: estiloSmall,),
                  Text("R\$ ${fundo.aplicacaoMinima.toString()}"),
                ],
              ),

              Column(
                children: <Widget>[
                  Text("Liquidez", style: estiloSmall,),
                  Text(fundo.liquidez.toString(), style: estiloLarge,),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            width: double.infinity,
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Rentabilidade Anual", style: estiloSmall,),
                    Text("${fundo.rentabilidade}%", style: estiloLarge,),
                  ],
                ),
                Text('+ DETALHES', style: estiloDetalhes,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}