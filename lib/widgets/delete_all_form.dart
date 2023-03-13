import 'package:flutter/material.dart';
import 'package:foodie/pages/home.dart';
import 'package:foodie/services/api_service.dart';
import 'package:foodie/theme/color.dart';

class DeleteAllForm extends StatefulWidget {
  const DeleteAllForm({Key? key}) : super(key: key);

  @override
  State<DeleteAllForm> createState() => _DeleteAllFormState();
}

class _DeleteAllFormState extends State<DeleteAllForm> {
  APIService client = APIService();

  static const succes = SnackBar(
    content: Text('Dish updated!'),
  );

  static const failed = SnackBar(
    content: Text('Dish updated!'),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
                child: Text(
                  'Delete All',
                  style: TextStyle(color: darker),
                ),
                onPressed: () {
                  client.get(endpoint: '/dishes/clear', query: {}).then(
                      (value) => value.body['status'] == "OK"
                          ? ScaffoldMessenger.of(context).showSnackBar(succes)
                          : ScaffoldMessenger.of(context).showSnackBar(failed));
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
