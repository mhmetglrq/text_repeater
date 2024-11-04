import 'package:text_repeater/core/usecase/usecase.dart';

import '../../../../../config/models/text_model.dart';
import '../../../repositories/text/local/local_text_repository.dart';

class GetSavedTextsUsecase implements UseCase<List<TextModel>, void> {
  final LocalTextRepository _repository;

  GetSavedTextsUsecase(this._repository);

  @override
  Future<List<TextModel>> call({void params}) async {
    return await _repository.getSavedTexts();
  }
}
