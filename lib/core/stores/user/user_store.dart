import 'package:mobx/mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';
import 'package:simple_attendances/core/models/master_location_model.dart';

part 'user_store.g.dart';

const double maxDistance = 50;

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store, NavigatorMixin {
  ObservableFuture<Box<dynamic>>? get startupFuture => _startupFuture;

  Box? get userBox => _userBox;

  @observable
  ObservableFuture<Box<dynamic>>? _startupFuture;

  @observable
  Box? _userBox;

  @observable
  Future<void> initUserBox() async {
    // Open startup box
    _startupFuture = ObservableFuture<Box<dynamic>>(HiveDbService.openBox<dynamic>(HiveDbService.constUserBox));
    _userBox = await _startupFuture;
  }

  bool isHaveCredential() {
    return (_userBox?.isOpen ?? false) && _userBox?.get(HiveDbService.constUsername) != null;
  }

  String? getUsername() => _userBox?.get(HiveDbService.constUsername);

  String getUserLocale() {
    return _userBox?.get(HiveDbService.constUserLocale) ?? 'en';
  }

  MasterLocationModel? getCurrentPinLocation() {
    return _userBox?.get(HiveDbService.constCurrentPinLocation);
  }

  void setCurrentPinLocation(MasterLocationModel? location) {
    _userBox?.put(HiveDbService.constCurrentPinLocation, location);
  }

  void setUserData(
    String name,
    String? locale,
  ) {
    _userBox?.put(HiveDbService.constUsername, name);
    if (locale != null) {
      _userBox?.put(HiveDbService.constUserLocale, locale);
    }
  }

  void signOut() {
    _userBox?.delete(HiveDbService.constUsername);
    _userBox?.delete(HiveDbService.constCurrentPinLocation);
  }
}
