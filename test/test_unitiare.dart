import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  test('Retourne "Merci prénom nom" si tout est valide', () {
    expect(
      genererMessage('Leane', 'Yvanna', 'leane@email.com', '24'),
      'Merci Leane Yvanna',
    );
  });
  test('Retourne erreur si un champ est vide', () {
    expect(
      genererMessage('', 'Yvanna', 'leane@email.com', '24'),
      'Champs requis',
    );
    expect(
      genererMessage('Leane', '', 'leane@email.com', '24'),
      'Champs requis',
    );
    expect(genererMessage('Leane', 'Yvanna', '', '24'), 'Champs requis');
    expect(
      genererMessage('Leane', 'Yvanna', 'leane@email.com', ''),
      'Champs requis',
    );
  });

  test('Retourne erreur si email invalide', () {
    expect(
      genererMessage('Leane', 'Yvanna', 'leanemail.com', '24'),
      'Email invalide',
    );
  });
}
