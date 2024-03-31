import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const FormContainer({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.all(10.0),
    this.padding = const EdgeInsets.all(10.0),
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
  }) : super(key: key);

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: FormBuilder(
        key: GlobalKey<FormBuilderState>(),
        child: widget.child,
      ),
    );
  }
}
