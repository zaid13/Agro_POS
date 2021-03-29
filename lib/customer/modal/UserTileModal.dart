


import 'package:agro_pos/admin/manage/manageCustomer.dart';
import 'package:agro_pos/admin/manage/manageEmployee.dart';
import 'package:agro_pos/customer/auth/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerModal{
  String Email;
  String Name;
  String Phone;

  initCustomerModalfromMap(Map data){

    this.Email =data['Email'];
    this.Name =data['Name']??'';
    this.Phone =data['Phone']??'';


    return this;
  }

  initCustomerModal(QueryDocumentSnapshot data){

  this.Email =data.data()['Email'];
  this.Name =data.data()['Name']??'';
  this.Phone =data.data()['Phone']??'';

  return this;
}

   getTile(data,context){
    if(this.Email==null)
    initCustomerModal(data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            crossAxisAlignment:CrossAxisAlignment.center ,
            children: [

              Container(width: 10,),
              Container(
                width: 70,
                height: 70,
                child: Image.asset('assets/customer.jpeg',      width: 70,
                  height: 70,fit: BoxFit.fill ,),),
              Container(width: 10,),
              //
              // Column(
              //           mainAxisAlignment:MainAxisAlignment.center ,
              //
              //           crossAxisAlignment:CrossAxisAlignment.start ,
              //       children: [
              //         Text('    ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              //         Text('Email:    ' ,style: TextStyle(fontSize: 16),),
              //         Text('Phone:    ' ,),
              //
              //
              //       ],
              //
              //   ),
              Expanded(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center ,

                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(Name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(Email,style: TextStyle(fontSize: 16),),
                    Text(Phone,),

                  ],

                ),
              ),
              Column(
                children: [

                  SizedBox(
                    height: 40,
                    child: IconButton(
                      color: Colors.blue,
                      onPressed: (){

                        Navigator.push(context,MaterialPageRoute(builder: (context) => Customer_Update(this),)).then((value)=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Manage_customer(),)));



                      },
                      icon: Icon(Icons.edit),


                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: IconButton(
                      color: Colors.red,
                      onPressed: () async {
                        QuerySnapshot qs =  await FirebaseFirestore.instance.collection('customer').where("Email",isEqualTo: Email).get();
                        FirebaseFirestore.instance.collection('customer').doc(qs.docs.first.id).delete();
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Manage_customer(),));
                          },
                      icon: Icon(Icons.delete),


                    ),
                  ),
                ],
              )


            ]
            ,
          ),
        ),
      ),
    );
  }
  getTileWithouButton(data,context){
    if(this.Email==null)
      initCustomerModal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            crossAxisAlignment:CrossAxisAlignment.center ,
            children: [
              Column(
                mainAxisAlignment:MainAxisAlignment.center ,

                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text('Name:    ',style: TextStyle(fontSize: 16),),
                  Text('Email:    ' ,style: TextStyle(fontSize: 16),),
                  Text('Phone:    ' ,style: TextStyle(fontSize: 16),),


                ],

              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center ,

                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(Name,style: TextStyle(fontSize: 16),),
                    Text(Email,style: TextStyle(fontSize: 16),),
                    Text(Phone,style: TextStyle(fontSize: 16),),

                  ],

                ),
              ),

            ]
            ,
          ),
        ),
      ),
    );
  }



  toMap(){
    return {'Email':Email,'Name':Name,'Phone':Phone};

  }

}