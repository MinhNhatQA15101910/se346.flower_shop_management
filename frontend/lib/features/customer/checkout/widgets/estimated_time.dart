import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EstimatedTime extends StatefulWidget {
  final DateTime datetime;
  const EstimatedTime({
    required this.datetime,
    Key? key,
  }) : super(key: key);

  @override
  _EstimatedTimeState createState() => _EstimatedTimeState();
}

class _EstimatedTimeState extends State<EstimatedTime> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.datetime;
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
    }
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
}
