import 'package:flutter/material.dart';
import 'screens/symbol_list_screen.dart'; // 作成した画面をインポート
//import 'screens/my_home_page.dart';

Future<void> main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST-TEST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //      home: const MyHomePage(),
      home: const SymbolListScreen(), // 最初の画面として設定
    );
  }
}
