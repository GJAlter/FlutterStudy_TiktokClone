import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void onEmailAndPasswordTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UsernameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gaps.v80,
                    Text(
                      "Sign up for Tiktok",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // style: TextStyle(
                      //   fontSize: Sizes.size24,
                      //   fontWeight: FontWeight.w700,
                      // ),
                    ),
                    Gaps.v20,
                    Text(
                      "Create a profile, follow other accounts, make your own videos, and more.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: isDarkMode(context) ? Colors.grey.shade300 : Colors.black45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gaps.v40,
                    if (orientation == Orientation.portrait) ...[
                      AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: "Use email & password",
                        onTap: () => onEmailAndPasswordTap(context),
                      ),
                      Gaps.v14,
                      const AuthButton(icon: FaIcon(FontAwesomeIcons.facebook), text: "Continue with Facebook"),
                      Gaps.v14,
                      const AuthButton(icon: FaIcon(FontAwesomeIcons.apple), text: "Continue with Apple"),
                      Gaps.v14,
                      const AuthButton(icon: FaIcon(FontAwesomeIcons.google), text: "Continue with Google"),
                    ],
                    if (orientation == Orientation.landscape) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: "Use email & password",
                              onTap: () => onEmailAndPasswordTap(context),
                            ),
                          ),
                          Gaps.h14,
                          const Expanded(
                            child: AuthButton(icon: FaIcon(FontAwesomeIcons.facebook), text: "Continue with Facebook"),
                          ),
                          Gaps.h14,
                          const Expanded(
                            child: AuthButton(icon: FaIcon(FontAwesomeIcons.apple), text: "Continue with Apple"),
                          ),
                          Gaps.h14,
                          const Expanded(
                            child: AuthButton(icon: FaIcon(FontAwesomeIcons.google), text: "Continue with Google"),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            color: isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an count?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      "Log in",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
