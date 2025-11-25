import 'package:easacc_app/features/auth/presentation/views/login_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
    ],
  );
}
