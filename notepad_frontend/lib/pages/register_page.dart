import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/auth/auth_api.dart';
import 'package:notepad_frontend/models/user_cubit.dart';
import 'package:notepad_frontend/pages/home/home.dart';
import 'package:notepad_frontend/widgets/fields.dart';
import 'package:notepad_frontend/widgets/texxt_button.dart';

import '../models/user_models.dart';
import '../theme.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              "Register",
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CustomField(
            iconUrl: 'assets/icon_name.png',
            hint: 'Nickname',
            controller: nicknameController,
          ),
          CustomField(
            iconUrl: 'assets/icon_email.png',
            hint: 'Email',
            controller: emailController,
          ),
          CustomField(
            iconUrl: 'assets/icon_password.png',
            hint: 'Password',
            controller: passwordController,
            obsecure: true,
          ),
          CustomField(
            iconUrl: 'assets/icon_password.png',
            hint: 'Confirm Password',
            controller: comfirmPassword,
            obsecure: true,
          ),
          CustomTextButton(
            title: 'Register',
            margin: EdgeInsets.only(top: 50),
            onTap: () async {
              var authRes = await registerUser(
                  emailController.text,
                  nicknameController.text,
                  passwordController.value.text,
                  comfirmPassword.text);

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
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text(
                    "Have an account? Login",
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
