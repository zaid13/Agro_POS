

import 'package:agro_pos/admin/manage/manageCustomer.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/admin/manage/manageProducts.dart';
import 'package:agro_pos/admin/manage/manageReciepts.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';

class Admin_Menu extends StatefulWidget {
  UserModal userModal;
Admin_Menu(this.userModal);
  @override
  _Admin_MenuState createState() => _Admin_MenuState();
}

class _Admin_MenuState extends State<Admin_Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Container(

          child: Column(
mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button('Products',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_products(),));

              }),
              Container(
                height: 10,
              ),
              _button('Employees',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_employee(),));

              }),
              Container(
                height: 10,
              ),
              _button('Customer',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_customer(),));

              }),
              Container(
                height: 10,
              ),
              _button('Receipt',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_receipt(widget.userModal),));

              }),
            ],
          ),


        ),
      ),
    );
  }

  _button(txt,Function function){
    return FlatButton(
      color: Colors.black.withOpacity(0.1),

      child: Container(
          width: 100,
          height:40,
          alignment: Alignment.center,
          child: Text(txt)),
      onPressed: function,
    );
  }
}
