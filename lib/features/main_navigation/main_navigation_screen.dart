import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/navigation_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../../constants/gaps.dart';
import '../user/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 4;

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onPostVideoTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const Scaffold(),
      fullscreenDialog: true,
    ));
  }

  void returnHome() {
    print("a");
    setState(() {
      selectedIndex = 0;
    });
  }

  bool isHome() {
    return selectedIndex == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Offstage(
            offstage: selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            child: DiscoverScreen(
              returnHome: () => returnHome,
            ),
          ),
          Offstage(
            offstage: selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 4,
            child: UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: isHome() ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationTab(
                text: "Home",
                isSelected: selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => onItemTap(0),
                isHome: isHome(),
              ),
              NavigationTab(
                text: "Discover",
                isSelected: selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => onItemTap(1),
                isHome: isHome(),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: onPostVideoTap,
                child: PostVideoButton(isHome: isHome()),
              ),
              Gaps.h24,
              NavigationTab(
                text: "Inbox",
                isSelected: selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => onItemTap(3),
                isHome: isHome(),
              ),
              NavigationTab(
                text: "Profile",
                isSelected: selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => onItemTap(4),
                isHome: isHome(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
