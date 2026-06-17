import 'package:flutter/material.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_vendor_cubit.dart';
import 'package:multi_vendor/features/main/home/view/home_screen.dart';

mixin HomeBoostVendorsMixin on State<HomeScreen> {
  final List<HomeProductByVendorCubit> boosts = [];

  @override
  void initState() {
    super.initState();
    if (FeatureFlags.multiVendor) {
      for (int i = 0; i < AppConfigs.vendorBoost.length; i++) {
        if (AppConfigs.vendorBoost.isExists(i)) {
          boosts.add(
            HomeProductByVendorCubit(getIt.get<HomeRepository>())
              ..getProducts(vendorId: AppConfigs.vendorBoost[i]),
          );
        }
      }
    }
  }

  void refreshBoosts() {
    for (int i = 0; i < boosts.length; i++) {
      boosts[i].getProducts(vendorId: AppConfigs.vendorBoost[i]);
    }
  }

  @override
  void dispose() {
    for (final cubit in boosts) {
      cubit.close();
    }
    super.dispose();
  }
}