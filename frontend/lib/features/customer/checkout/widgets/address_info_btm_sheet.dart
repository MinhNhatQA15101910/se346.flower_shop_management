import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/common/widgets/drop_down_button.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressInfoBottomSheet extends StatefulWidget {
  const AddressInfoBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressInfoBottomSheet> createState() => _AddressInfoBottomSheetState();
}

class _AddressInfoBottomSheetState extends State<AddressInfoBottomSheet> {
  List<String> provinceList = [
    'TP Hồ Chí Minh',
    'Hà Nội',
    'Đà Nẵng',
    'Cần Thơ',
    'Đồng Nai',
  ];
  List<String> districtList = [
    'TP Hồ Chí Minh',
    'Hà Nội',
    'Đà Nẵng',
    'Cần Thơ',
    'Đồng Nai',
  ];
  List<String> wardList = [
    'TP Hồ Chí Minh',
    'Hà Nội',
    'Đà Nẵng',
    'Cần Thơ',
    'Đồng Nai',
  ];

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.only(
        bottom: keyboardSpace,
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
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Container(
                      child: _BoldSizeText('Change shipping info'),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 24,
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: GlobalVariables.lightGrey,
              thickness: 1.0,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 12,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PaddingText('Province'),
                  CustomDropdownButton(
                    items: provinceList,
                    initialSelectedItem: provinceList[0],
                    onChanged: (selectedItem) {
                      print('Selected item: $selectedItem');
                    },
                  ),
                  _PaddingText('District'),
                  CustomDropdownButton(
                    items: districtList,
                    initialSelectedItem: districtList[0],
                    onChanged: (selectedItem) {
                      print('Selected item: $selectedItem');
                    },
                  ),
                  _PaddingText('Ward'),
                  CustomDropdownButton(
                    items: wardList,
                    initialSelectedItem: wardList[0],
                    onChanged: (selectedItem) {
                      print('Selected item: $selectedItem');
                    },
                  ),
                  _PaddingText('Street / Home Number'),
                  _customTextField(
                      TextInputType.text, 'Type street & home Number'),
                  _PaddingText('Phone Number'),
                  _customTextField(TextInputType.number, 'Type phone number'),
                ],
              ),
            ),
            Divider(
              color: GlobalVariables.defaultColor,
              thickness: 12.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GlobalVariables.customButton(
                        onTap: () => Navigator.pop(context),
                        buttonText: 'Cancel',
                        borderColor: GlobalVariables.green,
                        fillColor: Colors.white,
                        textColor: GlobalVariables.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      child: GlobalVariables.customButton(
                        onTap: () {},
                        buttonText: 'Confirm',
                        borderColor: GlobalVariables.green,
                        fillColor: GlobalVariables.green,
                        textColor: Colors.white,
                      ),
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
      padding: EdgeInsets.only(
        bottom: 8,
        top: 12,
      ),
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

  Widget _customTextField(TextInputType inputText, String hint) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GlobalVariables.darkGrey),
      ),
      child: TextFormField(
        cursorColor: GlobalVariables.darkGrey,
        keyboardType: inputText,
        style: TextStyle(
          color: GlobalVariables.darkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
