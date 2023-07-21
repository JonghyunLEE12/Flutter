import 'package:flutter/material.dart';

class Player {
  String? name; // ? => null 값을 가질 수 있음을 의미
  Player({required this.name});
}

void main() {
  var nico = Player(name: 'Jonghyun');
  runApp(App());
}

// 위젯을 만든다는건 class 를 만든느것
// 위젯을 만들기 위해선 SDK를 상속 받아야함
class App extends StatelessWidget {
  // StatelessWidget 상속 받기 위해선 build 메소드를 구현해줘야함

  @override
  Widget build(BuildContext context) {
    // materialApp(구글) 이나 CupertinaApp(IOS)을 리턴해줘야함 -> App이 root 이기 때문
    // 커스터마이즈된 UI를 리턴하고 싶을 땐, MaterialApp을 하고 구글 느낌을 빼주자
    // 클래스를 만든 뒤에는 반드시 , 로 끝내야 Flutter 가 Prettier 해줌
    return MaterialApp(
      // Scaffold => 화면 구성과 구조에 관한 걸 다룰수 있는 위젯
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          title: Text('Hello! Flutter!'),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
