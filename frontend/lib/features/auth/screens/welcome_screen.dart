import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:frontend/constants/global_variables.dart';
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "FlowerFly",
                        style: GoogleFonts.pacifico(
                          color: GlobalVariables.darkGreen,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )),
                  CarouselItem(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Welcome_02.png',
                        ),
                      ],
                    ),
                  ),
                  CarouselItem(child: Column())
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
                  onPressed: () => {next()},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Change color when button is pressed
                          return Colors.green.withOpacity(0.5);
                        }
                        // Default color
                        return GlobalVariables.darkGreen;
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(10.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
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
        effect: JumpingDotEffect(
          dotWidth: 20,
          dotHeight: 5,
          dotColor: GlobalVariables.darkGrey,
          activeDotColor: GlobalVariables.darkGreen,
        ),
      );

  void next() {
    setState(() {
      _activeIndex = (_activeIndex + 1) % _buttonContents.length;
    });
    _controller.nextPage(duration: Duration(milliseconds: 200));
  }

  void animateToSlide(int index) => _controller.animateToPage(index);
}
