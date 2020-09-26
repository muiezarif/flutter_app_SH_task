import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutterappdemotask/screens/ProfileScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutterappdemotask/bloc/AuthBloc.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context,listen:false);
    authBloc.currentUser.listen((user) {
      if(user != null){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>ProfileScreen()),
        );
      }
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Demo Task"),
        backgroundColor: Colors.blueAccent,

      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.FacebookNew,
              text: "Sign In With Facebook",
              onPressed: (){authBloc.loginFacebook();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>ProfileScreen()),
              );
          },
            ),
          ],
        ),
      ),
    );
  }
}
