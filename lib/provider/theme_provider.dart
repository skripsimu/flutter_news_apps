import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool isLight = false;
  ThemeData _dark = ThemeData(
    colorScheme: ColorScheme.dark(
      secondary: Colors.amber,
      primary: Colors.amber
    ),
  );
  ThemeData _light = ThemeData(
    colorScheme: ColorScheme.light(
      secondary: Colors.blue,
      onSecondary: Colors.white,
      primary: Colors.blue
    ),
  );

  ThemeData get theme => isLight ? _dark : _light;

  changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('theme', isLight.toString()));
  }
}
