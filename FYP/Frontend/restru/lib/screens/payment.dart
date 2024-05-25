import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = '/payment-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            payWithKhalti(context);
          },
          child: Text('Pay with Khalti'),
        ),
      ),
    );
  }

  void payWithKhalti(BuildContext context) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, // Amount in paisa
        productIdentity: 'product_id',
        productName: 'Product Name',
      ),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.eBanking,
        PaymentPreference.mobileBanking,
        PaymentPreference.connectIPS,
        PaymentPreference.sct,
      ],
      onSuccess: (success) {
        // Handle success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Successful!')),
        );
      },
      onFailure: (failure) {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Failed!')),
        );
      },
      onCancel: () {
        // Handle cancellation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Cancelled!')),
        );
      },
    );
  }
}
