import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/product_details/widgets/product_details_widget.dart';
import 'package:frontend/features/customer/rating/services/rating_service.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/size.dart';

class RatingScreen extends StatefulWidget {
  static const String routeName = "/customer-rating-screen";
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _ratingService = RatingService();
  Product _product = Product(
    id: 0,
    name: '',
    price: 0.0,
    salePrice: 0.0,
    salePercentage: 0.0,
    detailDescription: '',
    size: Size.small,
    weight: 0.0,
    color: '',
    material: '',
    stock: 0,
    sold: 0,
    ratingAvg: 0.0,
    totalRating: 0,
    imageUrls: [],
  );

  double _currentRating = 1.0;
  late Future<void> _loadFuture;

  void _fetchProductDetails() async {
    Product product = await _ratingService.fetchProductDetails(
      context,
      GlobalVariables.productId,
    );

    setState(() {
      _product = product;
    });
  }

  Future<void> _loadScreen() async {
    await Future.delayed(Duration(seconds: 2));
    _fetchProductDetails();
  }

  Future<void> _rateProduct() async {
    await _ratingService.rateProduct(
      context: context,
      productId: _product.id,
      rating: _currentRating,
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rating',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
                color: GlobalVariables.darkGreen,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProductDetailsWidget(product: _product),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 12),
                        _BoldSizeText('Tap a star to rate above product'),
                        SizedBox(height: 12),
                        RatingBar.builder(
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24,
                          unratedColor: GlobalVariables.lightYellow,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: GlobalVariables.yellow,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _currentRating = rating;
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: 160,
                          child: GlobalVariables.customButton(
                            buttonText: 'Rate',
                            borderColor: GlobalVariables.green,
                            fillColor: GlobalVariables.green,
                            textColor: Colors.white,
                            onTap: _rateProduct,
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _BoldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
