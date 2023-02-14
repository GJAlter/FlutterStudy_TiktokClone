import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(selectedIndex: selectedIndex, onDestinationSelected: onItemTap, labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected, destinations: const [
        NavigationDestination(
          icon: FaIcon(
            FontAwesomeIcons.house,
            color: Colors.teal,
          ),
          label: "Home",
        ),
        NavigationDestination(
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.amber,
          ),
          label: "Search",
        ),
      ]),
    );
  }
}
