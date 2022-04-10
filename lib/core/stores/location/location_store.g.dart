// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocationStore on _LocationStoreBase, Store {
  Computed<ViewState>? _$searchStateComputed;

  @override
  ViewState get searchState =>
      (_$searchStateComputed ??= Computed<ViewState>(() => super.searchState,
              name: '_LocationStoreBase.searchState'))
          .value;
  Computed<ViewState>? _$initStateComputed;

  @override
  ViewState get initState =>
      (_$initStateComputed ??= Computed<ViewState>(() => super.initState,
              name: '_LocationStoreBase.initState'))
          .value;

  final _$_locationBoxAtom = Atom(name: '_LocationStoreBase._locationBox');

  @override
  Box<MasterLocationModel>? get _locationBox {
    _$_locationBoxAtom.reportRead();
    return super._locationBox;
  }

  @override
  set _locationBox(Box<MasterLocationModel>? value) {
    _$_locationBoxAtom.reportWrite(value, super._locationBox, () {
      super._locationBox = value;
    });
  }

  final _$mapTypeAtom = Atom(name: '_LocationStoreBase.mapType');

  @override
  MapType get mapType {
    _$mapTypeAtom.reportRead();
    return super.mapType;
  }

  @override
  set mapType(MapType value) {
    _$mapTypeAtom.reportWrite(value, super.mapType, () {
      super.mapType = value;
    });
  }

  final _$_initFutureAtom = Atom(name: '_LocationStoreBase._initFuture');

  @override
  ObservableFuture<void>? get _initFuture {
    _$_initFutureAtom.reportRead();
    return super._initFuture;
  }

  @override
  set _initFuture(ObservableFuture<void>? value) {
    _$_initFutureAtom.reportWrite(value, super._initFuture, () {
      super._initFuture = value;
    });
  }

  final _$_searchLocationFutureAtom =
      Atom(name: '_LocationStoreBase._searchLocationFuture');

  @override
  ObservableFuture<List<Location>>? get _searchLocationFuture {
    _$_searchLocationFutureAtom.reportRead();
    return super._searchLocationFuture;
  }

  @override
  set _searchLocationFuture(ObservableFuture<List<Location>>? value) {
    _$_searchLocationFutureAtom.reportWrite(value, super._searchLocationFuture,
        () {
      super._searchLocationFuture = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_LocationStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$_handleHistoryLocationAsyncAction =
      AsyncAction('_LocationStoreBase._handleHistoryLocation');

  @override
  Future<void> _handleHistoryLocation() {
    return _$_handleHistoryLocationAsyncAction
        .run(() => super._handleHistoryLocation());
  }

  final _$searchLocationsAsyncAction =
      AsyncAction('_LocationStoreBase.searchLocations');

  @override
  Future<dynamic> searchLocations(GoogleMapController? mapController,
      {LatLng? latLng}) {
    return _$searchLocationsAsyncAction
        .run(() => super.searchLocations(mapController, latLng: latLng));
  }

  final _$saveLocationAsyncAction =
      AsyncAction('_LocationStoreBase.saveLocation');

  @override
  Future<void> saveLocation() {
    return _$saveLocationAsyncAction.run(() => super.saveLocation());
  }

  @override
  String toString() {
    return '''
mapType: ${mapType},
searchState: ${searchState},
initState: ${initState}
    ''';
  }
}
