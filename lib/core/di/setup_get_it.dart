import 'package:get_it/get_it.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/features/main/profile/data/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show SupabaseClient, Supabase;

// import '../database/hive_local_storage.dart';
import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/data/repository/otp_repository.dart';
import '../../features/authentication/data/repository/reset_password_repository.dart';
import '../../features/main/favorite/data/repository/favorite_repository.dart';
import '../../features/main/favorite/logic/favorite_cubit.dart';
import '../../features/main/home/data/repository/home_repository.dart';
import '../../features/news/data/repository/news_repository.dart';
import '../../features/shop/cart/data/repository/cart_repository.dart';
import '../../features/shop/cart/logic/cart_cubit.dart';
import '../../features/shop/product/data/repository/product_repository.dart';
import '../../features/vendors/data/repository/vendor_repository.dart';
import '../cubit/user_cubit.dart';
import '../database/hive_local_storage.dart';
import '../database/local_storage.dart';
import '../database/shared_pref_local_storage.dart';
import '../service/database_service.dart';
import '../utils/helper/user_session_helper.dart';

GetIt getIt = GetIt.instance;
UserCubit userCubit = getIt.get<UserCubit>();
CartCubit cartCubit = getIt.get<CartCubit>();
FavoriteCubit favoriteCubit = getIt.get<FavoriteCubit>();


class DI{
const  DI._();
static const String _userCache = 'userCache';
static const String _cartCache = 'cartCache';
static const String _favoriteCache = 'favoriteCache';
static const String _settings = 'settings';

 static Future<void> setupGetIt() async {
   await _setupLocalStorage();
    getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
    getIt.registerLazySingleton(
          () => AuthenticationService(getIt.get<SupabaseClient>()),
    );
    getIt.registerLazySingleton(
          () => DatabaseService(getIt.get<SupabaseClient>()),
    );
    getIt.registerLazySingleton(
          () =>
          UserSessionHelper(
            getIt.get<AuthenticationService>(),
            getIt.get<DatabaseService>(),
            getIt.get<LocalStorage>(instanceName: LocalStorageConstants.settings),
            getIt.get<LocalStorage>(instanceName: _userCache),
          ),
    );
    getIt.registerLazySingleton(() => UserCubit(getIt.get<UserSessionHelper>()));
    getIt.registerLazySingleton(() => CartCubit(getIt.get<CartRepository>()));
    getIt.registerLazySingleton(() => FavoriteCubit(getIt.get<FavoriteRepository>()));
    getIt.registerFactory(() =>
        AuthRepository(
            getIt.get<AuthenticationService>() ));
    getIt.registerFactory(()=>OtpRepository(getIt.get<AuthenticationService>())) ;
    getIt.registerFactory(()=>ResetPasswordRepository(getIt.get<AuthenticationService>())) ;
    getIt.registerFactory(()=>ProfileRepository(getIt.get<AuthenticationService>())) ;
    getIt.registerFactory(()=>HomeRepository(getIt.get<DatabaseService>()));
    getIt.registerFactory(()=>ProductRepository(getIt.get<DatabaseService>()));
    getIt.registerFactory(()=>VendorRepository(getIt.get<DatabaseService>()));
    getIt.registerFactory(()=>CartRepository(getIt.get<LocalStorage>(instanceName: _cartCache)));
    getIt.registerFactory(()=>FavoriteRepository(getIt.get<LocalStorage>(instanceName: _favoriteCache)));
    getIt.registerFactory(()=>NewsRepository(getIt.get<DatabaseService>()));
  }

  static Future<void>_setupLocalStorage()async{
    await HiveLocalStorage.init();
    await HiveLocalStorage.openBox(HiveBoxes.userBox) ;
    await HiveLocalStorage.openBox(HiveBoxes.cartBox) ;
    await HiveLocalStorage.openBox(HiveBoxes.favoriteBox) ;

    getIt.registerSingleton<LocalStorage>(
      await SharedPrefLocalStorage.create(),
      instanceName: _settings,
    );
    getIt.registerLazySingleton<LocalStorage>(
          () => HiveLocalStorage(HiveBoxes.userBox),
      instanceName: _userCache,
    );
    getIt.registerLazySingleton<LocalStorage>(
          () => HiveLocalStorage(HiveBoxes.cartBox),
      instanceName: _cartCache,
    );
    getIt.registerLazySingleton<LocalStorage>(
          () => HiveLocalStorage(HiveBoxes.favoriteBox),
      instanceName: _favoriteCache,
    );

  }




}



