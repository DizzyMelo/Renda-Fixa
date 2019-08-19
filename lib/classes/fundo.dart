import 'dart:convert';

class Fundo{
  double aplicacaoMinima, rentabilidade, score;
  String classe, cnpj, gestor, liquidez, nome, perfil;

  Fundo(this.aplicacaoMinima, this.rentabilidade, this.score, this.classe, this.cnpj, this.gestor, this.liquidez, this.nome, this.perfil);
  

  static List<Fundo> listaDeFundos = new List();
}