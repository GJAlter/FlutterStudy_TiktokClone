import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/singup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;
  const EmailScreen({Key? key, required this.username}) : super(key: key);

  @override
  ConsumerState<EmailScreen> createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController emailController = TextEditingController();

  String email = "";

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        email = emailController.text;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? isEmailValid() {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (email.isNotEmpty && !regExp.hasMatch(email)) {
      return "Email  Not Valid";
    }

    return null;
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void onSubmitTap() {
    if (email.isEmpty || isEmailValid() != null) return;
    ref.read(signUpForm.notifier).state = {"email": email};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "What is your email, ${widget.username}",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: onSubmitTap,
                // autocorrect: false, //자동 완성 비활성화
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v16,
              FormButton(
                text: "Next",
                disabled: email.isEmpty || isEmailValid() != null,
                onTap: onSubmitTap,
              )
            ],
          ),
        ),
      ),
    );
  }
}
