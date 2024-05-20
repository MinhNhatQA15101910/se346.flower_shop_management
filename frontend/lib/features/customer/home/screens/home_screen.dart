import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/common/widgets/single_category_card.dart';
import 'package:frontend/common/widgets/single_product_card.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/deals_of_day/screens/deals_of_day_screen.dart';
import 'package:frontend/features/customer/home/services/home_service.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeService = HomeService();

  final _recommendProductsScrollController = ScrollController();

  List<Product>? _dealsOfDayProducts;
  List<Category>? _categories;
  List<Product>? _recommendedProducts;

  int _activeIndex = 0;

  void _navigateToDealsOfDayScreen() {
    Navigator.of(context).pushNamed(DealsOfDayScreen.routeName);
  }

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void _fetchDealOfDayProductsInFirstPage() async {
    _dealsOfDayProducts =
        await _homeService.fetchAllDealOfDayProducts(context, 1);
    setState(() {});
  }

  void _fetchAllCategories() async {
    _categories = await _homeService.fetchAllCategories(context);
    setState(() {});
  }

  void _fetchRecommendedProductsInFirstPage() async {
    List<Product> newProducts = await _homeService.fetchAllRecommendedProducts(
      context,
      1,
    );

    setState(() {
      _recommendedProducts = newProducts;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchDealOfDayProductsInFirstPage();
    _fetchAllCategories();
    _fetchRecommendedProductsInFirstPage();
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
                  onPageChanged: (index, reason) => setState(
                    () {
                      _activeIndex = index;
                    },
                  ),
                ),
                itemBuilder: (context, index, realIndex) => Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/img-carousel-${index + 1}.png',
                      fit: BoxFit.fill,
                    ),
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

              // Deals of the day
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals of the Day',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: GlobalVariables.blackTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToDealsOfDayScreen,
                        child: Text(
                          'View more >',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _dealsOfDayProducts == null
                      ? const Loader()
                      : SizedBox(
                          height: 200,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: _dealsOfDayProducts!.length,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              childAspectRatio: 4 / 3,
                            ),
                            itemBuilder: (context, index) {
                              return SingleProductCard(
                                product: _dealsOfDayProducts![index],
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 24),

              // Categories
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: GlobalVariables.blackTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToDealsOfDayScreen,
                        child: Text(
                          'View more >',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _categories == null
                      ? const Loader()
                      : SizedBox(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemCount: _categories!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SingleCategoryCard(
                                category: _categories![index],
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended for you',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.blackTextColor,
                    ),
                  ),
                  Text(
                    'View more >',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: GlobalVariables.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _recommendedProducts == null
                  ? const Loader()
                  : GridView.builder(
                      controller: _recommendProductsScrollController,
                      itemCount: _recommendedProducts!.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return SingleProductCard(
                          product: _recommendedProducts![index],
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recommendProductsScrollController.dispose();
    super.dispose();
  }
}
