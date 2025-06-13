class DiscountCodeBody {
  final String code, amount;

  const DiscountCodeBody({
    required this.amount,
    required this.code,
  });

  Map<String, String> toJson() {
    return {"amount": amount, "code": code};
  }
}
