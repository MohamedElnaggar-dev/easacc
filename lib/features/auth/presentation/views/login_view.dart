import 'package:easacc_app/core/utils/constants/app_assets.dart';
import 'package:easacc_app/features/auth/presentation/widgets/custom_login_with_accouts.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLoginWithAccouts(
              text: 'Sign in with google',
              image: Assets.imagesGoogle,
            ),
            SizedBox(height: 32),
            CustomLoginWithAccouts(
              text: 'Sign in with facebook',
              image: Assets.imagesFacebook,
            ),
          ],
        ),
      ),
    );
  }
}
