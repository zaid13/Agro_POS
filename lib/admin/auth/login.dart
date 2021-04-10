import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/admin/auth/register.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Admin_Login extends StatefulWidget {
  @override
  _Admin_LoginState createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool  isloading = false;
  var requestdata ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white .withOpacity(0.7),

        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Login Admin'),
        ) ,
        body: ModalProgressHUD(
          inAsyncCall: isloading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  // autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      Container(
                        decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25))

                        ),
                        child: FormBuilderTextField(
                          // initialValue: 'Polo2322@gmail.com',
                          controller: TextEditingController(text: ''),
                          name: 'Email',
                          decoration: InputDecoration(

                            labelText:
                            'Email',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
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
                      ),


                      Container(height: 20,),


                      Container(
                        decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25))

                        ),
                        child: FormBuilderTextField(
                          name: 'Password',
// initialValue: 'Admin1234',
                        controller: TextEditingController(text: ''),
                          decoration: InputDecoration(
                            labelText:
                            'Password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),

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
                      ),
                      Container(height: 20,),


                    ],
                  ),
                ),
                MaterialButton(

                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),

                  color: Colors.lightGreen,
                  // color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {


                      print(_formKey.currentState.value);
                      var respose =  await LoginUser(_formKey.currentState.value);
                      showpopup(respose,_formKey.currentState.value);
                    } else {
                      print("validation failed");
                    }
                  },
                ),
                SizedBox(width: 20),

                FlatButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Admin_Register(),));

                }, child: Text('Register Admin'))

              ],
            ),
          ),
        ),
      ),
    );
  }
  LoginUser(data)async{
    setState(() {

      isloading = true;
    });

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('admin').where('Email',isEqualTo: data['Email']).where('Password',isEqualTo:data['Password'] ).get();
    var t =null;
    if(ds.size>0)
    {
      requestdata = ds;
      t ='sa';

    }


    setState(() {
      isloading = false;

    });

    return t;
  }
  showpopup(res,data){
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
      desc: "USER LOGIN",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {

            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModal(requestdata.docs[0] )),));

          },

          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
  }
}
