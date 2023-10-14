import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/main.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/screens/premium_view.dart';
import 'package:go_to_vienna/utils/links.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:go_to_vienna/widgets/settings_button.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(
      builder: (BuildContext context, value, Widget? child) {
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
                  'Settings',
                  textAlign: TextAlign.left,
                  style: TextStyles.dark27,
                ),
                SizedBox(height: 16.h),
                SettingsButton(
                  title: 'Privacy policy',
                  onTap: () => launchUri(Links.privacyPolicy),
                ),
                SizedBox(height: 12.h),
                SettingsButton(
                  title: 'Terms of use',
                  onTap: () => launchUri(Links.termsOfUse),
                ),
                SizedBox(height: 12.h),
                SettingsButton(
                  title: 'Support',
                  onTap: () => launchUri(Links.support),
                ),
                SizedBox(height: 12.h),
                Visibility(
                  visible: !value.isPremium,
                  child: SettingsButton(
                    title: 'Restore purchases',
                    onTap: () => _onRestore(value, context),
                  ),
                ),
                SizedBox(height: 16.h),
                Visibility(
                  visible: !value.isPremium,
                  child: GestureDetector(
                    onTap: () => _onTapPremium(context),
                    child: Container(
                      width: 332.w,
                      height: 122.h,
                      decoration: BoxDecoration(
                        color: ThemeColors.grayRed,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/categories/premium.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 16.h,
                          bottom: 12.h,
                          left: 16.w,
                          right: 190.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gain full access', style: TextStyles.red27),
                            SizedBox(height: 4.h),
                            Text(
                              'for only \$0.99',
                              style: TextStyles.red15.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onRestore(PlaceProvider provider, BuildContext context) async {
    final res = await Apphud.restorePurchases();
    if (res.purchases.map((e) => e.isActive).contains(true)) {
      provider.onBuyPremium();
    }
  }

  void _onTapPremium(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => const PremiumScreen(),
    );

    Navigator.of(context, rootNavigator: true).push(route);
  }
}
