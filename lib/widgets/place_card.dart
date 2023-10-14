import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/models/categories.dart';
import 'package:go_to_vienna/utils/utils.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.place,
    this.onTap,
    this.isFavorite = false,
    this.onLike,
    this.locked = false,
  }) : super(key: key);

  final Place place;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 332.w,
            height: 124.h,
            decoration: BoxDecoration(
              color: ThemeColors.grayRed,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Image.asset(
                        place.asset,
                        width: 124.w,
                        height: 124.h,
                      ),
                      Visibility(
                        visible: locked,
                        child: Container(
                          width: 124.w,
                          height: 124.h,
                          color: ThemeColors.dark.withOpacity(0.5),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/icons/lock.png',
                            width: 64.w,
                            height: 64.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          place.title,
                          style: TextStyles.dark15.copyWith(height: 1),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          place.text,
                          style: TextStyles.dark12,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/eye.png',
                              width: 12.w,
                              height: 12.h,
                            ),
                            SizedBox(width: 4.w),
                            Text('21512', style: TextStyles.gray10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12.h,
            left: 12.w,
            child: Visibility(
              visible: !locked,
              child: GestureDetector(
                onTap: locked ? null : onLike,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.dark.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    isFavorite
                        ? 'assets/images/icons/star_red.png'
                        : 'assets/images/icons/star_white.png',
                    width: 12.w,
                    height: 12.h,
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
