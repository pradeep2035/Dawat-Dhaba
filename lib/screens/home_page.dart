import 'package:carousel_slider/carousel_slider.dart';
import 'package:dawat_dhaba/components/banner_list.dart';
import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/screens/menu/item_detailed_page.dart';
import 'package:dawat_dhaba/screens/menu/menu_items_page.dart';
import 'package:dawat_dhaba/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController bannerCntrl = CarouselController();
  int currentindex = 0;
  List todaySpecial = [];
  List categoryList = [];
  final MenuDataController menuCntrl = Get.put(MenuDataController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryListData();
    fetchTodaySpecial();
  }

  fetchTodaySpecial() async {
    todaySpecial = await menuCntrl.fetchSpecialMenu();
    //print(todaySpecial.length);
    setState(() {});
  }

  fetchCategoryListData() async {
    categoryList = await menuCntrl.fetchCategoryList();
    //print(categoryList.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: screenHeight,
          width: screenWidth,
          //decoration: BoxDecoration(),
          child: todaySpecial.isEmpty && categoryList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange.shade600,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.018,
                      ),
                      Row(
                        children: [
                          //Image.asset("assets/dawat_logo.png",scale: screenHeight*0.0078,),
                          Text(
                            "Hello, Foodie!",
                            style: GoogleFonts.workSans(
                                fontSize: 23, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Image.asset(
                                "assets/notification.png",
                                color: const Color.fromARGB(255, 234, 163, 71),
                                height: 21.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Row(
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
                                onTap: () {
                                  Get.to(() => const SearchPage());
                                },
                                textCapitalization: TextCapitalization.words,
                                showCursor: false,
                                decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0),
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
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      CarouselSlider(
                        items: bannerimageList
                            .map((item) => Image.asset(
                                  item["image_path"],
                                  fit: BoxFit.fitWidth,
                                ))
                            .toList(),
                        carouselController: bannerCntrl,
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          aspectRatio: 2,
                          scrollPhysics: const BouncingScrollPhysics(),
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentindex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      const Row(
                        children: [
                          Text(
                            "What's on your mind?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 234, 163, 71)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      SizedBox(
                        height: screenHeight * 0.16,
                        width: screenWidth,
                        child: ListView.builder(
                            itemCount: categoryList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final categoryName =
                                  categoryList[index]["category"];
                              final categoryId = categoryList[index]["_id"];

                              return InkWell(
                                onTap: () {
                                  Get.to(() => MenuItemPage(
                                      categoryName: categoryName,
                                      categoryId: categoryId));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: screenHeight * 0.1,
                                        width: screenWidth * 0.25,
                                        //padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          //borderRadius: BorderRadius.circular(10),
                                          //color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orange.withOpacity(
                                                  0.2), // Light orange color with opacity
                                              spreadRadius: 6, // Spread radius
                                              blurRadius: 10, // Blur radius
                                              offset: const Offset(6,
                                                  3), // Offset in the x, y direction
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            categoryList[index]
                                                ["category_Image_url"],
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        categoryList[index]["category"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange.shade600,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Today's special",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text("See all",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 234, 163, 71)))
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          //scrollDirection: Axis.vertical,
                          itemCount: todaySpecial.length,
                          itemBuilder: (context, index) {
                            final item = todaySpecial[index];
                            final itemImage = item["Image_url"];
                            final String itemName = item["itemName"];
                            final String itemPrice = item["price"].toString();
                            final String itemCategory = item["category"];
                            final String itemRating = item["rating"].toString();
                            final String itemDescription = item["description"];
                            final String itemId = item["_id"];
                            return InkWell(
                              onTap: () {
                                Get.to(() => ItemDetailPage(
                                      itemImage: itemImage,
                                      itemName: itemName,
                                      itemPrice: itemPrice,
                                      itemCategory: itemCategory,
                                      itemRating: itemRating,
                                      itemDescription: itemDescription,
                                      itemId: itemId,
                                    ));
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
                                          offset: const Offset(0,
                                              3), // Offset in the x, y direction
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, right: 6.0),
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
                                                  todaySpecial[index]
                                                      ["Image_url"],
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        todaySpecial[index]
                                                            ["itemName"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18.4,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.005,
                                                      ),
                                                      Text(
                                                          "Qty : ${todaySpecial[index]["quantity"]} | ${todaySpecial[index]["category"]} ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.005,
                                                      ),
                                                      Row(
                                                        children: [
                                                          for (int i = 0;
                                                              i <=
                                                                  todaySpecial[
                                                                          index]
                                                                      [
                                                                      "rating"];
                                                              i++)
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .yellow
                                                                  .shade700,
                                                              size: 14,
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.005,
                                                      ),
                                                      Text(
                                                          " ₹ ${todaySpecial[index]["price"].toString()}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15)),
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
                                              backgroundColor: Color.fromARGB(
                                                  255, 249, 231, 204),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color.fromARGB(
                                                    255, 234, 163, 71),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          })
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
//