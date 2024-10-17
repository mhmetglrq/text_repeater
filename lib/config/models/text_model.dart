import 'package:hive/hive.dart';

part 'text_model.g.dart'; // Bu dosya build_runner ile üretilecek

@HiveType(typeId: 0) // typeId her model için benzersiz olmalı
class TextModel extends HiveObject {
  @HiveField(0)
  final String? text;

  @HiveField(1)
  final DateTime? createdAt;

  @HiveField(2)
  final String? type;

  @HiveField(3)
  final int? repeatCount;

  TextModel({
    this.text,
    this.createdAt,
    this.type,
    this.repeatCount,
  });
}
