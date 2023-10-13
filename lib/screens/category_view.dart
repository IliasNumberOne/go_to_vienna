import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/screens/category_screen/category_model.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (
        BuildContext context,
          PlaceProvider provider,
        Widget? child,
      ) {
        return Padding(
          padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
          child: Column(
            children: [
              Row(
                children: [
                  BackBtn(myContext: context),
                  SizedBox(
                    width: 72.w,
                  ),
                  Text(categories[0].name,
                      textAlign: TextAlign.center, style: TextStyles.dark19),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      categoryModel.items.length,
                      (index) => CategoryCard(index: categoryModel.items[index]),
                    ).withSpaceBetween(height: 12.h),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }
}
