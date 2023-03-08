import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';

import '../../generated/l10n.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  void onLoginTap(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    if (kDebugMode) {
      print(result);
    }
  }

  void onEmailAndPasswordTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: Offset(0, -1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => const UsernameScreen(),
      ),
    );
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
                      S.of(context).signUpTitle("TikTok", DateTime.now()),
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
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
                      S.of(context).signUpSubtitle(102),
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
                        text: S.of(context).authEmail,
                        onTap: () => onEmailAndPasswordTap(context),
                      ),
                      Gaps.v14,
                      AuthButton(icon: const FaIcon(FontAwesomeIcons.facebook), text: S.of(context).authFacebook),
                      Gaps.v14,
                      AuthButton(icon: const FaIcon(FontAwesomeIcons.apple), text: S.of(context).authApple),
                      Gaps.v14,
                      AuthButton(icon: const FaIcon(FontAwesomeIcons.google), text: S.of(context).authGoogle),
                    ],
                    if (orientation == Orientation.landscape) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).authEmail,
                              onTap: () => onEmailAndPasswordTap(context),
                            ),
                          ),
                          Gaps.h14,
                          Expanded(
                            child: AuthButton(icon: const FaIcon(FontAwesomeIcons.facebook), text: S.of(context).authFacebook),
                          ),
                          Gaps.h14,
                          Expanded(
                            child: AuthButton(icon: const FaIcon(FontAwesomeIcons.apple), text: S.of(context).authApple),
                          ),
                          Gaps.h14,
                          Expanded(
                            child: AuthButton(icon: const FaIcon(FontAwesomeIcons.google), text: S.of(context).authGoogle),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            // elevation: 2,
            color: isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnCount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      S.of(context).logIn("male"),
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
