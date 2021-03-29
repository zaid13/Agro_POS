//
//
//
//
// import 'package:agro_pos/customer/auth/register.dart';
// import 'package:agro_pos/products/products_modal.dart';
// import 'package:agro_pos/products/register.dart';
// import 'package:agro_pos/receipt/auth/register.dart';
// import 'package:agro_pos/receipt/modal/ReceiptTileModal.dart';
// import 'package:agro_pos/user/auth/register.dart';
// import 'package:agro_pos/user/modal/UserTileModal.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
//
// class  Manage_receipt extends StatefulWidget {
//     UserModal userModal;
//   Manage_receipt(this.userModal);
//   @override
//   _Manage_custoreceipt createState() => _Manage_custoreceipt();
// }
//
// class _Manage_custoreceipt extends State<Manage_receipt> {
//
//   @override
//   void initState() {
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.lightGreen,
//
//             title: Row(
//               mainAxisAlignment:MainAxisAlignment.spaceBetween ,
//               children: [
//                 Text('Manage Receipt'),
//                 FlatButton(
//                   onPressed: () async {
//
//
//                     await Navigator.push(context,MaterialPageRoute(builder: (context) => Receipt_Register(widget.userModal),));
//                     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Manage_receipt(widget.userModal),));
//
//                   },
//                   child: Icon(Icons.add,color: Colors.white,size: 28,),
//                 ),
//
//               ],
//             ),
//
//           ),
//
//           body: FutureBuilder(
//
//             future: FirebaseFirestore.instance.collection('receipt').get(),
//             builder: (context, snapshot) => snapshot.hasData?CustomerList(snapshot.data):ModalProgressHUD(inAsyncCall: true, child: Container()),
//
//           )),
//     );
//   }
//   CustomerList(data){
//
//     List <DocumentSnapshot >ds  =data.docs??[];
//
//     print( ds.length);
//
//     if(ds.length == 0)
//       return Container();
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child:   ListView.builder(itemCount: ds.length,itemBuilder: (context, index) => ReceiptModal() .getTile(ds[index],context),),
//     );
//   }
//
// }
