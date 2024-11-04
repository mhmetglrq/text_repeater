import '../../../../../config/models/text_model.dart';

abstract class LocalTextRepository {
  Future<String> repeatText(
      {required String text, required int times, required bool newLine});
  Future<String> randomizeText({required String text});
  Future<String> sortText({required String text});
  Future<String> reverseText({required String text});
  Future<List<Map<String, dynamic>>> wordCloud({required String text});
  Future<void> saveText({required TextModel textModel});
  Future<List<TextModel>> getSavedTexts();
}
