import 'package:easacc_app/core/utils/ui/app_bar.dart';
import 'package:flutter/material.dart';

class LinkView extends StatelessWidget {
  const LinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "Link View", isLeading: true));
  }
}
