import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FullScreen extends StatelessWidget {
  final int id;

  const FullScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(
          categoryItems[id].asset,
          width: 390.w,
          height: 372.h,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 46.h,
          left: 30.w,
          child: BackBtn(myContext: context),
        ),
        Positioned(
          top: 350.h,
          child: Container(
            width: 390.w,
            height: 472.h,
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
            decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    categoryItems[id].title,
                    style: TextStyles.dark27,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    categoryItems[id].text,
                    style: TextStyles.dark15
                        .copyWith(fontWeight: FontWeight.w400, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
