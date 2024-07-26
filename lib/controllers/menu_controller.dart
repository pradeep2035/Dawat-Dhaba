import 'package:dawat_dhaba/api_value.dart';
import 'package:dawat_dhaba/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MenuDataController extends GetxController {
  Dio dio = Dio();
  var searchResults = [].obs;
  var fetchCartItemList = [].obs;
  var isLoading = false.obs;
  var isLoadingCartItem = false.obs;
  var itemQuantities = <int>[].obs;
  var itemPrices = <int>[].obs;
  var totalPrice = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    // Fetch cart items when the controller initializes
    fetchCartItem();
  }

  fetchSpecialMenu() async {
    try {
      final response = await dio.get(apiValue.specialMenuUrl);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData["status_code"] == 200) {
          List data = responseData['data'];
          return data;
        }
      }
    } catch (e) {
      print("Error fetching special menu: $e");
      return null;
    }
    return null;
  }

//================================================================================CATEGORY LIST
  fetchCategoryList() async {
    try {
      final response = await dio.get(apiValue.categoryListUrl);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData["status_code"] == 200) {
          List data = responseData['data'];
          return data;
        }
      }
    } catch (e) {
      print("Error fetching special menu: $e");
      return null;
    }
    return null;
  }

  //======================================================================Fetching MENU INFO from category
  fetchingMenuInfo(categoryId) async {
    try {
      Map<String, dynamic> data = {'id': categoryId};
      final response =
          await dio.get(apiValue.menuListUrl, queryParameters: data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData["status_code"] == 200) {
          List data = responseData['data'];
          return data;
        }
      }
    } catch (e) {
      print("Error fetching special menu: $e");
      return null;
    }
    return null;
  }

//=========================================================================Search menu item
  Future<void> searchMenuItem(String searchInput) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> data = {"searchItem": searchInput};
      final response =
          await dio.get(apiValue.menuItemSearch, queryParameters: data);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data["status_code"] == 200) {
          List responseData = data['data'];
          searchResults.value = responseData;
        } else {
          searchResults.clear();
        }
      }
    } catch (error) {
      print("Found exception in searching menu :$error");
      searchResults.clear();
    }
    isLoading.value = false;
  }

  //========================================================================= ADD TO CART ITEMS
  addToCartItem(String itemId, int itemQuantity, int price) async {
    try {
      final response = await dio.post(apiValue.addToCart, data: {
        "Customer_id": SharedPreferencesHelper.getcustomerId(),
        "item_Id": itemId,
        "quantity": itemQuantity,
        "price": price
      });
      if (response.statusCode == 200) {
        print("successfully added to cart");
        print(response.data);
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  //==================================================================================Fetch cart item
  Future<void> fetchCartItem() async {
    isLoadingCartItem.value = true;
    try {
      Map<String, dynamic> data = {
        "Customer_id": SharedPreferencesHelper.getcustomerId()
      };
      final response =
          await dio.get(apiValue.fetchCartItem, queryParameters: data);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data["status_code"] == 200) {
          List responseData = data['data'];
          fetchCartItemList.value = responseData;
          itemQuantities.value =
              fetchCartItemList.map((item) => item['quantity'] as int).toList();
          itemPrices.value =
              fetchCartItemList.map((item) => item['price'] as int).toList();
          updateTotalPrice();
          print("CART ITEM FETCHED SUCCESSFULLY");
        } else {
          fetchCartItemList.clear();
          itemQuantities.clear();
          itemPrices.clear();
        }
      }
    } catch (e) {
      print("exception in fetching item : $e");
      throw Exception(e);
    }
    isLoadingCartItem.value = false;
  }

  void incrementQuantity(int index) async {
    if (index >= 0 && index < itemQuantities.length) {
      itemQuantities[index]++;
      updateItemPrice(index);
      updateTotalPrice();
      itemQuantities.refresh();
    } else {
      print("Invalid index for incrementQuantity: $index");
    }
  }

  void decrementQuantity(int index) async {
    if (index >= 0 && index < itemQuantities.length) {
      if (itemQuantities[index] > 1) {
        itemQuantities[index]--;
        updateItemPrice(index);
        updateTotalPrice();
        itemQuantities.refresh();
      }
    } else {
      print("Invalid index for decrementQuantity: $index");
    }
  }

  void updateItemPrice(int index) {
    if (index >= 0 && index < itemQuantities.length) {
      itemPrices[index] =
          fetchCartItemList[index]['price'] * itemQuantities[index];
      itemPrices.refresh();
    }
  }

  void updateTotalPrice() {
    double total = 0.0;
    for (var item in fetchCartItemList) {
      total += item['price'] * item['quantity'];
    }
    totalPrice.value = total;
  }

  deleteItemCart(String itemId, int index) async {
    try {
      final response =
          await dio.delete(apiValue.removeCartItem, data: {"id": itemId});
      if (response.statusCode == 200) {
        print("removed from cart");
        fetchCartItemList.removeAt(index);
        itemQuantities.removeAt(index);
        itemPrices.removeAt(index);
        updateTotalPrice();
      } else {
        print("not removed");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void clearCart() {
    fetchCartItemList.clear();
    itemQuantities.clear();
    itemPrices.clear();
    totalPrice.value = 0.0;
  }
}
