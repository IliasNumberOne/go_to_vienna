import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_to_vienna/providers/top_model.dart';
import 'package:go_to_vienna/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TopModel>(
      builder: (
        BuildContext context,
        TopModel topModel,
        Widget? child,
      ) {
        return PageView(
          onPageChanged: (index) => topModel.pageChanges(),
          children: List.generate(
            topItems.length,
            (index) {
              final topItem = topItems[index];
              return SlidingUpPanel(
                color:
                    topModel.isVisible ? Colors.transparent : ThemeColors.white,
                boxShadow: const [],
                parallaxEnabled: true,
                minHeight: 130.h,
                maxHeight: 472.h,
                controller: topModel.panelController,
                onPanelOpened: () => topModel.openPanel(),
                onPanelClosed: () => topModel.closePanel(),
                borderRadius: topModel.isVisible
                    ? null
                    : const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                panel: Container(
                  width: 390.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 24.h,
                  ),
                  child: SingleChildScrollView(
                    physics: topModel.isVisible
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          topItem.title,
                          style: TextStyles.dark27,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          topItem.text,
                          style: TextStyles.gray12,
                        ),
                      ],
                    ),
                  ),
                ),
                body: SizedBox(
                  width: 390.w,
                  height: 844.h,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, ThemeColors.white],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, 750));
                    },
                    blendMode: BlendMode.dstOut,
                    child: Image.asset(
                      topItem.asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
