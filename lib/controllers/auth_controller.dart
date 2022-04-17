import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:sibhat_tiktok/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sibhat_tiktok/models/user.dart' as model;
import 'package:image_picker/image_picker.dart';
import 'package:sibhat_tiktok/views/screens/auth/home_screen.dart';
import 'package:sibhat_tiktok/views/screens/auth/login_screen.dart';


class AuthController extends GetxController{
 static AuthController instance = Get.find();

  Rx<User?> ?_user;
  Rx<File?> ?_pickedImage;
 File? get profilePhoto =>_pickedImage?.value;

 @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user?.bindStream(firebaseAuth.authStateChanges());
    ever(_user!, _setInitialScreen);
  }

  _setInitialScreen(User? user){
   if(user ==null){
     Get.offAll(()=> LoginScreen());
   }
   else{
     Get.offAll(() => HomeScreen());
   }
  }

 void pickImage()async{
   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   if(pickedImage!=null){
     Get.snackbar('Profile Picture', 'You have succedssfully your profile picture');
   }
   _pickedImage = Rx<File?>(File(pickedImage!.path));
 }
  // upload to firebase storage

  Future<String> _uploadToStorage(File image) async{
  Reference ref =  firebaseStorage
      .ref()
      .child('profilePics')
      .child(firebaseAuth.currentUser!.uid);

   UploadTask uploadTask =ref.putFile(image);
   TaskSnapshot snap = await uploadTask;
   String downloadUrl = await snap.ref.getDownloadURL();
   return downloadUrl;
  }
  // registering the user

  void registerUser(String username,
      String email,
      String password,
      File? image) async{
    try{
      if(username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty
          && image!=null){
        // save our user to our auth and firebase firestore
        UserCredential cred = await  firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
        );

      String downloadUrl = await _uploadToStorage(image);
      model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto:downloadUrl);
     await  firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      }
      else{
        Get.snackbar('Error Creating Account','please enter all the fields');
      }
    }catch(e){
      Get.snackbar('Error Creating Account', e.toString());
    }
  }
  void loginUser(String email, String password) async{
    try{
    if(email.isNotEmpty && password.isNotEmpty){

      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('logging success');
    }else{
      Get.snackbar('Error Logging in','please enter all the fields');
    }
    }catch(e){
      Get.snackbar('Error Logging in', e.toString());
    }
  }
}