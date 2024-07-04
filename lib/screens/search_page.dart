import 'package:dawat_dhaba/controllers/menu_controller.dart';
import 'package:dawat_dhaba/screens/menu/item_detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final MenuDataController searchMenuCntrl = Get.put(MenuDataController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Container(
            height: screenHeight * 0.047,
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  searchMenuCntrl.searchMenuItem(query.toString());
                },
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
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (searchMenuCntrl.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Colors.orange.shade600,));
              }
              if (searchMenuCntrl.searchResults.isEmpty) {
                return const Center(child: Text('Search Your Food...'));
              }
              return ListView.builder(
                itemCount: searchMenuCntrl.searchResults.length,
                itemBuilder: (context, index) {
                  final item = searchMenuCntrl.searchResults[index];
                  final itemImage=item["Image_url"];
                  final String itemName=item["itemName"];
                  final String itemPrice=item["price"].toString();
                  final String itemCategory=item["category"];
                  final String itemRating=item["rating"].toString();
                  final String itemDescription=item["description"];
                  final String itemId=item["_id"];
                  return InkWell(
                    onTap: () {
                  Get.to(()=>ItemDetailPage(itemImage:itemImage,itemName:itemName,itemPrice:itemPrice,itemCategory:itemCategory,itemRating:itemRating,itemDescription:itemDescription, itemId: itemId,));
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
                                          item["Image_url"],
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
                                                item["itemName"],
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
                                                  "Category: ${item["category"]} ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              SizedBox(
                                                height: screenHeight * 0.005,
                                              ),
                                              Text(
                                                  " ₹ ${item["price"].toString()}",
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
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
