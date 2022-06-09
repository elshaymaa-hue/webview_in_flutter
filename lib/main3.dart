import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'OfferDataModel1.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:async';



void main() {
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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<OfferDataModel1>;
          return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            child: Image(
                              image:
                              NetworkImage(items[index].photo.toString()),
                              fit: BoxFit.fill,
                            )

                        ),
                        Expanded(
                          child: Container(
                            child: RaisedButton(
                              child: Text(
                                items[index].test.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                print(items[index].url.toString());
                              },
                            ),
                          ),
                            ),
                      ],
                          )

                        )

                );


              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<List<OfferDataModel1>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/offers1.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => OfferDataModel1.fromJson(e)).toList();
  }
}
