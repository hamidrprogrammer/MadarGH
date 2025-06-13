class InAppPurchaseInfo {
  final String productId, packageName;
  final InAppPurchaseState state;

  const InAppPurchaseInfo({
    required this.productId,
    required this.packageName,
    required this.state,
  });
}

enum InAppPurchaseState {
  success,
  refund;
}
