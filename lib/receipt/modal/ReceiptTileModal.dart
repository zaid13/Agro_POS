import 'package:intl/intl.dart';



import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

class ReceiptModal{

  String id;
  DateTime dateTime;
  CustomerModal customerModal;
  UserModal userModal;
  Products_Modal products_modal;





  init_ReceiptModal(QueryDocumentSnapshot data){


  this.userModal = UserModal().initUserModalfromMap(data.data()['user'] as Map);
  this.customerModal =CustomerModal().initCustomerModalfromMap(data.data()['customer']  as Map);
  this.products_modal = Products_Modal().init_Products_modalfromMap(data.data()['product'] as Map);

  this.dateTime  =   data.data()['time'] .toDate();
  this.id =   data.data()['id'];

  return this;
}

  getTile(data,context){
     init_ReceiptModal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 600,
        color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          crossAxisAlignment:CrossAxisAlignment.center ,
  children: [

          Expanded(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,

          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Row(
              children: [
                Text(id),
                Text(DateFormat('h:mm a EEE, MMM d, ''yy').format(dateTime))

              ],
            ),

            Text('Product',style: TextStyle(fontSize: 20),),
            products_modal.getTile(data, context),
            Text('Customer',style: TextStyle(fontSize: 20),),
            customerModal.getTile(data, context),
            Text('User',style: TextStyle(fontSize: 20),),
            userModal.getTile(data, context)





          ],

        ),
      ),

  ]
          ,
),
      ),
    );
  }

}