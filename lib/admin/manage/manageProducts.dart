


import 'package:agro_pos/customer/auth/register.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/products/register.dart';
import 'package:agro_pos/user/auth/register.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class  Manage_customer extends StatefulWidget {
  @override
  _Manage_customerState createState() => _Manage_customerState();
}

class _Manage_customerState extends State<Manage_customer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,

          title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Text('Manage Customer'),
              FlatButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Customer_Register(),));
                },
                child: Icon(Icons.add,color: Colors.white,size: 28,),
              ),

            ],
          ),

        ),

        body: FutureBuilder(

          future: FirebaseFirestore.instance.collection('customer').get(),
          builder: (context, snapshot) => snapshot.hasData?CustomerList(snapshot.data):ModalProgressHUD(inAsyncCall: true, child: Container()),

        ));
  }
  CustomerList(data){

    List <DocumentSnapshot >ds  =data.docs;
    print( ds.length);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:   ListView.builder(itemCount: ds.length,itemBuilder: (context, index) => CustomerModal() .getTile(ds[index],context),),
    );
  }

}
