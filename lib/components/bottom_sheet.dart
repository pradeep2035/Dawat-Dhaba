import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/controllers/mobile_verification_controller.dart';
import 'package:dawat_dhaba/screens/auth/mobile_verification_page.dart';
import 'package:dawat_dhaba/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatefulWidget {
  final String itemId;
  final String itemPrice;
  

  const BottomSheetWidget({super.key, required this.itemId, required this.itemPrice});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final MobileVerificationController authController = Get.put(MobileVerificationController());
  final MenuDataController addItemCntrl = Get.put(MenuDataController());
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 65,
      width: double.maxFinite,
      color: Colors.white,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _decrementQuantity,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                  child: Icon(Icons.remove),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                '$_quantity', // Quantity value
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: _incrementQuantity,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                  child: Icon(Icons.add),
                ),
              ),
              
            ],
          ),
          // SizedBox(height: 20),
          Spacer(),
          InkWell(
            onTap: ()async{
             if (authController.user.value != null) {
                 await addItemCntrl.addToCartItem(widget.itemId, _quantity,(_quantity*int.parse(widget.itemPrice)));
                  Get.to(() => CartPage()); 
                } else {
                  Get.to(() => MobileVerification()); 
                }
            },
            child: Container(
              height: 50,
              //width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange.shade700),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
