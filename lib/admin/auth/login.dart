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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Login Admin'),
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
                      // initialValue: 'Polo2322@gmail.com',
                      controller: TextEditingController(text: 'Polo2322@gmail.com'),
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
// initialValue: 'Admin1234',
                    controller: TextEditingController(text: 'Admin1234'),
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

                    /*             FormBuilderDropdown(
                      name: 'gender',
                      decoration: InputDecoration(
                        labelText: 'Gender',
                      ),
                      // initialValue: 'Male',
                      allowClear: true,
                      hint: Text('Select Gender'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      items: genderOptions
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                          .toList(),
                    ),
                    FormBuilderTypeAhead(
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                      name: 'country',
                      onChanged: _onChanged,
                      itemBuilder: (context, country) {
                        return ListTile(
                          title: Text(country),
                        );
                      },
                      controller: TextEditingController(text: ''),
                      initialValue: 'Uganda',
                      suggestionsCallback: (query) {
                        if (query.isNotEmpty) {
                          var lowercaseQuery = query.toLowerCase();
                          return allCountries.where((country) {
                            return country.toLowerCase().contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return allCountries;
                        }
                      },
                    ),
                    FormBuilderRadioList(
                      decoration:
                      InputDecoration(labelText: 'My chosen language'),
                      name: 'best_language',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                          .map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text('$lang'),
                      ))
                          .toList(growable: false),
                    ),
                    FormBuilderTouchSpin(
                      decoration: InputDecoration(labelText: 'Stepper'),
                      name: 'stepper',
                      initialValue: 10,
                      step: 1,
                      iconSize: 48.0,
                      addIcon: Icon(Icons.arrow_right),
                      subtractIcon: Icon(Icons.arrow_left),
                    ),
                    FormBuilderRating(
                      decoration: InputDecoration(labelText: 'Rate this form'),
                      name: 'rate',
                      iconSize: 32.0,
                      initialValue: 1.0,
                      max: 5.0,
                      onChanged: _onChanged,
                    ),*/
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
                          var respose =  await LoginUser(_formKey.currentState.value);
                          showpopup(respose,_formKey.currentState.value);
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
              FlatButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Admin_Register(),));

              }, child: Text('Register Admin'))

            ],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModalfromMap(data )),));

          },

          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
  }
}
