


import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/products/register.dart';
import 'package:agro_pos/user/auth/register.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class  Manage_products extends StatefulWidget {
  @override
  _Manage_productsState createState() => _Manage_productsState();
}

class _Manage_productsState extends State<Manage_products> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Text('Manage Products'),
              FlatButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Product_Register(),));
                },
                child: Icon(Icons.add,color: Colors.white,size: 28,),
              ),

            ],
          ),

        ),

        body: FutureBuilder(

          future: FirebaseFirestore.instance.collection('product').get(),
          builder: (context, snapshot) => snapshot.hasData?EmployeeList(snapshot.data):ModalProgressHUD(inAsyncCall: true, child: Container()),

        ));
  }
  EmployeeList(data){

    List <DocumentSnapshot >ds  =data.docs;
    print( ds.length);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:   ListView.builder(itemCount: ds.length,itemBuilder: (context, index) => Products_Modal() .getTile(ds[index],context),),
    );
  }

}
