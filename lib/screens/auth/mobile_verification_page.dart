import 'package:dawat_dhaba/controllers/mobile_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({super.key});

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  TextEditingController mobileCntrl = TextEditingController();
  final mobileVerification = Get.put(MobileVerificationController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/dawat_logo.png"), opacity: 0.3),
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Lottie.asset(
                "assets/Animation - 1708607377904.json",
                height: 220,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "Enter Your Mobile Number",
                style: GoogleFonts.nunito(
                    fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const Text(
                "We Will send you a Confirmation code",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextFormField(
                  controller: mobileCntrl,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  cursorColor: Colors.grey.shade600,
                  cursorHeight: 26,
                  decoration: const InputDecoration(
                    hintText: "  Mobile Number",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              GestureDetector(
                onTap: () async {
                  await mobileVerification.phoneNoVerification(
                      phone: mobileCntrl.text.toString());
                },
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            const Offset(0, 3), // Offset in x and y directions
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text("VERIFY",
                          style: GoogleFonts.workSans(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5))),
                ),
              ),
              const Spacer(),
              const Text(
                "By continuing you agree to Dawat Dhaba",
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terms of Use",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " & ",
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        )

        // Stack(
        //   children: [
        //    Positioned(
        //     height: screenHeight,
        //     width: screenWidth,
        //     child: Center(
        //       child: Opacity(
        //         opacity: 0.22,
        //         child: Image.asset("assets/dawat_logo.png",)),
        //     ),),
        //    Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Positioned(
        //           top: screenHeight * 0.06,
        //           child: Lottie.asset(
        //             "assets/Animation - 1708607377904.json",
        //             height: 220,
        //           )),
        //       Positioned(
        //           top: ,
        //           child: Text(
        //             "Enter Your Mobile Number",
        //             style: GoogleFonts.nunito(
        //                 fontSize: 26, fontWeight: FontWeight.w700),
        //           )),
        //       Positioned(
        //           top: screenHeight * 0.387,
        //           child: const Text(
        //             "We Will send you a Confirmation code",
        //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        //           )),
        //       Positioned(
        //           top: screenHeight * 0.46,
        //           right: screenWidth * 0.12,
        //           left: screenWidth * 0.12,
        //           child: TextFormField(
        //             controller: mobileCntrl,
        //             keyboardType: TextInputType.number,
        //             maxLength: 10,
        //             cursorColor: Colors.grey.shade600,
        //             cursorHeight: 26,
        //             decoration: const InputDecoration(
        //               hintText: "  Mobile Number",
        //               hintStyle: TextStyle(fontSize: 16, color: Colors.black),
        //             ),
        //           )),
        //       Positioned(
        //           top: screenHeight * 0.67,
        //           child: GestureDetector(
        //             onTap: () async {
        //               await mobileVerification.phoneNoVerification(
        //                   phone: mobileCntrl.text.toString());
        //             },
        //             child: Container(
        //               height: screenHeight * 0.06,
        //               width: screenWidth * 0.7,
        //               decoration: BoxDecoration(
        //                 color: Colors.orange.shade300,
        //                 borderRadius: BorderRadius.circular(12),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withOpacity(0.3), // Shadow color
        //                     spreadRadius: 2, // Spread radius
        //                     blurRadius: 5, // Blur radius
        //                     offset: const Offset(
        //                         0, 3), // Offset in x and y directions
        //                   ),
        //                 ],
        //               ),
        //               child: Center(
        //                   child: Text("VERIFY",
        //                       style: GoogleFonts.workSans(
        //                           fontSize: 23,
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w600,
        //                           letterSpacing: 1.5))),
        //             ),
        //           )),
        //       Positioned(
        //           bottom: 40,
        //           child: const Text(
        //             "By continuing you agree to Dawat Dhaba",
        //           )),
        //       Positioned(
        //           bottom:26,
        //           child: const Row(
        //             children: [
        //               Text(
        //                 "Terms of Use",
        //                 style: TextStyle(fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 " & ",
        //               ),
        //               Text(
        //                 "Privacy Policy",
        //                 style: TextStyle(fontWeight: FontWeight.bold),
        //               )
        //             ],
        //           )
        //         ),
        //     ],
        //   ),
        //   ]
        // ),

        );
  }
}

//image: AssetImage("assets/dawat_logo.png"), opacity: 0.22),