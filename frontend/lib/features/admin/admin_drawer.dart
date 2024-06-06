import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_account.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nguyen Van Vu',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'nguyenvanvu@blabla.com',
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

  Widget _buildDrawerItem(
      {required String title, required IconData icon, required int index}) {
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
        setState(() {
          listTileSelected[index] = true;
          listTileSelected
              .asMap()
              .forEach((key, value) => listTileSelected[key] = key == index);
        });
      },
    );
  }
}
