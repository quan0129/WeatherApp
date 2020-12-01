import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitySearchScreen();
}

class _CitySearchScreen extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter City"),
      ),
      body: Form(
          child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: _cityTextController,
              decoration: InputDecoration(
                  labelText: "Enter City", hintText: "Example Ha Noi"),
            ),
          )),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _cityTextController.text);
              })
        ],
      )),
    );
  }
}