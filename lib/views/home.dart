import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mavel_comics/consumers/comic_consumer.dart';
import 'package:mavel_comics/models/comic_model.dart';
import 'package:mavel_comics/models/root_model.dart';
import 'package:mavel_comics/widgets/comic_card.dart';
import 'package:mavel_comics/widgets/waiting_message.dart';

enum Status {
  Loading,
  Ready,
  ListEnd,
  Search,
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  List<ComicModel> comics = <ComicModel>[];
  List<ComicModel> cart = <ComicModel>[];
  StreamController<Status> _streamController;
  TextEditingController _searchController;
  RootModel rootModel;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<Status>();
    _searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);

    getData('0');
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _streamController.add(Status.ListEnd);
    }
  }

  void getData(String offset, {String title}) async {
    _streamController.add(Status.Loading);

    http.Response response;

    if (title != null && title.isNotEmpty) {
      response = await ComicConsumer().getComics(offset, title: title);
    } else {
      response = await ComicConsumer().getComics(offset);
    }

    Map<String, dynamic> body = jsonDecode(response.body);

    rootModel = RootModel().fromJson(body, ComicModel());

    for (ComicModel comic in rootModel.data.results) {
      comics.add(comic);
    }

    _streamController.add(Status.Ready);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Comics'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: StreamBuilder<Status>(
        initialData: Status.Loading,
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<Status> snapshot) {
          if (comics.isNotEmpty) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          comics.clear();
                          getData('0', title: _searchController.text);
                        },
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: GridView.extent(
                    controller: _scrollController,
                    maxCrossAxisExtent: 300.0,
                    padding: const EdgeInsets.all(8.0),
                    childAspectRatio: 0.556,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: comics
                        .map((ComicModel comic) => ComicCard(
                              comic: comic,
                            ))
                        .toList(),
                  ),
                ),
                if (snapshot.data == Status.ListEnd)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        int offset = comics.length + 20;
                        if (_searchController.text == null) {
                          getData(offset.toString());
                        } else {
                          getData(
                            offset.toString(),
                            title: _searchController.text,
                          );
                        }
                      },
                      child: Text('Load more'),
                    ),
                  ),
                if (snapshot.data == Status.Loading)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          } else {
            return WaitingMessage(
              message: 'Loading...',
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
