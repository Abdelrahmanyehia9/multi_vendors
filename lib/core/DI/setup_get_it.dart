import 'package:get_it/get_it.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show SupabaseClient, Supabase;

// import '../database/hive_local_storage.dart';
import '../cubit/user_cubit.dart';
import '../database/local_storage.dart';
import '../database/shared_pref_local_storage.dart';
import '../helper/user_session_helper.dart';
import '../service/database_service.dart';

GetIt getIt = GetIt.instance;
UserCubit userCubit = getIt.get<UserCubit>();
Future<void> setupGetIt() async {
  // await HiveLocalStorage.init();
  // getIt.registerLazySingleton<LocalStorage>(
  //       () => HiveLocalStorage('cache_box'),
  //   instanceName: LocalStorageConstants.cache,
  // );
  getIt.registerSingleton<LocalStorage>(
    await SharedPrefLocalStorage.create(),
    instanceName: LocalStorageConstants.settings,
  );
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton(
    () => AuthenticationService(getIt.get<SupabaseClient>()),
  );
  getIt.registerLazySingleton(
    () => DatabaseService(getIt.get<SupabaseClient>()),
  );
  getIt.registerLazySingleton(
    () => UserSessionHelper(
      getIt.get<AuthenticationService>(),
      getIt.get<DatabaseService>(),
      getIt.get<LocalStorage>(instanceName: LocalStorageConstants.settings),
    ),
  );
  getIt.registerLazySingleton(() => UserCubit(getIt.get<UserSessionHelper>()));
}
