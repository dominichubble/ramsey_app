import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Theme.of(context).primaryColor,
      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
