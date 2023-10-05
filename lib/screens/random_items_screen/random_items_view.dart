import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RandomItemsScreen extends StatelessWidget {
  final int count;
  final int id;

  const RandomItemsScreen({Key? key, required this.count, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomItemsModel>(
      builder: (
        BuildContext context,
        RandomItemsModel randomItemsModel,
        Widget? child,
      ) {
        return Padding(
          padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
          child: Column(
            children: [
              Row(
                children: [
                  BackBtn(myContext: context),
                  SizedBox(width: 72.w),
                  Text(
                    categories2[id].name,
                    textAlign: TextAlign.center,
                    style: TextStyles.dark19,
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      count,
                      (index) => CategoryCard(
                        index: randomItemsModel.items[index],
                      ),
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
