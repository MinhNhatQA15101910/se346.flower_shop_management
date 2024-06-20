class Ward {
  final String wardId;
  final String wardName;

  Ward({
    required this.wardId,
    required this.wardName,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      wardId: json['ward_id'],
      wardName: json['ward_name'],
    );
  }
}
