import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManagementPage extends StatefulWidget {
  const DataManagementPage({super.key});

  @override
  State<DataManagementPage> createState() => _DataManagementPageState();
}

class _DataManagementPageState extends State<DataManagementPage> {
  final TextEditingController _backupController = TextEditingController();

  bool _isSaving = false;
  bool _isSyncing = false;

  String? _lastBackupName;
  DateTime? _lastBackupTime;
  String? _lastSyncTime;

  @override
  void initState() {
    super.initState();
    _loadLastBackupInfo();
  }

  @override
  void dispose() {
    _backupController.dispose();
    super.dispose();
  }

  Future<void> _loadLastBackupInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastBackupName = prefs.getString('backup_name');
      final backupTimestamp = prefs.getInt('backup_time');
      _lastBackupTime = backupTimestamp != null ? DateTime.fromMillisecondsSinceEpoch(backupTimestamp) : null;
      _lastSyncTime = prefs.getString('sync_time');
    });
  }

  Future<void> _saveBackup() async {
    final backupName = _backupController.text.trim();
    if (backupName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inserisci un nome per il backup')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Simula salvataggio dati locali
      final prefs = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 1)); // simula delay

      // Salva nome e timestamp backup
      await prefs.setString('backup_name', backupName);
      await prefs.setInt('backup_time', DateTime.now().millisecondsSinceEpoch);

      setState(() {
        _lastBackupName = backupName;
        _lastBackupTime = DateTime.now();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup salvato con successo!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante il backup: $e')),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _syncData() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      // Simula sincronizzazione dati col server
      await Future.delayed(const Duration(seconds: 2)); // simula delay

      final prefs = await SharedPreferences.getInstance();
      final syncTime = DateTime.now().toLocal().toString();
      await prefs.setString('sync_time', syncTime);

      setState(() {
        _lastSyncTime = syncTime;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sincronizzazione completata!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante la sincronizzazione: $e')),
      );
    } finally {
      setState(() {
        _isSyncing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestione Dati'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Backup e sincronizzazione dei dati personali.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _backupController,
              decoration: const InputDecoration(
                labelText: 'Nome backup',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.backup),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _isSaving ? null : _saveBackup,
              icon: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save),
              label: const Text('Salva Backup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 12),

            if (_lastBackupName != null && _lastBackupTime != null)
              Text(
                'Ultimo backup: $_lastBackupName alle ${_lastBackupTime!.toLocal()}',
                style: TextStyle(color: Colors.grey[700]),
              ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _isSyncing ? null : _syncData,
              icon: _isSyncing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.sync),
              label: const Text('Sincronizza dati'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 12),

            if (_lastSyncTime != null)
              Text(
                'Ultima sincronizzazione: $_lastSyncTime',
                style: TextStyle(color: Colors.grey[700]),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
