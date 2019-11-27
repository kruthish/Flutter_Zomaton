import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Restaurents.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List categories = [];
  @override
  void initState() {
    super.initState();
    getCategoriesList();
  }

  void getCategoriesList() async{
    String requestUrl = 'https://developers.zomato.com/api/v2.1/categories';
    http.Response response = await http.get(requestUrl, headers: {'user-key': "7cf2a6aa1b8a27479f0c72b4da141551"});
     if (response.body != null){
      setState(() {
        categories = (json.decode(response.body))["categories"];
        print(categories);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body:ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey,
              child: ListTile(
              title: Text(' ${index + 1}.  ${categories[index]["categories"]["name"]}'),
              onTap: (){
                String text = "${categories[index]["categories"]["name"]}";
                Navigator.push(context, MaterialPageRoute(builder: (context) => Restaurents(typeOfRestaurent: text))
                );
              },
            ),
            )
          );
        },
      )
    );
  }
}