import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends StatelessWidget {
  PremiumScreen({Key? key}) : super(key: key);

  final List<String> advantages = [
    'More locations',
    'Lack of advertising',
    'Random selection feature',
    'Unlimited number of saves',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Premium',
                  textAlign: TextAlign.left,
                  style: TextStyles.dark27,
                ),
                GestureDetector(
                  onTap: context.pop,
                  child: Container(
                    width: 33.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: ThemeColors.dark2.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/icons/close.png',
                      width: 16.5.w,
                      height: 16.h,
                      scale: 1.7,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/on_boarding/image1.png',
                width: 332.w,
                height: 364.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Text('Gain full access: ', style: TextStyles.dark27),
            SizedBox(height: 8.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                advantages.length,
                (index) => Text(
                  '${index + 1}. ${advantages[index]}',
                  style:
                      TextStyles.dark19.copyWith(fontWeight: FontWeight.w400),
                ),
              ).withSpaceBetween(height: 10.h),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () => {
                context.read<PreferenceService>().setIsPremium(true),
                context.go('/'),
              },
              child: Container(
                width: 332.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: ThemeColors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Buy premium for \$0,99',
                    textAlign: TextAlign.center,
                    style: TextStyles.white15,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Privacy policy',
                    style: TextStyles.red12,
                  ),
                  Text(
                    'Restore purchases',
                    style: TextStyles.red12,
                  ),
                  Text(
                    'Terms of use',
                    style: TextStyles.red12,
                  ),
                ].withSpaceBetween(width: 22.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
