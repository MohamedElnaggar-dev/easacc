import 'package:easacc_app/features/auth/presentation/views/login_view.dart';
import 'package:easacc_app/features/link_view/presentation/view/link_view.dart';
import 'package:easacc_app/features/setting/presentation/views/setting_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const kHomeView = '/home';
  static const kLinkView = '/linkView';
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(path: kLinkView, builder: (context, state) => const LinkView()),
    ],
  );
}
