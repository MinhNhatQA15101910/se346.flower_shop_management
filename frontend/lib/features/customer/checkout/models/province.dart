class Province {
  final String provinceId;
  final String provinceName;
  final String provinceType;

  Province({
    required this.provinceId,
    required this.provinceName,
    required this.provinceType,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinceId: json['province_id'],
      provinceName: json['province_name'],
      provinceType: json['province_type'],
    );
  }
}
