import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leanesandbox/main.dart';

void main() {
  testWidgets('Affiche "Merci Leane Yvanna" après soumission', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'Leane');
    await tester.enterText(find.byType(TextField).at(1), 'Yvanna');
    await tester.enterText(find.byType(TextField).at(2), 'leane@email.com');

    await tester.tap(find.text('Envoyer'));
    await tester.pump();

    expect(find.text('Merci Leane Yvanna'), findsOneWidget);

    /*await tester.tap(find.text('Ok'));
    await tester.pump();

    expect(find.widgetWithText(TextField, ''), findsNWidgets(3));

    expect(find.text('Merci Leane Yvanna'), findsNothing);*/
  });
  /*testWidgets('mise a jour du formulaire apres clic sur le bouton Ok', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'Leane');
    await tester.enterText(find.byType(TextField).at(1), 'Yvanna');
    await tester.enterText(find.byType(TextField).at(2), 'leane@email.com');

    await tester.tap(find.text('Envoyer'));
    await tester.pump();

    expect(find.text('Merci Leane Yvanna'), findsOneWidget);

    await tester.tap(find.text('Ok'));
    await tester.pump();

    expect(find.widgetWithText(TextField, ''), findsNWidgets(3));

    expect(find.text('Merci Leane Yvanna'), findsNothing);
  });*/
}
