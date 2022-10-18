// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:sizer/sizer.dart';

import '../../core/themes/colors.dart';
import '../widgets/drawers/drawer_widget.dart';
import '../widgets/appbar/leading_widget.dart' show LeadingMenuIconButton;
import '../widgets/floadfile/desktop_widgets.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final Widget? floatActionButton;
  final Widget? bottomNavigationBar;
  // final CustomAppBar? appBar;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool? returnBackExit;
  final bool? activeDrawer;
  final bool activeScroll;
  final bool expanded;

  BaseScreen(
      {Key? key,
      required this.child,
      this.floatActionButton,
      this.bottomNavigationBar,
      this.padding = const EdgeInsets.all(10),
      // this.appBar,
      this.backgroundColor,
      this.returnBackExit,
      this.activeDrawer,
      this.activeScroll = false,
      this.expanded = false})
      : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      drawer: DefaultDrawer(),
      body: WindowBorder(
        color: FloadFileColors.borderWindows,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [...FloadFileColors.gradientScreen],
                stops: [0.0, 1.0]),
          ),
          child: ListView(shrinkWrap: widget.expanded, children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: LeadingMenuIconButton(),
                ),
                Expanded(child: WindowTitleBarBox(child: MoveWindow())),
                WindowButtons()
              ],
            ),
            Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.expanded ? SizedBox(
                  height: 80.w,
                  child: widget.child) : widget.child,
            ),
          ]),
        ),
      ),
      floatingActionButton: widget.floatActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
