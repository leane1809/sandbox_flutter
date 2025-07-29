import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

//fonction pour la gestion de l'email
String genererMessage(String prenom, String nom, String email, String age) {
  if (prenom.isEmpty || nom.isEmpty || email.isEmpty || age.isEmpty) {
    return 'Champs requis';
  }
  if (!email.contains('@')) {
    return 'Email invalide';
  }
  final parsedAge = int.tryParse(age);
  if (parsedAge == null || parsedAge < 0) {
    return 'Âge invalide';
  }
  return 'Merci $prenom $nom';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leane Sandbox',
      home: Scaffold(
        backgroundColor: Color(0xFFF2A2A2A2),
        body: Center(child: FormulaireWidget()),
      ),
    );
  }
}

class FormulaireWidget extends StatefulWidget {
  @override
  _FormulaireWidgetState createState() => _FormulaireWidgetState();
}

class _FormulaireWidgetState extends State<FormulaireWidget> {
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  String _message = '';
  bool afficherOK = false;

  void _envoyer() async {
    String prenom = _prenomController.text.trim();
    String nom = _nomController.text.trim();
    String email = _emailController.text.trim();
    String age = _ageController.text.trim();

    String resultat = genererMessage(prenom, nom, email, age);

    if (resultat == 'Champs requis' ||
        resultat == 'Email invalide' ||
        resultat == 'Âge invalide') {
      _afficherErreur(context, resultat);
      return;
    }

    setState(() {
      _message = resultat;
      afficherOK = true;
    });

    await envoyerDonnees(prenom, nom, email);
  }

  void _afficherErreur(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _okAction() {
    setState(() {
      _message = '';
      afficherOK = false;
      _prenomController.clear();
      _nomController.clear();
      _emailController.clear();
      _ageController.clear();
    });
  }

  Future<void> envoyerDonnees(String prenom, String nom, String email) async {
    await http.post(
      Uri.parse('https://webhook.site/a9a0df00-298a-45b8-83b2-682a1faf84e8'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prenom': prenom, 'nom': nom, 'email': email}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  size: 28,
                ), // L’icône
                SizedBox(width: 10), // Espace entre l’icône et le texte
                Text(
                  'FORMULAIRE',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          _buildChamp('Prénom', _prenomController),
          SizedBox(height: 16),
          _buildChamp('Nom', _nomController),
          SizedBox(height: 16),
          _buildChamp('Email', _emailController),
          SizedBox(height: 24),
          _buildChamp('Age', _ageController),
          SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _envoyer,
              child: Text('Envoyer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          if (_message.isNotEmpty) ...[
            SizedBox(height: 20),
            Center(child: Text(_message)),
          ],
          if (afficherOK)
            Center(
              child: ElevatedButton(
                onPressed: _okAction,
                child: Text('OK'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChamp(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: label == 'Age'
              ? TextInputType.number
              : TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Entrez votre $label',
          ),
        ),
      ],
    );
  }
}
