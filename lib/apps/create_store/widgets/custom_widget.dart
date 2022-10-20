import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../../../core/animated/section_animated.dart';

class SwitchCustomTile extends StatefulWidget {
  final String title;
  bool initValue;
  bool keepState;
  final List<Widget> children;

  SwitchCustomTile({
    Key? key,
    required this.title,
    this.initValue = false,
    this.keepState = false,
    required this.children,
  }) : super(key: key);

  @override
  State<SwitchCustomTile> createState() => _SwitchCustomTileState();
}

class _SwitchCustomTileState extends State<SwitchCustomTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTile.switchTile(
          title: widget.title,
          onToggle: (switchValue) {
            setState(() {
              widget.initValue = switchValue;
            });
          },
          switchValue: widget.keepState ? true : widget.initValue,
        ),
        ExpandedSection(
            expand: widget.keepState ? true : widget.initValue,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: widget.children,
              ),
            )),
      ],
    );
  }
}
