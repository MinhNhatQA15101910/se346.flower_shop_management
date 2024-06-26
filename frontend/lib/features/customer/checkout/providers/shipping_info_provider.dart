import 'package:flutter/material.dart';
import 'package:frontend/features/customer/checkout/models/shipping_info.dart';

class ShippingInfoProvider extends ChangeNotifier {
  ShippingInfo _shippingInfo = ShippingInfo(
    districtName: '',
    wardName: '',
    detailAddress: '',
    receiverName: '',
    phoneNumber: '',
  );

  ShippingInfo get shippingInfo => _shippingInfo;

  void setShippingInfo(ShippingInfo shippingInfo) {
    _shippingInfo = shippingInfo;
    notifyListeners();
  }
}
