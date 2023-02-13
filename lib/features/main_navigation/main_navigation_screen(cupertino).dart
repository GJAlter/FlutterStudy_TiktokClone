import 'package:flutter/cupertino.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final screens = [
    const Center(
      child: Text("Page1"),
    ),
    const Center(
      child: Text("Page2"),
    ),
    const Center(
      child: Text("Page3"),
    ),
    const Center(
      child: Text("Page4"),
    ),
    const Center(
      child: Text("Page5"),
    ),
    const Center(
      child: Text("Page6"),
    ),
  ];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Home",
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
