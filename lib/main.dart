import 'package:agro_pos/admin/auth/login.dart';
import 'package:agro_pos/receipt/pdfGenerator/notifcation.dart';
import 'package:agro_pos/receipt/pdfGenerator/pdfGen.dart';
import 'package:agro_pos/user/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          return Splash();
          return MyHomePage(title: 'Agro POS');
        },
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Agro POS'),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AGRO POS',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100,
            ),
            SpinKitRipple(
              color: Colors.lightGreen,
              size: MediaQuery.of(context).size.width - 50,
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/background.jpeg',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to AGRO POS 👋🏼 ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Are you a User or Admin ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  height: 350,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      color: Colors.green,
                      padding: EdgeInsets.all(20),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Admin_Login(),
                            ));
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'ADMIN',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.green,
                      onPressed: () {
                        // _showNotificationWithNoBody();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => User_Login(),
                            ));
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'USER',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // Future<void> _showNotificationWithNoBody() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //       'your channel id', 'your channel name', 'your channel description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'plain title', null, platformChannelSpecifics,
  //       payload: 'item x');
  // }
}
