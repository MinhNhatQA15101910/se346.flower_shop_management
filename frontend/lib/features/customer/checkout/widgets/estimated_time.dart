import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EstimatedTime extends StatefulWidget {
  final DateTime dateTime;
  final ValueChanged<DateTime> onDateChanged;

  const EstimatedTime({
    required this.dateTime,
    required this.onDateChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<EstimatedTime> createState() => _EstimatedTimeState();
}

class _EstimatedTimeState extends State<EstimatedTime> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GlobalVariables.customContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              color: GlobalVariables.darkGreen,
              size: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: _semiBoldSizeText(
                DateFormat('EEEE, dd/MM/yyyy').format(_selectedDateTime),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            InkResponse(
              child: Icon(
                Icons.edit,
                color: GlobalVariables.darkGreen,
                size: 24,
              ),
              onTap: () {
                _showDatePicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _semiBoldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime futureTime = DateTime.now().add(Duration(days: 3));
    final DateTime maxDate = DateTime.now().add(Duration(days: 9));

    if (_selectedDateTime.isBefore(futureTime)) {
      setState(() {
        _selectedDateTime = futureTime;
      });
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: futureTime,
      lastDate: maxDate,
    );

    if (picked != null && picked != _selectedDateTime) {
      setState(() {
        _selectedDateTime = picked;
      });
      widget.onDateChanged(picked);
    }
  }
}
