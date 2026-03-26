import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tpop_application_peerapas_s/app/app.dart';
import 'package:tpop_application_peerapas_s/core/config/app_environment.dart';

void main() {
  testWidgets('renders purchase package flow', (tester) async {
    Get.testMode = true;

    await tester.pumpWidget(
      SubscriptionApp(environment: AppEnvironment.staging()),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Choose your subscription'), findsOneWidget);
    expect(find.text('Pink Plus'), findsWidgets);
    expect(find.text('Stage Pass'), findsOneWidget);
  });
}
