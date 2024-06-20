class ShippingInfo {
  final String districtName;
  final String wardName;
  final String detailAddress;
  final String receiverName;
  final String phoneNumber;

  ShippingInfo({
    required this.districtName,
    required this.wardName,
    required this.detailAddress,
    required this.receiverName,
    required this.phoneNumber,
  });

  ShippingInfo copyWith({
    String? districtName,
    String? wardName,
    String? detailAddress,
    String? receiverName,
    String? phoneNumber,
  }) {
    return ShippingInfo(
      districtName: districtName ?? this.districtName,
      wardName: wardName ?? this.wardName,
      detailAddress: detailAddress ?? this.detailAddress,
      receiverName: receiverName ?? this.receiverName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
