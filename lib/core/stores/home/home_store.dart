import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_attendances/app/routes.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:simple_attendances/core/models/attendances_model.dart';
import 'package:simple_attendances/core/models/master_location_model.dart';
import 'package:simple_attendances/core/services/geo_service.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/views/helpers/dialog_helper.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/extensions/logger_extension.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store, NavigatorMixin {
  final UserStore userStore = getIt<UserStore>();
  final GeoService geoService = getIt<GeoService>();
  final DialogHelper dialogHelper = getIt<DialogHelper>();

  Box<AttendancesModel> get attendancesBox => HiveDbService.getBox<AttendancesModel>(HiveDbService.constAttendancesBox);

  void signOut(BuildContext context) async {
    final bool result = await dialogHelper.confirmationDialog(
      context,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out?',
    );

    if (result) {
      userStore.signOut();
      HiveDbService.getBox<MasterLocationModel>(HiveDbService.constLocationsBox).clear();
      HiveDbService.getBox<AttendancesModel>(HiveDbService.constAttendancesBox).clear();
      removeCurrentAndGoNamed(route: Routes.signIn);
    }
  }

  Future<void> goToLocationScreen(BuildContext context) async {
    final _locationPermissionStatus = await geoService.checkPermission();

    try {
      if (_locationPermissionStatus == LocationPermission.always || _locationPermissionStatus == LocationPermission.whileInUse) {
        goNamed(route: Routes.location);
      } else {
        await geoService.determinePosition(context).then((value) {
          if (value is Position) {
            goNamed(route: Routes.location);
          }
        });
      }
    } catch (e) {
      e.toString().logger();
    }
  }

  @action
  Future<void> addAttendances(BuildContext context) async {
    if (userStore.getCurrentPinLocation() != null) {
      final _result = await dialogHelper.confirmationDialog(
        context,
        title: 'Add Attendances',
        message: 'Make sure you in the correct location before adding attendances.',
      );

      // Get current location
      if (_result) {
        final _position = await geoService.determinePosition(context);

        if (_position is Position) {
          final _distance = geoService.distanceBetween(LatLng(_position.latitude, _position.longitude),
              LatLng(userStore.getCurrentPinLocation()!.lat!, userStore.getCurrentPinLocation()!.lng!));

          "Distance: ${_distance.toString()}".logger();

          if (_distance > maxDistance) {
            dialogHelper.snackBar(message: "You are too far from the pin location. Please try again.");
          } else {
            final _attendances = AttendancesModel()
              ..name = userStore.getUsername()
              ..timestamp = DateTime.now()
              ..lat = _position.latitude
              ..lng = _position.longitude;

            await attendancesBox.put(HiveDbService.constAttend, _attendances);
            dialogHelper.snackBar(message: "Attendances added successfully.");
          }
        }
      }
    } else {
      dialogHelper.snackBar(message: 'Please set your pin point first');
    }
  }
}
