import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('English and Arabic translation files expose the same keys', () {
    final english = _readTranslations('assets/translations/en.json');
    final arabic = _readTranslations('assets/translations/ar.json');

    expect(arabic.keys.toSet(), english.keys.toSet());
    expect(english['changeLanguage'], 'Change Language');
    expect(arabic['changeLanguage'], 'تغيير اللغة');
    expect(english['loading'], 'Loading');
    expect(arabic['loading'], 'جاري التحميل');
  });
}

Map<String, dynamic> _readTranslations(String path) {
  final content = File(path).readAsStringSync();

  return jsonDecode(content) as Map<String, dynamic>;
}
