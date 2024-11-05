import '../../../../../core/usecase/usecase.dart';
import '../../../repositories/text/local/local_text_repository.dart';

class SortTextUsecase implements UseCase<String, SortTextParams> {
  final LocalTextRepository _localTextRepository;

  SortTextUsecase(this._localTextRepository);

  @override
  Future<String> call({SortTextParams? params}) async {
    return await _localTextRepository.sortText(text: params!.text, isRecent: params.isRecent);
  }
}

class SortTextParams {
  final String text;
  final bool? isRecent;

  SortTextParams({
    required this.text,
    this.isRecent,
  });
}
