import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/lab_report/stethoscope/presentation/cubit/stethoscope_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../common/domain/entities/save_report_params.dart';
import '../../../common/domain/usecase/bmi_get_usecase.dart';
import '../../domain/usecase/stethoscope_usecase.dart';


class StethoscopeCubit extends Cubit<StethoscopeState> {
  final StethoscopeUseCase saveBloodPressureUseCase;
  final LabReportUseCase reportUseCase;
  final SharedPreferences storage;    // 👈 Added

  StethoscopeCubit ({
    required this.saveBloodPressureUseCase,
    required this.reportUseCase,
    required this.storage,
  }) : super(StethoscopeInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(StethoscopeSaving());
    final patientId = storage.getString("uid");
    final result = await saveBloodPressureUseCase(SaveParams(requestBody: requestBody, uhid: patientId.toString()));

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(StethoscopeSaveFailed(message:failure.message)); // No internet
      } else {
        emit(StethoscopeSaveFailed(message:failure.message)); // Generic error
      }
    }, (data) => emit(StethoscopeSaveSuccess(data)));
  }

  Future<void> getStethoscopeData() async {
    emit(StethoscopeLoading());
    final patientId = storage.getString("uid");
    final result = await reportUseCase(LabReportParams(uhid: patientId.toString(), group:'STETHOSCOPE'));
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(StethoscopeLoadFailed(message:failure.message)); // No internet
      } else {
        emit(StethoscopeLoadFailed(message:failure.message)); // Generic error
      }
    }, (data) {
      // Assuming checkbox value is in the API data under `isApproved`

      String value='';
      for(var param in data.parameters){
        if(param.name=='Need Follow Up'){
          value= param.value;
        }
      }
      final isChecked= value=='true'?true:false;
      emit(StethoscopeLoadSuccess(data, isChecked: isChecked));
    },
    );
  }


  void toggleCheckbox(bool value) {
    final currentState = state;
    if (currentState is StethoscopeLoadSuccess) {
      emit(StethoscopeLoadSuccess(
        currentState.stethoscopeData,
        isChecked: value,
      ));
    }
  }
  }