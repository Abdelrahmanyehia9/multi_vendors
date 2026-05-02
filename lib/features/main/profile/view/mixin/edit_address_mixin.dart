import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_address_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/edit_address_screen.dart';
import 'package:multi_vendor/core/service/geo_locator.dart';
import 'package:multi_vendor/shared/data/models/address_model.dart';

mixin EditAddressMixin on State<EditAddressScreen> {

  @override
  void initState() {
    super.initState();
    _initControllers();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _initLocation());
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
    countryController, cityController, streetController,
    buildingController, apartmentController, floorController,
    specialMarkController, zipCodeController, locationNameController,
  ];

  EditAddressCubit get addressCubit => context.read<EditAddressCubit>();
  AddressModel? address;
  final GeolocatorService geoLocator = getIt.get<GeolocatorService>();

  void _initControllers() {
    final iA = userCubit.user?.address;
    countryController = TextEditingController(text: iA?.country);
    cityController = TextEditingController(text: iA?.city);
    streetController = TextEditingController(text: iA?.street);
    buildingController = TextEditingController(text: iA?.buildNum);
    apartmentController = TextEditingController(text: iA?.aptNum);
    floorController = TextEditingController(text: iA?.floor?.toString());
    specialMarkController = TextEditingController(text: iA?.specialMark);
    zipCodeController = TextEditingController(text: iA?.postalCode?.toString());
    locationNameController = TextEditingController(text: iA?.name);
  }

  Future<void> _initLocation() async {
    if (userCubit.user?.address != null) return;
    if (!await geoLocator.checkPermission()) return;
    final location = await geoLocator.getCurrentLocation();
    if (location == null) return;
    _placemark = (await placemarkFromCoordinates(location.latitude, location.longitude)).first;
    if (countryController.text.isEmpty) countryController.text = _placemark?.country ?? '';
    if (cityController.text.isEmpty) cityController.text = _placemark?.locality ?? '';
    if (streetController.text.isEmpty) streetController.text = _placemark?.street ?? '';
    if (zipCodeController.text.isEmpty) zipCodeController.text = _placemark?.postalCode ?? '';
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
      street: streetController.text,
      floor: int.tryParse(floorController.text),
      postalCode: int.tryParse(zipCodeController.text),
      specialMark: specialMarkController.textOrNull,
      name: locationNameController.textOrNull,
    );
    addressCubit.editAddress(address!);
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }
}