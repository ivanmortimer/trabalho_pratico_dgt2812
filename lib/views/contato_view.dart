// Caminho do arquivo: lib/views/contato_view.dart
//
// View de atendimento da agência "Explore Mundo" com formulário validado.

import 'package:flutter/material.dart';

class ContatoView extends StatefulWidget {
  const ContatoView({super.key});

  @override
  State<ContatoView> createState() => _ContatoViewState();
}

class _ContatoViewState extends State<ContatoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  void _enviarMensagem() {
    if (_formKey.currentState!.validate()) {
      final String nome = _nomeController.text.trim();
      _nomeController.clear();
      _emailController.clear();
      _mensagemController.clear();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Mensagem enviada, $nome! Nossa equipe responderá em breve.',
            ),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      interactive: true,
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20.0),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.travel_explore, color: Colors.blue, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'Agência Explore Mundo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 24),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.phone_outlined, color: Colors.blue),
                    title: Text('Central: 0800 770 2812'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.email_outlined, color: Colors.blue),
                    title: Text('contato@exploremundo.com.br'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.schedule_outlined, color: Colors.blue),
                    title: Text('Seg a Sáb • 08:00 às 20:00'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Fale com nossa equipe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (String? valor) {
                    if (valor == null || valor.trim().length < 3) {
                      return 'Informe seu nome completo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (String? valor) {
                    if (valor == null || !valor.contains('@')) {
                      return 'Informe um endereço de e-mail válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mensagemController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Dúvida, orçamento ou sugestão de roteiro',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? valor) {
                    if (valor == null || valor.trim().length < 10) {
                      return 'Escreva uma mensagem com pelo menos 10 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _enviarMensagem,
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Enviar Mensagem'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
