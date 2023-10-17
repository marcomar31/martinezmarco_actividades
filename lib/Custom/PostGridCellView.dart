import 'dart:html';

import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';
import 'PostCellView.dart';

class PostGridCellView extends StatelessWidget {

  final List<FbPost> posts;

  const PostGridCellView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(child:
          PostCellView(
            sText: posts[index].titulo,
            dFontSize: 20,
          ),
          color: Colors.blue,
          alignment: Alignment.center,
        );
      },
    );

  }
}