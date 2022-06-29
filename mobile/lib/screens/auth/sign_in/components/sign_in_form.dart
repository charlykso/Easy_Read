import 'dart:developer';

import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/services/google_auth.dart';
import 'package:easy_read/shared/util/my_winged_divider.dart';
import 'package:easy_read/shared/util/social_media_icon.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/shared/util/my_text_input_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextInputField(
              hintText: 'Email Address or Phone Number',
              onChanged: (String value) => setState(() => email = value),
              textInputType: TextInputType.text,
            ),
            MyTextInputField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              obscureText: true,
              onChanged: (String value) => setState(() => password = value),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: myDefaultSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: stayLoggedIn,
                          onChanged: (bool? value) =>
                              setState(() => stayLoggedIn = value!),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(myDefaultSize * 0.5),
                          ),
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                              getColor),
                        ),
                      ),
                      Text(
                        'Stay Logged In',
                        style: TextStyle(
                          fontSize: size.width > 360
                              ? myDefaultSize
                              : myDefaultSize * 0.8,
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Your Password?',
                      style: TextStyle(
                        fontSize: size.width > 360
                            ? myDefaultSize
                            : myDefaultSize * 0.8,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: myDefaultSize * 1.5),
              child: MyPrimaryButton(
                text: 'Sign In',
                bgColor: Colors.transparent,
                press: () {
                  if (email.trim().isEmpty || password.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: myAnimationDuration,
                        content: const Text(
                          'Invalid email address or password',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red[700],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: myAnimationDuration,
                        content: Text(
                          'It\'s valid for now!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: myPrimaryColor,
                      ),
                    );
                  }
                },
                height: myDefaultSize * 5,
                width: size.width,
              ),
            ),
            const MyWingedDivider(text: 'OR'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaIcon(
                  imagePath: 'assets/icons/google-plus.svg',
                  tap: signInWithGoogle,
                ),
                SocialMediaIcon(
                  imagePath: 'assets/icons/facebook.svg',
                  tap: () {},
                ),
              ],
            ),
          ],
        ));
  }

  signInWithGoogle() async {
    final dynamic user = await GoogleAuth.signIn();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: myAnimationDuration,
          backgroundColor: Colors.red[700],
          content: const Text('Unable to sign in!'),
        ),
      );
    } else {
      log(user.toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
