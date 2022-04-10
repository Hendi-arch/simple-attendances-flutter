import 'package:mobx/mobx.dart';
import 'package:simple_attendances/app/routes.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:simple_attendances/core/models/attendances_model.dart';
import 'package:simple_attendances/core/models/master_location_model.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/extensions/logger_extension.dart';

part 'startup_store.g.dart';

class StartupStore = _StartupStoreBase with _$StartupStore;

abstract class _StartupStoreBase with Store, NavigatorMixin {
  final UserStore userStore = getIt<UserStore>();

  @computed
  ViewState get viewState => userStore.startupFuture == null
      ? ViewState.initial
      : userStore.startupFuture?.status == FutureStatus.pending
          ? ViewState.loading
          : userStore.startupFuture?.status == FutureStatus.rejected
              ? ViewState.error
              : ViewState.loaded;

  Future<void> handleStartup() async {
    try {
      // Init boxes
      await userStore.initUserBox();
      await HiveDbService.openBox<MasterLocationModel>(HiveDbService.constLocationsBox);
      await HiveDbService.openBox<AttendancesModel>(HiveDbService.constAttendancesBox);

      // Check user credentials
      if (userStore.isHaveCredential()) {
        removeCurrentAndGoNamed(route: Routes.home);
      } else {
        removeCurrentAndGoNamed(route: Routes.signIn);
      }
    } catch (e) {
      e.toString().logger();
    }
  }
}
