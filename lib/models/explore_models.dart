// Caminho do arquivo: lib/models/explore_models.dart
//
// Camada Model (Arquitetura MVC - Tema 5) do aplicativo "Explore Mundo".
// Inclui serialização/desserialização JSON (Tema 3) para persistência local.

import 'package:flutter/material.dart';

/// Representa uma avaliação publicada por um cliente sobre um destino.
class Avaliacao {
  final String autor;
  final String comentario;
  final int nota;
  final String data;

  const Avaliacao({
    required this.autor,
    required this.comentario,
    required this.nota,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'autor': autor,
    'comentario': comentario,
    'nota': nota,
    'data': data,
  };

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      autor: json['autor'] as String,
      comentario: json['comentario'] as String,
      nota: (json['nota'] as num).toInt(),
      data: json['data'] as String,
    );
  }
}

/// Representa um pacote turístico oferecido pela agência "Explore Mundo".
class PacoteViagem {
  final String id;
  final String titulo;
  final int duracaoDias;
  final double preco;
  final String inclui;

  const PacoteViagem({
    required this.id,
    required this.titulo,
    required this.duracaoDias,
    required this.preco,
    required this.inclui,
  });
}

/// Representa um destino turístico disponível no catálogo da agência.
class Destino {
  final String id;
  final String nome;
  final String localizacao;
  final String descricao;
  final String imagemAsset;
  final Color corFallback;
  final IconData iconeFallback;
  final String telefoneContato;
  final String coordenadas;
  final String instrucoesRota;
  final List<PacoteViagem> pacotes;
  final List<Avaliacao> avaliacoes;
  int contagemEstrelas;
  bool favorito;

  Destino({
    required this.id,
    required this.nome,
    required this.localizacao,
    required this.descricao,
    required this.imagemAsset,
    required this.corFallback,
    required this.iconeFallback,
    required this.telefoneContato,
    required this.coordenadas,
    required this.instrucoesRota,
    required this.pacotes,
    required this.avaliacoes,
    required this.contagemEstrelas,
    this.favorito = false,
  });
}

/// Representa uma reserva de pacote efetuada pelo cliente no aplicativo.
class Reserva {
  final String id;
  final String destinoNome;
  final String pacoteTitulo;
  final String clienteNome;
  final String clienteEmail;
  final int quantidadePessoas;
  final String dataPrevista;
  final double valorTotal;

  const Reserva({
    required this.id,
    required this.destinoNome,
    required this.pacoteTitulo,
    required this.clienteNome,
    required this.clienteEmail,
    required this.quantidadePessoas,
    required this.dataPrevista,
    required this.valorTotal,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'destinoNome': destinoNome,
    'pacoteTitulo': pacoteTitulo,
    'clienteNome': clienteNome,
    'clienteEmail': clienteEmail,
    'quantidadePessoas': quantidadePessoas,
    'dataPrevista': dataPrevista,
    'valorTotal': valorTotal,
  };

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id: json['id'] as String,
      destinoNome: json['destinoNome'] as String,
      pacoteTitulo: json['pacoteTitulo'] as String,
      clienteNome: json['clienteNome'] as String,
      clienteEmail: json['clienteEmail'] as String,
      quantidadePessoas: (json['quantidadePessoas'] as num).toInt(),
      dataPrevista: json['dataPrevista'] as String,
      valorTotal: (json['valorTotal'] as num).toDouble(),
    );
  }
}

/// Utilitário simples para formatação monetária em Real Brasileiro (BRL).
String formatarMoedaBrl(double valor) {
  final String fixo = valor.toStringAsFixed(2);
  final List<String> partes = fixo.split('.');
  final String inteiro = partes[0];
  final String centavos = partes[1];

  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < inteiro.length; i++) {
    final int posicaoReversa = inteiro.length - i;
    buffer.write(inteiro[i]);
    if (posicaoReversa > 1 && posicaoReversa % 3 == 1) {
      buffer.write('.');
    }
  }
  return 'R\$ ${buffer.toString()},$centavos';
}
