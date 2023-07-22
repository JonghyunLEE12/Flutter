import 'package:flutter/material.dart';
import 'package:toonflix/widgets/Button.dart';

class Player {
  String? name; // ? => null 값을 가질 수 있음을 의미
  Player({required this.name});
}

void main() {
  // var nico = Player(name: 'Jonghyun');
  runApp(const App());
}

// 위젯을 만든다는건 class 를 만드는것
// 위젯을 만들기 위해선 SDK를 상속 받아야함
class App extends StatelessWidget {
  const App({super.key});

  // StatelessWidget 상속 받기 위해선 build 메소드를 구현해줘야함

  @override
  Widget build(BuildContext context) {
    // materialApp(구글) 이나 CupertinaApp(IOS)을 리턴해줘야함 -> App이 root 이기 때문
    // 커스터마이즈된 UI를 리턴하고 싶을 땐, MaterialApp을 하고 구글 느낌을 빼주자
    // 클래스를 만든 뒤에는 반드시 , 로 끝내야 Flutter 가 Prettier 해줌
    return MaterialApp(
      // Scaffold => 화면 구성과 구조에 관한 걸 다룰수 있는 위젯
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                // Row => 수평 , Column => 수직
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey Selena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Welcome back',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 18,
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '\$5 194 482',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                        text: 'Transfer',
                        bgColor: Color(0xFFF1B33B),
                        textColor: Colors.black),
                    Button(
                        text: 'Request',
                        bgColor: Color(0xFF1F2123),
                        textColor: Colors.white)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
