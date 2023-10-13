import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<MainModel, CategoryModel>(
      builder: (
        BuildContext context,
        MainModel mainModel,
        CategoryModel categoryModel,
        Widget? child,
      ) {
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 46.h, bottom: 24.h),
                decoration: BoxDecoration(
                  color: ThemeColors.red2,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/main_bg.png'),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchBar(
                      onChanged: (String query) => {mainModel.searchItems(query)},
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                      constraints:
                          BoxConstraints(maxWidth: 336.w, maxHeight: 48.h),
                      leading: Image.asset(
                        'assets/images/icons/search.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      hintText: 'Search',
                      hintStyle: MaterialStatePropertyAll(
                        TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.gray,
                        ),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(ThemeColors.white),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            context.go('/category_screen'),
                            categoryModel.openPage(0),
                          },
                          child: Container(
                              width: 180.w,
                              height: 76.h,
                              decoration: BoxDecoration(
                                color: ThemeColors.grayRed,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(categories[0].asset),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  bottom: 12.h,
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  categories[0].name,
                                  style: TextStyles.red15,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        GestureDetector(
                          onTap: () => {
                            context.go('/category_screen'),
                            categoryModel.openPage(1),
                          },
                          child: Container(
                              width: 144.w,
                              height: 76.h,
                              decoration: BoxDecoration(
                                color: ThemeColors.grayRed,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(categories[1].asset),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  bottom: 12.h,
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  categories[1].name,
                                  style: TextStyles.red15,
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        categories.length - 2,
                        (index) => GestureDetector(
                          onTap: () => {
                            context.go('/category_screen'),
                            categoryModel.openPage(index + 2),
                          },
                          child: Container(
                            width: 104.w,
                            height: 76.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                      AssetImage(categories[index + 2].asset),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              width: 20.w,
                              padding: EdgeInsets.only(
                                left: 12.w,
                                bottom: 12.h,
                                right: 20.w,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                categories[index + 2].name,
                                style: TextStyles.red15,
                              ),
                            ),
                          ),
                        ),
                      ).withSpaceBetween(width: 12.w),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      mainModel.randomItems.length,
                      (index) =>
                          CategoryCard(index: mainModel.randomItems[index]),
                    ).withSpaceBetween(height: 12.h),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
