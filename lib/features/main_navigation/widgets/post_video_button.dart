import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  final bool isHome;

  const PostVideoButton({Key? key, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 18,
            child: Container(
              height: 33,
              width: 25,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: const Color(0xFF61D4F0),
                borderRadius: BorderRadius.circular(Sizes.size8),
              ),
            ),
          ),
          Positioned(
            left: 18,
            child: Container(
              height: 33,
              width: 25,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Sizes.size8),
              ),
            ),
          ),
          Container(
            height: 33,
            decoration: BoxDecoration(
              color: isHome ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(
                Sizes.size6,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
            // padding: const EdgeInsets.only(
            //   left: Sizes.size12,
            //   right: Sizes.size12,
            //   bottom: Sizes.size5,
            // ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: isHome ? Colors.black : Colors.white,
                size: Sizes.size16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
