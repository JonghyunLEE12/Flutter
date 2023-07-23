import 'package:flutter/material.dart';
import 'package:naver/models/webtoon_detail_model.dart';
import 'package:naver/models/webtoon_episode_model.dart';
import 'package:naver/services/api_serve.dart';
import 'package:naver/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 타 위젯에서 id와 같은 변수를 받아올 경우 Stateful 위젯 사용
class DetailScreen extends StatefulWidget {
  final String title, thumb, id;
  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // constructor 에서 접근 불가시 late -> init State 하자
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');

    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        isLiked = true;
        setState(() {});
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  // ID에 접근 할 수 없는 경우엔 initState를 통해서 접근하자
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1.5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: onHeartTap,
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              ),
            )
          ],
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
          ),
          child: SingleChildScrollView(
            // overFlow 문제 해결 방법
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hero => 페이지 전환 시, 동일한 이미지를 가지고 있다면, ID를 통해 애니메이션 효과 제공
                    Hero(
                      tag: widget.id,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(2, 2),
                              color: Colors.black.withOpacity(0.5),
                            )
                          ],
                        ),
                        width: 250,
                        clipBehavior: Clip.hardEdge,
                        // child: Image.network(webtoon.thumb),
                        child: Image.network('https://picsum.photos/536/354'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // 데이터가 다 받아올때까지 기다려줌
                FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text('...');
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var epi in snapshot.data!)
                            Episode(episode: epi, webtoonId: widget.id),
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
