import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mavel_comics/models/comic_model.dart';
import 'package:mavel_comics/views/comic_detail.dart';

enum ContentMenu {
  AddToCart,
  Details,
}

class ComicCard extends StatelessWidget {
  final ComicModel comic;

  const ComicCard({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = comic.thumbnail.replaceAll('http', 'https');

    return PopupMenuButton<ContentMenu>(
      itemBuilder: (BuildContext context) => _getMenu(),
      onSelected: (ContentMenu contentMenu) => _menuClick(context, contentMenu),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: 8.0),
              Text(
                comic.title,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<ContentMenu>> _getMenu() {
    return <PopupMenuEntry<ContentMenu>>[
      PopupMenuItem<ContentMenu>(
        value: ContentMenu.AddToCart,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.add_shopping_cart),
            ),
            Text('Add to Cart'),
          ],
        ),
      ),
      PopupMenuItem<ContentMenu>(
        value: ContentMenu.Details,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.description),
            ),
            Text('Details'),
          ],
        ),
      ),
    ];
  }

  void _menuClick(BuildContext context, ContentMenu contentMenu) {
    switch (contentMenu) {
      case ContentMenu.AddToCart:
        // TODO: Handle this case.
        break;
      case ContentMenu.Details:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ComicDetail(comic: comic),
          ),
        );
        break;
    }
  }
}
