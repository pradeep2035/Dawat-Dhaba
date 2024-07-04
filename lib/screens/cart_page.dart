import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}
      
class _CartPageState extends State<CartPage> {
  final MenuDataController cartItemCntrl = Get.put(MenuDataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartItemCntrl.fetchCartItem();
   
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.035,
          left: screenWidth * 0.06,
          right: screenWidth * 0.06),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: screenHeight * 0.09,
                  width: screenWidth * 0.09,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 2.0,
                    ),
                    //borderRadius: BorderRadius.circular(20)
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: screenHeight * 0.03,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Text(
                "Food Cart",
                style: GoogleFonts.workSans(
                    fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (cartItemCntrl.isLoadingCartItem.value) {
                return Center(child: CircularProgressIndicator(color: Colors.orange.shade600,));
              }
              if (cartItemCntrl.fetchCartItemList.isEmpty) {
                return const Center(child: Text('Cart is empty now'));
              }
              return ListView.builder(
                itemCount:cartItemCntrl.fetchCartItemList.length ,
                itemBuilder: (context, index) {
                  final cartItem = cartItemCntrl.fetchCartItemList[index];
                  return Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.only(top:screenHeight*0.026),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade400.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                    child: Image.network(
                                  cartItem["Image_Url"],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )),
                                //Spacer(),
                                 SizedBox(
                                  width: screenWidth*0.03,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem["itemName"],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: screenHeight * 0.005,
                                      // ),
                                      Text("Category: ${cartItem["category"]} ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(
                                        height: screenHeight * 0.005,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     for (int i = 0;
                                      //         i <= cartItem["rating"];
                                      //         i++)
                                      //       Icon(
                                      //         Icons.star,
                                      //         color: Colors.yellow.shade700,
                                      //         size: 14,
                                      //       ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: screenHeight * 0.005,
                                      ),
                                      // Text(" ₹ ${cartItem["price"].toString()}",
                                      //     style: const TextStyle(
                                      //         fontWeight: FontWeight.w500,
                                      //         fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const Expanded(
                          //   flex: 2,
                          //   child: CircleAvatar(
                          //     radius: 18,
                          //     backgroundColor:
                          //         Color.fromARGB(255, 249, 231, 204),
                          //     child: Icon(
                          //       Icons.arrow_forward_ios_rounded,
                          //       color: Color.fromARGB(255, 234, 163, 71),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    ));
  }
}
