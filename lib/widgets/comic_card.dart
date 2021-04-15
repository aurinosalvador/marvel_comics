import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mavel_comics/models/comic_model.dart';
import 'package:mavel_comics/views/comic_detail.dart';

class ComicCard extends StatelessWidget {
  final ComicModel comic;

  const ComicCard({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = comic.thumbnail.replaceAll('http', 'https');
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ComicDetail(comic: comic),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: '$url/portrait_uncanny.jpg',
                // width: 250,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 8.0),
              Text(
                comic.title,
                textAlign: TextAlign.center,
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
