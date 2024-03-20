import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/common/widgets/single_product_card.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                'Flowerly',
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: GlobalVariables.darkGreen,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
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
        child: Column(
          children: [
            CarouselSlider(
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
              ),
              items: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: GlobalVariables.darkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Image.asset('assets/banner1.png', fit: BoxFit.fill)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals of the Day',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View more >',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: GlobalVariables.darkGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              childAspectRatio: 5 / 3),
                      itemBuilder: (context, index) {
                        return const SingleProductCard();
                      },
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 5,
              ),
              itemBuilder: (context, index) {
                return const SingleProductCard();
              },
              physics: const BouncingScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
