import 'package:flutter/material.dart';
import 'package:fs_task_assesment/models/user.dart';

class AppData extends ChangeNotifier {
  static final AppData shared = AppData();

  // Global Context:
  final navigatorKey = GlobalKey<NavigatorState>();

  UserModel? user;
}
