import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news/features/auth/presentation/screen/login/cubit/login_cubit.dart';
import 'package:news/features/auth/presentation/screen/login/login_screen.dart';
import 'package:news/features/auth/presentation/screen/register/cubit/register_cubit.dart';
import 'package:news/features/auth/presentation/screen/register/register_screen.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';
import 'package:news/features/news/presentation/detail/detail_screen.dart';
import 'package:news/features/news/presentation/list/cubit/list_cubit.dart';
import 'package:news/features/news/presentation/list/list_screen.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news/features/settings/presentation/screen/settings_screen.dart';
import 'package:news/injection.dart';

enum Nav {
  home('/'),
  login('/login'),
  register('/register'),
  settings('/settings'),
  detail('/detail');

  final String path;

  const Nav(this.path);
}

class Navigation {
  final SettingsCubit settings;

  Navigation(this.settings);

  // Fallback untuk menjaga data artikel saat router refresh/rebuild
  NewsEntity? _selectedNews;

  late final router = GoRouter(
    initialLocation: Nav.home.path,
    refreshListenable: GoRouterRefreshStream(settings.stream),
    // refreshListenable: GoRouterRefreshStream(
    //   settings.stream.map((state) => state.isAuth).distinct(),
    // ),
    redirect: (context, route) {
      final isAuthenticated = settings.state.isAuth;
      final isGoingToLogin = route.matchedLocation == Nav.login.path;
      final isGoingToRegister = route.matchedLocation == Nav.register.path;

      // Jika belum login dan tidak menuju login atau register arahkan ke login
      if (!isAuthenticated && !(isGoingToLogin || isGoingToRegister)) {
        return Nav.login.path;
      }

      // Jika sudah login dan menuju login atau register arahkan ke home
      if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
        return Nav.home.path;
      }

      // Lanjutkan navigasi
      return null;
    },
    routes: [
      GoRoute(
        path: Nav.home.path,
        name: Nav.home.name,
        builder: (context, state) => BlocProvider(
          create: (context) => inject<ListCubit>(),
          child: const ListScreen(),
        ),
      ),
      GoRoute(
        path: Nav.login.path,
        name: Nav.login.name,
        builder: (context, state) => BlocProvider(
          create: (context) => inject<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Nav.register.path,
        name: Nav.register.name,
        builder: (context, state) => BlocProvider(
          create: (context) => inject<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Nav.settings.path,
        name: Nav.settings.name,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: Nav.detail.path,
        name: Nav.detail.name,
        builder: (context, state) {
          // Jika extra ada, simpan ke fallback
          if (state.extra is NewsEntity) {
            _selectedNews = state.extra as NewsEntity;
          }

          // Gunakan fallback jika extra null (misal saat rebuild/theme change)
          if (_selectedNews == null) {
            return const Scaffold(
              body: Center(child: Text('Error: Article data not found')),
            );
          }

          return DetailScreen(news: _selectedNews!);
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
