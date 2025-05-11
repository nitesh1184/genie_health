import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/lab_report/common/domain/entities/lab_report_parameter_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';


import '../../domain/usecase/post_emi_usecase.dart';

part 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  final PostBmiUseCase saveBmiUseCase;
  final LabReportUseCase getBmiUseCase;
  final SharedPreferences storage;    // 👈 Added

  BmiCubit({
    required this.saveBmiUseCase,
    required this.getBmiUseCase,
    required this.storage,
  }) : super(BmiInitial());

  Future<void> saveBmi(Map<String, dynamic> bmiRequestBody) async {
    emit(BmiSaving());
    final patientId = storage.getString("uid");
    final result = await saveBmiUseCase(SaveParams(requestBody: bmiRequestBody, uhid: patientId.toString()));

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(BmiSaveFailed(message:failure.message)); // No internet
      } else {
        emit(BmiSaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(BmiSaveSuccess(data)));
  }

  Future<void> getBmi() async {
    emit(BmiLoading());
    final patientId = storage.getString("uid");
    final result = await getBmiUseCase(LabReportParams(uhid: patientId.toString(), group:'BMI'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(BmiLoadFailed(message:failure.message)); // No internet
      } else {
        emit(BmiLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(BmiLoadSuccess(data)));
  }

}