


import 'package:agro_pos/receipt/ReciptPreview/ReciptPreview.dart';
import 'package:agro_pos/receipt/modal/ReceiptTileModal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleTile extends StatelessWidget {
  ReceiptModal _receiptModal;

  SaleTile(this._receiptModal);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),

        onPressed: (){                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReciptPreview(_receiptModal.id),));
},
        // borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        elevation: 12,
        child: Container(
          height: 100,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Date:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:DateFormat('h:mm a EEE, MMM d, ''yy').format(_receiptModal.dateTime),style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Total:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:_receiptModal.calculateTotal().toString(),style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Customer:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:_receiptModal.customerModal.Name,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: "Seller:  ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      TextSpan(text:_receiptModal.userModal.Name,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
