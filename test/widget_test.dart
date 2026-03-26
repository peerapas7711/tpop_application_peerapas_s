import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tpop_application_peerapas_s/core/storage/app_storage.dart';
import 'package:tpop_application_peerapas_s/core/storage/tags.dart' as app_tags;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return '.';
          }

          return null;
        });
  });

  test('persists selected locale in storage', () async {
    await AppStorage.instance.init();
    await AppStorage.instance.clear();

    await AppStorage.instance.writeLocale(const Locale('th', 'TH'));

    final storedLocale = AppStorage.instance.readLocale();

    expect(storedLocale, isNotNull);
    expect(storedLocale?.languageCode, 'th');
    expect(storedLocale?.countryCode, 'TH');
    expect(AppStorage.instance.readString(app_tags.Tags.LANG), 'th');
    expect(AppStorage.instance.readString(app_tags.Tags.LOCALELANG), 'th');
    expect(AppStorage.instance.readString(app_tags.Tags.LOCALE), 'th_TH');
    expect(AppStorage.instance.readString(app_tags.Tags.LOCALE_LABEL), 'ไทย');
  });
}
