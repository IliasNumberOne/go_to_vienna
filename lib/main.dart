import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_vienna/screens/screens.dart';
import 'package:go_to_vienna/screens/splash_screen.dart';
import 'package:go_to_vienna/services/preference_service.dart';
import 'package:go_to_vienna/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preference = await SharedPreferences.getInstance();
  final PreferenceService preferenceService = PreferenceService(preference);
  bool initScreen = preferenceService.getIsFirstEntry();
  await preferenceService.setIsFirstEntry();
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return GoToVienna(
          preferences: preference,
          initScreen: initScreen,
        );
      },
    ),
  );
}

class GoToVienna extends StatefulWidget {
  final SharedPreferences preferences;
  final bool initScreen;

  const GoToVienna({
    Key? key,
    required this.preferences,
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
            final hasBottomBar = (state.fullPath != '/full_screen/:id' &&
                state.fullPath != '/category_screen' &&
                state.fullPath != '/random/random_count' &&
                state.fullPath != '/premium_screen');
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
                ),
                GoRoute(
                  name: 'full_screen',
                  path: 'full_screen/:id',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: FullScreen(
                        id: int.parse(state.pathParameters['id']!),
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/favorite',
              pageBuilder: (context, state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const FavoritesScreen(),
                );
              },
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
                  name: 'random_count',
                  path: 'random_count/:id',
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: RandomCountScreen(
                        id: int.parse(state.pathParameters['id']!),
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      name: 'random_items',
                      path: 'random_items/:count',
                      pageBuilder: (context, state) {
                        return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: RandomItemsScreen(
                            count: int.parse(
                              state.pathParameters['count']!,
                            ),
                            id: int.parse(state.pathParameters['id']!),
                          ),
                        );
                      },
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
                  child: SettingsScreen(),
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
            create: (BuildContext context) =>
                PreferenceService(widget.preferences),
          ),
          ChangeNotifierProvider(
            create: (context) => MainModel(
              preferenceService: context.read<PreferenceService>(),
            )..getRandomItems(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryModel(
              preferenceService: context.read<PreferenceService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryCardModel(
              preferenceService: context.read<PreferenceService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoritesModel(
              preferenceService: context.read<PreferenceService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RandomItemsModel(
              preferenceService: context.read<PreferenceService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => TopModel(
              preferenceService: context.read<PreferenceService>(),
            ),
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
