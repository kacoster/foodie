import 'package:flutter/material.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/theme/color.dart';
import 'package:foodie/utils/global.dart';
import 'package:search_choices/search_choices.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();

  APIService call = new APIService();

  Map<String, dynamic> dishData = {};
  String _selectedItem = "";
  List<String> _dropdownItems = categories;

  List<DropdownMenuItem> ctgrs = [];

  _getDropdown() {
    _dropdownItems.forEach((element) {
      ctgrs.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
  }

  static const succes = SnackBar(
    content: Text('Dish updated!'),
  );

  static const failed = SnackBar(
    content: Text('Process Failed!'),
  );

  @override
  void initState() {
    super.initState();
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
