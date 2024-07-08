import 'package:dawat_dhaba/api_value.dart';
import 'package:dawat_dhaba/screens/auth/otp_page_verification.dart';
import 'package:dawat_dhaba/screens/cart_page.dart';
import 'package:dawat_dhaba/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MobileVerificationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Dio dio = Dio();
    var user = Rxn<User>();
  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> phoneNoVerification({
    required String phone,
  }) async {
        if (user.value != null) {
      Get.off(() => CartPage());
      return;
    }
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {
          // showSnackBar(context, "user successfully verified");
        },
        verificationFailed: (authException) {
          print(authException);
          if (authException.code == 'invalid-phone-number')
            print("invalid phone number, enter again");
          // showSnackBar(context, "invalid phone number, enter again");
          else
            print("User Verification Failed, try again");
          // showSnackBar(context, "User Verification Failed, try again");
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.off(
              () => OtpPage(phoneNo: phone, verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  void verifyOTP(
      {required String verificationId,
      required String otp,
      required String mobileNumber}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(credential);
      // snack bar for succes
      if (await storeVerifiedMobileNumber(mobileNumber)) {
        SharedPreferencesHelper.setcustomerId(customerId: mobileNumber);
        Get.back();
      } else {
        print('Failed to store mobile number');
      }
    } on FirebaseAuthException catch (e) {
      print("invalid otp $e");
      // setOtpProgress = false;
      if (e.code == 'invalid-verification-code') {
        // showSnackBar(context, "invalid verification code, Please try again");
      } else {
        // something went wrong snack bar
        print(e);
      }
    }
  }

  Future<bool> storeVerifiedMobileNumber(String mobileNumber) async {
    try {
      Map<String, dynamic> data = {'pNumber': mobileNumber};
      final response =
          await dio.get(apiValue.userRegisterUrl, queryParameters: data);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error storing mobile number: $e");
      return false;
    }
  }
}
