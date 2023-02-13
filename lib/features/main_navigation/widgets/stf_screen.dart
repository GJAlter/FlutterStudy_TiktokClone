import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({Key? key}) : super(key: key);

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int clicks = 0;

  void increase() {
    setState(() {
      clicks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            clicks.toString(),
            style: TextStyle(fontSize: Sizes.size48),
          ),
          TextButton(
            onPressed: increase,
            child: Text(
              "+",
              style: TextStyle(fontSize: Sizes.size48),
            ),
          ),
        ],
      ),
    );
  }
}
