


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerModal{
  String Email;
  String Name;

  initCustomerModalfromMap(Map data){

    this.Email =data['Email'];
    this.Name =data['Name']??'';

    return this;
  }

  initCustomerModal(QueryDocumentSnapshot data){

  this.Email =data.data()['Email'];
  this.Name =data.data()['Name']??'';

  return this;
}

   getTile(data,context){
    if(this.Email==null)
    initCustomerModal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
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


        ],

      ),
      Expanded(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,

          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Text(Name,style: TextStyle(fontSize: 16),),
            Text(Email,style: TextStyle(fontSize: 16),),

          ],

        ),
      ),
    Column(
      children: [

        SizedBox(
           height: 40,
          child: IconButton(
            color: Colors.blue,
            onPressed: (){},
            icon: Icon(Icons.edit),


          ),
        ),
        SizedBox(
          height: 40,
          child: IconButton(
            color: Colors.red,
            onPressed: (){},
            icon: Icon(Icons.delete),


          ),
        ),
      ],
    )


  ]
          ,
),
      ),
    );
  }
  getTileWithouButton(data,context){
    if(this.Email==null)
      initCustomerModal(data);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        color: Colors.black.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
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


              ],

            ),
            Expanded(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center ,

                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text(Name,style: TextStyle(fontSize: 16),),
                  Text(Email,style: TextStyle(fontSize: 16),),

                ],

              ),
            ),

          ]
          ,
        ),
      ),
    );
  }



  toMap(){
    return {'Email':Email,'Name':Name};

  }

}