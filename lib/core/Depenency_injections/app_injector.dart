import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:heath_genie/feature/Home/data/datasource/scanned_patient_list_data_source.dart';
import 'package:heath_genie/feature/Home/data/datasource/scanned_patient_list_data_source_impl.dart';
import 'package:heath_genie/feature/Home/domain/repository/scanned_patient_repository.dart';
import 'package:heath_genie/feature/Home/domain/usecase/scanned_patient_list_usecase.dart';
import 'package:heath_genie/feature/Home/presentation/cubit/scanned_patient_list_cubit.dart';
import 'package:heath_genie/feature/detail/data/datasource/patient_detail_data_source.dart';
import 'package:heath_genie/feature/detail/domain/repository/patient_repository.dart';
import 'package:heath_genie/feature/detail/domain/usecase/patient_detail_usecase.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_cubit.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/spyro_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../feature/Home/data/repository/scanned_patient_list_repository_impl.dart';
import '../../feature/auth/data/datasource/login_data_source.dart';
import '../../feature/auth/data/datasource/login_data_source_impl.dart';
import '../../feature/auth/data/repositories/login_repository_impl.dart';
import '../../feature/auth/domain/repository/login_repository.dart';
import '../../feature/auth/domain/usecase/login_usecase.dart';
import '../../feature/auth/presentation/cubit/login_cubit.dart';
import '../../feature/common/user/cubit/user_cubit.dart';
import '../../feature/detail/data/datasource/patient_detail_data_source_impl.dart';
import '../../feature/detail/data/repository/patient_detail_repository_impl.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Register Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(loginDataSource: sl()),
  );
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(patientDetailDataSource: sl()),
  );

  sl.registerLazySingleton<ScannedPatientListRepository>(
        () => ScannedPatientListRepositoryImpl(scannedPatientListDataSource: sl()),
  );

  // Register Use Case
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(loginRepository: sl()),
  );
  sl.registerLazySingleton<PatientDetailUseCase>(
    () => PatientDetailUseCase(patientRepository: sl()),
  );

  sl.registerLazySingleton<ScannedPatientListUseCase>(
        () => ScannedPatientListUseCase(scannedPatientListRepository: sl()),
  );

  //Register cubit
  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerFactory(() => LoginCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PatientDetailCubit(sl(), sl()));
  sl.registerFactory(() => ScannedPatientListCubit(sl(), sl()));
  sl.registerFactory(() => SpyroCubit());

  //Register DataSource
  sl.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceDataSourceImpl(),
  );
  sl.registerLazySingleton<PatientDetailDataSource>(
    () => PatientDetailDataSourceImpl(),
  );

  sl.registerLazySingleton<ScannedPatientListDataSource>(
        () => ScannedPatientListDataSourceImpl(),
  );
}
