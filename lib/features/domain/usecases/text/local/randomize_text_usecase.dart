import 'package:text_repeater/core/usecase/usecase.dart';
import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';

class RandomizeTextUsecase implements UseCase<String, RandomizeTextParams> {
  final LocalTextRepository _localTextRepository;

  RandomizeTextUsecase(this._localTextRepository);

  @override
  Future<String> call({params}) async {
    return await _localTextRepository.randomizeText(
      text: params!.text,
      isRecent: params.isRecent,
    );
  }
}

class RandomizeTextParams {
  final String text;
  final bool? isRecent;

  RandomizeTextParams({
    required this.text,
    this.isRecent,
  });
}
