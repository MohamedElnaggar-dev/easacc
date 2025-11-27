import 'dart:developer';

import 'package:easacc_app/core/utils/constants/app_assets.dart';
import 'package:easacc_app/core/utils/router/app_routes.dart';
import 'package:easacc_app/core/utils/ui/show_snak_bar.dart';
import 'package:easacc_app/features/auth/presentation/manger/signin_cubit/signin_cubit.dart';
import 'package:easacc_app/features/auth/presentation/widgets/custom_login_with_accouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            context.go(AppRoutes.kSettingView);
          } else if (state is SigninFailure) {
            showSnakBar(context, state.errorMessage, isError: true);
            log(state.errorMessage);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoginWithAccouts(
                  onTap: () {
                    BlocProvider.of<SigninCubit>(context).signInWithGoogle();
                  },
                  text: 'Sign in with google',
                  image: Assets.imagesGoogle,
                ),
                SizedBox(height: 32),
                CustomLoginWithAccouts(
                  onTap: () {
                    BlocProvider.of<SigninCubit>(context).signInWithFacebook();
                  },
                  text: 'Sign in with facebook',
                  image: Assets.imagesFacebook,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
