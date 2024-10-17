import '../../../../../config/models/text_model.dart';

abstract class LocalTextRepository {
  Future<String> repeatText(
      {required String text, required int times, required bool newLine});
  Future<String> randomizeText({required String text});
  Future<String> sortText({required String text});
  Future<String> reverseText({required String text});
  Future<String> wordCloud({required String text});
  Future<void> saveText(
      {required String text,
      required DateTime createdAt,
      required String type,
      required int repeatCount});
  Future<List<TextModel>> getSavedTexts();
}
