import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Fonction qui envoie les données vers Webhook.site
Future<http.Response> envoyerVersWebhook({
  required String prenom,
  required String nom,
  required String email,
}) async {
  final url = Uri.parse(
    'https://webhook.site/a9a0df00-298a-45b8-83b2-682a1faf84e8',
  );

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"prenom": prenom, "nom": nom, "email": email}),
  );

  print("✅ Webhook réponse : ${response.statusCode} - ${response.body}");
  return response;
}

void main() {
  test("Envoi vers Webhook.site et vérification", () async {
    final response = await envoyerVersWebhook(
      prenom: "Léane",
      nom: "Yvanna",
      email: "leane@email.com",
    );

    // Vérifie que le serveur a bien répondu
    expect(response.statusCode, anyOf([200, 201]));
  });
}
