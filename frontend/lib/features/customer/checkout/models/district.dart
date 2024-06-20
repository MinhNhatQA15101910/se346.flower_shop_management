class District {
  final String districtId;
  final String districtName;

  District({
    required this.districtId,
    required this.districtName,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtId: json['district_id'],
      districtName: json['district_name'],
    );
  }
}
