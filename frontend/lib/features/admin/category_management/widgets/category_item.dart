import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/widgets/add_update_category_btm_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;

  const CategoryItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _TilteText(widget.title),
                      _DescriptionText(widget.description),
                    ],
                  ),
                ),
                InkResponse(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: GlobalVariables.lightYellow,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: GlobalVariables.darkYellow,
                      size: 16,
                    ),
                  ),
                  onTap: () => {
                    showModalBottomSheet<dynamic>(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: AddUpdateCategotyBottomSheet(),
                        );
                      },
                    ),
                  },
                ),
                SizedBox(width: 8),
                InkResponse(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: GlobalVariables.lightRed,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: GlobalVariables.darkRed,
                      size: 16,
                    ),
                  ),
                  onTap: () => {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 1,
            color: GlobalVariables.lightGrey,
          )
        ],
      ),
    );
  }

  Widget _TilteText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _DescriptionText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: GlobalVariables.darkGrey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
