import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey();

  void addItem() {
    if (animatedListKey.currentState != null) {
      animatedListKey.currentState!.insertItem(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        key: animatedListKey,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (BuildContext context, int index, Animation<double> animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage("https://i.stack.imgur.com/frlIf.png"),
                  child: Text("Jun"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Human$index",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "2:16 PM",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  ],
                ),
                subtitle: const Text("Hello, World!"),
              ),
            ),
          );
        },
      ),
    );
  }
}
