import 'package:agro_pos/admin/manage/manageProduct.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/admin/manage/manageCustomer.dart';
import 'package:agro_pos/admin/manage/manageReciepts.dart';
import 'package:agro_pos/receipt/auth/register.dart';
import 'package:agro_pos/sales/sales_history.dart';
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
          backgroundColor: Colors.lightGreen,
          title: Text('Menu'),
        ),
        body: Container(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: [
              _button(Icons.add_shopping_cart, 'Products', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Manage_products(true),
                    ));
              }),
              _button(Icons.accessibility_new, 'Employees', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Manage_employee(),
                    ));
              }),
              _button(Icons.supervised_user_circle, 'Customer', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Manage_customer(),
                    ));
              }),
              _button(Icons.receipt, 'Receipt', () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => Receipt_Register(widget.userModal),));

              }),
              _button(Icons.history, 'Sales history', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SalesHistory(),));
              }),

              _button(Icons.logout, 'Log out', () {
                
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  _button(icon, txt, Function function) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
              color: Colors.lightGreen,
            ),
            Container(alignment: Alignment.center, child: Text(txt)),
          ],
        ),
        onPressed: function,
      ),
    );
  }
}
