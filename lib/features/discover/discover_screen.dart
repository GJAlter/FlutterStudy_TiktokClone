import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

class DiscoverScreen extends StatefulWidget {
  final Function returnHome;

  const DiscoverScreen({Key? key, required this.returnHome}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController textEditingController = TextEditingController();

  bool isWriting = false;

  void onSearchChanged(String value) {
    if (value.isNotEmpty && !isWriting) {
      setState(() {
        isWriting = true;
      });
    }
  }

  void onSearchSummited(String value) {}

  void onSearchClearTap() {
    if (isWriting) {
      setState(() {
        textEditingController.clear();
        isWriting = false;
      });
    }
  }

  void onTabBarTap(int index) {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: widget.returnHome(),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.size5,
                      right: Sizes.size18,
                    ),
                    child: FaIcon(FontAwesomeIcons.chevronLeft),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Sizes.size40,
                    child: TextField(
                      controller: textEditingController,
                      onChanged: onSearchChanged,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDarkMode(context)
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.size3),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: Sizes.size10),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Gaps.h10,
                            FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        suffixIcon: isWriting
                            ? GestureDetector(
                                onTap: onSearchClearTap,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleXmark,
                                      size: Sizes.size18,
                                      color: Colors.grey.shade500,
                                    ),
                                    Gaps.h5,
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Gaps.h20,
                const FaIcon(FontAwesomeIcons.sliders),
              ],
            ),
          ),
          elevation: 1,
          bottom: TabBar(
            onTap: onTabBarTap,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            tabs: [
              for (var tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(Sizes.size10),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.xxl
                    ? 5
                    : width > Breakpoints.xl
                        ? 4
                        : width > Breakpoints.lg
                            ? 3
                            : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraint) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 15,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/image1.jpeg",
                          image:
                              "https://images.unsplash.com/photo-1593291619431-271d4391ded1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d29uZGVyZnVsfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "This is a very long captions for my tiktok that im upload just now currently.",
                      style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    if (constraint.maxWidth > 330 || constraint.maxWidth < 300)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/15954278?v=4"),
                              radius: 14,
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                "My Avatar is going to be very long.",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h3,
                            const Text("2.0M"),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size40,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
