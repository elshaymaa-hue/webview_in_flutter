import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'OfferDataModel1.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:async';
import '../../src/shared/views/views.dart';
import 'package:url_launcher/url_launcher.dart';



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
                return  Row(
                  children:[
                  Expanded(
                      child: Padding(
                         padding: const EdgeInsets.all(2),
                           child: Clickable(
                              child:SizedBox(
                                height: 275,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image:
                                    NetworkImage(items[index].photo.toString()),
                                    fit: BoxFit.fill,
                                  )

                                ),
                              ),
                                onTap: () => launchUrl(Uri.parse(items[index].url.toString())),
                            )
                          )

                        )
                  ],
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
