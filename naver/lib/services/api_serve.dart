import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naver/models/webtoon_detail_model.dart';
import 'package:naver/models/webtoon_episode_model.dart';
import 'package:naver/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';

  static const String today = "today";

  // API 수신법
  // async 일 때 return 값이 있다면, Future< 반환되는 데이터의 자료형 > 으로 작성
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');

    // 데이터를 받아 올 때 까지 기다리기 => await 쓸려면 -> async 함수선언을 해줘야해
    final response = await http.get(url); // return 값이 Future , response 타입

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }

      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }

    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var epi in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(epi));
        return episodesInstances;
      }
    }

    throw Error();
  }
}
