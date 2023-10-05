import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/utils/utils.dart';

class RandomScreen extends StatelessWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Random',
            textAlign: TextAlign.left,
            style: TextStyles.dark27,
          ),
          SizedBox(height: 24.h),
          GridView.builder(
            shrinkWrap: true,
            itemCount: categories2.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {
                  context.pushNamed(
                    'random_count',
                    pathParameters: {'id': '$index'},
                  ),
                },
                child: Container(
                  width: 156.w,
                  height: 148.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                        image: AssetImage(categories2[index].asset),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      bottom: 16.h,
                      right: 65.w,
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      categories2[index].name,
                      style: TextStyles.red19,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
