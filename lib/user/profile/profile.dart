

import 'package:agro_pos/user/modal/UserTileModal.dart';
import 'package:flutter/material.dart';

class User_Profile extends StatelessWidget {
  UserModal userModal;
  User_Profile(this.userModal);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('User Profile'),
      ),
      body: Padding(
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
                    Text('Name:    ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text('Email:    ' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text('Phone:    ' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),


                  ],

                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center ,

                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Text(userModal.Name,style: TextStyle(fontSize: 22),),
                      Text(userModal.Email,style: TextStyle(fontSize: 22),),
                      Text(userModal.Phone,style: TextStyle(fontSize: 22),),

                    ],

                  ),
                ),


              ]
              ,
            ),
          ),
        ),
      ),
    ));
  }
}
