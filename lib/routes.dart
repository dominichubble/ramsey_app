import 'package:ramsey_app/screens/commissioners/commissioners_screen.dart';
import 'package:ramsey_app/screens/events/events_screen.dart';
import 'package:ramsey_app/screens/restaurants/restaurants_screen.dart';
import 'package:ramsey_app/screens/home/home_screen.dart';
import 'package:ramsey_app/screens/news/news_screen.dart';
import 'package:ramsey_app/widgets/common/main_navigation.dart';

class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String news = '/news';
  static const String events = '/events';
  static const String eventDetails = '/event-details';
  static const String foodDrink = '/food-drink';
  static const String commissioners = '/commissioners';

  static final routes = {
    main: (context) => const MainNavigation(),
    home: (context) => const HomeScreen(),
    news: (context) => const NewsScreen(),
    events: (context) => const EventsScreen(),
    foodDrink: (context) => const RestaurantsScreen(),
    commissioners: (context) => const CommissionersScreen(),
  };
}
