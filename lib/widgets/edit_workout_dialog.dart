import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';

class EditWorkoutDialog extends StatefulWidget {
  final Workout workout;

  const EditWorkoutDialog({Key? key, required this.workout}) : super(key: key);

  @override
  State<EditWorkoutDialog> createState() => _EditWorkoutDialogState();
}

class _EditWorkoutDialogState extends State<EditWorkoutDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _difficulty;
  late int _duration;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.workout.title);
    _descriptionController =
        TextEditingController(text: widget.workout.description);
    _difficulty = widget.workout.difficulty;
    _duration = widget.workout.duration;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifica allenamento'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titolo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Inserisci un titolo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _difficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficoltà',
                  border: OutlineInputBorder(),
                ),
                items: ['Facile', 'Media', 'Difficile'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _difficulty = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleziona una difficoltà';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _duration.toString(),
                decoration: const InputDecoration(
                  labelText: 'Durata (minuti)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una durata';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Inserisci un numero valido';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (int.tryParse(value) != null) {
                    _duration = int.parse(value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Salva'),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Crea una copia dell'allenamento con i dati aggiornati
      final updatedWorkout = Workout(
        id: widget.workout.id,
        title: _titleController.text,
        description: _descriptionController.text,
        difficulty: _difficulty,
        duration: _duration,
        exercises: widget.workout.exercises,
        createdBy: widget.workout.createdBy,
        isRecommended: widget.workout.isRecommended,
        createdAt: widget.workout.createdAt,
      );

      final workoutProvider =
          Provider.of<WorkoutProvider>(context, listen: false);
      final success = await workoutProvider.updateWorkout(updatedWorkout);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? 'Allenamento aggiornato con successo'
                : 'Errore durante l\'aggiornamento: ${workoutProvider.errorMessage}'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }
}
