import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurvedAnimation(curve: Curves.elasticIn, parent: animation),
              child: child,
            );
          })),
  GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurvedAnimation(curve: Curves.elasticIn, parent: animation),
              child: child,
            );
          })),
]);
