import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import '../services/com_z_coin_api.dart'; // 作成したサービスクラスをインポート

class SymbolListScreen extends StatefulWidget {
  const SymbolListScreen({super.key});

  @override
  State<SymbolListScreen> createState() => _SymbolListScreenState();
}

class _SymbolListScreenState extends State<SymbolListScreen> {
  final GmoCoinApiService _apiService = GmoCoinApiService();
  Future<List<dynamic>>? _symbolsFuture; // APIからのデータ取得結果を保持

  @override
  void initState() {
    super.initState();
    _loadSymbols(); // 画面初期化時にデータを読み込む
  }

  void _loadSymbols() {
    setState(() {
      _symbolsFuture = _apiService.getSymbols();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('取扱銘柄一覧 (GMOコイン)')),
      body: FutureBuilder<List<dynamic>>(
        future: _symbolsFuture, // このFutureの結果に応じてUIを構築
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // データ取得中
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // エラー発生時
            developer.log('Error in FutureBuilder: ${snapshot.error}');
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // データ取得成功時
            final symbols = snapshot.data!;
            return ListView.builder(
              itemCount: symbols.length,
              itemBuilder: (context, index) {
                final symbolData = symbols[index];
                // APIのレスポンス形式に合わせて表示する情報を取得
                // 例: symbolData['symbol']
                return ListTile(
                  title: Text(symbolData['symbol'] ?? '銘柄名なし'),
                  // subtitle: Text(symbolData.toString()), // 必要なら他の情報も表示
                );
              },
            );
          } else {
            // データが空の場合
            return const Center(child: Text('データがありません'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadSymbols, // 再読み込みボタン
        tooltip: '再読み込み',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
