import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mavel_comics/widgets/waiting_message.dart';

class Preload extends StatefulWidget {
  @override
  _PreloadState createState() => _PreloadState();
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class _PreloadState extends State<Preload> {
  @override
  Widget build(BuildContext context) {
    String hash = generateMd5('1${env['PRIVATE_KEY']}${env['API_KEY']}');
    print(hash);
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Comics'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: WaitingMessage(),
          ),
        ),
      ),
    );
  }
}
