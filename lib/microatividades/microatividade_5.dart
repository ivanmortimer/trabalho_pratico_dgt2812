// Caminho do arquivo: lib/microatividades/microatividade_5.dart
//
// Microatividade 5: Desenvolvimento de Outra Funcionalidade para o Widget
// em Flutter (Sobreposição de Elementos com Stack e Container)
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter
// Curso: Graduação Tecnológica em Desenvolvimento Full Stack - Estácio

import 'package:flutter/material.dart';

/// Ponto de entrada independente da Microatividade 5.
/// Permite a execução isolada via terminal utilizando a flag `-t`:
/// `flutter run -t lib/microatividades/microatividade_5.dart`
void main() => runApp(const Microatividade5App());

/// Widget raiz da Microatividade 5.
/// Configura o tema da aplicação com base no Material Design 3 e inicializa
/// a tela demonstrativa de sobreposição com o widget [Stack].
class Microatividade5App extends StatelessWidget {
  const Microatividade5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 5 - Widget Stack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StackDemoScreen(),
    );
  }
}

/// Tela demonstrativa que consolida os dois cenários visuais previstos no
/// roteiro oficial da Microatividade 5:
/// 1. Sobreposição de [Container]s coloridos de dimensões decrescentes.
/// 2. Sobreposição de rótulo textual sobre uma imagem circular ("Mia B").
class StackDemoScreen extends StatelessWidget {
  const StackDemoScreen({super.key});

  /// Constrói a pilha de [Container]s coloridos especificada nos procedimentos
  /// da Microatividade 5.
  ///
  /// No [Stack], a ordem de declaração na lista [children] define a ordem de
  /// pintura no eixo Z: o primeiro widget ocupa o fundo e cada widget seguinte
  /// é desenhado por cima do anterior, ancorado por padrão no canto superior
  /// esquerdo (`AlignmentDirectional.topStart`).
  Widget _buildContainerStack() {
    return Stack(
      children: [
        // Camada base (fundo): quadrado azul de 250x250 pixels
        Container(width: 250, height: 250, color: Colors.blue),
        // Camada intermediária: quadrado vermelho de 200x200 pixels
        Container(width: 200, height: 200, color: Colors.red),
        // Camada superior (topo): quadrado amarelo de 150x150 pixels
        Container(width: 150, height: 150, color: Colors.yellow),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Contêineres Empilhados",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// Constrói a sobreposição de texto sobre uma imagem circular, reproduzindo
  /// a referência visual ("Mia B") dos resultados esperados do roteiro oficial.
  ///
  /// Utiliza [Alignment] para posicionar o rótulo no quadrante inferior direito
  /// e [Image.asset] com [errorBuilder] para manter a estabilidade visual caso
  /// o arquivo `assets/images/ai_generated_mia.jpg` ainda não tenha sido copiado para o
  /// diretório do projeto.
  Widget _buildAvatarStack() {
    return Stack(
      // Posiciona os filhos não ancorados no quadrante inferior direito:
      // x = 0.6 (deslocado à direita do centro) e y = 0.6 (abaixo do centro).
      alignment: const Alignment(0.6, 0.6),
      children: [
        // Camada base: imagem recortada em formato circular
        ClipOval(
          child: Image.asset(
            'assets/images/ai_generated_mia.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            // Tratamento preventivo de erro: renderiza um avatar substituto
            // caso o arquivo de imagem ainda não exista em `assets/images/`.
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: Colors.blueGrey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      size: 110,
                      color: Colors.white,
                    ),
                  );
                },
          ),
        ),
        // Camada superior: rótulo textual com fundo semitransparente para
        // garantir contraste e legibilidade sobre a imagem de fundo.
        Container(
          decoration: const BoxDecoration(color: Colors.black45),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: const Text(
            'Mia B',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Microatividade 5 - Sobreposição (Stack)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // [SingleChildScrollView] evita erros de overflow vertical em dispositivos
      // com telas compactas ou na orientação paisagem.
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '1. Empilhamento de Contêineres (Stack)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _buildContainerStack(),
              const Divider(height: 48),
              const Text(
                '2. Rótulo Sobreposto a Imagem Circular',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _buildAvatarStack(),
            ],
          ),
        ),
      ),
    );
  }
}
