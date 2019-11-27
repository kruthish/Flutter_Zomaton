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
  String imageValue;
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
          
          this.imageValue = '${restaurentList[index]["restaurant"]["thumb"]}';
          if (this.imageValue == ""){
            this.imageValue = 'https://d1whtlypfis84e.cloudfront.net/guides/wp-content/uploads/2019/08/03091106/Trees-768x511.jpg';
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black87,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(    
                        image: NetworkImage(this.imageValue),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  
                  ListTile(
                  title: Text('${restaurentList[index]["restaurant"]["name"]}', style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                  onTap: (){
                    
                    },
                  ),
                  ListTile(
                    title: Text('${restaurentList[index]["restaurant"]["cuisines"]}', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                  ),
                  ListTile(
                    title: Text('${restaurentList[index]["restaurant"]["location"]["address"]}', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}