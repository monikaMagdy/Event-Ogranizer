import 'package:flutter/material.dart';
import 'package:mobile_project/screens/AddUserScreen.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:mobile_project/screens/Event_overview_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    UserAddNotifer().getUser().listen((user) {
      debugPrint("user: " + user.toString());

      if (user != null && user.uid != null) {
        //go to home page
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ButtonMenu()));
      } else {
        // Go to login page
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SignUpForm()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
