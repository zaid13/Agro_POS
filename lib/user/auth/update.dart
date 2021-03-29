


import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class User_Update extends StatefulWidget {
  final UserModal userModal;
  User_Update(this.userModal);
  @override
  _User_UpdateState createState() => _User_UpdateState();
}

class _User_UpdateState extends State<User_Update> {
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
          title: Text('Update User'),
        ) ,
        body: ModalProgressHUD(
          inAsyncCall: isloading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // autovalidate: true,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //
                      // Container(
                      //   // color:Colors.white,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(25)),
                      //   ),
                      //   child: FormBuilderTextField(
                      //     name: 'Email',
                      //     decoration: InputDecoration(
                      //
                      //       labelText:
                      //       'Email',
                      //
                      //       fillColor: Colors.white,
                      //       border: new OutlineInputBorder(
                      //         borderRadius: new BorderRadius.circular(25.0),
                      //         borderSide: new BorderSide(
                      //         ),
                      //       ),
                      //       //fillColor: Colors.green
                      //
                      //     ),
                      //     onChanged: (d){},
                      //     // valueTransformer: (text) => num.tryParse(text),
                      //     validator: FormBuilderValidators.compose([
                      //       FormBuilderValidators.required(context),
                      //       FormBuilderValidators.email(context),
                      //       FormBuilderValidators.max(context, 100),
                      //     ]),
                      //     keyboardType: TextInputType.text,
                      //   ),
                      // ),

                      Container(height: 20,),
                   /*   Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: FormBuilderTextField(
                          name: 'Password',

                          decoration: InputDecoration(
                            labelText:
                            'Password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            //fillColo

                          ),
                          obscureText: true,
                          onChanged: (d){},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([

                            FormBuilderValidators.minLength(context,6),
                            // FormBuilderValidators.(context),

                          ]),
                          keyboardType: TextInputType.text,
                        ),
                      ),*/
                      Container(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: FormBuilderTextField(
                          name: 'Name',
                          initialValue: widget.userModal.Name,

                          decoration: InputDecoration(
                            labelText:
                            'Name',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            //fillColo

                          ),
                          obscureText: false,
                          onChanged: (d){},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([

                            FormBuilderValidators.minLength(context,1),
                            // FormBuilderValidators.(context),
                            FormBuilderValidators.max(context, 100),
                          ]),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: FormBuilderTextField
                          (
                          name: 'Phone',
initialValue: widget.userModal.Phone,
                          decoration: InputDecoration(
                            labelText:
                            'Phone',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            //fillColo

                          ),

                          obscureText: false,
                          onChanged: (d){},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([

                            FormBuilderValidators.numeric(context),
                            // FormBuilderValidators.(context),

                          ]),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              MaterialButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),

                color: Colors.lightGreen,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Update Employee",
                    style: TextStyle(color: Colors.white),
                  ),
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

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('user').where('Email',isEqualTo:widget.userModal.Email).get();

    if(ds!=null && ds.docs.length==1)
    {
       await FirebaseFirestore.instance.collection('user').doc(ds.docs.first.id).update(data);

    }


    setState(() {
      isloading = false;

    });

    return ds;
  }
  showpopup(res){
    if(res==null)
    {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "USER NOT UPDATED",
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
      desc: "USER UPDATED",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);


            // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModal(res )),));

          },
          width: 120,
        )
      ],
    ).show().then((value) =>    Navigator.pop(context) );

    // Manage_Employee
  }
}
