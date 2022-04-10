import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_attendances/core/utility/fun_utils.dart';
import 'package:simple_attendances/core/services/geo_service.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/views/helpers/dialog_helper.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';
import 'package:simple_attendances/core/extensions/logger_extension.dart';
import 'package:simple_attendances/core/models/master_location_model.dart';

part 'location_store.g.dart';

class LocationStore = _LocationStoreBase with _$LocationStore;

abstract class _LocationStoreBase with Store {
  final DialogHelper _dialogHelper = getIt<DialogHelper>();
  final UserStore userStore = getIt<UserStore>();
  final GeoService _geoService = getIt<GeoService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController addressController = TextEditingController();

  CameraPosition? get initialPosition => _initialPosition;

  Box<MasterLocationModel>? get masterLocationBox => _locationBox;

  CameraPosition? _initialPosition;

  CameraPosition? _searchPosition;

  @observable
  Box<MasterLocationModel>? _locationBox;

  @observable
  MapType mapType = MapType.normal;

  @observable
  ObservableFuture<void>? _initFuture;

  @observable
  ObservableFuture<List<Location>>? _searchLocationFuture;

  @computed
  ViewState get searchState => _searchLocationFuture?.status == null
      ? ViewState.initial
      : _searchLocationFuture?.status == FutureStatus.rejected
          ? ViewState.error
          : _searchLocationFuture?.status == FutureStatus.pending
              ? ViewState.loading
              : ViewState.loaded;

  @computed
  ViewState get initState => _initFuture?.status == null
      ? ViewState.initial
      : _initFuture?.status == FutureStatus.rejected
          ? ViewState.error
          : _initFuture?.status == FutureStatus.pending
              ? ViewState.loading
              : ViewState.loaded;

  @action
  Future<void> init() async {
    try {
      // Get history locations from hive.
      _locationBox = HiveDbService.getBox<MasterLocationModel>(HiveDbService.constLocationsBox);

      // Get initial position.
      _initFuture = ObservableFuture(
        _geoService.getCurrentPosition().then((value) {
          _initialPosition = CameraPosition(
            zoom: 19.151926040649414,
            target: LatLng(value.latitude, value.longitude),
          );
        }).catchError((error) {
          // Default to the Head Office of the company.
          _initialPosition = const CameraPosition(
            zoom: 19.151926040649414,
            target: LatLng(-6.162006, 106.794212),
          );
        }).whenComplete(() {
          _handleHistoryLocation();
        }),
      );

      await _initFuture;
    } catch (e) {
      e.toString().logger();
    }
  }

  @action
  Future<void> _handleHistoryLocation() async {
    final _isEmptyHistory = _locationBox?.isEmpty;

    try {
      if ((_isEmptyHistory ?? true)) {
        final _addresses = await _geoService.getPlacemarkFromCoordinates(_initialPosition!.target);
        final _address = concanatePlacemark(_addresses.first);

        final _masterLocation = MasterLocationModel()
          ..address = _address
          ..lat = _initialPosition?.target.latitude
          ..lng = _initialPosition?.target.longitude
          ..timestamp = DateTime.now();

        _locationBox?.add(_masterLocation);
      }
    } catch (e) {
      e.toString().logger();
    }
  }

  @action
  Future searchLocations(GoogleMapController? mapController, {LatLng? latLng}) async {
    if (latLng != null) {
      _searchPosition = CameraPosition(
        target: latLng,
        zoom: 19.151926040649414,
      );
    } else {
      if (formKey.currentState!.validate()) {
        _searchLocationFuture = ObservableFuture(_geoService.getLocationFromAddress(address: addressController.text));
        final _result = await _searchLocationFuture!;

        _searchPosition = CameraPosition(
          zoom: 19.151926040649414,
          target: latLng ?? LatLng(_result.first.latitude, _result.first.longitude),
        );
      }
    }

    if (_searchPosition != null) {
      Future.delayed(const Duration(milliseconds: 250), () {
        mapController?.animateCamera(CameraUpdate.newCameraPosition(_searchPosition!));
      });
    }
  }

  @action
  Future<void> saveLocation() async {
    if (_searchPosition != null) {
      final _addresses = await _geoService.getPlacemarkFromCoordinates(_searchPosition!.target);
      final _address = concanatePlacemark(_addresses.first);

      final _masterLocation = MasterLocationModel()
        ..address = _address
        ..lat = _searchPosition?.target.latitude
        ..lng = _searchPosition?.target.longitude
        ..timestamp = DateTime.now();

      _locationBox?.add(_masterLocation);

      // Reset [_searchPosition] to null.
      _searchPosition = null;

      // Scroll to bottom.
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }

  void setCurrentPinLocation(GoogleMapController? controller, MasterLocationModel? value) {
    userStore.setCurrentPinLocation(value);

    Future.delayed(const Duration(milliseconds: 250), () {
      controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(value?.lat ?? 0.0, value?.lng ?? 0.0),
          zoom: 19.151926040649414,
        ),
      ));
    });

    _dialogHelper.snackBar(message: 'Pin Location set to ${value?.address ?? 'Unknown'}');
  }
}
