import 'package:easacc_app/features/auth/presentation/manger/signin_cubit/signin_cubit.dart';
import 'package:easacc_app/features/auth/presentation/views/login_view.dart';
import 'package:easacc_app/features/link_view/presentation/view/link_view.dart';
import 'package:easacc_app/features/setting/presentation/views/setting_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const kSettingView = '/settingView';
  static const kLinkView = '/linkView';
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => SigninCubit(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kSettingView,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(path: kLinkView, builder: (context, state) => const LinkView()),
    ],
  );
}
