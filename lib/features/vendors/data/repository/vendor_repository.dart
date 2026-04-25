import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/utils/rpc_functions.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';

import '../../../../core/queries/shop_queries.dart';


class VendorRepository {
  final DatabaseService _db;

  const VendorRepository(this._db);

  Future<Either<AppException, VendorDetailsModel>> getVendorDetails(
    int vendorId,
  ) async {
    try {
      final response = await _db.RPC(
        function: RpcFunctions.getVendorDetailsRPC,
        params: {"vendor_id": vendorId},
      );
      final vendor = VendorDetailsModel.fromJson(response);
      return right(vendor);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<VendorDetailsModel>>> getVendorsByCategory(int categoryId) async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.vendor_table,
        select: ShopQueries.vendorsByCategory,
        filter: (e)=>e.contains("categories", [categoryId])
      );
      final vendors = List<VendorDetailsModel>.from(response.map((x) => VendorDetailsModel.fromJson(x)));
      return right(vendors);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
