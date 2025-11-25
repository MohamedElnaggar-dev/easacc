import 'package:easacc_app/core/utils/constants/app_dimensions.dart';
import 'package:easacc_app/core/utils/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomLoginWithAccouts extends StatelessWidget {
  const CustomLoginWithAccouts({
    super.key,
    required this.text,
    required this.image,
    this.onTap,
  });
  final String text;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Image.asset(image, width: 24, height: 24),
            ),
            const SizedBox(width: 24),
            Text(text, style: AppStyles.semiBold(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
