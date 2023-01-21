import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/auth/auth_api.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/login_page.dart';

import '../../models/user_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Home of ${user.first_name} ${user.last_name} ${user.nickname}"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                await logOut(user.token!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInPage()),
                    (route) => false);
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
