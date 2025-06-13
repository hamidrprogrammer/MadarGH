import 'package:flutter/material.dart';

class MessagingServiceImpl extends MessagingServiceRepository {
  final messageService = GlobalKey<ScaffoldMessengerState>();

  @override
  void showSnackBar(String message, {Duration duration = const Duration(seconds: 1)}) {
    messageService.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'IRANSansXFaNum'),
        ),
        duration: duration, // Use the provided or default duration
      ),
    );
  }
}

abstract class MessagingServiceRepository {
  void showSnackBar(String message, {Duration duration});
}
