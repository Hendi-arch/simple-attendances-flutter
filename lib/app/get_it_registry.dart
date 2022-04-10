import 'package:get_it/get_it.dart';
import 'package:simple_attendances/core/services/geo_service.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/views/helpers/dialog_helper.dart';

final getIt = GetIt.I;

final getItRegistry = GetItRegistry();

class GetItRegistry {
  Future<void> doRegister() async {
    // Register services
    getIt.registerLazySingleton(() => UserStore());
    getIt.registerLazySingleton(() => DialogHelper());
    getIt.registerLazySingleton(() => GeoService());
  }
}
