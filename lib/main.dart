import 'package:flutter/material.dart';
import 'package:flutter_app/audioPage.dart';
import 'package:flutter_app/onlineaudiopage.dart';
import 'package:flutter_app/videopage.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      routes: {
        '/AudioPage': (context) => AudioPage(),
        '/OnlineAudioPlay': (context) => OnlineAudioPlay(),
        '/VideoClass': (context) => VideoClass()
      },
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.blueAccent,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
        ),

      ),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> arrayTableTitle = ["Audio player","Online Audio play", "Video player"];
  List<String> arrayNavigationItem = ["/AudioPage","/OnlineAudioPlay", "/VideoClass"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        // ignore: missing_return
        child: ListView.builder(
            itemCount: arrayTableTitle.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  height: 50,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text(arrayTableTitle[index])],
                    ),
                  ),
                ),
                onTap: () {
                  navigationFunction(index);
                },
              );
            },
        ),
      ),
    );
  }

  //Function for navigation
  void navigationFunction(int index) {
    Navigator.pushNamed(context, arrayNavigationItem[index]);
  }
}
