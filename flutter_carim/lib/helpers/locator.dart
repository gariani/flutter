import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:carimbinho/core/viewmodels/ContactCrud.dart';
import 'package:carimbinho/core/viewmodels/email_login_model.dart';
import 'package:carimbinho/core/viewmodels/facebook_login_model.dart';
import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:get_it/get_it.dart';
import '../core/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => Api('contacts'));
  locator.registerLazySingleton(() => ContactCrud());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Contact());

  locator.registerFactory(() => EmailLoginModel());
  locator.registerFactory(() => GoogleLoginModel());
  locator.registerFactory(() => FacebookLoginModel());
}