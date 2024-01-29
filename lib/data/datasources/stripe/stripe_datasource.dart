import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:projecttas_223200007/shared/constants/app_constants.dart';

class StripeDatasource {
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      final formattedAmount = (int.parse(amount) * 100).toString();
      Map<String, dynamic> body = {
        'amount': formattedAmount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      log('err charging user: ${err.toString()}');
      return {
        'error': err.toString(),
      };
    }
  }

  String _calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount));
    return calculatedAmount.toString();
  }
}
