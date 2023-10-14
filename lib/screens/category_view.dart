import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (
        BuildContext context,
        PlaceProvider provider,
        Widget? child,
      ) {
        return Padding(
          padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
          child: Column(
            children: [
              Row(
                children: [
                  BackBtn(),
                  SizedBox(
                    width: 72.w,
                  ),
                  Text(
                    provider.selectedCategory.name,
                    textAlign: TextAlign.center,
                    style: TextStyles.dark19,
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.places.length,
                  itemBuilder: (context, index) {
                    final place = provider.places[index];
                    final locked = place.isPremium && !provider.isPremium;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: PlaceCard(
                        place: place,
                        locked: locked,
                        onLike: () => provider.onLike(place.id),
                        isFavorite: provider.favoritesId.contains(place.id),
                        onTap: () {
                          if(locked) {
                            _onTapPremium(context);
                            return;
                          }
                          provider.selectPlace(place);
                          context.go('/category_screen/full_screen');
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }

  void _onTapPremium(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => PremiumScreen(),
    );

    Navigator.of(context, rootNavigator: true).push(route);
  }
}
