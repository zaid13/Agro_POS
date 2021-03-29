

import 'package:agro_pos/receipt/ReciptPreview/ReciptPreview.dart';
import 'package:agro_pos/receipt/modal/ReceiptTileModal.dart';
import 'package:agro_pos/sales/saleTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SalesHistory extends StatefulWidget {
  @override
  _SalesHistoryState createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,

            title: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              children: [
                Text('Sales History'),

              ],
            ),

          ),
         backgroundColor: Colors.white .withOpacity(0.7),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future:FirebaseFirestore.instance.collection('receipt').orderBy("time",descending: true).get(),
              builder: (context, snapshot) {
                if(snapshot.hasData){

print(snapshot.data.docs.length);
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => SaleTile(ReceiptModal().init_ReceiptModal(snapshot.data.docs[index])),);
              }
              return ModalProgressHUD(inAsyncCall: true, child: Container());

              }
            ),
          )),
    );
  }
}
