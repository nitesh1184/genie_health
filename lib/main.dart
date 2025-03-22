import 'package:flutter/cupertino.dart';
import 'core/Depenency_injections/app_injector.dart';
import 'core/network/dio_helper.dart';
import 'feature/app.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  DioHelper.init();

  runApp(MyApp());
}