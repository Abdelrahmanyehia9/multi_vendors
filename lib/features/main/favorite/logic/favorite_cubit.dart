import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/favorite/data/model/extension/favorite_model_extension.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_model.dart';
import 'package:multi_vendor/features/main/favorite/data/repository/favorite_repository.dart';

class FavoriteCubit extends Cubit<BaseState<FavoriteModel>> {
  final FavoriteRepository _repository;
  FavoriteModel favoriteModel =
  FavoriteModel(favoriteProducts: [], favoriteVendors: []);
  FavoriteCubit(this._repository) : super(const BaseState.initial());
  // ---------------- INIT ----------------
  Future<void> init() async {
    safeEmit(const BaseState.loading());
    final result = await _repository.getFavorite();
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
        favoriteModel = r;
        safeEmit(BaseState.success(r));
      },
    );
  }
  // ---------------- TOGGLE ----------------
  Future<void> toggleFavorite(
     FavoriteItem item,
  ) async {
    final updated = _toggleLocal(item);
    await _update(updated);
  }
  // ---------------- UPDATE ----------------
  Future<void> _update(
     FavoriteModel item,
  ) async {
    favoriteModel = item;
    safeEmit(BaseState.success(item));
    await _repository.updateFavorite(item);
  }
  // ---------------- LOCAL TOGGLE ----------------
  FavoriteModel _toggleLocal(FavoriteItem item) => favoriteModel.toggle(item,);
  // ---------------- CHECK ----------------
  bool isInFavorite(FavoriteItem item) => favoriteModel.containsItem(item,);

}