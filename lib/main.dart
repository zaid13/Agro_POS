import 'package:agro_pos/admin/auth/login.dart';
import 'package:agro_pos/receipt/pdfGenerator/pdfGen.dart';
import 'package:agro_pos/user/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),

      builder: (context, snapshot){
        return Splash();
            return  MyHomePage(title: 'Agro POS');


      },

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Agro POS'),));
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(

          children: [
            Text('AGRO POS',style: TextStyle(fontSize:25,color: Colors.lightGreen,fontWeight: FontWeight.bold),),
          ],
        ),

      ),

    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hey there 👋🏼 \n Are you a User or Admin ',style: TextStyle(fontSize: 25),),
Container(height: 100,),
            Column(
              children: [
                FlatButton(
                  // padding: EdgeInsets.all(20),
                  color: Colors.black.withOpacity(0.1),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Login(),));
                  },
                  child: Container(
                    width: 100,
                    height:40,
                    alignment: Alignment.center,
                    child: Text(
                      'ADMIN',

                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            FlatButton(
// padding: EdgeInsets.all(20),
              color: Colors.black.withOpacity(0.1),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => User_Login(),));


              },
              child: Container(
               width: 100,
                height:40,
                alignment: Alignment.center,
                child: Text(
                  'USER',
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),

                ),
              ),
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
