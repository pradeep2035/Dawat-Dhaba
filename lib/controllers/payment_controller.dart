import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../shared_pref.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  var isSuccess = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    isSuccess.value = true;
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
        Get.off(()=>const HomePage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    isSuccess.value = false;
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  Future<void> makePayment(double amount) async {
    var options = {
      "key": "rzp_test_FVTkDb9WMnoSx3",
      "amount": (amount * 100).toInt(),
      "name": "Dawat Dhaba",
      "description": "Food order",
      "prefill": {
        "contact": SharedPreferencesHelper.getcustomerId().toString(),
        "email": "pradeeprout899@gmail.com"
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      isSuccess.value = false;
      debugPrint(e.toString());
    }
  }
}
