import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/widgets/add_update_category_btm_sheet.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final Type? type;
  final Occasion? occasion;
  final VoidCallback onUpdate;

  const CategoryItem({
    super.key,
    this.type,
    this.occasion,
    required this.onUpdate,
  });

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = type != null
        ? type!.imageUrl
        : occasion != null
            ? occasion!.imageUrl
            : '';
    final title = type != null
        ? type!.name
        : occasion != null
            ? occasion!.name
            : '';
    final description = type != null ? 'Type' : 'Occasion';

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
                      image: NetworkImage(imageUrl),
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
                      _titleText(title),
                      _descriptionText(description),
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
                  onTap: () async {
                    final result = await showModalBottomSheet(
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
                          child: AddUpdateCategoryBottomSheet(
                            featureName: type != null
                                ? 'Update type'
                                : 'Update occasion',
                            categoryId: type != null ? type!.id : occasion!.id,
                          ),
                        );
                      },
                    );
                    if (result == true) {
                      onUpdate();
                    }
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

  Widget _titleText(String text) {
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

  Widget _descriptionText(String text) {
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
