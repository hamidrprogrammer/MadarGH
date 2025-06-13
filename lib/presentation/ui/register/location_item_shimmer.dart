import 'package:flutter/material.dart';
import 'package:my_ios_app/presentation/ui/main/BaseShimmer.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';

class LocationItemShimmer extends StatelessWidget {
  const LocationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: Container(
      alignment: Alignment.center,
      padding: 24.dpe,
      margin: 8.dpe,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: 8.bRadius,
      ),
    ));
  }
}
