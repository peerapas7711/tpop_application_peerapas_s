import 'package:flutter/widgets.dart';

import '../core/config/app_environment.dart';
import 'app.dart';

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SubscriptionApp(environment: environment));
}
