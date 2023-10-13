import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesModel>(
      builder: (
        BuildContext context,
        FavoritesModel favoritesModel,
        Widget? child,
      ) {
        return Padding(
          padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorite',
                textAlign: TextAlign.left,
                style: TextStyles.dark27,
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      favoritesModel.getItems().length,
                      (index) =>
                          CategoryCard(index: favoritesModel.getItems()[index]),
                    ).withSpaceBetween(height: 12.h),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
