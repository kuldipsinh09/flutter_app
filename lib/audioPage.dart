import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String _absolutePathOfAudio = "Not item selected yet";
  AudioPlayer audioPlayer;
  double _value = 1.0;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = true;
    //function call
    //getCurrentPlayerState();
    getCurrentTimeOfPlayer();
    getDurationOfPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Audio page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                    _absolutePathOfAudio != null
                        ? _absolutePathOfAudio
                        : "file not selected please select audio fine",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 30),
                FlatButton(
                  onPressed: () {
                    openAudioPicker();
                  },
                  child: Text(
                    "Select audio from file",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 30,
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                      Text(_position.toString().split(".")[0], style: TextStyle(fontWeight: FontWeight.w700),),

                      slider(),

                      Text(_duration.toString().split(".")[0], style: TextStyle(fontWeight: FontWeight.w300),),

                    ],
                  ),
                SizedBox(height:30),
                FlatButton(
                  onPressed: () {
                    playMusic();
                  },
                  child: Text(
                    "Play audio",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    resumeMusic();
                  },
                  child: Text(
                    "Puse audio",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    stopMusic();
                  },
                  child: Text(
                    "Stop audio",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Volume"),
                Slider(
                  value: _value,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.red,
                  inactiveColor: Colors.black,
                  label: 'Set a value',
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue;
                      setVolume(newValue);
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Choose audio file from gallery
  void openAudioPicker() async {
    String _path;
    try {
      _path = await FilePicker.getFilePath(
          type: FileType.audio, allowedExtensions: null);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _absolutePathOfAudio = _path;
    });
    print("file path you choosen ${_absolutePathOfAudio ?? ""}");
    getDurationOfPlayer();
  }

  void playMusic() async {
    await audioPlayer.play(_absolutePathOfAudio, isLocal: true);
  }

  //Get duration of selected item
  void getDurationOfPlayer() {
    print("vieo duration is ${audioPlayer.getDuration().toString()}");
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
  }

  void getCurrentTimeOfPlayer()  {
    audioPlayer.onAudioPositionChanged.listen((Duration duration){
      setState(() {
        _position = duration;
      });
    });
  }

  void getCurrentPlayerState() {
    audioPlayer.onNotificationPlayerStateChanged.listen((AudioPlayerState state) {
      print("current audio state is");
    });
  }

  void stopMusic() async {
    await audioPlayer.stop();
  }

  void resumeMusic()  {
     audioPlayer.pause(); // quickly plays the sound, will not release
  }

  void setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  Widget slider() {
    return Slider(
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
    );
  }
}
