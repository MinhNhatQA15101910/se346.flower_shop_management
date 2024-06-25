import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/widgets/category_pie_chart.dart';
import 'package:frontend/features/admin/statistic/widgets/monthly_revenue_bar_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final titleStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  final contentStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10), // To center the title
              Text(
                'FlowerFly',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: () => {},
                iconSize: 30,
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: GlobalVariables.lightGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.credit_card_outlined,
                                  size: 40,
                                  color: GlobalVariables.darkGreen,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _interSemiBold14('Sales'),
                            SizedBox(
                              height: 4,
                            ),
                            _interRegular14('123,456,789'),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: GlobalVariables.lightRed,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.collections_bookmark_outlined,
                                  size: 40,
                                  color: GlobalVariables.darkRed,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _interSemiBold14('Products'),
                            SizedBox(
                              height: 4,
                            ),
                            _interRegular14('69'),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: GlobalVariables.lightBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 40,
                                  color: GlobalVariables.darkBlue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _interSemiBold14('Orders'),
                            SizedBox(
                              height: 4,
                            ),
                            _interRegular14('139'),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: GlobalVariables.lightYellow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.supervisor_account_outlined,
                                  size: 40,
                                  color: GlobalVariables.darkYellow,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            _interSemiBold14('Customers'),
                            SizedBox(
                              height: 4,
                            ),
                            _interRegular14('302'),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CategoryPieChart(),
              MonthlyRevenueBarChart(),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _interSemiBold14(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _interRegular14(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
