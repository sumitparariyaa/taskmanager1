import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;

  const ProfilePictureWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
