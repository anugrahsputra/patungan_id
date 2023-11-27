import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class BrightnessSwitch extends StatefulWidget {
  const BrightnessSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.color,
  });

  final Brightness value;
  final Color color;
  final Function(Brightness brightness) onChanged;

  @override
  State<BrightnessSwitch> createState() => _BrightnessSwitchState();
}

class _BrightnessSwitchState extends State<BrightnessSwitch> {
  final AppSettings theme = sl<AppSettings>();
  late Brightness currentValue;

  @override
  void initState() {
    super.initState();

    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: widget.color,
      onPressed: () {
        setState(() {
          if (currentValue == Brightness.dark) {
            currentValue = Brightness.light;
          } else {
            currentValue = Brightness.dark;
          }

          widget.onChanged(currentValue);
        });
      },
      icon: Icon(theme.isDarkMode() ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
