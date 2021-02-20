


import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class User_Register extends StatefulWidget {
  @override
  _User_RegisterState createState() => _User_RegisterState();
}

class _User_RegisterState extends State<User_Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool  isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Register User'),
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
                    /*          FormBuilderFilterChip(
                      name: 'filter_chip',
                      decoration: InputDecoration(
                        labelText: 'Select many options',
                      ),
                      options: [
                        FormBuilderFieldOption(
                            value: 'Test', child: Text('Test')),
                        FormBuilderFieldOption(
                            value: 'Test 1', child: Text('Test 1')),
                        FormBuilderFieldOption(
                            value: 'Test 2', child: Text('Test 2')),
                        FormBuilderFieldOption(
                            value: 'Test 3', child: Text('Test 3')),
                        FormBuilderFieldOption(
                            value: 'Test 4', child: Text('Test 4')),
                      ],
                    ),
                    FormBuilderChoiceChip(
                      name: 'choice_chip',
                      decoration: InputDecoration(
                        labelText: 'Select an option',
                      ),
                      options: [
                        FormBuilderFieldOption(
                            value: 'Test', child: Text('Test')),
                        FormBuilderFieldOption(
                            value: 'Test 1', child: Text('Test 1')),
                        FormBuilderFieldOption(
                            value: 'Test 2', child: Text('Test 2')),
                        FormBuilderFieldOption(
                            value: 'Test 3', child: Text('Test 3')),
                        FormBuilderFieldOption(
                            value: 'Test 4', child: Text('Test 4')),
                      ],
                    ),
                    FormBuilderColorPickerField(
                      name: 'color_picker',
                      // initialValue: Colors.yellow,
                      colorPickerType: ColorPickerType.MaterialPicker,
                      decoration: InputDecoration(labelText: 'Pick Color'),
                    ),
                    FormBuilderChipsInput(
                      decoration: InputDecoration(labelText: 'Chips'),
                      name: 'chips_test',
                      onChanged: _onChanged,
                      initialValue: [
                        Contact('Andrew', 'stock@man.com',
                            'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                      ],
                      maxChips: 5,
                      findSuggestions: (String query) {
                        if (query.isNotEmpty) {
                          var lowercaseQuery = query.toLowerCase();
                          return contacts.where((profile) {
                            return profile.name
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                                profile.email
                                    .toLowerCase()
                                    .contains(query.toLowerCase());
                          }).toList(growable: false)
                            ..sort((a, b) => a.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(b.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)));
                        } else {
                          return const <Contact>[];
                        }
                      },
                      chipBuilder: (context, state, profile) {
                        return InputChip(
                          key: ObjectKey(profile),
                          label: Text(profile.name),
                          avatar: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          onDeleted: () => state.deleteChip(profile),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      },
                      suggestionBuilder: (context, state, profile) {
                        return ListTile(
                          key: ObjectKey(profile),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          title: Text(profile.name),
                          subtitle: Text(profile.email),
                          onTap: () => state.selectSuggestion(profile),
                        );
                      },
                    ),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      // onChanged: _onChanged,
                      inputType: InputType.time,
                      decoration: InputDecoration(
                        labelText: 'Appointment Time',
                      ),
                      initialTime: TimeOfDay(hour: 8, minute: 0),
                      // initialValue: DateTime.now(),
                      // enabled: true,
                    ),
                    FormBuilderDateRangePicker(
                      name: 'date_range',
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                      format: DateFormat('yyyy-MM-dd'),
                      onChanged: _onChanged,
                      decoration: InputDecoration(
                        labelText: 'Date Range',
                        helperText: 'Helper text',
                        hintText: 'Hint text',
                      ),
                    ),
                    FormBuilderSlider(
                      name: 'slider',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 6),
                      ]),
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 10.0,
                      initialValue: 7.0,
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration: InputDecoration(
                        labelText: 'Number of things',
                      ),
                    ),
                    FormBuilderCheckbox(
                      name: 'accept_terms',
                      initialValue: false,
                      onChanged: _onChanged,
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I have read and agree to the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.equal(
                        context,
                        true,
                        errorText:
                        'You must accept terms and conditions to continue',
                      ),
                    ),*/
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
                        // FormBuilderValidators.(context),
                        FormBuilderValidators.max(context, 70),
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

    QuerySnapshot ds = await FirebaseFirestore.instance.collection('user').where('Email',isEqualTo: data['Email']).get();
    var t =null;
    if(ds.size==0)
    {
      t = await FirebaseFirestore.instance.collection('user').add(data);

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
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModal(res )),));
  }
}
