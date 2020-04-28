import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class OnlineAudioPlay extends StatefulWidget {
  @override
  _OnlineAudioPlayState createState() => _OnlineAudioPlayState();
}

class _OnlineAudioPlayState extends State<OnlineAudioPlay> {
  List<String> arrayAudioURL = [
    "https://luan.xyz/files/audio/ambient_c_motion.mp3",
    "https://luan.xyz/files/audio/nasa_on_a_mission.mp3",
    "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p"
  ];
  double _sliderValue = 0.0;
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFile(arrayAudioURL[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Audio player"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text(localFilePath != null ? localFilePath : "Song title"),
            slider(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Image.asset("images/next.png"), onPressed: () {}),
                SizedBox(
                  width: 40,
                ),
                IconButton(
                    icon: Image.asset("images/play.png"), onPressed: () {
                  _loadFile(arrayAudioURL[0]);
                }),
                SizedBox(
                  width: 40,
                ),
                IconButton(
                    icon: Image.asset("images/previous.png"), onPressed: () {})
                ,
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Slider(
      value: _sliderValue,
      min: 0.0,
      max: 10.0,
      onChanged: (newSliderValue) {
        setState(() {
          _sliderValue = newSliderValue;
        });
      },
    );
  }

  Future _loadFile(String url) async {
    print("url is $url");
    final bytes = await readBytes(url);
    print("Total byte $bytes");
    final dir = await getApplicationDocumentsDirectory();
    print("dir is $dir");
    final file = File('${dir.path}/audio.mp3');
    print("file is $file");
    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    }
  }
}
