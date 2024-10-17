import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:text_repeater/features/data/data_sources/local/hive_database_service.dart';

import '../../../../domain/repositories/onboard/local/local_onboard_repository.dart';

class LocalOnboardRepositoryImpl implements LocalOnboardRepository {
  final HiveDatabaseService _databaseService;
  Logger logger = Logger();

  LocalOnboardRepositoryImpl(this._databaseService);

  @override
  Future<bool> getOnboardStatus() async {
    try {
      return await _databaseService.getData("onboard", "status");
    } on HiveError catch (e) {
      logger.e("Error log", error: e.message);
      return false;
    }
  }

  @override
  Future<void> saveOnboardStatus(bool value) async {
    try {
      return await _databaseService.putData("onboard", "status", value);
    } on HiveError catch (e) {
      logger.e("Error log", error: e.message);
    }
  }
}
