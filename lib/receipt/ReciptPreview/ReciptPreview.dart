



import 'package:agro_pos/receipt/modal/ReceiptTileModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ReciptPreview extends StatelessWidget {
  final String reciptId;
  ReciptPreview(this.reciptId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Receipt Preview'),
        ) ,
          backgroundColor: Colors.white .withOpacity(0.7) ,

        // body: ReceiptModal().getTile(reciptdata,context),
        body:  FutureBuilder(

          future: FirebaseFirestore.instance.collection('receipt').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              List<DocumentSnapshot> ds =snapshot.data.docs;
              var newdoc ;
              ds.forEach((element) {
                if(element.id == reciptId){
                  newdoc = element;
                }
              });

              return ReceiptModal().getTile(newdoc, context);

            }else return ModalProgressHUD(inAsyncCall: true, child: Container());
          }
        ),
      ),
    );
  }

}

