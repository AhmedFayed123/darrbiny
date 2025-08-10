
import 'package:darrbiny/features/exercises/data/repos/learner_exercises_repo.dart';
import 'package:darrbiny/features/exercises/data/repos/learner_exercises_repo_impl.dart';
import 'package:darrbiny/features/instructor_exercises/data/repos/instructor_exercises_repo_impl.dart';
import 'package:darrbiny/features/login/data/repos/login_repo.dart';
import 'package:darrbiny/features/login/data/repos/login_repo_impl.dart';
import 'package:darrbiny/features/message/data/repos/chat_repo.dart';
import 'package:darrbiny/features/message/data/repos/chat_repo_impl.dart';
import 'package:darrbiny/features/payment/data/repos/payment_repo.dart';
import 'package:darrbiny/features/payment/data/repos/payment_repo_impl.dart';
import 'package:darrbiny/features/profile/data/repos/profile_repo.dart';
import 'package:darrbiny/features/profile/data/repos/profile_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repos/home_repo.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/instructor_exercises/data/repos/instructor_exercises_repo.dart';
import '../../features/instructor_home/data/repos/instructor_home_repo.dart';
import '../../features/instructor_home/data/repos/instructor_home_repo_impl.dart';
import '../../features/sign_up/data/repos/sign_up_repo.dart';
import '../../features/sign_up/data/repos/sign_up_repo_impl.dart';
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


  }

  void _initRepositories() {
    sl.registerLazySingleton<SignUpRepo>(() => SignUpRepoImpl());
    sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
    sl.registerLazySingleton<StorageService>(() => StorageService());
    sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl());
    sl.registerLazySingleton<InstructorHomeRepo>(() => InstructorHomeRepoImpl());
    sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
    sl.registerLazySingleton<ChatRepo>(() => ChatRepoImpl());
    sl.registerLazySingleton<LearnerExercisesRepo>(() => LearnerExercisesRepoImpl());
    sl.registerLazySingleton<InstructorExercisesRepo>(() => InstructorExercisesRepoImpl());
    sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());


  }
}
