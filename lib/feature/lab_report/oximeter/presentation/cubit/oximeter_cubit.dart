import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';
import '../../domain/usecase/oximeter_usecase.dart';
import 'oximeter_state.dart';




class OximeterCubit extends Cubit<OximeterState> {
  final OximeterUseCase saveOximeterUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  OximeterCubit ({
    required this.saveOximeterUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(OximeterInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(OximeterSaving());
    final patientId = storage.getString("uid");
    final result = await saveOximeterUseCase(SaveParams(requestBody: requestBody, uhid: patientId.toString()));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(OximeterSaveFailed(message:failure.message)); // No internet
      } else {
        emit(OximeterSaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(OximeterSaveSuccess(data)));
  }

  Future<void> getOximeterData() async {
    emit(OximeterLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'OXIMETER'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(OximeterLoadFailed(message:failure.message)); // No internet
      } else {
        emit(OximeterLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(OximeterLoadSuccess(data)));
  }

}