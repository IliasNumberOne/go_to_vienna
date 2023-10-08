import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.initScreen,
  });

  final int? initScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final path = widget.initScreen == 0 || widget.initScreen == null
        ? '/on_boarding_screen'
        : '/';
    Future.delayed(const Duration(milliseconds: 500), () {
      context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/loading.png',
      width: 390.w,
      height: 844.h,
      fit: BoxFit.cover,
    );
  }
}
