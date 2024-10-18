import 'dart:ui';

import 'package:flutter/material.dart';

// gets the size dimensions of any device using the app
FlutterView _view = WidgetsBinding.instance.platformDispatcher.views.first;

class Device {
  static Size get screenSize => _view.physicalSize / _view.devicePixelRatio;
}
