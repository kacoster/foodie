import 'package:flutter/material.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/theme/color.dart';
import 'package:search_choices/search_choices.dart';

class SingleDishDelete extends StatefulWidget {
  const SingleDishDelete({Key? key}) : super(key: key);

  @override
  State<SingleDishDelete> createState() => _SingleDishDeleteState();
}

class _SingleDishDeleteState extends State<SingleDishDelete> {
  APIService call = APIService();

  String _seleckedSku = "";
  List<dynamic> _skuDropdownItems = [];
  List<DropdownMenuItem> sku = [];
  Map<String, dynamic> dishData = {};

  static const succes = SnackBar(
    content: Text('Dish updated!'),
  );

  static const failed = SnackBar(
    content: Text('Dish updated!'),
  );

  static const invalid = SnackBar(
      content: Text('SKU Not Valid!'),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.redAccent);

  _getSkuDropdown() {
    _skuDropdownItems.forEach((element) {
      sku.add(DropdownMenuItem(
        child: Text(element.split('-')[0]),
        value: element,
      ));
    });
  }

  _getAllSku() async {
    await call.getSku('/dishes/sku').then((value) => setState(() {
          print(value['data']);
          _skuDropdownItems = value['data'];
        }));

    _getSkuDropdown();
  }

  @override
  void initState() {
    super.initState();
    _getAllSku();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SearchChoices.single(
              items: sku,
              value: _seleckedSku,
              hint: "Select sku",
              searchHint: "Search sku",
              onChanged: (value) {
                setState(() {
                  _seleckedSku = value;
                  //dishData['id'] = _seleckedSku;
                });
              },
              style: TextStyle(color: primary),
              isExpanded: true,
            ),
            TextButton(
                child: Text(
                  'Delete Dish',
                  style: TextStyle(color: darker),
                ),
                onPressed: () {
                  if (_seleckedSku != "") {
                    call.deleteDish('/dishes/${_seleckedSku}', {}).then(
                        (value) => value == 200
                            ? ScaffoldMessenger.of(context).showSnackBar(succes)
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(failed));
                    setState(() {
                      _seleckedSku = "";
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(invalid);
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(secondary)))
          ],
        ),
      ),
    );
  }
}
