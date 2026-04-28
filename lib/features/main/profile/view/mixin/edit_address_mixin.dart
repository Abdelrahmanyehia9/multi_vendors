import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_profile_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/edit_address_screen.dart';
import 'package:multi_vendor/core/service/geo_locator.dart';
import 'package:multi_vendor/shared/data/models/address_model.dart';

mixin EditAddressMixin on State<EditAddressScreen> {


  @override
  void initState() {
    _initLocation();
    _initControllers();
    super.initState();
  }
  Placemark? _placemark;
  final formKey = GlobalKey<FormState>();
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController streetController;
  late TextEditingController buildingController;
  late TextEditingController apartmentController;
  late TextEditingController floorController;
  late TextEditingController specialMarkController;
  late TextEditingController zipCodeController;
  late TextEditingController locationNameController;
  late final List<TextEditingController> _controllers = [
    countryController,
    cityController,
    streetController,
    buildingController,
    apartmentController,
    floorController,
    specialMarkController,
    zipCodeController,
    locationNameController,
  ];
  EditProfileCubit get profileCubit => context.read<EditProfileCubit>();
  AddressModel? address ;
  final GeolocatorService geoLocator = getIt.get<GeolocatorService>();
  Future<void> _initLocation() async {
    if(userCubit.user?.address != null) return;
    Position? location;
    final bool locationEnabled = await geoLocator
        .checkPermission();
    if (locationEnabled) {
      location = await geoLocator.getCurrentLocation();
      if (location != null) {
        final placeMarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        _placemark = placeMarks.isNotEmpty ? placeMarks.first : null;
      }
    }
    return;
  }
  void _initControllers() {
    ///initial address from user cubit
    final iA = userCubit.user?.address;
    countryController = TextEditingController(text:iA?.country?? _placemark?.country);
    cityController = TextEditingController(text:iA?.city?? _placemark?.locality);
    streetController = TextEditingController(text:iA?.street?? _placemark?.street);
    buildingController = TextEditingController(text: iA?.buildNum);
    apartmentController = TextEditingController(text: iA?.aptNum);
    floorController = TextEditingController(text: iA?.floor?.toString());
    specialMarkController = TextEditingController(text: iA?.specialMark);
    zipCodeController = TextEditingController(
      text:iA?.postalCode?.toString() ?? _placemark?.postalCode,
    );
    locationNameController = TextEditingController(text: iA?.name);
  }

  void resetAddress() {
    for (var c in _controllers) {
      c.clear();
    }
  }

  void onSave() {
    if (!formKey.currentState!.validate()) return;
     address = AddressModel(
        country: countryController.text,
        city: cityController.text,
        buildNum: buildingController.text,
        aptNum: apartmentController.text,
        street: streetController.text ,
    floor: int.tryParse(floorController.text),
      postalCode: int.tryParse(zipCodeController.text),
      specialMark: specialMarkController.textOrNull,
      name: locationNameController.textOrNull,
    );
     context.read<EditProfileCubit>().editAddress(address!) ;
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }
}
