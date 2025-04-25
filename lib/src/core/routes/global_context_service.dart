import 'package:flutter/material.dart';

class GlobalContextService {
  static BuildContext? context;

  static set setContext(value) => context = value;

  static BuildContext get getContext => context!;
}
