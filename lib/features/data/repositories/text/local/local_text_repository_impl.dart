import 'package:text_repeater/config/models/text_model.dart';
import 'package:text_repeater/features/data/data_sources/local/hive_database_service.dart';

import '../../../../domain/repositories/text/local/local_text_repository.dart';

class LocalTextRepositoryImpl implements LocalTextRepository {
  final HiveDatabaseService _databaseService;

  LocalTextRepositoryImpl(this._databaseService);

  @override
  Future<List<TextModel>> getSavedTexts() async {
    // return await _databaseService.getAllTexts();
    throw UnimplementedError();
  }

  @override
  Future<String> randomizeText({required String text}) async {
    List<String> words = text.split(' ');
    words.shuffle(); // Kelimeleri karıştır
    return words.join(' '); // Yeniden birleştir ve döndür
  }

  @override
  Future<String> repeatText(
      {required String text, required int times, required bool newLine}) async {
    String separator = newLine ? '\n' : ' ';
    return List.filled(times, text)
        .join(separator); // Metni belirtilen sayıda tekrarla
  }

  @override
  Future<String> reverseText({required String text}) async {
    return text.split('').reversed.join(); // Metni ters çevir
  }

  @override
  Future<void> saveText(
      {required String text,
      required DateTime createdAt,
      required String type,
      required int repeatCount}) async {
    // final textModel = TextModel(
    //   text: text,
    //   createdAt: createdAt,
    //   type: type,
    //   repeatCount: repeatCount,
    // );
    // await _databaseService.saveText(textModel); // Hive'a kaydet
  }

  @override
  Future<String> sortText({required String text}) async {
    List<String> words = text.split(' ');
    words.sort(); // Alfabetik sıraya göre sırala
    return words.join(' '); // Yeniden birleştir ve döndür
  }

  @override
  Future<String> wordCloud({required String text}) async {
    // Kelime sıklığını hesaplayalım
    Map<String, int> wordCount = {};
    List<String> words = text.split(' ');

    for (String word in words) {
      wordCount[word] = (wordCount[word] ?? 0) + 1;
    }

    // Kelime bulutunu basit bir string formunda döndürelim (Grafiksel olarak yapmak için başka paketler kullanılabilir)
    return wordCount.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n');
  }
}
