import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sibhat_tiktok/constants.dart';
import 'package:sibhat_tiktok/views/screens/auth/confirm_screen.dart';

class AddVidoeScreen extends StatelessWidget {
  const AddVidoeScreen({Key? key}) : super(key: key);

  pickVidoe(ImageSource src, BuildContext context)async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video!=null){
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context)=>ConfirmScreen(
                videoFile: File(video.path),
                videoPath:video.path ,
              )));
    }
  }


  showOptionsDialog(BuildContext context){
    return showDialog(context: context, builder: (context)=> SimpleDialog(
       children: [
         SimpleDialogOption(
           onPressed: ()=>pickVidoe(ImageSource.gallery, context),
           child: Row(
             children: const [
               Icon(Icons.image),
               Padding(
                 padding: EdgeInsets.all(7.0),
                 child: Text('Gallery',
                   style: TextStyle(fontSize: 20),),
               )
             ],
           ),
         ),

         SimpleDialogOption(
           onPressed: ()=>pickVidoe(ImageSource.camera, context),
           child: Row(
             children: const [
               Icon(Icons.camera_alt),
               Padding(
                 padding: EdgeInsets.all(7.0),
                 child: Text('Camera',
                   style: TextStyle(fontSize: 20),),
               )
             ],
           ),
         ),
         SimpleDialogOption(
           onPressed: ()=>Navigator.of(context).pop(),
           child: Row(
             children: const [
               Icon(Icons.cancel),
               Padding(
                 padding: EdgeInsets.all(7.0),
                 child: Text('Cancel',
                   style: TextStyle(fontSize: 20),),
               )
             ],
           ),
         )
       ],
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () =>showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 40,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(
              child: Text(
                'Add video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }
}
