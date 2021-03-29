


import 'dart:math';

import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Product_Update extends StatefulWidget {
  final Products_Modal products_modal;
  Product_Update(this.products_modal);
  @override
  _Product_UpdateState createState() => _Product_UpdateState();
}

class _Product_UpdateState extends State<Product_Update> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool  isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Update Product'),
        ) ,
        body: ModalProgressHUD(
          inAsyncCall: isloading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(height: 20,),

/*
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: FormBuilderTextField(
                        name: 'Name',

                        decoration: InputDecoration(
                          labelText:
                          'Name',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),

                        ),

                        onChanged: (d){},
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([

                          FormBuilderValidators.minLength(context,1),
                          // FormBuilderValidators.(context),
                          FormBuilderValidators.max(context, 70),
                        ]),
                        keyboardType: TextInputType.text,
                      ),
                    ),*/
                    Container(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: FormBuilderTextField(
                        name: 'price',
initialValue: widget.products_modal.price.toString(),
                        decoration: InputDecoration(
                          labelText:
                          'price',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                        ),

                        onChanged: (d){},
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([

                          FormBuilderValidators.min(context,1),
                          FormBuilderValidators.numeric(context,),
                          FormBuilderValidators.required(context),

                          // FormBuilderValidators.(context),
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: FormBuilderTextField(
                        name: 'quantity_left',
initialValue: widget.products_modal.quantity_left.toString(),
                        decoration: InputDecoration(
                          labelText:
                          'quantity_left',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                        ),

                        onChanged: (d){},
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([

                          FormBuilderValidators.minLength(context,1),
                          // FormBuilderValidators.(context),
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),

                        ]),
                        keyboardType: TextInputType.number,
                      ),
                    ),




                    Container(height: 20,),

                  ],
                ),
              ),
              MaterialButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),

                color: Colors.lightGreen,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Add Product",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  _formKey.currentState.save();
                  if (_formKey.currentState.validate()) {
                    print(_formKey.currentState.value);

                    var respose =  await UpdateProduct(_formKey.currentState.value);
                    showpopup(respose);


                  } else {
                    print("validation failed");
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
  UpdateProduct(data)async{
    setState(() {

      isloading = true;
    });

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('product').where('Name',isEqualTo: widget.products_modal.Name).get();
    var t =null;
    if(ds!=null && ds.docs.length==1)
    {

      Map mp ={/*'id':id*/};
      mp.addAll(data);
// mp.addAll();
      t = Map<String, dynamic>.from(mp);

      await FirebaseFirestore.instance.collection('product').doc(widget.products_modal.id).update(Map<String, dynamic>.from(mp));

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
        desc: "PRODUCT NOT UPDATED",
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
      desc: "PRODUCT UPDATED",
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
    ).show().then((value) => Navigator.pop(context));

    // Manage_Employee
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(),));
  }
}
