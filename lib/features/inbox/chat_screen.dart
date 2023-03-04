import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  void editText() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    messageController.addListener(editText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            children: [
              const CircleAvatar(
                foregroundImage: NetworkImage(
                  "https://i.stack.imgur.com/frlIf.png",
                ),
                radius: Sizes.size24,
                child: Text("Jun"),
              ),
              Positioned(
                left: Sizes.size32,
                top: Sizes.size32,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size4,
                    ),
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
          title: const Text(
            "Jun",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h28,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
              horizontal: Sizes.size14,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 3 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size14),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size20),
                        topRight: const Radius.circular(Sizes.size20),
                        bottomLeft: Radius.circular(isMine ? Sizes.size20 : Sizes.size5),
                        bottomRight: Radius.circular(!isMine ? Sizes.size20 : Sizes.size5),
                      ),
                    ),
                    child: const Text(
                      "This is a message!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              elevation: 0,
              height: Sizes.size96,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size44,
                        child: Bubble(
                          padding: const BubbleEdges.only(right: 0),
                          nip: BubbleNip.rightBottom,
                          elevation: 0,
                          radius: const Radius.circular(
                            Sizes.size16,
                          ),
                          color: Colors.white,
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: "Send a message...",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(
                                Sizes.size5,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: FaIcon(
                                  FontAwesomeIcons.faceLaugh,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIconColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    Container(
                      width: Sizes.size40,
                      height: Sizes.size40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size32,
                        ),
                        color: messageController.text.isEmpty ? Colors.grey.shade300 : Colors.lightBlueAccent,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
