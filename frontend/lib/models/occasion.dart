import 'dart:convert';

class Occasion {
  final int id;
  final String name;
  final String imageUrl;

  const Occasion({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }

  factory Occasion.fromMap(Map<String, dynamic> map) {
    return Occasion(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Occasion.fromJson(String source) =>
      Occasion.fromMap(json.decode(source));
}
