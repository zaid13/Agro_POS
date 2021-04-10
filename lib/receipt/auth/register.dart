import 'dart:math';

import 'package:agro_pos/admin/Menu.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/customer/modal/UserTileModal.dart';
import 'package:agro_pos/products/products_modal.dart';
import 'package:agro_pos/receipt/ReciptPreview/ReciptPreview.dart';
import 'package:agro_pos/receipt/modal/ReceiptTileModal.dart';
import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  bool isloading = false;
  CustomerModal customerModal = CustomerModal();
  List<Products_Modal> products_modal = [Products_Modal()];
  List<int> prod_quat = [];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ReciptPreview(
          payload
      );
    }));
  }
  showNotification(id) async {
    var android = AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'AGRO POS', 'Receipt Created', platform,
        payload:id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Register Receipt'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: ModalProgressHUD(
                    inAsyncCall: isloading,
                    child: ListView(
                      children: <Widget>[
                        FormBuilder(
                          key: _formKey,
                          // autovalidate: true,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'TOTAL',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  Text(
                                    ReceiptModal()
                                        .calculateTotalFromList(products_modal)
                                        .toString(),
                                    style: TextStyle(fontSize: 23),
                                  ),
                                ],
                              ),
                              Container(
                                height: 70,
                                child: FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('customer')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List customerls = [];

                                      List ds = snapshot.data.docs;
                                      ds.forEach((element) {
                                        customerls.add({
                                          'Email': element.data()['Email'],
                                          'Name': element.data()['Name'],
                                        });
                                      });
                                      return FormBuilderDropdown(
                                        onChanged: (value) {
                                          setState(() {
                                            customerls.forEach((element) {
                                              if (element['Email'] == value)
                                                customerModal
                                                    .initCustomerModalfromMap(
                                                        element);
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
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              context)
                                        ]),

                                        items: customerls
                                            .map((customerdata) =>
                                                DropdownMenuItem(
                                                  value: customerdata['Email']
                                                      .toString(),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          customerdata['Name']),
                                                      Text(customerdata[
                                                          'Email']),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    }
                                    return ModalProgressHUD(
                                        inAsyncCall: true, child: Container());
                                  },
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: products_modal.length,
                                  itemBuilder: (con, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.lightGreen.shade50,
                                        elevation: 12,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                child: FutureBuilder(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection('product')
                                                      .get(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List productls = [];

                                                      List ds =
                                                          snapshot.data.docs;
                                                      print(ds.length);
                                                      int i =0;

                                                      ds.forEach((element) {
                                                        productls.add({
                                                          'price': element
                                                              .data()['price'],
                                                          'Name': element
                                                              .data()['Name'],
                                                          'id': element
                                                              .data()['id'],
                                                          'quantity_left': element
                                                              .data()[
                                                          'quantity_left'],
                                                          'quantity':prod_quat.length>i ?prod_quat[i]:null,
                                                        });
                                                        i++;
                                                      });
                                                      return FormBuilderDropdown(

                                                        onChanged: (value) {
                                                          print(value);

                                                          productls.forEach(
                                                                  (element) {
                                                                if (element['Name'] ==
                                                                    value) {
                                                                  setState(() {
                                                                    products_modal[
                                                                    index] = products_modal[index]
                                                                        .init_Products_modalfromMap(
                                                                        element);
                                                                  });
                                                                }
                                                              });

                                                        },
                                                        name: 'customer',
                                                        decoration:
                                                        InputDecoration(
                                                          labelText:
                                                          'product$index',
                                                        ),
                                                        // initialValue: 'Male',
                                                        allowClear: false,
                                                        hint: Text('product'),
                                                        validator:
                                                        FormBuilderValidators
                                                            .compose([
                                                          FormBuilderValidators
                                                              .required(context)
                                                        ]),

                                                        items: productls
                                                            .map((customerdata) =>
                                                            DropdownMenuItem(
                                                              value: customerdata[
                                                              'Name']
                                                                  .toString(),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  Text(customerdata[
                                                                  'Name']),
                                                                  Text(customerdata[
                                                                  'price']),
                                                                ],
                                                              ),
                                                            ))
                                                            .toList(),
                                                      );
                                                    }
                                                    return ModalProgressHUD(
                                                        inAsyncCall: true,
                                                        child: Container());
                                                  },
                                                ),
                                              ),
                                              Container(
                                                height: 70,
                                                child: FormBuilderTouchSpin(
                                                  decoration: InputDecoration(
                                                      labelText: 'Quantity'),
                                                  name: 'quantity${index}',
                                                  initialValue:
                                                      products_modal[index]
                                                          .quantity,

                                                  step: 1,
                                                  iconSize: 48.0,
                                                  addIcon:
                                                      Icon(Icons.arrow_right),
                                                  subtractIcon:
                                                      Icon(Icons.arrow_left),
                                                  enabled: products_modal[index]
                                                      .spinnerIsActive,
                                                  onChanged: (d) {
                                                    setState(() {
                                                      products_modal[index]
                                                          .quantity = d;
                                                    });
                                                  },
                                                ),
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  FlatButton(
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        setState(() {
                                                          products_modal
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      )),
                                                  Text(
                                                      'Price ${products_modal[index].calculateCost()}')
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FlatButton(
                  color: Colors.green,
                  onPressed: () {


                    setState(() {
                      products_modal.add(Products_Modal());
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'ADD',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () async {
                  _formKey.currentState.save();
                  if (_formKey.currentState.validate()) {
                    print(_formKey.currentState.value);

                    var respose =
                        await registerReciept(_formKey.currentState.value);
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

  registerReciept(data) async {
    setState(() {
      isloading = true;
    });

    var id;
    {
       id = Random().nextInt(5446614).toString() +
          DateTime.now().microsecondsSinceEpoch.toString();
      List ls = [];
      products_modal.forEach((element) {
        ls.add(element.toMap());
      });
      Map mp = {
        'id': id,
        'user': widget.userModal.toMap(),
        'customer': customerModal.toMap(),
        'product': ls,
        'time': Timestamp.now(),
        'quantity': data['quantity'],
      };


      await FirebaseFirestore.instance
          .collection('receipt')
          .doc(id)
          .set(Map<String, dynamic>.from(mp));
    }

    setState(() {
      isloading = false;
    });

    return id;
  }

  showpopup(res) async {
    if (res == null) {
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
    showNotification(res);
    Alert(
      context: context,
      type: AlertType.success,
      title: "SUCCESS",
      desc: "RECEIPT ADDED",
      buttons: [
        DialogButton(
          child: Text(
            "Show Receipt",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReciptPreview(res),)),
          width: 180,
        )
      ],
    ).show();

    // Manage_Employee
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Menu(UserModal().initUserModalfromMap(res )),));
  }
}
