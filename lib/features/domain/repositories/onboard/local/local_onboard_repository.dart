abstract class LocalOnboardRepository {
  Future<void> saveOnboardStatus(bool value);
  Future<bool> getOnboardStatus();
}
