class ApiValue{
  static List url=["production url","https://resturent-backend-api.onrender.com/dawat/"];
  static int isBeta =1;
  //========================================================Authentication
  String userRegisterUrl ='${url[isBeta]}user';
  //========================================================Food Menu
  String specialMenuUrl='${url[isBeta]}TodaysSpecialMenu';
  String menuListUrl ='${url[isBeta]}menu/itemByCategory';
  //========================================================Category List
  String categoryListUrl='${url[isBeta]}menu/ByCategory';
  //========================================================search api
  String menuItemSearch='${url[isBeta]}menu/search';
  //========================================================Food cart
  String addToCart='${url[isBeta]}customer/addItem';
  String fetchCartItem='${url[isBeta]}customer/cart';
  String updateQuntityCartItem='${url[isBeta]}customer/quantityChangeInCart';
  String removeCartItem='${url[isBeta]}customer/removeItem';

}
ApiValue apiValue = ApiValue();
