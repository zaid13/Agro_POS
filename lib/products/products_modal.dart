


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products_Modal{

  String Name;
  String id;
  double price ;
  int quantity_left ;


  init_Products_modalfromMap(Map data){

    this.Name = data['Name'];
    this.id = data['id'];
    this.price  = data['price'] ;
    this.quantity_left  = data['quantity_left'];

    return this;
  }

  init_Products_modal(DocumentSnapshot data){
  this.Name = data.data()['Name'];
    this.id = data.data()['id'];
  this.price  = double.tryParse(data.data()['price']) ;
    this.quantity_left  = int.tryParse(data.data()['quantity_left']);

    return this;
  }

  Widget getTile(data , BuildContext context){
    if(id==null)
    init_Products_modal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 100,
      color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
mainAxisAlignment:MainAxisAlignment.center ,
      crossAxisAlignment:CrossAxisAlignment.center ,
      children: [
        Column(
          mainAxisAlignment:MainAxisAlignment.center ,

          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Text('Name   '),
            Text('id   '),
            Text('price   '),
            Text('quantity_left   '),
          ],
        ),
        Column(
          mainAxisAlignment:MainAxisAlignment.center ,


          crossAxisAlignment:CrossAxisAlignment.start ,

          children: [
            Text('${Name}   '),
            Text('${id}   '),
            Text('${price}   '),
            Text('${quantity_left}   '),


          ],
        ),
        Column(
          children: [

            IconButton(
            color: Colors.blue,
              onPressed: (){},
            icon: Icon(Icons.edit),


          ),
            IconButton(
              color: Colors.red,
              onPressed: (){},
              icon: Icon(Icons.delete),


            ),
          ],
        )

      ],
      ),
      ),
    );

  }

  toMap(){
    return {

      'id':id,
      'Name':Name,
      'price':price,
      'quantity_left':quantity_left


    };

  }
}