import 'package:flutter/material.dart';
import 'package:sibhat_tiktok/controllers/upload_vidoe_controller.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

import '../../widgets/text_input_field.dart';
import 'package:get/get.dart';
class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {

  late VideoPlayerController controller;
TextEditingController _songController = TextEditingController();
TextEditingController _captionController = TextEditingController();

UploadVideoController uploadVideoController =Get.put(UploadVideoController());


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller =VideoPlayerController.file(widget.videoFile);
  });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              SizedBox(width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height/1.5,
                child:VideoPlayer(controller) ,
              ),
               SizedBox(
                height: 30,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width-20,
                        child: TextInputField(
                            controller: _songController,
                            labelText:'Song Name',
                            icon:Icons.music_note),
                      ),

                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width-20,
                        child: TextInputField(
                            controller: _captionController,
                            labelText:'Caption',
                            icon:Icons.closed_caption),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: ()=>uploadVideoController.uploadVideo(_songController.text, _captionController.text, widget.videoPath),
                          child: const Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,

                            ),
                          )
                      )
                    ],

                  ),

                ),
              )
            ],
          ),
        ),
    );
  }
}
