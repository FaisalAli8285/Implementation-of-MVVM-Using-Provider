class RoutesName {
  static const String login = "login_Screen";
  static const String home = "home_Screen";
  static const String signup = "signup_Screen";
  static const String splashscreen = "splash_Screen";
}
// When Navigator.pushNamed is called, it passes the route name "home_Screen" to generateRoute, which then uses 
// the switch case to find the appropriate MaterialPageRoute and navigate to HomeScreen.
// The RouteSettings object indeed contains the route name as a string, which is matched against the predefined
// route names in the RoutesName class. This process ensures that the correct screen is navigated to when 
// Navigator.pushNamed is called.






