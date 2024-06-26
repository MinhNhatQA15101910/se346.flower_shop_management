import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/models/product.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({super.key, required this.product});
  final Product product;

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CarouselSlider.builder(
              itemCount: widget.product.imageUrls.length,
              options: CarouselOptions(
                viewportFraction: 1.0,
                aspectRatio: 1.2,
                onPageChanged: (index, reason) => setState(() {
                  _activeIndex = index;
                }),
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrls[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_activeIndex + 1} / ${widget.product.imageUrls.length}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: GlobalVariables.screenWidth,
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.product.name,
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    unratedColor: GlobalVariables.lightGreen,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.green,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Text(
                    '(${widget.product.totalRating})',
                    style: GoogleFonts.inter(
                      color: GlobalVariables.darkGrey,
                    ),
                  ),
                ],
              ),
              Text(
                '\$ ${widget.product.salePrice.toString()}',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: BoxDecoration(
                      color: GlobalVariables.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '-${widget.product.salePercentage}%',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '\$ ${widget.product.price.toString()}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: GlobalVariables.darkGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
