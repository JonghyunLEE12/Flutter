import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showTitle = true;

  void toggletitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('Nothing'),
              IconButton(
                  onPressed: toggletitle, icon: const Icon(Icons.thumb_up))
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  // 부모 요소에 의존하는 데이터를 초기화하기 위해 initState 가 사용됨
  // initState 는 항상 build 위에 호출할 것
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // dispose -> 위젯이 스크린에서 제거될 때 호출되는 메서드
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Text('My Large Title',
        style: TextStyle(
          fontSize: 30,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ));
  }
}
