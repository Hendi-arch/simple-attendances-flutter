import 'package:hive_flutter/hive_flutter.dart';

part 'master_location_model.g.dart';

@HiveType(typeId: 1)
class MasterLocationModel {
  @HiveField(0)
  String? address;

  @HiveField(1)
  double? lat;

  @HiveField(2)
  double? lng;

  @HiveField(3)
  DateTime? timestamp;
}
