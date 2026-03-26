import 'package:get/get.dart';

import '../../../../core/config/app_environment.dart';
import '../../domain/entities/purchase_history_snapshot.dart';
import '../../domain/usecases/get_purchase_history_usecase.dart';

class PurchaseHistoryController extends GetxController
    with StateMixin<PurchaseHistorySnapshot> {
  PurchaseHistoryController({
    required AppEnvironment environment,
    required GetPurchaseHistoryUseCase getPurchaseHistoryUseCase,
  }) : _environment = environment,
       _getPurchaseHistoryUseCase = getPurchaseHistoryUseCase;

  final AppEnvironment _environment;
  final GetPurchaseHistoryUseCase _getPurchaseHistoryUseCase;

  AppEnvironment get environment => _environment;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory({bool showLoading = true}) async {
    if (showLoading) {
      change(null, status: RxStatus.loading());
    }

    try {
      final history = await _getPurchaseHistoryUseCase.call();
      if (history.isEmpty) {
        change(history, status: RxStatus.empty());
        return;
      }

      change(history, status: RxStatus.success());
    } catch (_) {
      change(null, status: RxStatus.error('subscriptionHistoryErrorTitle'));
    }
  }
}
