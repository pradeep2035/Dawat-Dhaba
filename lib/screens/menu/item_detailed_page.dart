import 'package:dawat_dhaba/components/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetailPage extends StatefulWidget {
  final itemImage;
  final String itemName;
  final String itemPrice;
  final String itemCategory;
  final String itemRating;
  final String itemDescription; 
  final String itemId; 
  const ItemDetailPage(
      {super.key,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      required this.itemCategory, required this.itemRating, required this.itemDescription, required this.itemId});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.only(left: 16.0, right: 16.0, top: screenHeight*0.035),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Text(
                  "Details",
                  style: GoogleFonts.workSans(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  // height: 10,
                  width: screenWidth * 0.1,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              height: screenHeight * 0.24,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      widget.itemImage,
                    ),
                    fit: BoxFit.cover),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.035,
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.itemName,
                  style: GoogleFonts.workSans(
                      fontSize: 26.8, fontWeight: FontWeight.w700),
                )),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "₹ ${widget.itemPrice}/-",
                style: GoogleFonts.workSans(
                  fontSize: 25.6,
                  color: Colors.orange.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange.shade700),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/food-tray.png",
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3,),
                        //Spacer(),
                        Text(
                          widget.itemCategory,
                          style: GoogleFonts.workSans(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled_rounded,color: Colors.white,size: 22,),
                        //Spacer(),
                        SizedBox(width: 3,),
                        Text(
                          "20-30",
                          style: GoogleFonts.workSans(
                              fontSize: 13,
                              color: Colors.white,
                            fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.white,size: 22,),
                        SizedBox(width: 3,),
                        //Spacer(),
                        Text(
                          widget.itemRating.toString(),
                          style: GoogleFonts.workSans(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: screenHeight*0.05, // Specify the height of the divider
              thickness: 1.5, // Specify the thickness of the divider
              color: Colors.grey.shade400, // Specify the color of the divider
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text("Description",style: GoogleFonts.workSans(fontSize: 20, fontWeight: FontWeight.w600 ),)),
              SizedBox(height: screenHeight*0.01,),
              Text(widget.itemDescription, style: GoogleFonts.workSans(fontSize: 16)),
              SizedBox(height: screenHeight*0.03),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text("Recommended For You",style: GoogleFonts.workSans(fontSize: 20, fontWeight: FontWeight.w600 ),)),
              
          ],
        ),
      ),
     bottomSheet: BottomSheetWidget(itemId: widget.itemId),
    );
  }
}


