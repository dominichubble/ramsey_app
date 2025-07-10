import 'package:ramsey_app/screens/home_screen.dart';
import 'package:ramsey_app/screens/news_screen.dart';
import 'package:ramsey_app/screens/events_screen.dart';
import 'package:ramsey_app/screens/food_drink_screen.dart';
import 'package:ramsey_app/screens/commissioners_screen.dart';
import 'package:ramsey_app/widgets/main_navigation.dart';

class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String news = '/news';
  static const String events = '/events';
  static const String foodDrink = '/food-drink';
  static const String commissioners = '/commissioners';

  static final routes = {
    main: (context) => const MainNavigation(),
    home: (context) => const HomeScreen(),
    news: (context) => const NewsScreen(),
    events: (context) => const EventsScreen(),
    foodDrink: (context) => const FoodDrinkScreen(),
    commissioners: (context) => const CommissionersScreen(),
  };
}
