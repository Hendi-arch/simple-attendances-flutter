import 'package:hive_flutter/hive_flutter.dart';

part 'attendances_model.g.dart';

@HiveType(typeId: 2)
class AttendancesModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  double? lat;

  @HiveField(2)
  double? lng;

  @HiveField(3)
  DateTime? timestamp;
}
