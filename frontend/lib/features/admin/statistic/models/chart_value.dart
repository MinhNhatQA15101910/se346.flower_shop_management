import 'dart:convert';

class ChartValue {
  final String name;
  final double value;

  ChartValue({
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory ChartValue.fromMap(Map<String, dynamic> map) {
    return ChartValue(
      name: map['name'] ?? '',
      value: double.tryParse(map['value']) ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartValue.fromJson(String source) =>
      ChartValue.fromMap(json.decode(source));
}
