import 'package:cb_app/locator.dart';
import 'package:cb_app/services/navigation_service.dart';
import 'package:cb_app/ui/view/createpost_view.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../constants/app_routes.dart';

class DynamicLinkService{
  
  final NavigationService _navigationService =  locator<NavigationService>();
  
  Future handleDynamicLink() async{
    //Handle dynamic link progression in background
    final PendingDynamicLinkData  data = await FirebaseDynamicLinks.instance.getInitialLink();
    //Function link
    _handleDynamicLink(data);

    //Handle dynamic link in foreground
    FirebaseDynamicLinks.instance.onLink.listen((data) async {
      _handleDynamicLink(data);
    }, onError: (error){
      print(error);
    });
  }

  void _handleDynamicLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if(deepLink != null){
      print("_handleDeepLink | dynamicLink - $deepLink");
      var  isPost = deepLink.pathSegments.contains('post');
      if(isPost){
        var title =  deepLink.queryParameters['title'];
        if(title != null){
          //Navigate to create post screen
          _navigationService.navigateTo(CreatePostViewRoute,arguments: title);
        }
      }
    }
  }
}