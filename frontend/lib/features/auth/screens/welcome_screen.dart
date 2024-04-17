import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/main_auth_screen.dart';
import 'package:frontend/features/auth/widgets/carousel_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _activeIndex = 0;
  final _controller = CarouselController();
  final _urlImages = [
    GlobalVariables.welcomeImage_01,
    GlobalVariables.welcomeImage_02,
    GlobalVariables.welcomeImage_03,
  ];
  final _buttonContents = [
    "Get Started",
    "Next",
    "Ready",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appBG.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                carouselController: _controller,
                items: [
                  CarouselItem(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Welcome to",
                          style: GoogleFonts.inter(
                            color: GlobalVariables.darkGreen,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "FlowerFly!",
                          style: GoogleFonts.pacifico(
                            color: GlobalVariables.darkGreen,
                            fontSize: 50,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/Welcome_01.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                  CarouselItem(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/Welcome_02.png'),
                          ),
                        ),
                        Text(
                          "Let's Start Journey",
                          style: GoogleFonts.pacifico(
                            color: GlobalVariables.darkGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "With FlowerFly",
                          style: GoogleFonts.pacifico(
                            color: GlobalVariables.darkGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "FlowerFly provides unique",
                          style: GoogleFonts.inter(
                            color: GlobalVariables.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "and meaningful gifts",
                          style: GoogleFonts.inter(
                            color: GlobalVariables.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  CarouselItem(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/Welcome_03.png'),
                          ),
                        ),
                        Text(
                          "You Have Many",
                          style: GoogleFonts.pacifico(
                            color: GlobalVariables.darkGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Choices Available",
                          style: GoogleFonts.pacifico(
                            color: GlobalVariables.darkGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "FlowerFly provides a lot of",
                          style: GoogleFonts.inter(
                            color: GlobalVariables.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "beautiful gifts to your lover",
                          style: GoogleFonts.inter(
                            color: GlobalVariables.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  height: GlobalVariables.screenHeight / 2,
                  reverse: false,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) => setState(
                    () {
                      _activeIndex = index;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              buildIndicator(),
              SizedBox(height: 20.0),
              SizedBox(
                width: GlobalVariables.screenWidth / 2,
                child: ElevatedButton(
                  onPressed: next,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Change color when button is pressed
                          return Colors.green.withOpacity(0.5);
                        }
                        // Default color
                        return GlobalVariables.green;
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(10.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    _buttonContents[_activeIndex],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _activeIndex,
        count: _urlImages.length,
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
          dotWidth: 28,
          dotHeight: 5,
          expansionFactor: 1.5,
          dotColor: GlobalVariables.green,
          activeDotColor: GlobalVariables.pureWhite,
        ),
      );

  void next() {
    setState(() {
      if (_activeIndex == 2) {
        Navigator.of(context).pushNamed(MainAuthScreen.routeName);
      } else {
        _activeIndex = (_activeIndex + 1) % _buttonContents.length;
      }
    });
    _controller.nextPage(duration: Duration(milliseconds: 200));
  }

  void animateToSlide(int index) => _controller.animateToPage(index);
}
