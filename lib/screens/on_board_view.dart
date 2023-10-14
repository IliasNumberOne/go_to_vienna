import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<String> texts = [
    'Our app will help you find the top places to visit in this magical city.',
    "We offer you top places in every city. Discover new adventures with Let's go to Vienna.",
    "Your reliable guide in the world of entertainment and discovery! Our top places are waiting for you. Seize the moment and go on a journey",
  ];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            SizedBox(
              width: 332.w,
              child: Text(
                "Travel with us",
                style: TextStyles.dark27,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: List.generate(
                  texts.length,
                  (index) => Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'assets/images/on_boarding/image${index + 1}.png',
                          width: 332.w,
                          height: 364.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 332.w,
                        child: Text(
                          texts[index],
                          style: TextStyles.dark19.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                if (currentIndex == texts.length - 1) {context.go('/')},
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              },
              child: Container(
                width: 332.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: ThemeColors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    currentIndex + 1 == texts.length ? 'Start' : 'Next',
                    textAlign: TextAlign.center,
                    style: TextStyles.white15,
                  ),
                ),
              ),
            ),
            SizedBox(height: 58.h),
          ],
        ),
      ),
    );
  }
}
