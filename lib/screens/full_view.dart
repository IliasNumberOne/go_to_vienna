import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.asset(
              value.place.asset,
              width: 390.w,
              height: 372.h,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 289.h),
                    Container(
                      width: 390.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 25.h,
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          Text(
                            value.place.title,
                            style: TextStyles.dark27,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            value.place.text,
                            style: TextStyles.dark15.copyWith(
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 46.h,
              left: 30.w,
              child: BackBtn(),
            ),
          ],
        );
      },
    );
  }
}
