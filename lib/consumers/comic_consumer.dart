import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class ComicConsumer {
  Future<http.Response> getComics(String offset, {String title}) async {
    String ts = DateTime.now().millisecondsSinceEpoch.toString();
    String hash = generateMd5('$ts${env['PRIVATE_KEY']}${env['API_KEY']}');

    Map<String, String> params = <String, String>{
      'ts': ts,
      'apikey': env['API_KEY'],
      'hash': hash,
      'offset': offset,
      'limit': '20',
      if (title != null) 'titleStartsWith': title,
      'orderBy': 'title',
    };

    http.Response response = await http.get(
      Uri(
        scheme: 'https',
        host: 'gateway.marvel.com',
        path: '/v1/public/comics',
        queryParameters: params,
      ),
    );

    return response;
  }
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
