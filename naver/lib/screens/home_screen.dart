import 'package:flutter/material.dart';
import 'package:naver/models/webtoon_model.dart';
import 'package:naver/services/api_serve.dart';
import 'package:naver/widgets/webtoon_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text('오늘의 웹툰',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: FutureBuilder(
        future: webtoons,
        // snapshot 데이터를 받았는지 , 오류가 발생했는지 확인 가능
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 많은 양의 데이터를 연속적으로 보여주고 싶을 때 => ListView
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // Expanded -> 무한한 높이를 가지는 에러를 방지
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
