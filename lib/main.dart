import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import 'features/authentication/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //방향 고정
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TikTok Clone",
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w700,
          ),
        ),
        splashColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      // home: const MainNavigationScreen(),
      home: const SignUpScreen(),
    );
  }
}
