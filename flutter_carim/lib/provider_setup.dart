import 'package:carimbinho/core/viewmodels/ContactCrud.dart';
import 'package:provider/provider.dart';
import 'package:carimbinho/core/services/authentication_service.dart';

import 'core/models/contact.dart';

List<SingleChildCloneableWidget> providers = [
  ...independetServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independetServices = [
  Provider.value(value: ContactCrud())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<ContactCrud, AuthenticationService>(
    builder: (context, crud, authenticationService) =>
        AuthenticationService(crud: crud),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<Contact>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).contact,
  )
];