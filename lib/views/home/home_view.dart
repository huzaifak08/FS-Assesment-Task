import 'package:flutter/material.dart';
import 'package:fs_task_assesment/models/user.dart';
import 'package:fs_task_assesment/services/user_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home View")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserModel user = UserModel(
              uid: 'sadasd',
              name: 'dfdfdf',
              email: 'dfdf',
              password: 'dfdfdf',
            );
            await UserService().saveUserData(user: user);
          },
          child: Text("Save to DB"),
        ),
      ),
    );
  }
}
