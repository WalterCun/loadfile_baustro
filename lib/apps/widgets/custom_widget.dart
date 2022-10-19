import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../../core/animated/section_animated.dart';

class SwitchCustomTile extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const SwitchCustomTile({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  State<SwitchCustomTile> createState() => _SwitchCustomTileState();
}

class _SwitchCustomTileState extends State<SwitchCustomTile> {
  bool switchT = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTile.switchTile(
          title: widget.title,
          onToggle: (switchValue) {
            setState(() {
              switchT = switchValue;
            });
          },
          switchValue: switchT,
        ),
        ExpandedSection(
            expand: switchT,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: widget.children,
              ),
            )),
      ],
    );
  }
}
