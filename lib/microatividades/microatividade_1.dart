// Caminho do arquivo: lib/microatividades/microatividade_1.dart
//
// Microatividade 1: Preparação e Validação do Ambiente de Desenvolvimento
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(const Microatividade1App());

/// Modelo de dados da aplicação.
class EtapaProcedimento {
  final String titulo;
  final String descricao;
  final String comando;
  bool concluido;

  EtapaProcedimento({
    required this.titulo,
    required this.descricao,
    required this.comando,
    required this.concluido,
  });
}

/// Widget principal da Microatividade 1.
/// Expõe um painel interativo de verificação das etapas de configuração do
/// ambiente Flutter no Windows 11 e resumo do diagnóstico `flutter doctor`.
class Microatividade1App extends StatelessWidget {
  const Microatividade1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 1 - Ambiente Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Microatividade1Screen(),
    );
  }
}

class Microatividade1Screen extends StatefulWidget {
  const Microatividade1Screen({super.key});

  @override
  State<Microatividade1Screen> createState() => _Microatividade1ScreenState();
}

class _Microatividade1ScreenState extends State<Microatividade1Screen> {
  // Declaração e inicialização do controlador de Scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // <-- Boa prática: liberar memória
    super.dispose();
  }

  // Etapas oficiais descritas na Microatividade 1 do roteiro intitulado
  // "Trabalho Prático | DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter"
  final List<EtapaProcedimento> _etapasProcedimento = [
    EtapaProcedimento(
      titulo: '1. Instalação do Git para Windows',
      descricao: 'Cliente Git instalado e configurado para controle de versão.',
      comando: 'git --version',
      concluido: true,
    ),
    EtapaProcedimento(
      titulo: '2. Download e Extração do Flutter SDK',
      descricao: 'Arquivo zip (canal stable) extraído em diretório sem restrição de privilégios.',
      comando: r'C:\flutter',
      concluido: true,
    ),
    EtapaProcedimento(
      titulo: '3. Configuração das Variáveis de Ambiente',
      descricao:
          r'C:\flutter\bin adicionado à variável Path do usuário no Windows.',
      comando: r'$env:PATH',
      concluido: true,
    ),
    EtapaProcedimento(
      titulo: '4. Reinicialização e Aplicação do Path',
      descricao: 'Sessão do sistema/terminal atualizada para reconhecer os binários do SDK.',
      comando: 'pwsh',
      concluido: true,
    ),
    EtapaProcedimento(
      titulo: '5. Verificação da Instalação do Flutter',
      descricao: 'Execução do comando flutter exibindo a listagem de ajuda da ferramenta CLI.',
      comando: 'flutter --help',
      concluido: true,
    ),
    EtapaProcedimento(
      titulo: '6. Diagnóstico com flutter doctor',
      descricao: 'Validação completa do SDK, toolchain Android, VS Code e dispositivos.',
      comando: 'flutter doctor -v',
      concluido: true,
    ),
  ];

  String _obterPlataformaAtual() {
    if (kIsWeb) {
      return 'Web Browser (Chrome / Edge)';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 'Windows Desktop (Windows 11 Home 23H2)';
      case TargetPlatform.android:
        return 'Android (Emulador / Dispositivo Físico)';
      case TargetPlatform.iOS:
        return 'iOS (Simulador / Dispositivo)';
      case TargetPlatform.linux:
        return 'Linux Desktop';
      case TargetPlatform.macOS:
        return 'macOS Desktop';
      case TargetPlatform.fuchsia:
        return 'Fuchsia';
    }
  }

  void _executarDiagnosticoSimulado() {
    final totalConcluidas = _etapasProcedimento
        .where((etapa) => etapa.concluido)
        .length;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Diagnóstico concluído: $totalConcluidas de ${_etapasProcedimento.length} '
          'etapas validadas com sucesso em ${_obterPlataformaAtual()}!',
        ),
        duration: const Duration(
          seconds: 6,
        ), // Define o tempo exato de exibição
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        // Define margem inferior de 32 pixels e mantém margens laterais
        margin: const EdgeInsets.only(bottom: 32.0, left: 16.0, right: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Microatividade 1 - Ambiente Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Adição do Scrollbar com thumbVisibility ativa para garantir a visualização da barra vertical
      body: Scrollbar(
        // Vinculação do controlador de Scroll a ambos os widgets no método build:
        controller: _scrollController, // <-- Vinculação aqui
        thumbVisibility: true,
        // Força a interatividade do scroll thumb no Android/iOS:
        interactive: true,
        thickness: 10.0,
        radius: const Radius.circular(10.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              // Permite clicar e arrastar a tela com o mouse:
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView(
            controller: _scrollController, // <-- Vinculação aqui
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.green.shade700,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Ambiente de Desenvolvimento Validado',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      const Text('• Disciplina: DGT2812 - Flutter (Estácio)'),
                      const Text(
                        '• SO: Windows 11 Home (23H2 | Build 22631.6199)',
                      ),
                      const Text('• IDE & Shell: VS Code + PowerShell 7'),
                      Text('• Alvo em execução: ${_obterPlataformaAtual()}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Procedimentos do Roteiro Oficial (Microatividade 1):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._etapasProcedimento.map((etapa) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CheckboxListTile(
                    value: etapa.concluido,
                    onChanged: (bool? novoValor) {
                      setState(() {
                        etapa.concluido = novoValor ?? false;
                      });
                    },
                    secondary: Icon(
                      etapa.concluido
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: etapa.concluido ? Colors.green : Colors.grey,
                    ),
                    title: Text(
                      etapa.titulo,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${etapa.descricao}\nComando/Ref: ${etapa.comando}',
                    ),
                    isThreeLine: true,
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Nota técnica de compatibilidade:
              // ElevatedButton substitui o antigo RaisedButton (depreciado no Flutter 2.0+)
              // citado nos objetivos gerais do roteiro oficial.
              ElevatedButton.icon(
                onPressed: _executarDiagnosticoSimulado,
                icon: const Icon(Icons.medical_services_outlined),
                label: const Text(
                  'Validar Status do Ambiente (flutter doctor)',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
              const SizedBox(height: 32), // <-- Adicionado para aumentar o espaço na parte de baixo datela.
            ],
          ),
        ),
      ),
    );
  }
}
