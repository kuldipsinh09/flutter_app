import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_audio_stream/url_audio_stream.dart';

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

  String localFilePath;
  AudioStream stream;
  bool _isResume = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _loadFile(arrayAudioURL[0]);
    stream = new AudioStream(arrayAudioURL[0]);

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
                    icon: Image.asset(_isResume ? "images/pause.png" : "images/play.png"), onPressed: () {
                  setState(() {
                    _isResume = !_isResume;
                  });
                  if (_isResume) {playMusic();} else {resumeMusic();}
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


  void playMusic() async {
    stream.start();
  }
  void resumeMusic()  {
    stream.pause();
    // quickly plays the sound, will not release
  }
}
