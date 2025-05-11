import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/usecase/get_health_check_usecase.dart';
import 'health_check_state.dart';

class HealthCheckCubit extends Cubit<HealthCheckState> {
  final HealthCheckUseCase reportUseCase;

  final SharedPreferences storage;    // 👈 Added

  HealthCheckCubit ({
    required this.reportUseCase,
    required this.storage,
  }) : super(HealthCheckInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    // emit(BloodPressureSaving());

  }

  Future<void> getReport() async {
    emit(HealthCheckLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(patientId.toString());
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(HealthCheckLoadFailed(message:failure.message)); // No internet
      } else {
        emit(HealthCheckLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(HealthCheckLoadSuccess(data)));
  }

}