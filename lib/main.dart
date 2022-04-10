import 'package:flutter/material.dart';
import 'package:simple_attendances/app/main_app.dart';
import 'package:simple_attendances/core/models/models.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive setup
  await HiveDbService.getInstance();
  HiveDbService.registerAdapter<MasterLocationModel>(MasterLocationModelAdapter());
  HiveDbService.registerAdapter<AttendancesModel>(AttendancesModelAdapter());

  // GetIt setup
  getItRegistry.doRegister();

  runApp(const MainApp());
}
