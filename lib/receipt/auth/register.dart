


import 'dart:math';

import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Receipt_Register extends StatefulWidget {
  UserModal userModal;
Receipt_Register(this.userModal);

  @override
  _Receipt_RegisterState createState() => _Receipt_RegisterState();
}

class _Receipt_RegisterState extends State<Receipt_Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool  isloading = false;
  CustomerModal customerModal  =CustomerModal() ;
List<  Products_Modal> products_modal  = [Products_Modal()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Register Receipt'),
        ) ,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Container(

                  child: ModalProgressHUD(
                    inAsyncCall: isloading,
                    child: ListView(

                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  _formKey.currentState.save();
                                  if (_formKey.currentState.validate()) {
                                    print(_formKey.currentState.value);

                                    var respose =  await registerReciept(_formKey.currentState.value);
                                    showpopup(respose);


                                  } else {
                                    print("validation failed");
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).accentColor,
                                child: Text(
                                  "Reset",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _formKey.currentState.reset();
                                },
                              ),
                            ),
                          ],
                        ),
                        FormBuilder(
                          key: _formKey,
                          // autovalidate: true,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8 ,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: products_modal.length,

                                                itemBuilder: (con,index){
                                                  return Column(
                                                    children: [
                                                      FormBuilderTouchSpin(
                                                                decoration: InputDecoration(labelText: 'Quantity'),
                                                                name: 'quantity${index}',
                                                                initialValue: 1,
                                                                step: 1,
                                                                iconSize: 48.0,
                                                                addIcon: Icon(Icons.arrow_right),
                                                                subtractIcon: Icon(Icons.arrow_left),
                                                      ),
                                                      Container(
                                                                height: 100,
                                                                child: FutureBuilder(
                                                                  future: FirebaseFirestore.instance.collection('customer').get(),
                                                                  builder: (context, snapshot) {
                                                                    if(snapshot.hasData){
                                                                      List customerls = [];

                                                                      List ds = snapshot.data.docs;
                                                                      ds.forEach(( element) {
                                                                        customerls.add({'Email':element.data()['Email'],
                                                                            'Name':element.data()['Name'],});
                                                                      });
                                                                      return FormBuilderDropdown(
                                                                        onChanged: (value) {
                                                                            setState(() {
                                                                              customerls.forEach((element) {

                                                                                if(element['Email'] ==value)
                                                                                  customerModal.initCustomerModalfromMap(element);

                                                                              });

                                                                            });

                                                                        },
                                                                        name: 'customer$index',
                                                                        decoration: InputDecoration(
                                                                            labelText: 'customer',
                                                                        ),
                                                                        // initialValue: 'Male',
                                                                        allowClear: true,
                                                                        hint: Text('customer'),
                                                                        validator: FormBuilderValidators.compose(
                                                                              [FormBuilderValidators.required(context)]),

                                                                        items:customerls
                                                                              .map((customerdata) => DropdownMenuItem(
                                                                            value: customerdata['Email'].toString(),
                                                                            child: Row(
                                                                              mainAxisAlignment:MainAxisAlignment.spaceAround ,
                                                                              children: [
                                                                                Text(customerdata['Name']),
                                                                                Text(customerdata['Email']),
                                                                              ],
                                                                            ),
                                                                        )).toList(),
                                                                      );
                                                                    }
                                                                    return ModalProgressHUD(inAsyncCall: true, child:Container());
                                                                  },

                                                                ),
                                                      ),
                                                      Container(
                                                                height: 100,
                                                                child: FutureBuilder(
                                                                  future: FirebaseFirestore.instance.collection('product').get(),
                                                                  builder: (context, snapshot) {
                                                                    if(snapshot.hasData){
                                                                      List productls = [];

                                                                      List ds = snapshot.data.docs;
                                                                      print(ds.length);
                                                                      ds.forEach(( element) {

                                                                        productls.add(
                                                                              {
                                                                                'price':element.data()['price'],
                                                                                'Name':element.data()['Name'],
                                                                                'id':element.data()['id'],
                                                                                'quantity_left':element.data()['quantity_left']

                                                                              }

                                                                        );

                                                                      });
                                                                      return FormBuilderDropdown(
                                                                        onChanged: (value) {

                                                                            productls.forEach((element) {
                                                                              if(element['Name'] == value)
                                                                                products_modal[index].init_Products_modalfromMap(element);



                                                                            });

                                                                        },
                                                                        name: 'customer',
                                                                        decoration: InputDecoration(
                                                                            labelText: 'product$index',
                                                                        ),
                                                                        // initialValue: 'Male',
                                                                        allowClear: true,
                                                                        hint: Text('product'),
                                                                        validator: FormBuilderValidators.compose(
                                                                              [FormBuilderValidators.required(context)]),

                                                                        items:productls
                                                                              .map((customerdata) => DropdownMenuItem(
                                                                            value: customerdata['Name'].toString(),
                                                                            child: Row(
                                                                              mainAxisAlignment:MainAxisAlignment.spaceAround ,
                                                                              children: [
                                                                                Text(customerdata['Name']),
                                                                                Text(customerdata['price']),
                                                                              ],
                                                                            ),
                                                                        )).toList(),
                                                                      );
                                                                    }
                                                                    return ModalProgressHUD(inAsyncCall: true, child:Container());
                                                                  },

                                                                ),
                                                      ),
                                                      Container(height: 20,),
                                                    ],
                                                  );
                                                },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              FlatButton(
                  color: Colors.blue,
                  onPressed: (){
                    setState(() {
                      products_modal.add(Products_Modal());

                    });
                  },
                  child: Row(
                children: [
                  Icon(Icons.add),
                  Text('ADD'),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  registerReciept(data)async{
    setState(() {

      isloading = true;
    });
var t;

    {

      var id = Random().nextInt(5446614).toString()+ DateTime.now().microsecondsSinceEpoch.toString();
      List  ls = [];
      products_modal.forEach((element) {
        ls.add(element.toMap());
      });
      Map mp ={
        'id':id,
        'user':widget.userModal.toMap(),
        'customer':customerModal.toMap(),
        'product':ls,
        'time':Timestamp.now(),
        'quantity':data['quantity']

      };


      t = mp;
      print('34');
      await FirebaseFirestore.instance.collection('receipt').doc(id).set(Map<String, dynamic>.from(mp));

    }


    setState(() {
      isloading = false;

    });

    return t;
  }



  showpopup(res){
    if(res==null)
    {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "RECEIPT ALREADY EXISTS",
        buttons: [

          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      return;
    }

    Alert(
      context: context,
      type: AlertType.success,
      title: "SUCCESS",
      desc: "RECEIPT ADDED",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModalfromMap(res )),));
  }
}
