import 'package:ramsey_app/screens/home_screen.dart';
import 'package:ramsey_app/screens/news_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String news = '/news';

  static final routes = {
    home: (context) => const HomeScreen(),
    news: (context) => const NewsScreen(),
  };
}
