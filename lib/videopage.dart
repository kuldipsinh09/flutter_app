import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

 class VideoClass extends StatefulWidget {
   @override
   _VideoClassState createState() => _VideoClassState();
 }
 
 class _VideoClassState extends State<VideoClass> {
   Future<void> _initializeVideoPlayerFuture;


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Video player"),
         centerTitle: true,
       ),
       body: Container(

       ),
     );
   }
 }
