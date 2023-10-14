import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/utils/utils.dart';

class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    this.onChanged,
    this.controller,
    required this.focusNode,
  });

  final void Function(String query)? onChanged;
  final TextEditingController? controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: 336.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Image.asset(
                'assets/images/icons/search.png',
                width: 24.w,
                height: 24.h,
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.gray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
