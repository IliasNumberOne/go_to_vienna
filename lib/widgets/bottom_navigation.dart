import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  final bool hasBottomBar;

  const BottomNavigation({
    Key? key,
    required this.child,
    this.hasBottomBar = true,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selected = 0;

  void _onTap(int index, String path) {
    setState(() {
      _selected = index;
      context.go(path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TopModel>(
      builder: (
          BuildContext context,
          TopModel topModel,
          Widget? child,
          ) {
        return Material(
          color: ThemeColors.white,
          child: Column(
            children: [
              Expanded(child: widget.child),
              Visibility(
                visible: widget.hasBottomBar,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: topModel.isVisible ? 80.h : 0,
                  curve: Curves.easeInOut,
                  child: Container(
                    height: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        tapBarItems.length,
                            (index) {
                          return GestureDetector(
                            onTap: () => _onTap(index, tapBarItems[index].path),
                            child: Image.asset(
                              index == _selected
                                  ? tapBarItems[index].selectedImg
                                  : tapBarItems[index].regularImg,
                              width: 52.w,
                              height: 52.h,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );

  }
}
