import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> notifications = List.generate(20, (index) => "${index}h");

  void onDismissed(String key) {
    notifications.remove(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activity"),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Gaps.v14,
          for (var notification in notifications)
            Dismissible(
              onDismissed: (direction) => onDismissed(notification),
              background: Container(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.only(left: Sizes.size10),
                  child: FaIcon(FontAwesomeIcons.check),
                ),
              ),
              key: Key(notification),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                ),
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: Sizes.size1,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Account updates:",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16,
                    ),
                    children: [
                      const TextSpan(
                        text: " Upload longer videos",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: " $notification",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
