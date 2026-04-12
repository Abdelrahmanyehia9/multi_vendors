import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_state.dart';
import '../../../core/models/product_model.dart';

class ProductsByVendorCubit extends Cubit<BaseState<List<ProductModel>>> {
  ProductsByVendorCubit():super(const BaseState.initial()) ;

}