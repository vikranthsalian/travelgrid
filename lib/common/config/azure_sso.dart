import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:travelgrid/common/config/navigator_key.dart';

class AzureSSO{
  static final Config config = new Config(
    tenant: "06643ed2-3004-4e12-9001-7193b2f0442a",
    clientId: "6cc2992e-28a2-422b-8cbc-19ef18584b42",
    clientSecret: "FEu7Q~sU.3aD5jRq1cOeWS.geV4GhXZvkjU9h",
    isB2C: false,
    // redirectUri is Optional as a default is calculated based on app type/web location
   // redirectUri: "https://login.live.com/oauth20_desktop.srf",
    scope: "openid profile offline_access User.read",
    redirectUri: "https://travelex.narayanahealth.org:8090/tgmsal-3.0",

    navigatorKey: appNavigatorKey,
    webUseRedirect: false, // default is false - on web only, forces a redirect flow instead of popup auth
    //Optional parameter: Centered CircularProgressIndicator while rendering web page in WebView
    loader: Center(child: CircularProgressIndicator()),
  );
  getConfig(){
    return config;
  }


  // Future<String> signIn(String email, String password) async
  // {
  //   config.loginHint = email;
  //   final AadOAuth oauth = new AadOAuth (config);
  //   await oauth.login();
  //   final accessToken = await oauth.getAccessToken();
  //   final graphResponse = await http.get(
  //     Uri.parse(NetworkConstants.MS_GRAPH_USER_INFO_URL),
  //     headers: {
  //       "Authorization": "Bearer
  //           + "$accessToken",
  //       "Content-Type": "application/json"
  //     },
  //   );
  //   switch (graphResponse.statusCode) {
  //     case HttpStatus.ok:
  //       if (rememberMeIsCheckhed) {}
  //       await LocaleManager.instance
  //           .setStringValue(PreferencesKeys.ACCESSTOKEN, accessToken!);
  //       await NavigationService.instance
  //           .navigateToPageClear(NavigationConstants.HOME_VIEW);
  //   }
  // }

}