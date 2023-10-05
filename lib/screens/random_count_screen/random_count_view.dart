import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RandomCountScreen extends StatelessWidget {
  final int id;

  const RandomCountScreen({Key? key, required this.id}) : super(key: key);

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
                  SizedBox(width: 15.w),
                  Container(
                    width: 240.w,
                    child: Text(
                      'How many seats do you want to randomize?',
                      textAlign: TextAlign.center,
                      style: TextStyles.dark15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Column(
                children: List.generate(
                  4,
                      (index) => GestureDetector(
                    onTap: () => {
                      context.pushNamed(
                        'random_items',
                        pathParameters: {'id': '$id','count': '${index+1}'},
                      ),
                      randomItemsModel.getRandomIndex(id, index+1)
                    },
                    child: Container(
                      width: 332.w,
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: ThemeColors.grayRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1} place',
                            style: TextStyles.red15,
                          ),
                          Image.asset(
                            'assets/images/icons/arrow_right_red.png',
                            width: 16.w,
                            height: 16.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ).withSpaceBetween(height: 12.h),
              ),
            ],
          ),
        );
      },
    );
  }
}
