import 'package:flutter/material.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/theme/color.dart';
import 'package:foodie/utils/global.dart';
import 'package:search_choices/search_choices.dart';

class EditDishForm extends StatefulWidget {
  const EditDishForm({Key? key}) : super(key: key);

  @override
  State<EditDishForm> createState() => _EditDishFormState();
}

class _EditDishFormState extends State<EditDishForm> {
  final _formKey = GlobalKey<FormState>();

  APIService call = new APIService();

  Map<String, dynamic> dishData = {};
  String _selectedItem = "";
  String _seleckedSku = "";
  List<String> _dropdownItems = categories;
  List<dynamic> _skuDropdownItems = [];

  List<DropdownMenuItem> ctgrs = [];
  List<DropdownMenuItem> sku = [];

  _getDropdown() {
    _dropdownItems.forEach((element) {
      ctgrs.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
  }

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

  static const succes = SnackBar(
    content: Text('Dish updated!'),
  );

  static const failed = SnackBar(
    content: Text('Dish update failed!'),
  );

  @override
  void initState() {
    super.initState();
    _getAllSku();
    _getDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              SearchChoices.single(
                items: sku,
                value: _seleckedSku,
                hint: "Select sku",
                searchHint: "Search sku",
                onChanged: (value) {
                  setState(() {
                    _seleckedSku = value;
                    dishData['id'] = _seleckedSku;
                  });
                },
                style: TextStyle(color: primary),
                isExpanded: true,
              ),
              SearchChoices.single(
                items: ctgrs,
                value: _selectedItem,
                hint: "Select category",
                searchHint: "Search category",
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    dishData['category'] = _selectedItem;
                  });
                },
                style: TextStyle(color: primary),
                isExpanded: true,
              ),
              SizedBox(height: 5),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['name'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Dish name',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['description'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Dish description',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['prepTime'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Preparation time (Mins) ',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['availTime'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Dish availability e.g weekdays, weekends',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['inStock'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Dish in stock (Yes/No)',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['price'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Dish price',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['availQuntity'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Quantity available',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                style: TextStyle(color: primary),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    dishData['image'] = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Image url',
                    labelStyle: TextStyle(color: shadowColor, fontSize: 12)),
                style: TextStyle(color: primary),
              ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: darker),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var resp = await call.updateDish('/dishes', dishData);
                    if (resp == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(succes);
                      _formKey.currentState?.reset();
                      setState(() {
                        _selectedItem = "";
                        _seleckedSku = "";
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(failed);
                    }
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(secondary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
