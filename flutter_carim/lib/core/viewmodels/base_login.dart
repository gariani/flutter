import 'package:carimbinho/core/services/authentication_service.dart';

class BaseLogin{

  final AuthenticationService authenticationService;

  BaseLogin(this.authenticationService);

  Future<bool> login({String contactId}) async{}

  Future<bool> logoff({String contactId}) async{print('teste');}

}
