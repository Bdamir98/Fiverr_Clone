// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../screens/Create_add.dart';
import '../screens/ProfileScreen.dart';
import '../screens/feed_screen.dart';
import '../screens/chat_screen/message_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const CreatAdd(),
  MessageScreen(),
  //const SearchScreen(),
  ProfileScreen(),
  //ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
