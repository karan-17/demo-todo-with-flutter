import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_one/data/model/user_model.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/pages/auth_page/loginPage.dart';
import 'package:easy_one/pages/pages_view/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easyone',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final Future<User> user = ApiService.instance.getUser();
  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: user,
        builder: (context,AsyncSnapshot<User> snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashPage();
          if (snapshot.hasData) {
            return HomePage(
              user: snapshot.data,
            );
          }
          return LoginPage();
        });
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
          ),
        ),
      ),
    );
  }
}
