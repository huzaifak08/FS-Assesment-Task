import 'package:flutter/material.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/models/user.dart';
import 'package:fs_task_assesment/services/user_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home View")),
      body: Center(
        child: Column(
          children: [
            Text(userModel?.name ?? "NO Name"),
            Text(userModel?.email ?? "NO Email"),

            ElevatedButton(
              onPressed: () async {
                UserModel? user = await UserService().getUserData(
                  userId: AppData.shared.user?.uid ?? '',
                );
                setState(() {
                  userModel = user;
                });
              },
              child: Text("Save to DB"),
            ),
          ],
        ),
      ),
    );
  }
}
