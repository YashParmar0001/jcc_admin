import 'dart:math';

class GenerationUtils {
  static String generate8DigitPassword() {
    Random random = Random();
    String password = '';

    for (int i = 0; i < 8; i++) {
      password += random.nextInt(10).toString();
    }

    return password;
  }
}