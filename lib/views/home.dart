import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_comics/controllers/cart_controller.dart';
import 'package:marvel_comics/controllers/comic_controller.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/models/root_model.dart';
import 'package:marvel_comics/views/cart.dart';
import 'package:marvel_comics/widgets/comic_card.dart';
import 'package:marvel_comics/widgets/waiting_message.dart';
import 'package:provider/provider.dart';

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
      response = await ComicController().getComics(offset, title: title);
    } else {
      response = await ComicController().getComics(offset);
    }

    Map<String, dynamic> body = jsonDecode(response.body);

    rootModel = RootModel().fromJson(body, ComicModel());

    for (ComicModel comic in rootModel.data.results) {
      comics.add(comic);
    }

    _streamController.add(Status.Ready);
  }

  void _search(BuildContext context, String title) {
    FocusScope.of(context).unfocus();
    comics.clear();
    getData('0', title: title);
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
            // child: Icon(Icons.shopping_cart),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Cart(),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Positioned(
                      top: -2,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        width: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Consumer<CartController>(
                          builder: (
                            BuildContext context,
                            CartController cart,
                            Widget child,
                          ) {
                            return Text(
                              cart.cartCount.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9.0,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                    onEditingComplete: () =>
                        _search(context, _searchController.text),
                    decoration: InputDecoration(
                      labelText: 'Search...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () =>
                            _search(context, _searchController.text),
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
            if (snapshot.data == Status.Ready) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: TextField(
                      controller: _searchController,
                      onEditingComplete: () =>
                          _search(context, _searchController.text),
                      decoration: InputDecoration(
                        labelText: 'Search...',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () =>
                              _search(context, _searchController.text),
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('No data.'),
                    ),
                  ),
                ],
              );
            }
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
