import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  final List<String> notifications = List.generate(20, (index) => "${index}h");
  final List<Map<String, dynamic>> activityMenus = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "For TikTok",
      "icon": FontAwesomeIcons.tiktok,
    },
  ];

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 250,
    ),
  );
  late final Animation<double> arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(animationController);
  late final Animation<Offset> allActivityAnimation = Tween(
    begin: const Offset(0, -1.0),
    end: Offset.zero,
  ).animate(animationController);
  late final Animation<Color?> barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(animationController);

  bool isShowBarrier = false;

  void toggleAnimations() async {
    if (animationController.isCompleted) {
      await animationController.reverse();
    } else {
      animationController.forward();
    }
    setState(() {
      isShowBarrier = !isShowBarrier;
    });
  }

  void onDismissed(String key) {
    setState(() {
      notifications.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("All Activity"),
              Gaps.h2,
              RotationTransition(
                turns: arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: Sizes.size10),
                      child: FaIcon(FontAwesomeIcons.check),
                    ),
                  ),
                  key: Key(notification),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size14,
                    ),
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.grey.shade800 : Colors.white,
                        border: Border.all(
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? null : Colors.black,
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
          if (isShowBarrier)
            AnimatedModalBarrier(
              color: barrierAnimation,
              dismissible: true,
              onDismiss: toggleAnimations,
            ),
          SlideTransition(
            position: allActivityAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var activityMenu in activityMenus)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            activityMenu["icon"],
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            activityMenu["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
