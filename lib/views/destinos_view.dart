// Caminho do arquivo: lib/views/destinos_view.dart
//
// View de exploração e busca de múltiplos destinos turísticos.
// Aplica ListView.builder, filtros dinâmicos e navegação via Navigator.push
// conforme abordado no Tema 2 da disciplina DGT2812.

import 'package:flutter/material.dart';
import 'package:trabalho_pratico_dgt2812/controllers/explore_controller.dart';
import 'package:trabalho_pratico_dgt2812/models/explore_models.dart';
import 'package:trabalho_pratico_dgt2812/views/destino_detalhe_view.dart';

class DestinosView extends StatefulWidget {
  final ExploreController controller;

  const DestinosView({super.key, required this.controller});

  @override
  State<DestinosView> createState() => _DestinosViewState();
}

class _DestinosViewState extends State<DestinosView> {
  final TextEditingController _buscaController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _termoBusca = '';
  bool _apenasFavoritos = false;

  @override
  void dispose() {
    _buscaController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (BuildContext context, Widget? child) {
        final List<Destino> destinosFiltrados = widget.controller
            .filtrarDestinos(
              termo: _termoBusca,
              apenasFavoritos: _apenasFavoritos,
            );

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: TextField(
                controller: _buscaController,
                decoration: InputDecoration(
                  hintText: 'Buscar destino ou país...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _termoBusca.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _buscaController.clear();
                            setState(() => _termoBusca = '');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onChanged: (String valor) =>
                    setState(() => _termoBusca = valor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Apenas favoritos'),
                    selected: _apenasFavoritos,
                    avatar: Icon(
                      _apenasFavoritos ? Icons.star : Icons.star_border,
                      size: 18,
                      color: Colors.red[500],
                    ),
                    onSelected: (bool selecionado) {
                      setState(() => _apenasFavoritos = selecionado);
                    },
                  ),
                  const Spacer(),
                  Text(
                    '${destinosFiltrados.length} destino(s)',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: destinosFiltrados.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'Nenhum destino encontrado para o filtro aplicado.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      interactive: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        itemCount: destinosFiltrados.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Destino destino = destinosFiltrados[index];
                          final double menorPreco = destino.pacotes
                              .map((PacoteViagem p) => p.preco)
                              .reduce((double a, double b) => a < b ? a : b);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        DestinoDetalheView(
                                          controller: widget.controller,
                                          destinoId: destino.id,
                                          exibirAppBar: true,
                                        ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 112,
                                    height: 112,
                                    child: Image.asset(
                                      destino.imagemAsset,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace,
                                          ) {
                                            return Container(
                                              color: destino.corFallback,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                destino.iconeFallback,
                                                color: Colors.white,
                                                size: 38,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            destino.nome,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            destino.localizacao,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'A partir de ${formatarMoedaBrl(menorPreco)}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    destino.favorito
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    size: 16,
                                                    color: Colors.red[500],
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    '${destino.contagemEstrelas}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
