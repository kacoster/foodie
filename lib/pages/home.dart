import 'package:foodie/theme/color.dart';
import 'package:foodie/utils/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodie/models/dish_model.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/widgets/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIService client = APIService();
  DishDataModel? data;
  List<DishDataModel> allDishList = [];
  List<DishDataModel> filteredDishList = [];
  bool allSelect = true,
      pizzaSelect = false,
      saladSelect = false,
      burgerSelect = false,
      drinkSelect = false,
      snackSelect = false;
  String filterCat = "All";

  @override
  void initState() {
    super.initState();
    getDishesData();
    filteredDishList = allDishList;
    filterCategories(allDishList, globals.category);
  }

  Future<void> getDishesData() async {
    Map<String, dynamic> resp =
        await client.get(endpoint: '/dishes', query: {});

    resp['data'].forEach((obj) => allDishList.add(DishDataModel.fromJson(obj)));

    setState(() {
      allDishList = allDishList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.clear_all_rounded,
                      size: 28,
                    ))),
          ],
        ),
      ),
      body: getBody(),
    );
  }

  filterCategories(List<DishDataModel> data, String categoryTag) {
    List<DishDataModel> lst = [];

    if (categoryTag == "All") {
      lst = data;
    } else {
      lst = data.where((i) => i.category == categoryTag).toList();
    }

    return (lst);
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Leeker Foodie!",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Find Your Meals",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: 5, left: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        allSelect = true;
                        filterCat = "All";
                        pizzaSelect = saladSelect =
                            drinkSelect = burgerSelect = snackSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: allSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.th,
                              size: 17,
                              color: allSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "All",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: allSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pizzaSelect = true;
                        filterCat = "Pizza";
                        allSelect = saladSelect =
                            burgerSelect = drinkSelect = snackSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: pizzaSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.pizzaSlice,
                              size: 12,
                              color: pizzaSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Pizza",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: pizzaSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        saladSelect = true;
                        filterCat = "Salad";
                        allSelect = pizzaSelect =
                            burgerSelect = drinkSelect = snackSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: saladSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.cloudMeatball,
                              size: 17,
                              color: saladSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Salad",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: saladSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        burgerSelect = true;
                        filterCat = "Burger";
                        allSelect = pizzaSelect =
                            saladSelect = drinkSelect = snackSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: burgerSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.hamburger,
                              size: 17,
                              color: burgerSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Burger",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: burgerSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        drinkSelect = true;
                        filterCat = "Drink";
                        allSelect = pizzaSelect =
                            saladSelect = burgerSelect = snackSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: drinkSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.wineBottle,
                              size: 17,
                              color: drinkSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Drink",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: drinkSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        snackSelect = true;
                        filterCat = "Snack";
                        allSelect =
                            pizzaSelect = saladSelect = drinkSelect = false;
                        filteredDishList =
                            filterCategories(allDishList, filterCat);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: snackSelect ? primary : cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.cookie,
                              size: 17,
                              color: snackSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Snack",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: snackSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: listFeatured(),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  listFeatured() {
    return Column(
      children: List.generate(filteredDishList.length,
          (index) => MenuItem(data: filteredDishList[index])),
    );
  }
}
