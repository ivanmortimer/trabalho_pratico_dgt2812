// Caminho do arquivo: lib/microatividades/microatividade_4.dart
//
// Microatividade 4: Utilização do Widget ListView em Flutter
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter

import 'package:flutter/material.dart';

/// Ponto de entrada independente para testar a Microatividade 4.
void main() {
  runApp(const Microatividade4App());
}

class Microatividade4App extends StatelessWidget {
  const Microatividade4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 4 - ListView',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listas com ListView'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        // O corpo da tela é preenchido pelo ListView, garantindo rolagem nativa
        body: const TechList(),
      ),
    );
  }
}

/// Widget que isola a construção da lista de tecnologias.
class TechList extends StatelessWidget {
  const TechList({super.key});

  @override
  Widget build(BuildContext context) {
    // O ListView renderiza os componentes verticalmente e provê a barra de rolagem
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: const [
        Card(
          elevation: 1,
          child: ListTile(
            leading: Icon(Icons.flash_on, color: Colors.grey),
            title: Text('Flutter'),
            subtitle: Text('Tudo é um widget'),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        ),
        Card(
          elevation: 1,
          child: ListTile(
            leading: Icon(Icons.mood, color: Colors.grey),
            title: Text('Dart'),
            subtitle: Text('É fácil'),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        ),
        Card(
          elevation: 1,
          child: ListTile(
            leading: Icon(Icons.local_fire_department, color: Colors.grey),
            title: Text('Firebase'),
            subtitle: Text('Combina com Flutter'),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
