import 'package:foodie/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodie/models/dish_model.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/widgets/delete_all_form.dart';
import 'package:foodie/widgets/delete_single.dart';
import 'package:foodie/widgets/edit_form.dart';
import 'package:foodie/widgets/update_form.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({Key? key}) : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  APIService client = APIService();
  DishDataModel? data;

  bool allSelect = true, singleSelect = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getDishesData() async {
    Map<String, dynamic> resp =
        await client.get(endpoint: '/dishes', query: {});
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
              "Delete Dishes",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Options",
          //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          //       )
          //     ],
          //   ),
          // ),
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
                        singleSelect = false;
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
                          Icon(FontAwesomeIcons.utensils,
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
                        singleSelect = true;
                        allSelect = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        color: singleSelect ? primary : cardColor,
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
                              color: singleSelect ? Colors.white : darker),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Single",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: singleSelect ? Colors.white : darker),
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
          getForm(allSelect),
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
            child: DeleteAllForm(),
          )
        ],
      ));
    } else {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: SingleDishDelete(),
          )
        ],
      ));
    }
  }
}
