import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import 'chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const routeName = "chats";
  static const routeURL = "/chats";

  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
  List<int> items = [];

  void addItem() {
    if (animatedListKey.currentState != null) {
      animatedListKey.currentState!.insertItem(items.length);
    }
    items.add(items.length);
  }

  void removeItem(int index) {
    if (animatedListKey.currentState != null) {
      animatedListKey.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: makeTile(index),
        ),
      );
    }
    items.removeAt(index);
  }

  Widget makeTile(int index) {
    return ListTile(
      onLongPress: () => removeItem(index),
      onTap: () => openChat(index),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage("https://avatars.githubusercontent.com/u/15954278?v=4"),
        child: Text("Jun"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Human$index",
            style: const TextStyle(
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
    );
  }

  void openChat(int id) {
    context.pushNamed(ChatScreen.routeName, params: {
      "chatId": "$id",
    });
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
              child: makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
