// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easacc_app/core/utils/constants/app_styles.dart';
import 'package:easacc_app/core/utils/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool isLeading;

  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.actions,
    required this.isLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title ?? '',
        style: AppStyles.semiBold(color: Colors.black, fontSize: 20),
      ),
      centerTitle: centerTitle,
      leading: isLeading == true
          ? GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.replace(AppRoutes.kSettingView);
                }
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black),
            )
          : null,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
