import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtGenerator {
  static const privateKey = 'nGq308R-7DN4ZZetsXEhE6qEn1wgU3Ddscpid94Y3gE';

  Future<String> generateToken({required String pId, required int price}) {
    final jwt = JWT(
      {
        'price': price,
        'package_name': 'ir.mamakschool.mamak',
        'exp': DateTime.now()
            .add(const Duration(minutes: 1))
            .toUtc()
            .millisecondsSinceEpoch,
        'sku':pId
      },
    );
    var token = jwt.sign(SecretKey(privateKey));

    return Future.value(token);
  }
}
