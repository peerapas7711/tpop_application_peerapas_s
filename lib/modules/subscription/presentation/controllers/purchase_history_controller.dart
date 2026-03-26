import 'package:get/get.dart';

import '../../domain/entities/purchase_history_snapshot.dart';
import '../../domain/usecases/get_purchase_history_usecase.dart';

class PurchaseHistoryController extends GetxController
    with StateMixin<PurchaseHistorySnapshot> {
  PurchaseHistoryController({
    required GetPurchaseHistoryUseCase getPurchaseHistoryUseCase,
  }) : _getPurchaseHistoryUseCase = getPurchaseHistoryUseCase;

  final GetPurchaseHistoryUseCase _getPurchaseHistoryUseCase;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory({bool showLoading = true}) async {
    if (showLoading) {
      change(GetStatus<PurchaseHistorySnapshot>.loading());
    }

    try {
      final history = await _getPurchaseHistoryUseCase.call();
      if (history.isEmpty) {
        change(GetStatus<PurchaseHistorySnapshot>.empty());
        return;
      }

      change(GetStatus<PurchaseHistorySnapshot>.success(history));
    } catch (_) {
      change(
        GetStatus<PurchaseHistorySnapshot>.error(
          'subscriptionHistoryErrorTitle',
        ),
      );
    }
  }
}
