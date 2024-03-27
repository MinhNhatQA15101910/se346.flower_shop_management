import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/common/widgets/single_product_card.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/deals_of_day/screens/deals_of_day_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;

  void _navigateToDealsOfDayScreen() {
    Navigator.of(context).pushNamed(DealsOfDayScreen.routeName);
  }

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FlowerFly',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: _navigateToCartScreen,
                iconSize: 30,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: 5,
                carouselController: CarouselController(),
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  aspectRatio: 3 / 1.2,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) => setState(() {
                    _activeIndex = index;
                  }),
                ),
                itemBuilder: (context, index, realIndex) => Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.darkBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/banner1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedSmoothIndicator(
                activeIndex: _activeIndex,
                count: 5,
                duration: const Duration(milliseconds: 600),
                effect: const ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 12.0,
                  dotHeight: 8.0,
                  strokeWidth: 1.5,
                  dotColor: GlobalVariables.lightGreen,
                  activeDotColor: GlobalVariables.darkGreen,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals of the Day',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToDealsOfDayScreen,
                        child: Text(
                          'View more >',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              childAspectRatio: 4 / 3),
                      itemBuilder: (context, index) {
                        return const SingleProductCard();
                      },
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended for you',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'View more >',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: GlobalVariables.darkGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                itemCount: 10,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  return const SingleProductCard();
                },
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
