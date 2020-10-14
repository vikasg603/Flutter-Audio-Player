import 'dart:io';

import 'package:audio_player_flutter/src/services/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final Map<String, Object> cache;
  final _baseUrl = 'https://api.jsonbin.io/b';
  final http.Client client;

  ApiService({
    HttpClient client,
    Map<String, Object> cache,
  })  : client = client ?? http.Client(),
        cache = cache ?? <String, Object>{};

  Future<BuiltList<AudioFile>> fetchAllTunes() async {
    final response = await client.get(
      '$_baseUrl/5f872fcd302a837e957949e7',
      headers: {
        HttpHeaders.acceptHeader: '*/*',
        HttpHeaders.cacheControlHeader: 'no-cache',
        HttpHeaders.contentTypeHeader: 'application/json',
        'secret-key':
            '\$2b\$10\$CSuhLPFe.PTjLjnNQ43lMudwj.6k61Hzh4wSYpfhTiqLdWJxF5Js.'
      },
    );
    //print('Api Service: fetch AudioFile: ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(AudioFile.parseListOfAudioFiles, response.body);
    } else {
      throw NetworkError(response.statusCode.toString());
    }
  }
}

class CSuhLPFe {}
