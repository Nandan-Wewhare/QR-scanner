import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

var url;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var result = await BarcodeScanner.scan(options: ScanOptions(useCamera: -1));
  url = result.rawContent;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => main(),
          label: Text(
            'Scan Another',
            textScaleFactor: 1.5,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('QR and Barcode Scanner'),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isURL(url) ? url : 'NOT AN URL',
                style: TextStyle(color: Colors.red),
                textScaleFactor: 1.6,
              ),
              SizedBox(
                height: 50,
              ),
              OutlineButton(
                onPressed: isURL(url) ? () => launchURL() : null,
                child: Text(
                  'Go to Link',
                  textScaleFactor: 1.2,
                ),
                splashColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
