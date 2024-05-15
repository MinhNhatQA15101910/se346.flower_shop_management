import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/features/customer/account/widgets/item_tag.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void navigateToCartScreen(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: () => navigateToCartScreen(context),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/img_account_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.black.withOpacity(0.5)
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 1,
                        child: Container(color: GlobalVariables.defaultColor),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 1,
                        child: Row(
                          children: [
                            AspectRatio(aspectRatio: 1.0),
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipOval(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: userProvider.user.imageUrl == ''
                                      ? Image.asset(
                                          'assets/images/img_account.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          userProvider.user.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            AspectRatio(aspectRatio: 1.0),
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 3 / 0.5,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: _usernameText(
                              userProvider.user.username,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GlobalVariables.customContainer(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_promotion_code.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _regularSizeText('Promotion code'),
                                SizedBox(height: 8),
                                _boldSizeText('13'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Container(
                            width: 2,
                            height: 60,
                            color: GlobalVariables.lightGrey),
                      ),
                    ),
                    Flexible(
                      flex: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_reward_point.png',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _regularSizeText('Promotion code'),
                                SizedBox(height: 8),
                                _boldSizeText('139'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GlobalVariables.customContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Orders',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        //onTap: do sth,
                        child: Text(
                          'View more >',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //Do sth
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.pending_actions,
                                  size: 40,
                                  color: GlobalVariables.darkGrey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _regularSizeText('Pending')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //Do sth
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  size: 40,
                                  color: GlobalVariables.darkGrey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _regularSizeText('In delivery')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //Do sth
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.assignment_turned_in,
                                  size: 40,
                                  color: GlobalVariables.darkGrey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _regularSizeText('Delivered')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GlobalVariables.customContainer(
              child: ItemTag(
                title: 'Favorite',
                description: 'View products you love',
                imgPath: 'assets/images/img_favourite.png',
                onTap: () {},
                isVisibleArrow: true,
              ),
            ),
            GlobalVariables.customContainer(
              child: ItemTag(
                title: 'Recently',
                description: 'View recently products',
                imgPath: 'assets/images/img_recent.png',
                onTap: () {},
                isVisibleArrow: true,
              ),
            ),
            GlobalVariables.customContainer(
              child: ItemTag(
                title: 'Support',
                description: 'Call or text us for quick support',
                imgPath: 'assets/images/img_support.png',
                onTap: () {},
                isVisibleArrow: true,
              ),
            ),
            GlobalVariables.customContainer(
              child: ItemTag(
                title: 'Change password',
                description: 'Change your account password',
                onTap: () {},
                iconData: Icons.password,
              ),
            ),
            GlobalVariables.customContainer(
              child: ItemTag(
                title: 'Log out',
                description: 'Log out of your account',
                onTap: () {},
                iconData: Icons.logout,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Terms and Conditions',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: GlobalVariables.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'version: 1.0.0',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: GlobalVariables.darkGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _regularSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _boldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
