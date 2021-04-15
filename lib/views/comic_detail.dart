import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mavel_comics/models/comic_model.dart';
import 'package:mavel_comics/views/maps.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: '$url/portrait_uncanny.jpg',
                // width: 250,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  comic.description ?? 'No Description',
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  textScaleFactor: 1.2,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Maps(),
                  ),
                ),
                child: Text('Send to Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
