import 'package:flutter/material.dart';
import 'package:naver/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDector -> 대부분의 동작을 감지함
    return GestureDetector(
      onTap: () {
        // 네비게이터
        Navigator.push(
          context,
          // MaterialPageRoute -> Stateless 페이지로 넘어가게 해준다.
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: ((context) => DetailScreen(
                    id: id,
                    thumb: thumb,
                    title: title,
                  ))),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
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
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
