import 'dart:math';

import 'package:text_repeater/config/models/text_model.dart';
import 'package:text_repeater/features/data/data_sources/local/hive_database_service.dart';

import '../../../../domain/repositories/text/local/local_text_repository.dart';

class LocalTextRepositoryImpl implements LocalTextRepository {
  final HiveDatabaseService _databaseService;

  LocalTextRepositoryImpl(this._databaseService);

  @override
  Future<List<TextModel>> getSavedTexts() async {
    List<TextModel> savedTexts = [];
    final data = await _databaseService.getData("recents", "text");
    if (data != null) {
      for (var textModel in data) {
        savedTexts.add(textModel);
      }
    }
    return savedTexts;
  }

  @override
  Future<String> randomizeText({required String text, bool? isRecent}) async {
    List<String> words = text.split(' ');
    words.shuffle(); // Kelimeleri karıştır
    TextModel textModel = TextModel(
        text: words.join(' '),
        createdAt: DateTime.now(),
        type: 'randomize',
        repeatCount: 0);
    await saveText(textModel: textModel, isRecent: isRecent);
    return words.join(' '); // Yeniden birleştir ve döndür
  }

  @override
  Future<String> repeatText(
      {required String text,
      required int times,
      required bool newLine,
      bool? isRecent}) async {
    String separator = newLine ? '\n' : ' ';

    TextModel textModel = TextModel(
        text: text,
        createdAt: DateTime.now(),
        type: 'repeat',
        repeatCount: times,
        isNewLine: newLine);

    await saveText(textModel: textModel, isRecent: isRecent);
    return List.filled(times, text)
        .join(separator); // Metni belirtilen sayıda tekrarla
  }

  @override
  Future<String> reverseText({required String text, bool? isRecent}) async {
    TextModel textModel = TextModel(
        text: text.split('').reversed.join(),
        createdAt: DateTime.now(),
        type: 'reverse',
        repeatCount: 0);
    await saveText(textModel: textModel, isRecent: isRecent);
    return text.split('').reversed.join(); // Metni ters çevir
  }

  @override
  Future<void> saveText({required TextModel textModel, bool? isRecent}) async {
    if (isRecent == false || isRecent == null) {
      List<TextModel> savedTexts = await getSavedTexts();
      if (savedTexts.length >= 10) {
        savedTexts.removeAt(0);
      }

      savedTexts.add(textModel);
      await _databaseService.putData("recents", "text", savedTexts);
    }
  }

  @override
  Future<String> sortText({required String text, bool? isRecent}) async {
    List<String> words = text.split(' ');
    words.sort(); // Alfabetik sıraya göre sırala

    TextModel textModel = TextModel(
        text: words.join(' '),
        createdAt: DateTime.now(),
        type: 'sort',
        repeatCount: 0);
    await saveText(textModel: textModel, isRecent: isRecent);
    return words.join(' '); // Yeniden birleştir ve döndür
  }

  @override
  Future<List<Map<String, dynamic>>> wordCloud(
      {required String text, bool? isRecent}) async {
    // Kelime sıklığını hesaplayan metot
    Map<String, dynamic> wordMap = {};
    List<String> words = text.split(' ');

    for (String word in words) {
      word =
          word.toLowerCase(); // Büyük küçük harf duyarlılığını kaldırmak için
      wordMap[word] =
          Random().nextInt(100) + 10; // Kelime sıklığını rastgele ata
    }

    // Map<String, int> türündeki wordCount'u List<Map> formatına dönüştürelim

    List<Map<String, dynamic>> wordList = wordMap.entries.map((entry) {
      return {'word': entry.key, 'value': entry.value};
    }).toList();

    TextModel textModel = TextModel(
        text: text,
        createdAt: DateTime.now(),
        type: 'wordCloud',
        repeatCount: 0);

    await saveText(textModel: textModel, isRecent: isRecent);
    return wordList;
  }
}
