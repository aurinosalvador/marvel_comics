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
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  List<ComicModel> comics = [];
  StreamController _streamController;
  RootModel rootModel;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<Status>();

    _scrollController = ScrollController()..addListener(_scrollListener);

    getData('0');
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      int offset = comics.length + 20;
      getData(offset.toString());
    }
  }

  void getData(String offset) async {
    _streamController.add(Status.Loading);

    http.Response response = await ComicConsumer().getComics(offset);

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
      ),
      body: StreamBuilder<Status>(
        initialData: Status.Loading,
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (comics.length != 0) {
            Size size = MediaQuery.of(context).size;

            /*24 is for notification bar on Android*/
            final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
            final double itemWidth = size.width / 2;

            return Column(
              children: [
                Expanded(
                  child: GridView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10.0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (itemWidth / itemHeight),
                      mainAxisSpacing: 10.0,
                    ),
                    children: comics
                        .map((e) => ComicCard(
                              comic: e,
                            ))
                        .toList(),
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
    _scrollController.dispose();
    super.dispose();
  }
}
