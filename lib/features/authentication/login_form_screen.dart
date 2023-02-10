import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';
import '../onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, String?> loginMap = {};

  void onSubmitTap() {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InterestsScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  final regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value != null && value.isEmpty) {
                    return "Please write your email";
                  }

                  if (!regExp.hasMatch(value!)) {
                    return "Email not valid";
                  }

                  return null;
                },
                onSaved: (newValue) => loginMap["id"] = newValue,
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please write your password";
                  }
                  return null;
                },
                onSaved: (newValue) => loginMap["password"] = newValue,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: onSubmitTap,
                child: const FormButton(
                  text: "Next",
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
