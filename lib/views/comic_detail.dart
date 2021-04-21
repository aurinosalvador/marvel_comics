import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/views/maps.dart';

class ComicDetail extends StatelessWidget {
  final ComicModel comic;

  const ComicDetail({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = comic.thumbnail.replaceAll('http', 'https');

    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: '$url/portrait_uncanny.jpg',
                // width: 250,
                placeholder: (BuildContext context, String url) =>
                    CircularProgressIndicator(),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        Icon(Icons.error),
              ),
              // SizedBox(height: 6.0),
              Text(
                comic.description ?? 'No Description',
                textAlign: TextAlign.justify,
                softWrap: true,
                textScaleFactor: 1.2,
                maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Maps(),
                  ),
                ),
                label: Text('Send to Address'),
                icon: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
