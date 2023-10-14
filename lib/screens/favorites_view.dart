import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (
        BuildContext context,
        PlaceProvider value,
        Widget? child,
      ) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              left: 28.w,
              right: 28.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Favorite',
                  textAlign: TextAlign.left,
                  style: TextStyles.dark27,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.favorites.length,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    itemBuilder: (context, index) {
                      final place = value.favorites[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: PlaceCard(
                          isFavorite: true,
                          onLike: () => value.onLike(place.id),
                          onTap: () {
                            value.selectPlace(place);
                            context.go('/favorites_screen/full_screen');
                          },
                          place: place,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
