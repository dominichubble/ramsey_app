import 'package:ramsey_app/screens/home_screen.dart';

import '../screens/events_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String events = '/events';

  static final routes = {
    home: (context) => const HomeScreen(),
    events: (context) => const EventsScreen(),
  };
}
