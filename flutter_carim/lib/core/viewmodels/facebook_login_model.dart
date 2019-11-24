import 'package:carimbinho/core/services/authentication_service.dart';
import 'base_login.dart';
import 'base_model.dart';

class FacebookLoginModel extends BaseModel implements BaseLogin {
  @override
  Future<bool> login({String contactId}) {
    return null;
  }

  @override
  // TODO: implement authenticationService
  AuthenticationService get authenticationService => null;

  @override
  Future<bool> logoff({String contactId}) {
    // TODO: implement logoff
    return null;
  }
}
