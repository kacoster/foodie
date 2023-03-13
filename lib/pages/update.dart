import 'package:foodie/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodie/models/dish_model.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/widgets/edit_form.dart';
import 'package:foodie/widgets/update_form.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  APIService client = APIService();
  DishDataModel? data;

  bool newSelect = true, editSelect = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getDishesData() async {
    Map<String, dynamic> resp =
        await client.get(endpoint: '/dishes', query: {});

    //resp['data'].forEach((obj) => allDishList.add(DishDataModel.fromJson(obj)));

    // setState(() {
    //   allDishList = allDishList;
    // });
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

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Add or Update Dish",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Options",
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
                        newSelect = true;
                        editSelect = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: newSelect ? primary : cardColor,
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
                          Icon(FontAwesomeIcons.utensils,
                              size: 17,
                              color: newSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "New",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: newSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        editSelect = true;
                        newSelect = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: editSelect ? primary : cardColor,
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
                          Icon(FontAwesomeIcons.penSquare,
                              size: 17,
                              color: editSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Existing",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: editSelect ? Colors.white : darker),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          getForm(newSelect),
        ],
      ),
    );
  }

  getForm(bool option) {
    if (option) {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: UpdateForm(),
          )
        ],
      ));
    } else {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: EditDishForm(),
          )
        ],
      ));
    }
  }
}
