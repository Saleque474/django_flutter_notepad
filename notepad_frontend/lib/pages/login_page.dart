import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/main.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/home/home.dart';

import '../api/auth/auth_api.dart';
import '../models/user_cubit.dart';
import '../theme.dart';
import '../widgets/fields.dart';
import '../widgets/texxt_button.dart';
import 'forget_pass.dart';
import 'register_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 50),
          //   child: Image.asset(
          //     'assets/img_login.png',
          //   ),
          // ),
          SizedBox(
            height: 155,
          ),
          CustomField(
            controller: emailController,
            iconUrl: 'assets/icon_email.png',
            hint: 'Email',
          ),
          CustomField(
            controller: passwordController,
            iconUrl: 'assets/icon_password.png',
            hint: 'Password',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
          ),
          // Login
          CustomTextButton(
            onTap: () async {
              var authRes =
                  await userAuth(emailController.text, passwordController.text);
              if (authRes.runtimeType == String) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          width: 250,
                          decoration: BoxDecoration(),
                          child: Text(authRes)),
                    );
                  },
                );
              } else if (authRes.runtimeType == User) {
                User user = authRes;
                context.read<UserCubit>().emit(user);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ));
              }
            },
            title: 'Login',
            margin: EdgeInsets.only(top: 50),
          ),
          //
          Container(
            margin: EdgeInsets.only(
              top: 30,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register now.",
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
