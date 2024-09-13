import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mood_diary/resources/resources.dart';

void main() {
  test('feeling_images assets test', () {
    expect(File(FeelingImages.calmness).existsSync(), isTrue);
    expect(File(FeelingImages.fear).existsSync(), isTrue);
    expect(File(FeelingImages.joy).existsSync(), isTrue);
    expect(File(FeelingImages.rage).existsSync(), isTrue);
    expect(File(FeelingImages.sadness).existsSync(), isTrue);
    expect(File(FeelingImages.strength).existsSync(), isTrue);
  });
}
