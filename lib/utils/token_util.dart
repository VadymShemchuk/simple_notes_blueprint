import 'dart:convert';
import 'dart:math';

class TokenUtil {
  const TokenUtil._();

  static String generateToken() {
    final Random random = Random.secure();
    const int length = 32;
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    final token = base64Url.encode(values);
    return token;
  }
}
