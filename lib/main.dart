import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitshopweb/ui/auth/login_screen.dart';
import 'package:fruitshopweb/ui/auth/register_screen.dart';
import 'package:fruitshopweb/ui/home/base_home_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/color_const.dart';

Future<void> main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Fruit Shop',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: AppState(),
    );
  }
}

class AppState extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  _AppStateState createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Fruit Shop',
      navigatorKey: AppState.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
            color: ColorPath.MAIN_COLOR,
            iconTheme: IconThemeData(
              color: ColorPath.DARK_COLOR,
            )),
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        highlightColor: ColorPath.DARK_COLOR,
      ),
      routes: _routes,
      initialRoute: LoginScreen.routeName,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => BaseHomeView(),
        );
      },

    );
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    LoginScreen.routeName: (context) => LoginScreen(),
    RegisterScreen.routeName: (context) => RegisterScreen(),
    BaseHomeView.routeName: (context) => const BaseHomeView(),
  };

}

