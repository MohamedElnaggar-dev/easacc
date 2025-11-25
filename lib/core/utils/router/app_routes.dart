import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits_app/core/utils/injector/get_it.dart';
import 'package:suits_app/features/auth/presentation/manger/forget_password_cubit/forget_password_cubit.dart';
import 'package:suits_app/features/auth/presentation/manger/otp_cubit/otp_cubit.dart';
import 'package:suits_app/features/auth/presentation/manger/signin_cubit/signin_cubit.dart';
import 'package:suits_app/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:suits_app/features/auth/presentation/view/create_new_password_view.dart';
import 'package:suits_app/features/auth/presentation/view/forget_password_view.dart';
import 'package:suits_app/features/auth/presentation/view/login_view.dart';
import 'package:suits_app/features/auth/presentation/view/signup_view.dart';
import 'package:suits_app/features/auth/presentation/view/verification_code_view.dart';
import 'package:suits_app/features/cart/presentation/views/cart_view.dart';
import 'package:suits_app/features/get_started/presentation/view/get_started_view.dart';
import 'package:suits_app/features/home/presentation/view/home_view.dart';
import 'package:suits_app/features/home/presentation/view/product_details_view.dart';
import 'package:suits_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:suits_app/features/splash/presentation/view/splash_view.dart';
import 'package:suits_app/root.dart';

abstract class AppRouter {
  static const kOnboardingView = '/onboardingView';
  static const kGetStartedView = '/getStartedView';
  static const kLoginView = '/loginView';
  static const kSignupView = '/signupView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kVerificationCodeView = '/verificationCodeView';
  static const kCreateNewPasswordView = '/createNewPasswordView';
  static const kHomeView = '/homeView';
  static const kExploreView = '/exploreView';
  static const kProfileView = '/profileView';
  static const kProductDetailsView = '/productDetailsView';
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shell',
  );
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kGetStartedView,
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => injector<SigninCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => BlocProvider(
          create: (context) => injector<SignupCubit>(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => injector<OtpCubit>(),
          child: const ForgetPasswordView(),
        ),
      ),
      GoRoute(
        path: kVerificationCodeView,
        builder: (context, state) => BlocProvider(
          create: (context) => injector<OtpCubit>(),
          child: const VerificationCodeView(),
        ),
      ),
      GoRoute(
        path: kCreateNewPasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => injector<ForgetPasswordCubit>(),
          child: const CreateNewPasswordView(),
        ),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) => const ProductDetailsView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Root(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: kHomeView,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kExploreView,
                builder: (context, state) => const CartView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kProfileView,
                builder: (context, state) =>
                    const Scaffold(body: Center(child: Text('Profile'))),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
