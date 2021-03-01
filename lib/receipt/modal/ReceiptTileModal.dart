import 'package:intl/intl.dart';

import 'package:agro_pos/receipt/pdfGenerator/pdfGen.dart';

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
  List<Products_Modal> products_modal_list;





  init_ReceiptModal(QueryDocumentSnapshot data){


  this.userModal = UserModal().initUserModalfromMap(data.data()['user'] as Map);
  customerModal =CustomerModal().initCustomerModalfromMap(data.data()['customer']  as Map);
  this.products_modal_list = Products_Modal().init_Products_modalfromALL_List(data.data()['product']);

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
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start ,

          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            RaisedButton(
              color:Colors.black.withOpacity(0.2),
              onPressed: (){CreatePdf.generateInvoice(this);},
              child: Row(
                children: [

                  Icon( Icons.inventory,color: Colors.white,),
                  Text('Generate Invoice',style: TextStyle(color: Colors.white),)
                ],

              ),
            ),
            Column(
              children: [


                Text('ID:    '+id),
                Text(DateFormat('h:mm a EEE, MMM d, ''yy').format(dateTime))

              ],
            ),

            Text('Product',style: TextStyle(fontSize: 20),),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                itemCount: products_modal_list.length,
                itemBuilder: (context, index) => products_modal_list[index].getTileWithouButton(data, context),),
            ),
            Text('Customer',style: TextStyle(fontSize: 20),),
            customerModal.getTileWithouButton(data, context),
            Text('User',style: TextStyle(fontSize: 20),),
            userModal.getTileWithouButton(data, context),
Row(children: [

  Text('Total'),
  Expanded(child: Text(calculateTotal.toString(),style: TextStyle(color: Colors.green,fontSize: 22),))
],)




          ],

        ),
      ),
    );
  }
  double calculateTotal(){
    double cost = 0;

    products_modal_list.forEach((element) {
      cost+=element.calculateCost();
    });
    print(cost);
    return cost;
}


}