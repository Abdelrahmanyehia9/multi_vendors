import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';

class VendorRepository {
  final DatabaseService _db;
  const VendorRepository(this._db);
  Future<Either<AppException, VendorDetailsModel>> getVendorDetails(
    int vendorId,
  ) async {

      final response = await _db.GET_SINGLE(
        table: RemoteDatabaseConstants.vendor_table,
        filter: (q) => q.eq(RemoteDatabaseConstants.id_column, vendorId),
      );
      final vendor = VendorDetailsModel.fromJson(response) ;
      return right(vendor);

  }
}
