// Caminho do arquivo: lib/views/reservas_view.dart
//
// View para consulta e cancelamento das reservas efetuadas pelo cliente.

import 'package:flutter/material.dart';
import 'package:trabalho_pratico_dgt2812/controllers/explore_controller.dart';
import 'package:trabalho_pratico_dgt2812/models/explore_models.dart';

class ReservasView extends StatefulWidget {
  final ExploreController controller;
  final VoidCallback onExplorarDestinos;

  const ReservasView({
    super.key,
    required this.controller,
    required this.onExplorarDestinos,
  });

  @override
  State<ReservasView> createState() => _ReservasViewState();
}

class _ReservasViewState extends State<ReservasView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _confirmarCancelamento(Reserva reserva) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cancelar Reserva'),
          content: Text(
            'Deseja cancelar a reserva do pacote "${reserva.pacoteTitulo}" '
            'para ${reserva.destinoNome}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Manter'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                widget.controller.cancelarReserva(reserva.id);
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Reserva cancelada com sucesso.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              },
              child: const Text('Cancelar Reserva'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (BuildContext context, Widget? child) {
        final List<Reserva> reservas = widget.controller.reservas;

        if (reservas.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.luggage_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhuma reserva registrada ainda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore os destinos da agência e escolha um pacote para '
                    'efetuar sua primeira reserva.',
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: widget.onExplorarDestinos,
                    icon: const Icon(Icons.explore_outlined),
                    label: const Text('Explorar Destinos'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          interactive: true,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            itemCount: reservas.length,
            itemBuilder: (BuildContext context, int index) {
              final Reserva reserva = reservas[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number_outlined,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              reserva.pacoteTitulo,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Cancelar reserva',
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade600,
                            ),
                            onPressed: () => _confirmarCancelamento(reserva),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text('Destino: ${reserva.destinoNome}'),
                      Text(
                        'Cliente: ${reserva.clienteNome} (${reserva.clienteEmail})',
                      ),
                      Text(
                        'Embarque previsto: ${reserva.dataPrevista} • '
                        '${reserva.quantidadePessoas} viajante(s)',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: ${formatarMoedaBrl(reserva.valorTotal)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
