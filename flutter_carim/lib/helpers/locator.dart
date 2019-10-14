import 'package:carimbinho/core/viewmodels/CRUDModel.dart';
import 'package:get_it/get_it.dart';
import '../core/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => Api('contacts'));
  locator.registerLazySingleton(() => CRUDModel());
}