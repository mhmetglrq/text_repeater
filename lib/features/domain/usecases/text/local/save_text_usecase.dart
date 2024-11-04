import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';

import '../../../../../config/models/text_model.dart';
import '../../../../../core/usecase/usecase.dart';

class SaveTextUsecase implements UseCase<void, TextModel> {
  final LocalTextRepository _localTextRepository;

  SaveTextUsecase(this._localTextRepository);
  @override
  Future<void> call({TextModel? params}) async {
    return await _localTextRepository.saveText(textModel: params!);
  }
}
