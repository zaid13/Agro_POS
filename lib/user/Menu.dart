

import 'package:agro_pos/admin/manage/manageCustomer.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/admin/manage/manageProducts.dart';
import 'package:agro_pos/admin/manage/manageReciepts.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';

class Customer_Menu extends StatefulWidget {
  UserModal userModal;
Customer_Menu(this.userModal);
  @override
  _Admin_MenuState createState() => _Admin_MenuState();
}

class _Admin_MenuState extends State<Customer_Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        backgroundColor: Colors.lightGreen,
        ),

        body: Container(

          child: ListView(
// mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button('Products',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_products(),));

              },'assets/product.jpeg'),

              Container(
                height: 10,
              ),
              _button('Customer',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_customer(),));

              },'assets/customer.jpeg'),
              Container(
                height: 10,
              ),
              _button('Receipt',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_receipt(widget.userModal),));

              },'assets/reciept.jpeg'),
            ],
          ),


        ),
      ),
    );
  }

  _button(txt,Function function,imgname){
    return FlatButton(
      color: Colors.black.withOpacity(0.1),

      child: Container(
          width: MediaQuery.of(context).size.width  -20,
          height:200,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container
                (
                  width: MediaQuery.of(context).size.width  -20,
                  height:150,

                  child: Image.asset(imgname,fit: BoxFit.fill,)),
              Container(
                   alignment: Alignment.center,
                  child: Text(txt))
            ],
          )),
      onPressed: function,
    );
  }
}
