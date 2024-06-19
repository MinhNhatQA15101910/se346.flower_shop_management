import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/account/services/account_service.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

final Map<String, IconData> drawerItems = {
  'Carousel management': Icons.view_carousel_outlined,
  'Import an Excel file': Icons.import_export_outlined,
  'Change password': Icons.password_outlined,
  'Log out': Icons.logout_outlined,
};

class _AdminDrawerState extends State<AdminDrawer> {
  List<bool> listTileSelected = drawerItems.keys.map((e) => false).toList();

  void _logOut() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Log out confirm'),
          content: const Text('Are you sure to log out the app?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                final accountService = AccountService();
                accountService.logOut(context);

                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            // The "No" button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              GlobalVariables.green,
              GlobalVariables.lightGreen,
              GlobalVariables.lightGrey,
            ],
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 111,
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userProvider.user.imageUrl != ''
                      ? Image.network(
                          userProvider.user.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/images/img_account.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.user.username,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        userProvider.user.email,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: GlobalVariables.darkGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ...drawerItems.entries
                .map(
                  (e) => _buildDrawerItem(
                    title: e.key,
                    icon: e.value,
                    index: drawerItems.keys.toList().indexOf(e.key),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required int index,
  }) {
    return ListTile(
      selected: listTileSelected[index],
      tileColor: Colors.transparent,
      selectedTileColor: GlobalVariables.green,
      splashColor: GlobalVariables.green.withOpacity(0.5),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color:
              listTileSelected[index] ? Colors.white : GlobalVariables.darkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: Icon(
        icon,
        color:
            listTileSelected[index] ? Colors.white : GlobalVariables.darkGrey,
      ),
      onTap: () {
        if (index == 3) {
          _logOut();
        }
      },
    );
  }
}
