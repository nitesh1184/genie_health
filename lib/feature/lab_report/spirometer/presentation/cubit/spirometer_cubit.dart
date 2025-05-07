import 'package:bloc/bloc.dart';
import 'package:heath_genie/feature/lab_report/spirometer/presentation/cubit/spirometer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../bmi/domain/usecase/post_emi_usecase.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';




class SpirometerCubit extends Cubit<SpirometerState> {
  final PostBmiUseCase saveBmiUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  SpirometerCubit ({
    required this.saveBmiUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(SpirometerInitial());

  Future<void> saveParameter(Map<String, dynamic> bmiRequestBody) async {
    emit(SpirometerSaving());
    final patientId = storage.getString("uid");
    final result = await saveBmiUseCase(SaveBmiParams(bmiRequestBody: bmiRequestBody, uhid: patientId.toString()));

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(SpirometerSaveFailed(message:failure.message)); // No internet
      } else {
        emit(SpirometerSaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(SpirometerSaveSuccess(data)));
  }

  Future<void> getSpirometerData() async {
    emit(SpirometerLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'SPIROMETER'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(SpirometerLoadFailed(message:failure.message)); // No internet
      } else {
        emit(SpirometerLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(SpirometerLoadSuccess(data)));
  }

}