import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/models/district.dart';
import 'package:frontend/features/customer/checkout/models/ward.dart';
import 'package:frontend/features/customer/checkout/providers/shipping_info_provider.dart';
import 'package:frontend/features/customer/checkout/services/checkout_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddressInfoBottomSheet extends StatefulWidget {
  const AddressInfoBottomSheet({Key? key}) : super(key: key);

  @override
  _AddressInfoBottomSheetState createState() => _AddressInfoBottomSheetState();
}

class _AddressInfoBottomSheetState extends State<AddressInfoBottomSheet> {
  List<String> provinceList = ['TP Hồ Chí Minh'];
  final CheckoutService _checkoutService = CheckoutService();
  List<String> _districtNames = ['Loading...']; // Initial placeholder
  List<String> _wardNames = ['Choose a district first']; // Initial placeholder
  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedWard;

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();

  void _fetchDistricts() async {
    try {
      List<District> districts = await _checkoutService.fetchDistricts('79');
      if (!mounted) return;
      setState(() {
        _districtNames =
            districts.map((district) => district.districtName).toList();
        _selectedDistrict =
            _districtNames.isNotEmpty ? _districtNames[0] : null;
        _wardNames = ['Choose a ward'];
        _selectedWard = null;
      });
    } catch (e) {
      print('Error fetching districts: $e');
      setState(() {
        _districtNames = ['Error loading districts'];
      });
    }
  }

  Future<String?> _getDistrictId(String districtName) async {
    List<District> districts = await _checkoutService.fetchDistricts('79');
    if (!mounted) return null;

    District? selectedDistrict = districts.firstWhere(
      (district) => district.districtName == districtName,
    );

    return selectedDistrict.districtId;
  }

  void _fetchWards(String districtId) async {
    try {
      List<Ward> wards = await _checkoutService.fetchWards(districtId);
      setState(() {
        _wardNames = wards.map((ward) => ward.wardName).toList();
        _selectedWard = _wardNames.isNotEmpty ? _wardNames[0] : null;
      });
    } catch (e) {
      print('Error fetching wards: $e');
      setState(() {
        _wardNames = ['Error loading wards'];
        _selectedWard = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDistricts();
    _fetchWards('785');
  }

  @override
  void dispose() {
    _streetController.dispose();
    _phoneNumberController.dispose();
    _receiverNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final shippingInfoProvider = context.watch<ShippingInfoProvider>();
    final shippingInfo = shippingInfoProvider.shippingInfo;
    return Container(
      padding: EdgeInsets.only(bottom: keyboardSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 24),
                  Expanded(
                    child: Container(
                      child: _BoldSizeText('Change shipping info'),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 24,
                    icon: const Icon(Icons.clear, color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(color: GlobalVariables.lightGrey, thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PaddingText('Province'),
                  _buildDropdown(
                    value: _selectedProvince ?? provinceList[0],
                    items: provinceList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProvince = newValue;
                      });
                    },
                  ),
                  _PaddingText('District'),
                  _buildDropdown(
                    value: _selectedDistrict ?? _districtNames[0],
                    items: _districtNames.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      setState(() {
                        _selectedDistrict = newValue;
                      });

                      if (_selectedDistrict != null) {
                        String? districtId =
                            await _getDistrictId(_selectedDistrict!);
                        if (districtId != null) {
                          _fetchWards(districtId);
                        }
                      }
                    },
                  ),
                  _PaddingText('Ward'),
                  _buildDropdown(
                    value: _selectedWard ?? _wardNames[0],
                    items: _wardNames.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedWard = newValue;
                      });
                    },
                  ),
                  _PaddingText('Street / Home Number'),
                  _customTextField(TextInputType.text,
                      'Type street & home Number', _streetController),
                  _PaddingText('Receiver Name'),
                  _customTextField(TextInputType.text, 'Type receiver name',
                      _receiverNameController),
                  _PaddingText('Phone Number'),
                  _customTextField(TextInputType.number, 'Type phone number',
                      _phoneNumberController),
                ],
              ),
            ),
            Divider(color: GlobalVariables.defaultColor, thickness: 12.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: GlobalVariables.customButton(
                      buttonText: 'Cancel',
                      borderColor: GlobalVariables.green,
                      fillColor: Colors.white,
                      textColor: GlobalVariables.green,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GlobalVariables.customButton(
                      buttonText: 'Confirm',
                      borderColor: GlobalVariables.green,
                      fillColor: GlobalVariables.green,
                      textColor: Colors.white,
                      onTap: () => {
                        if (_selectedDistrict != 'Loading...' &&
                            _selectedDistrict != null &&
                            _selectedWard != 'Choose a ward' &&
                            _selectedWard != 'Error loading wards' &&
                            _selectedWard != null &&
                            _receiverNameController.text != "" &&
                            _phoneNumberController.text != "")
                          {
                            Navigator.pop(context),
                            shippingInfoProvider.setShippingInfo(
                              shippingInfo.copyWith(
                                districtName: _selectedDistrict,
                                wardName: _selectedWard,
                                detailAddress: _streetController.text,
                                receiverName: _receiverNameController.text,
                                phoneNumber: _phoneNumberController.text,
                              ),
                            ),
                          }
                        else
                          {
                            IconSnackBar.show(
                              context,
                              label: 'Shipping info must not be empty',
                              snackBarType: SnackBarType.fail,
                            ),
                          }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _BoldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _PaddingText(String text) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 12),
      child: Text(
        text,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _customTextField(
      TextInputType inputType, String hint, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: GlobalVariables.darkGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              GoogleFonts.inter(fontSize: 14, color: GlobalVariables.darkGrey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: GlobalVariables.darkGrey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          onChanged: onChanged,
          items: items,
          icon: Icon(Icons.expand_more, color: Colors.grey),
        ),
      ),
    );
  }
}
