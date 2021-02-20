


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
  Products_Modal products_modal  = Products_Modal();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Register Receipt'),
        ) ,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          child: ModalProgressHUD(
            inAsyncCall: isloading,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  // autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: 'Quantity'),
                        name: 'quantity',
                        initialValue: 1,
                        step: 1,
                        iconSize: 48.0,
                        addIcon: Icon(Icons.arrow_right),
                        subtractIcon: Icon(Icons.arrow_left),
                      ),
                      Container
                        (
                        height: 100,
                        child: FutureBuilder(
future: FirebaseFirestore.instance.collection('customer').get(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List ls = [];

                              List ds = snapshot.data.docs;
                              ds.forEach(( element) {
                                ls.add({'Email':element.data()['Email'],
                                  'Name':element.data()['Name'],});
                              });
                              return FormBuilderDropdown(
                                onChanged: (value) {
                                  setState(() {
                                    ls.forEach((element) {

                                      if(element['Email'] ==value)
                                        customerModal.initCustomerModalfromMap(element);

                                    });

                                  });

                                },
                                name: 'customer',
                                decoration: InputDecoration(
                                  labelText: 'customer',
                                ),
                                // initialValue: 'Male',
                                allowClear: true,
                                hint: Text('customer'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),

                                items:ls
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
                              List ls = [];

                              List ds = snapshot.data.docs;
                              print(ds.length);
                              ds.forEach(( element) {

                                ls.add(
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
                                  ls.forEach((element) {
                                    if(element['Name'] == value)
                                      products_modal.init_Products_modalfromMap(element);



                                  });

                                },
                                name: 'customer',
                                decoration: InputDecoration(
                                  labelText: 'product',
                                ),
                                // initialValue: 'Male',
                                allowClear: true,
                                hint: Text('product'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),

                                items:ls
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
                  ),
                ),
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

                            var respose =  await Registeruser(_formKey.currentState.value);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Registeruser(data)async{
    setState(() {

      isloading = true;
    });
var t;

    {

      var id = Random().nextInt(5446614).toString()+ DateTime.now().microsecondsSinceEpoch.toString();
      Map mp ={
        'id':id,
        'user':widget.userModal.toMap(),
        'customer':customerModal.toMap(),
        'product':products_modal.toMap(),
        'time':Timestamp.now(),
        'quantity':data['quantity']

      };


      t = mp;
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
