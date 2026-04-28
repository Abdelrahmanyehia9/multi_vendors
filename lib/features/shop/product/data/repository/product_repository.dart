import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/utils/rpc_functions.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';

import 'package:multi_vendor/core/queries/shop_queries.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_response_model.dart';

class ProductRepository {
  final DatabaseService _databaseService;

  const ProductRepository(this._databaseService);

  Future<Either<AppException, List<ProductTagModel>>> getAllTags() async {
    try {
      final response = await _databaseService.GET(
        table: RemoteDatabaseConstants.tags_table,
      );
      final tags = response.map((e) => ProductTagModel.fromJson(e)).toList();
      return right(tags);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, ProductDetailsModel>> getSingleProduct({
    required int pId,
  }) async {
    try {
      final response = await _databaseService.GET_SINGLE(
        table: RemoteDatabaseConstants.product_table,
        select: ShopQueries.productItemDetails,
        filter: (e) => e.eq(RemoteDatabaseConstants.id_column, pId),
      );
      final product = ProductDetailsModel.fromJson(response);
      return right(product);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, ProductsFiltersModel>> getProductFilters({
    ProductsFiltersModel? selectedFilters,
  })
  async {
try{


  final response = await _databaseService.RPC(
    function: RpcFunctions.getProductsFiltersRPC,
    params: selectedFilters?.toJson(),
  );
  final filters = ProductsFiltersModel.fromJson(response);
  return right(filters);
}catch(e){
  return left(e.toAppException);
}

  }
  Future<Either<AppException, ProductResponseModel>> getProductInFilters({
    ProductsFiltersModel? selectedFilters,
  })
  async {
   try{
     final response = await _databaseService.RPC(
       function: RpcFunctions.getProductsInFiltersRPC,
       params: selectedFilters?.toJson(),
     );
     final filters = ProductResponseModel.fromJson(response);
     return right(filters);
   }catch(e){
     return left(e.toAppException) ;
   }
  }
}
