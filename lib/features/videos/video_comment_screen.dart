import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import '../../constants/gaps.dart';

class VideoCommentScreen extends StatefulWidget {
  const VideoCommentScreen({Key? key}) : super(key: key);

  @override
  State<VideoCommentScreen> createState() => _VideoCommentScreenState();
}

class _VideoCommentScreenState extends State<VideoCommentScreen> {
  final ScrollController scrollController = ScrollController();

  bool isWriting = false;

  void onCloseTab() {
    Navigator.of(context).pop();
  }

  void stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      isWriting = false;
    });
  }

  void onStartWriting() {
    setState(() {
      isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22686 comments"),
          actions: [
            IconButton(
              onPressed: onCloseTab,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: scrollController,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Gaps.v20,
                  controller: scrollController,
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size96 + Sizes.size20,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text("Jun"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jun",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            Text("댓글 하나아나아랴두리냐두리냗더ㅇ러ㅑ미넝리ㅑ넝린ㅇ러ㅣㅑ"),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                          Gaps.v3,
                          Text(
                            "3.2k",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                      vertical: Sizes.size10,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          child: const Text("Jun"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: onStartWriting,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: Sizes.size14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade800,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade800,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade800,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (isWriting)
                          Row(
                            children: [
                              Gaps.h14,
                              GestureDetector(
                                onTap: stopWriting,
                                child: FaIcon(
                                  FontAwesomeIcons.circleArrowUp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
