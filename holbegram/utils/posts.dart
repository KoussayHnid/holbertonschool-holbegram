import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String postUrl;
  final String caption;

  PostCard({required this.username, required this.postUrl, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(username),
        Image.network(postUrl),
        Text(caption),
      ],
    );
  }
}
