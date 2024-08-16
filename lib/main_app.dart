import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/routes_manager.dart';
import 'package:news_connect/src/common/resources/theme_manager.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:news_connect/src/features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:news_connect/src/features/authentication/presentation/screens/login_page.dart';
import 'package:news_connect/src/features/main/presentation/screens/main_page.dart';

import 'src/features/authentication/domain/repository/user_repo.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            onGenerateRoute: RouteGenerator.getRoute,
            navigatorKey: navigatorKey,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                  child: const MainPage(),
                );
              } else {
                return BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                  child: const LoginPage(),
                );
                // return const LoginPage();
              }
            }),
          );
        },
      ),
    );
  }
}
