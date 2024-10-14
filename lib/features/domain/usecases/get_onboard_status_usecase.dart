import '../../../core/usecase/usecase.dart';
import '../repositories/local_onboard_repository.dart';

class GetOnboardStatusUsecase implements UseCase<bool, void> {
  final LocalOnboardRepository _onboardRepository;

  GetOnboardStatusUsecase(this._onboardRepository);

  @override
  Future<bool> call({void params}) async {
    return await _onboardRepository.getOnboardStatus();
  }
}
