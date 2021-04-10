

  import 'package:agro_pos/products/register.dart';
import 'package:agro_pos/user/auth/register.dart';
  import 'package:agro_pos/user/modal/UserTileModal.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
  import 'package:modal_progress_hud/modal_progress_hud.dart';

  class Manage_employee extends StatefulWidget {
    @override
    _Manage_employeeState createState() => _Manage_employeeState();
  }

  class _Manage_employeeState extends State<Manage_employee> {
      final _formKey = GlobalKey<FormBuilderState>();
      var searchCtrl = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,

          title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Text('Mangage Employee'),

            ],
          ),

        ),

          body: FutureBuilder(

            future: FirebaseFirestore.instance.collection('user').orderBy("Name",descending: false).get(),
            builder: (context, snapshot) => snapshot.hasData?EmployeeList(snapshot.data):ModalProgressHUD(inAsyncCall: true, child: Container()),

          ));
    }
    EmployeeList(data){
      List <DocumentSnapshot >all  =data.docs;
      List <DocumentSnapshot >ds = [];
      if(searchCtrl.text.compareTo('')==0) {
        ds  =data.docs;
      }
      else{
        ds =[];
        all.forEach((element) {
          String name = element.data()['Name'];
          if(name==null || name.toUpperCase().startsWith(searchCtrl.text.toUpperCase()))
            ds.add(element);

        });
      }


  print( ds.length);

  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),

                  child: TextField(

                    onChanged: (d){
                      setState(() {
                        ds = [];
                      });
                    },
                    controller: searchCtrl,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                  ),
                ),
              ),


            ),
          ),


          RawMaterialButton(

            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => User_Register(),)).then((value) => {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Manage_employee(),))

              });

            },
            constraints: BoxConstraints(),
            elevation: 2.0,
            fillColor: Colors.green,
            child: Icon(Icons.add,color: Colors.white,),
            padding: EdgeInsets.all(6.0),
            shape: CircleBorder(),
          )

        ],
      ),

      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:   ListView.builder(itemCount: ds.length,itemBuilder: (context, index) => UserModal() .getTile(ds[index],context),),
        ),
      ),
    ],
  );
    }
  }
