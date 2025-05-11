import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/lab_report/thermometer/presentation/cubit/thermometer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/usecase/thermometer_usecase.dart';

class ThermometerCubit extends Cubit<ThermometerState> {
  final ThermometerUseCase saveTemperatureUseCase;
  final SharedPreferences storage;

  ThermometerCubit({
    required this.saveTemperatureUseCase,
    required this.storage,
  }) : super(ThermometerInitial());

  Future<void> saveParameter(Map<String, dynamic> requestBody) async {
    emit(ThermometerSaving());
    final patientId = storage.getString("uid");
    final result = await saveTemperatureUseCase.saveThermometerReport(
      SaveParams(requestBody: requestBody, uhid: patientId.toString()),
    );

    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(ThermometerSaveFailed(message: failure.message)); // No internet
      } else {
        emit(ThermometerSaveFailed(message: failure.message)); // Generic error
      }
    }, (data) => emit(ThermometerSaveSuccess(data)));
  }

  Future<void> getThermometerReport() async {
    emit(ThermometerLoading());
    final patientId = storage.getString("uid");
    final result = await saveTemperatureUseCase(
      ThermoMeterParams(uhid: patientId.toString(), group: 'THERMOMETER'),
    );
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(ThermometerLoadFailed(message: failure.message)); // No internet
      } else {
        emit(ThermometerLoadFailed(message: failure.message)); // Generic error
      }
    }, (data) => emit(ThermometerLoadSuccess(data)));
  }

  void toggleUnit() {
    if (state is ThermometerUnitChanged) {
      final currentUnit = (state as ThermometerUnitChanged).isCelsius;
      emit(ThermometerUnitChanged(isCelsius: !currentUnit));
    }
  }

  void setInitialUnit(bool isCelsius) {
    emit(ThermometerUnitChanged(isCelsius: isCelsius));
  }
}
