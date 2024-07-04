import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/screens/menu/item_detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const MenuItemPage({super.key, required this.categoryName, required this.categoryId});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  List menuList=[];
    final MenuDataController menuCntrl = Get.put(MenuDataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMenuList();
  }

  fetchMenuList()async{
   menuList=await menuCntrl.fetchingMenuInfo(widget.categoryId.toString()); 
   setState(() {
   });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image:DecorationImage(image: AssetImage("assets/bg.webp"),fit: BoxFit.fitWidth,alignment: Alignment.topCenter,opacity: 0.5) 
        ),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight*0.013,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                onPressed: (){
                  Get.back();
                }, 
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                const Spacer(),
               Text(widget.categoryName,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 234, 163, 71),letterSpacing: 1)),
               const Spacer(),
               SizedBox(width: screenWidth*0.08,)
              ],
            ),
            SizedBox(
              height: screenHeight*0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                    children: [
                      Container(
                        height: screenHeight * 0.047,
                        width: screenWidth * 0.77,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            showCursor: false,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                              prefixIcon: const Icon(Icons.search_rounded),
                              iconColor: Colors.grey.shade600,
                              //helperText: "Search"
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: screenHeight * 0.047,
                        width: screenWidth * 0.11,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 231, 204),
                            borderRadius: BorderRadius.circular(14)),
                        child: const Icon(
                          Icons.filter_list_rounded,
                          color: Color.fromARGB(255, 234, 163, 71),
                          size: 25,
                        ),
                      )
                    ],
                  ),
            ),
            SizedBox(
              height: screenHeight*0.06,
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))
              ),
              child: ListView.builder(
                 shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              itemCount: menuList.length,
              itemBuilder:(context, index){
              final itemImage=menuList[index]["Image_url"];
              final String itemName=menuList[index]["itemName"];
              final String itemPrice=menuList[index]["price"].toString();
              final String itemCategory=menuList[index]["category"];
              final String itemRating=menuList[index]["rating"].toString();
              final String itemDescription=menuList[index]["description"];
              final String itemId=menuList[index]["_id"];

               return InkWell(
                onTap: () {
                  Get.to(()=>ItemDetailPage(itemImage:itemImage,itemName:itemName,itemPrice:itemPrice,itemCategory:itemCategory,itemRating:itemRating,itemDescription:itemDescription,itemId:itemId));
                },
                 child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                              height: screenHeight * 0.14,
                              width: screenWidth * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.2), // Light orange color with opacity
                                    spreadRadius: 3, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: const Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6.0, right: 6.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                      ClipOval(
                                          child: Image.network(
                                        menuList[index]["Image_url"],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )),
                                      //Spacer(),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              menuList[index]["itemName"],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.4,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.005,
                                            ),
                                            Text(
                                                "Category: ${menuList[index]["category"]} ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            SizedBox(
                                              height: screenHeight * 0.005,
                                            ),
                                            Row(
                                              children: [
                                                for (int i = 0;
                                                    i <=
                                                        menuList[index]
                                                            ["rating"];
                                                    i++)
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow.shade700,
                                                    size: 14,
                                                  ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.005,
                                            ),
                                            Text(
                                                " ₹ ${menuList[index]["price"].toString()}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            Color.fromARGB(255, 249, 231, 204),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color:
                                              Color.fromARGB(255, 234, 163, 71),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
               );
              } ),
            ),
          ],
        )
      ),
    );
  }
}
