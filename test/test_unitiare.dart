import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  test('Retourne "Merci prénom nom" si tout est valide', () {
    expect(
      genererMessage('Leane', 'Yvanna', 'leane@email.com'),
      'Merci Leane Yvanna',
    );
  });

  test('Retourne erreur si un champ est vide', () {
    expect(genererMessage('', 'Yvanna', 'leane@email.com'), 'Champs requis');
    expect(genererMessage('Leane', '', 'leane@email.com'), 'Champs requis');
    expect(genererMessage('Leane', 'Yvanna', ''), 'Champs requis');
  });

  test('Retourne erreur si email invalide', () {
    expect(
      genererMessage('Leane', 'Yvanna', 'leanemail.com'),
      'Email invalide',
    );
  });
}
