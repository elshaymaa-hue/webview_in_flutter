import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'OfferDataModel1.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


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
                            height: 150,
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
                                style: TextStyle(fontSize: 40),
                              ),
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              onPressed: () {
                               // print(items[index].url.toString());
                               // launchUrl(Uri.parse(items[index].url.toString()));
                                _navigateToNextScreen(context);
                                    // SfPdfViewer.network(
                                    // items[index].url.toString(),
                                    // controller: _pdfViewerController,
                                    // key: _pdfViewerStateKey);

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
  // ignore: non_constant_identifier_names

  Future<List<OfferDataModel1>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/offers2.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => OfferDataModel1.fromJson(e)).toList();
  }

}
void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
}

class NewScreen extends StatelessWidget {
  @override
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
 //   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfPdfViewer.network(
              'https://cmms-site.com/quran/fathah.pdf',
              controller: _pdfViewerController,
              key: _pdfViewerStateKey),
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    _pdfViewerStateKey.currentState!.openBookmarkView();
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    _pdfViewerController.jumpToPage(5);
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    _pdfViewerController.zoomLevel = 1.25;
                  },
                  icon: Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                  ))
            ],
          ),
        ));
  }
}