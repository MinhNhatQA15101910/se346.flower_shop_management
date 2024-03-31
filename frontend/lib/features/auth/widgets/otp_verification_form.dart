import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/common/widgets/form_container.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({Key? key}) : super(key: key);

  @override
  _OtpVerificationFormState createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final TextEditingController otp01 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: GlobalVariables.defaultColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
