// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/chat_screen/chat_screen.dart';

class AddBlockDetailsScreen extends StatefulWidget {
  final String collectionId;
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;

  const AddBlockDetailsScreen(
      {super.key, required this.collectionId, required this.data});

  @override
  State<AddBlockDetailsScreen> createState() => _AddBlockDetailsScreenState();
}

class _AddBlockDetailsScreenState extends State<AddBlockDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(right: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        leadingWidth: 35,
        title: Text(
          'back',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.data!['uid'] ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return null;
              }
              String post_id = widget.data!['postId'];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                      post_id: post_id, collectionId: widget.collectionId),
                ),
              );
            },
            icon: Icon(
              Icons.send_outlined,
              color:
                  widget.data!['uid'] == FirebaseAuth.instance.currentUser!.uid
                      ? const Color.fromARGB(255, 87, 87, 87)
                      : Colors.white,
            ),
          ),

          //talk to me button---------------------------------------------------
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 400,
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: widget.data!['postUrl'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: 350,
                    margin: EdgeInsets.all(10),
                    color: Colors.green,
                    child: Image.network(
                      widget.data!['postUrl'][index],
                    ), //import frome firebace-------------------------------------
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 40,
                color: Colors.amber,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(widget.data!['username']),
                ), //import frome firebace-------------------------------------
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    // width: 370,
                    height: 200,
                    margin: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            widget.data!['description'],
                          ),
                          // Text(widget.data!['email']),
                          // Text(widget.data!['adds_text']),
                          // Text(widget.data!['username']),
                        ],
                      ), //import frome firebace-------------------------------------
                    )),
                Container(
                    // width: 370,
                    height: 50,
                    margin: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Center(
                        child: Text(
                      widget.data!['data2'],
                    ) //import frome firebace-------------------------------------
                        )),
                Container(
                    // width: 370,
                    height: 50,
                    margin: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Center(
                        child: Text(
                      widget.data!['data3'],
                    ) //import frome firebace-------------------------------------
                        )),
                Container(
                    // width: 370,
                    height: 50,
                    margin: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        widget.data!['data4'],
                      ), //import frome firebace-------------------------------------
                    )),
                Container(
                    // width: 370,
                    height: 50,
                    margin: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        widget.data!['data5'],
                      ), //import frome firebace-------------------------------------
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
