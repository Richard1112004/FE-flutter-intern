import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdToken {
  Future<String?> getUserIdFromToken() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token');

  if (token != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print("Decoded Token: $decodedToken");
    return decodedToken['jti'];
  }
  return null;
}

}
