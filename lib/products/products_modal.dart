import 'package:agro_pos/admin/manage/manageProduct.dart';
import 'package:agro_pos/products/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products_Modal {
  String Name;
  String id;
  double price = 0.0;
  int quantity_left;
  int quantity = 0;

  bool  spinnerIsActive = true;
  double calculateCost() {
    if (price == null || quantity == null) return 0;
// if(quantity == 1)
//   return price  * quantity_left;

    return price * quantity;
  }

  init_Products_modalfromALL_List(List data) {
  return   data.map((e) => init_Products_modalfromMap(e)).toList(growable: true);
  }

  init_Products_modalfromMap(Map data) {

    Products_Modal newProducts_Modal = Products_Modal();
    print('dfede');
    newProducts_Modal.Name = data['Name'];
    newProducts_Modal.id = data['id'];

    if (data['price'].runtimeType == String) {
      newProducts_Modal.price = double.tryParse(data['price'] ?? '0.0');
    } else {
      newProducts_Modal.price = data['price'];
    }
    if (data['quantity_left'].runtimeType == String) {
      newProducts_Modal.quantity_left = int.tryParse(data['quantity_left'] ?? '0');
    } else {
      newProducts_Modal.quantity_left = data['quantity_left'];
    }
    if (data['quantity'].runtimeType == String) {
      newProducts_Modal.quantity = int.tryParse(data['quantity'] ?? '0');
    } else {
      newProducts_Modal.quantity = data['quantity'];
    }

    return newProducts_Modal;
  }

  init_Products_modal(DocumentSnapshot data) {
    this.Name = data.data()['Name'];
    this.id = data.data()['id'];
    this.price = double.tryParse(data.data()['price'] ??'0.0');
    this.quantity_left = int.tryParse(data.data()['quantity_left'] ?? '0');
    this.quantity = int.tryParse(data.data()['quantity'] ?? '0');

    return this;
  }

  Widget getTile(data, BuildContext context,admin) {
    if (id == null) init_Products_modal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
          elevation: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 10,),
            Container(
              height: 70,
              child: Image.asset('assets/product.jpeg'),),
            Container(width: 10,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(height: 15,),
                Text('    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                // Text('id   '),
                Text('quantity_left   '),

                Text('price   ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Name}   ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  // Text('${id}   ',overflow: TextOverflow.clip,),
                  Text('${quantity_left}   '),

                  Text('${price}   ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            admin? Column(
              children: [
                IconButton(
                  color: Colors.blue,
                  onPressed: () {

                    Navigator.push(context,MaterialPageRoute(builder: (context) => Product_Update(this),)).then((value) =>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Manage_products(admin),)));


                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () {

                    FirebaseFirestore.instance.collection('product').doc(id).delete().then((value) =>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Manage_products(admin),)));

                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ):Container()
          ],
        ),
      ),
    );
  }

  Widget getTileWithouButton(data, BuildContext context) {
    if (id == null) init_Products_modal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name   '),
                  Text('id   '),
                  Text('price   '),
                  Text('quantity '),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Name}   '),
                  Text('${id}   '),
                  Text('${price}   '),
                  Text('${quantity}   '),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  toMap() {
    return {
      'id': id,
      'Name': Name,
      'price': price,
      'quantity_left': quantity_left,
      'quantity': quantity,
    };
  }
}
