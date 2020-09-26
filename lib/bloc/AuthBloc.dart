import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutterappdemotask/services/auth_service.dart';

class AuthBloc{
  final authService = AuthService();
  final facebookLogin = FacebookLogin();
  Stream<FirebaseUser> get currentUser => authService.currentUser;
  loginFacebook() async{
    final result = await facebookLogin.logIn(permissions:[FacebookPermission.email,FacebookPermission.publicProfile]);
    print(result.toString());
    switch(result.status){
      case FacebookLoginStatus.Success:
        final FacebookAccessToken fat = result.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: fat.token);
        final res = await authService.signInWithCredential(credential);
        break;
      case FacebookLoginStatus.Cancel:
        print("cancelled");
        break;
      case FacebookLoginStatus.Error:
        print("Error");
        break;
    }
  }

  logout(){
    authService.logout();
  }

}