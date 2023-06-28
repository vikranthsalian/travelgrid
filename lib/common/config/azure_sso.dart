import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:travelgrid/common/config/navigator_key.dart';

class AzureSSO{
  static final Config config = new Config(
    tenant: "06643ed2-3004-4e12-9001-7193b2f0442a",
    clientId: "a406aa00-7aa7-410f-8b9d-6d6c0892beb9",
    prompt: "login",
   // clientSecret: "Uq48Q~s3rTjTRT1Bm_pKRXY3rrl.MyExmIjW3bCl",
    // redirectUri is Optional as a default is calculated based on app type/web location
   // redirectUri: "https://login.live.com/oauth20_desktop.srf",
    scope: "openid profile offline_access User.read",
    redirectUri: "msauth.cm.travelgrid.nh://auth",
   // https://travelgrid.channelmentor.org:8090/login
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