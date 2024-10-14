import '../../../core/usecase/usecase.dart';
import '../repositories/local_onboard_repository.dart';

class SaveOnboardStatusUseCase implements UseCase<void, bool> {
  final LocalOnboardRepository _onboardRepository;

  SaveOnboardStatusUseCase(this._onboardRepository);

  @override
  Future<void> call({bool? params}) async {
    return await _onboardRepository.saveOnboardStatus(params ?? false);
  }
}
