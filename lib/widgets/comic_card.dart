import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final Map<String, dynamic> comic;

  const ComicCard({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(comic['title']);
    return Card(
      child: Column(
        children: [
          Text('Teste'),
        ],
      ),
    );
  }
}
