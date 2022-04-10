import 'package:hive_flutter/hive_flutter.dart';

class HiveDbService {
  static HiveDbService? _hiveDbService;

  static Future<HiveDbService> getInstance() async {
    if (_hiveDbService == null) {
      var _service = HiveDbService._();
      await _service._init();
      _hiveDbService = _service;
    }
    return _hiveDbService!;
  }

  HiveDbService._();

  Future _init() async {
    await Hive.initFlutter();
  }

  static const String constAttendancesBox = "attendances";
  static const String constLocationsBox = "locations";
  static const String constUserBox = "user";
  
  static const String constAttend = "attend";
  static const String constUsername = "username";
  static const String constUserLocale = "locale";
  static const String constCurrentPinLocation = "currentPinLocation";

  static void registerAdapter<T>(TypeAdapter<T> boxAdapter) {
    if (!Hive.isAdapterRegistered(boxAdapter.typeId)) {
        Hive.registerAdapter(boxAdapter);
      }
  }

  static Future<Box<T>> openBox<T>(String box) async {
    return await Hive.openBox<T>(box);
  }

  static Box<T> getBox<T>(String box) {
    return Hive.box<T>(box);
  }

  static bool isBoxOpen(String box) => Hive.isBoxOpen(box);

  static Future<void> close(String box) => Hive.box(box).close();

  static Future<void> closeAllBoxes() => Hive.close();
}
