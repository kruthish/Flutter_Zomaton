import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Restaurents extends StatefulWidget {
  final String typeOfRestaurent;
  Restaurents({this.typeOfRestaurent});
  @override
  _RestaurentsState createState() => _RestaurentsState();
}

class _RestaurentsState extends State<Restaurents> {
  List restaurentList = [];
  @override
  void initState() {
    super.initState();
    getRestaurents(widget.typeOfRestaurent);
  }

  void getRestaurents(String restaurentType) async {
    String requestUrl =  "https://developers.zomato.com/api/v2.1/search?category=$restaurentType";
    http.Response response = await http.get(requestUrl, headers: {'user-key': "7cf2a6aa1b8a27479f0c72b4da141551"});
    setState(() {
      restaurentList = json.decode(response.body)["restaurants"];
      print(restaurentList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.typeOfRestaurent}'),
      ),
      body: new ListView.builder(
        itemCount: restaurentList.length,
        itemBuilder: (context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blueGrey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage('${restaurentList[index]["restaurant"]["thumb"]}'),
                    ),
                  ),

                  ListTile(
                  title: Text('${restaurentList[index]["restaurant"]["name"]}'),
                  onTap: (){
                    
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}