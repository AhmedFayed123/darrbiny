
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repos/home_repo.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import 'storage_service.dart';


final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    await _initSharedPref();
    _initServices();
    _initRepositories();
  }

  Future<void> _initSharedPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPref);
  }

  void _initServices() {
    sl.registerLazySingleton<StorageService>(() => StorageService());
    sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl());

  }

  void _initRepositories() {
    // sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
    // sl.registerLazySingleton<SignupRepo>(() => SignupRepoImpl());
    // sl.registerLazySingleton<MarketRepo>(() => MarketRepoImpl());
    // sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
    // sl.registerLazySingleton<WalletRepo>(() => WalletRepoImpl());
    // sl.registerLazySingleton<TradeRepo>(() => TradeRepoImpl());
    // sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(dio: Dio()));

  }
}
