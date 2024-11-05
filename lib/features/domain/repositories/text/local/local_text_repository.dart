import '../../../../../config/models/text_model.dart';

abstract class LocalTextRepository {
  Future<String> repeatText(
      {required String text,
      required int times,
      required bool newLine,
      bool? isRecent});
  Future<String> randomizeText({required String text, bool? isRecent});
  Future<String> sortText({required String text, bool? isRecent});
  Future<String> reverseText({required String text, bool? isRecent});
  Future<List<Map<String, dynamic>>> wordCloud(
      {required String text, bool? isRecent});
  Future<void> saveText({required TextModel textModel});
  Future<List<TextModel>> getSavedTexts();
}
