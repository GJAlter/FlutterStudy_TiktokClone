import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';

import '../../../constants/sizes.dart';

class CountView extends StatelessWidget {
  final String count;
  final String text;

  const CountView({Key? key, required this.count, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v5,
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
