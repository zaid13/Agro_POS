


import 'dart:math';

import 'package:agro_pos/admin/Menu.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Product_Register extends StatefulWidget {
  @override
  _Product_RegisterState createState() => _Product_RegisterState();
}

class _Product_RegisterState extends State<Product_Register> {
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
          title: Text('Register Product'),
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
                    ),
                    Container(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: FormBuilderTextField(
                        name: 'price',

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

                    var respose =  await RegisterProduct(_formKey.currentState.value);
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
  RegisterProduct(data)async{
    setState(() {

      isloading = true;
    });

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('product').where('Name',isEqualTo: data['Name']).get();
    var t =null;
    if(ds.size==0)
    {
      var id = Random().nextInt(5446614).toString()+ DateTime.now().microsecondsSinceEpoch.toString();
      Map mp ={'id':id};
      mp.addAll(data);
// mp.addAll();
t = Map<String, dynamic>.from(mp);

      await FirebaseFirestore.instance.collection('product').doc(id).set(Map<String, dynamic>.from(mp));

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
        desc: "PRODUCT ALREADY EXISTS",
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
      desc: "PRODUCT ADDED",
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
