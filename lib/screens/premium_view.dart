// ignore_for_file: use_build_context_synchronously

import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/main.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/utils/links.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final List<String> advantages = [
    'More locations',
    'Lack of advertising',
    'Random selection feature',
    'Unlimited number of saves',
  ];

  bool purchaseLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: 46.h, left: 28.w, right: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Premium',
                        textAlign: TextAlign.left,
                        style: TextStyles.dark27,
                      ),
                      GestureDetector(
                        onTap: context.pop,
                        child: Container(
                          width: 33.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: ThemeColors.dark2.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/icons/close.png',
                            width: 16.5.w,
                            height: 16.h,
                            scale: 1.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      'assets/images/on_boarding/image1.png',
                      width: 332.w,
                      height: 364.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('Gain full access: ', style: TextStyles.dark27),
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      advantages.length,
                      (index) => Text(
                        '${index + 1}. ${advantages[index]}',
                        style: TextStyles.dark19
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ).withSpaceBetween(height: 10.h),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => _onBuyPremium(provider),
                    child: Container(
                      width: 332.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: ThemeColors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Buy premium for \$0,99',
                          textAlign: TextAlign.center,
                          style: TextStyles.white15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => launchUri(Links.privacyPolicy),
                          child: Text(
                            'Privacy policy',
                            style: TextStyles.red12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _onRestore(provider),
                          child: Text(
                            'Restore purchases',
                            style: TextStyles.red12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launchUri(Links.termsOfUse),
                          child: Text(
                            'Terms of use',
                            style: TextStyles.red12,
                          ),
                        ),
                      ].withSpaceBetween(width: 22.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: purchaseLoading,
              child: const Material(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onRestore(PlaceProvider provider) async {
    final res = await Apphud.restorePurchases();
    if (res.purchases.map((e) => e.isActive).contains(true)) {
      provider.onBuyPremium();
      context.pop();
    }
  }

  void _onBuyPremium(PlaceProvider provider) async {
    setState(() {
      purchaseLoading = true;
    });
    var paywalls = await Apphud.paywalls();
    await Apphud.purchase(
      product: paywalls?.paywalls.first.products!.first,
    ).whenComplete(
      () async {
        if (await Apphud.hasActiveSubscription() ||
            await Apphud.hasPremiumAccess()) {
          provider.onBuyPremium();
          context.pop();
        }
      },
    );
    setState(() {
      purchaseLoading = false;
    });
  }
}
