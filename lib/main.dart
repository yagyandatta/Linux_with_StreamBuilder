// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: MyLinuxApp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

// String command;
// String ip;
// var data;
// var v;
// var firestore;

// class MyLinuxApp extends StatefulWidget {
//   @override
//   _MyLinuxAppState createState() => _MyLinuxAppState();
// }

// Color hexToColor(String code) {
//   return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
// }

// class _MyLinuxAppState extends State<MyLinuxApp> {
//   var firebase = FirebaseFirestore.instance;

//   check() async {
//     var url = "http://$ip/cgi-bin/all.py?x=$command";
//     var response = await http.get(url);
//     await firebase.collection("linux").add({
//       'ip': ip,
//       'command': command,
//       'output': "${response.body}",
//     });
//     setState(() {
//       data = response.body;
//     });
//     print(data);
//   }

//   get() async {
//     var g = await firebase.collection("linux").get();
//     v = g.docs[0].data();
//     print(v);
//     ;
//     setState(() {
//       firestore = v;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: new Container(
//           padding: const EdgeInsets.all(20.0),
//           color: Colors.white,
//           child: Column(
//             children: [
//               new Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   image: const DecorationImage(
//                     image: AssetImage('assets/logo.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               new Container(
//                 child: new Center(
//                     child: new Column(children: [
//                   new Padding(padding: EdgeInsets.only(top: 5.0)),
//                   new Text(
//                     'Linux App',
//                     style: new TextStyle(
//                         color: hexToColor("#170104"), fontSize: 25.0),
//                   ),
//                   new Padding(padding: EdgeInsets.only(top: 30.0)),
//                   new TextFormField(
//                     decoration: new InputDecoration(
//                       labelText: "Enter Host IP",
//                       fillColor: Colors.white,
//                       border: new OutlineInputBorder(
//                         borderRadius: new BorderRadius.circular(25.0),
//                         borderSide: new BorderSide(),
//                       ),
//                       //fillColor: Colors.green
//                     ),
//                     validator: (val) {
//                       if (val.length == 0) {
//                         return "IP cannot be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.number,
//                     style: new TextStyle(
//                       fontFamily: "Poppins",
//                     ),
//                     onChanged: (value) {
//                       ip = (value);
//                     },
//                   ),

//                   //raised button for check
//                   // RaisedButton(
//                   //     child: Text('Submit'),
//                   //     onPressed: () {
//                   //       get();
//                   //       print("ip submited");
//                   //     }),
//                   Container(
//                     height: 5.0,
//                   ),
//                   new TextFormField(
//                     decoration: new InputDecoration(
//                       labelText: "Enter Linux Command",
//                       fillColor: Colors.white,
//                       border: new OutlineInputBorder(
//                         borderRadius: new BorderRadius.circular(25.0),
//                         borderSide: new BorderSide(),
//                       ),
//                       //fillColor: Colors.green
//                     ),
//                     validator: (val) {
//                       if (val.length == 0) {
//                         return "command cannot be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.text,
//                     style: new TextStyle(
//                       fontFamily: "Poppins",
//                     ),
//                     onChanged: (value) {
//                       command = (value);
//                     },
//                   ),
//                   RaisedButton(
//                       child: Text('Submit'),
//                       onPressed: () {
//                         print("result...");
//                         check();
//                       }),
//                   new Padding(padding: EdgeInsets.only(top: 10.0)),
//                   Container(
//                     // color: Colors.grey,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                     ),
//                     child: Text(
//                       data ?? "wait for the result . . . .",
//                     ),
//                   ),
//                 ])),
//               ),
//             ],
//           )),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyLinuxApp(),
    debugShowCheckedModeBanner: false,
  ));
}

String command;
String ip;
var data;
var v;
var firestore;

class MyLinuxApp extends StatefulWidget {
  @override
  _MyLinuxAppState createState() => _MyLinuxAppState();
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class _MyLinuxAppState extends State<MyLinuxApp> {
  var firebase = FirebaseFirestore.instance;

  check() async {
    var url = "http://$ip/cgi-bin/all.py?x=$command";
    var response = await http.get(url);
    await firebase.collection("linux").add({
      'ip': ip,
      'command': command,
      'output': "${response.body}",
    });
    setState(() {
      data = response.body;
    });
    print(data);
  }

  get() async {
    var g = await firebase.collection("linux").get();
    v = g.docs[0].data();
    print(v);
    setState(() {
      firestore = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
            children: [
              new Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                child: new Center(
                    child: new Column(children: [
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Text(
                    'Linux App',
                    style: new TextStyle(
                        color: hexToColor("#170104"), fontSize: 25.0),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 30.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Host IP",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "IP cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                    onChanged: (value) {
                      ip = (value);
                    },
                  ),

                  //raised button for check
                  // RaisedButton(
                  //     child: Text('Submit'),
                  //     onPressed: () {
                  //       get();
                  //       print("ip submited");
                  //     }),
                  Container(
                    height: 5.0,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Linux Command",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "command cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                    onChanged: (value) {
                      command = (value);
                    },
                  ),
                  RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        print("result...");
                        check();
                      }),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  StreamBuilder(
                    stream: Firestore.instance.collection('linux').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        // color: Colors.grey,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          data ?? "wait for the result . . . .",
                        ),
                      );
                    },
                  ),
                ])),
              ),
            ],
          )),
    );
  }
}
