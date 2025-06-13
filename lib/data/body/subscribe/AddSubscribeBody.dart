import 'package:json_annotation/json_annotation.dart';

part 'AddSubscribeBody.g.dart';

@JsonSerializable(explicitToJson: true)
class AddSubscribeBody {
  final String subscriptionId, discountCode;

  const AddSubscribeBody({
    required this.subscriptionId,
    required this.discountCode,
  });

  AddSubscribeBody fromJson(Map<String, dynamic> json) =>
      _$AddSubscribeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddSubscribeBodyToJson(this);
}
