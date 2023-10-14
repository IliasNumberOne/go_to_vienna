import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/utils/utils.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.pop,
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: ThemeColors.dark2.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          'assets/images/icons/arrow_left.png',
          width: 16.w,
          height: 16.h,
          scale: 1.7,
        ),
      ),
    );
  }
}
