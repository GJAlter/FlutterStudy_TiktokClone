import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/user/widgets/CountView.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Jun"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.gear,
                  size: Sizes.size20,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage("https://avatars.githubusercontent.com/u/15954278?v=4"),
                  child: Text("Jun"),
                ),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "@Jun",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    Gaps.h5,
                    FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size16,
                      color: Colors.blue.shade500,
                    ),
                  ],
                ),
                Gaps.v24,
                SizedBox(
                  height: Sizes.size48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CountView(
                        count: "97",
                        text: "Following",
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      CountView(
                        count: "10.5M",
                        text: "Followers",
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      CountView(
                        count: "149.3M",
                        text: "Likes",
                      ),
                    ],
                  ),
                ),
                Gaps.v14,
                FractionallySizedBox(
                  widthFactor: 1 / 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Sizes.size12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.size4),
                      ),
                    ),
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Gaps.v14,
                Text("All highlight and where to watch live matches on FIFA"
                    "+")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
