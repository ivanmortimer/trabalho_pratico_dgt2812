// Caminho do arquivo: lib/microatividades/microatividade_2.dart
//
// Microatividade 2: Utilização de Widgets Flutter Básicos
// MaterialApp, Scaffold e AppBar
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter

import 'package:flutter/material.dart';

/// Ponto de entrada independente para a Microatividade 2.
void main() {
  runApp(
    // O MaterialApp é o widget raiz que configura o roteamento,
    // os temas e os padrões visuais (Material Design) do aplicativo.
    const MaterialApp(
      title: "Microatividade 2 - Olá Flutter",
      debugShowCheckedModeBanner: false,
      home: StatelessWidgetExemplo("Olá Flutter - MaterialApp"),
    ),
  );
}

/// A classe [StatelessWidgetExemplo] implementa a estrutura visual básica
/// exigida pela Microatividade 2, sem gerenciar estados internos.
class StatelessWidgetExemplo extends StatelessWidget {
  final String _appBarTitle;

  // Construtor atualizado para os padrões do Flutter 3.x+ com super.key
  const StatelessWidgetExemplo(this._appBarTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    // O Scaffold provê a estrutura de layout para a tela,
    // incluindo a barra superior (AppBar) e o corpo principal (body).
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        // Adição opcional de cor para melhorar o contraste visual
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // O widget Center alinha seu filho (child) no meio exato da tela.
      body: const Center(
        child: Text('Macoratti.net', style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
