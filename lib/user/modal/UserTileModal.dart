


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModal{
  String Email;
  String Name;

initUserModal(QueryDocumentSnapshot data){

  this.Email =data.data()['Email'];
  this.Name =data.data()['Name']??'';

}
   getTile(data,context){
    initUserModal(data);
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - 40,
child: Column(
  children: [
        Row(
      children: [
        Text('Email:    ' ,style: TextStyle(fontSize: 18),),
        Text(Email,style: TextStyle(fontSize: 18),),

      ],

    ),
    Row(
      children: [
        Text('Name:    ',style: TextStyle(fontSize: 18),),
        Text(Name,style: TextStyle(fontSize: 18),),

      ],

    )
  ],
),
    );
  }

}