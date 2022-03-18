import 'package:cb_app/services/pushnotify_service.dart';

import '../constants/app_routes.dart';
import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/navigation_service.dart';
import 'base_models.dart';

class StartUpViewModel extends BaseModel{

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =  locator<PushNotificationService>();


  Future handleStartupLogic() async{
    await _pushNotificationService.initializeNotification();
    var userLoggedIn = await _authenticationService.isUserLoggedIn();

    if(userLoggedIn){
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}