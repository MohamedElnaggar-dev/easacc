import 'package:easacc_app/core/utils/constants/app_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.text,
  });
  final void Function()? onTap;
  final bool isLoading;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          height: AppDimensions.buttonHeight,
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.medium,
            horizontal: AppPadding.small,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
          child: Center(
            child: isLoading
                ? const CupertinoActivityIndicator(color: Colors.white)
                : Text(
                    text,
                    style: AppStyles.semiBold(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
