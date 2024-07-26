import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/controllers/payment_controller.dart';
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
  final PaymentController paymentController = Get.put(PaymentController());

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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.035,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                bottom: screenHeight * 0.27),
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
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.orange.shade600,
                      ));
                    }
                    if (cartItemCntrl.fetchCartItemList.isEmpty) {
                      return const Center(child: Text('Cart is empty now'));
                    }
                    return ListView.builder(
                      itemCount: cartItemCntrl.fetchCartItemList.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItemCntrl.fetchCartItemList[index];
                        final item_Id = cartItemCntrl.fetchCartItemList[index]['_id'];
                        return Container(
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.9,
                          margin: EdgeInsets.only(top: screenHeight * 0.026),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey.shade400.withOpacity(0.2)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 6.0, right: 6.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                          child: Image.network(
                                        cartItem["Image_Url"],
                                        width: screenWidth * 0.15,
                                        height: screenHeight * 0.07,
                                        fit: BoxFit.cover,
                                      )),
                                      //Spacer(),
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartItem["itemName"],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                                "Category: ${cartItem["category"]}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            SizedBox(
                                              height: screenHeight * 0.005,
                                            ),
                                            Obx(()=>Text(" ₹ ${cartItemCntrl.itemPrices[index].toString()}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15))
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5,),
                                         Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () async{
                                             await cartItemCntrl.deleteItemCart(item_Id,index);
                                            },
                                            child: Icon(Icons.cancel,color:Colors.grey.shade500,))),
                                          SizedBox(height: screenHeight*0.02,),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                cartItemCntrl
                                                    .decrementQuantity(index);
                                              },
                                              child: Container(
                                                height: screenHeight * 0.03,
                                                width: screenWidth * 0.07,
                                                decoration: BoxDecoration(
                                                color: Colors.orange.shade100,
                                                borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: const Center(child: Icon(Icons.remove,color: Colors.white,)),
                                              ),
                                            ),
                                            Obx(() => Text(
                                                  cartItemCntrl
                                                      .itemQuantities[index]
                                                      .toString(),
                                                  style: const TextStyle(fontSize: 14),
                                                )),
                                            InkWell(
                                              onTap: () {
                                                 cartItemCntrl.incrementQuantity(index);
                                              },
                                              child: Container(
                                                height: screenHeight * 0.03,
                                                width: screenWidth * 0.07,
                                                decoration: BoxDecoration(
                                                color: Colors.orange.shade400,
                                                borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: const Center(child: Icon(Icons.add,color: Colors.white,)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.25,
              width: screenWidth*0.9,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
              color: Colors.orange.shade600,
              borderRadius: BorderRadius.circular(18)

              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Obx(() => Text(
                                  '₹ ${cartItemCntrl.totalPrice.value}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GST',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              '₹ 5', 
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              '₹ 10', 
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Obx(() => Text(
                                  '₹ ${(cartItemCntrl.totalPrice.value + 5 - 10).toString()}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.65,
                    child: ElevatedButton(
                      onPressed: () {
                        cartItemCntrl.updateTotalPrice();
                        paymentController.makePayment(cartItemCntrl.totalPrice.value);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Place my order',
                        style: TextStyle(fontSize: 16,color: Colors.orange.shade800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
