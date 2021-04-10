import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:agro_pos/receipt/pdfGenerator/pdfGen.dart';

import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

class ReceiptModal {
  String id;
  DateTime dateTime;
  CustomerModal customerModal;
  UserModal userModal;
  List products_modal_list;


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  init_ReceiptModal(QueryDocumentSnapshot data) {
    this.userModal =
        UserModal().initUserModalfromMap(data.data()['user'] as Map);
    customerModal = CustomerModal()
        .initCustomerModalfromMap(data.data()['customer'] as Map);

    this.products_modal_list = Products_Modal()
        . init_Products_modalfromALL_List(data.data()['product']);

    this.dateTime = data.data()['time'].toDate();
    this.id = data.data()['id'];

    return this;
  }

  getTile(data, context) {
    init_ReceiptModal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 650,
        color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaisedButton(
              color: Colors.deepPurple,
              onPressed: () {


                CreatePdf.generateInvoice(this);

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory,
                      color: Colors.white,
                    ),
                    Container(width: 5,),
                    Text(
                      'Generate Invoice',
                      style: TextStyle(color: Colors.white,fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [

                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "ID:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:id,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Date:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:DateFormat('h:mm a EEE, MMM d, ''yy').format(dateTime),style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ],
            ),
Container(height: 15,),

            Text(
              'Customer',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            customerModal.getTileWithouButton(data, context),
            Text(
              'User',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            userModal.getTileWithouButton(data, context),

            Text(
              'Product',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products_modal_list.length,
                itemBuilder: (context, index) => products_modal_list[index]
                    .getTileWithouButton(data, context),
              ),
            ),



            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

      ),
                    Text(
                      calculateTotal().toString(),
                      style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),

                    ),]
                    )

                ),
              ),

          ],
        ),
      ),
    );
  }

  double calculateTotal() {
    double cost = 0;

    products_modal_list.forEach((element) {
      cost += element.calculateCost();
    });
    print(cost);
    return cost;
  }

  double calculateTotalFromList(ls) {
    double cost = 0;

    ls.forEach((element) {
      cost += element.calculateCost();
    });
    print(cost);
    return cost;
  }


}

