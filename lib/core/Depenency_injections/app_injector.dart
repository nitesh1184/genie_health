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
import 'package:heath_genie/feature/lab_report/blood_pressure/domain/repository/blood_pressure_repository.dart';
import 'package:heath_genie/feature/lab_report/blood_pressure/domain/usecase/blood_pressure_usecase.dart';
import 'package:heath_genie/feature/lab_report/optometry/data/datasource/optometry_data_source.dart';
import 'package:heath_genie/feature/lab_report/optometry/domain/repository/optometry_repository.dart';
import 'package:heath_genie/feature/lab_report/optometry/domain/usecase/optometry_usecase.dart';
import 'package:heath_genie/feature/lab_report/optometry/presentation/cubit/optometry_cubit.dart';
import 'package:heath_genie/feature/lab_report/spirometer/data/datasource/spirometer_data_source.dart';
import 'package:heath_genie/feature/lab_report/spirometer/domain/repository/spirometer_repository.dart';
import 'package:heath_genie/feature/lab_report/spirometer/domain/usecase/post_spirometer_usecase.dart';
import 'package:heath_genie/feature/lab_report/stethoscope/data/datasource/stethoscope_data_source.dart';
import 'package:heath_genie/feature/lab_report/stethoscope/domain/repository/stethoscope_repository.dart';
import 'package:heath_genie/feature/lab_report/stethoscope/domain/usecase/stethoscope_usecase.dart';
import 'package:heath_genie/feature/lab_report/stethoscope/presentation/cubit/stethoscope_cubit.dart';
import 'package:heath_genie/feature/lab_report/thermometer/data/datasource/thermometer_report_data_source.dart';
import 'package:heath_genie/feature/lab_report/thermometer/domain/repository/thermometer_repository.dart';
import 'package:heath_genie/feature/lab_report/thermometer/domain/usecase/thermometer_usecase.dart';
import 'package:heath_genie/feature/lab_report/thermometer/presentation/cubit/thermometer_cubit.dart';
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
import '../../feature/lab_report/basic_health_checkup/data/datasource/health_check_data_source.dart';
import '../../feature/lab_report/basic_health_checkup/data/datasource/health_check_data_source_impl.dart';
import '../../feature/lab_report/basic_health_checkup/data/repository/health_chekup_repository_impl.dart';
import '../../feature/lab_report/basic_health_checkup/domain/repository/health_checkp_repository.dart';
import '../../feature/lab_report/basic_health_checkup/domain/usecase/get_health_check_usecase.dart';
import '../../feature/lab_report/basic_health_checkup/presentation/cubit/health_check_cubit.dart';
import '../../feature/lab_report/blood_pressure/data/datasource/blood_pressure_data_source.dart';
import '../../feature/lab_report/blood_pressure/data/datasource/blood_pressure_data_source_impl.dart';
import '../../feature/lab_report/blood_pressure/data/repository/blood_pressure_repository_impl.dart';
import '../../feature/lab_report/blood_pressure/presentation/cubit/blood_pressure_cubit.dart';
import '../../feature/lab_report/bmi/data/datasource/bmi_data_source.dart';
import '../../feature/lab_report/bmi/data/datasource/bmi_data_source_impl.dart';
import '../../feature/lab_report/bmi/data/repository/bmi_repository_impl.dart';
import '../../feature/lab_report/bmi/domain/repository/bmi_repository.dart';
import '../../feature/lab_report/bmi/domain/usecase/post_emi_usecase.dart';
import '../../feature/lab_report/bmi/presentation/cubit/bmi_cubit.dart';
import '../../feature/lab_report/common/data/datasource/lab_report_data_source.dart';
import '../../feature/lab_report/common/data/datasource/lab_report_data_source_impl.dart';
import '../../feature/lab_report/common/data/repository/lab_repository_impl.dart';
import '../../feature/lab_report/common/domain/repository/lab_report_repository.dart';
import '../../feature/lab_report/common/domain/usecase/bmi_get_usecase.dart';
import '../../feature/lab_report/optometry/data/datasource/optometry_data_source_impl.dart';
import '../../feature/lab_report/optometry/data/repository/optometry_repository_impl.dart';
import '../../feature/lab_report/oximeter/data/datasource/oximeter_data_source.dart';
import '../../feature/lab_report/oximeter/data/datasource/oximeter_data_source_impl.dart';
import '../../feature/lab_report/oximeter/data/repository/oximeter_repository_impl.dart';
import '../../feature/lab_report/oximeter/domain/repository/oximeter_repository.dart';
import '../../feature/lab_report/oximeter/domain/usecase/oximeter_usecase.dart';
import '../../feature/lab_report/oximeter/presentation/cubit/oximeter_cubit.dart';
import '../../feature/lab_report/phlebotomy/data/datasource/phlebotomy_data_source.dart';
import '../../feature/lab_report/phlebotomy/data/datasource/phlebotomy_data_source_impl.dart';
import '../../feature/lab_report/phlebotomy/data/repository/phlebotomy_repository_impl.dart';
import '../../feature/lab_report/phlebotomy/domain/repository/phlebotomy_repository.dart';
import '../../feature/lab_report/phlebotomy/domain/usecase/phlebotomy_usecase.dart';
import '../../feature/lab_report/phlebotomy/presentation/cubit/phlebotomy_cubit.dart';
import '../../feature/lab_report/spirometer/data/datasource/spirometer_data_source_impl.dart';
import '../../feature/lab_report/spirometer/data/repository/spirometer_repository_impl.dart';
import '../../feature/lab_report/spirometer/presentation/cubit/spirometer_cubit.dart';
import '../../feature/lab_report/stethoscope/data/datasource/stethoscope_data_source_impl.dart';
import '../../feature/lab_report/stethoscope/data/repository/stethoscope_repository_impl.dart';
import '../../feature/lab_report/thermometer/data/datasource/thermometer_report_data_source_impl.dart';
import '../../feature/lab_report/thermometer/data/repository/thermometer_report_repository_impl.dart';

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

  sl.registerLazySingleton<LabReportRepository>(
        () => LabRepositoryImpl(labReportDataSource: sl()),
  );

  sl.registerLazySingleton<BmiRepository>(
        () => BmiRepositoryImpl(bmiDataSource: sl()),
  );

  sl.registerLazySingleton<SpirometerRepository>(
        () => SpirometerRepositoryImpl(spirometerDataSource: sl()),
  );

  sl.registerLazySingleton<BloodPressureRepository>(
        () => BloodPressureRepositoryImpl(bloodPressureDataSource: sl()),
  );

  sl.registerLazySingleton<OximeterRepository>(
        () => OximeterRepositoryImpl(oximeterDataSource: sl()),
  );

  sl.registerLazySingleton<ThermometerRepository>(
        () => ThermometerRepositoryImpl(thermoMeterDataSource: sl()),
  );

  sl.registerLazySingleton<StethoscopeRepository>(
        () => StethoscopeRepositoryImpl(stethoscopeDataSource: sl()),
  );

  sl.registerLazySingleton<OptometryRepository>(
        () => OptometryRepositoryImpl(optometryDataSource: sl()),
  );

  sl.registerLazySingleton<HealthCheckRepository>(
        () => HealthCheckRepositoryImpl(healthCheckDataSource: sl()),
  );

  sl.registerLazySingleton<PhlebotomyRepository>(
        () => PhlebotomyRepositoryImpl(phlebotomyDataSource: sl()),
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

  sl.registerLazySingleton<LabReportUseCase>(
        () => LabReportUseCase(repository: sl()),
  );

  sl.registerLazySingleton<PostBmiUseCase>(
        () => PostBmiUseCase(repository: sl()),
  );

  sl.registerLazySingleton<PostSpirometerUseCase>(
        () => PostSpirometerUseCase(repository: sl()),
  );

  sl.registerLazySingleton<BloodPressureUseCase>(
        () => BloodPressureUseCase(repository: sl()),
  );

  sl.registerLazySingleton<OximeterUseCase>(
        () => OximeterUseCase(repository: sl()),
  );

  sl.registerLazySingleton<ThermometerUseCase>(
        () => ThermometerUseCase(repository: sl()),
  );

  sl.registerLazySingleton<StethoscopeUseCase>(
        () => StethoscopeUseCase(repository: sl()),
  );

  sl.registerLazySingleton<OptometryUseCase>(
        () => OptometryUseCase(repository: sl()),
  );

  sl.registerLazySingleton<HealthCheckUseCase>(
        () => HealthCheckUseCase(repository: sl()),
  );

  sl.registerLazySingleton<PhlebotomyUseCase>(
        () => PhlebotomyUseCase(repository: sl()),
  );



  //Register cubit
  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerFactory(() => LoginCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PatientDetailCubit(sl(), sl()));
  sl.registerFactory(() => ScannedPatientListCubit(sl(), sl()));
  sl.registerFactory(() => BmiCubit(saveBmiUseCase: sl(), getBmiUseCase: sl(), storage: sl()));
  sl.registerFactory(() => SpirometerCubit(saveBmiUseCase: sl(), reportUseCase: sl(), storage: sl(),));
  sl.registerFactory(() => BloodPressureCubit(saveBloodPressureUseCase: sl(), reportUseCase: sl(), storage: sl(),));
  sl.registerFactory(() => OximeterCubit(reportUseCase: sl(), storage: sl(), saveOximeterUseCase: sl(),));
  sl.registerFactory(() => ThermometerCubit(saveTemperatureUseCase: sl(), storage: sl()));
  sl.registerFactory(() => StethoscopeCubit(saveBloodPressureUseCase: sl(), reportUseCase: sl(), storage: sl()));
  sl.registerFactory(() => OptometryCubit(saveOptometryUseCase: sl(), reportUseCase: sl(), storage: sl()));
  sl.registerFactory(() => HealthCheckCubit(storage: sl(), reportUseCase: sl()));
  sl.registerFactory(() => PhlebotomyCubit(savePhlebotomyUseCase: sl(), reportUseCase: sl(), storage: sl()));

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

  sl.registerLazySingleton<LabReportDataSource>(
        () => LabReportDataSourceImpl(),
  );

  sl.registerLazySingleton<BmiRemoteDataSource>(
        () => BmiRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<SpirometerDataSource>(
        () => SpirometerDataSourceImpl(),
  );

  sl.registerLazySingleton<BloodPressureDataSource>(
        () => BloodPressureDataSourceImpl(),
  );
  sl.registerLazySingleton<OximeterDataSource>(
        () => OximeterDataSourceImpl(),
  );
  sl.registerLazySingleton<ThermometerReportDataSource>(
        () => ThermometerReportDataSourceImpl(),
  );
  sl.registerLazySingleton<StethoscopeDataSource>(
        () => StethoscopeDataSourceImpl(),
  );
  sl.registerLazySingleton<OptometryDataSource>(
        () => OptometryDataSourceImpl(),
  );

  sl.registerLazySingleton<PhlebotomyDataSource>(
        () => PhlebotomyDataSourceImpl(),
  );

  sl.registerLazySingleton<HealthCheckDataSource>(
        () => HealthCheckDataSourceImpl(),
  );


}
