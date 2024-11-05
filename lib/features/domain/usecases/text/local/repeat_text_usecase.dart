import 'package:text_repeater/core/usecase/usecase.dart';
import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';

class RepeatTextUsecase implements UseCase<String, RepeatTextParams> {
  final LocalTextRepository _localTextRepository;

  RepeatTextUsecase(this._localTextRepository);

  @override
  Future<String> call({params}) async {
    return await _localTextRepository.repeatText(
        text: params!.text, times: params.times, newLine: params.newLine);
  }
}

class RepeatTextParams {
  final String text;
  final int times;
  final bool newLine;
  final bool? isRecent;

  RepeatTextParams(
      {required this.text,
      required this.times,
      required this.newLine,
      this.isRecent});
}
