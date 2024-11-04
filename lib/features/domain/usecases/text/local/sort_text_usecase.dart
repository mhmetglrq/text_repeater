import '../../../../../core/usecase/usecase.dart';
import '../../../repositories/text/local/local_text_repository.dart';

class SortTextUsecase implements UseCase<String, String> {
  final LocalTextRepository _localTextRepository;

  SortTextUsecase(this._localTextRepository);

  @override
  Future<String> call({String? params}) async {
    return await _localTextRepository.sortText(text: params!);
  }
}
