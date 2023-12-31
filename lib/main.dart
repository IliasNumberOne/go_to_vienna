import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/providers/place_provider.dart';
import 'package:go_to_vienna/providers/top_model.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/screens/splash_screen.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUri(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preference = await SharedPreferences.getInstance();

  await Apphud.start(apiKey: 'app_YrjhdGdTA14xSZX6m8yWFKqhawBfXQ');
  final PreferenceService preferenceService = PreferenceService(preference);
  bool initScreen = preferenceService.getIsFirstEntry();
  await preferenceService.setIsFirstEntry();
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return GoToVienna(
          preferenceService: preferenceService,
          initScreen: initScreen,
        );
      },
    ),
  );
}

class GoToVienna extends StatefulWidget {
  final PreferenceService preferenceService;
  final bool initScreen;

  const GoToVienna({
    Key? key,
    required this.preferenceService,
    required this.initScreen,
  }) : super(key: key);

  @override
  State<GoToVienna> createState() => _GoToViennaState();
}

class _GoToViennaState extends State<GoToVienna> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/splash_screen',
      routes: [
        GoRoute(
          path: '/splash_screen',
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: SplashScreen(initScreen: widget.initScreen),
            );
          },
        ),
        ShellRoute(
          pageBuilder: (context, state, child) {
            final hasBottomBar = !state.fullPath!.contains('full_screen');
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: BottomNavigation(
                hasBottomBar: hasBottomBar,
                child: child,
              ),
            );
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const MainScreen(),
                );
              },
              routes: [
                GoRoute(
                    path: 'category_screen',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const CategoryScreen(),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'full_screen',
                        pageBuilder: (context, state) {
                          return buildPageWithDefaultTransition(
                            context: context,
                            state: state,
                            child: const FullScreen(),
                          );
                        },
                      ),
                    ]),
                GoRoute(
                  path: 'full_screen',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const FullScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/favorites_screen',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const FavoritesScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'full_screen',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const FullScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/top',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const TopScreen(),
                );
              },
            ),
            GoRoute(
              path: '/random',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const RandomScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'random_count',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const RandomCountScreen(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'category_screen',
                      pageBuilder: (context, state) {
                        return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const CategoryScreen(),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'full_screen',
                          pageBuilder: (context, state) {
                            return buildPageWithDefaultTransition(
                              context: context,
                              state: state,
                              child: const FullScreen(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const SettingsScreen(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/premium_screen',
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: PremiumScreen(),
            );
          },
        ),
        GoRoute(
          path: '/on_boarding_screen',
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const OnBoardingScreen(),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) => widget.preferenceService,
          ),
          ChangeNotifierProvider(
            create: (context) => PlaceProvider(
              preferenceService: widget.preferenceService,
            )..init(),
          ),
          ChangeNotifierProvider(
            create: (context) => TopModel(),
          ),
        ],
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            theme: ThemeData(fontFamily: 'Montserrat'),
            routerConfig: _router,
          );
        });
  }
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool opaque = true,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    opaque: opaque,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
