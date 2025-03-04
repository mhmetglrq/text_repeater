// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:text_repeater/core/usecase/usecase.dart';

import '../../../repositories/text/local/local_text_repository.dart';

class CreateWordCloudUseCase
    implements UseCase<List<Map<String, dynamic>>, CreateWordCloudUseCaseParams> {
  final LocalTextRepository _localTextRepository;
  CreateWordCloudUseCase(this._localTextRepository);
  @override
  Future<List<Map<String, dynamic>>> call({CreateWordCloudUseCaseParams? params}) async {
    return await _localTextRepository.wordCloud(text: params!.text, isRecent: params.isRecent);
  }
}

class CreateWordCloudUseCaseParams {
  final String text;
  final bool? isRecent;
  CreateWordCloudUseCaseParams({required this.text, this.isRecent});
}
