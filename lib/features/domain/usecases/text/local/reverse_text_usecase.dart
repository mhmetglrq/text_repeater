// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:text_repeater/core/usecase/usecase.dart';
import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';

class ReverseTextUsecase implements UseCase<String, String> {
  final LocalTextRepository _localTextRepository;
  ReverseTextUsecase(
    this._localTextRepository,
  );

  @override
  Future<String> call({String? params}) async {
    return await _localTextRepository.reverseText(text: params!);
  }
}
