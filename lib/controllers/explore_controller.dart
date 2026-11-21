// Caminho do arquivo: lib/controllers/explore_controller.dart
//
// Camada Controller (Arquitetura MVC - Tema 5) do aplicativo "Explore Mundo".
// Gerencia o estado reativo (ChangeNotifier) e a persistência local via
// SharedPreferences + JSON (Tema 3).

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_pratico_dgt2812/models/explore_models.dart';

class ExploreController extends ChangeNotifier {
  static const String _chaveFavoritos = 'explore_mundo_favoritos_v1';
  static const String _chaveAvaliacoes = 'explore_mundo_avaliacoes_v1';
  static const String _chaveReservas = 'explore_mundo_reservas_v1';

  bool _disposed = false;

  final List<Destino> _destinos = [
    Destino(
      id: 'oeschinen',
      nome: 'Oeschinen Lake Campground',
      localizacao: 'Kandersteg, Switzerland',
      descricao:
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      imagemAsset: 'assets/images/lake.jpg',
      corFallback: const Color(0xFF1E6091),
      iconeFallback: Icons.landscape_rounded,
      telefoneContato: '+41 33 675 80 80',
      coordenadas: '46.4989° N, 7.7291° E',
      instrucoesRota:
          'Acesso via trem até a estação Kandersteg, seguido de teleférico '
          'panorâmico (Oeschinensee Gondola) e trilha leve de 30 minutos.',
      contagemEstrelas: 41,
      favorito: true,
      pacotes: const [
        PacoteViagem(
          id: 'pkg_oeschinen_1',
          titulo: 'Expedição Alpes Suíços Essencial',
          duracaoDias: 5,
          preco: 7890.00,
          inclui: 'Hospedagem alpina, passe de teleférico e café da manhã.',
        ),
        PacoteViagem(
          id: 'pkg_oeschinen_2',
          titulo: 'Imersão Kandersteg & Tobogã de Verão',
          duracaoDias: 7,
          preco: 10450.00,
          inclui: 'Hotel 4 estrelas, passeio de barco no lago e guia bilíngue.',
        ),
      ],
      avaliacoes: [
        const Avaliacao(
          autor: 'Camila Andrade',
          comentario:
              'Paisagem inesquecível! A trilha saindo do teleférico é bem '
              'sinalizada e a água azul-turquesa do lago impressiona.',
          nota: 5,
          data: '12/10/2026',
        ),
        const Avaliacao(
          autor: 'Henrique Souza',
          comentario:
              'O atendimento da Explore Mundo facilitou toda a logística de '
              'trens na Suíça. Recomendo o passeio de barco no fim da tarde.',
          nota: 5,
          data: '28/10/2026',
        ),
      ],
    ),
    Destino(
      id: 'chapada',
      nome: 'Parque Nacional da Chapada Diamantina',
      localizacao: 'Lençóis, Bahia - Brasil',
      descricao:
          'Localizada no coração da Bahia, a Chapada Diamantina reúne cânions '
          'monumentais, grutas de águas cristalinas como o Poço Azul e a '
          'Cachoeira da Fumaça, uma das maiores quedas livres do Brasil. '
          'Ideal para ecoturismo, trilhas guiadas e observação da flora '
          'endêmica de campos rupestres.',
      imagemAsset: 'assets/images/chapada.jpg',
      corFallback: const Color(0xFF2D6A4F),
      iconeFallback: Icons.forest_rounded,
      telefoneContato: '+55 (75) 3334-1200',
      coordenadas: '12.5614° S, 41.3900° W',
      instrucoesRota:
          'Voo até o Aeroporto de Lençóis (LEC) ou trajeto rodoviário pela '
          'BR-242 saindo de Salvador (aproximadamente 6 horas).',
      contagemEstrelas: 87,
      favorito: false,
      pacotes: const [
        PacoteViagem(
          id: 'pkg_chapada_1',
          titulo: 'Roteiro Trilhas & Cachoeiras',
          duracaoDias: 4,
          preco: 2650.00,
          inclui: 'Pousada em Lençóis, transfer 4x4 e guia credenciado.',
        ),
        PacoteViagem(
          id: 'pkg_chapada_2',
          titulo: 'Travessia Vale do Pati Completa',
          duracaoDias: 6,
          preco: 4190.00,
          inclui: 'Pensão completa, hospedagem domiciliar e seguro aventura.',
        ),
      ],
      avaliacoes: [
        const Avaliacao(
          autor: 'Fernanda Lima',
          comentario:
              'O pôr do sol no Morro do Pai Inácio foi o ponto alto da viagem.',
          nota: 5,
          data: '04/11/2026',
        ),
      ],
    ),
    Destino(
      id: 'patagonia',
      nome: 'Torres del Paine National Park',
      localizacao: 'Patagônia, Chile',
      descricao:
          'Cartão-postal da Patagônia chilena, o Parque Nacional Torres del '
          'Paine combina picos de granito imponentes, geleiras milenares como '
          'o Glaciar Grey e lagos de coloração esmeralda. Um destino de classe '
          'mundial para trekking, fotografia de natureza e expedições guiadas.',
      imagemAsset: 'assets/images/patagonia.jpg',
      corFallback: const Color(0xFF3A5A78),
      iconeFallback: Icons.terrain_rounded,
      telefoneContato: '+56 61 241 2100',
      coordenadas: '50.9423° S, 73.4068° W',
      instrucoesRota:
          'Conexão aérea até Puerto Natales (PNT) ou Punta Arenas (PUQ), '
          'seguida de traslado terrestre até a portaria Laguna Amarga.',
      contagemEstrelas: 64,
      favorito: false,
      pacotes: const [
        PacoteViagem(
          id: 'pkg_patagonia_1',
          titulo: 'Circuito W Panorâmico',
          duracaoDias: 6,
          preco: 6490.00,
          inclui: 'Refúgios de montanha, navegação no Lago Grey e traslados.',
        ),
      ],
      avaliacoes: [
        const Avaliacao(
          autor: 'Rafael Mendes',
          comentario:
              'Estrutura impecável e vistas surreais dos Cuernos del Paine.',
          nota: 5,
          data: '19/10/2026',
        ),
      ],
    ),
    Destino(
      id: 'kyoto',
      nome: 'Distrito Histórico de Kyoto',
      localizacao: 'Kyoto, Japão',
      descricao:
          'Antiga capital imperial japonesa, Kyoto preserva mais de mil '
          'templos, santuários xintoístas icônicos como Fushimi Inari, jardins '
          'zen e casas tradicionais em Gion. O destino harmoniza tradição '
          'secular, alta gastronomia e mobilidade ferroviária de ponta.',
      imagemAsset: 'assets/images/kyoto.jpg',
      corFallback: const Color(0xFF9B2226),
      iconeFallback: Icons.temple_buddhist_rounded,
      telefoneContato: '+81 75-343-0548',
      coordenadas: '35.0116° N, 135.7681° E',
      instrucoesRota:
          'Chegada pelo Aeroporto Internacional de Kansai (KIX) e trem '
          'expresso Haruka direto para Kyoto Station (75 minutos).',
      contagemEstrelas: 95,
      favorito: false,
      pacotes: const [
        PacoteViagem(
          id: 'pkg_kyoto_1',
          titulo: 'Tradição Imperial & Templos',
          duracaoDias: 8,
          preco: 11800.00,
          inclui: 'Hotel central, Japan Rail Pass regional e tour cultural.',
        ),
      ],
      avaliacoes: [
        const Avaliacao(
          autor: 'Juliana Costa',
          comentario:
              'Caminhar pelos portais torii ao amanhecer é mágico. Organização '
              'nota 10 da equipe Explore Mundo.',
          nota: 5,
          data: '01/11/2026',
        ),
      ],
    ),
  ];

  final List<Reserva> _reservas = [];

  List<Destino> get destinos => List.unmodifiable(_destinos);

  List<Reserva> get reservas => List.unmodifiable(_reservas);

  /// Retorna o destino principal em destaque (Oeschinen Lake Campground).
  Destino get destinoDestaque => _destinos.first;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Restaura favoritos, avaliações e reservas armazenados localmente
  /// via [SharedPreferences] em formato JSON (Tema 3).
  Future<void> carregarDadosLocais() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // 1. Restaurar favoritos e contagem de estrelas
      final String? favoritosJson = prefs.getString(_chaveFavoritos);
      if (favoritosJson != null) {
        final Map<String, dynamic> mapaFavoritos =
            jsonDecode(favoritosJson) as Map<String, dynamic>;
        for (final Destino destino in _destinos) {
          final dynamic estado = mapaFavoritos[destino.id];
          if (estado is Map<String, dynamic>) {
            destino.favorito = estado['favorito'] as bool? ?? destino.favorito;
            destino.contagemEstrelas =
                (estado['contagemEstrelas'] as num?)?.toInt() ??
                destino.contagemEstrelas;
          }
        }
      }

      // 2. Restaurar avaliações por destino
      final String? avaliacoesJson = prefs.getString(_chaveAvaliacoes);
      if (avaliacoesJson != null) {
        final Map<String, dynamic> mapaAvaliacoes =
            jsonDecode(avaliacoesJson) as Map<String, dynamic>;
        for (final Destino destino in _destinos) {
          final dynamic lista = mapaAvaliacoes[destino.id];
          if (lista is List<dynamic>) {
            destino.avaliacoes
              ..clear()
              ..addAll(
                lista.map(
                  (dynamic item) =>
                      Avaliacao.fromJson(item as Map<String, dynamic>),
                ),
              );
          }
        }
      }

      // 3. Restaurar reservas efetuadas
      final String? reservasJson = prefs.getString(_chaveReservas);
      if (reservasJson != null) {
        final List<dynamic> listaReservas =
            jsonDecode(reservasJson) as List<dynamic>;
        _reservas
          ..clear()
          ..addAll(
            listaReservas.map(
              (dynamic item) => Reserva.fromJson(item as Map<String, dynamic>),
            ),
          );
      }

      if (!_disposed) {
        notifyListeners();
      }
    } catch (erro) {
      debugPrint('Aviso ao carregar persistência local: $erro');
    }
  }

  /// Serializa e grava o estado atual no armazenamento local do dispositivo.
  Future<void> _salvarDadosLocais() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final mapaFavoritos = {
        for (final Destino d in _destinos)
          d.id: {
            'favorito': d.favorito,
            'contagemEstrelas': d.contagemEstrelas,
          },
      };

      final mapaAvaliacoes = {
        for (final Destino d in _destinos)
          d.id: d.avaliacoes.map((Avaliacao a) => a.toJson()).toList(),
      };

      final listaReservas = _reservas.map((Reserva r) => r.toJson()).toList();

      await prefs.setString(_chaveFavoritos, jsonEncode(mapaFavoritos));
      await prefs.setString(_chaveAvaliacoes, jsonEncode(mapaAvaliacoes));
      await prefs.setString(_chaveReservas, jsonEncode(listaReservas));
    } catch (erro) {
      debugPrint('Aviso ao salvar persistência local: $erro');
    }
  }

  /// Busca um destino pelo identificador único.
  Destino obterDestinoPorId(String id) {
    return _destinos.firstWhere(
      (destino) => destino.id == id,
      orElse: () => _destinos.first,
    );
  }

  /// Filtra destinos por texto (nome ou localização) e opcionalmente favoritos.
  List<Destino> filtrarDestinos({
    String termo = '',
    bool apenasFavoritos = false,
  }) {
    final String consulta = termo.trim().toLowerCase();
    return _destinos.where((destino) {
      final bool correspondeTexto =
          consulta.isEmpty ||
          destino.nome.toLowerCase().contains(consulta) ||
          destino.localizacao.toLowerCase().contains(consulta);
      final bool correspondeFavorito = !apenasFavoritos || destino.favorito;
      return correspondeTexto && correspondeFavorito;
    }).toList();
  }

  /// Alterna o estado de favorito de um destino e persiste a alteração.
  bool alternarFavorito(String destinoId) {
    final Destino destino = obterDestinoPorId(destinoId);
    destino.favorito = !destino.favorito;
    destino.contagemEstrelas += destino.favorito ? 1 : -1;
    notifyListeners();
    unawaited(_salvarDadosLocais());
    return destino.favorito;
  }

  /// Adiciona um novo comentário/avaliação e persiste a alteração.
  void adicionarAvaliacao(String destinoId, Avaliacao avaliacao) {
    final Destino destino = obterDestinoPorId(destinoId);
    destino.avaliacoes.insert(0, avaliacao);
    notifyListeners();
    unawaited(_salvarDadosLocais());
  }

  /// Registra uma nova reserva de pacote de viagem e persiste a alteração.
  void registrarReserva(Reserva reserva) {
    _reservas.insert(0, reserva);
    notifyListeners();
    unawaited(_salvarDadosLocais());
  }

  /// Cancela uma reserva existente pelo seu identificador e persiste a alteração.
  void cancelarReserva(String reservaId) {
    _reservas.removeWhere((reserva) => reserva.id == reservaId);
    notifyListeners();
    unawaited(_salvarDadosLocais());
  }
}
