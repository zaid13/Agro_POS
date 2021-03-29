

import 'package:agro_pos/admin/manage/manageProduct.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/admin/manage/manageCustomer.dart';
import 'package:agro_pos/admin/manage/manageReciepts.dart';
import 'package:agro_pos/receipt/auth/register.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:agro_pos/user/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

class Customer_Menu extends StatefulWidget {
  UserModal userModal;
Customer_Menu(this.userModal);
  @override
  _Admin_MenuState createState() => _Admin_MenuState();
}

class _Admin_MenuState extends State<Customer_Menu> {
  GlobalKey<SliderMenuContainerState> _key =
  new GlobalKey<SliderMenuContainerState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer:MultiLevelDrawer(

          backgroundColor: Colors.orangeAccent,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          divisionColor: Colors.white,
          header: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   "assets/dp_default.png",
                    //   width: 100,
                    //   height: 100,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.userModal.Name.isEmpty?'Name is not set':widget.userModal.Name
                      ,style: TextStyle(color: Colors. white,fontSize: 22),),
                  ],
                )),
          ),
          children: [


            MLMenuItem(
                leading: Icon(Icons.history,color: Colors.white,size: 30),
                trailing: Container(),
                content: Text(
                  "Receipt"
                  ,style: TextStyle(color: Colors. white,fontWeight: FontWeight.bold,fontSize: 18),),

                onClick: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Receipt_Register(widget.userModal),));
                }),

            MLMenuItem(

                leading: Icon(Icons.inventory,color: Colors.white,size: 30),
                content: Text("products"
                  ,style: TextStyle(color: Colors. white,fontWeight: FontWeight.bold,fontSize: 18),),

                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_products(false),));

                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen()));
                },
                trailing: Container()
            ),


            MLMenuItem(
              leading: Icon(Icons.account_circle_rounded,color: Colors.white,size: 30,),
              content: Text("Customer Profile"
                ,style: TextStyle(color: Colors. white,fontWeight: FontWeight.bold,fontSize: 18),),
              onClick: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => User_Profile(widget.userModal)));
              },
              trailing: Container()
            ),

            MLMenuItem(
                // leading: Icon(Icons.account_circle_rounded),
                content: Text("Signout",style: TextStyle(color: Colors. white,fontSize: 18,fontWeight: FontWeight.bold),),
                onClick: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                trailing: Container()
            ),
          ],
        ),
        appBar: AppBar(
          title: Text('Menu',style: TextStyle(color: Colors. white),),
          backgroundColor: Colors.lightGreen,
        ),





        body:  Container(

          child: ListView(
// mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button('Products',(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Manage_products(false),));

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
                Navigator.push(context,MaterialPageRoute(builder: (context) => Receipt_Register(widget.userModal),));



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
MLMenuItem1({
@required  Widget leading,
  @required  Widget  trailing,
  @required  Widget content,
  @required  Function onClick

}){
  // ignore: deprecated_member_use
  return RaisedButton(
    onPressed: onClick,
    child: Row(
      children: [
        leading,
        content,
        trailing,

      ],
    ),
  );

}