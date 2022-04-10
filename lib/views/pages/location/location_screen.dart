import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/core/utility/fun_utils.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/views/helpers/gap.dart';
import 'package:simple_attendances/views/widgets/custom_text_widget.dart';
import 'package:simple_attendances/core/models/master_location_model.dart';
import 'package:simple_attendances/core/stores/location/location_store.dart';
import 'package:simple_attendances/views/widgets/keyboard_dismissed_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> with NavigatorMixin {
  final LocationStore _locationStore = LocationStore();

  GoogleMapController? _controller;

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      _controller = controllerParam;
    });
  }

  @override
  void initState() {
    _locationStore.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return KeyboardDismissedWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Observer(
          builder: (context) {
            switch (_locationStore.initState) {
              case ViewState.initial:
                return const Center(child: CircularProgressIndicator());
              case ViewState.loading:
                return const Center(child: CircularProgressIndicator());
              case ViewState.loaded:
                return _buildBody(_size);
              case ViewState.error:
                return const Center(child: Text('Error'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _locationStore.saveLocation();
          },
          tooltip: 'Add To Pin Location',
          child: const Icon(Icons.add_location),
        ),
      ),
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              // Google map.
              GoogleMap(
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                mapType: _locationStore.mapType,
                initialCameraPosition: _locationStore.initialPosition!,
                onTap: (LatLng latLng) {
                  _locationStore.searchLocations(_controller, latLng: latLng);
                },
              ),
              // Search bar.
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _locationStore.formKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Search',
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              back();
                            },
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              _locationStore.searchLocations(_controller);
                            },
                          ),
                        ),
                        cursorColor: Colors.black,
                        onFieldSubmitted: (value) {
                          _locationStore.searchLocations(_controller);
                        },
                        textInputAction: TextInputAction.search,
                        controller: _locationStore.addressController,
                      ),
                    ),
                  ),
                ),
              ),

              // Circularloading indicator when searching.
              if (_locationStore.searchState == ViewState.loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),

        // List of history locations.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                      fontSize: 15,
                      text: "Pin Pointed Locations",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2, 2),
                          ),
                        ],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    tenPx,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<MapType>(
                        iconSize: 20,
                        elevation: 16,
                        value: _locationStore.mapType,
                        icon: const Icon(Icons.map),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        underline: const SizedBox.shrink(),
                        onChanged: (MapType? newValue) {
                          if (_locationStore.mapType != newValue) {
                            _locationStore.mapType = newValue!;
                          }
                        },
                        items: MapType.values
                            .map((MapType value) => DropdownMenuItem<MapType>(
                                  value: value,
                                  child: Text(
                                    getEnumName(value),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<BoxEvent>(
                  stream: _locationStore.masterLocationBox?.watch(),
                  builder: (context, snapshot) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      controller: _locationStore.scrollController,
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: _locationStore.masterLocationBox?.length ?? 0,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemBuilder: (context, index) {
                        final location = _locationStore.masterLocationBox?.get(index);

                        return ValueListenableBuilder<Box<dynamic>>(
                          valueListenable: _locationStore.userStore.userBox!.listenable(),
                          builder: (_, userBox, __) {
                            return RadioListTile<MasterLocationModel?>(
                              title: CustomTextWidget(text: location?.address),
                              subtitle: CustomTextWidget(text: '${location?.lat}, ${location?.lng}'),
                              value: location,
                              onChanged: (MasterLocationModel? value) {
                                _locationStore.setCurrentPinLocation(_controller, value);
                              },
                              groupValue: _locationStore.userStore.getCurrentPinLocation(),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
