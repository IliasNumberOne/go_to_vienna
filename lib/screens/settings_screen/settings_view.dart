import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final List<String> links = [
    'Privacy policy',
    'Terms of use',
    'Support',
    'Restore purchases',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            textAlign: TextAlign.left,
            style: TextStyles.dark27,
          ),
          SizedBox(height: 16.h),
          Column(
            children: List.generate(
              links.length,
              (index) => GestureDetector(
                onTap: () => {},
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(links[index], style: TextStyles.red15),
                      Image.asset(
                        'assets/images/icons/arrow_right_red.png',
                        width: 16.w,
                        height: 16.h,
                      )
                    ],
                  ),
                ),
              ),
            ).withSpaceBetween(height: 12.h),
          ),
          SizedBox(height: 16.h),
          Visibility(
            visible: !context.read<PreferenceService>().getIsPremium(),
            child: GestureDetector(
              onTap: () => {context.go('/premium_screen')},
              child: Container(
                width: 332.w,
                height: 122.h,
                decoration: BoxDecoration(
                  color: ThemeColors.grayRed,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/categories/premium.png'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                    bottom: 12.h,
                    left: 16.w,
                    right: 190.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gain full access', style: TextStyles.red27),
                      SizedBox(height: 4.h),
                      Text(
                        'for only \$0.99',
                        style: TextStyles.red15.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
