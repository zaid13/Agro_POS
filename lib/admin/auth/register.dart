import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class Admin_Register extends StatefulWidget {
  @override
  _Admin_RegisterState createState() => _Admin_RegisterState();
}

class _Admin_RegisterState extends State<Admin_Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool  isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Register Admin'),
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

                    FormBuilderTextField(
                      name: 'Email',
                      decoration: InputDecoration(
                        labelText:
                        'Email',
                      ),
                      onChanged: (d){},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                        FormBuilderValidators.max(context, 70),
                      ]),
                      keyboardType: TextInputType.text,
                    ),
                    Container(height: 20,),
                    FormBuilderTextField(
                      name: 'Password',

                      decoration: InputDecoration(
                        labelText:
                        'Password',

                      ),
                      obscureText: true,
                      onChanged: (d){},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([

                        FormBuilderValidators.minLength(context,6),

                      ]),
                      keyboardType: TextInputType.text,
                    ),
                    Container(height: 20,),
                    FormBuilderTextField(
                      name: 'Name',

                      decoration: InputDecoration(
                        labelText:
                        'Name',

                      ),
                      obscureText: true,
                      onChanged: (d){},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([

                        FormBuilderValidators.minLength(context,1),
                        // FormBuilderValidators.(context),

                      ]),
                      keyboardType: TextInputType.text,
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
    );
  }
  Registeruser(data)async{
    setState(() {

      isloading = true;
    });

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('admin').where('Email',isEqualTo: data['Email']).get();
    var t =null;
    print(ds.size);
    if(ds.size==0)
    {
      t = await FirebaseFirestore.instance.collection('admin').add(data);

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
        desc: "USER ALREADY EXISTS",
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
      desc: "USER ADDED",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);

          // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModal(res )),));

          }          ,
          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
  }
}
