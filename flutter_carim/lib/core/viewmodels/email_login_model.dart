import 'package:carimbinho/core/enum/viewstate.dart';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:carimbinho/core/viewmodels/base_model.dart';
import 'base_login.dart';

class EmailLoginModel extends BaseModel implements BaseLogin {

  String errorMessage;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Future<bool> login({String contactId}) async {
    setState(ViewState.Busy);

    if(contactId.isEmpty){
      errorMessage = 'Email não informado';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.getContactById(contactId);
    setState(ViewState.Idle);
    return success;
  }

  @override
  Future<bool> logoff({String contactId}) {
    // TODO: implement logoff
    return null;
  }

  @override
  // TODO: implement authenticationService
  AuthenticationService get authenticationService => _authenticationService;

}