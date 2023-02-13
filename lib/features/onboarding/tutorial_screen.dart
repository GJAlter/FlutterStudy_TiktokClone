import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/tutorial_page.dart';

import '../../constants/sizes.dart';

enum Direction { left, right }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction direction = Direction.right;
  Page page = Page.first;

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      direction = Direction.right;
    } else {
      direction = Direction.left;
    }
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      if (direction == Direction.left) {
        page = Page.second;
      } else {
        page = Page.first;
      }
    });
  }

  void onEnterAppTap() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: AnimatedCrossFade(
              crossFadeState: page == Page.first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 500),
              firstChild: const TutorialPage(
                title: "Watch cool videos!",
                description: "Videos are personalized for you based on what you watch, like, and share.",
              ),
              secondChild: const TutorialPage(
                title: "Follow the rules",
                description: "Take care of one anothers. Pils!",
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size24,
                horizontal: Sizes.size24,
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: page == Page.first ? 0 : 1,
                child: CupertinoButton(
                  onPressed: onEnterAppTap,
                  color: Theme.of(context).primaryColor,
                  child: const Text("Enter the app!"),
                ),
              )),
        ),
      ),
    );
  }
}
