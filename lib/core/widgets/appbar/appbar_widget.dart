import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar(
      {Key? key,
        required this.title,
        this.leading,
        this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
      title: Text(title),
      leading: leading,
      actions: actions,
    );
  }
}