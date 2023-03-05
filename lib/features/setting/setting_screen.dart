import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ListWheelScrollView(
          itemExtent: 200,
          children: [
            for (var i = 0; i < 10; i++)
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: Text(
                    "Pick Me$i",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size52,
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
