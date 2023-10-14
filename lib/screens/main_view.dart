import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PlaceProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => provider.init(),
    );
  }

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (
        BuildContext context,
        PlaceProvider value,
        Widget? child,
      ) {
        return Column(
          children: [
            Container(
              width: 390.w,
              decoration: BoxDecoration(
                color: ThemeColors.red2,
                image: const DecorationImage(
                  image: AssetImage('assets/images/main_bg.png'),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.scaleDown,
                ),
              ),
              padding: EdgeInsets.only(top: 15.h, bottom: 24.h),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    InputWidget(
                      focusNode: focusNode,
                      controller: controller,
                      onChanged: value.onSearch,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: 338.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryCard(
                            category: categories[0],
                            width: 180.w,
                            onTap: () {
                              value.selectCategory(categories[0]);
                              context.go('/category_screen');
                            },
                          ),
                          CategoryCard(
                            category: categories[1],
                            width: 144.w,
                            onTap: () {
                              value.selectCategory(categories[1]);
                              context.go('/category_screen');
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: 338.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryCard(
                            category: categories[2],
                            onTap: () {
                              value.selectCategory(categories[2]);
                              context.go('/category_screen');
                            },
                          ),
                          CategoryCard(
                            category: categories[3],
                            onTap: () {
                              value.selectCategory(categories[3]);
                              context.go('/category_screen');
                            },
                          ),
                          CategoryCard(
                            category: categories[4],
                            onTap: () {
                              value.selectCategory(categories[4]);
                              context.go('/category_screen');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.places.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 24.h,
                ),
                itemBuilder: (context, index) {
                  final place = value.places[index];
                  final locked = place.isPremium && !value.isPremium;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: PlaceCard(
                      place: place,
                      locked: locked,
                      isFavorite: value.favoritesId.contains(place.id),
                      onLike: () => value.onLike(place.id),
                      onTap: () {
                        if(locked) {
                          _onTapPremium(context);
                          return;
                        }
                        value.selectPlace(place);
                        context.go('/full_screen');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
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
