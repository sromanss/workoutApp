import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = 'Italiano';

  final Map<String, String> _languages = {
    'Italiano': 'it',
    'English': 'en',
    'Español': 'es',
    'Français': 'fr',
    'Deutsch': 'de',
  };
  

  void _applyLanguageChange() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lingua Selezionata'),
        content: Text(
          'Hai selezionato: $_selectedLanguage\n\nLa localizzazione completa sarà implementata in una versione futura.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text('Selezione Lingua'),
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  ),
  body: ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: _languages.length,
    itemBuilder: (context, index) {
      // …il tuo ListView.builder…
    },
  ),
  bottomNavigationBar: SafeArea(
    minimum: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Nota: La localizzazione completa sarà implementata in una versione futura dell\'app.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _applyLanguageChange,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Applica Modifiche'),
          ),
        ),
      ],
    ),
  ),
);
  }
}
