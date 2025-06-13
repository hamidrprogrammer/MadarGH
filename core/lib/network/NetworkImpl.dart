import 'package:http/http.dart' as http;

import 'NetworkRepository.dart';

class NetworkImpl extends NetworkRepository<http.Client> {
  http.Client? client;
  @override
  http.Client getClient() {
    client ??= http.Client();
    return client!;
  }
}
