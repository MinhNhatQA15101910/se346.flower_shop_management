import 'dart:convert';

class Type {
  final int id;
  final String name;
  final String imageUrl;

  const Type({
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

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) =>
      Type.fromMap(json.decode(source));

  Type copyWith({
    int? id,
    String? name,
    String? imageUrl,
  }) {
    return Type(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
