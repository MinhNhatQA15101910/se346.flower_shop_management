import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/services/cart_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductCartItem extends StatefulWidget {
  final String productName;
  final String imagePath;
  final double price;
  final int quantity;
  final int limitQuantity;
  final int productId;
  final VoidCallback onRemove;
  final VoidCallback onQuantityChanged; // Add this line

  const ProductCartItem({
    Key? key,
    required this.productName,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.limitQuantity,
    required this.productId,
    required this.onRemove,
    required this.onQuantityChanged, // Add this line
  }) : super(key: key);

  @override
  State<ProductCartItem> createState() => _ProductCartItemState(
        quantity,
        limitQuantity,
      );
}

class _ProductCartItemState extends State<ProductCartItem> {
  int _quantity = 0;
  int _limitQuantity = 0;
  bool _isIncrementEnabled = true;
  bool _isDecrementEnabled = false;
  final CartService _cartService = CartService();

  _ProductCartItemState(this._quantity, this._limitQuantity);

  @override
  void initState() {
    super.initState();
    _updateButtonState();
  }

  void _updateButtonState() {
    setState(() {
      _isIncrementEnabled = _quantity < _limitQuantity;
      _isDecrementEnabled = _quantity > 1;
    });
  }

  Future<void> _addToCart(int productId) async {
    final success = await _cartService.addToCart(context, productId);
    if (success) {
      setState(() {
        _quantity++;
        _updateButtonState();
        widget.onQuantityChanged();
      });
    }
  }

  Future<void> _removeFromCart(int productId) async {
    final success = await _cartService.removeFromCart(context, productId);
    if (success) {
      setState(() {
        if (_quantity > 1) {
          _quantity--;
        }
        _updateButtonState();
        widget.onQuantityChanged();
      });
    }
  }

  Future<void> _deleteFromCart(int productId) async {
    final success = await _cartService.deleteFromCart(context, productId);
    if (success) {
      setState(() {
        widget.onRemove();
        widget.onQuantityChanged();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                _deleteFromCart(widget.productId);
              },
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imagePath),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _productText(widget.productName),
                        SizedBox(height: 8),
                        _priceText('\$' + widget.price.toString()),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: _isDecrementEnabled
                                  ? InkWell(
                                      onTap: () {
                                        _removeFromCart(widget.productId);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_decrement_button_enable.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      'assets/vectors/vector_decrement_button_disable.svg',
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFDCDCE2)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _productNumberText(_quantity.toString())
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Material(
                              color: Colors.transparent,
                              child: _isIncrementEnabled
                                  ? InkWell(
                                      onTap: () async {
                                        await _addToCart(widget.productId);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_increment_button_enable.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      'assets/vectors/vector_increment_button_disable.svg',
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 2,
                color: GlobalVariables.lightGrey,
                margin: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _priceText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _productNumberText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
