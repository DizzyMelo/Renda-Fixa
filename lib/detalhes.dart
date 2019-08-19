import 'package:flutter/material.dart';
import 'classes/fundo.dart';
import 'graficos/grafico.dart';


class Detalhe extends StatefulWidget {
  Fundo fundo;
  Detalhe(this.fundo);
  @override
  _DetalheState createState() => _DetalheState();
}

class _DetalheState extends State<Detalhe> {
  TextStyle estiloClasse = new TextStyle(fontSize: 16.0, color: Colors.white);
  TextStyle estiloLarge =
      new TextStyle(fontSize: 20.0, fontFamily: "TitiliumBold");
  TextStyle estiloMedium =
      new TextStyle(fontSize: 18.0, fontFamily: "TitiliumBold");
  TextStyle estiloSmall = new TextStyle(
      fontSize: 24.0, color: Colors.black, fontFamily: "TitiliumLight");
  TextStyle estiloDetalhes = new TextStyle(fontSize: 14.0, color: Colors.blue);


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: widget.fundo.perfil == "moderado"
            ? Color(0xFF44B95C)
            : Color(0xFFF18900),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.fundo.classe),
          backgroundColor: widget.fundo.perfil == "moderado"
              ? Color(0xFF44B95C)
              : Color(0xFFF18900),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 110.0,
                      width: 110.0,
                      child: Icon(
                        Icons.person,
                        size: 75.0,
                        color: Colors.grey[400],
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.fundo.gestor,
                        style: estiloMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(height: 20.0,),
                Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.fundo.nome,
                        style: estiloLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: w,
                    height: 120.0,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Rentabilidade",
                              style: estiloMedium,
                            ),
                            Text(
                              widget.fundo.rentabilidade.toString(),
                              style: estiloSmall,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Liquidez",
                              style: estiloMedium,
                            ),
                            Text(
                              widget.fundo.liquidez.toString(),
                              style: estiloSmall,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Score",
                              style: estiloMedium,
                            ),
                            Text(
                              widget.fundo.score.toString(),
                              style: estiloSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                BarChartSample1(widget.fundo.aplicacaoMinima.toString())
              ],
            ),
          ),
        ));
  }
}
