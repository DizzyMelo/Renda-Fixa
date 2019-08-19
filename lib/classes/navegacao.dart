import 'package:flutter/material.dart';

import '../detalhes.dart';
import 'fundo.dart';

class Navegacao{
  BuildContext context;
  Navegacao(this.context);

  irParaDetalhes(Fundo fundo){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Detalhe(fundo)));
  }
}

/*

Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()),
                                (Route route) => route == null);

 */