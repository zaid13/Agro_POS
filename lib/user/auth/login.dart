import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/sharedpreference/sharepreference.dart';
import 'package:agro_pos/user/Menu.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

    class User_Login extends StatefulWidget {
  @override
  _User_LoginState createState() => _User_LoginState();
}

class _User_LoginState extends State<User_Login> {
  final _formKey = GlobalKey<FormBuilderState>();
bool  isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      // initialValue: 'gehehe@zcapin.com',
                      controller: TextEditingController(text:'gehehe@zcapin.com' ),
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
// initialValue: 'gsgsgsg',
                        controller: TextEditingController(text: 'gsgsgsg'),
                      decoration: InputDecoration(
                        labelText:
                        'Password',

                      ),
                      obscureText: true,
                      onChanged: (d){},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([

                        FormBuilderValidators.minLength(context,6),
                        // FormBuilderValidators.(context),
                        FormBuilderValidators.max(context, 70),
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

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('user').where('Email',isEqualTo: data['Email']).
    where('Password',isEqualTo: data['Password']).get();
    var t =null;
    if(ds.size==1)
      {
         t = ds.docs .first;

      }


 setState(() {
   isloading = false;

 });

 return t;
  }
  showpopup(DocumentSnapshot res){
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
      desc: "USER SIGNED IN",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {Navigator.pop(context);
          UserModal userModal = UserModal().initUserModal(res );

          Navigator.push(context, MaterialPageRoute(builder: (context) => Customer_Menu(userModal )));

          },
          width: 120,
        )
      ],
    ).show();

  }
    }
