import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/models/categories.dart';
import 'package:go_to_vienna/utils/utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
    this.width,
  });

  final Category category;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 104.w,
        height: 76.h,
        padding: EdgeInsets.only(left: 12.w, bottom: 12.h, right: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          image: DecorationImage(
            image: AssetImage(category.asset),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          category.name,
          style: TextStyles.red15,
        ),
      ),
    );
  }
}
