import 'package:flutter/material.dart';

import '../theme.dart';

class CustomField extends StatelessWidget {
  final String iconUrl;
  final String hint;
  TextEditingController? controller;
  final bool obsecure;

  CustomField({
    this.controller,
    this.iconUrl = '',
    this.hint = '',
    this.obsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(
          color: kWhiteColor,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            height: 26,
            width: 26,
            margin: EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage(
                //     iconUrl,
                //   ),
                // ),
                ),
          ),
          Expanded(
            child: TextFormField(
              obscureText: obsecure,
              controller: controller,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              style: whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
