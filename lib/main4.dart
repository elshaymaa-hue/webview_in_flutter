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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',),
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
                                         print(items[index].url.toString());
                                         _navigateToNextScreen(context);



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

              ),

              );


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

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen(title: 'Flutter Demo Home Page',)));
}

class NewScreen extends StatelessWidget {
  NewScreen ({Key? key, required this.title}) : super(key: key);

  @override
  final String title;
  late String name;
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    name ="flutter";
    _pdfViewerController = PdfViewerController();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Syncfusion Flutter PdfViewer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController.jumpToPage(5);
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        controller: _pdfViewerController,
      ),
    );
  }
}