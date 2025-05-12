import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/lab_report/phlebotomy/presentation/cubit/phlebotomy_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';
import '../../domain/usecase/phlebotomy_usecase.dart';


class PhlebotomyCubit extends Cubit<PhlebotomyState> {
  final PhlebotomyUseCase savePhlebotomyUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  PhlebotomyCubit ({
    required this.savePhlebotomyUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(PhlebotomyInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(PhlebotomySaving());
    final patientId = storage.getString("uid");
    final result = await savePhlebotomyUseCase(SaveParams(requestBody: requestBody, uhid: patientId.toString()));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(PhlebotomySaveFailed(message:failure.message)); // No internet
      } else {
        emit(PhlebotomySaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(PhlebotomySaveSuccess(data)));
  }

  Future<void> getPhlebotomyData() async {
    emit(PhlebotomyLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'PHLEBOTOMY'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(PhlebotomyLoadFailed(message:failure.message)); // No internet
      } else {
        emit(PhlebotomyLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(PhlebotomyLoadSuccess(data)));
  }

  void toggleCheckBox(bool value) {
    emit(CheckBoxValueChanged(isChecked: value));
  }

}