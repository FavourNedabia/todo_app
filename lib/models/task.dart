import 'dart:convert';

// Classe représentant une tâche
class Task {
  String titre; // Titre de la tâche
  String categorie; // Catégorie de la tâche
  bool isUrgent; // Indicateur si la tâche est urgente
  bool isCompleted; // Indicateur si la tâche est terminée

  // Constructeur
  Task({
    required this.titre,
    required this.categorie,
    required this.isUrgent,
    required this.isCompleted,
  });

  // Factory pour créer une instance de Task à partir d'un Map (JSON)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      titre: json['titre'], // Récupération du titre depuis le Map JSON
      categorie: json['categorie'], // Récupération de la catégorie depuis le Map JSON
      isUrgent: json['isUrgent'], // Récupération de l'indicateur d'urgence depuis le Map JSON
      isCompleted: json['isCompleted'], // Récupération de l'indicateur de complétude depuis le Map JSON
    );
  }

  // Méthode pour convertir une instance de Task en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'titre': titre, // Ajout du titre dans le Map JSON
      'categorie': categorie, // Ajout de la catégorie dans le Map JSON
      'isUrgent': isUrgent, // Ajout de l'indicateur d'urgence dans le Map JSON
      'isCompleted': isCompleted, // Ajout de l'indicateur de complétude dans le Map JSON
    };
  }
}
