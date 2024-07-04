import 'package:dawat_dhaba/components/otp_inputfield.dart';
import 'package:dawat_dhaba/controllers/mobile_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';



class OtpPage extends StatefulWidget {
  final String phoneNo;
  final String verificationId;
  const OtpPage({super.key, required this.phoneNo, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();
  TextEditingController ctrl3 = TextEditingController();
  TextEditingController ctrl4 = TextEditingController();
  TextEditingController ctrl5 = TextEditingController();
  TextEditingController ctrl6 = TextEditingController();
  final otpController = Get.put(MobileVerificationController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 60,),
              Container(
                  height: 200,
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/Animation - 1710054196902.json")),
              SizedBox(height: 20),
              Text("Enter OTP", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              Text(
                "An 6 digit code has been sent to\n+91 ${widget.phoneNo}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpInputField(controller: ctrl1),
                  OtpInputField(controller: ctrl2),
                  OtpInputField(controller: ctrl3),
                  OtpInputField(controller: ctrl4),
                  OtpInputField(controller: ctrl5),
                  OtpInputField(controller: ctrl6),
                ],
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () async{
                  String otp = ctrl1.text +
                            ctrl2.text +
                            ctrl3.text +
                            ctrl4.text +
                            ctrl5.text +
                            ctrl6.text;
                        if (otp.length == 6) {
                          otpController.verifyOTP(verificationId: widget.verificationId, otp: otp,mobileNumber:widget.phoneNo);
                        }else{
                         // showSnackBar(context, "please enter OTP");
                        }
                },
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.7,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange.shade300
                  ) ,
                  child: Center(child: Text("SUBMIT",style: GoogleFonts.workSans(fontSize: 23,color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 1.5),))
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}