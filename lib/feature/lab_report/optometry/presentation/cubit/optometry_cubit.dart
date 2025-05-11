
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';
import '../../domain/usecase/optometry_usecase.dart';
import 'optometry_state.dart';

class OptometryCubit extends Cubit<OptometryState> {
  final OptometryUseCase saveOptometryUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  OptometryCubit ({
    required this.saveOptometryUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(OptometryInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(OptometrySaving());
    final patientId = storage.getString("uid");
    final result = await saveOptometryUseCase(SaveParams(requestBody: requestBody, uhid: patientId.toString()));

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(OptometrySaveFailed(message:failure.message)); // No internet
      } else {
        emit(OptometrySaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(OptometrySaveSuccess(data)));
  }

  Future<void> getOptometryData() async {
    emit(OptometryLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'OPTOMETRY'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(OptometryLoadFailed(message:failure.message)); // No internet
      } else {
        emit(OptometryLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(OptometryLoadSuccess(data)));
  }

}