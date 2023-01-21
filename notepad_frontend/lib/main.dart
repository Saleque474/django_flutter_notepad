import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad_frontend/api/auth/auth_api.dart';
import 'package:notepad_frontend/models/user_cubit.dart';
import 'package:notepad_frontend/pages/home/home.dart';

import 'constants.dart';
import 'models/user_models.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserCubit(User());
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<Box>(
            future: Hive.openBox(tokenBox),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var box = snapshot.data;
                var token = box!.get("token");
                if (token != null) {
                  return FutureBuilder<User?>(
                      future: getUser(token),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            User user = snapshot.data!;
                            user.token = token;
                            context.read<UserCubit>().emit(user);
                            return const HomePage();
                          } else {
                            return const SignInPage();
                          }
                        } else {
                          return const SignInPage();
                        }
                      });
                } else {
                  return const SignInPage();
                }
              } else if (snapshot.hasError) {
                return const SignInPage();
              } else {
                return const SignInPage();
              }
            }),
      ),
    );
  }
}
