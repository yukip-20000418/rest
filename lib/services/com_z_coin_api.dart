import 'dart:developer' as developer;
import 'dart:convert'; // jsonDecode のために必要
import 'package:http/http.dart' as http;

class GmoCoinApiService {
  static const String _baseUrl = 'https://api.coin.z.com/public';

  // 取扱全銘柄情報を取得するメソッド
  Future<List<dynamic>> getSymbols() async {
    final Uri endpoint = Uri.parse('$_baseUrl/v1/symbols');
    developer.log('Requesting to: $endpoint'); // リクエストURLをログに出力

    try {
      final response = await http.get(endpoint);

      developer.log('Response status: ${response.statusCode}'); // ステータスコードをログに
      // developer.log('Response body: ${response.body}'); // レスポンスボディ全体をログに（長くなる可能性あり）

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);
        if (decodedBody['status'] == 0 && decodedBody['data'] != null) {
          // APIの仕様に応じて、実際に必要なデータ部分を抽出
          // 今回の /public/v1/symbols では、data がリストになっている
          developer.log(
            'Successfully fetched symbols. Count: ${decodedBody['data'].length}',
          );
          return List<dynamic>.from(decodedBody['data']);
        } else {
          developer.log('API error: ${decodedBody['messages']}');
          throw Exception('API returned an error: ${decodedBody['messages']}');
        }
      } else {
        // HTTPエラーの場合
        developer.log('HTTP error ${response.statusCode}: ${response.body}');
        throw Exception('Failed to load symbols: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error fetching symbols: $e');
      throw Exception('Failed to load symbols: $e');
    }
  }

  // 他のPublic APIメソッドもここに追加していく
  // 例: getTicker, getOrderbooks など
}
