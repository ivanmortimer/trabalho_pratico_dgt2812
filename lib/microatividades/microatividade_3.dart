// Caminho do arquivo: lib/microatividades/microatividade_3.dart
//
// Microatividade 3: Criação de layouts básicos com os Widgets (Row e Column)
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter

import 'package:flutter/material.dart';

/// Ponto de entrada independente para testar a Microatividade 3.
void main() {
  runApp(const Microatividade3App());
}

class Microatividade3App extends StatelessWidget {
  const Microatividade3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 3 - Layouts',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Layouts - Row e Column'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        // O widget Center alinha a linha de botões no meio da tela
        body: const Center(child: ButtonSection()),
      ),
    );
  }
}

/// Widget que encapsula a seção de botões ("Button section" do roteiro)
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  /// Função auxiliar para construir as colunas individuais de botões.
  /// Demonstra a aplicação do widget [Column] contendo [Icon] e [Text].
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      // mainAxisSize.min garante que a coluna ocupe apenas o espaço necessário
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28.0),
        const SizedBox(height: 8.0), // Espaçamento vertical exigido no layout
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define a cor azul padronizada para os ícones e textos
    const Color color = Colors.blue;

    // O widget Row alinha os três elementos horizontalmente na tela,
    // distribuindo o espaço de forma igual entre eles (spaceEvenly).
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );
  }
}
