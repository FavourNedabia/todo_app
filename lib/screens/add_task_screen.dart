import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/task_service.dart';


class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Clé globale pour le formulaire
  final formKey = GlobalKey<FormState>();

  // Contrôleur de texte pour le champ de titre de la tâche
  final TextEditingController _titleController = TextEditingController();

  // Booléen pour indiquer si la tâche est urgente
  bool _isUrgent = false;

  // Liste des catégories avec des emojis
  final List<String> categories = [
    '💼',
    '💊',
    '💸',
    '👛',
    '🤷‍♀️',
    '🧼',
  ];

  // Index de la catégorie sélectionnée
  int _selectedCategoryIndex = 0;

  @override
  void dispose() {
    // Libération des ressources du contrôleur de texte
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter TODO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey, // Assignation de la clé au formulaire
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySelector(), // Construction du sélecteur de catégorie
                const SizedBox(height: 20),
                _buildTitleField(), // Construction du champ de titre de la tâche
                const SizedBox(height: 20),
                _buildUrgentCheckbox(), // Construction de la case à cocher pour l'urgence
                const SizedBox(height: 20),
                _buildAddButton(), // Construction du bouton d'ajout de la tâche
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour construire le sélecteur de catégorie
  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez votre catégorie :',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: categories.map((emoji) {
            int index = categories.indexOf(emoji);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index; // Mise à jour de l'index de la catégorie sélectionnée
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedCategoryIndex == index ? Colors.blue : Colors.grey, // Couleur de fond basée sur la sélection
                ),
                child: Text(
                  emoji, // Affichage de l'emoji
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget pour construire le champ de texte du titre de la tâche
  Widget _buildTitleField() {
    return Row(
      children: [
        const Text(
          'Quelle tache avez vous à effecter :',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const Icon(
          Icons.task_alt_outlined,
          size: 35,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 90,
            child: TextFormField(
              controller: _titleController, // Assignation du contrôleur de texte
              decoration: InputDecoration(
                labelText: "Nom de tâche",
                hintText: "Tâche",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre'; // Validation du champ de texte
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  // Widget pour construire la case à cocher d'urgence de la tâche
  Widget _buildUrgentCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isUrgent, // Valeur de la case à cocher
          onChanged: (bool? value) {
            setState(() {
              _isUrgent = value ?? false; // Mise à jour de l'état d'urgence
            });
          },
          activeColor: Colors.blue,
        ),
        const SizedBox(width: 16),
        const Text(
          'La tâche est urgente',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const Icon(
          Icons.warning_amber_outlined,
          size: 20,
        ),
        const Spacer(),
        
      ],
    );
  }

  // Widget pour construire le bouton d'ajout de la tâche
  Widget _buildAddButton() {
    return Center(
      child: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 70)),
            maximumSize: MaterialStateProperty.all(const Size(double.infinity, 104)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 67, 129, 69)),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Action à effectuer lors de l'ajout de la tâche
              Navigator.pop(context); // Retour à l'écran précédent après validation
            }
          },
          child: const Text("Ajouter"), // Texte du bouton
        ),
      ),
    );
  }
}
