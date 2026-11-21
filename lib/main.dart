// Caminho do arquivo: lib/main.dart
//
// Trabalho Prático Final: Aplicativo da Agência de Viagens "Explore Mundo"
// Disciplina: DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter
// Curso: Graduação Tecnológica em Desenvolvimento Full Stack - Estácio

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_pratico_dgt2812/controllers/explore_controller.dart';
import 'package:trabalho_pratico_dgt2812/views/contato_view.dart';
import 'package:trabalho_pratico_dgt2812/views/destino_detalhe_view.dart';
import 'package:trabalho_pratico_dgt2812/views/destinos_view.dart';
import 'package:trabalho_pratico_dgt2812/views/reservas_view.dart';

void main() => runApp(const ExploreMundoApp());

/// Configuração global de rolagem para suportar gestos de arrasto com toque,
/// mouse e trackpad em Android, Windows Desktop e Web (Chrome/Edge).
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

/// Widget raiz da aplicação "Explore Mundo".
class ExploreMundoApp extends StatelessWidget {
  const ExploreMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo - Agência de Viagens',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExploreMundoHome(),
    );
  }
}

/// Estrutura principal com navegação por abas ([BottomNavigationBar]) e menu
/// lateral ([Drawer]), integrando os modelos de navegação do Tema 2.
class ExploreMundoHome extends StatefulWidget {
  const ExploreMundoHome({super.key});

  @override
  State<ExploreMundoHome> createState() => _ExploreMundoHomeState();
}

class _ExploreMundoHomeState extends State<ExploreMundoHome> {
  final ExploreController _controller = ExploreController();
  int _selectedIndex = 0;

  static const List<String> _titulosAbas = [
    'Explore Mundo',
    'Catálogo de Destinos',
    'Minhas Reservas',
    'Contato & Atendimento',
  ];

  @override
  void initState() {
    super.initState();
    // Carregar dados persistidos com o uso do `shared_preferences`
    _controller.carregarDadosLocais();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selecionarAba(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> paginas = [
      // Aba 0 (Inicial): exibe imediatamente o destino destaque do roteiro
      // oficial (Oeschinen Lake Campground) com interatividade completa.
      DestinoDetalheView(
        controller: _controller,
        destinoId: _controller.destinoDestaque.id,
      ),
      // Aba 1: catálogo pesquisável de destinos da agência.
      DestinosView(controller: _controller),
      // Aba 2: gerenciamento das reservas de pacotes efetuadas.
      ReservasView(
        controller: _controller,
        onExplorarDestinos: () => _selecionarAba(1),
      ),
      // Aba 3: informações institucionais e formulário de contato.
      const ContatoView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulosAbas[_selectedIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.travel_explore, color: Colors.white, size: 42),
                  SizedBox(height: 10),
                  Text(
                    'Explore Mundo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Agência de Viagens • DGT2812',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.landscape_outlined),
              title: const Text('Destaque (Oeschinen Lake)'),
              selected: _selectedIndex == 0,
              onTap: () {
                _selecionarAba(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore_outlined),
              title: const Text('Explorar Destinos'),
              selected: _selectedIndex == 1,
              onTap: () {
                _selecionarAba(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_number_outlined),
              title: const Text('Minhas Reservas'),
              selected: _selectedIndex == 2,
              onTap: () {
                _selecionarAba(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent_outlined),
              title: const Text('Contato'),
              selected: _selectedIndex == 3,
              onTap: () {
                _selecionarAba(3);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: paginas),
      bottomNavigationBar: ListenableBuilder(
        listenable: _controller,
        builder: (BuildContext context, Widget? child) {
          final int totalReservas = _controller.reservas.length;
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _selecionarAba,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.star_outline),
                activeIcon: Icon(Icons.star),
                label: 'Destaque',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Destinos',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: totalReservas > 0,
                  label: Text('$totalReservas'),
                  child: const Icon(Icons.luggage_outlined),
                ),
                activeIcon: Badge(
                  isLabelVisible: totalReservas > 0,
                  label: Text('$totalReservas'),
                  child: const Icon(Icons.luggage),
                ),
                label: 'Reservas',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline),
                activeIcon: Icon(Icons.mail),
                label: 'Contato',
              ),
            ],
          );
        },
      ),
    );
  }
}
