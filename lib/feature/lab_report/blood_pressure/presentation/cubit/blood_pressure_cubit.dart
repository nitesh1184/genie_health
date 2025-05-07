import 'package:bloc/bloc.dart';
import 'package:heath_genie/feature/lab_report/spirometer/presentation/cubit/spirometer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../bmi/domain/usecase/post_emi_usecase.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';
import '../../domain/usecase/blood_pressure_usecase.dart';
import 'blood_pressure_state.dart';




class BloodPressureCubit extends Cubit<BloodPressureState> {
  final BloodPressureUseCase saveBloodPressureUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  BloodPressureCubit ({
    required this.saveBloodPressureUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(BloodPressureInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(BloodPressureSaving());
    final patientId = storage.getString("uid");
    final result = await saveBloodPressureUseCase(SaveParams(requestBody: requestBody, uhid: patientId.toString()));

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(BloodPressureSaveFailed(message:failure.message)); // No internet
      } else {
        emit(BloodPressureSaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(BloodPressureSaveSuccess(data)));
  }

  Future<void> getBloodPressureData() async {
    emit(BloodPressureLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'BLOOD PRESSURE'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(BloodPressureLoadFailed(message:failure.message)); // No internet
      } else {
        emit(BloodPressureLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(BloodPressureLoadSuccess(data)));
  }

}