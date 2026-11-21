// Caminho do arquivo: lib/views/destino_detalhe_view.dart
//
// View principal do destino turístico do aplicativo "Explore Mundo".
// Preserva integralmente a estrutura exigida no roteiro oficial TRABAL~1.PDF
// (Image.asset, titleSection, buttonSection com _buildButtonColumn, textSection
// e ListView) enriquecida com interatividade aderente à agência de viagens.

import 'package:flutter/material.dart';
import 'package:trabalho_pratico_dgt2812/controllers/explore_controller.dart';
import 'package:trabalho_pratico_dgt2812/models/explore_models.dart';

class DestinoDetalheView extends StatefulWidget {
  final ExploreController controller;
  final String destinoId;
  final bool exibirAppBar;

  const DestinoDetalheView({
    super.key,
    required this.controller,
    required this.destinoId,
    this.exibirAppBar = false,
  });

  @override
  State<DestinoDetalheView> createState() => _DestinoDetalheViewState();
}

class _DestinoDetalheViewState extends State<DestinoDetalheView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Constrói cada coluna interativa da seção de botões (CALL, ROUTE, SHARE).
  /// Segue a modularização proposta pelo roteiro oficial com [Column], [Icon]
  /// e [Text], encapsulada em [InkWell] para resposta tátil e ações reais.
  Widget _buildButtonColumn(
    Color color,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Exibe feedback discreto na parte inferior da tela.
  void _exibirSnackBar(String mensagem, {Color? cor}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(mensagem),
          backgroundColor: cor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
  }

  /// Ação do botão CALL: exibe informações de atendimento direto da agência.
  void _abrirDialogoContatoRapido(Destino destino) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.support_agent_rounded, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(child: Text('Central Explore Mundo')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atendimento especializado para ${destino.nome}:',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text('• Telefone local/destino: ${destino.telefoneContato}'),
              const Text('• Central Brasil: 0800 770 2812'),
              const Text('• WhatsApp 24h: +55 (31) 99999-2812'),
              const SizedBox(height: 8),
              const Text(
                'Horário: Segunda a Sábado, das 08h às 20h.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Fechar'),
            ),
            // Nota de compatibilidade Flutter 3.x+: ElevatedButton substitui
            // o antigo RaisedButton citado nos objetivos gerais do PDF.
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _exibirSnackBar(
                  'Ligação simulada iniciada para ${destino.telefoneContato}.',
                  cor: Colors.blue.shade700,
                );
              },
              icon: const Icon(Icons.call),
              label: const Text('Ligar Agora'),
            ),
          ],
        );
      },
    );
  }

  /// Ação do botão ROUTE: exibe localização geográfica e instruções de acesso.
  void _abrirDialogoRota(Destino destino) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.map_outlined, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(child: Text('Rota e Localização')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destino.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                destino.localizacao,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Divider(height: 20),
              Text('Coordenadas GPS: ${destino.coordenadas}'),
              const SizedBox(height: 10),
              const Text(
                'Como chegar:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(destino.instrucoesRota),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Fechar'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _exibirSnackBar(
                  'Rota traçada para ${destino.nome} (${destino.coordenadas}).',
                  cor: Colors.teal.shade700,
                );
              },
              icon: const Icon(Icons.directions),
              label: const Text('Iniciar Navegação'),
            ),
          ],
        );
      },
    );
  }

  /// Abre diálogo com formulário validado para efetuar reserva de um pacote.
  void _abrirDialogoReserva(Destino destino, PacoteViagem pacote) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String clienteNome = '';
    String clienteEmail = '';
    String dataPrevista = '15/01/2027';
    int quantidadePessoas = 2;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setDialogState) {
            final double total = pacote.preco * quantidadePessoas;
            return AlertDialog(
              title: Text('Reservar: ${pacote.titulo}'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${destino.nome} • ${pacote.duracaoDias} dias',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? valor) {
                          if (valor == null || valor.trim().length < 3) {
                            return 'Informe seu nome completo.';
                          }
                          return null;
                        },
                        onSaved: (String? valor) => clienteNome = valor!.trim(),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'E-mail de confirmação',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? valor) {
                          if (valor == null || !valor.contains('@')) {
                            return 'Informe um e-mail válido.';
                          }
                          return null;
                        },
                        onSaved: (String? valor) =>
                            clienteEmail = valor!.trim(),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: dataPrevista,
                        decoration: const InputDecoration(
                          labelText: 'Data prevista (DD/MM/AAAA)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? valor) {
                          if (valor == null || valor.trim().length < 8) {
                            return 'Informe uma data válida.';
                          }
                          return null;
                        },
                        onSaved: (String? valor) =>
                            dataPrevista = valor!.trim(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Viajantes:'),
                          Row(
                            children: [
                              IconButton(
                                onPressed: quantidadePessoas > 1
                                    ? () => setDialogState(
                                        () => quantidadePessoas--,
                                      )
                                    : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                '$quantidadePessoas',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: quantidadePessoas < 10
                                    ? () => setDialogState(
                                        () => quantidadePessoas++,
                                      )
                                    : null,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        'Total estimado: ${formatarMoedaBrl(total)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final Reserva novaReserva = Reserva(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        destinoNome: destino.nome,
                        pacoteTitulo: pacote.titulo,
                        clienteNome: clienteNome,
                        clienteEmail: clienteEmail,
                        quantidadePessoas: quantidadePessoas,
                        dataPrevista: dataPrevista,
                        valorTotal: total,
                      );
                      widget.controller.registrarReserva(novaReserva);
                      Navigator.of(dialogContext).pop();
                      _exibirSnackBar(
                        'Reserva confirmada! Consulte na aba "Reservas".',
                        cor: Colors.green.shade700,
                      );
                    }
                  },
                  child: const Text('Confirmar Reserva'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Abre diálogo para o cliente compartilhar sua avaliação e comentário.
  void _abrirDialogoNovaAvaliacao(Destino destino) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String autor = '';
    String comentario = '';
    int notaSelecionada = 5;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Avaliar Experiência'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Seu nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Digite seu nome.';
                          }
                          return null;
                        },
                        onSaved: (String? valor) => autor = valor!.trim(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(5, (int index) {
                          final int estrela = index + 1;
                          return IconButton(
                            icon: Icon(
                              estrela <= notaSelecionada
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber.shade700,
                            ),
                            onPressed: () {
                              setDialogState(() => notaSelecionada = estrela);
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Comentário sobre o destino',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? valor) {
                          if (valor == null || valor.trim().length < 5) {
                            return 'Escreva um breve comentário.';
                          }
                          return null;
                        },
                        onSaved: (String? valor) => comentario = valor!.trim(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final DateTime hoje = DateTime.now();
                      final String dataFormatada =
                          '${hoje.day.toString().padLeft(2, '0')}/'
                          '${hoje.month.toString().padLeft(2, '0')}/'
                          '${hoje.year}';
                      widget.controller.adicionarAvaliacao(
                        destino.id,
                        Avaliacao(
                          autor: autor,
                          comentario: comentario,
                          nota: notaSelecionada,
                          data: dataFormatada,
                        ),
                      );
                      Navigator.of(dialogContext).pop();
                      _exibirSnackBar(
                        'Obrigado! Sua avaliação foi publicada.',
                        cor: Colors.green.shade700,
                      );
                    }
                  },
                  child: const Text('Publicar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Renderiza o banner principal utilizando [Image.asset] com [errorBuilder]
  /// visual elegante caso o arquivo ainda não tenha sido copiado para assets.
  Widget _buildBannerImagem(Destino destino) {
    return Image.asset(
      destino.imagemAsset,
      width: double.infinity,
      height: 240,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
            return Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    destino.corFallback,
                    destino.corFallback.withValues(alpha: 0.72),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(destino.iconeFallback, size: 72, color: Colors.white),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      destino.nome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destino.localizacao,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    final Widget conteudo = ListenableBuilder(
      listenable: widget.controller,
      builder: (BuildContext context, Widget? child) {
        final Destino destino = widget.controller.obterDestinoPorId(
          widget.destinoId,
        );

        // 1. Seção de Título (titleSection) conforme o roteiro oficial:
        // Container(padding: EdgeInsets.all(32)) -> Row -> Expanded + Estrela
        final Widget titleSection = Container(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        destino.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      destino.localizacao,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              // Estrela interativa de favoritos/avaliação
              InkWell(
                key: const Key('favorite_button'),
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  final bool agoraFavorito = widget.controller.alternarFavorito(
                    destino.id,
                  );
                  _exibirSnackBar(
                    agoraFavorito
                        ? '${destino.nome} adicionado aos favoritos!'
                        : '${destino.nome} removido dos favoritos.',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        destino.favorito ? Icons.star : Icons.star_border,
                        color: Colors.red[500],
                      ),
                      const SizedBox(width: 4),
                      Text('${destino.contagemEstrelas}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        // 2. Seção de Botões (buttonSection) conforme o roteiro oficial:
        // Row(MainAxisAlignment.spaceEvenly) utilizando _buildButtonColumn
        final Widget buttonSection = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(
              primaryColor,
              Icons.call,
              'CALL',
              () => _abrirDialogoContatoRapido(destino),
            ),
            _buildButtonColumn(
              primaryColor,
              Icons.near_me,
              'ROUTE',
              () => _abrirDialogoRota(destino),
            ),
            _buildButtonColumn(
              primaryColor,
              Icons.share,
              'SHARE',
              () => _exibirSnackBar(
                'Link de "${destino.nome}" (${destino.localizacao}) '
                'pronto para compartilhamento!',
                cor: Colors.blue.shade700,
              ),
            ),
          ],
        );

        // 3. Seção de Texto Descritivo (textSection) conforme o roteiro oficial
        final Widget textSection = Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            destino.descricao,
            softWrap: true,
            style: const TextStyle(height: 1.45),
          ),
        );

        // 4. Seção de Pacotes de Viagem (contextualização "Explore Mundo")
        final Widget pacotesSection = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pacotes Disponíveis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...destino.pacotes.map((PacoteViagem pacote) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                pacote.titulo,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text('${pacote.duracaoDias} dias'),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          pacote.inclui,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${formatarMoedaBrl(pacote.preco)} / pessoa',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _abrirDialogoReserva(destino, pacote),
                              icon: const Icon(Icons.event_available, size: 18),
                              label: const Text('Reservar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );

        // 5. Seção de Avaliações e Comentários de Clientes
        final Widget avaliacoesSection = Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Avaliações (${destino.avaliacoes.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _abrirDialogoNovaAvaliacao(destino),
                    icon: const Icon(Icons.rate_review_outlined, size: 18),
                    label: const Text('Avaliar'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...destino.avaliacoes.map((Avaliacao avaliacao) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primaryColor.withValues(alpha: 0.15),
                      child: Text(
                        avaliacao.autor.isNotEmpty
                            ? avaliacao.autor[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            avaliacao.autor,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber.shade700,
                            ),
                            const SizedBox(width: 2),
                            Text('${avaliacao.nota}.0'),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(avaliacao.comentario),
                          const SizedBox(height: 4),
                          Text(
                            avaliacao.data,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );

        // Uso obrigatório de ListView (Passo 9 do roteiro TRABAL~1.PDF)
        // garantindo rolagem fluida em dispositivos móveis, tablets e desktop.
        return Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          interactive: true,
          child: ListView(
            controller: _scrollController,
            children: [
              _buildBannerImagem(destino),
              titleSection,
              buttonSection,
              textSection,
              const Divider(indent: 24, endIndent: 24),
              pacotesSection,
              const Divider(indent: 24, endIndent: 24),
              avaliacoesSection,
            ],
          ),
        );
      },
    );

    if (!widget.exibirAppBar) {
      return conteudo;
    }

    final Destino destinoAtual = widget.controller.obterDestinoPorId(
      widget.destinoId,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(destinoAtual.nome),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: conteudo,
    );
  }
}
