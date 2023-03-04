import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

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
            // pinned: true,
            stretch: true,
            backgroundColor: Colors.teal,
            elevation: 1,
            collapsedHeight: 80,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Image.asset(
                "assets/images/image1.jpeg",
                fit: BoxFit.cover,
              ),
              title: Text("Hello"),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20,
                )
              ],
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) => Container(
                  color: Colors.amber[100 * (index % 9)],
                  child: Align(alignment: Alignment.center, child: Text("Item $index")),
                ),
              ),
              itemExtent: 60),
          SliverPersistentHeader(
            delegate: CustomDelegate(),
            pinned: true,
            floating: true,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: 50,
              (context, index) => Container(
                color: Colors.blue[100 * (index % 9)],
                child: Align(alignment: Alignment.center, child: Text("Item $index")),
              ),
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: Sizes.size20,
              crossAxisSpacing: Sizes.size20,
              childAspectRatio: 1,
            ),
          ),
          SliverPersistentHeader(
            delegate: CustomDelegate2(),
            pinned: true,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: 50,
              (context, index) => Container(
                color: Colors.purple[100 * (index % 9)],
                child: Align(alignment: Alignment.center, child: Text("Item $index")),
              ),
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: Sizes.size20,
              crossAxisSpacing: Sizes.size20,
              childAspectRatio: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.green,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text("Title!"),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CustomDelegate2 extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.green,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text("Title2"),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
