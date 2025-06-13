export 'unsupported_adapter.dart'
if (dart.library.html) 'package:core/dioNetwork/kanoonHttp/web_adapter.dart'
if (dart.library.io) 'package:core/dioNetwork/kanoonHttp/mobile_adapter.dart';
