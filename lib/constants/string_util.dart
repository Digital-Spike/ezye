import 'dart:math';

class StringUtil {
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) {
        const chars =
            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        Random rnd = Random();
        return chars.codeUnitAt(rnd.nextInt(chars.length));
      }));
}
