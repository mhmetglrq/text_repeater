import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabaseService {
  HiveDatabaseService._privateConstructor();
  static final HiveDatabaseService instance =
      HiveDatabaseService._privateConstructor();

  // Belirli bir box açma (Dinamik olarak)
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  // Veri ekleme veya güncelleme
  Future<void> putData<T>(String boxName, String key, T value) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    await box.put(key, value);
    await box.close();
  }

  // Veri okuma
  Future<T?> getData<T>(String boxName, String key) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    T? value = box.get(key);
    await box.close();

    return value;
  }

  // Tüm verileri okuma
  Future<List<T>> getAllData<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    List<T> dataList = [];
    for (var i = 0; i < box.length; i++) {
      dataList.add(box.getAt(i) as T);
    }
    await box.close();
    return dataList;
  }

  // Veri silme
  Future<void> deleteData<T>(String boxName, String key) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    await box.delete(key);
    await box.close();
  }

  // Tüm verileri silme
  Future<void> clearBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    await box.clear();
    await box.close();
  }

  // Box'u kapatma
  Future<void> closeBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await openBox<T>(boxName);
    }
    final box = Hive.box<T>(boxName);
    await box.close();
  }

  // Tüm box'ları kapatma
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
