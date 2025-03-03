import 'dart:typed_data';
import 'dart:convert';

class ServiceAuto {
  final String? id;
  final String title;
  final String description;
  final Uint8List photo;

  ServiceAuto({
    this.id,
    required this.title,
    required this.description,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title.isNotEmpty ? title : "Titre par défaut",
      'description':
          description.isNotEmpty ? description : "Description par défaut",
      'picture': base64Encode(photo.isNotEmpty
          ? photo
          : Uint8List(0)), // Valeur par défaut si photo est vide
    };
  }

  // Méthode toJson pour sérialiser l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'photo': base64Encode(photo), // Simplification de la gestion de photo
    };
  }

  ServiceAuto copyWith({
    String? title,
    String? description,
    Uint8List? photo,
  }) {
    return ServiceAuto(
      title: title ?? this.title,
      description: description ?? this.description,
      photo: photo ?? this.photo,
    );
  }
}
