import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mavel_comics/models/comic_model.dart';
import 'package:mavel_comics/models/root_model.dart';
import 'package:mavel_comics/widgets/comic_card.dart';
import 'package:mavel_comics/widgets/waiting_message.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String hash = generateMd5('1${env['PRIVATE_KEY']}${env['API_KEY']}');
    // print(hash);
    Map<String, String> params = {
      'ts': '1',
      'apikey': env['API_KEY'],
      'hash': hash,
      'offset': '0',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Comics'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: http.get(
          Uri(
            scheme: 'https',
            host: 'gateway.marvel.com',
            path: '/v1/public/comics',
            queryParameters: params,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              http.Response response = snapshot.data;

              print(response.body);

              Map<String, dynamic> body = jsonDecode(response.body);

              RootModel<ComicModel> rootModel =
                  RootModel<ComicModel>().fromJson(body, ComicModel());

              print(rootModel.data.results.length);

              return Text('Olá Mundo!');
            }
          }
          return WaitingMessage(
            message: 'Carregando...',
          );
        },
      ),
    );
  }
}
