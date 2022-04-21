import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sibhat_tiktok/controllers/auth_controller.dart';
import 'package:sibhat_tiktok/views/screens/auth/add_video_screen.dart';
import 'package:sibhat_tiktok/views/screens/auth/vidoe_screen.dart';

List pages =[
   VideoScreen(),
  Text('Search Screen'),
 const AddVidoeScreen(),
  Text('Message Screen'),
  Text('Profile Screen'),
];



//Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;


//firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore  = FirebaseFirestore.instance;

// controllers

var authController = AuthController.instance;