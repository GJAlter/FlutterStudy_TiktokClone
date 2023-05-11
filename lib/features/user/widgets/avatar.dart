import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/features/user/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;
  const Avatar({
    Key? key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  }) : super(key: key);

  void _onAvatarTap(WidgetRef ref) async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: 50,
              foregroundImage: hasAvatar
                  ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/tiktok-clone-jun.appspot.com/o/"
                      "avatars%2F$uid?alt=media&token=b4cdfab6-62ac-476a-8048-c2f34f535c91&date=${DateTime.now().millisecondsSinceEpoch}")
                  : null,
              child: Text(name),
            ),
    );
  }
}
