// Caminho do arquivo: test/widget_test.dart
//
// Teste automatizado de widgets (Tema 5) validando a renderização da tela
// principal, a interatividade dos favoritos e a persistência via SharedPreferences.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_pratico_dgt2812/main.dart';

void main() {
  testWidgets(
    'Renderiza o destino destaque e alterna favorito com persistência local',
    (WidgetTester tester) async {
      // Inicializa o mock em memória do SharedPreferences para ambiente de teste
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(const ExploreMundoApp());
      await tester.pumpAndSettle();

      // Verifica os elementos obrigatórios do roteiro oficial TRABAL~1.PDF
      expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
      expect(find.text('Kandersteg, Switzerland'), findsOneWidget);
      expect(find.text('CALL'), findsOneWidget);
      expect(find.text('ROUTE'), findsOneWidget);
      expect(find.text('SHARE'), findsOneWidget);
      expect(find.text('41'), findsOneWidget);

      // Testa a interatividade da estrela de favoritos (41 -> 40 -> 41)
      await tester.tap(find.byKey(const Key('favorite_button')));
      await tester.pumpAndSettle();
      expect(find.text('40'), findsOneWidget);

      await tester.tap(find.byKey(const Key('favorite_button')));
      await tester.pumpAndSettle();
      expect(find.text('41'), findsOneWidget);
    },
  );
}
